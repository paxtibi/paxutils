unit paxutils;

{$mode objfpc}{$H+}
{$M+}

interface

uses
  Classes, SysUtils, contnrs, ctypes, LMessages, paxtypes;

type
  TCompareResult = -1..1;

const
  CompareEquals      = 0;
  CompareLessThan    = Low(TCompareResult);
  CompareGreaterThan = High(TCompareResult);


type
  ERuntimeException = class(Exception)
  end;

  ENullPointerException = class(ERuntimeException)
  end;

  EViolatedMandatoryConstraintException = class(ERuntimeException)

  end;

type
  FILE_PTR = Pointer;
  { TMangagedLibrary }

  TMangagedLibrary = class
  protected
    FHandle:      THandle;
    FLocations:   TStringList;
    FLibraryName: string;
    FBindedToLocation: string;
  protected
    procedure bindEntries; virtual;
    function getProcAddress(entryName: RawByteString; mandatory: boolean = False): Pointer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure TryLoad;
    procedure UnLoad;
    procedure AddLocation(aPath: string);
    procedure removeLocation(aPath: string);
    function loaded: boolean;
  end;


  ESemaphoreException = class(Exception)
  end;

type
{
Credits
Forum user : Pascal

Adapted from

  https://forum.lazarus.freepascal.org/index.php?topic=48032.0
}
  { TSemaphore }

  TSemaphore = class
  private
    fMaxPermits: cardinal;
    fPermits: cardinal;
    fLock: TRTLCriticalSection;
    FBlockQueue: TQueue;
    function GetWaitCount: cardinal;
  public
    function isInUsed: boolean;
    procedure acquire;
    procedure release;
    constructor Create(MaxPermits: cardinal); virtual;
    destructor Destroy; override;
  published
    property Permits: cardinal read fPermits;
    property MaxPermits: cardinal read fMaxPermits;
  end;


  { TMutex }

  TMutex = class(TSemaphore)
  public
    constructor Create(); reintroduce;
  end;



const
  WM_EXECUTOR_NOTIFY_STOP      = WM_USER;
  WM_EXECUTOR_NOTIFY_RUNNING   = WM_USER + 1;
  WM_EXECUTOR_NOTIFY_FINISCHED = WM_USER + 2;

type

  TTaskExecutorState = (
    esStop = WM_EXECUTOR_NOTIFY_STOP,
    esRun = WM_EXECUTOR_NOTIFY_RUNNING,
    esFinish = WM_EXECUTOR_NOTIFY_FINISCHED
    );

  { TTask }

  TTask = class
  private
    FOnNotify: TNotifyEvent;
    FRunnable: IRunnable;
    procedure SetOnNotify(AValue: TNotifyEvent);
    procedure SetRunnable(AValue: IRunnable);
  protected
    type
    { TTaskExecutor }

    TTaskExecutor = class(TThread)
    private
      FContainer: TTask;
    protected
      constructor Create(aContainer: TTask); reintroduce;
      procedure Execute; override;
    public
      procedure notifyState(newState: TTaskExecutorState);
      procedure Run; virtual;
    end;

  protected
    FTaskExecutor:      TTaskExecutor;
    FTaskExecutorState: TTaskExecutorState;
  protected
    procedure receiveNotifyStop(var Message: TLMessage); stdcall; message WM_EXECUTOR_NOTIFY_STOP;
    procedure receiveNotifyRunning(var Message: TLMessage); stdcall; message WM_EXECUTOR_NOTIFY_RUNNING;
    procedure receiveNotifyFinished(var Message: TLMessage); stdcall; message WM_EXECUTOR_NOTIFY_FINISCHED;
    class function executorFactory(targetContainer: TTask): TTaskExecutor; virtual;
  public
    constructor Create;

    property Runnable: IRunnable read FRunnable write SetRunnable;

    property OnNotify: TNotifyEvent read FOnNotify write SetOnNotify;
    property State: TTaskExecutorState read FTaskExecutorState;
  end;


implementation

uses
  dynlibs;

{ TMutex }

constructor TMutex.Create();
begin
  inherited Create(1);
end;

{ TSemaphore }

function TSemaphore.GetWaitCount: cardinal;
begin
  EnterCriticalSection(fLock);
  try
    Result := FBlockQueue.Count;
  finally
    LeaveCriticalSection(fLock);
  end;
end;

function TSemaphore.isInUsed: boolean;
begin
  result := fPermits < fMaxPermits;
end;

procedure TSemaphore.acquire;
var
  aWait: boolean;
  aEvent: PRTLEvent;
begin
  EnterCriticalSection(fLock);
  try
    if (fPermits > 0) then
    begin
      Dec(fPermits);
      aWait := False;
    end
    else
    begin
      aEvent := RTLEventCreate;
      FBlockQueue.Push(aEvent);
      aWait := True;
    end;
  finally
    LeaveCriticalSection(fLock);
  end;
  if aWait then
  begin
    RTLeventWaitFor(aEvent);
    RTLEventDestroy(aEvent);
  end;
end;

procedure TSemaphore.release;
begin
  EnterCriticalSection(fLock);
  try
    if FBlockQueue.Count > 0 then
      RTLEventSetEvent(PRTLEvent(FBlockQueue.Pop))
    else
      Inc(fPermits);
  finally
    LeaveCriticalSection(fLock);
  end;
end;

constructor TSemaphore.Create(MaxPermits: cardinal);
begin
  fMaxPermits := MaxPermits;
  fPermits    := MaxPermits;
  InitCriticalSection(fLock);
  FBlockQueue := TQueue.Create;
end;

destructor TSemaphore.Destroy;
begin
  DoneCriticalSection(fLock);
  FBlockQueue.Free;
  inherited Destroy;
end;

{ TTask }

procedure TTask.receiveNotifyStop(var Message: TLMessage); stdcall;
begin
  FTaskExecutorState := esStop;
end;

procedure TTask.receiveNotifyRunning(var Message: TLMessage); stdcall;
begin
  FTaskExecutorState := esRun;
end;

procedure TTask.receiveNotifyFinished(var Message: TLMessage); stdcall;
begin
  FTaskExecutorState := esFinish;
end;

procedure TTask.SetRunnable(AValue: IRunnable);
begin
  if FRunnable = AValue then
    Exit;
  FRunnable := AValue;
end;

procedure TTask.SetOnNotify(AValue: TNotifyEvent);
begin
  if FOnNotify = AValue then
    Exit;
  FOnNotify := AValue;
end;

class function TTask.executorFactory(targetContainer: TTask): TTaskExecutor;
begin
  result := TTaskExecutor.Create(targetContainer);
end;

constructor TTask.Create;
begin
  FTaskExecutor      := executorFactory(self);
  FTaskExecutorState := esStop;
end;

{ TTask.TTaskExecutor }

constructor TTask.TTaskExecutor.Create(aContainer: TTask);
begin
  inherited Create(True, DefaultStackSize);
  FContainer := aContainer;
  notifyState(esStop);
end;

procedure TTask.TTaskExecutor.Execute;
begin
  notifyState(esRun);
  Run();
  notifyState(esFinish);
end;

procedure TTask.TTaskExecutor.notifyState(newState: TTaskExecutorState);
var
  message: TLMessage;
begin
  message.msg := Ord(newState);
  if Assigned(FContainer) then
  begin
    FContainer.Dispatch(message);
  end;
end;

procedure TTask.TTaskExecutor.Run;
begin
  FContainer.Runnable.run;
end;



{ TMangagedLibrary }

procedure TMangagedLibrary.bindEntries;
begin

end;

constructor TMangagedLibrary.Create;
begin
  FHandle    := NilHandle;
  FLocations := TStringList.Create;
end;

destructor TMangagedLibrary.Destroy;
begin
  FreeAndNil(FLocations);
  UnLoad;
  inherited Destroy;
end;

procedure TMangagedLibrary.TryLoad;
var
  CurrentPath: string;
begin
  if loaded then
    UnLoad;
  if FLocations.Count > 0 then
    for CurrentPath in FLocations do
    begin
      FHandle := LoadLibrary(CurrentPath + DirectorySeparator + FLibraryName + '.' + SharedSuffix);
      if FHandle <> NilHandle then
      begin
        FBindedToLocation := CurrentPath;
        exit;
      end;
    end
  else
  begin
    // Demand to OS to find library
    FHandle           := LoadLibrary(FLibraryName + '.' + SharedSuffix);
    FBindedToLocation := 'OS Path';
  end;
  if FHandle <> NilHandle then
  begin
    bindEntries;
  end;
end;

procedure TMangagedLibrary.UnLoad;
begin
  if FHandle <> NilHandle then
    UnloadLibrary(FHandle);
end;

procedure TMangagedLibrary.AddLocation(aPath: string);
begin
  FLocations.Add(aPath);
end;

procedure TMangagedLibrary.removeLocation(aPath: string);
var
  idx: integer;
begin
  idx := FLocations.IndexOf(aPath);
  if idx > 0 then
    FLocations.Delete(idx);
end;

function TMangagedLibrary.loaded: boolean;
begin
  Result := FHandle <> NilHandle;
end;

function TMangagedLibrary.getProcAddress(entryName: RawByteString; mandatory: boolean): Pointer;
begin
  Result := dynlibs.GetProcAddress(FHandle, entryName);
  if (Result = nil) and mandatory then
  begin
    raise EViolatedMandatoryConstraintException.CreateFmt('%s not found in %s', [entryName, FLibraryName]);
  end;
end;

initialization

end.
