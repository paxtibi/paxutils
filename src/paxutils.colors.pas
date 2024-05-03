unit paxutils.colors;

{$mode objfpc}{$H+}
{$ModeSwitch typehelpers}
{$ModeSwitch advancedrecords}

interface

uses
  Classes,
  SysUtils;

type
  TGraphicsColor = -$7FFFFFFF - 1..$7FFFFFFF;
  PColor = ^TColor;
  TColor = TGraphicsColor;

const
  {$J+}
  // WebColors

  ColorAliceBlue = TColor($FFF8F0);
  ColorAntiqueWhite = TColor($D7EBFA);
  ColorAqua = TColor($FFFF00);
  ColorAquamarine = TColor($D4FF7F);
  ColorAzure = TColor($FFFFF0);
  ColorBeige = TColor($DCF5F5);
  ColorBisque = TColor($C4E4FF);
  ColorBlack = TColor($000000);
  ColorBlanchedAlmond = TColor($CDEBFF);
  ColorBlue = TColor($FF0000);
  ColorBlueViolet = TColor($E22B8A);
  ColorBrown = TColor($2A2AA5);
  ColorBurlyWood = TColor($87B8DE);
  ColorCadetBlue = TColor($A09E5F);
  ColorChartreuse = TColor($00FF7F);
  ColorChocolate = TColor($1E69D2);
  ColorCoral = TColor($507FFF);
  ColorCornflowerBlue = TColor($ED9564);
  ColorCornsilk = TColor($DCF8FF);
  ColorCrimson = TColor($3C14DC);
  ColorCyan = TColor($FFFF00);
  ColorDarkBlue = TColor($8B0000);
  ColorDarkCyan = TColor($8B8B00);
  ColorDarkGoldenRod = TColor($0B86B8);
  ColorDarkGray = TColor($A9A9A9);
  ColorDarkGrey = TColor($A9A9A9);
  ColorDarkGreen = TColor($006400);
  ColorDarkKhaki = TColor($6BB7BD);
  ColorDarkMagenta = TColor($8B008B);
  ColorDarkOliveGreen = TColor($2F6B55);
  ColorDarkOrange = TColor($008CFF);
  ColorDarkOrchid = TColor($CC3299);
  ColorDarkRed = TColor($00008B);
  ColorDarkSalmon = TColor($7A96E9);
  ColorDarkSeaGreen = TColor($8FBC8F);
  ColorDarkSlateBlue = TColor($8B3D48);
  ColorDarkSlateGray = TColor($4F4F2F);
  ColorDarkSlateGrey = TColor($4F4F2F);
  ColorDarkTurquoise = TColor($D1CE00);
  ColorDarkViolet = TColor($D30094);
  ColorDeepPink = TColor($9314FF);
  ColorDeepSkyBlue = TColor($FFBF00);
  ColorDimGray = TColor($696969);
  ColorDimGrey = TColor($696969);
  ColorDodgerBlue = TColor($FF901E);
  ColorFireBrick = TColor($2222B2);
  ColorFloralWhite = TColor($F0FAFF);
  ColorForestGreen = TColor($228B22);
  ColorFuchsia = TColor($FF00FF);
  ColorGainsboro = TColor($DCDCDC);
  ColorGhostWhite = TColor($FFF8F8);
  ColorGold = TColor($00D7FF);
  ColorGoldenRod = TColor($20A5DA);
  ColorGray = TColor($808080);
  ColorGrey = TColor($808080);
  ColorGreen = TColor($008000);
  ColorGreenYellow = TColor($2FFFAD);
  ColorHoneyDew = TColor($F0FFF0);
  ColorHotPink = TColor($B469FF);
  ColorIndianRed = TColor($5C5CCD);
  ColorIndigo = TColor($82004B);
  ColorIvory = TColor($F0FFFF);
  ColorKhaki = TColor($8CE6F0);
  ColorLavender = TColor($FAE6E6);
  ColorLavenderBlush = TColor($F5F0FF);
  ColorLawnGreen = TColor($00FC7C);
  ColorLemonChiffon = TColor($CDFAFF);
  ColorLightBlue = TColor($E6D8AD);
  ColorLightCoral = TColor($8080F0);
  ColorLightCyan = TColor($FFFFE0);
  ColorLightGoldenRodYellow = TColor($D2FAFA);
  ColorLightGray = TColor($D3D3D3);
  ColorLightGrey = TColor($D3D3D3);
  ColorLightGreen = TColor($90EE90);
  ColorLightPink = TColor($C1B6FF);
  ColorLightSalmon = TColor($7AA0FF);
  ColorLightSeaGreen = TColor($AAB220);
  ColorLightSkyBlue = TColor($FACE87);
  ColorLightSlateGray = TColor($998877);
  ColorLightSlateGrey = TColor($998877);
  ColorLightSteelBlue = TColor($DEC4B0);
  ColorLightYellow = TColor($E0FFFF);
  ColorLime = TColor($00FF00);
  ColorLimeGreen = TColor($32CD32);
  ColorLinen = TColor($E6F0FA);
  ColorMagenta = TColor($FF00FF);
  ColorMaroon = TColor($000080);
  ColorMediumAquaMarine = TColor($AACD66);
  ColorMediumBlue = TColor($CD0000);
  ColorMediumOrchid = TColor($D355BA);
  ColorMediumPurple = TColor($DB7093);
  ColorMediumSeaGreen = TColor($71B33C);
  ColorMediumSlateBlue = TColor($EE687B);
  ColorMediumSpringGreen = TColor($9AFA00);
  ColorMediumTurquoise = TColor($CCD148);
  ColorMediumVioletRed = TColor($8515C7);
  ColorColorMidnightBlue = TColor($701919);
  ColorMintCream = TColor($FAFFF5);
  ColorMistyRose = TColor($E1E4FF);
  ColorMoccasin = TColor($B5E4FF);
  ColorNavajoWhite = TColor($ADDEFF);
  ColorNavy = TColor($800000);
  ColorOldLace = TColor($E6F5FD);
  ColorOlive = TColor($008080);
  ColorOliveDrab = TColor($238E6B);
  ColorOrange = TColor($00A5FF);
  ColorOrangeRed = TColor($0045FF);
  ColorOrchid = TColor($D670DA);
  ColorPaleGoldenRod = TColor($AAE8EE);
  ColorPaleGreen = TColor($98FB98);
  ColorPaleTurquoise = TColor($EEEEAF);
  ColorPaleVioletRed = TColor($9370DB);
  ColorPapayaWhip = TColor($D5EFFF);
  ColorPeachPuff = TColor($B9DAFF);
  ColorPeru = TColor($3F85CD);
  ColorPink = TColor($CBC0FF);
  ColorPlum = TColor($DDA0DD);
  ColorPowderBlue = TColor($E6E0B0);
  ColorPurple = TColor($800080);
  ColorRebeccaPurple = TColor($993366);
  ColorRed = TColor($0000FF);
  ColorRosyBrown = TColor($8F8FBC);
  ColorRoyalBlue = TColor($E16941);
  ColorSaddleBrown = TColor($13458B);
  ColorSalmon = TColor($7280FA);
  ColorSandyBrown = TColor($60A4F4);
  ColorSeaGreen = TColor($578B2E);
  ColorSeaShell = TColor($EEF5FF);
  ColorSienna = TColor($2D52A0);
  ColorSilver = TColor($C0C0C0);
  ColorSkyBlue = TColor($EBCE87);
  ColorSlateBlue = TColor($CD5A6A);
  ColorSlateGray = TColor($908070);
  ColorSlateGrey = TColor($908070);
  ColorSnow = TColor($FAFAFF);
  ColorSpringGreen = TColor($7FFF00);
  ColorSteelBlue = TColor($B48246);
  ColorTan = TColor($8CB4D2);
  ColorTeal = TColor($808000);
  ColorThistle = TColor($D8BFD8);
  ColorTomato = TColor($4763FF);
  ColorTurquoise = TColor($D0E040);
  ColorViolet = TColor($EE82EE);
  ColorWheat = TColor($B3DEF5);
  ColorWhite = TColor($FFFFFF);
  ColorWhiteSmoke = TColor($F5F5F5);
  ColorYellow = TColor($00FFFF);
  ColorYellowGreen = TColor($32CD9A);

  MIN_RADIX = 2;
  MAX_RADIX = 36;
  Theme_Color_Interval = 0.08;
  yiq_contrasted_threshold = 150;
{$J-}

var
  clBtnDefault_color: TColor;
  clBtnDefault_bg: TColor;
  clBtnDefault_border: TColor;

  clBtnPrimary_color: TColor;
  clBtnPrimary_bg: TColor;
  clBtnPrimary_border: TColor;

  clBtnSuccess_color: TColor;
  clBtnSuccess_bg: TColor;
  clBtnSuccess_border: TColor;

  clBtnInfo_color: TColor;
  clBtnInfo_bg: TColor;
  clBtnInfo_border: TColor;

  clBtnWarning_color: TColor;
  clBtnWarning_bg: TColor;
  clBtnWarning_border: TColor;

  clBtnDanger_color: TColor;
  clBtnDanger_bg: TColor;
  clBtnDanger_border: TColor;

  clNavbarDarkColor: TColor;
  clNavbarDarkHoverColor: TColor;
  clNavbarDarkActiveColor: TColor;
  clNavbarDarkDisabledColor: TColor;
  clNavbarDarkTogglerBorderColor: TColor;

  clNavbarLightColor: TColor;
  clNavbarLightHoverColor: TColor;
  clNavbarLightActiveColor: TColor;
  clNavbarLightDisabledColor: TColor;
  clNavbarLightTogglerBorderBolor: TColor;

  clNavbarLightBrandColor: TColor;
  clNavbarLightBrandHoverColor: TColor;
  clNavbarDarkBrandColor: TColor;
  clNavbarDarkBrandHoverColor: TColor;

type
  {$PUSH}
  {$A1}

  { TRGBA }

  TRGBA = packed record
    r: byte;
    g: byte;
    b: byte;
    a: byte;
    function toString: string;
  end;
  {$POP}

  THSLA = record
    hue: single;
    saturation: single;
    lightness: single;
    alpha: single;
    function toString: string;
  end;

  { TColorHelper }

  TColorHelper = type helper for TColor
    function css(Value: string): TColor;
    function red: byte;
    function blue: byte;
    function green: byte;
    function alpha: byte;
    function hex: string;
  end;

  ENumberFormatException = class(Exception)

  end;

type
  TManipulationMethod = (mmAbsolute, mmRelative);


function parseInt(Value: string; radix: int32 = 16): int64;
function parseDouble(Value: string): Double;
function cssCodeToColor(webCode: string): TColor;

operator := (commonValue: string): TColor;
operator := (Value: TRGBA): TColor;
operator := (color: TColor): String;

function lighten(color: TColor; percent: single; method: TManipulationMethod = mmAbsolute): TColor;
function darken(color: TColor; percent: single): TColor;
function mix(color1, color2: TColor; weight: single = 0.5): TColor;
function tint(color: TColor; percent: single): TColor;
function shade(color: TColor; percent: single): TColor;

function hsla(color: TColor): THSLA;
function rgba(color: TColor): TRGBA;
function rgba(color: TColor; a: single): TColor;
function rgba(r, g, b: byte; a: single): TRGBA;
function rgba(color: THSLA): TRGBA;

function ifThen(condition: boolean; ifTrue: TColor; ifFalse: TColor = ColorBlack): TColor;

implementation

uses
  Math;

const
  numberDictionary = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

function Blue(rgb: TColor): Byte;
begin
  Result := (rgb shr 16) and $000000ff;
end;

function Green(rgb: TColor): Byte;
begin
  Result := (rgb shr 8) and $000000ff;
end;

function Red(rgb: TColor): Byte;
begin
  Result := rgb and $000000ff;
end;

function RGBToColor(R, G, B: Byte): TColor;
begin
  Result := (B shl 16) or (G shl 8) or R;
end;

function parseInt(Value: string; radix: int32): int64;

  function getDigit(Value: char): integer;
  var
    idx: integer;
  begin
    Result := -1;
    for idx := 1 to numberDictionary.Length do
    begin
      if numberDictionary[idx] = Value then
        exit(idx - 1);
    end;
  end;

var
  negative: boolean = False;
  i: int64 = 1;
  len: integer;
  limit: int64 = -int64.MaxValue;
  multmin: int64 = 0;
  digit: int64 = 0;
  firstChar: integer;
begin
  Result := 0;
  len := length(Value) + 1;
  Value := UpperCase(Value);
  if (radix < MIN_RADIX) then
  begin
    raise  ENumberFormatException.CreateFmt('radix %d less %d', [radix, MIN_RADIX]);
  end;

  if (radix > MAX_RADIX) then
  begin
    raise  ENumberFormatException.CreateFmt('radix %d greater %d', [radix, MAX_RADIX]);
  end;

  if (len > 0) then
  begin
    firstChar := numberDictionary.IndexOf(Value[1]);
    if (firstChar < 0) then
    begin
      if (Value[1] = '-') then
      begin
        negative := True;
        limit := int64.MinValue;
      end
      else
      if (Value[1] <> '+') then
        raise ENumberFormatException.Create(Value);
      if (len = 1) then
        raise ENumberFormatException.Create(Value);
      i += 1;
    end;
  end;
  multmin := limit div radix;
  while (i < len) do
  begin
    digit := getDigit(Value[i]);
    Inc(i);
    if (digit < 0) then
    begin
      raise ENumberFormatException.Create(Value);
    end;
    if (Result < multmin) then
    begin
      raise ENumberFormatException.Create(Value);
    end;
    Result *= radix;
    if (Result < limit + digit) then
    begin
      raise ENumberFormatException.Create(Value);
    end;
    Result += digit;
  end;

  if negative then
    Result := -Result;
end;

function parseDouble(Value: string): Double;
begin
  TryStrToFloat(Value,Result);
end;

function cssCodeToColor(webCode: string): TColor;
var
  map: TRGBA absolute Result;
begin
  if webCode[1] = '#' then
  begin
    map.a := 0;
    if webCode.Length < 7 then
    begin
      map.r := parseInt(webCode[2] + webCode[2]);
      map.g := parseInt(webCode[3] + webCode[3]);
      map.b := parseInt(webCode[4] + webCode[4]);
    end
    else
    begin
      map.r := parseInt(webCode[2] + webCode[3]);
      map.g := parseInt(webCode[4] + webCode[5]);
      map.b := parseInt(webCode[6] + webCode[7]);
    end;
  end
  else
    raise ENumberFormatException.Create('Not css code');
end;

{ TRGBA }

function TRGBA.toString: string;
begin
  Result := Format('rgba(%d,%d,%d,%d)', [self.r, self.g, self.b, self.a]);
end;

{ THSLAHelper }

function THSLA.toString: string;
begin
  Result := Format('hsl(%4.2f,%4.2f%%,%4.2f%%)', [self.hue, self.saturation, self.lightness]);
end;

{ TColorHelper }

function TColorHelper.css(Value: string): TColor;
begin
  Result := cssCodeToColor(Value);
end;

function TColorHelper.red: byte;
var
  map: TRGBA absolute self;
begin
  Result := map.r;
end;

function TColorHelper.blue: byte;
var
  map: TRGBA absolute self;
begin
  Result := map.b;
end;

function TColorHelper.green: byte;
var
  map: TRGBA absolute self;
begin
  Result := map.g;
end;

function TColorHelper.alpha: byte;
var
  map: TRGBA absolute self;
begin
  Result := map.a;
end;

function TColorHelper.hex: string;
var
  map: TRGBA absolute self;
begin
  Result := Format('#%.2X%.2X%.2X', [map.r, map.g, map.b]);
end;

function clamp(val: single): single;
begin
  Result := Math.min(1, Math.max(0, val));
end;

operator := (commonValue: string): TColor;
begin
  Result := cssCodeToColor(commonValue);
end;

operator := (Value: TRGBA): TColor;
begin

end;

operator := (color: TColor): String;
begin
  result := format('rgb(%d,%d,%d)', [color.red, color.green, color.blue]);
end;

function lighten(color: TColor; percent: single; method: TManipulationMethod): TColor;
  // from libsass -> Functions
var
  hsl: THSLA;
  map: TRGBA absolute Result;
begin
  Result := color;
  hsl := hsla(color);
  if method = mmRelative then
    hsl.lightness += hsl.lightness * percent
  else
    hsl.lightness += percent;
  if (hsl.lightness > 1) then
    hsl.lightness := 1;
  map := rgba(hsl);
end;

function darken(color: TColor; percent: single): TColor;
  // from libsass -> Functions
var
  hsl: THSLA;
  map: TRGBA absolute Result;
begin
  Result := color;
  hsl := hsla(color);
  if (hsl.lightness > 1) then
    hsl.lightness := 1;
  hsl.lightness -= percent;
  if (hsl.lightness > 1) then
    hsl.lightness := 1;
  map := rgba(hsl);
end;

function mix(color1, color2: TColor; weight: single): TColor;
var
  w: single;
  a: single;
  w1, w2: single;
  rgba: TRGBA absolute Result;
  guard: extended;
  h1, h2: THSLA;
begin
  w := weight * 2 - 1;
  h1 := hsla(color1);
  h2 := hsla(color2);
  a := h1.alpha - h2.alpha;
  w1 := 1;
  guard := w * a;
  if (guard = -1) then
    w1 += w
  else
    w1 += (w + a) / (1 + w * a);
  w1 /= 2;
  w2 := 1 - w1;
  rgba.r := round(color1.red * w1 + color2.red * w2);
  rgba.g := round(color1.green * w1 + color2.green * w2);
  rgba.b := round(color1.blue * w1 + color2.blue * w2);
  rgba.a := round(color1.alpha * weight + color2.alpha * (1 - weight));
end;

function tint(color: TColor; percent: single): TColor;
begin
  Result := mix(ColorWhite, color, percent);
end;

function shade(color: TColor; percent: single): TColor;
begin
  Result := mix(ColorBlack, color, percent);
end;

function hsla(color: TColor): THSLA;
var
  //set these variables to your needs, e.g. 360, 255, 255
  MaxHue: integer = 360;
  MaxSat: integer = 255;
  MaxLum: integer = 255;
  R, G, B, D, Cmax, Cmin, h, s, l: double;
  map: TRGBA absolute color;
begin
  R := map.R / 255;
  G := map.G / 255;
  B := map.B / 255;
  Cmax := Max(R, Max(G, B));
  Cmin := Min(R, Min(G, B));
  L := (Cmax + Cmin) / 2;
  if Cmax = Cmin then
  begin
    H := 0;
    S := 0;
  end
  else
  begin
    D := Cmax - Cmin;
    //calc L
    if L < 0.5 then
      S := D / (Cmax + Cmin)
    else
      S := D / (2 - Cmax - Cmin);
    //calc H
    if R = Cmax then
      H := (G - B) / D
    else
    if G = Cmax then
      H := 2 + (B - R) / D
    else
      H := 4 + (R - G) / D;
    H := H / 6;
    if H < 0 then
      H := H + 1;
  end;
  Result.alpha := 1;
  Result.hue := round(H * MaxHue);
  Result.saturation := round(S * MaxSat);
  Result.lightness := round(L * MaxLum);
end;

function rgba(color: TColor): TRGBA;
var
  map: TRGBA absolute color;
begin
  Result := map;
end;

function rgba(color: TColor; a: single): TColor;
var
  rgb: TRGBA absolute Result;
begin
  rgba := color;
  rgb.a := ceil(255 * a);
end;

function rgba(r, g, b: byte; a: single): TRGBA;
var
  rgb: TRGBA absolute Result;
begin
  rgb.a := ceil(255 * a);
  rgb.r := r;
  rgb.g := g;
  rgb.b := b;
end;

function rgba(color: THSLA): TRGBA;

  function hue(m1, m2, h: single): single;
  begin
    if (h < 0) then
      h := h + 1
    else
    if h > 1 then
      h := h - 1;

    if (h * 6 < 1) then
      exit(m1 + (m2 - m1) * h * 6)
    else if (h * 2 < 1) then
      exit(m2)
    else if (h * 3 < 2) then
      exit(m1 + (m2 - m1) * (2 / 3 - h) * 6)
    else
      exit(m1);
  end;

var
  m1, m2: single;
  rgb: TRGBA absolute Result;

begin
  while color.hue > 360 do
    color.hue -= 360;
  color.hue := color.hue / 360;
  color.saturation := clamp(color.saturation);
  color.lightness := clamp(color.lightness);
  color.alpha := clamp(color.alpha);
  if color.lightness <= 0.5 then
    m2 := color.lightness * (color.saturation + 1)
  else
    m2 := color.lightness + color.saturation - color.lightness * color.saturation;
  m1 := color.lightness * 2 - m2;

  rgb.r := trunc(hue(m1, m2, color.hue + 1 / 3) * 255);
  rgb.g := trunc(hue(m1, m2, color.hue) * 255);
  rgb.b := trunc(hue(m1, m2, color.hue - 1 / 3) * 255);
end;

const
  yiq_text_dark: TColor = 0;
  yiq_text_light: TColor = 0;

function colorYIQ(color: TColor; dark: TColor = 0; light: TColor = 0): TColor;
var
  r, g, b: byte;
  yiq: word;
begin
  r := red(color);
  g := green(color);
  b := blue(color);
  if dark = 0 then
    dark := yiq_text_dark;
  if light = 0 then
    dark := yiq_text_light;

  yiq := ((r * 299) + (g * 587) + (b * 114)) div 1000;

  if yiq > yiq_contrasted_threshold then
    Result := dark
  else
    Result := light;
end;

function ifThen(condition: boolean; ifTrue: TColor; ifFalse: TColor): TColor;
begin
  Result := ifFalse;
  if condition then
    Result := ifTrue;
end;



initialization

end.
