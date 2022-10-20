unit frameKalibrUnit;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Actions,
  Vcl.Graphics, Vcl.Controls, Vcl.Grids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ActnList, Vcl.Forms,

  VclTee.TeEngine, VclTee.Series, VclTee.TeeProcs, VclTee.Chart, VclTee.TeeGDIPlus,
  registry,

  frameBaseChartUnit,
  InfoDataUnit, frameOsSwitch;

type
  TKalibrSheetFrame = class(TBaseChartFrame)
    Splitter2: TSplitter;
    mChart: TChart;

    PasSeries: TLineSeries;
    LaserSeries: TLineSeries;
    LaserPomocSeries: TLineSeries;

    PasOblSeries: TLineSeries;
    PasErrSeries: TLineSeries;

    // wkres w okienku
    PasLaserTransChart: TChart;
    PasLaserAvrSeries: TPointSeries;
    PasLaserLineSeries: TLineSeries;

    Panel1: TPanel;
    KalibrShowPointsBox: TCheckBox;
    Grid0BottomBox: TCheckBox;
    Grid0LeftBox: TCheckBox;
    Grid0RightBox: TCheckBox;
    LiczABBtn: TButton;
    WspAEdit: TLabeledEdit;
    WspBEdit: TLabeledEdit;
    AutoBBtn: TButton;
    Memo2: TMemo;
    GroupBox1: TGroupBox;
    StabRegTimeEdit: TLabeledEdit;
    StabRegAmplEdit: TLabeledEdit;
    Button1: TButton;
    ShowStabRegPcBox: TCheckBox;
    ShowStabRegStmBox: TCheckBox;
    showTranclChartBtn: TButton;
    ShowKalibrptGridBtn: TButton;
    GroupBox2: TGroupBox;
    KalibrMaxLaserSrKwEdit: TLabeledEdit;
    KalibrMaxPointOdchylEdit: TLabeledEdit;
    MinLaserDataEdit: TLabeledEdit;
    MaxLaserDataEdit: TLabeledEdit;
    Panel4: TPanel;
    ChartPanel: TPanel;
    ShowPointlabelBox: TCheckBox;
    HideChartPanel: TButton;
    GridPanel: TPanel;
    HideKalibrGridBtn: TButton;
    MaxErrorTxt: TStaticText;
    KalibrGrid: TStringGrid;
    ActionList1: TActionList;
    showTranslChartAct: TAction;
    LiczABAct: TAction;
    LiczStabReg: TAction;
    BuildTransTableAct: TAction;
    AutoBAct: TAction;
    OsRightSwitchFrame: TOsSwitchFrame;
    OsLeftSwitchFrame: TOsSwitchFrame;
    LeftAxisUpBtn: TButton;
    LeftAxisDnBtn: TButton;
    RightAxisDnBtn: TButton;
    RightAxisUpBtn: TButton;
    LeftAxisZeroBtn: TButton;
    RightAxisZeroBtn: TButton;
    procedure showTranslChartActExecute(Sender: TObject);
    procedure ShowKalibrptGridBtnClick(Sender: TObject);
    procedure HideKalibrGridBtnClick(Sender: TObject);
    procedure ShowPointlabelBoxClick(Sender: TObject);
    procedure KalibrShowPointsBoxClick(Sender: TObject);
    procedure Grid0BottomBoxClick(Sender: TObject);
    procedure Grid0LeftBoxClick(Sender: TObject);
    procedure Grid0RightBoxClick(Sender: TObject);
    procedure Button1KeyPress(Sender: TObject; var Key: Char);
    procedure HideChartPanelClick(Sender: TObject);
    procedure LiczStabRegUpdate(Sender: TObject);
    procedure LiczStabRegExecute(Sender: TObject);
    procedure LiczABActExecute(Sender: TObject);
    procedure WspAEditKeyPress(Sender: TObject; var Key: Char);
    procedure BuildTransTableActUpdate(Sender: TObject);
    procedure AutoBActExecute(Sender: TObject);
    procedure PasLaserTransChartAfterDraw(Sender: TObject);
    procedure mChartAfterDraw(Sender: TObject);
    procedure mChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LeftAxisUpBtnClick(Sender: TObject);
    procedure LeftAxisDnBtnClick(Sender: TObject);
    procedure RightAxisUpBtnClick(Sender: TObject);
    procedure RightAxisDnBtnClick(Sender: TObject);
    procedure LeftAxisZeroBtnClick(Sender: TObject);
    procedure RightAxisZeroBtnClick(Sender: TObject);
    procedure ShowStabRegPcBoxClick(Sender: TObject);
    procedure showTranclChartBtnClick(Sender: TObject);
    procedure showTranslChartActUpdate(Sender: TObject);
    procedure KalibrGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    kalibrChartDt: TKalibrChartDt;

    procedure ReloadKalibrPtGrid;
    procedure FillMemoDt;
    procedure LiczKalibrStabRegion(oncoData: TOncoObject);
    procedure AddKalibrChartItems;
    procedure MakeLaserSymul;
    procedure OnRightOsChangedProc(Sender: TObject);
    procedure OnLeftOsChangedProc(Sender: TObject);
    procedure ChangeInSec(doObj, ObjToChange: TOsSwitchFrame);

  public
    procedure doOnShow;
    procedure doAfterdataLoaded(oncoData: TOncoObject);
    procedure saveToReg(reg: TRegistry);
    procedure loadFromReg(reg: TGkRegistry);

  end;

implementation

{$R *.dfm}
// uses Main;

procedure TKalibrSheetFrame.AutoBActExecute(Sender: TObject);
begin
  mViewData.KonfigData.liczAutoB;
  WspBEdit.Text := FormatFloat('0.00000', mViewData.KonfigData.getWspB);
  MakeLaserSymul;
end;

procedure TKalibrSheetFrame.BuildTransTableActUpdate(Sender: TObject);
begin
  if Assigned(mViewData) then
    (Sender as TAction).Enabled := mViewData.KonfigData.isPasData and mViewData.KonfigData.isLaserData
  else
    (Sender as TAction).Enabled := false;
end;

procedure TKalibrSheetFrame.Button1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    LiczKalibrStabRegion(mViewData);
    doOnShow;
  end;
end;

procedure TKalibrSheetFrame.Grid0BottomBoxClick(Sender: TObject);
begin
  mChart.BottomAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TKalibrSheetFrame.Grid0LeftBoxClick(Sender: TObject);
begin
  mChart.LeftAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TKalibrSheetFrame.Grid0RightBoxClick(Sender: TObject);
begin
  mChart.RightAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TKalibrSheetFrame.HideChartPanelClick(Sender: TObject);
begin
  ChartPanel.Visible := false;
end;

procedure TKalibrSheetFrame.HideKalibrGridBtnClick(Sender: TObject);
begin
  GridPanel.Visible := false;
end;

procedure TKalibrSheetFrame.ShowKalibrptGridBtnClick(Sender: TObject);
begin
  GridPanel.Visible := not(GridPanel.Visible);
  ReloadKalibrPtGrid;
end;

procedure TKalibrSheetFrame.showTranclChartBtnClick(Sender: TObject);
begin
  inherited;
  ChartPanel.Visible := not(ChartPanel.Visible);

end;

procedure TKalibrSheetFrame.ShowPointlabelBoxClick(Sender: TObject);
begin
  PasLaserAvrSeries.Marks.Visible := ShowPointlabelBox.Checked;
end;

procedure TKalibrSheetFrame.ShowStabRegPcBoxClick(Sender: TObject);
begin
  inherited;
  mChart.Invalidate;
end;

procedure TKalibrSheetFrame.showTranslChartActExecute(Sender: TObject);
var
  i: Integer;
  X, Y, Y1: double;
  wsp_a, wsp_b: double;
  color: TColor;
begin
  ChartPanel.Visible := not(ChartPanel.Visible);
  if ChartPanel.Visible then
  begin

    PasLaserAvrSeries.Clear;
    PasLaserLineSeries.Clear;

    wsp_a := mViewData.KonfigData.getWspA;
    wsp_b := mViewData.KonfigData.getWspB;

    for i := 0 to mViewData.KonfigData.stabRegTab.getCnt - 1 do
    begin
      X := mViewData.KonfigData.stabRegTab.tab[i].laserAvr;
      Y := mViewData.KonfigData.stabRegTab.tab[i].pasAvr;
      Y1 := wsp_a * X + wsp_b;

      color := mViewData.KonfigData.stabRegTab.tab[i].getPointColor;

      PasLaserAvrSeries.AddXY(X, Y, intToStr(i + 1), color);
      PasLaserLineSeries.AddXY(X, Y1);
    end;
  end;

end;

procedure TKalibrSheetFrame.showTranslChartActUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := Assigned(mViewData);
end;

procedure TKalibrSheetFrame.WspAEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    MakeLaserSymul;
  end;
end;

procedure TKalibrSheetFrame.mChartAfterDraw(Sender: TObject);
var
  dataPerSek: single;
  cv: TCanvas;
  Chart: TChart;
  RW: TRect;

  procedure drawVLine(idx: Integer; color: TColor);
  var
    t: double;
    X: Integer;
  begin
    t := idx / dataPerSek;
    X := Chart.BottomAxis.CalcXPosValue(t);

    cv.Pen.Width := 1;
    cv.Pen.Style := psDash;
    cv.Pen.color := color;
    cv.MoveTo(X, RW.Top);
    cv.LineTo(X, RW.Bottom);
  end;

  procedure drawHLine(nr: Integer; str, len: Integer; avr: single; color: TColor);
  var
    X1, x2: Integer;
    Y: Integer;
    Y1: Integer;
  begin
    X1 := Chart.BottomAxis.CalcXPosValue(str / dataPerSek);
    x2 := Chart.BottomAxis.CalcXPosValue((str + len) / dataPerSek);
    Y := Chart.LeftAxis.CalcYPosValue(avr);

    cv.Pen.Width := 3;
    cv.Pen.Style := psSolid;
    cv.Pen.color := color;
    cv.MoveTo(X1, Y);
    cv.LineTo(x2, Y);

    if Y - RW.Top > 17 then
      Y1 := Y - 17
    else
      Y1 := Y + 3;
    cv.Font.color := color;
    cv.Font.Height := 14;
    cv.TextOut(X1, Y1, intToStr(nr));

  end;

var
  i: Integer;
  v: double;
  Y: Integer;
  ocena: TOncoObject.TOcenaTranslRec;
  color: TColor;
begin
  Chart := mChart;
  cv := Chart.Canvas.ReferenceCanvas;
  RW := getChartWorkRect(Chart);
  DrawChartCursor(Chart, kalibrChartDt, clGreen);

  if Assigned(mViewData) then
  begin

    dataPerSek := mViewData.KonfigData.getDataperSek;

    if ShowStabRegStmBox.Checked and PasSeries.Visible then
    begin

      for i := 0 to TOncoInfo.POINT_CNT - 1 do
      begin

        // drawVLine(mViewData.Info.MeasKalibrRec.tabPoint[i].idxMin, clGreen);  todo
        // drawVLine(mViewData.Info.MeasKalibrRec.tabPoint[i].idxMax, clBlue);
      end;

      v := mViewData.Info.MeasKalibrRec.avrMax;
      Y := Chart.LeftAxis.CalcYPosValue(v);
      cv.Pen.color := clRed;
      cv.MoveTo(RW.Left, Y);
      cv.LineTo(RW.Right, Y);
    end;

    // rysowanie poziomych kresek zgodnie z tabel¹ "ocena.stabRegTab"
    if ShowStabRegPcBox.Checked and PasSeries.Visible then
    begin
      mViewData.KonfigData.getOcena(ocena);
      for i := 0 to ocena.stabRegTab.getCnt - 1 do
      begin
        color := ocena.stabRegTab.tab[i].getPointColor;

        drawHLine(i + 1, ocena.stabRegTab.tab[i].begIdx, ocena.stabRegTab.tab[i].len,
          ocena.stabRegTab.tab[i].pasAvr, color);
      end;
    end;

  end;
end;

procedure TKalibrSheetFrame.mChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ssCtrl in Shift then
    kalibrChartDt.setPos(mChart, X, Y);
end;

procedure TKalibrSheetFrame.KalibrGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
var
  Gr: TStringGrid;
  color: TColor;
  bkColor: TColor;
  reg: TOncoObject.TStabReg;
begin
  inherited;
  Gr := Sender as TStringGrid;
  color := clBLACK;
  if ARow > 0 then
  begin
    reg := mViewData.KonfigData.stabRegTab.tab[ARow - 1];
    color := reg.getPointColor;
  end;
  bkColor := clWindow;
  if gdSelected in State then
    bkColor := clActiveCaption;

  Gr.Canvas.Brush.color := bkColor;
  Gr.Canvas.Font.color := color;
  Gr.Canvas.FillRect(Rect);
  Gr.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Gr.Cells[ACol, ARow]);
end;

procedure TKalibrSheetFrame.KalibrShowPointsBoxClick(Sender: TObject);
begin
  PasSeries.Pointer.Visible := KalibrShowPointsBox.Checked;
end;

procedure TKalibrSheetFrame.ReloadKalibrPtGrid;
var
  i, n: Integer;
  reg: TOncoObject.TStabReg;
  mxIdx: Integer;
begin
  if GridPanel.Visible then
  begin
    KalibrGrid.Rows[0].CommaText :=
      'lp "Pas AVR[mm]" "Pas ŒrKW[mm]" "Laser AVR[%]" "Laser ŒrKW[%]" "Pas Obl[mm]" "Error[mm]"';
    if Assigned(mViewData) then
    begin
      n := mViewData.KonfigData.stabRegTab.getCnt;
      KalibrGrid.RowCount := n + 1;
      for i := 0 to n - 1 do
      begin
        KalibrGrid.Cells[0, i + 1] := intToStr(i + 1);
        reg := mViewData.KonfigData.stabRegTab.tab[i];
        KalibrGrid.Cells[1, i + 1] := FormatFloat('0.00', reg.pasAvr);
        KalibrGrid.Cells[2, i + 1] := FormatFloat('0.000', reg.pasSrKw);
        KalibrGrid.Cells[3, i + 1] := FormatFloat('0.00', reg.laserAvr);
        KalibrGrid.Cells[4, i + 1] := FormatFloat('0.000', reg.laserSrKw);
        KalibrGrid.Cells[5, i + 1] := FormatFloat('0.00', reg.pasObl);
        KalibrGrid.Cells[6, i + 1] := FormatFloat('0.00', reg.Err);

      end;
      mxIdx := mViewData.KonfigData.stabRegTab.getMaxErrorIdx;
      if mxIdx >= 0 then
      begin
        reg := mViewData.KonfigData.stabRegTab.tab[mxIdx];
        MaxErrorTxt.Caption := format('MaxError: pos=%u err=%.2f[mm]', [mxIdx + 1, reg.Err]);
      end
      else
        MaxErrorTxt.Caption := '...';
    end;
  end;

end;

procedure TKalibrSheetFrame.doOnShow;
var
  i, n: Integer;
  X, Y: double;
  yLaser: double;
  yObl: double;
  chCnt: Integer;
  dataPerSek: single;
  pasDt: boolean;
  laserDt: boolean;
  laserPomDt: boolean;

begin
  OsRightSwitchFrame.OnOsChanged := OnRightOsChangedProc;
  OsLeftSwitchFrame.OnOsChanged := OnLeftOsChangedProc;

  PasSeries.Clear;
  LaserSeries.Clear;
  LaserPomocSeries.Clear;
  PasOblSeries.Clear;
  PasErrSeries.Clear;

  if Assigned(mViewData) then
  begin
    chCnt := mViewData.KonfigData.getChannelCnt;
    n := mViewData.KonfigData.getCnt;
    n := n div chCnt;

    dataPerSek := mViewData.KonfigData.getDataperSek;
    for i := 0 to n - 1 do
    begin
      X := i / dataPerSek;

      if mViewData.KonfigData.isPasData then
        PasSeries.AddXY(X, mViewData.KonfigData.getDistVal(i));

      if mViewData.KonfigData.isLaserData then
        LaserSeries.AddXY(X, mViewData.KonfigData.getLaserVal(i));

      if mViewData.KonfigData.isLaserPomocData then
        LaserPomocSeries.AddXY(X, mViewData.KonfigData.getPomDistVal(i));

      if mViewData.KonfigData.isOblRdy then
      begin
        yLaser := mViewData.KonfigData.tab[chCnt * i + 1];
        yObl := mViewData.KonfigData.getPasObl(yLaser);
        Y := mViewData.KonfigData.getDistVal(i);
        PasOblSeries.AddXY(X, yObl);
        PasErrSeries.AddXY(X, Y - yObl);
      end;

    end;

    pasDt := mViewData.KonfigData.isPasData;
    laserDt := mViewData.KonfigData.isLaserData;
    laserPomDt := mViewData.KonfigData.isLaserPomocData;
    OsLeftSwitchFrame.setEnab(pasDt, laserDt, laserPomDt);
    OsRightSwitchFrame.setEnab(pasDt, laserDt, laserPomDt);
  end
  else
  begin
    OsLeftSwitchFrame.setAllDisable;
    OsRightSwitchFrame.setAllDisable;

  end;
  AddKalibrChartItems;
  FillMemoDt;
end;

const
  ZOOM_K = 0.2;

procedure TKalibrSheetFrame.RightAxisUpBtnClick(Sender: TObject);
var
  min, max, del: double;
  k: double;
begin
  inherited;
  min := mChart.RightAxis.Minimum;
  max := mChart.RightAxis.Maximum;
  del := max - min;
  k := 1 / (1 + ZOOM_K);
  min := min + k * del;
  max := max - k * del;
  mChart.RightAxis.SetMinMax(min, max);
end;

procedure TKalibrSheetFrame.LeftAxisUpBtnClick(Sender: TObject);
var
  min, max, del: double;
  k: double;
begin
  inherited;
  min := mChart.LeftAxis.Minimum;
  max := mChart.LeftAxis.Maximum;
  del := max - min;
  k := 1 / (1 + 2 * ZOOM_K);
  del := del * k;
  min := min + ZOOM_K * del;
  max := max - ZOOM_K * del;
  mChart.LeftAxis.SetMinMax(min, max);
end;

procedure TKalibrSheetFrame.RightAxisDnBtnClick(Sender: TObject);
var
  min, max, del: double;
begin
  inherited;
  min := mChart.RightAxis.Minimum;
  max := mChart.RightAxis.Maximum;
  del := max - min;
  min := min - ZOOM_K * del;
  max := max + ZOOM_K * del;
  mChart.RightAxis.SetMinMax(min, max);
end;

procedure TKalibrSheetFrame.LeftAxisDnBtnClick(Sender: TObject);
var
  min, max, del: double;
begin
  inherited;
  min := mChart.LeftAxis.Minimum;
  max := mChart.LeftAxis.Maximum;
  del := max - min;
  min := min - ZOOM_K * del;
  max := max + ZOOM_K * del;
  mChart.LeftAxis.SetMinMax(min, max);
end;

procedure TKalibrSheetFrame.LeftAxisZeroBtnClick(Sender: TObject);
begin
  inherited;
  mChart.LeftAxis.Automatic := true;
end;

procedure TKalibrSheetFrame.RightAxisZeroBtnClick(Sender: TObject);
begin
  inherited;
  mChart.RightAxis.Automatic := true;
end;

procedure TKalibrSheetFrame.LiczABActExecute(Sender: TObject);
var
  maxPointError: double;
begin
  maxPointError := StrToFloat(KalibrMaxPointOdchylEdit.Text);

  mViewData.KonfigData.LiczAB(maxPointError);
  WspAEdit.Text := FormatFloat('0.00000', mViewData.KonfigData.getWspA);
  WspBEdit.Text := FormatFloat('0.00000', mViewData.KonfigData.getWspB);
  MakeLaserSymul;
end;

procedure TKalibrSheetFrame.LiczKalibrStabRegion(oncoData: TOncoObject);
var
  minTime, maxAmpl, maxLaserSrKw: double;
  maxLaser, minLaser: double;
begin
  if Assigned(oncoData) then
  begin
    minTime := StrToFloat(StabRegTimeEdit.Text);
    maxAmpl := StrToFloat(StabRegAmplEdit.Text);
    maxLaserSrKw := StrToFloat(KalibrMaxLaserSrKwEdit.Text);
    maxLaser := StrToFloat(MaxLaserDataEdit.Text);
    minLaser := StrToFloat(MinLaserDataEdit.Text);
    oncoData.KonfigData.FindStabReg(minTime, maxAmpl, maxLaserSrKw, maxLaser, minLaser);
  end;
end;

procedure TKalibrSheetFrame.LiczStabRegExecute(Sender: TObject);
begin
  LiczKalibrStabRegion(mViewData);
  doOnShow;
end;

procedure TKalibrSheetFrame.LiczStabRegUpdate(Sender: TObject);
begin
  if Assigned(mViewData) then
    (Sender as TAction).Enabled := mViewData.KonfigData.isPasData
  else
    (Sender as TAction).Enabled := false;
end;

procedure TKalibrSheetFrame.FillMemoDt;
var
  ocenaTranslRec: TOncoObject.TOcenaTranslRec;
  mxIdx: Integer;
  reg: TOncoObject.TStabReg;
begin
  Memo2.Clear;
  if Assigned(mViewData) then
  begin
    mViewData.KonfigData.getOcena(ocenaTranslRec);
    if ocenaTranslRec.isOblRdy then
    begin
      Memo2.Lines.Add(format('ErrAvr=%.2f[mm]', [ocenaTranslRec.errAvr]));

      Memo2.Lines.Add(format('AbsErrAvr=%.2f[mm]', [ocenaTranslRec.errAvrAbs]));
    end;

    Memo2.Lines.Add(format('StabRegCnt=%u', [length(ocenaTranslRec.stabRegTab.tab)]));

    mxIdx := mViewData.KonfigData.stabRegTab.getMaxErrorIdx;
    if mxIdx >= 0 then
    begin
      reg := mViewData.KonfigData.stabRegTab.tab[mxIdx];
      Memo2.Lines.Add(format('MaxError: pos=%u err=%.2f[mm]', [mxIdx + 1, reg.Err]));
    end

    {
      dtPerSek := mViewData.KonfigData.getDataperSek;
      for i := 0 to length(ocenaTranslRec.stabRegTab.tab) - 1 do
      begin
      Memo2.Lines.Add
      (Format('Reg[%u]: (S=%.2f[s] L=%.2f[s] PAS:(AVR=%.2f[mm] KW=%.3f[mm]) LASER:(AVR=%.2f[mm] KW=%.3f[mm])',
      [i + 1, ocenaTranslRec.stabRegTab.tab[i].begIdx / dtPerSek, ocenaTranslRec.stabRegTab.tab[i].len / dtPerSek,
      ocenaTranslRec.stabRegTab.tab[i].avr, ocenaTranslRec.stabRegTab.tab[i].srKw,
      ocenaTranslRec.stabRegTab.tab[i].laserAvr, ocenaTranslRec.stabRegTab.tab[i].laserSrKw]

      ));
      end;
    }
  end;
end;

procedure TKalibrSheetFrame.AddKalibrChartItems;
begin

end;

procedure TKalibrSheetFrame.MakeLaserSymul;
var
  wspA, wspB: single;
begin
  if Assigned(mViewData) then
  begin
    try
      wspA := StrToFloat(WspAEdit.Text);
      wspB := StrToFloat(WspBEdit.Text);
      mViewData.KonfigData.SetSymulParams(wspA, wspB);
      doOnShow;
    except

    end;
  end;
end;

procedure TKalibrSheetFrame.PasLaserTransChartAfterDraw(Sender: TObject);
var
  cv: TCanvas;
  Chart: TChart;
  RW: TRect;
begin

  Chart := mChart;
  cv := Chart.Canvas.ReferenceCanvas;
  RW := getChartWorkRect(Chart);
  DrawChartCursor(Chart, kalibrChartDt, clGreen);
end;

procedure TKalibrSheetFrame.doAfterdataLoaded(oncoData: TOncoObject);
var
  maxPointError: double;
begin
  maxPointError := StrToFloat(KalibrMaxPointOdchylEdit.Text);
  LiczKalibrStabRegion(oncoData);
  oncoData.KonfigData.LiczAB(maxPointError);
  WspAEdit.Text := FormatFloat('0.00000', oncoData.KonfigData.getWspA);
  WspBEdit.Text := FormatFloat('0.00000', oncoData.KonfigData.getWspB);

  doOnShow;

end;

procedure TKalibrSheetFrame.saveToReg(reg: TRegistry);
begin
  reg.WriteBool('KalibrShowPointsBox', KalibrShowPointsBox.Checked);

  reg.WriteBool('Grid0LeftBox', Grid0LeftBox.Checked);
  reg.WriteBool('Grid0RightBox', Grid0RightBox.Checked);
  reg.WriteBool('Grid0BottomBox', Grid0BottomBox.Checked);
  reg.WriteBool('ShowStabRegStmBox', ShowStabRegStmBox.Checked);
  reg.WriteBool('ShowStabRegPcBox', ShowStabRegPcBox.Checked);
  reg.WriteString('StabRegAmplEdit', StabRegAmplEdit.Text);
  reg.WriteString('StabRegTimeEdit', StabRegTimeEdit.Text);

  reg.WriteString('MinLaserDataEdit', MinLaserDataEdit.Text);
  reg.WriteString('MaxLaserDataEdit', MaxLaserDataEdit.Text);
  reg.WriteString('KalibrMaxLaserSrKwEdit', KalibrMaxLaserSrKwEdit.Text);
  reg.WriteString('KalibrMaxPointOdchylEdit', KalibrMaxPointOdchylEdit.Text);

end;

procedure TKalibrSheetFrame.loadFromReg(reg: TGkRegistry);
begin
  reg.RegCheckBox('KalibrShowPointsBox', KalibrShowPointsBox);
  reg.RegCheckBox('Grid0LeftBox', Grid0LeftBox);
  reg.RegCheckBox('Grid0RightBox', Grid0RightBox);
  reg.RegCheckBox('Grid0BottomBox', Grid0BottomBox);
  reg.RegCheckBox('ShowStabRegStmBox', ShowStabRegStmBox);
  reg.RegCheckBox('ShowStabRegPcBox', ShowStabRegPcBox);
  reg.RegLabEdit('StabRegAmplEdit', StabRegAmplEdit);
  reg.RegLabEdit('StabRegTimeEdit', StabRegTimeEdit);

  reg.RegLabEdit('MinLaserDataEdit', MinLaserDataEdit);
  reg.RegLabEdit('MaxLaserDataEdit', MaxLaserDataEdit);
  reg.RegLabEdit('KalibrMaxLaserSrKwEdit', KalibrMaxLaserSrKwEdit);
  reg.RegLabEdit('KalibrMaxPointOdchylEdit', KalibrMaxPointOdchylEdit);
end;

procedure TKalibrSheetFrame.ChangeInSec(doObj, ObjToChange: TOsSwitchFrame);
  procedure switchSeries(btRight, btLeft: boolean; aSeries: TLineSeries); overload;
  begin
    if btRight then
    begin
      aSeries.Visible := true;
      aSeries.VertAxis := aRightAxis;
    end
    else if btLeft then
    begin
      aSeries.Visible := true;
      aSeries.VertAxis := aLeftAxis;
    end
    else
    begin
      aSeries.Visible := false;
    end;
  end;

  procedure switchSeries(btRight, btLeft: TRadioButton; aSeries: TLineSeries); overload;
  begin
    switchSeries(btRight.Checked, btLeft.Checked, aSeries);
  end;

  procedure switchSeries(btRight, btLeft: TCheckBox; aSeries: TLineSeries); overload;
  begin
    switchSeries(btRight.Enabled and btRight.Checked, btLeft.Enabled and btLeft.Checked, aSeries);
  end;

begin
  if doObj.PasButton.Checked and ObjToChange.PasButton.Checked then
    ObjToChange.OffButton.Checked := true;

  if doObj.LaserButton.Checked and ObjToChange.LaserButton.Checked then
    ObjToChange.OffButton.Checked := true;

  if doObj.LaserPomocBtn.Checked and ObjToChange.LaserPomocBtn.Checked then
    ObjToChange.OffButton.Checked := true;

  mChart.UndoZoom;
  mChart.LeftAxis.Automatic := true;
  mChart.RightAxis.Automatic := true;

  switchSeries(OsRightSwitchFrame.PasButton, OsLeftSwitchFrame.PasButton, PasSeries);
  switchSeries(OsRightSwitchFrame.LaserButton, OsLeftSwitchFrame.LaserButton, LaserSeries);
  switchSeries(OsRightSwitchFrame.LaserPomocBtn, OsLeftSwitchFrame.LaserPomocBtn, LaserPomocSeries);

  switchSeries(OsRightSwitchFrame.AddPasOblBox, OsLeftSwitchFrame.AddPasOblBox, PasOblSeries);
  switchSeries(OsRightSwitchFrame.AddErrorBox, OsLeftSwitchFrame.AddErrorBox, PasErrSeries);

end;

procedure TKalibrSheetFrame.OnRightOsChangedProc(Sender: TObject);
begin
  ChangeInSec(OsRightSwitchFrame, OsLeftSwitchFrame);
end;

procedure TKalibrSheetFrame.OnLeftOsChangedProc(Sender: TObject);
begin
  ChangeInSec(OsLeftSwitchFrame, OsRightSwitchFrame);
end;

end.
