{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit paxutils_package;

{$warn 5023 off : no warning about unused units}
interface

uses
  paxutils, paxutils.designpatterns, paxutils.chartjs.org, paxutils.batch, 
  paxutils.persistence, paxutils.persistence.engines, paxutils.xml.dom3, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('paxutils_package', @Register);
end.
