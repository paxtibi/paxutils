unit paxutils;

{$mode objfpc}{$H+}
{$M+}

interface

uses
  Classes, SysUtils, contnrs, ctypes, LMessages, paxtypes, fgl;

type
  TCompareResult = -1..1;

const
  CompareEquals = 0;
  CompareLessThan = Low(TCompareResult);
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

  TMangagedLibrary = class(TInterfacedObject)
  protected
    FHandle: THandle;
    FLocations: TStringList;
    FLibraryName: string;
    FBindedToLocation: string;
  protected
    procedure bindEntries; virtual;
    function getProcAddress(entryName: rawbytestring; mandatory: boolean = True): Pointer;
  protected
    procedure ensureLoaded;
    procedure mandatoryCheck(reference: Pointer; entryPointName: string);
    procedure TryLoad;
    procedure UnLoad;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddLocation(aPath: string);
    procedure removeLocation(aPath: string);
    function loaded: boolean;
    procedure load;
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
    procedure Release;
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

  IRunnable = interface
    ['{ED9B730D-2646-4184-BD67-013AC38B81C9}']
    procedure run;
  end;

  TTaskQueue = class;

  { TTask }

  TTask = class(TThread)
  private
    FActiveQueue: TTaskQueue;
    FRunner: IRunnable;
    procedure SetActiveQueue(AValue: TTaskQueue);
    procedure SetRunner(AValue: IRunnable);
  protected
  public
    constructor Create();
    destructor Destroy; override;
    procedure Execute; override;
    property ActiveQueue: TTaskQueue read FActiveQueue write SetActiveQueue;
    property runner: IRunnable read FRunner write SetRunner;
  end;

  { TTask }
  TTasks = specialize TFPGList<TTask>;

  { TTaskQueue }

  TTaskQueue = class(TTasks)
  private
    FSemaphore: TSemaphore;
    procedure SetSemaphore(AValue: TSemaphore);
  public
    procedure add(aTask: TTask);
    property Semaphore: TSemaphore read FSemaphore write SetSemaphore;
    procedure Start;
    procedure Stop;
    procedure Terminate;
    function workingCount: uint32;
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
  Result := fPermits < fMaxPermits;
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

procedure TSemaphore.Release;
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
  fPermits := MaxPermits;
  InitCriticalSection(fLock);
  FBlockQueue := TQueue.Create;
end;

destructor TSemaphore.Destroy;
begin
  DoneCriticalSection(fLock);
  FBlockQueue.Free;
  inherited Destroy;
end;


{ TMangagedLibrary }

procedure TMangagedLibrary.bindEntries;
begin

end;

constructor TMangagedLibrary.Create;
begin
  FHandle := NilHandle;
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
        break;
      end;
    end
  else
  begin
    // Demand to OS to find library
    FHandle := LoadLibrary(FLibraryName + '.' + SharedSuffix);
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

procedure TMangagedLibrary.load;
begin
  if not loaded then
    TryLoad;
end;

function TMangagedLibrary.getProcAddress(entryName: rawbytestring; mandatory: boolean): Pointer;
begin
  Result := dynlibs.GetProcAddress(FHandle, entryName);
  if (Result = nil) and mandatory then
  begin
    raise EViolatedMandatoryConstraintException.CreateFmt('%s not found in %s', [entryName, FLibraryName]);
  end;
end;

procedure TMangagedLibrary.ensureLoaded;
begin
  if not loaded then
    TryLoad;
end;

procedure TMangagedLibrary.mandatoryCheck(reference: Pointer; entryPointName: string);
begin
  if reference = nil then
    raise ENullPointerException.CreateFmt('Entry point %s not binded', [entryPointName]);
end;


{ TTask }

procedure TTask.SetActiveQueue(AValue: TTaskQueue);
begin
  if FActiveQueue = AValue then
    Exit;
  FActiveQueue := AValue;
end;

procedure TTask.SetRunner(AValue: IRunnable);
begin
  if Frunner = AValue then Exit;
  Frunner := AValue;
end;

constructor TTask.Create;
begin
  inherited Create(True, DefaultStackSize);
  FreeOnTerminate := True;
  FActiveQueue := nil;
end;

destructor TTask.Destroy;
begin
  FActiveQueue := nil;
  FRunner := nil;
  inherited Destroy;
end;

procedure TTask.Execute;
var
  idx: integer;
begin
  ActiveQueue.Semaphore.acquire;
  if FRunner <> nil then
  begin
    FRunner.run;
  end;
  if FActiveQueue <> nil then
  begin
    idx := FActiveQueue.IndexOf(self);
    if idx >= 0 then
      FActiveQueue.Remove(self);
  end;
  ActiveQueue.Semaphore.Release;
end;

procedure TTaskQueue.SetSemaphore(AValue: TSemaphore);
begin
  if FSemaphore = AValue then
    Exit;
  FSemaphore := AValue;
end;

procedure TTaskQueue.add(aTask: TTask);
begin
  inherited Add(aTask);
  ATask.ActiveQueue := self;
end;

procedure TTaskQueue.Start;
var
  task: TTask;
begin
  for task in self do
  begin
    task.Start;
  end;
end;

procedure TTaskQueue.Stop;
var
  task: TTask;
begin
  for task in self do
  begin
    task.Suspend;
  end;
end;

procedure TTaskQueue.Terminate;
var
  task: TTask;
begin
  for task in self do
  begin
    task.Terminate;
  end;
end;

function TTaskQueue.workingCount: uint32;
var
  task: TTask;
begin
  Result := 0;
  for task in self do
  begin
    if not task.Finished then
      InterLockedIncrement(Result);
  end;
end;


initialization

end.
