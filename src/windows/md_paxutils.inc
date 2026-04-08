const
  _has_calculated_offset: boolean = False;
  Unix_Epoch: TSYSTEMTIME = (wYear: 1970; wMonth: 1; wDayOfWeek: 0; wDay: 1; wHour: 0; wMinute: 0; wSecond: 0; wMilliseconds: 0);

var
  _calculated_offset: uint64;


function jlong_from(h, l: uint32): uint64;
var
  tmp: Int64Rec;
begin
  tmp.Hi := h;
  tmp.Lo := l;
  Result := uint64(tmp);
  Result := Result div 10000;
end;

function windows_to_java_time(wt: TFILETIME): uint64;
var
  a: uint64;
begin
  a := jlong_from(wt.dwHighDateTime, wt.dwLowDateTime);
  Result := (a - _calculated_offset);
end;

function TOS.currentTimeMillis: uint64;
var
  wt: TFILETIME;
begin
  GetSystemTimeAsFileTime(wt);
  Result := windows_to_java_time(wt);
end;


const
  PROPSIZE = 9;      // eight-letter + null terminator
  SNAMESIZE = 86;    // max number of chars for LOCALE_SNAME is 85
  LOCALE_ENUMPROC = $0000005c;

function SetupI18nProps(lcid: LCID; var locale: TLocale): boolean;
var
  tmp: array[0..SNAMESIZE - 1] of char;
  s: string;
begin
  Result := True;
  FillChar(tmp[0], SNAMESIZE, #0);
  if (GetLocaleInfo(lcid, LOCALE_ENUMPROC, @tmp, SNAMESIZE) > 0) then
  begin
    s := tmp;
  end;
end;

function TOS.getUserLocale: TLocale;
var
  userDefaultLCID, userDefaultUILCID: LCID;
  userDefaultUILang: LANGID;
  hStdHandle: HANDLE;
begin
  userDefaultLCID := Windows.GetUserDefaultLCID();
  userDefaultUILang := Windows.GetUserDefaultLangID();
  userDefaultUILCID := MAKELCID(userDefaultUILang, SORTIDFROMLCID(userDefaultLCID));

  if (PRIMARYLANGID(LANGIDFROMLCID(userDefaultLCID)) = PRIMARYLANGID(userDefaultUILang)) then
  begin
    userDefaultUILCID := userDefaultLCID;
  end;

  SetupI18nProps(userDefaultLCID, Result);
  SetupI18nProps(userDefaultUILCID, Result);
end;

procedure TOS.init;
var
  jot: TFILETIME;
begin
  SystemTimeToFileTime(Unix_Epoch, jot);
  _calculated_offset := jlong_from(jot.dwHighDateTime, jot.dwLowDateTime);
end;
