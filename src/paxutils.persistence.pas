unit paxutils.persistence;

{$mode objfpc}{$H+}
{$M+}
{$ModeSwitch typehelpers}
{$ModeSwitch advancedrecords}
{$modeswitch prefixedattributes}
{$define custom_attributes}

interface

uses
  Classes, SysUtils, Rtti;
type
  { Entity }

  Entity = class(TCustomAttribute)
    constructor Create;
  end;

  { Table }

  Table = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(aName: string);
  published
    property Name: string read FName;
  end;

  Id = class(TCustomAttribute)

  end;

  { Column }

  Column = class(TCustomAttribute)
  private
    FDefaultValue: string;
    FLength: int32;
    FName: string;
    FNullable: boolean;
    FSQLTypeName: string;
  public
    constructor Create(aName: string); overload;
    constructor Create(aName: string; aColumnLength: int32); overload;
    constructor Create(aName: string; aSQLTypeName: string); overload;
    constructor Create(aName: string; aNullable: boolean); overload;
    constructor Create(aName: string; aColumnLength: int32; aSQLTypeName: string); overload;
    constructor Create(aName: string; aColumnLength: int32; aSQLTypeName: string; aNullable: boolean); overload;
  published
    property Name: string read FName;
    property Length: int32 read FLength;
    property nullable: boolean read FNullable;
    property SQLTypeName: string read FSQLTypeName;
    property defaultValue: string read FDefaultValue;
  end;

  PrimaryKey = class(TCustomAttribute)

  end;

  { ForeingKey }

  ForeingKey = class(TCustomAttribute)
  private
    FReferenceColumn: string;
    FReferenceEntity: string;
    procedure SetreferenceColumn(AValue: string);
    procedure SetreferenceEntity(AValue: string);
  published
    constructor Create(aReferenceEntity: string; aReferenceColumn: string); overload;
    property referenceEntity: string read FreferenceEntity write SetreferenceEntity;
    property referenceColumn: string read FreferenceColumn write SetreferenceColumn;
  end;

  { UniqueConstraint }

  UniqueConstraint = class(TCustomAttribute)
  private
    FColumnNames: TStringArray;
    FName: string;
    procedure SetColumnNames(AValue: TStringArray);
    procedure SetName(AValue: string);
  public
    constructor Create(aColumnNames: TStringArray; aName: string = ''); overload;
  published
    property Name: string read FName write SetName;
    property ColumnNames: TStringArray read FColumnNames write SetColumnNames;
  end;

  { Index }

  Index = class(TCustomAttribute)
  private
    FColumnList: string;
    FName: string;
    FUnique: boolean;
    procedure SetColumnList(AValue: string);
    procedure SetName(AValue: string);
    procedure SetUnique(AValue: boolean);
  public
    constructor Create(aName: string; aColumnList: string = ''; aUnique: boolean = False); overload;
  published
    property ColumnList: string read FColumnList write SetColumnList;
    property Name: string read FName write SetName;
    property Unique: boolean read FUnique write SetUnique default False;
  end;

  { SequenceGenerator }

  SequenceGenerator = class(TCustomAttribute)
  private
    FAllocationSize: integer;
    FCatalog: string;
    FInitialValue: integer;
    FName: string;
    FSchema: string;
    FSequenceName: string;
    procedure SetAllocationSize(AValue: integer);
    procedure SetCatalog(AValue: string);
    procedure SetInitialValue(AValue: integer);
    procedure SetName(AValue: string);
    procedure SetSchema(AValue: string);
    procedure SetSequenceName(AValue: string);
  public
    constructor Create(aName: string; aSequenceName: string = ''; aCatalog: string = ''; aSchema: string = ''; aInitialValue: integer = 1; aAllocationSize: integer = 50); overload;
  published
    property AllocationSize: integer read FAllocationSize write SetAllocationSize default 50;
    property Catalog: string read FCatalog write SetCatalog;
    property InitialValue: integer read FInitialValue write SetInitialValue default 1;
    property Name: string read FName write SetName;
    property Schema: string read FSchema write SetSchema;
    property SequenceName: string read FSequenceName write SetSequenceName;
  end;

  { PersistenceUnit }

  PersistenceUnit = class(TCustomAttribute)
  private
    FName: string;
    procedure SetName(AValue: string);
  public
    property Name: string read FName write SetName;
  end;

  {$EndIf}


implementation

type
  TConnectionConfiguration = class

  end;

  {$IfDef custom_attributes}


  { PersistenceUnit }

procedure PersistenceUnit.SetName(AValue: string);
begin
  if FName = AValue then Exit;
  FName := AValue;
end;

{ SequenceGenerator }

procedure SequenceGenerator.SetAllocationSize(AValue: integer);
begin
  if FAllocationSize = AValue then Exit;
  FAllocationSize := AValue;
end;

procedure SequenceGenerator.SetCatalog(AValue: string);
begin
  if FCatalog = AValue then Exit;
  FCatalog := AValue;
end;

procedure SequenceGenerator.SetInitialValue(AValue: integer);
begin
  if FInitialValue = AValue then Exit;
  FinitialValue := AValue;
end;

procedure SequenceGenerator.SetName(AValue: string);
begin
  if FName = AValue then Exit;
  FName := AValue;
end;

procedure SequenceGenerator.SetSchema(AValue: string);
begin
  if FSchema = AValue then Exit;
  FSchema := AValue;
end;

procedure SequenceGenerator.SetSequenceName(AValue: string);
begin
  if FSequenceName = AValue then Exit;
  FSequenceName := AValue;
end;

constructor SequenceGenerator.Create(aName: string; aSequenceName: string; aCatalog: string; aSchema: string; aInitialValue: integer; aAllocationSize: integer);
begin
  FAllocationSize := aAllocationSize;
  FCatalog := aCatalog;
  FInitialValue := aInitialValue;
  FName := aName;
  FSchema := aSchema;
  FSequenceName := aSequenceName;
end;

{ UniqueConstraint }

procedure UniqueConstraint.SetColumnNames(AValue: TStringArray);
begin
  if FColumnNames = AValue then Exit;
  FColumnNames := AValue;
end;

procedure UniqueConstraint.SetName(AValue: string);
begin
  if FName = AValue then Exit;
  FName := AValue;
end;

constructor UniqueConstraint.Create(aColumnNames: TStringArray; aName: string);
begin
  FName := aName;
  FColumnNames := aColumnNames;
end;

{ Index }

procedure Index.SetColumnList(AValue: string);
begin
  if FColumnList = AValue then Exit;
  FColumnList := AValue;
end;

procedure Index.SetName(AValue: string);
begin
  if FName = AValue then Exit;
  FName := AValue;
end;

procedure Index.SetUnique(AValue: boolean);
begin
  if FUnique = AValue then Exit;
  FUnique := AValue;
end;

constructor Index.Create(aName, aColumnList: string; aUnique: boolean);
begin
  FName := aName;
  FColumnList := aColumnList;
  FUnique := aUnique;
end;

{ Entity }

constructor Entity.Create;
begin

end;


{ Table }

constructor Table.Create(aName: string);
begin
  fName := aName;
end;

{ Column }

constructor Column.Create(aName: string);
begin
  Create(aName, -1, '', True);
end;

constructor Column.Create(aName: string; aColumnLength: int32);
begin
  Create(aName, aColumnLength, '', True);
end;

constructor Column.Create(aName: string; aSQLTypeName: string);
begin
  Create(aName, -1, aSQLTypeName, True);
end;

constructor Column.Create(aName: string; aNullable: boolean);
begin
  Create(aName, -1, '', aNullable);
end;

constructor Column.Create(aName: string; aColumnLength: int32; aSQLTypeName: string);
begin
  Create(aName, aColumnLength, aSQLTypeName, True);
end;

constructor Column.Create(aName: string; aColumnLength: int32; aSQLTypeName: string; aNullable: boolean);
begin
  FName := aName;
  FLength := aColumnLength;
  FNullable := aNullable;
  FSQLTypeName := aSQLTypeName;
end;

{ ForeingKey }

procedure ForeingKey.SetreferenceColumn(AValue: string);
begin
  if FreferenceColumn = AValue then Exit;
  FreferenceColumn := AValue;
end;

procedure ForeingKey.SetreferenceEntity(AValue: string);
begin
  if FreferenceEntity = AValue then Exit;
  FreferenceEntity := AValue;
end;

constructor ForeingKey.Create(aReferenceEntity: string; aReferenceColumn: string);
begin
  FReferenceColumn := aReferenceColumn;
  FReferenceEntity := aReferenceEntity;
end;

{$EndIf}

end.
