library info;

 {$mode objfpc} {$H+}

uses
  SysUtils;


// The DLL subroutine
  function funStringBack(strIn: string): PChar;
  begin
    funStringBack := PChar(UpperCase(strIn));
  end;


  // Exported subroutine(s)
exports
  funStringBack;

begin
end.
