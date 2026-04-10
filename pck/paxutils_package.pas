{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit paxutils_package;

{$warn 5023 off : no warning about unused units}
interface

uses
  pax.utils,
  pax.utils.colors,
  pax.utils.containers,
  pax.utils.calandars,
  LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('paxutils_package', @Register);
end.
