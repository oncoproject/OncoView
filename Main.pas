unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  System.zip,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, System.Actions,
  Vcl.ActnList, Vcl.ComCtrls, System.ImageList, Vcl.ImgList, VclTee.TeEngine,
  Vcl.ExtCtrls, VclTee.TeeProcs, VclTee.Chart, Vcl.ToolWin, registry,

  InfoDataUnit, Vcl.Grids, Vcl.ValEdit, Vcl.StdCtrls, VclTee.Series;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    LV: TListView;
    MainPageControl: TPageControl;
    InfoSheet: TTabSheet;
    KalibrSheet: TTabSheet;
    MeasSheet: TTabSheet;
    KalibrChart: TChart;
    PomiarChart: TChart;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ToolButton1: TToolButton;
    actOpen: TAction;
    CfgStmSheet: TTabSheet;
    KalibrTabControl: TTabControl;
    StmVLE: TValueListEditor;
    CalibrVLE: TValueListEditor;
    PatiendIdText: TStaticText;
    Label1: TLabel;
    Label2: TLabel;
    DateText: TStaticText;
    MeasKalibrGrid: TStringGrid;
    Label3: TLabel;
    PomiarVLE: TValueListEditor;
    PomiarSer1: TLineSeries;
    PomiarSer2: TLineSeries;
    KalibrSeries: TLineSeries;
    KalibrRightSeries: TLineSeries;
    Panel1: TPanel;
    LedsPB: TPaintBox;
    Panel2: TPanel;
    KalibrShowPointsBox: TCheckBox;
    MeasDystPomBox: TCheckBox;
    GridLeftBox: TCheckBox;
    GridRightBox: TCheckBox;
    GridBottomBox: TCheckBox;
    PaintOnMouseMove: TCheckBox;
    PaintLedLineBox: TCheckBox;
    Memo1: TMemo;
    HelpPanel: TPanel;
    HideHelpBtn: TButton;
    ToolButton2: TToolButton;
    actShowHelp: TAction;
    PomMeasGrid: TStringGrid;
    ToolButton3: TToolButton;
    actSaveCsv: TAction;
    Splitter1: TSplitter;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    actUndoZoom: TAction;
    actZoomInTime: TAction;
    actZoomOutTime: TAction;
    KalibrDystPomBox: TCheckBox;
    Label4: TLabel;
    WersjaDanychText: TStaticText;
    Grid0BottomBox: TCheckBox;
    Grid0LeftBox: TCheckBox;
    Grid0RightBox: TCheckBox;
    PasLaserSheet: TTabSheet;
    PasLaserChart: TChart;
    PasLaserTabSeries: TLineSeries;
    Panel3: TPanel;
    PasLaserShowPointsBox: TCheckBox;
    GridPLBottomBox: TCheckBox;
    GridPLLeftBox: TCheckBox;
    GridPLRightBox: TCheckBox;
    KalibrLaserBox: TCheckBox;
    procedure LVDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InfoSheetShow(Sender: TObject);
    procedure MeasSheetShow(Sender: TObject);
    procedure KalibrSheetShow(Sender: TObject);
    procedure KalibrTabControlChange(Sender: TObject);
    procedure CfgStmSheetShow(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure KalibrChartAfterDraw(Sender: TObject);
    procedure KalibrShowPointsBoxClick(Sender: TObject);
    procedure LedsPBPaint(Sender: TObject);
    procedure PomiarChartAfterDraw(Sender: TObject);
    procedure MeasDystPomBoxClick(Sender: TObject);
    procedure PomiarChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure KalibrChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GridLeftBoxClick(Sender: TObject);
    procedure GridRightBoxClick(Sender: TObject);
    procedure HideHelpBtnClick(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actShowHelpExecute(Sender: TObject);
    procedure actSaveCsvUpdate(Sender: TObject);
    procedure actSaveCsvExecute(Sender: TObject);
    procedure GridBottomBoxClick(Sender: TObject);
    procedure PomiarChartMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure PaintLedLineBoxClick(Sender: TObject);
    procedure actZoomInTimeUpdate(Sender: TObject);
    procedure actUndoZoomExecute(Sender: TObject);
    procedure actZoomInTimeExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actZoomOutTimeExecute(Sender: TObject);
    procedure KalibrDystPomBoxClick(Sender: TObject);
    procedure Grid0BottomBoxClick(Sender: TObject);
    procedure Grid0LeftBoxClick(Sender: TObject);
    procedure Grid0RightBoxClick(Sender: TObject);
    procedure LVCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure PasLaserSheetShow(Sender: TObject);
    procedure PasLaserShowPointsBoxClick(Sender: TObject);
    procedure GridPLBottomBoxClick(Sender: TObject);
    procedure GridPLLeftBoxClick(Sender: TObject);
    procedure GridPLRightBoxClick(Sender: TObject);
    procedure KalibrLaserBoxClick(Sender: TObject);

  type
    TKalibrChartDt = record
      mouse_x: Integer;
      mouse_y: Integer;
      valX: double;
      valY_L: double;
      valY_R: double;
      procedure setPos(Chart: TChart; X, Y: Integer);
    end;

  private

    mViewData: TOncoObject;
    mLedState: byte;
    kalibrChartDt: TKalibrChartDt;
    pomiarChartDt1: TKalibrChartDt;
    pomiarChartDt2: TKalibrChartDt;
    procedure OpenOnpFile(Fname: string);
    procedure OpenZipFile(Fname: string);
    procedure FillKalibrTabControl;
    function getChartWorkRect(Chart: TChart): TRect;
    procedure DrawChartCursor(Chart: TChart; const dt: TKalibrChartDt; color: TColor);
    procedure SaveMeasDataToCvs(Fname: string);
    procedure LiczLeds(X: Integer);
    procedure saveToReg;
    procedure loadFromReg;
    procedure ZoomTime(m: double);
    procedure LoadKalibrRightSeries;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  MEAS_PER_SEK = 50.0; // 50 pomiarów na sekundê
  MEAS_PER_SEK_DIV = 10.0; // 10 pomiarów na sekundê
  REG_KEY = '\SOFTWARE\ONCOPROJECT\VIEWER';

function YesNoStr(q: boolean): string;
begin
  if q then
    Result := 'YES'
  else
    Result := 'NO';
end;

procedure TForm1.TKalibrChartDt.setPos(Chart: TChart; X, Y: Integer);
begin
  if (mouse_x <> X) or (mouse_y <> Y) then
  begin
    valX := Chart.BottomAxis.CalcPosPoint(X);
    valY_L := Chart.LeftAxis.CalcPosPoint(Y);
    valY_R := Chart.RightAxis.CalcPosPoint(Y);
    mouse_x := X;
    mouse_y := Y;
    Chart.Invalidate;
  end;

end;


// ------------------------------------------------------------------------------
// TForm1
// ------------------------------------------------------------------------------

procedure TForm1.saveToReg;
var
  registry: TRegistry;
begin
  registry := TRegistry.Create;
  try
    if registry.OpenKey(REG_KEY, true) then
    begin
      if WindowState = wsNormal then
      begin
        registry.WriteInteger('Top', Top);
        registry.WriteInteger('Left', Left);
      end;
      registry.WriteInteger('LV_WIDTH', LV.Width);
      registry.WriteInteger('LV_1Col_WIDTH', LV.Columns[0].Width);
      registry.WriteInteger('LV_2Col_WIDTH', LV.Columns[1].Width);

      registry.WriteBool('MeasDystPomBox', MeasDystPomBox.Checked);
      registry.WriteBool('KalibrShowPointsBox', KalibrShowPointsBox.Checked);
      registry.WriteBool('PaintOnMouseMove', PaintOnMouseMove.Checked);
      registry.WriteBool('PaintLedLineBox', PaintLedLineBox.Checked);
      registry.WriteBool('KalibrDystPomBox', KalibrDystPomBox.Checked);
      registry.WriteBool('KalibrLaserBox', KalibrLaserBox.Checked);
      registry.WriteBool('GridLeftBox', GridLeftBox.Checked);
      registry.WriteBool('GridRightBox', GridRightBox.Checked);
      registry.WriteBool('GridBottomBox', GridBottomBox.Checked);
      registry.WriteBool('Grid0LeftBox', Grid0LeftBox.Checked);
      registry.WriteBool('Grid0RightBox', Grid0RightBox.Checked);
      registry.WriteBool('Grid0BottomBox', Grid0BottomBox.Checked);

    end;
  finally
    registry.Free;
  end;
end;

procedure TForm1.loadFromReg;
var
  registry: TRegistry;

  function RegInt(KeyName: string; Default: Integer): Integer;
  begin
    if registry.ValueExists(KeyName) then
      Result := registry.ReadInteger(KeyName)
    else
      Result := Default;
  end;
  function RegBool(KeyName: string; Default: boolean): boolean;
  begin
    if registry.ValueExists(KeyName) then
      Result := registry.ReadBool(KeyName)
    else
      Result := Default;
  end;

  procedure RegCheckBox(KeyName: string; box: TCheckBox);
  begin
    if registry.ValueExists(KeyName) then
      box.Checked := registry.ReadBool(KeyName);
  end;

begin
  registry := TRegistry.Create;
  try
    if registry.OpenKey(REG_KEY, true) then
    begin
      Top := RegInt('Top', Top);
      Left := RegInt('Left', Left);
      LV.Width := RegInt('LV_WIDTH', LV.Width);
      LV.Columns[0].Width := RegInt('LV_1Col_WIDTH', LV.Columns[0].Width);
      LV.Columns[1].Width := RegInt('LV_2Col_WIDTH', LV.Columns[1].Width);

      RegCheckBox('MeasDystPomBox', MeasDystPomBox);
      RegCheckBox('KalibrShowPointsBox', KalibrShowPointsBox);
      RegCheckBox('GridLeftBox', GridLeftBox);
      RegCheckBox('GridRightBox', GridRightBox);
      RegCheckBox('GridBottomBox', GridBottomBox);
      RegCheckBox('PaintOnMouseMove', PaintOnMouseMove);
      RegCheckBox('PaintLedLineBox', PaintLedLineBox);
      RegCheckBox('KalibrDystPomBox', KalibrDystPomBox);
      RegCheckBox('KalibrLaserBox', KalibrLaserBox);
      RegCheckBox('Grid0LeftBox', Grid0LeftBox);
      RegCheckBox('Grid0RightBox', Grid0RightBox);
      RegCheckBox('Grid0BottomBox', Grid0BottomBox);

    end;
  finally
    registry.Free;
  end;
end;

procedure TForm1.actOpenExecute(Sender: TObject);
var
  dlg: TOpenDialog;
  Fname: string;
  Ext: string;

begin
  Fname := '';
  dlg := TOpenDialog.Create(self);
  try
    dlg.Filter := 'Pliki OncoProject|*.onp|Pliki zip|*.zip|Wszystkie pliki|*.*';
    if dlg.Execute then
    begin
      Fname := dlg.FileName
    end;
  finally
    dlg.Free;
  end;
  if Fname <> '' then
  begin
    Ext := ExtractFileExt(Fname);
    if Ext = '.onp' then
    begin
      OpenOnpFile(Fname);
    end
    else if Ext = '.zip' then
    begin
      OpenZipFile(Fname);
    end;
    if Assigned(LV.Selected) then
      LVDblClick(nil);
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  mViewData := nil;
  loadFromReg;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  saveToReg;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  MeasKalibrGrid.Rows[0].CommaText := 'lp. "Pomiar 1" "Pomiar 2" "Pomiar 3"';
  MeasKalibrGrid.Cols[0].CommaText := 'lp. Min Max Amplituda';
  PomMeasGrid.Rows[0].CommaText := 'lp. Czas Dystans "Dyst.pom" Ró¿nica';
  PomMeasGrid.Cols[0].CommaText := 'lp. kursor odniesienie ró¿nica';
  PasLaserSheet.PageControl := nil;
end;

procedure TForm1.LVCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
var
  d1, d2: TOncoObject;
  s1, s2: string;
begin
  d1 := TOncoObject(Item1.Data);
  d2 := TOncoObject(Item2.Data);
  s1 := d1.Info.measTime;
  s2 := d2.Info.measTime;
  if s1 > s2 then
    Compare := -1
  else if s1 < s2 then
    Compare := 1
  else
    Compare := 0;

end;

procedure TForm1.LVDblClick(Sender: TObject);
begin
  if Assigned(LV.Selected) then
  begin
    mViewData := TOncoObject(LV.Selected.Data);
    MainPageControl.ActivePage.OnShow(nil);
  end;
end;

procedure TForm1.OpenOnpFile(Fname: string);
var
  OncoObject: TOncoObject;
  LI: TListItem;
begin
  OncoObject := TOncoObject.Create;
  if OncoObject.LoadFromFile(Fname) then
  begin
    LI := LV.Items.Add;
    LI.Caption := OncoObject.Info.patientID;
    LI.SubItems.Add(OncoObject.Info.measTime);
    LI.Data := OncoObject;
    LI.Selected := true;
    if OncoObject.TeachData.isRdy then
      PasLaserSheet.PageControl := MainPageControl
    else
      PasLaserSheet.PageControl := nil;
  end
  else
    OncoObject.Free;
end;

procedure TForm1.OpenZipFile(Fname: string);
var
  zip: TZipFile;
  i: Integer;
  s: string;
  OncoObject: TOncoObject;
  Stream: TStream;
  LocalHeader: TZipHeader;
  LI: TListItem;
begin
  zip := TZipFile.Create;
  try
    zip.Open(Fname, zmRead);
    for i := 0 to zip.FileCount - 1 do
    begin
      s := zip.FileName[i];
      OncoObject := TOncoObject.Create;

      try
        zip.Read(s, Stream, LocalHeader);
        OncoObject.LoadFrom(Stream);

        LI := LV.Items.Add;
        LI.Caption := OncoObject.Info.patientID;
        LI.SubItems.Add(OncoObject.Info.measTime);
        LI.Data := OncoObject;
        if i = 0 then
          LI.Selected := true;

      finally
        Stream.Free;
      end;

    end;

  finally
    zip.Free;
  end;

end;

procedure TForm1.LedsPBPaint(Sender: TObject);
  procedure PanitLedBox(idx: Integer; posX: single; state: boolean);
  const
    MARG = 5;
    TabColor: array [0 .. 7] of TColor = (clRED, clRED, clRED, clRED, clLIME, clLIME, clLIME, clRED);
  var
    R: TRect;
    color: TColor;
  begin
    R.Left := MARG;
    R.Right := LedsPB.Width - MARG;
    R.Top := trunc(posX + MARG);
    R.Bottom := trunc(posX + LedsPB.Height / 8 - MARG);

    LedsPB.Canvas.Pen.Style := psSolid;
    LedsPB.Canvas.Pen.color := clBlack;
    LedsPB.Canvas.Pen.Width := 2;

    LedsPB.Canvas.Brush.Style := bsSolid;
    if state then
      color := TabColor[idx]
    else
      color := clGray;

    LedsPB.Canvas.Brush.color := color;
    LedsPB.Canvas.FillRect(R);
  end;

var
  dh: single;
  i: Integer;
begin
  dh := LedsPB.Height / 8;
  for i := 0 to 7 do
  begin
    PanitLedBox(i, dh * (7 - i), (mLedState and (1 shl i)) <> 0);
  end;

end;

procedure TForm1.KalibrTabControlChange(Sender: TObject);
begin
  FillKalibrTabControl;
end;

procedure TForm1.FillKalibrTabControl;
var
  chNr: Integer;
  chn: TOncoInfo.TCalibrChan;
const
  TabUnits: array [0 .. TOncoInfo.CHANNEL_CNT - 1] of String = ('mm', 'Pa', '%', 'mm');
begin
  if Assigned(mViewData) then
  begin
    chNr := KalibrTabControl.TabIndex;
    chn := mViewData.Info.StmCfg.Calibr.Chan[chNr];
    CalibrVLE.Values['Wspó³.A'] := FormatFloat('0.0000', chn.wspol_a);
    CalibrVLE.Values['Wspó³.B'] := FormatFloat('0.0000', chn.wspol_b);

    CalibrVLE.Values['Pt.0 - w.wartoœc zmierzona'] := FormatFloat('0.00', chn.CalibrPt[0].valMeas) + '[%]';
    CalibrVLE.Values['Pt.0 - w.wartoœc zadana'] := FormatFloat('0.00', chn.CalibrPt[0].valFiz) + '[' +
      TabUnits[chNr] + ']';
    CalibrVLE.Values['Pt.1 - w.wartoœc zmierzona'] := FormatFloat('0.00', chn.CalibrPt[1].valMeas) + '[%]';
    CalibrVLE.Values['Pt.1 - w.wartoœc zadana'] := FormatFloat('0.00', chn.CalibrPt[1].valFiz) + '[' +
      TabUnits[chNr] + ']';
  end;
end;

function DistStr(f: single): string;
begin
  Result := FormatFloat('0.00', f) + ' [mm]';
end;

procedure TForm1.actSaveCsvUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := Assigned(mViewData);
end;

procedure TForm1.actSaveCsvExecute(Sender: TObject);
var
  dlg: TSaveDialog;
begin
  dlg := TSaveDialog.Create(self);
  try
    dlg.Filter := 'Pliki Excel|*.csv|Wszystkie pliki|*.*';
    dlg.DefaultExt := 'csv';
    dlg.FileName := mViewData.Info.patientID + '_' + mViewData.Info.measTime;
    if dlg.Execute then
    begin
      SaveMeasDataToCvs(dlg.FileName);

    end;
  finally
    dlg.Free;
  end;
end;

procedure TForm1.SaveMeasDataToCvs(Fname: string);
var
  SL: TStringList;
  SL2: TStringList;
  n, i: Integer;
  s: string;
begin
  SL := TStringList.Create;
  SL2 := TStringList.Create;
  try
    n := length(mViewData.MeasData) div 2;
    for i := 0 to n - 1 do
    begin
      SL2.Clear;
      SL2.Add(IntToStr(i));
      SL2.Add(FormatFloat('0.000', i / MEAS_PER_SEK_DIV));
      SL2.Add(FormatFloat('0.000', mViewData.MeasData[2 * i + 0]));
      SL2.Add(FormatFloat('0.000', mViewData.MeasData[2 * i + 1]));
      s := SL2.CommaText;
      SL.Add(s);
    end;
    SL.SaveToFile(Fname);
  finally
    SL.Free;
    SL2.Free;
  end;
end;

procedure TForm1.actShowHelpExecute(Sender: TObject);
begin
  HelpPanel.Visible := not HelpPanel.Visible;
end;

procedure TForm1.actUndoZoomExecute(Sender: TObject);
var
  Chart: TChart;
begin
  case MainPageControl.ActivePageIndex of
    1:
      Chart := KalibrChart;
    2:
      Chart := PomiarChart;
  else
    Chart := nil;
  end;
  if Assigned(Chart) then
  begin
    Chart.UndoZoom;
  end;
end;

procedure TForm1.ZoomTime(m: double);
var
  Chart: TChart;
  R: TRect;
  dx, sx: Integer;
begin
  case MainPageControl.ActivePageIndex of
    1:
      Chart := KalibrChart;
    2:
      Chart := PomiarChart;
  else
    Chart := nil;
  end;
  if Assigned(Chart) then
  begin
    R := Chart.ChartRect;
    sx := R.CenterPoint.X;
    dx := R.Width div 2;
    dx := round(m * dx);
    R.Left := sx - dx;
    R.Right := sx + dx;
    Chart.ZoomRect(R);
  end;
end;

procedure TForm1.actZoomInTimeExecute(Sender: TObject);
begin
  ZoomTime(0.8);
end;

procedure TForm1.actZoomOutTimeExecute(Sender: TObject);
begin
  ZoomTime(1 / 0.8);
end;

procedure TForm1.actZoomInTimeUpdate(Sender: TObject);
var
  q: boolean;
begin
  q := (MainPageControl.ActivePageIndex = 1) or (MainPageControl.ActivePageIndex = 2);
  q := q and Assigned(mViewData);

  (Sender as TAction).Enabled := q;
end;

procedure TForm1.CfgStmSheetShow(Sender: TObject);
var
  Cfg: TOncoInfo.TStmCfg;
  i: Integer;
begin
  if Assigned(mViewData) then
  begin
    FillKalibrTabControl;
    Cfg := mViewData.Info.StmCfg;
    StmVLE.Values['tcp_ip'] := Cfg.TcpCfg.tcp_ip;
    StmVLE.Values['tcp_mask'] := Cfg.TcpCfg.tcp_mask;
    StmVLE.Values['tcp_gw'] := Cfg.TcpCfg.tcp_gw;

    StmVLE.Values['DistanceChannelNr'] := IntToStr(Cfg.SpecSett.distanceChannelNr);
    StmVLE.Values['PressureChannelNr'] := IntToStr(Cfg.SpecSett.pressureChannelNr);
    StmVLE.Values['TestDistChannelNr'] := IntToStr(Cfg.SpecSett.testDistChannelNr);

    StmVLE.Values['PressurePmax'] := FloatToStr(Cfg.Limits.pressurePmax);
    StmVLE.Values['DistHmax'] := DistStr(Cfg.Limits.distHmax);
    StmVLE.Values['TimeT1d'] := FloatToStr(Cfg.Limits.timeT1d);
    StmVLE.Values['TimeT1u'] := FloatToStr(Cfg.Limits.timeT1u);
    StmVLE.Values['DistH1'] := DistStr(Cfg.Param.distH1);
    StmVLE.Values['DistH2'] := DistStr(Cfg.Param.distH2);
    StmVLE.Values['DistH3'] := DistStr(Cfg.Param.distH3);
    StmVLE.Values['DistH4'] := DistStr(Cfg.Param.distH4);
    StmVLE.Values['DistH5'] := DistStr(Cfg.Param.distH5);
    StmVLE.Values['DistH6'] := DistStr(Cfg.Param.distH6);
    StmVLE.Values['DistH7'] := DistStr(Cfg.Param.distH7);
    StmVLE.Values['DistHw'] := DistStr(Cfg.Param.distHw);
    StmVLE.Values['DistH11'] := DistStr(Cfg.Param.distH11);
    StmVLE.Values['PressureP1'] := FloatToStr(Cfg.Param.pressureP1);
    StmVLE.Values['PressureP2'] := FloatToStr(Cfg.Param.pressureP2);
    StmVLE.Values['TimeT4'] := FloatToStr(Cfg.Param.timeT4);
    StmVLE.Values['MinBreathPerMin'] := FloatToStr(Cfg.Param.minBreathPerMin);
    StmVLE.Values['MaxBreathPerMin'] := FloatToStr(Cfg.Param.maxBreathPerMin);
    StmVLE.Values['ConfigAfterChart'] := YesNoStr(Cfg.Param.configAfterChart);
    for i := 0 to TOncoInfo.TAB_STEP_LEN - 1 do
    begin
      StmVLE.Values['Led_step_' + IntToStr(i)] := DistStr(Cfg.Param.TabStep[i]);
    end;

  end;

end;

procedure TForm1.InfoSheetShow(Sender: TObject);
var
  i: Integer;
  Kalibr: TOncoInfo.TMeasKalibrRec;
begin
  if Assigned(mViewData) then
  begin
    PatiendIdText.Caption := mViewData.Info.patientID;
    DateText.Caption := mViewData.Info.measTime;
    WersjaDanychText.Caption := IntToStr(mViewData.Info.DataVer);

    Kalibr := mViewData.Info.MeasKalibrRec;

    for i := 0 to TOncoInfo.POINT_CNT - 1 do
    begin
      MeasKalibrGrid.Cells[1 + i, 1] := FormatFloat('0.00', Kalibr.tabPoint[i].minVal);
      MeasKalibrGrid.Cells[1 + i, 2] := FormatFloat('0.00', Kalibr.tabPoint[i].maxVal);
      MeasKalibrGrid.Cells[1 + i, 3] := FormatFloat('0.00', Kalibr.tabPoint[i].Amplituda);
    end;

    PomiarVLE.Values['Lokalizacja'] := mViewData.Info.getLokalizacjaStr;
    PomiarVLE.Values['TrybPomiaru'] := mViewData.Info.getTrybPomiaruStr;
    PomiarVLE.Values['Wdech/wydech'] := mViewData.Info.getWdechStr;
    PomiarVLE.Values['Kana³y'] := mViewData.Info.ChnKalibrExis;

    PomiarVLE.Values['avrMax'] := DistStr(Kalibr.avrMax);
    PomiarVLE.Values['avrAmpl'] := DistStr(Kalibr.avrAmpl);
    PomiarVLE.Values['valSuggested'] := DistStr(Kalibr.valSuggested);
    PomiarVLE.Values['valApproved'] := DistStr(Kalibr.valApproved);
  end;
end;

var
  drawNr: Integer;

function TForm1.getChartWorkRect(Chart: TChart): TRect;
begin
  Result.Left := Chart.BottomAxis.CalcXPosValue(Chart.BottomAxis.Minimum);
  Result.Right := Chart.BottomAxis.CalcXPosValue(Chart.BottomAxis.Maximum);
  Result.Top := Chart.LeftAxis.CalcYPosValue(Chart.LeftAxis.Maximum);
  Result.Bottom := Chart.LeftAxis.CalcYPosValue(Chart.LeftAxis.Minimum);
end;

procedure TForm1.Grid0BottomBoxClick(Sender: TObject);
begin
  KalibrChart.BottomAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TForm1.Grid0LeftBoxClick(Sender: TObject);
begin
  KalibrChart.LeftAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TForm1.Grid0RightBoxClick(Sender: TObject);
begin
  KalibrChart.RightAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TForm1.GridBottomBoxClick(Sender: TObject);
begin
  PomiarChart.BottomAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TForm1.GridLeftBoxClick(Sender: TObject);
begin
  PomiarChart.LeftAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TForm1.GridPLBottomBoxClick(Sender: TObject);
begin
  PasLaserChart.BottomAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TForm1.GridPLLeftBoxClick(Sender: TObject);
begin
  PasLaserChart.LeftAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TForm1.GridPLRightBoxClick(Sender: TObject);
begin
  PasLaserChart.RightAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TForm1.GridRightBoxClick(Sender: TObject);
begin
  PomiarChart.RightAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TForm1.HideHelpBtnClick(Sender: TObject);
begin
  HelpPanel.Visible := false;
end;

procedure TForm1.DrawChartCursor(Chart: TChart; const dt: TKalibrChartDt; color: TColor);
var
  cv: TCanvas;
  R: TRect;
  RW: TRect;
  X, Y: Integer;

begin
  cv := Chart.Canvas.ReferenceCanvas;
  RW := getChartWorkRect(Chart);

  X := Chart.BottomAxis.CalcXPosValue(dt.valX);
  Y := Chart.LeftAxis.CalcYPosValue(dt.valY_L);

  if RW.Contains(Point(X, Y)) then
  begin

    cv.Pen.Width := 1;
    cv.Pen.Style := psSolid;
    cv.Pen.color := color;

    R := Chart.GetRectangle;

    cv.MoveTo(R.Left, Y);
    cv.LineTo(R.Right, Y);

    cv.MoveTo(X, R.Top);
    cv.LineTo(X, R.Bottom);
  end;

end;

procedure TForm1.KalibrChartAfterDraw(Sender: TObject);
var
  cv: TCanvas;
  R: TRect;
  RW: TRect;
  i: Integer;
  t: double;
  Chart: TChart;
  X: Integer;
  v: double;
  Y: Integer;
  s: string;
begin
  Chart := KalibrChart;
  cv := Chart.Canvas.ReferenceCanvas;
  RW := getChartWorkRect(Chart);
  DrawChartCursor(Chart, kalibrChartDt, clGreen);

  if Assigned(mViewData) then
  begin

    cv.Pen.Width := 1;
    cv.Pen.Style := psDash;

    for i := 0 to TOncoInfo.POINT_CNT - 1 do
    begin
      t := mViewData.Info.MeasKalibrRec.tabPoint[i].idxMin / MEAS_PER_SEK;
      X := Chart.BottomAxis.CalcXPosValue(t);

      cv.Pen.color := clGreen;
      cv.MoveTo(X, RW.Top);
      cv.LineTo(X, RW.Bottom);

      t := mViewData.Info.MeasKalibrRec.tabPoint[i].idxMax / MEAS_PER_SEK;
      X := Chart.BottomAxis.CalcXPosValue(t);

      cv.Pen.color := clBlue;
      cv.MoveTo(X, RW.Top);
      cv.LineTo(X, RW.Bottom);
    end;

    v := mViewData.Info.MeasKalibrRec.avrMax;
    Y := Chart.LeftAxis.CalcYPosValue(v);
    cv.Pen.color := clRED;
    cv.MoveTo(RW.Left, Y);
    cv.LineTo(RW.Right, Y);

    s := Format('KN=%d', [drawNr]);
    OutputDebugString(PChar(s));
    inc(drawNr);

  end;
end;

procedure TForm1.KalibrChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ssCtrl in Shift then
    kalibrChartDt.setPos(KalibrChart, X, Y);
end;

procedure TForm1.KalibrDystPomBoxClick(Sender: TObject);
begin
  KalibrLaserBox.Checked := false;
  KalibrRightSeries.Visible := KalibrDystPomBox.Checked;
  LoadKalibrRightSeries;
end;

procedure TForm1.KalibrLaserBoxClick(Sender: TObject);
begin
  KalibrDystPomBox.Checked := false;
  KalibrRightSeries.Visible := KalibrLaserBox.Checked;
  LoadKalibrRightSeries;
end;

procedure TForm1.PaintLedLineBoxClick(Sender: TObject);
begin
  PomiarChart.Invalidate;
end;

procedure TForm1.PasLaserSheetShow(Sender: TObject);
var
  i, n: Integer;
  X, Y: double;
begin
  PasLaserTabSeries.Clear;

  if Assigned(mViewData) then
  begin
    n := mViewData.TeachData.getCnt;

    for i := 0 to n - 1 do
    begin
      if mViewData.TeachData.tab[i].cnt > 0 then
      begin
        Y := mViewData.TeachData.tab[i].val;
        X := (100.0 * i) / n;
        PasLaserTabSeries.AddXY(X, Y);
      end;
    end;
  end;
end;

procedure TForm1.PasLaserShowPointsBoxClick(Sender: TObject);
begin
  PasLaserTabSeries.Pointer.Visible := (Sender as TCheckBox).Checked;
end;

procedure TForm1.PomiarChartAfterDraw(Sender: TObject);
var
  cv: TCanvas;
  R: TRect;
  RW: TRect;
  Chart: TChart;

  procedure DrawHorizLine(Y: double; color: TColor);
  var
    yi: Integer;
  begin
    yi := Chart.LeftAxis.CalcYPosValue(Y);
    if (RW.Top <= yi) and (RW.Bottom >= yi) then
    begin
      cv.Pen.Width := 1;
      cv.Pen.Style := psDash;
      cv.Pen.color := color;
      cv.MoveTo(RW.Left, yi);
      cv.LineTo(RW.Right, yi);
    end;
  end;

begin
  if Assigned(mViewData) then
  begin

    Chart := PomiarChart;
    cv := Chart.Canvas.ReferenceCanvas;
    RW := getChartWorkRect(Chart);
    DrawChartCursor(Chart, pomiarChartDt1, clGreen);
    DrawChartCursor(Chart, pomiarChartDt2, clMaroon);
    if PaintLedLineBox.Checked then
    begin
      // DrawHorizLine(mViewData.Info.CharPar.tabLevel[7], clRED);
      DrawHorizLine(mViewData.Info.CharPar.tabLevel[7], clGreen);
      DrawHorizLine(mViewData.Info.CharPar.tabLevel[3], clGreen);
      DrawHorizLine(mViewData.Info.CharPar.tabLevel[0], clRED);

    end;
  end;

end;

procedure TForm1.LiczLeds(X: Integer);
var
  i: Integer;
  b: byte;
  time: double;
  idx: Integer;
  Y: double;

begin

  time := PomiarChart.BottomAxis.CalcPosPoint(X);
  idx := round(time * MEAS_PER_SEK_DIV);
  if (idx < PomiarSer1.Count) and (idx >= 0) then
  begin
    Y := PomiarSer1.YValue[idx];

    b := 0;
    for i := 0 to TOncoInfo.LEVEL_CNT - 1 do
    begin
      if Y > mViewData.Info.CharPar.tabLevel[i] then
      begin
        b := b or (1 shl i);
      end;
    end;
    mLedState := b;
    LedsPB.Invalidate;
    OutputDebugString(PChar(Format('Led=%02X, y=%f t=%f idx=%d', [b, Y, time, idx])));
  end;
end;

procedure TForm1.PomiarChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  procedure FillGrid(nr: Integer; const dt: TKalibrChartDt);
  begin
    PomMeasGrid.Cells[1, nr] := FormatFloat('0.00', dt.valX) + ' [s]';
    PomMeasGrid.Cells[2, nr] := FormatFloat('0.00', dt.valY_L) + ' [mm]';
    PomMeasGrid.Cells[3, nr] := FormatFloat('0.00', dt.valY_R) + ' [mm]';
    PomMeasGrid.Cells[4, nr] := FormatFloat('0.00', dt.valY_R - dt.valY_L) + ' [mm]';
  end;

begin
  if ssCtrl in Shift then
    pomiarChartDt2.setPos(PomiarChart, X, Y)
  else
    pomiarChartDt1.setPos(PomiarChart, X, Y);

  FillGrid(1, pomiarChartDt1);
  FillGrid(2, pomiarChartDt2);

  PomMeasGrid.Cells[1, 3] := FormatFloat('0.00', pomiarChartDt1.valX - pomiarChartDt2.valX) + ' [s]';
  PomMeasGrid.Cells[2, 3] := FormatFloat('0.00', pomiarChartDt1.valY_L - pomiarChartDt2.valY_L) + ' [mm]';
  PomMeasGrid.Cells[3, 3] := FormatFloat('0.00', pomiarChartDt1.valY_R - pomiarChartDt2.valY_R) + ' [mm]';
  PomMeasGrid.Cells[4, 3] := '';

  LiczLeds(X);
end;

procedure TForm1.PomiarChartMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if PaintOnMouseMove.Checked then
    LiczLeds(X);
end;

procedure TForm1.KalibrSheetShow(Sender: TObject);
var
  i, n: Integer;
  X, Y: double;
  chCnt: Integer;
begin
  KalibrSeries.Clear;

  if Assigned(mViewData) then
  begin
    chCnt := mViewData.Info.getKalibrDataCnt;
    n := length(mViewData.konfigData);
    n := n div chCnt;

    for i := 0 to n - 1 do
    begin
      X := i / MEAS_PER_SEK;
      Y := mViewData.konfigData[chCnt * i + 0];
      KalibrSeries.AddXY(X, Y);
    end;

    KalibrLaserBox.Enabled := mViewData.Info.isKalibrLaserData;
    KalibrDystPomBox.Enabled := mViewData.Info.isKalibrTestData;
  end
  else
  begin
    KalibrLaserBox.Enabled := false;
    KalibrDystPomBox.Enabled := false;
  end;
  LoadKalibrRightSeries;
end;

procedure TForm1.LoadKalibrRightSeries;
var
  i, n: Integer;
  X, Y: double;
  yPom: double;
  chCnt: Integer;
  dtOfs: Integer;
begin
  KalibrRightSeries.Clear;
  KalibrRightSeries.Visible := KalibrDystPomBox.Checked or KalibrLaserBox.Checked;

  if Assigned(mViewData) then
  begin
    chCnt := mViewData.Info.getKalibrDataCnt;
    n := length(mViewData.konfigData) div chCnt;
    if chCnt >= 2 then
    begin
      if KalibrLaserBox.Checked then
        dtOfs := 1
      else
        dtOfs := 2;

      for i := 0 to n - 1 do
      begin
        X := i / MEAS_PER_SEK;
        yPom := mViewData.konfigData[chCnt * i + dtOfs];
        KalibrRightSeries.AddXY(X, yPom);
      end;
    end;
  end;
end;

procedure TForm1.KalibrShowPointsBoxClick(Sender: TObject);
begin
  KalibrSeries.Pointer.Visible := KalibrShowPointsBox.Checked;
end;

procedure TForm1.MeasDystPomBoxClick(Sender: TObject);
begin
  PomiarSer2.Visible := MeasDystPomBox.Checked;
end;

procedure TForm1.MeasSheetShow(Sender: TObject);
var
  i, n: Integer;
  X: double;
  y1, y2: double;
  chCnt: Integer;
begin
  PomiarSer1.Clear;
  PomiarSer2.Clear;
  if Assigned(mViewData) then
  begin
    chCnt := mViewData.Info.getKalibrDataCnt;
    n := length(mViewData.MeasData) div chCnt;
    for i := 0 to n - 1 do
    begin
      X := i / MEAS_PER_SEK_DIV;
      y1 := mViewData.MeasData[chCnt * i + 0];
      PomiarSer1.AddXY(X, y1);
      if chCnt >= 2 then
      begin
        y2 := mViewData.MeasData[chCnt * i + 1];
        PomiarSer2.AddXY(X, y2);
      end;
    end;

  end;
end;

end.
