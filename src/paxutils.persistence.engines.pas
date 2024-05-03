unit paxutils.persistence.engines;

{$mode objfpc}{$H+}
{$M+}
{$ModeSwitch typehelpers}
{$ModeSwitch advancedrecords}
{$if FPC_FULLVERSION >= 30301 }
{$ModeSwitch prefixedattributes}
{$define CUSTOM_ATTRIBUTES}
{$endif}

interface

uses
  Classes, SysUtils,
  paxutils.persistence,
  db;

type
  IPersistenceEngine = interface
    ['{7C95E0D7-446B-450A-9E12-C25E40002D20}']
  end;


{$ifdef CUSTOM_ATTRIBUTES}
{$endif}

implementation

{$ifdef CUSTOM_ATTRIBUTES}
{$endif}

end.
