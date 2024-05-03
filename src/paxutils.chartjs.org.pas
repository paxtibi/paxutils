unit paxutils.chartjs.org;

{$mode objfpc}{$H+}
{$ModeSwitch prefixedattributes}
interface

uses
  Classes, SysUtils, fpjson, paxutils.colors, openssl;

type
  { TJSONObjectHelper }

  TJSONObjectHelper = class helper for TJSONObject
    procedure setValue(Name: string; Value: TJSONArray); overload;
    procedure setValue(Name: string; Value: TJSONObject); overload;
    procedure setValue(Name: string; Value: boolean); overload;
    procedure setValue(Name: string; Value: string); overload;
    procedure setValue(Name: string; Value: integer); overload;
    procedure setValue(Name: string; Value: double); overload;
    procedure setValue(Name: string; Value: single); overload;
    procedure setValue(Name: string; Value: int64); overload;

    procedure getValue(Name: string; out Value: TJSONArray); overload;
    procedure getValue(Name: string; out Value: TJSONObject); overload;
    procedure getValue(Name: string; out Value: boolean); overload;
    procedure getValue(Name: string; out Value: string); overload;
    procedure getValue(Name: string; out Value: integer); overload;
    procedure getValue(Name: string; out Value: double); overload;
    procedure getValue(Name: string; out Value: single); overload;
    procedure getValue(Name: string; out Value: int64); overload;
  end;

  TJSONArrayHelper = class helper for TJSONArray
    procedure addAll(values: TStringArray);
  end;

function putFileContent(fileName: string; Data: TJSONData): boolean;

type
  TChartType = (ctLine, ctBar, ctHorizontalBar, ctRadar, ctDoughnut, ctPolarArea, ctBubblect, ctPie, ctScatter);

  TLabels = class(TJSONArray)
  end;

  { TDatasetData }

  TDatasetData = class(TJSONArray)
    procedure replace(index: integer; aValue: int64);
    procedure replace(index: integer; aValue: double);
  end;

  { TChartDataSet }

  TChartDataSet = class(TJSONObject)
  private
    function getBarPercentage: double;
    function getCategoryPercentage: double;
    function getFill: boolean;
    function getOrder: integer;
    function getPointBackgroundColor: string;
    function getPointBorderColor: string;
    function getPointBorderWidth: integer;
    function getPointRadius: integer;
    function getBackgroundColor: string;
    function getBorderWidth: integer;
    function getBorderColor: string;
    function getChartType: TChartType;
    function getData: TDatasetData;
    function getHidden: boolean;
    function getHideInLegendAndTooltip: boolean;
    function getLabel: string;
    function getShowLine: boolean;
    function getStack: string;
    function getWeight: double;
    function getXAxis: string;
    function getYAxis: string;
    procedure SetBackgroundColor(AValue: string);
    procedure setBarPercentage(AValue: double);
    procedure SetBorderColor(AValue: string);
    procedure SetBorderWidth(AValue: integer);
    procedure setCategoryPercentage(AValue: double);
    procedure setChartType(AValue: TChartType);
    procedure SetFill(AValue: boolean);
    procedure setHidden(AValue: boolean);
    procedure setHideInLegendAndTooltip(AValue: boolean);
    procedure setLabel(AValue: string);
    procedure setOrder(AValue: integer);
    procedure SetpointBackgroundColor(AValue: string);
    procedure SetpointBorderColor(AValue: string);
    procedure SetpointBorderWidth(AValue: integer);
    procedure SetPointRadius(AValue: integer);
    procedure setShowLine(AValue: boolean);
    procedure setStack(AValue: string);
    procedure setWeight(AValue: double);
    procedure setXAxis(AValue: string);
    procedure setYAxis(AValue: string);
  public
    constructor Create; reintroduce;
  published
    property Data: TDatasetData read getData;
    property labelValue: string read getLabel write setLabel;
    property chartType: TChartType read getChartType write setChartType;
    property hidden: boolean read getHidden write setHidden;
    property hideInLegendAndTooltip: boolean read getHideInLegendAndTooltip write setHideInLegendAndTooltip;
    property showLine: boolean read getShowLine write setShowLine;
    property stack: string read getStack write setStack;
    property weight: double read getWeight write setWeight;
    property backgroundColor: string read getBackgroundColor write SetbackgroundColor;
    property borderWidth: integer read getBorderWidth write SetborderWidth;
    property borderColor: string read getBorderColor write SetborderColor;
    property fill: boolean read getFill write SetFill;
    property order: integer read getOrder write setOrder;
    property pointBorderColor: string read getPointBorderColor write SetpointBorderColor;
    property pointBackgroundColor: string read getPointBackgroundColor write SetpointBackgroundColor;
    property pointBorderWidth: integer read getPointBorderWidth write SetpointBorderWidth;
    property pointRadius: integer read getPointRadius write SetPointRadius;
    property categoryPercentage: double read getCategoryPercentage write setCategoryPercentage;
    property barPercentage: double read getBarPercentage write setBarPercentage;
    property xAxis: string read getXAxis write setXAxis;
    property yAxis: string read getYAxis write setYAxis;
  end;

  { TChartDataSets }

  TChartDataSets = class(TJSONArray)
  private
    function GetDataset(Index: integer): TChartDataSet;
    procedure SetDataset(Index: integer; AValue: TChartDataSet);
  public
    property Dataset[Index: integer]: TChartDataSet read GetDataset write SetDataset; default;
  end;

  { TChartDataSetsArrayHelper }

  TChartDataSetsArrayHelper = class helper for TChartDataSets
  protected
    procedure internalAdd(aValue: TChartDataSet);
  public
    function newDataSet(): TChartDataSet;
  end;

  { TChartData }

  TChartData = class(TJSONObject)
  private
    function GetDatasets: TChartDataSets;
    function GetLabels: TLabels;
  public
    constructor Create; reintroduce;
    property labels: TLabels read GetLabels;
    property datasets: TChartDataSets read GetDatasets;
  end;

  { TChartScaleTicks }

  TChartScaleTicks = class(TJSONObject)
  private
    function getBeginAtZero: boolean;
    function getCallback: string;
    function getMaxRotation: double;
    function getMinRotation: double;
    function getSampleSize: double;
    procedure setBeginAtZero(AValue: boolean);
    procedure setCallback(AValue: string);
    procedure setMaxRotation(AValue: double);
    procedure setMinRotation(AValue: double);
    procedure setSampleSize(AValue: double);
  public
    constructor Create; reintroduce;
    property beginAtZero: boolean read getBeginAtZero write setBeginAtZero;
    property maxRotation: double read getMaxRotation write setMaxRotation;
    property minRotation: double read getMinRotation write setMinRotation;
    property sampleSize: double read getSampleSize write setSampleSize;
    property callback: string read getCallback write setCallback;
  end;

  { TChartScaleTitle }

  TChartScaleTitle = class(TJSONObject)
  private
    function GetDisplay: boolean;
    function getText: string;
    procedure SetDisplay(AValue: boolean);
    procedure setText(AValue: string);
  public
    constructor Create; reintroduce;
    property display: boolean read GetDisplay write SetDisplay;
    property Text: string read getText write setText;
  end;

  TChartTimeUnit = (tuMillisecond, tuSecond, tuMinute, tuHour, tuDay, tuWeek, tuMonth, tuQuarter, tuYear);

  { TChartTime }

  TChartTime = class(TJSONObject)
  private
    function getTimeUnit: TChartTimeUnit;
    procedure setTimeUnit(AValue: TChartTimeUnit);
  published
    property timeunit: TChartTimeUnit read getTimeUnit write setTimeUnit;
  end;

  TChartScale = class(TJSONObject)
  private
    function getAlignToPixels: boolean;
    function getBackgroundColor: string;
    function getDisplay: boolean;
    function getMax: double;
    function getMin: double;
    function getReverse: boolean;
    function getScaleType: string;
    function getStacked: boolean;
    function getSuggestedMax: double;
    function getSuggestedMin: double;
    function getTicks: TChartScaleTicks;
    function getTitle: TChartScaleTitle;
    function getUnit: TChartTime;
    function getWeight: double;
    procedure setAlignToPixels(AValue: boolean);
    procedure setBackgroundColor(AValue: string);
    procedure setDisplay(AValue: boolean);
    procedure setMax(AValue: double);
    procedure setMin(AValue: double);
    procedure setReverse(AValue: boolean);
    procedure setScaleType(AValue: string);
    procedure setStacked(AValue: boolean);
    procedure setSuggestedMax(AValue: double);
    procedure setSuggestedMin(AValue: double);
    procedure setTicks(AValue: TChartScaleTicks);
    procedure setTitle(AValue: TChartScaleTitle);
    procedure setUnit(AValue: TChartTime);
    procedure setWeight(AValue: double);
  public
    constructor Create; reintroduce;
    //property scaleType: string read getScaleType write setScaleType;
    //property scaleUnit: TChartTime read getUnit write setUnit;
    property alignToPixels: boolean read getAlignToPixels write setAlignToPixels;
    property backgroundColor: string read getBackgroundColor write setBackgroundColor;
    property display: boolean read getDisplay write setDisplay;
    property min: double read getMin write setMin;
    property max: double read getMax write setMax;
    property reverse: boolean read getReverse write setReverse;
    property stacked: boolean read getStacked write setStacked;
    property suggestedMax: double read getSuggestedMax write setSuggestedMax;
    property suggestedMin: double read getSuggestedMin write setSuggestedMin;
    property weight: double read getWeight write setWeight;
    //property grid  : TObject;
    property ticks: TChartScaleTicks read getTicks write setTicks;
    property title: TChartScaleTitle read getTitle write setTitle;
  end;

  { TChartScales }

  TChartScales = class(TJSONObject)
  private
    function GetScales(Name: string): TChartScale;
    procedure SetScales(Name: string; AValue: TChartScale);
  public
    property scales[Name: string]: TChartScale read GetScales write SetScales; default;
  end;

  TDrawTime = (afterDraw, afterDatasetsDraw, beforeDraw, beforeDatasetsDraw);


  { TAnnotationLabel }

  TAnnotationLabel = class(TJSONObject)
  private
    function getAdjustX: double;
    function getAdjustY: double;
    function getColor: string;
    function getContent: string;
    function getEnable: boolean;
    procedure setAdjustX(AValue: double);
    procedure setAdjustY(AValue: double);
    procedure setColor(AValue: string);
    procedure setContent(AValue: string);
    procedure setEnable(AValue: boolean);
  public
    constructor Create; reintroduce;
    property content: string read getContent write setContent;
    property enable: boolean read getEnable write setEnable;
    property adjustX: double read getAdjustX write setAdjustX;
    property adjustY: double read getAdjustY write setAdjustY;
    property color: string read getColor write setColor;
  end;

  { TChartPluginLineAnnotation }

  TChartPluginLineAnnotation = class(TJSONObject)
  private
    function getAnnotationLabel: TAnnotationLabel;
    function getBoderColor: string;
    function getScaleID: string;
    function getAnnotatinValue: string;
    procedure setBorderColor(AValue: string);
    procedure setScaleID(AValue: string);
    procedure setAnnotatinValue(AValue: string);
  public
    constructor Create; reintroduce;
    property scaleID: string read getScaleID write setScaleID;
    property annotatinValue: string read getAnnotatinValue write setAnnotatinValue;
    property annotationLabel: TAnnotationLabel read getAnnotationLabel;
    property borderColor: string read getBoderColor write setBorderColor;
  end;

  { TChartPluginAnnotations }

  TChartPluginAnnotations = class(TJSONArray)
  private
    function getItems(idx: integer): TChartPluginLineAnnotation;
    procedure setItems(idx: integer; AValue: TChartPluginLineAnnotation);
  public
    property items[idx: integer]: TChartPluginLineAnnotation read getItems write setItems; default;
  end;


  { TChartPluginAnnotation }

  TChartPluginAnnotation = class(TJSONObject)
  private
    function getAnnotations: TChartPluginAnnotations;
  public
    property annotations: TChartPluginAnnotations read getAnnotations;
  end;


  { TChartOptionsPluginTitle }

  TChartOptionsPluginTitle = class(TJSONObject)
  private
    function getDisplay: boolean;
    function getFullScreen: boolean;
    function getText: string;
    procedure setDisplay(AValue: boolean);
    procedure setFullScreen(AValue: boolean);
    procedure setText(AValue: string);
  public
    //property align: Align;
    property display: boolean read getDisplay write setDisplay;
    //property position: 'top' | 'left' | 'bottom' | 'right';
    //property color: Color;
    //property font: ScriptableAndScriptableOptions<Partial<FontSpec>, ScriptableChartContext>;
    property fullSize: boolean read getFullScreen write setFullScreen;
    //property padding: number | { top: number; bottom: number };
    property Text: string read getText write setText;
  end;


  { TChartOptionsPluginTooltipCallbacks }

  TChartOptionsPluginTooltipCallbacks = class(TJSONObject)
  private
    function getLabel: string;
    procedure setLabel(AValue: string);
  public
    property label_: string read getLabel write setLabel;
  end;

  { TChartOptionsPluginTooltip }

  TChartOptionsPluginTooltip = class(TJSONObject)
  private
    function getCallback: TChartOptionsPluginTooltipCallbacks;
    procedure setCallback(AValue: TChartOptionsPluginTooltipCallbacks);
  public
    property callbacks: TChartOptionsPluginTooltipCallbacks read getCallback write setCallback;
  end;

  { TChartPlugin }

  TChartPlugin = class(TJSONObject)
  private
    function getAnnotation: TChartPluginAnnotation;
    function getSubtitlePlugin: TChartOptionsPluginTitle;
    function getTitlePlugin: TChartOptionsPluginTitle;
    function getTooltip: TChartOptionsPluginTooltip;
  public
    property annotation: TChartPluginAnnotation read getAnnotation;
    property title: TChartOptionsPluginTitle read getTitlePlugin;
    property subtitle: TChartOptionsPluginTitle read getSubtitlePlugin;
    property tooltip: TChartOptionsPluginTooltip read getTooltip;
  end;

  { TChartOptions }

  TChartOptions = class(TJSONObject)
  private
    function getIndexAxis: string;
    function getPlugin: TChartPlugin;
    function getResponsive: boolean;
    function getScales: TChartScales;
    function getShowLines: boolean;
    procedure setIndexAxis(AValue: string);
    procedure setResponsive(AValue: boolean);
    procedure setShowLines(AValue: boolean);
  published
    property responsive: boolean read getResponsive write setResponsive;
    property indexAxis: string read getIndexAxis write setIndexAxis;
    //property responsiveAnimationDuration: Double;
    //property aspectRatio: Double;
    //property maintainAspectRatio: Boolean;
    //events?: string[] | undefined;
    //legendCallback?(chart: Chart): string;
    //onHover?(this: Chart, event: MouseEvent, activeElements: Array<{}>): any;
    //onClick?(event?: MouseEvent, activeElements?: Array<{}>): any;
    //onResize?(this: Chart, newSize: ChartSize): void;
    //property title: IChartTitleOptions;
    //property legend: IChartLegendOptions;
    //property tooltips: IChartTooltipOptions;
    //property hover: IChartHoverOptions;
    //property animation: IChartAnimationOptions;
    //property elements: IChartElementsOptions;
    //property layout: IChartLayoutOptions;
    //property scale: IRadialLinearScale;
    property scales: TChartScales read getScales;
    property showLines: boolean read getShowLines write setShowLines;
    //property spanGaps: boolean;
    //property cutoutPercentage: Double;
    //property circumference: Double;
    //property rotation: Double;
    //property devicePixelRatio: Double;
    //property plugins: IChartPluginsOptions;
    //property defaultColor: String;
    property plugin: TChartPlugin read getPlugin;
  end;


  { TChartConfiguration }

  TChartConfiguration = class(TJSONObject)
  private
    function getCharOptions: TChartOptions;
    function getChartType: TChartType;
    function getData: TChartData;
    procedure setChartType(AValue: TChartType);
  public
    constructor Create; reintroduce;
    property Data: TChartData read getData;
    property options: TChartOptions read getCharOptions;
    property chartType: TChartType read getChartType write setChartType;
  end;


implementation

uses
  TypInfo;

function putFileContent(fileName: string; Data: TJSONData): boolean;
var
  fs: TFileStream;
  content: string;
begin
  Result := True;
  try
    fileName := ExpandFileName(fileName);
    ForceDirectories(ExtractFileDir(fileName));
    fs := TFileStream.Create(fileName, fmCreate or fmShareDenyWrite);
    content := Data.FormatJSON(AsJSONFormat);
    fs.Write(content[1], content.Length);
  except
    on  E: Exception do
    begin
      Result := False;
    end;
  end;
end;

{ TJSONObjectHelper }

procedure TJSONObjectHelper.setValue(Name: string; Value: TJSONArray);
var
  Data: TJSONData;
begin
  try
    Data := find(Name);
    if assigned(Data) then
      (self as TJSONObject).Arrays[Name] := Value
    else
      Add(Name, Value);
  except
    Add(Name, Value);
  end;
end;

procedure TJSONObjectHelper.setValue(Name: string; Value: TJSONObject);
var
  Data: TJSONData;
begin
  try
    Data := find(Name);
    if assigned(Data) then
      (self as TJSONObject).Objects[Name] := Value
    else
      Add(Name, Value);
  except
    Add(Name, Value);
  end;
end;

procedure TJSONObjectHelper.setValue(Name: string; Value: boolean);
var
  Data: TJSONData;
begin
  try
    Data := find(Name);
    if Assigned(Data) then
      find(Name).AsBoolean := Value
    else
      Add(Name, Value);
  except
    Add(Name, Value);
  end;
end;

procedure TJSONObjectHelper.setValue(Name: string; Value: string);
var
  Data: TJSONData;
begin
  try
    Data := find(Name);
    if Assigned(Data) then
      find(Name).AsString := Value
    else
      Add(Name, Value);
  except
    Add(Name, Value);
  end;
end;

procedure TJSONObjectHelper.setValue(Name: string; Value: integer);
var
  Data: TJSONData;
begin
  try
    Data := find(Name);
    if Assigned(Data) then
      find(Name).AsInteger := Value
    else
      Add(Name, Value);
  except
    Add(Name, Value);
  end;
end;

procedure TJSONObjectHelper.setValue(Name: string; Value: double);
var
  Data: TJSONData;
begin
  try
    Data := find(Name);
    if Assigned(Data) then
      find(Name).AsFloat := Value
    else
      Add(Name, Value);
  except
    Add(Name, Value);
  end;
end;

procedure TJSONObjectHelper.setValue(Name: string; Value: single);
var
  Data: TJSONData;
begin
  try
    Data := find(Name);
    if Assigned(Data) then
      find(Name).AsFloat := Value
    else
      Add(Name, Value);
  except
    Add(Name, Value);
  end;
end;

procedure TJSONObjectHelper.setValue(Name: string; Value: int64);
var
  Data: TJSONData;
begin
  try
    Data := find(Name);
    if Assigned(Data) then
      find(Name).AsInt64 := Value
    else
      Add(Name, Value);
  except
    Add(Name, Value);
  end;
end;

procedure TJSONObjectHelper.getValue(Name: string; out Value: TJSONArray);
begin
  try
    Value := (self as TJSONObject).Arrays[Name];
  except
    Value := nil;
  end;
end;

procedure TJSONObjectHelper.getValue(Name: string; out Value: TJSONObject);
begin
  try
    Value := (self as TJSONObject).Objects[Name];
  except
    Value := nil;
  end;
end;

procedure TJSONObjectHelper.getValue(Name: string; out Value: boolean);
begin
  try
    Value := find(Name).AsBoolean;
  except
  end;
end;

procedure TJSONObjectHelper.getValue(Name: string; out Value: string);
begin
  try
    Value := find(Name).AsString;
  except
  end;
end;

procedure TJSONObjectHelper.getValue(Name: string; out Value: integer);
begin
  try
    Value := find(Name).AsInteger;
  except
  end;

end;

procedure TJSONObjectHelper.getValue(Name: string; out Value: double);
begin
  try
    Value := find(Name).AsFloat;
  except
    Value := 0.0;
  end;
end;

procedure TJSONObjectHelper.getValue(Name: string; out Value: single);
begin
  try
    Value := find(Name).AsFloat;
  except
    Value := 0.0;
  end;
end;

procedure TJSONObjectHelper.getValue(Name: string; out Value: int64);
begin
  try
    Value := find(Name).AsInt64;
  except
  end;
end;

{ TJSONArrayHelper }

procedure TJSONArrayHelper.addAll(values: TStringArray);
var
  Value: string;
begin
  for Value in values do
    TJSONArray(self).Add(Value);
end;


const
  ChartTypeStrings: array[TChartType] of string = ('line', 'bar', 'horizontalBar', 'radar', 'doughnut', 'polarArea', 'bubble', 'pie', 'scatter');

  { TAnnotationLabel }

function TAnnotationLabel.getAdjustX: double;
begin
  getValue('xAdjust', Result);
end;

function TAnnotationLabel.getAdjustY: double;
begin
  getValue('yAdjust', Result);
end;

function TAnnotationLabel.getColor: string;
begin
  getValue('color', Result);
end;

function TAnnotationLabel.getContent: string;
begin
  getValue('content', Result);
end;

function TAnnotationLabel.getEnable: boolean;
begin
  getValue('enabled', Result);
end;

procedure TAnnotationLabel.setAdjustX(AValue: double);
begin
  setValue('xAdjust', AValue);
end;

procedure TAnnotationLabel.setAdjustY(AValue: double);
begin
  setValue('yAdjust', AValue);
end;

procedure TAnnotationLabel.setColor(AValue: string);
begin
  setValue('color', AValue);
end;

procedure TAnnotationLabel.setContent(AValue: string);
begin
  setValue('content', AValue);
end;

procedure TAnnotationLabel.setEnable(AValue: boolean);
begin
  setValue('enabled', AValue);
end;

constructor TAnnotationLabel.Create;
begin
  inherited Create;
  setValue('rotation', 'auto');
  setValue('position', 'start');
  setValue('backgroundColor', 'transparent');
  setValue('color', 'black');
end;

{ TChartPluginAnnotations }

function TChartPluginAnnotations.getItems(idx: integer): TChartPluginLineAnnotation;
begin
  Result := Objects[idx] as TChartPluginLineAnnotation;
end;

procedure TChartPluginAnnotations.setItems(idx: integer; AValue: TChartPluginLineAnnotation);
begin
  Objects[idx] := AValue;
end;

{ TChartPluginLineAnnotation }

function TChartPluginLineAnnotation.getAnnotationLabel: TAnnotationLabel;
var
  item: TJSONObject;
begin
  GetValue('label', item);
  if (item = nil) then
  begin
    item := TAnnotationLabel.Create;
    setValue('label', item);
  end;
  Result := item as TAnnotationLabel;
end;

function TChartPluginLineAnnotation.getBoderColor: string;
begin
  getValue('borderColor', Result);
end;

function TChartPluginLineAnnotation.getScaleID: string;
begin
  getValue('scaleID', Result);
end;

function TChartPluginLineAnnotation.getAnnotatinValue: string;
begin
  getValue('value', Result);
end;

procedure TChartPluginLineAnnotation.setBorderColor(AValue: string);
begin
  setValue('borderColor', AValue);
end;

procedure TChartPluginLineAnnotation.setScaleID(AValue: string);
begin
  setValue('scaleID', AValue);
end;

procedure TChartPluginLineAnnotation.setAnnotatinValue(AValue: string);
begin
  setValue('value', AValue);
end;

constructor TChartPluginLineAnnotation.Create;
begin
  inherited Create;
  setValue('type', 'line');
  setValue('display', True);
  SetValue('color', 'rgba(0,0,0,0.5)');
end;

{ TChartPluginAnnotation }

function TChartPluginAnnotation.getAnnotations: TChartPluginAnnotations;
var
  item: TJSONArray;
begin
  getValue('annotations', item);
  if item = nil then
  begin
    item := TChartPluginAnnotations.Create;
    setValue('annotations', item);
  end;
  Result := item as TChartPluginAnnotations;
end;


{ TChartTime }

function TChartTime.getTimeUnit: TChartTimeUnit;
begin
  begin
    Result := tuDay;
    try
      Result := TChartTimeUnit(GetEnumValue(TypeInfo(Result), 'tu' + find('unit').AsString));
    except
    end;
  end;
end;

procedure TChartTime.setTimeUnit(AValue: TChartTimeUnit);
var
  typeName: string;
begin
  typeName := GetEnumName(TypeInfo(AValue), Ord(AValue)).Substring(2).ToLower;
  setValue('unit', typeName);
end;

{ TChartOptionsPluginTooltip }

function TChartOptionsPluginTooltip.getCallback: TChartOptionsPluginTooltipCallbacks;
var
  obj: TJSONObject;
begin
  getValue('callback', obj);
  if obj = nil then
  begin
    obj := TChartOptionsPluginTooltipCallbacks.Create;
    setValue('callback', obj);
  end;
  Result := obj as TChartOptionsPluginTooltipCallbacks;
end;

procedure TChartOptionsPluginTooltip.setCallback(AValue: TChartOptionsPluginTooltipCallbacks);
begin
  setValue('callback', AValue);
end;

{ TChartOptionsPluginTooltipCallbacks }

function TChartOptionsPluginTooltipCallbacks.getLabel: string;
begin
  setValue('label', Result);
end;

procedure TChartOptionsPluginTooltipCallbacks.setLabel(AValue: string);
begin
  setValue('label', AValue);
end;


{ TDatasetData }

procedure TDatasetData.replace(index: integer; aValue: int64);
begin
  Items[index] := TJSONLargeIntNumber.Create(aValue);
end;

procedure TDatasetData.replace(index: integer; aValue: double);
begin
  Items[index] := TJSONFloatNumber.Create(aValue);
end;

{ TChartOptionsPluginTitle }

function TChartOptionsPluginTitle.getDisplay: boolean;
begin
  getValue('display', Result);
end;

function TChartOptionsPluginTitle.getFullScreen: boolean;
begin
  getValue('fullSize', Result);
end;

function TChartOptionsPluginTitle.getText: string;
begin
  getValue('text', Result);
end;

procedure TChartOptionsPluginTitle.setDisplay(AValue: boolean);
begin
  setValue('display', AValue);
end;

procedure TChartOptionsPluginTitle.setFullScreen(AValue: boolean);
begin
  setValue('fullSize', AValue);
end;

procedure TChartOptionsPluginTitle.setText(AValue: string);
begin
  setValue('text', AValue);
end;

{ TChartDataSetsArrayHelper }

procedure TChartDataSetsArrayHelper.internalAdd(aValue: TChartDataSet);
begin
  self.Add(aValue);
end;

function TChartDataSetsArrayHelper.newDataSet(): TChartDataSet;
begin
  Result := TChartDataSet.Create;
  internalAdd(Result);
end;

{ TChartScaleTitle }

function TChartScaleTitle.getText: string;
begin
  getValue('text', Result);
end;

function TChartScaleTitle.GetDisplay: boolean;
begin
  getValue('display', Result);
end;

procedure TChartScaleTitle.SetDisplay(AValue: boolean);
begin
  setValue('display', AValue);
end;

procedure TChartScaleTitle.setText(AValue: string);
begin
  setValue('text', AValue);
end;

constructor TChartScaleTitle.Create;
begin
  inherited Create();
  display := False;
end;

{ TChartScale }

function TChartScale.getAlignToPixels: boolean;
begin
  getValue('alignToPixels', Result);
end;

function TChartScale.getBackgroundColor: string;
begin
  getValue('backgroundColor', Result);
end;

function TChartScale.getDisplay: boolean;
begin
  getValue('display', Result);
end;

function TChartScale.getMax: double;
begin
  getValue('max', Result);
end;

function TChartScale.getMin: double;
begin
  getValue('min', Result);
end;

function TChartScale.getReverse: boolean;
begin
  getValue('reverse', Result);
end;

function TChartScale.getScaleType: string;
begin
  getValue('type', Result);
end;

function TChartScale.getStacked: boolean;
begin
  getValue('stacked', Result);
end;

function TChartScale.getSuggestedMax: double;
begin
  getValue('suggestedMax', Result);
end;

function TChartScale.getSuggestedMin: double;
begin
  getValue('suggestedMin', Result);
end;

function TChartScale.getTicks: TChartScaleTicks;
var
  o: TJSONObject;
begin
  getValue('ticks', o);
  Result := o as TChartScaleTicks;
  if Result = nil then
  begin
    Result := TChartScaleTicks.Create;
    ticks := Result;
  end;
end;

function TChartScale.getTitle: TChartScaleTitle;
var
  o: TJSONObject;
begin
  getValue('title', o);
  Result := o as TChartScaleTitle;
  if Result = nil then
  begin
    Result := TChartScaleTitle.Create;
    title := Result;
  end;
end;

function TChartScale.getUnit: TChartTime;
var
  o: TJSONObject;
begin
  getValue('unit', o);
  Result := o as TChartTime;
  if (Result = nil) then
  begin
    Result := TChartTime.Create;
    setValue('unit', Result);
  end;
end;

function TChartScale.getWeight: double;
begin
  getValue('weight', Result);
end;

procedure TChartScale.setAlignToPixels(AValue: boolean);
begin
  setValue('alignToPixels', AValue);
end;

procedure TChartScale.setBackgroundColor(AValue: string);
begin
  setValue('backgroundColor', AValue);
end;

procedure TChartScale.setDisplay(AValue: boolean);
begin
  setValue('display', AValue);
end;

procedure TChartScale.setMax(AValue: double);
begin
  setValue('max', AValue);
end;

procedure TChartScale.setMin(AValue: double);
begin
  setValue('min', AValue);
end;

procedure TChartScale.setReverse(AValue: boolean);
begin
  setValue('reverse', AValue);
end;

procedure TChartScale.setScaleType(AValue: string);
begin
  setValue('type', AValue);
end;

procedure TChartScale.setStacked(AValue: boolean);
begin
  setValue('stacked', AValue);
end;

procedure TChartScale.setSuggestedMax(AValue: double);
begin
  setValue('suggestedMax', AValue);
end;

procedure TChartScale.setSuggestedMin(AValue: double);
begin
  setValue('suggestedMin', AValue);
end;

procedure TChartScale.setTicks(AValue: TChartScaleTicks);
begin
  setValue('ticks', AValue);
end;

procedure TChartScale.setTitle(AValue: TChartScaleTitle);
begin
  setValue('title', AValue);
end;

procedure TChartScale.setUnit(AValue: TChartTime);
begin
  setValue('unit', AValue);
end;

procedure TChartScale.setWeight(AValue: double);
begin
  setValue('weight', AValue);
end;

constructor TChartScale.Create;
begin
  inherited Create();
  min := 0.0;
  suggestedMin := 0.0;
end;

{ TChartScales }

function TChartScales.Getscales(Name: string): TChartScale;
var
  item: TJSONObject;
begin
  getValue(Name, item);
  if (item = nil) then
  begin
    item := TChartScale.Create;
    setValue(Name, item);
  end;
  Result := item as TChartScale;
end;

procedure TChartScales.Setscales(Name: string; AValue: TChartScale);
begin
  setValue(Name, AValue);
end;

{ TChartDataSets }

function TChartDataSets.GetDataset(Index: integer): TChartDataSet;
begin
  Result := Objects[index] as TChartDataSet;
end;

procedure TChartDataSets.SetDataset(Index: integer; AValue: TChartDataSet);
begin
  Objects[index] := AValue;
end;

{ TChartPlugin }

function TChartPlugin.getAnnotation: TChartPluginAnnotation;
var
  item: TJSONObject = nil;
begin
  getValue('annotation', item);
  if (item = nil) then
  begin
    item := TChartPluginAnnotation.Create();
    setValue('annotation', item);
  end;
  Result := item as TChartPluginAnnotation;
end;

function TChartPlugin.getSubtitlePlugin: TChartOptionsPluginTitle;
var
  obj: TJSONObject;
begin
  getValue('subtitle', obj);
  if obj = nil then
  begin
    obj := TChartOptionsPluginTitle.Create;
    setValue('subtitle', obj);
  end;
  Result := obj as TChartOptionsPluginTitle;
end;

function TChartPlugin.getTitlePlugin: TChartOptionsPluginTitle;
var
  obj: TJSONObject;
begin
  getValue('title', obj);
  if obj = nil then
  begin
    obj := TChartOptionsPluginTitle.Create;
    setValue('title', obj);
  end;
  Result := obj as TChartOptionsPluginTitle;
end;

function TChartPlugin.getTooltip: TChartOptionsPluginTooltip;
var
  obj: TJSONObject;
begin
  getValue('tooltip', obj);
  if obj = nil then
  begin
    obj := TChartOptionsPluginTooltip.Create;
    setValue('tooltip', obj);
  end;
  Result := obj as TChartOptionsPluginTooltip;
end;

{ TChartScaleTicks }

function TChartScaleTicks.getBeginAtZero: boolean;
begin
  getValue('beginAtZero', Result);
end;

function TChartScaleTicks.getCallback: string;
begin
  getValue('callback', Result);
end;

function TChartScaleTicks.getMaxRotation: double;
begin
  getValue('maxRotation', Result);
end;

function TChartScaleTicks.getMinRotation: double;
begin
  getValue('minRotation', Result);
end;

function TChartScaleTicks.getSampleSize: double;
begin
  getValue('sampleSize', Result);
end;

procedure TChartScaleTicks.setBeginAtZero(AValue: boolean);
begin
  setValue('beginAtZero', AValue);
end;

procedure TChartScaleTicks.setCallback(AValue: string);
begin
  setValue('callback', AValue);
end;

procedure TChartScaleTicks.setMaxRotation(AValue: double);
begin
  setValue('maxRotation', AValue);
end;

procedure TChartScaleTicks.setMinRotation(AValue: double);
begin
  setValue('minRotation', AValue);
end;

procedure TChartScaleTicks.setSampleSize(AValue: double);
begin
  setValue('sampleSize', AValue);
end;

constructor TChartScaleTicks.Create;
begin
  inherited Create;
  maxRotation := 90;
  minRotation := 90;
end;

{ TChartOptions }

function TChartOptions.getIndexAxis: string;
begin
  getValue('indexAxis', Result);
end;

function TChartOptions.getPlugin: TChartPlugin;
var
  item: TJSONObject = nil;
begin
  getValue('plugins', item);
  if (item = nil) then
  begin
    item := TChartPlugin.Create();
    setValue('plugins', item);
  end;
  Result := item as TChartPlugin;
end;

function TChartOptions.getResponsive: boolean;
begin
  getValue('responsive', Result);
end;

function TChartOptions.getScales: TChartScales;
var
  item: TJSONObject;
begin
  getValue('scales', item);
  if (item = nil) then
  begin
    item := TChartScales.Create();
    setValue('scales', item);
  end;
  Result := item as TChartScales;
end;

function TChartOptions.getShowLines: boolean;
begin
  getValue('showLines', Result);
end;

procedure TChartOptions.setIndexAxis(AValue: string);
begin
  setValue('indexAxis', AValue);
end;

procedure TChartOptions.setResponsive(AValue: boolean);
begin
  setValue('responsive', AValue);
end;

procedure TChartOptions.setShowLines(AValue: boolean);
begin
  setValue('showLines', AValue);
end;

{ TChartDataSet }

function TChartDataSet.getBarPercentage: double;
begin
  getValue('barPercentage', Result);
end;

function TChartDataSet.getCategoryPercentage: double;
begin
  getValue('categoryPercentage', Result);
end;

function TChartDataSet.getFill: boolean;
begin
  getValue('fill', Result);
end;

function TChartDataSet.getOrder: integer;
begin
  getValue('order', Result);
end;

function TChartDataSet.getPointBackgroundColor: string;
begin
  getValue('pointBackgroundColor', Result);
end;

function TChartDataSet.getPointBorderColor: string;
begin
  getValue('pointBorderColor', Result);
end;

function TChartDataSet.getPointBorderWidth: integer;
begin
  getValue('pointBorderWidth', Result);
end;

function TChartDataSet.getPointRadius: integer;
begin
  getValue('pointRadius', Result);
end;

function TChartDataSet.getBackgroundColor: string;
begin
  getValue('backgroundColor', Result);
end;

function TChartDataSet.getBorderWidth: integer;
begin
  getValue('borderWidth', Result);
end;

function TChartDataSet.getBorderColor: string;
begin
  getValue('borderColor', Result);
end;

function TChartDataSet.getChartType: TChartType;
begin
  Result := ctLine;
  try
    Result := TChartType(GetEnumValue(TypeInfo(Result), 'ct' + find('type').AsString));
  except
  end;
end;

function TChartDataSet.getData: TDatasetData;
var
  item: TJSONData;
begin
  item := find('data');
  Result := item as TDatasetData;
end;

function TChartDataSet.getHidden: boolean;
begin
  Result := False;
  getValue('hidden', Result);
end;

function TChartDataSet.getHideInLegendAndTooltip: boolean;
begin
  Result := False;
  getValue('hideInLegendAndTooltip', Result);
end;

function TChartDataSet.getLabel: string;
begin
  Result := '';
  getValue('label', Result);
end;

function TChartDataSet.getShowLine: boolean;
begin
  Result := False;
  getValue('showLine', Result);
end;

function TChartDataSet.getStack: string;
begin
  Result := '';
  getValue('stack', Result);
end;

function TChartDataSet.getWeight: double;
begin
  Result := 0.0;
  getValue('weight', Result);
end;

function TChartDataSet.getXAxis: string;
begin
  getValue('xAxis', Result);
end;

function TChartDataSet.getYAxis: string;
begin
  getValue('yAxis', Result);
end;

procedure TChartDataSet.SetBackgroundColor(AValue: string);
begin
  setValue('backgroundColor', AValue);
end;

procedure TChartDataSet.setBarPercentage(AValue: double);
begin
  setValue('barPercentage', AValue);
end;

procedure TChartDataSet.SetBorderColor(AValue: string);
begin
  setValue('borderColor', AValue);
end;

procedure TChartDataSet.SetBorderWidth(AValue: integer);
begin
  setValue('borderWidth', AValue);
end;

procedure TChartDataSet.setCategoryPercentage(AValue: double);
begin
  setValue('categoryPercentage', AValue);
end;

procedure TChartDataSet.setChartType(AValue: TChartType);
var
  charTypeName: string;
begin
  charTypeName := GetEnumName(TypeInfo(AValue), Ord(AValue)).Substring(2).ToLower;
  setValue('type', charTypeName);
end;

procedure TChartDataSet.SetFill(AValue: boolean);
begin
  setValue('fill', AValue);
end;

procedure TChartDataSet.setHidden(AValue: boolean);
begin
  setValue('hidden', AValue);
end;

procedure TChartDataSet.setHideInLegendAndTooltip(AValue: boolean);
begin
  setValue('hideInLegendAndTooltip', AValue);
end;

procedure TChartDataSet.setLabel(AValue: string);
begin
  setValue('label', AValue);
end;

procedure TChartDataSet.setOrder(AValue: integer);
begin
  setValue('order', AValue);
end;

procedure TChartDataSet.SetpointBackgroundColor(AValue: string);
begin
  setValue('pointBackgroundColor', AValue);
end;

procedure TChartDataSet.SetpointBorderColor(AValue: string);
begin
  setValue('pointBorderColor', AValue);
end;

procedure TChartDataSet.SetpointBorderWidth(AValue: integer);
begin
  setValue('pointBorderWidth', AValue);
end;

procedure TChartDataSet.SetPointRadius(AValue: integer);
begin
  setValue('pointRadius', AValue);
end;

procedure TChartDataSet.setShowLine(AValue: boolean);
begin
  setValue('showLine', AValue);
end;

procedure TChartDataSet.setStack(AValue: string);
begin
  setValue('stack', AValue);
end;

procedure TChartDataSet.setWeight(AValue: double);
begin
  setValue('weight', AValue);
end;

procedure TChartDataSet.setXAxis(AValue: string);
begin
  setValue('xAxis', AValue);
end;

procedure TChartDataSet.setYAxis(AValue: string);
begin
  setValue('yAxis', AValue);
end;

constructor TChartDataSet.Create;
begin
  inherited Create;
  Add('data', TDatasetData.Create);
  setChartType(ctLine);
end;

{ TChartData }

function TChartData.GetDatasets: TChartDataSets;
begin
  Result := find('datasets') as TChartDataSets;
end;

function TChartData.GetLabels: TLabels;
begin
  Result := find('labels') as TLabels;
end;

constructor TChartData.Create;
begin
  inherited Create;
  add('labels', TLabels.Create);
  add('datasets', TChartDataSets.Create);
end;


{ TChartConfiguration }

constructor TChartConfiguration.Create;
begin
  inherited Create;
  chartType := ctLine;
  Add('data', TChartData.Create);
  options.getScales.scales['xAxes'].min := 0.0;
  options.getScales.scales['yAxes'].ticks.beginAtZero := True;
  options.getScales.scales['yAxes'].min := 0.0;
end;

function TChartConfiguration.getCharOptions: TChartOptions;
var
  item: TJSONObject;
begin
  getValue('options', item);
  if item = nil then
  begin
    item := TChartOptions.Create;
    Objects['options'] := item;
  end;
  Result := item as TChartOptions;
end;

function TChartConfiguration.getChartType: TChartType;
begin
  Result := ctLine;
  try
    Result := TChartType(GetEnumValue(TypeInfo(Result), 'ct' + find('type').AsString));
  except
  end;
end;

function TChartConfiguration.getData: TChartData;
var
  item: TJSONData;
begin
  item := find('data');
  Result := item as TChartData;
end;

procedure TChartConfiguration.setChartType(AValue: TChartType);
var
  charTypeName: string;
begin
  charTypeName := GetEnumName(TypeInfo(AValue), Ord(AValue)).Substring(2).ToLower;
  setValue('type', charTypeName);
end;

end.
