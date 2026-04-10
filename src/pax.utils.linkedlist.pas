unit pax.utils.linkedlist;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, paxutils.containers;

type
  { TLinkedList }

  TLinkedList<aType> = class(TAbstractSequentialList<aType>, IList<aType>)
  protected
  type
    { TEntry }

    TEntry = class
    public
      Element: aType;
      Next: TEntry;
      Previous: TEntry;

      constructor Create(aPrev: TEntry; aElement: aType; aNext: TEntry);
      destructor Destroy; override;
    end;

  protected
    fSize: int32;
    fHeader: TEntry;
  protected
    function addBefore(aItem: aType; entry: TEntry): TEntry;
    function remove(entry: TEntry): TEntry;
  public
    constructor Create; override; overload;
    constructor Create(c: ICollection<aType>); virtual; overload;
    function getFirst: aType;
    function getLast: aType;
    function removeFirst: aType;
    function removeLast: aType;
    procedure addFirst(a: aType);
    procedure addLast(a: aType);
    function contains(o: aType): boolean; override;
    function size: integer; override;
  end;

implementation

{ TLinkedList<aType>.TNode }

constructor TLinkedList<aType>.TEntry.Create(aPrev: TEntry; aElement: aType; aNext: TEntry);
begin
  Element := aElement;
  Next := aNext;
  Previous := aPrev;
end;

destructor TLinkedList<aType>.TEntry.Destroy;
begin
  inherited Destroy;
end;

{ TLinkedList }

function TLinkedList<aType>.addBefore(aItem: aType; entry: TEntry): TEntry;
begin
  Result := TEntry.Create(aItem, entry, entry.previous);
  Result.previous.Next := Result;
  Result.Next.previous := Result;
  Inc(FSize);
end;

function TLinkedList<aType>.remove(entry: TEntry): TEntry;
begin
  if (entry = Fheader) then
    raise ENoSuchElementException.Create();

  Result := entry.element;
  entry.previous.Next := entry.Next;
  entry.Next.previous := entry.previous;
  entry.previous := nil;
  entry.Next := nil;
  entry.element := nil;
  Dec(FSize);
end;

constructor TLinkedList<aType>.Create;
begin
  inherited Create;
  fSize := 0;
  fHeader := TEntry.Create(nil, nil, nil);
  fHeader.Next := fHeader;
  fHeader.Previous := fHeader;
end;

constructor TLinkedList<aType>.Create(c: ICollection<aType>);
begin
  Create();
  addAll(c);
end;

function TLinkedList<aType>.getFirst: aType;
begin
  if (fSize = 0) then
    raise ENoSuchElementException.Create();
  Result := FHeader.Next.element;
end;

function TLinkedList<aType>.getLast: aType;
begin
  if (fSize = 0) then
    raise ENoSuchElementException.Create();

  Result := fHeader.previous.element;
end;

function TLinkedList<aType>.removeFirst: aType;
begin
  Result := remove(fHeader.Next);
end;

function TLinkedList<aType>.removeLast: aType;
begin
  Result := remove(fHeader.Next);
end;

procedure TLinkedList<aType>.addFirst(a: aType);
begin
  addBefore(a, fHeader.Next);
end;

procedure TLinkedList<aType>.addLast(a: aType);
begin
  addBefore(a, fHeader);
end;

function TLinkedList<aType>.contains(o: aType): boolean;
begin
  Result := indexOf(o) > -1;
end;

function TLinkedList<aType>.size: integer;
begin
  Result := fSize;
end;

end.
