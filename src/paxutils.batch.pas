unit paxutils.batch;

{$mode delphi}{$H+}
{$D+}

interface

uses
  fgl, Classes, SysUtils, paxutils;

type
  { IItemReaderListener }

  IItemReaderListener = interface
    ['{7F17693E-85E3-4838-A55B-F4B327D6E59F}']
    procedure readCount;
    function Count: uint64;
    function totalCount: uint64;
  end;

  { IItemWriterListener }

  IItemWriterListener = interface
    ['{46CC8B66-9258-4B56-88EA-E808C031BCDD}']
    procedure requestCount(Count: integer = 1);
    procedure writeCount(Count: integer = 1);
    function Count: uint64;
    function totalCount: uint64;
    function getRequestCount: uint64;
  end;

  { IItemReader }

  IItemReader<TItemType> = interface
    ['{E7FC1E44-7907-421C-8403-B5333714CEC2}']
    function GetListener: IItemReaderListener;
    function GetSkip: integer;
    function Open: boolean;
    function Read(out item: TItemType): boolean;
    function Close: boolean;
    procedure SetListener(AValue: IItemReaderListener);
    procedure SetSkip(AValue: integer);
    property Skip: integer read GetSkip write SetSkip;
    property Listener: IItemReaderListener read GetListener write SetListener;
  end;

  { IChunk }

  IChunk<TItemType> = interface
    ['{32254F0A-A303-45C5-AD6E-507F715EBB98}']
    function Count: integer;
    function add(const item: TItemType): boolean;
    function get(const index: integer): TItemType;
    function ready: boolean;
    function getCapacity: integer;
  end;

  { IItemWriter }

  IItemWriter<TItemType> = interface
    ['{E7FC1E44-7907-421C-8403-B5333714CEC2}']
    function GetListener: IItemWriterListener;
    function Open: boolean;
    procedure SetListener(AValue: IItemWriterListener);
    procedure Write(const items: IChunk<TItemType>);
    function Close: boolean;
    property Listener: IItemWriterListener read GetListener write SetListener;
  end;

  { IItemProcessor<TInputType, TOutputType> }

  IItemProcessor<TInputType, TOutputType> = interface
    ['{001C3B41-609E-4266-B860-2B687FB4304E}']
    function process(const aIntput: TInputType): TOutputType;
  end;

  { IItemMultiWriter<TItemType> }

  IItemMultiWriter<TItemType> = interface(IItemWriter<TItemType>)
    ['{2C7BB1A9-34CE-46E7-831D-A803D8580C61}']
    function addWriter(writer: IItemWriter<TItemType>): boolean;
    function writerCount: integer;
  end;

  { IStringProcessor }

  IStringProcessor<TItemType> = interface(IItemProcessor<string, TItemType>)
    ['{F544CED9-D95C-4042-8B7C-B04FA406AB75}']
  end;

  { IStep<TInputType, TOutputType> }

  IStep<TInputType, TOutputType> = interface
    ['{F6976823-E7E4-4841-A05B-B47CFD8F1E23}']
    function getItemProcessor: IItemProcessor<TInputType, TOutputType>;
    function getItemReader: IItemReader<TInputType>;
    function getItemWriter: IItemWriter<TOutputType>;
    procedure setItemProcessor(aItem: IItemProcessor<TInputType, TOutputType>);
    procedure setItemReader(aItem: IItemReader<TInputType>);
    procedure setItemWriter(aItem: IItemWriter<TOutputType>);
    procedure Execute;
  end;

  { TAbstractItemReader }

  TAbstractItemReader<TItemType> = class(TInterfacedPersistent, IItemReader<TItemType>)
  private
    FListener: IItemReaderListener;
    FSkip: integer;
    function GetListener: IItemReaderListener;
    function GetSkip: integer;
    procedure SetListener(AValue: IItemReaderListener);
    procedure SetSkip(AValue: integer);
  public
    constructor Create(); virtual;
    destructor Destroy; override;
    function Open: boolean; virtual; abstract;
    function Read(out item: TItemType): boolean; virtual; abstract;
    function Close: boolean; virtual; abstract;
    property Skip: integer read GetSkip write SetSkip;
    property Listener: IItemReaderListener read GetListener write SetListener;
  end;

  { TAbstractItemWriter }

  TAbstractItemWriter<TItemType> = class(TInterfacedPersistent, IItemWriter<TItemType>)
  private
    FListener: IItemWriterListener;
    function GetListener: IItemWriterListener;
    procedure SetListener(AValue: IItemWriterListener);
  public
    function Open: boolean; virtual; abstract;
    procedure Write(const items: IChunk<TItemType>); virtual; abstract;
    function Close: boolean; virtual; abstract;
    function flush: boolean; virtual;
    property Listener: IItemWriterListener read GetListener write SetListener;
  end;

  { TAbstractProcessor }

  TAbstractProcessor<TInputType, TOutputType> = class(TInterfacedPersistent, IItemProcessor<TInputType, TOutputType>)
  public
    function process(const aIntput: TInputType): TOutputType; virtual; abstract;
  end;

  { TAbstractStep }

  TAbstractStep<TInputType, TOutputType> = class(TInterfacedPersistent, IStep<TInputType, TOutputType>)
  protected
    FItemProcessor: IItemProcessor<TInputType, TOutputType>;
    FItemReader: IItemReader<TInputType>;
    FItemWriter: IItemWriter<TOutputType>;
  public
    function getItemProcessor: IItemProcessor<TInputType, TOutputType>;
    function getItemReader: IItemReader<TInputType>;
    function getItemWriter: IItemWriter<TOutputType>;
    procedure setItemProcessor(aItem: IItemProcessor<TInputType, TOutputType>);
    procedure setItemReader(aItem: IItemReader<TInputType>);
    procedure setItemWriter(aItem: IItemWriter<TOutputType>);
    procedure Execute; virtual; abstract;
  end;

  { TAbstractFileReader }

  TAbstractFileReader<TItemType> = class(TAbstractItemReader<TItemType>)
  protected
    FFile: Text;
    FFileName: string;
    procedure SetFileName(AValue: string);
  public
    function Open: boolean; override;
    function Close: boolean; override;
    property FileName: string read FFileName write SetFileName;
  end;

  { TAbstractFileWriter }

  TAbstractFileWriter<TItemType> = class(TAbstractItemWriter<TItemType>)
  protected
    FFile: Text;
    FFileName: string;
    procedure SetFileName(AValue: string);
  public
    function Open: boolean; override;
    property FileName: string read FFileName write SetFileName;
    function flush: boolean; override;
    function Close: boolean; override;
  end;

  { TFlatFileReader }

  TFlatFileReader = class(TAbstractFileReader<string>)
  protected
  public
    constructor Create(aFileName: string; aSkip: integer = 1); reintroduce;
    function Open: boolean; override;
    function Read(out item: string): boolean; override;
    function Close: boolean; override;
  published
    property Skip;
  end;

  { TFlatFileWriter }

  TFlatFileWriter = class(TAbstractFileWriter<string>)
  public
    procedure Write(const items: IChunk<string>); override;
  end;

  { TFixedSizeFileWriter }

  TFixedSizeFileWriter<TItemType> = class(TAbstractItemWriter<TItemType>)
  protected
    FFile: THandleStream;
    FFileName: string;
    procedure SetFileName(AValue: string);
  protected
    procedure WriteSingleItem(item: TItemType); virtual; abstract;
  public
    constructor Create(aFileName: TFileName); virtual;
    function Open: boolean; override;
    procedure Write(const items: IChunk<TItemType>); override;
    function Close: boolean; override;
  published
    property FileName: string read FFileName write SetFileName;
  end;

  { TFlatFileChunkedWriter }

  TFlatFileChunkedWriter = class(TAbstractItemWriter<string>, IItemWriter<string>)
  protected
    FFile: Text;
    FFileName: string;
    procedure SetFileName(AValue: string);
  public
    function Open: boolean; override;
    procedure Write(const items: IChunk<string>); override;
    function Close: boolean; override;
  published
    property FileName: string read FFileName write SetFileName;
  end;

  { TBaseChunk<TItemType> }

  TBaseChunk<TItemType> = class(TInterfacedObject, IChunk<TItemType>)
  protected
    FCapacity: integer;
    FCount: integer;
    fChunk: array of TItemType;
    procedure SetCapacity(AValue: integer);
    procedure SetCount(AValue: integer);
  public
    constructor Create(aCapacity: integer); virtual;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    function Count: integer; virtual;
    function add(const item: TItemType): boolean; virtual;
    function get(const index: integer): TItemType; virtual;
    function ready: boolean;
    function getCapacity: integer;
  end;

  { TStringAbstractItemProcessor }

  TStringAbstractItemProcessor<OutputItem> = class(TAbstractProcessor<string, OutputItem>, IStringProcessor<OutputItem>)
  protected
    function Next(var cursor: pchar; separator: char = ','): string;
    function NextInt(var cursor: pchar; separator: char = ','): int64;
  public
  end;

  { TIdentityProcessor }

  TIdentityProcessor<TType> = class(TAbstractProcessor<TType, TType>)
    function process(const aInput: TType): TType; override;
  end;

  { TSplitCSVItemProcessor }

  TSplitCSVItemProcessor = class(TStringAbstractItemProcessor<TStringArray>)
  private
    FSeparatorChar: char;
    procedure SetSeparatorChar(AValue: char);
  public
    function process(const aIntput: string): TStringArray; override;
  published
    property SeparatorChar: char read FSeparatorChar write SetSeparatorChar;
  end;

  { TItemReaderListener }

  TItemReaderListener = class(TInterfacedObject, IItemReaderListener)
  protected
    FCount: uint64;
    fLock: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure readCount;
    function Count: uint64;
    function totalCount: uint64;
  end;

  { TItemWriterListener }

  TItemWriterListener = class(TInterfacedObject, IItemWriterListener)
  protected
    FCount: uint64;
    FRequestCount: uint64;
    fLock: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure writeCount(Count: integer = 1);
    procedure requestCount(Count: integer = 1);
    function Count: uint64;
    function totalCount: uint64;
    function getRequestCount: uint64;
  end;

  { TItemMultiWriter }

  TItemMultiWriter<TItemType> = class(TAbstractItemWriter<TItemType>,
    IItemMultiWriter<TItemType>, IItemWriterListener)
  protected
  type
    TDelegateList = TFPGList<IItemWriter<TItemType>>;
  protected
    FDelegates: TDelegateList;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Write(const items: IChunk<TItemType>); override;
    function Open: boolean; override;
    function Close: boolean; override;
    function addWriter(writer: IItemWriter<TItemType>): boolean;
    function writerCount: integer;
    procedure requestCount(Count: integer = 1);
    procedure writeCount(Count: integer = 1);
    function Count: uint64;
    function totalCount: uint64;
    function getRequestCount: uint64;
  end;

  IExecutor = interface
    ['{7F43EDBF-2809-417E-9B6D-063F53AD7A1D}']
    procedure Execute;
  end;

  { TBaseStep }

  TBaseStep<TInputType, TOutputType> = class(TAbstractStep<TInputType, TOutputType>)
  private
    FChunkSize: integer;
    FName: string;
    FProcessor: IItemProcessor<TInputType, TOutputType>;
    FReader: IItemReader<TInputType>;
    FWriter: IItemWriter<TOutputType>;
    procedure SetChunkSize(AValue: integer);
    procedure SetName(AValue: string);
  protected
    function getReader: IItemReader<TInputType>;
    function getWriter: IItemWriter<TOutputType>;
    function getProcessor: IItemProcessor<TInputType, TOutputType>;
    procedure SetProcessor(AValue: IItemProcessor<TInputType, TOutputType>);
    procedure SetReader(AValue: IItemReader<TInputType>);
    procedure SetWriter(AValue: IItemWriter<TOutputType>);
  public
    constructor Create(); virtual;
    procedure Execute; override;
    property Reader: IItemReader<TInputType> read getReader write SetReader;
    property Writer: IItemWriter<TOutputType> read getWriter write SetWriter;
    property Processor: IItemProcessor<TInputType, TOutputType> read FProcessor write SetProcessor;
    property Name: string read FName write SetName;
    property ChunkSize: integer read FChunkSize write SetChunkSize;
  end;

  TExecutorQueue = class;

  { TExecutor }

  TExecutor = class(TInterfacedObject, IExecutor)
  private
  type
    { TInternalThread }

    TInternalThread = class(TThread)
    protected
      FOwner: TExecutor;
      procedure SetOwner(AValue: TExecutor);
    public
      procedure Execute; override;
      property Owner: TExecutor read FOwner write SetOwner;
    end;

  private
    FRunner: TInternalThread;
    FActiveQueue: TExecutorQueue;
    function getFinished: boolean;
    function GetSuspended: boolean;
    procedure SetSuspended(AValue: boolean);

  protected
    function GetOnTerminate: TNotifyEvent;
    procedure SetOnTerminate(AValue: TNotifyEvent);
    procedure SetActiveQueue(AValue: TExecutorQueue);
  protected
    procedure internalExecute; virtual; abstract;
  public
    constructor Create(); reintroduce;
    destructor Destroy; override;
    procedure Execute; virtual;
    property OnTerminate: TNotifyEvent read GetOnTerminate write SetOnTerminate;
    procedure Resume;
    procedure Suspend;
    procedure Terminate;
    property Suspended: boolean read GetSuspended write SetSuspended;
    property Finished: boolean read getFinished;
  end;

  TExecutors = TFPGList<IExecutor>;

  { TExecutorQueue }

  TExecutorQueue = class(TExecutors)
  private
    FStarted: boolean;
    procedure OnExecutorTerminate(Task: TObject);
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure add(aExecutor: IExecutor);
    procedure Start;
    procedure Stop;
    procedure Terminate;
    function workingCount: uint32;
    procedure Execute;
  end;

  { TStepExecutor }

  TStepExecutor<TInputType, TOutputType> = class(TExecutor)
  private
    FStep: IStep<TInputType, TOutputType>;
    procedure SetStep(AValue: IStep<TInputType, TOutputType>);
  protected
    procedure internalExecute; override;
  public
    property Step: IStep<TInputType, TOutputType> read FStep write SetStep;
  end;

  { TJob }

  TJob = class(TInterfacedObject)
  protected
    FStepExecutors: TExecutorQueue;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure addExecutor(aExecutor: IExecutor);
    procedure Execute;
  end;

implementation


{ TAbstractItemReader }

procedure TAbstractItemReader<TItemType>.SetSkip(AValue: integer);
begin
  if FSkip = AValue then Exit;
  FSkip := AValue;
end;

constructor TAbstractItemReader<TItemType>.Create;
begin

end;

function TAbstractItemReader<TItemType>.GetSkip: integer;
begin
  Result := FSkip;
end;

function TAbstractItemReader<TItemType>.GetListener: IItemReaderListener;
begin
  Result := FListener;
end;

procedure TAbstractItemReader<TItemType>.SetListener(AValue: IItemReaderListener);
begin
  FListener := AValue;
end;

destructor TAbstractItemReader<TItemType>.Destroy;
begin
  inherited Destroy;
end;


{ TBaseChunk }

procedure TBaseChunk<TItemType>.SetCapacity(AValue: integer);
begin
  if FCapacity = AValue then Exit;
  FCapacity := AValue;
  SetLength(fChunk, AValue);
  FCount := 0;
end;

procedure TBaseChunk<TItemType>.SetCount(AValue: integer);
begin
  if FCount = AValue then Exit;
  FCount := AValue;
end;

constructor TBaseChunk<TItemType>.Create(aCapacity: integer);
begin
  FCapacity := aCapacity;
end;

destructor TBaseChunk<TItemType>.Destroy;
begin
  inherited Destroy;
end;

procedure TBaseChunk<TItemType>.AfterConstruction;
begin
  inherited AfterConstruction;
  SetLength(fChunk, FCapacity);
end;

procedure TBaseChunk<TItemType>.BeforeDestruction;
var
  idx: integer;
  item: TItemType;
begin
  if (fChunk <> nil) then
  begin
    for idx := FCapacity - 1 downto 0 do
    begin
      item := fChunk[idx];
      fChunk[idx] := nil;
      if item <> nil then
        FreeAndNil(item);
    end;
  end;
  SetLength(fChunk, 0);
  inherited BeforeDestruction;
end;

function TBaseChunk<TItemType>.Count: integer;
begin
  Result := FCount;
end;

function TBaseChunk<TItemType>.add(const item: TItemType): boolean;
begin
  Result := False;
  if FCount <= FCapacity then
  begin
    fChunk[FCount] := item;
    Result := True;
  end;
  FCount += 1;
end;

function TBaseChunk<TItemType>.get(const index: integer): TItemType;
begin
  Result := fChunk[index];
end;

function TBaseChunk<TItemType>.ready: boolean;
begin
  Result := FCount = FCapacity;
end;

function TBaseChunk<TItemType>.getCapacity: integer;
begin
  Result := FCapacity;
end;

{ TStringAbstractItemProcessor }

function TStringAbstractItemProcessor<OutputItem>.Next(var cursor: pchar; separator: char): string;
begin
  Result := '';
  while (cursor^ <> #0) do
  begin
    case cursor^ of
      '"': begin
        Inc(cursor);
        while not (cursor^ in ['"', #0]) do
        begin
          if cursor^ = '\' then
          begin
            Inc(cursor);
            Result += cursor^;
            Inc(cursor);
          end
          else
          if cursor^ = '"' then
          begin
            Inc(cursor);
            Result += cursor^;
            Inc(cursor);
          end
          else
          begin
            Result += cursor^;
            Inc(cursor);
          end;
        end;
        if cursor^ = '"' then Inc(cursor);
        if cursor^ = separator then Inc(cursor);
        exit(Result);
      end
      else
      begin
        if cursor^ = separator then
        begin
          Inc(cursor);
          exit(Result);
        end
        else
          Result += cursor^;
      end;
    end;
    Inc(cursor);
  end;

end;

function TStringAbstractItemProcessor<OutputItem>.NextInt(var cursor: pchar; separator: char): int64;
begin
  Result := StrToInt64(Next(cursor, separator));
end;

{ TAbstractFileReader }

procedure TAbstractFileReader<TItemType>.SetFileName(AValue: string);
begin
  FFileName := AValue;
end;

function TAbstractFileReader<TItemType>.Open: boolean;
begin
  AssignFile(FFile, FFileName);
  Reset(FFile);
  Result := True;
end;

function TAbstractFileReader<TItemType>.Close: boolean;
begin
  CloseFile(FFile);
  Result := True;
end;

{ TSplitCSVItemProcessor }

procedure TSplitCSVItemProcessor.SetSeparatorChar(AValue: char);
begin
  if FSeparatorChar = AValue then Exit;
  FSeparatorChar := AValue;
end;

function TSplitCSVItemProcessor.process(const aIntput: string): TStringArray;
var
  cursor: pchar;
begin
  cursor := PChar(aIntput);
  SetLength(Result, 0);
  while cursor^ <> #0 do
  begin
    SetLength(Result, Length(Result) + 1);
    Result[High(Result)] := Next(cursor, FSeparatorChar);
  end;
end;

{ TFlatFileChunkedWriter }

procedure TFlatFileChunkedWriter.SetFileName(AValue: string);
begin
  if FFileName = AValue then Exit;
  FFileName := AValue;
end;

function TFlatFileChunkedWriter.Open: boolean;
begin
  AssignFile(FFile, FFileName);
  Rewrite(FFile);
  Result := True;
end;

procedure TFlatFileChunkedWriter.Write(const items: IChunk<string>);
var
  item: string;
  idx: integer;
begin
  for idx := 0 to items.Count - 1 do
  begin
    item := items.get(idx);
    WriteLn(FFile, item);
    if Listener <> nil then
    begin
      Listener.writeCount(1);
    end;
  end;
end;

function TFlatFileChunkedWriter.Close: boolean;
begin
  CloseFile(FFile);
  Result := True;
end;

{ TIdentityProcessor }

function TIdentityProcessor<TType>.process(const aInput: TType): TType;
begin
  Result := aInput;
end;

{ TFlatFileWriter }

procedure TFlatFileWriter.Write(const items: IChunk<string>);
var
  idx: integer;
begin
  for idx := 0 to items.Count - 1 do
  begin
    WriteLn(FFile, items.get(idx));
  end;
  if Listener <> nil then Listener.writeCount(items.Count);
end;

{ TFixedSizeFileWriter }

procedure TFixedSizeFileWriter<TItemType>.SetFileName(AValue: string);
begin
  FFileName := AValue;
end;

constructor TFixedSizeFileWriter<TItemType>.Create(aFileName: TFileName);
begin
  FFileName := aFileName;
end;

function TFixedSizeFileWriter<TItemType>.Open: boolean;
begin
  FFile := TFileStream.Create(FFileName, fmCreate or fmOpenWrite or fmShareDenyWrite);
  Result := True;
end;

procedure TFixedSizeFileWriter<TItemType>.Write(const items: IChunk<TItemType>);
var
  idx: integer;
begin
  for idx := 0 to items.Count - 1 do
  begin
    try
      WriteSingleItem(items.get(idx));
      if Listener <> nil then
        Listener.writeCount(1);
    except
      on E: Exception do
        Writeln(E.Message);
    end;
  end;
end;

function TFixedSizeFileWriter<TItemType>.Close: boolean;
begin
  FreeAndNil(FFile);
  Result := True;
end;

{ TAbstractFileWriter }

procedure TAbstractFileWriter<TItemType>.SetFileName(AValue: string);
begin
  FFileName := aValue;
end;

function TAbstractFileWriter<TItemType>.Open: boolean;
begin
  AssignFile(FFile, FFileName);
  Rewrite(FFile);
  Result := True;
end;

function TAbstractFileWriter<TItemType>.flush: boolean;
begin
  Result := inherited flush;
  System.Flush(FFile);
end;

function TAbstractFileWriter<TItemType>.Close: boolean;
begin
  Flush;
  CloseFile(FFile);
  Result := True;
end;

{ TAbstractItemWriter }

procedure TAbstractItemWriter<TItemType>.SetListener(AValue: IItemWriterListener);
begin
  if FListener = AValue then Exit;
  FListener := AValue;
end;

function TAbstractItemWriter<TItemType>.flush: boolean;
begin
  Result := True;
end;

function TAbstractItemWriter<TItemType>.GetListener: IItemWriterListener;
begin
  Result := FListener;
end;

{ TAbstractStep }

function TAbstractStep<TInputType, TOutputType>.getItemProcessor: IItemProcessor<TInputType, TOutputType>;
begin
  Result := FItemProcessor;
end;

function TAbstractStep<TInputType, TOutputType>.getItemReader: IItemReader<TInputType>;
begin
  Result := FItemReader;
end;

function TAbstractStep<TInputType, TOutputType>.getItemWriter: IItemWriter<TOutputType>;
begin
  Result := FItemWriter;
end;

procedure TAbstractStep<TInputType, TOutputType>.setItemProcessor(aItem: IItemProcessor<TInputType, TOutputType>);
begin
  FItemProcessor := aItem;
end;

procedure TAbstractStep<TInputType, TOutputType>.setItemReader(aItem: IItemReader<TInputType>);
begin
  FItemReader := aItem;
end;

procedure TAbstractStep<TInputType, TOutputType>.setItemWriter(aItem: IItemWriter<TOutputType>);
begin
  FItemWriter := aItem;
end;

{ TFlatFileReader }

constructor TFlatFileReader.Create(aFileName: string; aSkip: integer);
begin
  inherited Create();
  FileName := aFileName;
  Skip := aSkip;
end;

function TFlatFileReader.Open: boolean;
var
  item: string;
begin
  Result := inherited Open;
  if not EOF(FFile) then
    while FSkip > 0 do
    begin
      ReadLn(FFile, item);
      Dec(FSkip);
    end;
  Result := not EOF(FFile);
end;

function TFlatFileReader.Read(out item: string): boolean;
begin
  if not (EOF(FFile)) then
  begin
    ReadLn(FFile, item);
    if Listener <> nil then
    begin
      Listener.readCount;
    end;
  end;
  Result := not EOF(FFile);
end;

function TFlatFileReader.Close: boolean;
begin
  Result := inherited Close;
end;


{ TItemReaderListener }

constructor TItemReaderListener.Create;
begin
  InitCriticalSection(fLock);
end;

destructor TItemReaderListener.Destroy;
begin
  DoneCriticalSection(fLock);
  inherited Destroy;
end;

procedure TItemReaderListener.readCount;
begin
  try
    EnterCriticalSection(fLock);
    fCount += 1;
  finally
    LeaveCriticalSection(fLock);
  end;
end;

function TItemReaderListener.Count: uint64;
const
  lastCount: uint64 = 0;
begin
  Result := FCount - lastCount;
  lastCount := FCount;
end;

function TItemReaderListener.totalCount: uint64;
begin
  Result := FCount;
end;


{ TItemWriterListener }

constructor TItemWriterListener.Create;
begin
  InitCriticalSection(fLock);
end;

destructor TItemWriterListener.Destroy;
begin
  DoneCriticalSection(fLock);
  inherited Destroy;
end;

procedure TItemWriterListener.writeCount(Count: integer);
begin
  try
    EnterCriticalSection(fLock);
    fCount += Count;
  finally
    LeaveCriticalSection(fLock);
  end;
end;

procedure TItemWriterListener.requestCount(Count: integer);
begin
  try
    EnterCriticalSection(fLock);
    FRequestCount += Count;
  finally
    LeaveCriticalSection(fLock);
  end;
end;

function TItemWriterListener.Count: uint64;
const
  lastCount: uint64 = 0;
begin
  Result := FCount - lastCount;
  lastCount := FCount;
end;

function TItemWriterListener.totalCount: uint64;
begin
  Result := FCount;
end;

function TItemWriterListener.getRequestCount: uint64;
begin
  Result := FRequestCount;
end;

{ TExecutor }

function TExecutor.getFinished: boolean;
begin
  Result := FRunner.Finished;
end;

function TExecutor.GetSuspended: boolean;
begin
  Result := FRunner.Suspended;
end;

procedure TExecutor.SetSuspended(AValue: boolean);
begin
  FRunner.Suspended := AValue;
end;

function TExecutor.GetOnTerminate: TNotifyEvent;
begin
  Result := FRunner.OnTerminate;
end;

procedure TExecutor.SetOnTerminate(AValue: TNotifyEvent);
begin
  FRunner.OnTerminate := AValue;
end;

procedure TExecutor.SetActiveQueue(AValue: TExecutorQueue);
begin
  if FActiveQueue = AValue then
    Exit;
  FActiveQueue := AValue;
end;


constructor TExecutor.Create();
begin
  inherited Create();
  FRunner := TInternalThread.Create(True);
  FRunner.FreeOnTerminate := False;
  FRunner.Owner := self;
end;

destructor TExecutor.Destroy;
begin
  try
    FRunner.Free;
  except
  end;
  inherited Destroy;
end;

procedure TExecutor.Execute;
begin
  FRunner.Start;
end;

procedure TExecutor.Resume;
begin
  FRunner.Resume;
end;

procedure TExecutor.Suspend;
begin
  FRunner.Suspend;
end;

procedure TExecutor.Terminate;
begin
  FRunner.Terminate;
end;

{ TExecutor.TInternalThread }

procedure TExecutor.TInternalThread.SetOwner(AValue: TExecutor);
begin
  if FOwner = AValue then Exit;
  FOwner := AValue;
end;

procedure TExecutor.TInternalThread.Execute;
begin
  FOwner.internalExecute;
  Terminate;
end;

{ TExecutorQueue }

procedure TExecutorQueue.OnExecutorTerminate(Task: TObject);
begin
  Self.Remove(Task as TExecutor);
end;

procedure TExecutorQueue.AfterConstruction;
begin
  inherited AfterConstruction;
  FStarted := False;
end;

procedure TExecutorQueue.BeforeDestruction;
begin
  inherited BeforeDestruction;
end;

procedure TExecutorQueue.add(aExecutor: IExecutor);
begin
  inherited Add(aExecutor);
  (aExecutor as TExecutor).SetActiveQueue(self);
  (aExecutor as TExecutor).OnTerminate := OnExecutorTerminate;
  if FStarted then
    aExecutor.Execute;
end;

procedure TExecutorQueue.Start;
var
  aExecutor: IExecutor;
begin
  FStarted := False;
  for aExecutor in self do
  begin
    (aExecutor as TExecutor).Resume;
  end;
end;

procedure TExecutorQueue.Stop;
var
  aExecutor: IExecutor;
begin
  for aExecutor in self do
  begin
    (aExecutor as TExecutor).Suspend;
  end;
end;

procedure TExecutorQueue.Terminate;
var
  aExecutor: IExecutor;
begin
  for aExecutor in self do
  begin
    (aExecutor as TExecutor).Terminate;
    self.Remove(aExecutor);
  end;
end;

function TExecutorQueue.workingCount: uint32;
var
  aExecutor: IExecutor;
begin
  Result := 0;
  try
    for aExecutor in self do
    begin
      if not (aExecutor as TExecutor).Finished then
        InterLockedIncrement(Result);
    end;
  except
  end;
end;

procedure TExecutorQueue.Execute;
begin
  Start;
  while workingCount > 0 do
  begin
    sleep(100);
  end;
  Stop;
  Terminate;
end;

{ TStepExecutor }

procedure TStepExecutor<TInputType, TOutputType>.SetStep(AValue: IStep<TInputType, TOutputType>);
begin
  if FStep = AValue then Exit;
  FStep := AValue;
end;

procedure TStepExecutor<TInputType, TOutputType>.internalExecute;
begin
  if FStep <> nil then
    FStep.Execute;
  Terminate;
end;

{ TJob }

procedure TJob.AfterConstruction;
begin
  inherited AfterConstruction;
  FStepExecutors := TExecutorQueue.Create;
end;

procedure TJob.BeforeDestruction;
begin
  FStepExecutors.Terminate;
  FreeAndNil(FStepExecutors);
  inherited BeforeDestruction;
end;

procedure TJob.addExecutor(aExecutor: IExecutor);
begin
  FStepExecutors.add(aExecutor);
end;

procedure TJob.Execute;
var
  totalTimer: TTimer = 0;
begin
  totalTimer.restart;
  FStepExecutors.Execute;
  Writeln('Job done in ', millisToString(totalTimer.elapsed));
end;

{ TItemMultiWriter }

constructor TItemMultiWriter<TItemType>.Create;
begin
  FDelegates := TDelegateList.Create();
end;

destructor TItemMultiWriter<TItemType>.Destroy;
begin
  FreeAndNil(FDelegates);
  inherited Destroy;
end;

procedure TItemMultiWriter<TItemType>.Write(const items: IChunk<TItemType>);
var
  writer: IItemWriter<TItemType>;
begin
  for writer in FDelegates do
    writer.Write(items);
end;

function TItemMultiWriter<TItemType>.Open: boolean;
var
  writer: IItemWriter<TItemType>;
begin
  Result := False;
  for writer in FDelegates do
    writer.Open;
  Result := True;
end;

function TItemMultiWriter<TItemType>.Close: boolean;
var
  writer: IItemWriter<TItemType>;
begin
  Result := False;
  for writer in FDelegates do
    writer.Close;
  Result := True;
end;

function TItemMultiWriter<TItemType>.addWriter(writer: IItemWriter<TItemType>): boolean;
begin
  FDelegates.add(writer);
  writer.Listener := self;
end;

function TItemMultiWriter<TItemType>.writerCount: integer;
begin
  Result := FDelegates.Count;
end;

procedure TItemMultiWriter<TItemType>.requestCount(Count: integer);
begin
  if Listener <> nil then Listener.requestCount(Count);
end;

procedure TItemMultiWriter<TItemType>.writeCount(Count: integer);
begin
  if Listener <> nil then Listener.writeCount(Count);
end;

function TItemMultiWriter<TItemType>.Count: uint64;
begin
  Result := 0;
  if Listener <> nil then Result := Listener.Count;
end;

function TItemMultiWriter<TItemType>.totalCount: uint64;
begin
  Result := 0;
  if Listener <> nil then Result := Listener.totalCount;
end;

function TItemMultiWriter<TItemType>.getRequestCount: uint64;
begin
  Result := 0;
  if Listener <> nil then Result := Listener.getRequestCount;
end;

{ TBaseStep }

procedure TBaseStep<TInputType, TOutputType>.SetName(AValue: string);
begin
  if FName = AValue then Exit;
  FName := AValue;
end;

procedure TBaseStep<TInputType, TOutputType>.SetChunkSize(AValue: integer);
begin
  if FChunkSize = AValue then Exit;
  FChunkSize := AValue;
end;

function TBaseStep<TInputType, TOutputType>.getReader: IItemReader<TInputType>;
begin
  Result := FReader;
end;

function TBaseStep<TInputType, TOutputType>.getWriter: IItemWriter<TOutputType>;
begin
  Result := FWriter;
end;

function TBaseStep<TInputType, TOutputType>.getProcessor: IItemProcessor<TInputType, TOutputType>;
begin
  Result := FProcessor;
end;

procedure TBaseStep<TInputType, TOutputType>.SetProcessor(AValue: IItemProcessor<TInputType, TOutputType>);
begin
  if FProcessor = AValue then Exit;
  FProcessor := AValue;
end;

procedure TBaseStep<TInputType, TOutputType>.SetReader(AValue: IItemReader<TInputType>);
begin
  FReader := AValue;
end;

procedure TBaseStep<TInputType, TOutputType>.SetWriter(AValue: IItemWriter<TOutputType>);
begin
  FWriter := AValue;
end;

constructor TBaseStep<TInputType, TOutputType>.Create();
begin
  FReader := nil;
  FWriter := nil;
  FChunkSize := 500;
end;

procedure TBaseStep<TInputType, TOutputType>.Execute;
var
  reader: IItemReader<TInputType>;
  processore: IItemProcessor<TInputType, TOutputType>;
  writer: IItemWriter<TOutputType>;
  inputItem: TInputType;
  outputItem: TOutputType;
  done: boolean = False;
  chunk: TBaseChunk<TOutputType> = nil;
  timer: TTimer = 0;
  totalTimer: TTimer = 0;
begin
  processore := getProcessor;
  reader := getReader;
  writer := getWriter;
  reader.Open;
  writer.Open;
  done := False;
  totalTimer.restart;
  repeat
    timer.restart;
    done := not reader.Read(inputItem);
    if not done then
    begin
      if chunk = nil then
        chunk := TBaseChunk<TOutputType>.Create(FChunkSize);
      outputItem := processore.process(inputItem);
      chunk.add(outputItem);
      if chunk.ready then
      begin
        writer.Write(chunk);
        Writeln('   ', FName: 50, ' Step Chunk C:', chunk.getCapacity: 10,
          ' R:', reader.Listener.Count: 10, '-> W', writer.Listener.Count: 10,
          '(T-R:', reader.Listener.totalCount: 10, ':: T-W:',
          writer.Listener.totalCount: 10,
          ') in ', millisToString(timer.elapsed), ' millis');
        FreeAndNil(chunk);
        chunk := TBaseChunk<TOutputType>.Create(FChunkSize);
      end;
    end;
  until done;
  if chunk.Count > 0 then
    writer.Write(chunk);
  Writeln(FName: 50, ' Step Done T-R:', reader.Listener.totalCount: 10,
    '-> T-W:', writer.Listener.totalCount: 10, ' in ',
    millisToString(totalTimer.elapsed));
  FreeAndNil(chunk);
  reader.Close;
  writer.Close;
end;


end.
