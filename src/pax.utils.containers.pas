unit pax.utils.containers;

{$Mode delphi}{$H+}
{$ModeSwitch typehelpers}
interface

uses
  Classes, SysUtils, pax.utils;

type
  { IComparator }
  IComparator<aType> = interface
    ['{2DD26379-34F3-48BB-B5FB-7626A6535305}']
    function compare(value1, value2: aType): integer;
  end;

  { IIterator }
  IIterator<aType> = interface
    ['{891B68F3-72BF-4FA2-BD65-72DD85A7C338}']
    function hasNext(): boolean;
    function Next(): aType;
    procedure remove();
  end;

  {$if FPC_FULLVERSION <= 20701}
  { IEnumeration }
  IEnumeration<aType> = interface
    ['{70A6E4EF-71F3-4783-9174-E40B24262C66}']
    function getCurrent: aType;
    function MoveNext: boolean;
    procedure Reset;
    property Current: aType read getCurrent;
  end;

  {$else}
    IEnumeration<aType> = interface(IEnumerator<aType>)
    ['{70A6E4EF-71F3-4783-9174-E40B24262C66}']
    end;
  {$EndIf}

  { IListIterator }
  IListIterator<aType> = interface(IIterator<aType>)
    ['{66B164F2-0195-48FE-8F5E-BC4F830016E2}']
    procedure add(e: aType);
    function hasPrevious(): boolean;
    function nextIndex(): int32;
    function previous(): aType;
    function previousIndex(): int32;
    procedure setItem(e: aType);
  end;


  { ICollection }
  ICollection<aType> = interface
    ['{0F0FD74A-3A23-4FC1-BACE-D84194067816}']
    function getEnumerator: IEnumeration<aType>;
    function add(e: aType): boolean;
    function addAll(c: ICollection<aType>): boolean;
    procedure Clear();
    function contains(o: aType): boolean;
    function containsAll(c: ICollection<aType>): boolean;
    function equals(o: TObject): boolean;
    function hashCode(): THashCode;
    function isEmpty(): boolean;
    function iterator(): IIterator<aType>;
    function remove(o: aType): boolean; overload;
    function removeAll(c: ICollection<aType>): boolean;
    function retainAll(c: ICollection<aType>): boolean;
    function size(): integer;
    function toArray: TArray<aType>;
  end;

  { IList }
  IList<aType> = interface(ICollection<aType>)
    ['{6B9F2B39-B6C3-4250-BF0F-E1BF55CCB58B}']
    procedure add(index: int32; element: aType); overload;
    function addAll(index: int32; c: ICollection<aType>): boolean; overload;
    function getItem(index: int32): aType;
    function indexOf(o: aType): int32;
    function lastIndexOf(o: aType): int32;
    function listIterator(): IListIterator<aType>; overload;
    function listIterator(index: int32): IListIterator<aType>; overload;
    function remove(index: int32): aType; overload;
    function replace(index: int32; element: aType): aType;
  end;

  { ISet }
  ISet<aType> = interface(ICollection<aType>)
    ['{23DA8C5C-FAB4-41A4-B55D-FBBB2836B613}']
  end;

  { ISortedSet }
  ISortedSet<aType> = interface(ISet<aType>)
    ['{45945647-E1E8-455E-9AAA-734AA3751E1A}']
    function comparator(): IComparator<aType>;
    function First(): aType;
    function headSet(toElement: aType): ISortedSet<aType>;
    function last(): aType;
    function subSet(fromElement, toElement: aType): ISortedSet<aType>;
    function tailSet(fromElement: aType): ISortedSet<aType>;
  end;

  { INavigableSet }
  INavigableSet<aType> = interface(ISet<aType>)
    ['{5C9984F0-014A-4589-AB83-5328B3A9D5A8}']
  end;

  { IQueue }
  IQueue<aType> = interface(ICollection<aType>)
    ['{E6FDC6EA-558F-4039-B1F6-6F7090A55F99}']
    function remove(): aType; overload;
    function element(): aType;
    function offer(e: aType): boolean;
    function peek(): aType;
    function poll(): aType;
  end;

  { IDeque }
  IDeque<aType> = interface(IQueue<aType>)
    ['{71D074A2-0AE2-46F7-9B2D-EE07A9DC8CBB}']
    procedure addFirst(a: aType);
    procedure addLast(a: aType);
    function descendingIterator(): IIterator<aType>;
    function getFirst(): aType;
    function getLast(): aType;
    function offerFirst(a: aType): boolean;
    function offerLast(a: aType): boolean;
    function peekFirst(): aType;
    function peekLast(): aType;
    function pollFirst(): aType;
    function pollLast(): aType;
    function pop(): aType;
    procedure push(a: aType);
    function removeFirst(): aType;
    function removeFirstOccurrence(o: aType): boolean;
    function removeLast(): aType;
    function removeLastOccurrence(o: aType): boolean;
  end;

  { IMap }
  IMapEntry<aKeyType, aValueType> = interface
    ['{5C01FB31-FDEB-48B6-8AD3-2FA7C9F79928}']
    function equals(o: IMapEntry<aKeyType, aValueType>): boolean;
    function getKey(): aKeyType;
    function getValue(): aValueType;
    function hashCode(): THashCode;
    function setValue(Value: aValueType): aValueType;
  end;

  IMap<aKeyType, aValueType> = interface
    ['{F01CBD92-4DFB-4D4E-9088-541C84015A1D}']
    procedure Clear();
    function containsKey(key: aKeyType): boolean;
    function containsValue(Value: aValueType): boolean;
    function entrySet(): ISet<IMapEntry<aKeyType, aValueType>>;
    function equals(o: IMap<aKeyType, aValueType>): boolean;
    function get(key: aKeyType): aValueType;
    function hashCode(): THashCode;
    function isEmpty(): boolean;
    function keySet(): ISet<aKeyType>;
    function put(key: aKeyType; Value: aValueType): aValueType;
    procedure putAll(m: IMap<aKeyType, aValueType>);
    function remove(key: aKeyType): aValueType;
    function size(): int32;
    function values(): ICollection<aValueType>;
  end;

  { ISortedMap }
  ISortedMap<aKeyType, aValueType> = interface(IMap<aKeyType, aValueType>)
    ['{FA85391F-B21D-4163-9B6E-B0A84F929941}']
    function comparator(): IComparator<aKeyType>;
    function firstKey(): aKeyType;
    function headMap(toKey: aKeyType): ISortedMap<aKeyType, aValueType>;
    function lastKey(): aKeyType;
    function subMap(fromKey, toKey: aKeyType): ISortedMap<aKeyType, aValueType>;
    function tailMap(fromKey: aKeyType): ISortedMap<aKeyType, aValueType>;
  end;

  { INavigableMap }
  INavigableMap<aKeyType, aValueType> = interface(IMap<aKeyType, aValueType>)
    ['{A5264471-9DFC-47A7-AFF4-233F0E242E5F}']
    function ceilingEntry(key: aKeyType): IMapEntry<aKeyType, aValueType>;
    function ceilingKey(key: aKeyType): aKeyType;
    function descendingKeySet(): INavigableSet<aKeyType>;
    function descendingMap(): INavigableMap<aKeyType, aValueType>;
    function firstEntry(): IMapEntry<aKeyType, aValueType>;
    function floorEntry(key: aKeyType): IMapEntry<aKeyType, aValueType>;
    function floorKey(key: aKeyType): aKeyType;
    function headMap(toKey: aKeyType): ISortedMap<aKeyType, aValueType>; overload;
    function headMap(toKey: aKeyType; inclusive: boolean): INavigableMap<aKeyType, aValueType>; overload;
    function higherEntry(key: aKeyType): IMapEntry<aKeyType, aValueType>;
    function higherKey(key: aKeyType): aKeyType;
    function lastEntry(): IMapEntry<aKeyType, aValueType>;
    function lowerEntry(key: aKeyType): IMapEntry<aKeyType, aValueType>;
    function lowerKey(key: aKeyType): aKeyType;
    function navigableKeySet(): INavigableSet<aKeyType>;
    function pollFirstEntry(): IMapEntry<aKeyType, aValueType>;
    function pollLastEntry(): IMapEntry<aKeyType, aValueType>;
    function subMap(fromKey: aKeyType; fromInclusive: boolean; toKey: aKeyType; toInclusive: boolean): INavigableMap<aKeyType, aValueType>; overload;
    function subMap(fromKey, toKey: aKeyType): ISortedMap<aKeyType, aValueType>; overload;
    function tailMap(fromKey: aKeyType): ISortedMap<aKeyType, aValueType>; overload;
    function tailMap(fromKey: aKeyType; inclusive: boolean): INavigableMap<aKeyType, aValueType>; overload;
  end;

  { TAbstractCollection }

  TAbstractCollection<aType> = class(TInterfacedObject, ICollection<aType>)
    function getEnumerator: IEnumeration<aType>; virtual; abstract;
    function add(e: aType): boolean; virtual; abstract;
    function addAll(c: ICollection<aType>): boolean; virtual;
    procedure Clear(); virtual;
    function contains(o: aType): boolean; virtual;
    function containsAll(c: ICollection<aType>): boolean; virtual;
    function equals(o: TObject): boolean; reintroduce; virtual; abstract;
    function hashCode(): THashCode; virtual; abstract;
    function isEmpty(): boolean; virtual;
    function iterator(): IIterator<aType>; virtual; abstract;
    function remove(o: aType): boolean; virtual;
    function removeAll(c: ICollection<aType>): boolean; virtual;
    function retainAll(c: ICollection<aType>): boolean; virtual;
    function size(): integer; virtual; abstract;
    function ToString: ansistring; override;
    function toArray: TArray<aType>;
  end;

  { TAbstractList }

  TAbstractList<aType> = class(TAbstractCollection<aType>, IList<aType>)
  protected
    FMonitor: TRTLCriticalSection;
    procedure enterMonitor;
    procedure leaveMonitor;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function add(e: aType): boolean; overload; override;
    procedure add(index: int32; element: aType); virtual; abstract; overload;
    function addAll(index: int32; c: ICollection<aType>): boolean; virtual; abstract; overload;
    function getItem(index: int32): aType; virtual; abstract; overload;
    function indexOf(o: aType): int32; virtual; overload;
    function lastIndexOf(o: aType): int32; virtual; overload;
    function listIterator(): IListIterator<aType>; virtual; abstract; overload;
    function listIterator(index: int32): IListIterator<aType>; virtual; abstract; overload;
    function remove(index: int32): aType; virtual; abstract; overload;
    function replace(index: int32; element: aType): aType; virtual; abstract; overload;
  end;

  { TAbstractSequentialList }

  TAbstractSequentialList<aType> = class(TAbstractList<aType>)
  public
    function getItem(index: int32): aType; override; overload;
    function setItem(index: int32; item: aType): aType; virtual;
    procedure add(index: int32; element: aType); override; overload;
    function addAll(index: int32; c: ICollection<aType>): boolean; override; overload;
    function remove(index: int32): aType; override; overload;
    function iterator: IIterator<aType>; override;
  end;

  { TAbstractSet }

  TAbstractSet<aType> = class(TAbstractCollection<aType>, ISet<aType>)
    function removeAll(c: ICollection<aType>): boolean; override;
    function hashCode(): THashCode; override;
  end;

  { TAbstractQueue }

  TAbstractQueue<aType> = class(TAbstractCollection<aType>, IQueue<aType>)
    function add(e: aType): boolean; override;
    function addAll(c: ICollection<aType>): boolean; override;
    function remove(o: aType): boolean; virtual; abstract; overload;
    function remove(): aType; virtual; overload;
    function element(): aType; virtual;
    function offer(e: aType): boolean; virtual; abstract;
    function peek(): aType; virtual; abstract;
    function poll(): aType; virtual; abstract;
    procedure Clear; override;
  end;

  { TAbstractMap }

  TAbstractMap<aKeyType, aValueType> = class(TInterfacedObject,
    IMap<aKeyType, aValueType>)
    procedure Clear(); virtual;
    function containsKey(key: aKeyType): boolean; virtual;
    function containsValue(Value: aValueType): boolean; virtual;
    function entrySet(): ISet<IMapEntry<aKeyType, aValueType>>; virtual; abstract;
    function equals(o: IMap<aKeyType, aValueType>): boolean; reintroduce; virtual; abstract;
    function get(key: aKeyType): aValueType; virtual;
    function hashCode(): THashCode; virtual; abstract;
    function isEmpty(): boolean; virtual;
    function keySet(): ISet<aKeyType>; virtual; abstract;
    function put(key: aKeyType; Value: aValueType): aValueType; virtual; abstract;
    procedure putAll(m: IMap<aKeyType, aValueType>); virtual;
    function remove(key: aKeyType): aValueType; virtual;
    function size(): int32; virtual;
    function values(): ICollection<aValueType>; virtual; abstract;
  end;

  { TSimpleMapEntry }

  TSimpleMapEntry<aKeyType, aValueType> = class(TInterfacedObject,
    IMapEntry<aKeyType, aValueType>)
  protected
    fKey: aKeyType;
    fValue: aValueType;
  public
    constructor Create(aKey: aKeyType; aValue: aValueType);
    function equals(o: IMapEntry<aKeyType, aValueType>): boolean; reintroduce;
    function getKey(): aKeyType;
    function getValue(): aValueType;
    function hashCode(): THashCode;
    function setValue(aValue: aValueType): aValueType;
  end;

  TDictionary<aKeyType, aValueType> = class(TInterfacedObject)
  public
    function size(): int32; virtual; abstract;
    function isEmpty(): boolean; virtual; abstract;
    function keys(): IEnumeration<aKeyType>; virtual; abstract;
    function elements(): IEnumeration<aValueType>; virtual; abstract;
    function get(key: aKeyType): aValueType; virtual; abstract;
    function put(key: aKeyType; Value: aValueType): aValueType; virtual; abstract;
    function remove(key: aKeyType): aValueType; virtual; abstract;
  end;

  IHashtableMapEntry<aKeyType, aValueType> = interface(IMapEntry<aKeyType, aValueType>)
    function getNext: IHashtableMapEntry<aKeyType, aValueType>;
  end;

  { THashtable }

  THashtable<aKeyType, aValueType> = class(TDictionary<aKeyType,
    aValueType>, IMap<aKeyType, aValueType>)
  protected
    FRefCount: longint;
    FDestroyCount: longint;
    fMonitor: TMutex;
    fTable: array of IHashtableMapEntry<aKeyType, aValueType>;
    fCount: int32;
    fThreshold: int32;
    fLoadFactor: double;
  protected
    function QueryInterface(constref iid: tguid; out obj): longint;
    {$IFNDEF WINDOWS} cdecl{$ELSE}stdcall{$ENDIF};
    function _AddRef: longint; {$IFNDEF WINDOWS} cdecl{$ELSE}stdcall{$ENDIF};
    function _Release: longint; {$IFNDEF WINDOWS} cdecl{$ELSE}stdcall{$ENDIF};
  public
    constructor Create;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    property RefCount: longint read FRefCount;
  public
    procedure Clear(); virtual;
    function contains(aValue: aValueType): boolean; virtual;
    function containsKey(aKey: aKeyType): boolean; virtual;
    function containsValue(aValue: aValueType): boolean; virtual;
    function entrySet(): ISet<IMapEntry<aKeyType, aValueType>>; virtual; abstract;
    function equals(o: IMap<aKeyType, aValueType>): boolean; reintroduce; virtual; abstract;
    function get(key: aKeyType): aValueType; reintroduce; virtual; abstract;
    function hashCode(): THashCode; virtual; abstract;
    function isEmpty(): boolean; reintroduce; virtual; abstract;
    function keySet(): ISet<aKeyType>; virtual; abstract;
    function put(key: aKeyType; Value: aValueType): aValueType; reintroduce; virtual; abstract;
    procedure putAll(m: IMap<aKeyType, aValueType>); virtual; abstract;
    function remove(key: aKeyType): aValueType; reintroduce; virtual; abstract;
    function size(): int32; reintroduce; virtual; abstract;
    function values(): ICollection<aValueType>; virtual; abstract;
  end;


  { EException }

  EException = class(Exception)
    constructor Create(const msg: string); overload;
    constructor Create; overload;
  end;

  ENoSuchElementException = class(EException)

  end;

  EIllegalStateException = class(EException)

  end;

  EIndexOutOfBoundsException = class(EException)
  end;

function CalculateHashCode(const aValue: int8): THashCode; overload; inline;
function CalculateHashCode(const aValue: int16): THashCode; overload; inline;
function CalculateHashCode(const aValue: int32): THashCode; overload; inline;
function CalculateHashCode(const aValue: int64): THashCode; overload; inline;

function CalculateHashCode(const aValue: uint8): THashCode; overload; inline;
function CalculateHashCode(const aValue: uint16): THashCode; overload; inline;
function CalculateHashCode(const aValue: uint32): THashCode; overload; inline;
function CalculateHashCode(const aValue: uint64): THashCode; overload; inline;

function CalculateHashCode(const aValue: single): THashCode; overload; inline;
function CalculateHashCode(const aValue: double): THashCode; overload; inline;

function CalculateHashCode(const aValue: ansistring): THashCode; overload; inline;
function CalculateHashCode(const aValue: widestring): THashCode; overload; inline;
function CalculateHashCode(const aValue: utf8string): THashCode; overload; inline;

function CalculateHashCode(const aValue: TObject): THashCode; overload; inline;

function areEquals(item1, item2: int8): boolean; overload; inline;
function areEquals(item1, item2: int16): boolean; overload; inline;
function areEquals(item1, item2: int32): boolean; overload; inline;
function areEquals(item1, item2: int64): boolean; overload; inline;

function areEquals(item1, item2: uint8): boolean; overload; inline;
function areEquals(item1, item2: uint16): boolean; overload; inline;
function areEquals(item1, item2: uint32): boolean; overload; inline;
function areEquals(item1, item2: uint64): boolean; overload; inline;

function areEquals(item1, item2: single): boolean; overload; inline;
function areEquals(item1, item2: double): boolean; overload; inline;

function areEquals(item1, item2: ansistring): boolean; overload; inline;
function areEquals(item1, item2: widestring): boolean; overload; inline;
function areEquals(item1, item2: utf8string): boolean; overload; inline;

function areEquals(item1, item2: TObject): boolean; overload;

implementation

type
  { THashtableEntity }
  THashtableEntity<aKeyType, aValueType> = class(TInterfacedObject, IHashTableMapEntry<aKeyType, aValueType>)
  protected
    fHash: int64;
    fKey: aKeyType;
    fValue: aValueType;
    fNext: IHashtableMapEntry<aKeyType, aValueType>;
  public
    constructor Create(aHash: int64; aKey: aKeyType; aValue: aValueType; aNext: IHashtableMapEntry<aKeyType, aValueType>);
    function equals(o: IMapEntry<aKeyType, aValueType>): boolean; reintroduce; virtual;
    function getKey(): aKeyType; virtual;
    function hashCode(): THashCode; virtual;
    function getValue(): aValueType; virtual;
    function setValue(aValue: aValueType): aValueType; virtual;
    function getNext: IHashtableMapEntry<aKeyType, aValueType>;
  end;

function THashtable<aKeyType, aValueType>.QueryInterface(constref iid: tguid; out obj): longint;{$IFNDEF WINDOWS} cdecl{$ELSE}stdcall{$ENDIF};
begin
  if getInterface(iid, obj) then
    Result := S_OK
  else
    Result := longint(E_NOINTERFACE);
end;

function THashtable<aKeyType, aValueType>._AddRef: longint;
  {$IFNDEF WINDOWS} cdecl{$ELSE}stdcall{$ENDIF};
begin
  Result := InterlockedIncrement(FRefCount);
end;

function THashtable<aKeyType, aValueType>._Release: longint;
  {$IFNDEF WINDOWS} cdecl{$ELSE}stdcall{$ENDIF};
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
  begin
    if InterlockedIncrement(FDestroyCount) = 1 then
      self.Destroy;
  end;
end;

constructor THashtable<aKeyType, aValueType>.Create;
begin
  FMonitor := TMutex.Create();
end;

destructor THashtable<aKeyType, aValueType>.Destroy;
begin
  FRefCount := 0;
  FDestroyCount := 0;
  FreeAndNil(FMonitor);
  inherited Destroy;
end;

procedure THashtable<aKeyType, aValueType>.AfterConstruction;
begin
  InterlockedDecrement(FRefCount);
end;

procedure THashtable<aKeyType, aValueType>.BeforeDestruction;
begin
  if FRefCount <> 0 then
    raise EIllegalStateException.Create('THashtable<?,?>.BeforeDestruction');
end;

class function THashtable<aKeyType, aValueType>.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  if Result <> nil then
  begin
    THashtable<aKeyType, aValueType>(Result).FRefCount := 1;
  end;
end;

procedure THashtable<aKeyType, aValueType>.Clear();
var
  idx: integer;
begin
  FMonitor.acquire;
  for idx := Length(fTable) - 1 downto 0 do
    fTable[idx] := nil;
  fCount := 0;
  FMonitor.Release;
end;

function THashtable<aKeyType, aValueType>.contains(aValue: aValueType): boolean;
var
  i: int32;
  e: IHashtableMapEntry<aKeyType, aValueType>;
begin
  Result := False;
  FMonitor.acquire;
  if (aValue = nil) then
    raise ENullPointerException.Create();

  for i := Length(Ftable) - 1 downto 0 do
  begin
    e := fTable[i];
    while e <> nil do
    begin
      if areEquals(e.getValue(), aValue) then
        Result := True;
      e := e.getNext();
    end;
  end;
  FMonitor.Release;
end;

function THashtable<aKeyType, aValueType>.containsKey(aKey: aKeyType): boolean;
var
  hash: THashCode;
  index: int32;
  e: IHashtableMapEntry<aKeyType, aValueType>;
begin
  Result := False;
  FMonitor.acquire;
  hash := CalculateHashCode(aKey);
  index := (hash and $7FFFFFFF) mod Length(fTable);
  e := fTable[index];
  while e <> nil do
  begin
    if areEquals(e.hashCode(), hash) and areEquals(e.getKey(), aKey) then
    begin
      Result := True;
      break;
    end;
    e := e.getNext();
  end;
  FMonitor.Release;
end;

function THashtable<aKeyType, aValueType>.containsValue(aValue: aValueType): boolean;
begin
  Result := contains(aValue);
end;


{ TAbstractCollection }

function TAbstractCollection<aType>.addAll(c: ICollection<aType>): boolean;
var
  item: aType;
begin
  Result := False;
  for item in c do
    if add(item) then
      Result := True;
end;

procedure TAbstractCollection<aType>.Clear();
var
  it: IIterator<aType>;
begin
  it := iterator();
  while (it.hasNext()) do
  begin
    it.Next();
    it.remove();
  end;
end;

function TAbstractCollection<aType>.contains(o: aType): boolean;
var
  it: IIterator<aType>;
begin
  Result := False;
  it := iterator();
  while (it.hasNext()) do
    if (areEquals(o, it.Next())) then
      exit(True);
end;

function TAbstractCollection<aType>.containsAll(c: ICollection<aType>): boolean;
var
  item: aType;
begin
  Result := True;
  for item in c do
    if (not contains(item)) then
      exit(False);
end;

function TAbstractCollection<aType>.isEmpty: boolean;
begin
  Result := size = 0;
end;

function TAbstractCollection<aType>.remove(o: aType): boolean;
var
  it: IIterator<aType>;
begin
  Result := False;
  it := iterator();
  while (it.hasNext()) do
    if (areEquals(o, it.Next())) then
    begin
      it.remove();
      exit(True);
    end;
end;

function TAbstractCollection<aType>.removeAll(c: ICollection<aType>): boolean;
var
  it: IIterator<aType>;
begin
  Result := False;
  it := iterator();
  while (it.hasNext()) do
    if (c.contains(it.Next())) then
    begin
      it.remove();
      Result := True;
    end;
end;

function TAbstractCollection<aType>.retainAll(c: ICollection<aType>): boolean;
var
  it: IIterator<aType>;
begin
  Result := True;
  it := iterator();
  while (it.hasNext()) do
    if (not c.contains(it.Next())) then
    begin
      it.remove();
      Result := True;
    end;
end;

function TAbstractCollection<aType>.ToString: ansistring;
var
  it: IIterator<aType>;
  item: aType;
begin
  it := iterator();
  Result := '[';
  while it.hasNext() do
  begin
    item := it.Next();
    Result += item + ', ';
  end;
  Result += ']';
end;

function TAbstractCollection<aType>.toArray: TArray<aType>;
var
  item: aType;
  index: integer;
begin
  SetLength(Result, size());
  index := 0;
  for item in self do
  begin
    Result[index] := item;
    index += 1;
  end;
end;

{ TAbstractList }

procedure TAbstractList<aType>.enterMonitor;
begin
  EnterCriticalSection(FMonitor);
end;

procedure TAbstractList<aType>.leaveMonitor;
begin
  LeaveCriticalSection(FMonitor);
end;

constructor TAbstractList<aType>.Create;
begin
  InitCriticalSection(FMonitor);
end;

destructor TAbstractList<aType>.Destroy;
begin
  DoneCriticalSection(FMonitor);
  inherited Destroy;
end;

function TAbstractList<aType>.add(e: aType): boolean;
begin
  add(size());
  Result := True;
end;

function TAbstractList<aType>.indexOf(o: aType): int32;
var
  it: IListIterator<aType>;
begin
  Result := -1;
  it := listIterator();
  while (it.hasNext()) do
    if (areEquals(o, it.Next())) then
      exit(it.previousIndex());
end;

function TAbstractList<aType>.lastIndexOf(o: aType): int32;
var
  it: IListIterator<aType>;
begin
  Result := -1;
  it := listIterator(size());
  while it.hasPrevious() do
    if areEquals(o, it.previous()) then
      exit(it.nextIndex());
end;

{ TAbstractMap }

procedure TAbstractMap<aKeyType, aValueType>.Clear();
begin
  entrySet().Clear();
end;

function TAbstractMap<aKeyType, aValueType>.containsKey(key: aKeyType): boolean;
var
  it: IIterator<IMapEntry<aKeyType, aValueType>>;
  item: IMapEntry<aKeyType, aValueType>;
begin
  it := entrySet().iterator();
  while (it.hasNext()) do
  begin
    item := it.Next();
    if (item = nil) and areEquals(key, item.getKey()) then
    begin
      exit(True);
    end;
  end;
  Result := False;
end;

function TAbstractMap<aKeyType, aValueType>.containsValue(Value: aValueType): boolean;
var
  it: IIterator<IMapEntry<aKeyType, aValueType>>;
  item: IMapEntry<aKeyType, aValueType>;
begin
  it := entrySet().iterator();
  while (it.hasNext()) do
  begin
    item := it.Next();
    if (item = nil) or areEquals(Value, item.getValue()) then
      exit(True);
  end;
  Result := False;
end;

function TAbstractMap<aKeyType, aValueType>.get(key: aKeyType): aValueType;
var
  it: IIterator<IMapEntry<aKeyType, aValueType>>;
  item: IMapEntry<aKeyType, aValueType>;
begin
  it := entrySet().iterator();
  while (it.hasNext()) do
  begin
    item := it.Next();
    if (item <> nil) and (areEquals(item.getKey(), key)) then
      exit(item.getValue());
  end;
  raise ENoSuchElementException.Create('No such element found');
end;

function TAbstractMap<aKeyType, aValueType>.isEmpty(): boolean;
begin
  Result := size() = 0;
end;

procedure TAbstractMap<aKeyType, aValueType>.putAll(m: IMap<aKeyType, aValueType>);
var
  item: IMapEntry<aKeyType, aValueType> = nil;
begin
  for item in m.entrySet() do
  begin
    put(item.getKey(), item.getValue());
  end;
end;

function TAbstractMap<aKeyType, aValueType>.remove(key: aKeyType): aValueType;
var
  it: IIterator<IMapEntry<aKeyType, aValueType>>;
  correctEntry, item: IMapEntry<aKeyType, aValueType>;
  oldValue: aValueType;
begin
  correctEntry := nil;
  it := entrySet().iterator();
  while (correctEntry = nil) and (it.hasNext()) do
  begin
    item := it.Next();
    if (areEquals(key, item.getKey())) then
    begin
      correctEntry := item;
    end;
  end;

  if (correctEntry <> nil) then
  begin
    oldValue := correctEntry.getValue();
    it.remove();
  end;
  Result := oldValue;
end;

function TAbstractMap<aKeyType, aValueType>.size(): int32;
begin
  Result := entrySet().size();
end;

{ TSimpleMapEntry }

constructor TSimpleMapEntry<aKeyType, aValueType>.Create(aKey: aKeyType; aValue: aValueType);
begin
  fKey := akey;
  fValue := aValue;
end;

function TSimpleMapEntry<aKeyType,
aValueType>.equals(o: IMapEntry<aKeyType, aValueType>): boolean;
begin
  Result := areEquals(fKey, o.getKey()) and areEquals(fValue, o.getValue());
end;

function TSimpleMapEntry<aKeyType, aValueType>.getKey(): aKeyType;
begin
  Result := fKey;
end;

function TSimpleMapEntry<aKeyType, aValueType>.getValue(): aValueType;
begin
  Result := fValue;
end;

function TSimpleMapEntry<aKeyType, aValueType>.HashCode(): THashCode;
begin
  Result := CalculateHashCode(fKey) xor CalculateHashCode(fValue);
end;

function TSimpleMapEntry<aKeyType, aValueType>.setValue(aValue: aValueType): aValueType;
begin
  Result := fValue;
  fValue := aValue;
end;

function CalculateHashCode(const aValue: int8): THashCode;
begin
  Result := aValue;
end;

function CalculateHashCode(const aValue: int16): THashCode;
begin
  Result := aValue;
end;

function CalculateHashCode(const aValue: int32): THashCode;
begin
  Result := aValue;
end;

function CalculateHashCode(const aValue: int64): THashCode;
begin
  Result := aValue;
end;

function CalculateHashCode(const aValue: uint8): THashCode;
begin
  Result := aValue;
end;

function CalculateHashCode(const aValue: uint16): THashCode;
begin
  Result := aValue;
end;

function CalculateHashCode(const aValue: uint32): THashCode;
begin
  Result := aValue;
end;

function CalculateHashCode(const aValue: uint64): THashCode;
begin
  Result := aValue;
end;

function CalculateHashCode(const aValue: single): THashCode;
var
  r: uint16 absolute aValue;
begin
  Result := r;
end;

function CalculateHashCode(const aValue: double): THashCode;
var
  r: uint32 absolute aValue;
begin
  Result := r;
end;

function CalculateHashCode(const aValue: ansistring): THashCode;
begin
  Result := aValue.GetHashCode;
end;

function CalculateHashCode(const aValue: widestring): THashCode;
var
  p: pwidechar;
begin
  Result := 0;
  p := pwidechar(aValue);
  while p^ <> #0 do
  begin
    Result := Result + Ord(p^) * 31;
    Inc(p);
  end;
end;

function OrdChar(var p: pchar): uint64;
{
https://wiki.freepascal.org/UTF8_strings_and_characters
1 byte  : 0xxxxxxx
2 bytes : 110xxxxx 10xxxxxx                    $C0 $C0
3 bytes : 1110xxxx 10xxxxxx 10xxxxxx           $E0 $C0
4 bytes : 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx  $F0 $C0
}
var
  bufferSize: uint8;
  idx: uint8;
begin
  bufferSize := 1;
  if (Ord(p^) and $F0) = $F0 then
  begin
    bufferSize := 4;
  end
  else
  if (Ord(p^) and $E0) = $E0 then
  begin
    bufferSize := 3;
  end
  else
  if (Ord(p^) and $C0) = $C0 then
  begin
    bufferSize := 2;
  end;
  Result := 0;
  for idx := 0 to bufferSize - 1 do
  begin
    Result := Result + Ord(p^);
    Inc(p);
  end;
end;

function CalculateHashCode(const aValue: utf8string): THashCode;
var
  p: pchar;
begin
  p := PChar(aValue);
  Result := 0;
  while P^ <> #0 do
  begin
    Result := Result + OrdChar(p) * 31;
  end;
end;

function CalculateHashCode(const aValue: TObject): THashCode;
begin
  Result := uint64(aValue.GetHashCode);
end;

function areEquals(item1, item2: int8): boolean;
begin
  Result := item1 = item2;
end;

function areEquals(item1, item2: int16): boolean;
begin
  Result := item1 = item2;
end;

function areEquals(item1, item2: int32): boolean;
begin
  Result := item1 = item2;
end;

function areEquals(item1, item2: int64): boolean;
begin
  Result := item1 = item2;
end;

function areEquals(item1, item2: uint8): boolean;
begin
  Result := item1 = item2;
end;

function areEquals(item1, item2: uint16): boolean;
begin
  Result := item1 = item2;
end;

function areEquals(item1, item2: uint32): boolean;
begin
  Result := item1 = item2;
end;

function areEquals(item1, item2: uint64): boolean;
begin
  Result := item1 = item2;
end;

function areEquals(item1, item2: single): boolean;
begin
  Result := item1 = item2;
end;

function areEquals(item1, item2: double): boolean;
begin
  Result := item1 = item2;
end;

function areEquals(item1, item2: ansistring): boolean;
begin
  Result := item1 = item2;
end;

function areEquals(item1, item2: widestring): boolean;
begin
  Result := item1 = item2;
end;

function areEquals(item1, item2: utf8string): boolean;
begin
  Result := item1 = item2;
end;

function areEquals(item1, item2: TObject): boolean;
begin
  if (item1 = nil) and (item2 = nil) then
    exit(True);
  if (item1 <> nil) and (item2 = nil) then
    exit(False);
  if (item1 = nil) and (item2 <> nil) then
    exit(False);
  Result := item1.Equals(item2);
end;

{ TAbstractSet }

function TAbstractSet<aType>.removeAll(c: ICollection<aType>): boolean;
var
  it: IIterator<aType>;
begin
  Result := False;
  if (size() > c.size()) then
  begin
    it := c.iterator();
    while it.hasNext() do
    begin
      Result := Result or remove(it.Next());
    end;
  end
  else
  begin
    it := iterator();
    while it.hasNext() do
    begin
      if c.contains(it.Next()) then
      begin
        it.remove();
        Result := True;
      end;
    end;
  end;
end;

function TAbstractSet<aType>.hashCode(): THashCode;
var
  it: IIterator<aType>;
  item: aType;
begin
  Result := 0;
  it := iterator();
  while (it.hasNext()) do
  begin
    item := it.Next();
    Result += CalculateHashCode(item);
  end;
end;

{ TAbstractQueue }

function TAbstractQueue<aType>.add(e: aType): boolean;
begin
  Result := False;
  if (offer(e)) then
    Result := True;
end;

function TAbstractQueue<aType>.addAll(c: ICollection<aType>): boolean;
var
  e: aType;
begin
  Result := False;
  for e in c do
    if add(e) then
      Result := True;
end;

function TAbstractQueue<aType>.remove: aType;
begin
  Result := poll();
end;

function TAbstractQueue<aType>.element(): aType;
begin
  Result := peek;
end;

procedure TAbstractQueue<aType>.Clear;
begin
  while size() > 0 do
  begin
    poll();
  end;
end;

{ TAbstractSequentialList }

function TAbstractSequentialList<aType>.getItem(index: int32): aType;
begin
  Result := listIterator(index).Next;
end;

function TAbstractSequentialList<aType>.setItem(index: int32; item: aType): aType;
var
  it: IListIterator<aTYpe>;
begin
  try
    it := listIterator(index);
    Result := it.Next();
    it.setItem(item);
  except
    on e: ENoSuchElementException do
      raise EIndexOutOfBoundsException.CreateFmt('Index: %d', [index]);
  end;
end;

procedure TAbstractSequentialList<aType>.add(index: int32; element: aType);
begin
  listIterator(index).add(element);
end;

function TAbstractSequentialList<aType>.addAll(index: int32; c: ICollection<aType>): boolean;
var
  it1: IListIterator<aType>;
  it2: IIterator<aType>;
begin
  Result := False;
  it1 := listIterator(index);
  it2 := c.iterator();
  while (it2.hasNext()) do
  begin
    it1.add(it2.Next());
    Result := True;
  end;
end;

function TAbstractSequentialList<aType>.remove(index: int32): aType;
var
  it: IListIterator<aType>;
begin
  it := listIterator(index);
  Result := it.Next();
  it.remove();
end;

function TAbstractSequentialList<aType>.iterator: IIterator<aType>;
begin
  Result := listIterator();
end;

{ THashtableEntity }


constructor THashtableEntity<aKeyType, aValueType>.Create(aHash: int64; aKey: aKeyType; aValue: aValueType; aNext: IHashtableMapEntry<aKeyType, aValueType>);
begin
  fHash := aHash;
  fKey := aKey;
  fValue := aValue;
  fNext := aNext;
end;

function THashtableEntity<aKeyType,
aValueType>.equals(o: IMapEntry<aKeyType, aValueType>): boolean;
begin

end;

function THashtableEntity<aKeyType, aValueType>.getKey(): aKeyType;
begin
  Result := fKey;
end;

function THashtableEntity<aKeyType, aValueType>.getValue(): aValueType;
begin
  Result := fValue;
end;

function THashtableEntity<aKeyType, aValueType>.hashCode(): THashCode;
begin
  Result := fHash;
end;

function THashtableEntity<aKeyType, aValueType>.setValue(aValue: aValueType): aValueType;
begin
  Result := FValue;
  fValue := aValue;
end;

function THashtableEntity<aKeyType, aValueType>.getNext: IHashtableMapEntry<aKeyType, aValueType>;
begin
  Result := fNext;
end;

{ EException }

constructor EException.Create(const msg: string);
begin
  inherited Create(msg);
end;

constructor EException.Create;
begin
  Create('');
end;


end.
