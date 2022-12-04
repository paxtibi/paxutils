unit paxutils;

{$mode objfpc}{$H+}
{$M+}
{$ModeSwitch typehelpers}
{$ModeSwitch advancedrecords}
{$if FPC_FULLVERSION >= 30301 }
  {$modeswitch prefixedattributes}
  {$define custom_attributes}
{$endif}

interface

uses
  Classes, SysUtils, contnrs, fgl;

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
    constructor Create(MaxPermits: cardinal = 10); virtual;
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
    FStarted: boolean;
    FSemaphore: TSemaphore;
    procedure SetSemaphore(AValue: TSemaphore);
    procedure OnTaskTerminate(Task: TObject);
  public
    procedure AfterConstruction; override;
    procedure add(aTask: TTask);
    property Semaphore: TSemaphore read FSemaphore write SetSemaphore;
    procedure Start;
    procedure Stop;
    procedure Terminate;
    function workingCount: uint32;
  end;

  { TProperties }

  TProperties = class(TInterfacedObject)
  private
    function continueLine(const line: ansistring): boolean; overload; virtual;
    function loadConvert(const theString: ansistring): ansistring; overload; virtual;
    function saveConvert(const theString: ansistring; const escapeSpace: boolean): ansistring; overload; virtual;
    class procedure writeln(const bw: TStream; const s: ansistring); overload; virtual;
    class function toHex(const nibble: longint): char; overload; virtual;
  protected
    FDefaults: TProperties;
    FValues: TStringList;//;TItem;
  protected
    procedure print(_out_: TStream; message: ansistring);
    procedure println(_out_: TStream; message: ansistring);
    function readLine(_in_: TStream; var EOF: boolean): ansistring;
  public
    constructor Create; overload; virtual;
    constructor Create(const defaults: TProperties); overload; virtual;
    destructor Destroy; override;
    procedure load(const inStream: TStream); overload; virtual;
    procedure load(filename: ansistring); overload; virtual;
    procedure loadResource(resourceName: ansistring); overload; virtual;
    procedure save(const _out_: TStream; const header: ansistring); overload; virtual;
    procedure save(filename: ansistring; const header: ansistring = ''); overload; virtual;
    procedure store(const _out_: TStream; const header: ansistring); overload; virtual;
    function setProperty(const key: ansistring; const Value: ansistring): ansistring; overload; virtual;
    function setBoolean(const key: ansistring; const Value: boolean): ansistring; overload; virtual;
    function setLongint(const key: ansistring; const Value: longint): ansistring; overload; virtual;
    function getProperty(const key: ansistring; const defaultValue: ansistring = ''): ansistring; overload; virtual;
    function getBoolean(const key: ansistring; const defaultValue: boolean = False): boolean; overload; virtual;
    function getLongint(const key: ansistring; const defaultValue: longint = 0): longint; overload; virtual;
    function getExtended(const key: ansistring; const defaultValue: extended = 0): extended; overload; virtual;
    function propertyNames: TStrings; overload; virtual;
    function containKey(const aKey: string): boolean;
  end;

  { IComparable }

  generic IComparable<itemType> = interface
    function compareTo(const comparable: itemType): TCompareResult;
  end;

type
  TSize = uint64;

function millis(): int64; inline;
function millisToString(millis: int64): string;

implementation

uses
  dynlibs;

function millis(): int64;
var
  D: double;
begin
  D := now * single(MSecsPerDay);
  if D < 0 then
    D := D - 0.5
  else
    D := D + 0.5;
  Result := trunc(D);
end;

function millisToString(millis: int64): string;
var
  h: word = 0;
  m: word = 0;
  s: word = 0;
  ms: word = 0;
begin
  ms := (millis mod 1000);
  millis := millis div 1000;
  if millis > 0 then
  begin
    s := (millis mod 60);
    millis := millis div 60;
  end;
  if millis > 0 then
  begin
    m := (millis mod 60);
    millis := millis div 60;
  end;
  if millis > 0 then
  begin
    h := millis;
  end;
  Result := Format('%.2d:%.2d:%.2d.%.4d', [h, m, s, ms]);
end;

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
    try
      FRunner.run;
    except
    end;
  end;
  if FActiveQueue <> nil then
  begin
    idx := FActiveQueue.IndexOf(self);
    if idx >= 0 then
      FActiveQueue.Remove(self);
  end;
  ActiveQueue.Semaphore.Release;
  FRunner := nil;
  Terminate;
end;

procedure TTaskQueue.SetSemaphore(AValue: TSemaphore);
begin
  if FSemaphore = AValue then
    Exit;
  FSemaphore := AValue;
end;

procedure TTaskQueue.OnTaskTerminate(Task: TObject);
begin
  Self.Remove(Task as TTask);
end;

procedure TTaskQueue.AfterConstruction;
begin
  inherited AfterConstruction;
  FStarted := False;
end;

procedure TTaskQueue.add(aTask: TTask);
begin
  inherited Add(aTask);
  ATask.ActiveQueue := self;
  aTask.OnTerminate := @OnTaskTerminate;
  if FStarted then
    aTask.Start;
end;

procedure TTaskQueue.Start;
var
  task: TTask;
begin
  FStarted := True;
  for task in self do
  begin
    task.Start;
  end;
end;

procedure TTaskQueue.Stop;
var
  task: TTask;
begin
  FStarted := False;
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
    self.Remove(task);
    task.Free;
  end;
end;

function TTaskQueue.workingCount: uint32;
var
  task: TTask;
begin
  Result := 0;
  for task in self do
  begin
    try
      if not task.Finished then
        InterLockedIncrement(Result);
    except
    end;
  end;
end;

const
  keyValueSeparators = '=: '#9#13#10#12;
  strictKeyValueSeparators = '=:';
  specialSaveChars = '=: '#9#13#10#12'#!';
  whiteSpaceChars = ' '#9#13#10#12;
  hexDigit: array[0..15] of char = (
    '0', '1', '2', '3', '4', '5', '6', '7',
    '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');

{ TProperties }

constructor TProperties.Create;
begin
  Create(nil);
end;

constructor TProperties.Create(const defaults: TProperties);
begin
  FValues := TStringList.Create;
  FDefaults := defaults;
end;

destructor TProperties.Destroy;
begin
  FreeAndNil(FValues);
  inherited Destroy;
end;

function TProperties.setProperty(const key: ansistring; const Value: ansistring): ansistring;
begin
  Result := key + '=' + Value;
  FValues.Values[key] := Value;
end;

procedure TProperties.load(filename: ansistring);
var
  FS: TFileStream;
  dir: ansistring;
begin
  try
    dir := ExpandFileName(fileName); { *Converted from ExpandFileName*  }
    chdir(ExtractFilePath(dir));
    FS := TFileStream.Create(ExtractFileName(dir), fmOpenRead);
    load(fs);
    FS.Free;
  except
  end;
end;

procedure TProperties.load(const inStream: TStream);
var
  line, nextLine, loppedLine, key, Value: ansistring;
  startIndex, len, keyStart: longint;
  separatorIndex, valueIndex: longint;
  firstChar, currentChar: widechar;
  EOF: boolean;
  def: TProperties;
begin
  EOF := False;
  while (True) do
  begin
    // Get next line
    line := readLine(inStream, EOF);
    if (EOF) and (length(line) = 0) then
    begin
      exit;
    end;
    if (length(line) > 0) then
    begin
      firstChar := line[1];
      if (line[1] = '#') and (line[2] = '!') then
      begin
        def := TProperties.Create(FDefaults);
        def.load(copy(line, 3, Length(line)) + '.properties');
        FDefaults := def;
        continue;
      end;
      if ((firstChar <> '#') and (firstChar <> '!')) then
      begin
        while (continueLine(line)) do
        begin
          nextLine := readLine(inStream, EOF);
          if (nextLine = '') then
            nextLine := '';
          loppedLine := copy(line, 0, length(line) - 1);
          startIndex := 1;
          while startIndex < length(nextLine) do
          begin
            if (pos(nextLine[startIndex], whiteSpaceChars) = 0) then
            begin
              Break;
            end;
            Inc(startIndex);
          end;
          nextLine := copy(nextLine, startIndex, length(nextLine));
          line := loppedLine + nextLine;
        end;
        len := length(line);
        keyStart := 1;
        while keyStart < len do
        begin
          if (pos(line[keyStart], whiteSpaceChars) = 0) then
          begin
            Break;
          end;
          Inc(keyStart);
        end;
        if (keyStart = len) then
          continue;
        separatorIndex := keyStart;
        while separatorIndex < len do
        begin
          currentChar := line[separatorIndex];
          if (currentChar = '\') then
            Inc(separatorIndex)
          else if (pos(currentChar, keyValueSeparators) <> 0) then
          begin
            Break;
          end;
          Inc(separatorIndex);
        end;
        valueIndex := separatorIndex;
        while valueIndex < len do
        begin
          if (pos(line[valueIndex], whiteSpaceChars) = 0) then
          begin
            Break;
          end;
          Inc(valueIndex);
        end;
        if (valueIndex < len) then
          if (pos(line[valueIndex], strictKeyValueSeparators) <> 0) then
            Inc(valueIndex);
        while (valueIndex < len) do
        begin
          if (pos(line[valueIndex], whiteSpaceChars) = 0) then
          begin
            Break;
          end;
          Inc(valueIndex);
        end;
        key := copy(line, keyStart, separatorIndex);
        Value := '';
        if separatorIndex < len then
          Value := copy(line, valueIndex, len);
        key := trim(loadConvert(key));
        Value := loadConvert(Value);
        setProperty(key, Value);
      end;
    end;
  end;
end;

function TProperties.continueLine(const line: ansistring): boolean;
var
  slashCount, index: longint;
begin
  slashCount := 0;
  index := length(line);
  while ((index >= 0) and (line[index] = '\')) do
  begin
    Inc(slashCount);
    Dec(index);
  end;
  Result := ((slashCount mod 2) = 1);
end;

function TProperties.loadConvert(const theString: ansistring): ansistring;
var
  achar: widechar;
  len, x, i: longint;
  retChar: widechar;
  Value: word absolute retChar;
  outBuffer: ansistring;
begin
  outBuffer := '';
  len := length(theString);
  x := 1;
  while x <= len do
  begin
    aChar := theString[x];
    Inc(X);
    if (aChar = '\') then
    begin
      aChar := theString[x];
      Inc(X);
      if (aChar = 'u') then
      begin
        // Formato xxxx
        Value := 0;
        for i := 0 to 3 do
        begin
          aChar := theString[x];
          Inc(x);
          case (aChar) of
            '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
              Value := (Value shl 4) + Ord(aChar) - Ord('0');
            'a', 'b', 'c', 'd', 'e', 'f':
              Value := (Value shl 4) + 10 + Ord(aChar) - Ord('a');
            'A', 'B', 'C', 'D', 'E', 'F':
              Value := (Value shl 4) + 10 + Ord(aChar) - Ord('A');
            else
              raise Exception.Create('Malformed \\uxxxx encoding.');
          end;
        end;
        SetLength(outBuffer, Length(outBuffer) + 1);
        outbuffer[Length(outBuffer)] := RetChar;
      end
      else
      begin
        if (aChar = 't') then
          aChar := #8
        else if (aChar = 'r') then
          aChar := #13
        else if (aChar = 'n') then
          aChar := #10
        else if (aChar = 'f') then
          aChar := #12;
        outBuffer := outBuffer + aChar;
      end;
    end
    else
    begin
      if pos(aChar, strictKeyValueSeparators) = 0 then
        outBuffer := outBuffer + aChar;
    end;
  end;
  Result := outBuffer;
end;

function TProperties.saveConvert(const theString: ansistring; const escapeSpace: boolean): ansistring;
var
  len, x: longint;
  outBuffer: ansistring;
  achar: widechar;

begin
  outBuffer := '';
  len := length(theString);
  for x := 1 to len do
  begin
    aChar := theString[x];
    case (aChar) of
      ' ':
      begin
        if (x = 0) or (escapeSpace) then
          outBuffer := outBuffer + ('\');
        outBuffer := outBuffer + (' ');
      end;
      '\':
      begin
        outBuffer := outBuffer + ('\');
        outBuffer := outBuffer + ('\');
      end;
      #9:
      begin
        outBuffer := outBuffer + ('\');
        outBuffer := outBuffer + ('t');
      end;
      #10:
      begin
        outBuffer := outBuffer + ('\');
        outBuffer := outBuffer + ('n');
      end;
      #13:
      begin
        outBuffer := outBuffer + ('\');
        outBuffer := outBuffer + ('r');
      end;
      #12:
      begin
        outBuffer := outBuffer + ('\');
        outBuffer := outBuffer + ('f');
      end;
      else
        if ((aChar < char($0020)) or (aChar > char($007E))) then
        begin
          outBuffer := outBuffer + ('\');
          outBuffer := outBuffer + ('u');
          outBuffer := outBuffer + (toHex((Ord(aChar) shr 12) and $F));
          outBuffer := outBuffer + (toHex((Ord(aChar) shr 8) and $F));
          outBuffer := outBuffer + (toHex((Ord(aChar) shr 4) and $F));
          outBuffer := outBuffer + (toHex(Ord(aChar) and $F));
        end
        else
        begin
          if (pos(aChar, specialSaveChars) <> 0) then
            outBuffer := outBuffer + ('\');
          outBuffer := outBuffer + (aChar);
        end;
    end;
  end;
  Result := outBuffer;
end;

procedure TProperties.save(const _out_: TStream; const header: ansistring);
begin
  store(_out_, header);
end;

procedure TProperties.save(filename: ansistring; const header: ansistring);
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(filename, fmCreate or fmOpenWrite);
  store(fs, header);
  FS.Free;
end;

procedure TProperties.store(const _out_: TStream; const header: ansistring);
var
  index: longint;
  e: TStrings;
  key, val: ansistring;
begin
  //FValues.Sort;
  if (header <> '') then
    writeln(_out_, '#' + header);
  writeln(_out_, '#' + DateToStr(now));
  e := propertyNames;
  for index := 0 to e.Count - 1 do
  begin
    key := e[index];
    val := getProperty(ansistring(key));
    key := saveConvert(ansistring(key), True);
    val := saveConvert(val, False);
    writeln(_out_, key + '=' + val);
  end;
end;

class procedure TProperties.writeln(const bw: TStream; const s: ansistring);
var
  line: ansistring;
  idx: integer;
begin
  line := s + LineEnding;
  for idx := 1 to length(line) do
  begin
    bw.Write(line[idx], sizeOf(line[idx]));
  end;
end;

function TProperties.getProperty(const key: ansistring; const defaultValue: ansistring): ansistring;
begin
  Result := FValues.Values[key];
  if Result = '' then
  begin
    if assigned(FDefaults) then
      Result := FDefaults.getProperty(key);
    if Result = '' then
      Result := defaultValue;
    setProperty(key, 'missing value');
  end;
  if Length(Result) <> 0 then
    if Result[1] = '@' then
    begin
      Result := getProperty(Result, defaultValue);
    end;
end;

function TProperties.getBoolean(const key: ansistring; const defaultValue: boolean): boolean;
var
  Value: ansistring;
begin
  Value := getProperty(key, '');
  if Value = '' then
    Result := defaultValue
  else
    Result := SameText(Value, 'true') or SameText(Value, 'yes') or SameText(Value, 'Y');
end;

function HexToInt(s: ansistring): cardinal;
var
  P: pwidechar;
begin
  P := pwidechar(S);
  Result := 0;
  while P^ <> #0 do
  begin
    Result := Result * 16;
    case P^ of
      '0'..'9':
      begin
        Inc(Result, Ord(P^) - Ord('0'));
      end;
      'a'..'f':
      begin
        Inc(Result, Ord(P^) - Ord('a') + 10);
      end;
      'A'..'F':
      begin
        Inc(Result, Ord(P^) - Ord('A') + 10);
      end;
    end;
    Inc(P);
  end;
end;

function TProperties.setBoolean(const key: ansistring; const Value: boolean): ansistring;
begin
  if Value then
  begin
    Result := setProperty(key, 'Y');
  end
  else
  begin
    Result := setProperty(key, 'N');
  end;
end;

function TProperties.setLongint(const key: ansistring; const Value: longint): ansistring;
var
  cifre: ansistring;
  _mod_, _valore_: longint;
begin
  cifre := '';
  _valore_ := Value;
  while _valore_ > 0 do
  begin
    _mod_ := (_valore_ mod 16);
    _valore_ := _valore_ div 16;
    if _mod_ < 10 then
    begin
      cifre := Chr(_mod_ + Ord('0')) + cifre;
    end
    else
    begin
      _mod_ := _mod_ - 10;
      cifre := Chr(_mod_ + Ord('A')) + cifre;
    end;
  end;
  Result := setProperty(key, cifre);
end;

function TProperties.getLongint(const key: ansistring; const defaultValue: longint): longint;
var
  Value: ansistring;
begin
  Value := getProperty(key, '');
  if Value = '' then
    Result := defaultValue
  else
  begin
    Result := StrToInt(Value);
  end;
end;

function TProperties.getExtended(const key: ansistring; const defaultValue: extended): extended;
var
  Value: ansistring;
  C1, C2: char;
begin
  Value := getProperty(key, '');
  if Value = '' then
    Result := defaultValue
  else
  begin
    C1 := DefaultFormatSettings.ThousandSeparator;
    C2 := DefaultFormatSettings.DecimalSeparator;
    DefaultFormatSettings.ThousandSeparator := ',';
    DefaultFormatSettings.DecimalSeparator := '.';
    Result := StrToFloat(Value);
    DefaultFormatSettings.ThousandSeparator := C1;
    DefaultFormatSettings.DecimalSeparator := C2;
  end;
end;

function TProperties.propertyNames: TStrings;
var
  index: longint;
begin
  if assigned(FDefaults) then
    Result := FDefaults.propertyNames
  else
    Result := TStringList.Create;

  for index := 0 to FValues.Count - 1 do
  begin
    Result.Add(FValues.Names[index]);
  end;
end;

function TProperties.containKey(const aKey: string): boolean;
begin
  Result := FValues.IndexOf(aKey) >= -1;
end;

class function TProperties.toHex(const nibble: longint): char;
begin
  Result := hexDigit[nibble];
end;

procedure TProperties.print(_out_: TStream; message: ansistring);
var
  Valore: pwidechar;
begin
  Valore := pwidechar(message);
  while not (Valore^ = #0) do
  begin
    _out_.Write(Valore^, 1);
    Inc(Valore);
  end;
  _out_.Write(Valore^, 1);
end;

procedure TProperties.println(_out_: TStream; message: ansistring);
begin
  print(_out_, message + LineEnding);
end;

function TProperties.readLine(_in_: TStream; var EOF: boolean): ansistring;
var
  c: char;
begin
  c := #0;
  Result := '';
  if EOF then
    exit;
  EOF := _in_.Read(c, 1) <> 1;
  while (not (c in [#0, #13, #10])) and (not EOF) do
  begin
    if EOF then
    begin
      continue;
    end;
    Result := Result + c;
    EOF := _in_.Read(c, 1) <> 1;
    if c = #13 then
      EOF := _in_.Read(c, 1) <> 1;
  end;
end;

procedure TProperties.loadResource(resourceName: ansistring);
var
  R: TResourceStream;
const
  resourceType: PChar = 'properties';
begin
  R := TResourceStream.Create(0, resourceName, resourceType);
  load(r);
  R.Free;
end;



initialization

end.
