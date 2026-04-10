unit pax.utils.arraylist;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, paxutils.containers;

type
  { TArrayList }

  TArrayList<aType> = class(TAbstractList<aType>)
  private
  const
    MAX_ARRAY_SIZE = integer.MaxValue - 8;
  type
    TArrayOfType = array of aType;
  private
    FElementData: TArrayOfType;
    FSize: int32;
  private
    class function hugeCapacity(minCapacity: int32): int32;
    function batchRemove(c: ICollection<aType>; complement: boolean): boolean;
    function outOfBoundsMsg(index: int32): string;
    procedure ensureCapacityInternal(minCapacity: int32);
    procedure fastRemove(index: int32);
    procedure grow(minCapacity: int32);
    procedure rangeCheck(index: int32);
    procedure rangeCheckForAdd(index: int32);
  protected
    function elementData(index: int32): aType;
    procedure removeRange(fromIndex, toIndex: int32);
  public
    constructor Create(); override; overload;
    constructor Create(c: ICollection<aType>); overload;
    constructor Create(initialCapacity: uint32); overload;
    function add(e: aType): boolean; override;
    function addAll(c: ICollection<aType>): boolean; overload; override;
    function addAll(index: int32; c: ICollection<aType>): boolean; overload; override;
    function contains(o: aType): boolean; override;
    function getItem(index: int32): aType; override;
    function indexOf(o: aType): int32; override;
    function isEmpty(): boolean; override;
    function iterator(): IIterator<aType>; override;
    function lastIndexOf(o: aType): int32; override;
    function listIterator(): IListIterator<aType>; override;
    function listIterator(index: int32): IListIterator<aType>; override;
    function remove(index: int32): aType; override;
    function remove(o: aType): boolean; override;
    function removeAll(c: ICollection<aType>): boolean; override;
    function retainAll(c: ICollection<aType>): boolean; override;
    function setItem(index: int32; element: aType): aType; virtual;
    function size(): int32; override;
    procedure add(index: int32; element: aType); override;
    procedure Clear(); override;
    procedure ensureCapacity(minCapacity: int32); virtual;
    procedure trimToSize(); virtual;

    property items[index: int32]: AType read getItem write setItem; default;
  end;


type
  { TIterator }

  TIterator<aType> = class(TInterfacedObject, IIterator<aType>)
  protected
    fCursor: int32;       // index of next element to return
    fLastRet: int32; // index of last element returned; -1 if no such
    fTarghet: TArrayList<aType>;
  public
    constructor Create(aTarget: TArrayList<aType>);
    function hasNext(): boolean;
    function Next(): aType;
    procedure remove();
  end;

  { TListIterator }

  TListIterator<aType> = class(TIterator<aType>, IListIterator<aType>)
  public
    constructor Create(index: int32; aTarget: TArrayList<aType>); reintroduce;
    procedure add(e: aType);
    function hasPrevious(): boolean;
    function nextIndex(): int32;
    function previous(): aType;
    function previousIndex(): int32;
    procedure setItem(e: aType);
  end;

implementation

{ TArrayList }

class function TArrayList<aType>.hugeCapacity(minCapacity: int32): int32;
begin
  if (minCapacity > MAX_ARRAY_SIZE) then
    Result := integer.MaxValue
  else
    Result := MAX_ARRAY_SIZE;
end;

function TArrayList<aType>.batchRemove(c: ICollection<aType>; complement: boolean): boolean;
var
  r: int32 = 0;
  w: int32 = 0;
  i: integer;
begin
  Result := False;
  try
    while r < FSize do
    begin
      if (c.contains(FElementData[r]) = complement) then
      begin
        enterMonitor;
        FElementData[w] := FElementData[r];
        leaveMonitor;
        Inc(w);
      end;
      Inc(r);
    end;
  finally
    if (r <> FSize) then
    begin
      enterMonitor;
      Move(FElementData[r], FElementData[w], FSize - r);
      leaveMonitor;
      w += FSize - r;
    end;
    if (w <> FSize) then
    begin
      FSize := w;
      Result := True;
    end;
  end;
end;

function TArrayList<aType>.outOfBoundsMsg(index: int32): string;
begin
  Result := Format('Index: %d, Size: %d', [index, size]);
end;

procedure TArrayList<aType>.ensureCapacityInternal(minCapacity: int32);
begin
  if (minCapacity - Length(FElementData) > 0) then
    grow(minCapacity);
end;

procedure TArrayList<aType>.fastRemove(index: int32);
var
  numMoved: integer;
begin
  numMoved := FSize - index - 1;
  if (numMoved > 0) then
  begin
    enterMonitor;
    Move(FElementData[index + 1], FElementData[index], numMoved);
    leaveMonitor;
  end;
  FSize -= 1;
end;

procedure TArrayList<aType>.grow(minCapacity: int32);
var
  oldCapacity, newCapacity: integer;
begin
  oldCapacity := Length(FElementData);
  newCapacity := oldCapacity + (oldCapacity shr 1);
  if (newCapacity - minCapacity < 0) then
    newCapacity := minCapacity;
  if (newCapacity - MAX_ARRAY_SIZE > 0) then
    newCapacity := hugeCapacity(minCapacity);
  enterMonitor;
  SetLength(FElementData, newCapacity);
  leaveMonitor;
end;

procedure TArrayList<aType>.rangeCheck(index: int32);
begin
  if (index >= FSize) then
    raise EIndexOutOfBoundsException.Create(outOfBoundsMsg(index));
end;

procedure TArrayList<aType>.rangeCheckForAdd(index: int32);
begin
  if (index > FSize) or (index < 0) then
    raise EIndexOutOfBoundsException.Create(outOfBoundsMsg(index));
end;

function TArrayList<aType>.elementData(index: int32): aType;
begin
  Result := FElementData[index];
end;

procedure TArrayList<aType>.removeRange(fromIndex, toIndex: int32);
var
  numMoved, newSize: int32;
begin
  numMoved := FSize - toIndex;
  enterMonitor;
  Move(FElementData[toIndex], FElementData[fromIndex], numMoved);
  leaveMonitor;
  newSize := FSize - (toIndex - fromIndex);
  FSize := size;
end;

constructor TArrayList<aType>.Create();
begin
  Create(10);
end;

constructor TArrayList<aType>.Create(c: ICollection<aType>);
begin
  FElementData := c.toArray();
  FSize := length(FElementData);
end;

constructor TArrayList<aType>.Create(initialCapacity: uint32);
begin
  inherited Create;
  SetLength(FElementData, initialCapacity);
  fSize := 0;
end;

function TArrayList<aType>.add(e: aType): boolean;
begin
  enterMonitor;
  ensureCapacityInternal(size + 1);
  FElementData[FSize] := e;
  Inc(FSize);
  leaveMonitor;
  Result := True;
end;

function TArrayList<aType>.addAll(c: ICollection<aType>): boolean;
var
  numNew: int32;
  a: TArrayOfType;
begin
  a := c.toArray;
  numNew := length(a);
  enterMonitor;
  ensureCapacityInternal(size + numNew);
  move(a[0], FElementData[size], numNew);
  FSize += numNew;
  leaveMonitor;
  Result := numNew <> 0;
end;

function TArrayList<aType>.addAll(index: int32; c: ICollection<aType>): boolean;
var
  numNew, numMoved: int32;
  a: TArrayOfType;
begin
  rangeCheckForAdd(index);

  a := c.toArray();
  numNew := length(a);
  numMoved := FSize - index;
  enterMonitor;
  ensureCapacityInternal(FSize + numNew);
  if (numMoved > 0) then
    move(FElementData[index], FElementData[index + numNew], numMoved);
  move(a[0], FElementData[index], numNew);
  fSize += numNew;
  leaveMonitor;
  Result := numNew <> 0;
end;

function TArrayList<aType>.contains(o: aType): boolean;
begin
  Result := indexOf(o) >= 0;
end;

function TArrayList<aType>.getItem(index: int32): aType;
begin
  rangeCheck(index);
  enterMonitor;
  Result := FElementData[index];
  leaveMonitor;
end;

function TArrayList<aType>.indexOf(o: aType): int32;
var
  idx: integer;
begin
  Result := -1;
  for idx := 0 to size - 1 do
    if (areEquals(o, FElementData[idx])) then
      exit(idx);
end;

function TArrayList<aType>.isEmpty(): boolean;
begin
  Result := size() = 0;
end;

function TArrayList<aType>.iterator(): IIterator<aType>;
begin
  Result := IIterator<aType>(TIterator<aType>.Create(self));
end;

function TArrayList<aType>.lastIndexOf(o: aType): int32;
var
  idx: integer;
begin
  Result := -1;
  for idx := FSize - 1 downto 0 do
    if (areEquals(o, FElementData[idx])) then
      exit(idx);
end;

function TArrayList<aType>.listIterator(): IListIterator<aType>;
begin
  Result := listIterator(0);
end;

function TArrayList<aType>.listIterator(index: int32): IListIterator<aType>;
begin
  Result := TListIterator<aType>.Create(index, self);
end;

function TArrayList<aType>.remove(index: int32): aType;
var
  numMoved: int32;
begin
  rangeCheck(index);
  Result := FElementData[index];
  numMoved := FSize - index - 1;
  enterMonitor;
  if (numMoved > 0) then
    Move(FElementData[index + 1], FElementData[index], numMoved);
  FillByte(FElementData[FSize], SizeOf(AType), 0);
  leaveMonitor;
end;

function TArrayList<aType>.remove(o: aType): boolean;
var
  index: int32;
begin
  Result := False;
  for index := 0 to FSize - 1 do
  begin
    if (areEquals(o, FElementData[index])) then
    begin
      fastRemove(index);
      exit(True);
    end;
  end;
end;

function TArrayList<aType>.removeAll(c: ICollection<aType>): boolean;
begin
  Result := batchRemove(c, False);
end;

function TArrayList<aType>.retainAll(c: ICollection<aType>): boolean;
begin
  Result := batchRemove(c, True);
end;

function TArrayList<aType>.setItem(index: int32; element: aType): aType;
begin
  rangeCheck(index);
  enterMonitor;
  Result := elementData(index);
  FElementData[index] := element;
  leaveMonitor;
end;

function TArrayList<aType>.size(): int32;
begin
  Result := FSize;
end;

procedure TArrayList<aType>.add(index: int32; element: aType);
begin
  rangeCheckForAdd(index);
  enterMonitor;
  ensureCapacityInternal(FSize + 1);
  Move(FElementData[index], FElementData[index + 1], FSize - index);
  FElementData[index] := element;
  FSize += 1;
  leaveMonitor;
end;

procedure TArrayList<aType>.Clear();
var
  Value: integer;
begin
  Value := Length(FElementData);
  enterMonitor;
  SetLength(FElementData, 0);
  SetLength(FElementData, Value);
  leaveMonitor;
  FSize := 0;
end;

procedure TArrayList<aType>.ensureCapacity(minCapacity: int32);
begin
  if (minCapacity > 0) then
    ensureCapacityInternal(minCapacity);
end;

procedure TArrayList<aType>.trimToSize();
var
  oldCapacity: int32;
begin
  oldCapacity := Length(FElementData);
  if (size < oldCapacity) then
  begin
    enterMonitor;
    SetLength(FElementData, FSize);
    leaveMonitor;
  end;
end;


{ TIterator }

constructor TIterator<aType>.Create(aTarget: TArrayList<aType>);
begin
  fTarghet := aTarget;
  fLastRet := -1;
  fCursor := 0;
end;

function TIterator<aType>.hasNext(): boolean;
begin
  Result := fCursor <> fTarghet.Size;
end;

function TIterator<aType>.Next(): aType;
var
  i: int32;
begin
  i := fCursor;
  if (i >= fTarghet.size()) then
    raise ENoSuchElementException.Create('');

  FCursor := i + 1;
  Result := fTarghet[fLastRet];
  fLastRet := i;
end;

procedure TIterator<aType>.remove();
begin
  if (FLastRet < 0) then
    raise EIllegalStateException.Create('');

  fTarghet.remove(aType(FLastRet));
  FCursor := FlastRet;
  FlastRet := -1;
end;

{ TListIterator }

constructor TListIterator<aType>.Create(index: int32; aTarget: TArrayList<aType>);
begin
  inherited Create(aTarget);
  fCursor := index;
end;

procedure TListIterator<aType>.add(e: aType);
begin
  fTarghet.add(fCursor, e);
  fCursor += 1;
  fLastRet := -1;
end;

function TListIterator<aType>.hasPrevious(): boolean;
begin
  Result := FCursor > 0;
end;

function TListIterator<aType>.nextIndex(): int32;
begin
  Result := fCursor;
end;

function TListIterator<aType>.previous(): aType;
begin
  Dec(fCursor);
  Result := fTarghet.getItem(fCursor);
end;

function TListIterator<aType>.previousIndex(): int32;
begin
  Result := fCursor + 1;
end;

procedure TListIterator<aType>.setItem(e: aType);
begin
  if (FlastRet < 0) then
    raise EIllegalStateException.Create();
  fTarghet[fLastRet] := e;
end;

end.
