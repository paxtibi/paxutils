unit paxutils.designpatterns;

{$mode delphi}{$H+}
{$M+}
{$ModeSwitch typehelpers}
{$ModeSwitch advancedrecords}
interface

uses
  Classes, SysUtils;

type
  { TSingleton }

  TSingleton<T: TObject> = record
  strict private
  type TSingletonType = record
    private
    class var
      fInstance: T;
    end;
  class var
    fCriticalSection: TRTLCriticalSection;
  class var
    fSingleton: TSingletonType;
  public
    class constructor Create;
    class destructor Destroy;
    class function GetInstance: T; static;
  end;

  { IIterator }

  IIterator<T> = interface(IInterface)
    function GetCurrent: T;
    function MoveNext: boolean;
    procedure Reset;
    property Current: T read GetCurrent;
  end;

  IClonable = interface
    ['{9138B4C5-3D13-466E-92B5-896A7DFEEE80}']
    function clone: IClonable;
  end;

  { TPropertyLink }

  TPropertyLink = class(TComponent)
  private
    FInstance: TObject;
    FPropertyName: string;
    function getPropertyKind: TTypeKind;
    procedure SetInstance(AValue: TObject);
    procedure SetPropertyName(AValue: string);
  public
    procedure Notify(Sender: TObject);
  published
    property Instance: TObject read FInstance write SetInstance;
    property PropertyName: string read FPropertyName write SetPropertyName;
    property Kind: TTypeKind read getPropertyKind;
  end;

  { TPropertyMediator }

  TPropertyMediator = class(TComponent)
  private
    FModel: TPropertyLink;
    FView: TPropertyLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Model: TPropertyLink read FModel;
    property View: TPropertyLink read FView;
  end;

implementation

uses
  typinfo, paxutils;

  { TSingleton }

class constructor TSingleton<T>.Create;
begin
  InitCriticalSection(fCriticalSection);
end;

class destructor TSingleton<T>.Destroy;
begin
  DoneCriticalSection(fCriticalSection);
end;

class function TSingleton<T>.GetInstance: T;
begin
  if not Assigned(fSingleton.fInstance) then
  begin
    EnterCriticalSection(fCriticalSection);
    try
      if not Assigned(fSingleton.fInstance) then
        fSingleton.fInstance := T.Create;
    finally
      LeaveCriticalSection(fCriticalSection);
    end;
  end;
  Result := fSingleton.fInstance;
end;

{ TPropertyLink }

procedure TPropertyLink.SetInstance(AValue: TObject);
begin
  if FInstance = AValue then Exit;
  FInstance := AValue;
end;

function TPropertyLink.getPropertyKind: TTypeKind;
var
  propertyInfo: PPropInfo;
begin
  Result := tkUnknown;
  if FInstance <> nil then
  begin
    propertyInfo := GetPropInfo(FInstance, FPropertyName, tkProperties);
    if assigned(propertyInfo) then
    begin
      Result := propertyInfo^.PropType^.Kind;
    end
    else
    begin
      raise EIllegalStateException.Create('Tipo dato non riconosciuto! Controllare il nome/visibilità della property :' + FInstance.ClassName + '.' + FPropertyName);
    end;
  end;
end;

procedure TPropertyLink.SetPropertyName(AValue: string);
begin
  if FPropertyName = AValue then Exit;
  FPropertyName := AValue;
end;

procedure TPropertyLink.Notify(Sender: TObject);
begin

end;

{ TPropertyMediator }

constructor TPropertyMediator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FModel := TPropertyLink.Create(self);
  FView := TPropertyLink.Create(self);
end;

destructor TPropertyMediator.Destroy;
begin
  inherited Destroy;
end;

end.
