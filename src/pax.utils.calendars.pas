unit pax.utils.calendars;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  TCalendarField = (
    ERA = 0,
    YEAR = 1,
    MONTH = 2,
    WEEK_OF_YEAR = 3,
    WEEK_OF_MONTH = 4,
    DATE = 5,   // sinonimo di DAY_OF_MONTH
    DAY_OF_MONTH = 5,
    DAY_OF_YEAR = 6,
    DAY_OF_WEEK = 7,
    DAY_OF_WEEK_IN_MONTH = 8,
    AM_PM = 9,
    HOUR = 10,
    HOUR_OF_DAY = 11,
    MINUTE = 12,
    SECOND = 13,
    MILLISECOND = 14,
    ZONE_OFFSET = 15,
    DST_OFFSET = 16
    );

  TWeekDay = (
    SUNDAY = 1,
    MONDAY = 2,
    TUESDAY = 3,
    WEDNESDAY = 4,
    THURSDAY = 5,
    FRIDAY = 6,
    SATURDAY = 7);

  TMonth = (
    JANUARY = 0, FEBRUARY = 1, MARCH = 2, APRIL = 3,
    MAY = 4, JUNE = 5, JULY = 6, AUGUST = 7,
    SEPTEMBER = 8, OCTOBER = 9, NOVEMBER = 10, DECEMBER = 11,
    UNDECIMBER = 12
    );

const
  // AM/PM
  AM = 0;
  PM = 1;



type
  { TCalendar }

  TCalendar = class abstract(TObject)
  protected
    fFirstDayOfWeek: int32;
    fMinimalDaysInFirstWeek: int32;
  protected
    procedure ComputeTime; virtual; abstract;
    procedure ComputeFields; virtual; abstract;
    function InternalGet(Field: TCalendarField): integer; virtual;
  public
    constructor Create; virtual;
    // constructor Create(Zone: TTimeZone; Locale: TLocale); // da implementare se necessario

    class function GetInstance: TCalendar; virtual; abstract;
    class function GetInstance(const Zone: TTimeZone): TCalendar; virtual; abstract;
    class function GetInstance(const Locale: TLocale): TCalendar; virtual; abstract;
    class function GetInstance(const Zone: TTimeZone; const Locale: TLocale): TCalendar; virtual; abstract;

    class function GetAvailableLocales: TArray<TLocale>; virtual; abstract; // stub

    function GetTime: TDateTime; virtual;
    procedure SetTime(const Value: TDateTime); virtual;

    function GetTimeInMillis: int64; virtual;
    procedure SetTimeInMillis(const Millis: int64); virtual;

    function Get(Field: TCalendarField): integer; virtual;
    procedure SetField(Field: TCalendarField; Value: integer); virtual;

    procedure SetDate(Year, Month, Day: integer); virtual;
    procedure SetDateTime(Year, Month, Day, Hour, Minute: integer); virtual;
    procedure SetDateTimeFull(Year, Month, Day, Hour, Minute, Second: integer); virtual;

    procedure Clear; virtual;
    procedure ClearField(Field: TCalendarField); virtual;

    function IsSet(Field: TCalendarField): boolean; virtual;

    procedure Add(Field: TCalendarField; Amount: integer); virtual; abstract;
    procedure Roll(Field: TCalendarField; Amount: integer); virtual; abstract;
    procedure RollUp(Field: TCalendarField; Up: boolean); virtual; abstract;

    function GetMinimum(Field: TCalendarField): integer; virtual; abstract;
    function GetMaximum(Field: TCalendarField): integer; virtual; abstract;
    function GetGreatestMinimum(Field: TCalendarField): integer; virtual; abstract;
    function GetLeastMaximum(Field: TCalendarField): integer; virtual; abstract;

    function GetActualMinimum(Field: TCalendarField): integer; virtual;
    function GetActualMaximum(Field: TCalendarField): integer; virtual;

    procedure SetLenient(Lenient: boolean); virtual;
    function IsLenient: boolean; virtual;

    procedure SetFirstDayOfWeek(Value: integer); virtual;
    function GetFirstDayOfWeek: integer; virtual;

    procedure SetMinimalDaysInFirstWeek(Value: integer); virtual;
    function GetMinimalDaysInFirstWeek: integer; virtual;

    function GetTimeZone: TTimeZone; virtual;
    procedure SetTimeZone(const Value: TTimeZone); virtual;

    function Before(When: TObject): boolean; virtual;
    function After(When: TObject): boolean; virtual;

    function Equals(Obj: TObject): boolean; override;
    function HashCode: integer; virtual;
    function Clone: TObject; virtual;

    function ToString: string; override;
  end;

  TGregorianCalendar = class(TCalendar)
  private
    FGregorianChange: TDateTime;   // data di passaggio dal calendario Giuliano

  protected
    procedure ComputeTime; override;
    procedure ComputeFields; override;
  public
    // Costruttori
    constructor Create; override;
    constructor Create(const Zone: TTimeZone); overload;
    constructor Create(const Locale: TLocale); overload;
    constructor Create(const Zone: TTimeZone; const Locale: TLocale); overload;

    constructor Create(Year, Month, DayOfMonth: integer); overload;
    constructor Create(Year, Month, DayOfMonth, HourOfDay, Minute: integer); overload;
    constructor Create(Year, Month, DayOfMonth, HourOfDay, Minute, Second: integer); overload;

    class function GetInstance: TCalendar; override;

    // Metodi specifici di GregorianCalendar
    procedure SetGregorianChange(const Date: TDateTime);
    function GetGregorianChange: TDateTime;

    function IsLeapYear(Year: integer): boolean; virtual;

    // Override dei metodi di calcolo
    function GetActualMaximum(Field: TCalendarField): integer; override;
    function GetActualMinimum(Field: TCalendarField): integer; override;

    procedure Add(Field: TCalendarField; Amount: integer); override;
    procedure Roll(Field: TCalendarField; Amount: integer); override;
    procedure RollUp(Field: TCalendarField; Up: boolean); override;

    function GetMinimum(Field: TCalendarField): integer; override;
    function GetMaximum(Field: TCalendarField): integer; override;
    function GetGreatestMinimum(Field: TCalendarField): integer; override;
    function GetLeastMaximum(Field: TCalendarField): integer; override;

    function Clone: TObject; override;
    function Equals(Obj: TObject): boolean; override;
    function HashCode: integer; override;

    function GetCalendarType: string; virtual;
    // function ToZonedDateTime: TZonedDateTime; // se si vuole supporto avanzato
    // class function From(const Zdt: TZonedDateTime): TGregorianCalendar;

  end;


implementation

const
  ERA_MASK = (1 shl ERA);
  YEAR_MASK = (1 shl YEAR);
  MONTH_MASK = (1 shl MONTH);
  WEEK_OF_YEAR_MASK = (1 shl WEEK_OF_YEAR);
  WEEK_OF_MONTH_MASK = (1 shl WEEK_OF_MONTH);
  DAY_OF_MONTH_MASK = (1 shl DAY_OF_MONTH);
  DAY_OF_YEAR_MASK = (1 shl DAY_OF_YEAR);
  DAY_OF_WEEK_MASK = (1 shl DAY_OF_WEEK);
  DAY_OF_WEEK_IN_MONTH_MASK = (1 shl DAY_OF_WEEK_IN_MONTH);
  AM_PM_MASK = (1 shl AM_PM);
  HOUR_MASK = (1 shl HOUR);
  HOUR_OF_DAY_MASK = (1 shl HOUR_OF_DAY);
  MINUTE_MASK = (1 shl MINUTE);
  SECOND_MASK = (1 shl SECOND);
  MILLISECOND_MASK = (1 shl MILLISECOND);
  ZONE_OFFSET_MASK = (1 shl ZONE_OFFSET);
  DST_OFFSET_MASK = (1 shl DST_OFFSET);


end.
