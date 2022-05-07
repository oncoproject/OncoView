unit framePomiarUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frameBaseChartUnit, VclTee.TeeGDIPlus,
  Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls, VclTee.TeEngine, VclTee.Series,
  VclTee.TeeProcs, VclTee.Chart,
  InfoDataUnit;

type
  TPomiarSheetFrame = class(TBaseChartFrame)
    mChart: TChart;
    PasSeries: TLineSeries;
    LaserPomocSeries: TLineSeries;
    LaserPomocBox: TCheckBox;
    PomMeasGrid: TStringGrid;
    LedsPB: TPaintBox;
    PaintLedLineBox: TCheckBox;
    PaintOnMouseMove: TCheckBox;
    GridLeftBox: TCheckBox;
    GridRightBox: TCheckBox;
    GridBottomBox: TCheckBox;
    Panel2: TPanel;
    LaserBox: TCheckBox;
    LaserSeries: TLineSeries;
    ZmRightAxisBox: TCheckBox;
    procedure LaserPomocBoxClick(Sender: TObject);
    procedure PaintLedLineBoxClick(Sender: TObject);
    procedure GridRightBoxClick(Sender: TObject);
    procedure GridLeftBoxClick(Sender: TObject);
    procedure GridBottomBoxClick(Sender: TObject);
    procedure LedsPBPaint(Sender: TObject);
    procedure mChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure mChartAfterDraw(Sender: TObject);
    procedure mChartMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure LaserBoxClick(Sender: TObject);
    procedure ZmRightAxisBoxClick(Sender: TObject);

  private
    mLedState: byte;
    pomiarChartDt1: TKalibrChartDt;
    pomiarChartDt2: TKalibrChartDt;
    procedure LiczLeds(X: Integer);

  public
    procedure doOnShow;
    procedure doAfterdataLoaded(oncoData: TOncoObject);
    procedure saveToReg(reg: TGkRegistry);
    procedure loadFromReg(reg: TGkRegistry);
  end;

implementation

{$R *.dfm}

procedure TPomiarSheetFrame.GridBottomBoxClick(Sender: TObject);
begin
  inherited;
  mChart.BottomAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TPomiarSheetFrame.GridLeftBoxClick(Sender: TObject);
begin
  inherited;
  mChart.LeftAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TPomiarSheetFrame.GridRightBoxClick(Sender: TObject);
begin
  inherited;
  mChart.RightAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TPomiarSheetFrame.LedsPBPaint(Sender: TObject);
  procedure PanitLedBox(idx: Integer; posX: single; State: boolean);
  const
    MARG = 5;
    TabColor: array [0 .. 7] of TColor = (clRed, clRed, clRed, clRed, clLIME, clLIME, clLIME, clRed);
  var
    R: TRect;
    color: TColor;
  begin
    R.Left := MARG;
    R.Right := LedsPB.Width - MARG;
    R.Top := trunc(posX + MARG);
    R.Bottom := trunc(posX + LedsPB.Height / 8 - MARG);

    LedsPB.Canvas.Pen.Style := psSolid;
    LedsPB.Canvas.Pen.color := clBLACK;
    LedsPB.Canvas.Pen.Width := 2;

    LedsPB.Canvas.Brush.Style := bsSolid;
    if State then
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

procedure TPomiarSheetFrame.LaserBoxClick(Sender: TObject);
var
  ev : TNotifyEvent;
begin
  inherited;
  ev := LaserPomocBox.OnClick;
  LaserPomocBox.OnClick := nil;
  LaserPomocBox.Checked := false;
  LaserPomocBox.OnClick := ev;

  ZmRightAxisBox.Checked := false;
  mChart.RightAxis.Automatic := true;

  LaserSeries.Visible := LaserBox.Checked;
  LaserPomocSeries.Visible := LaserPomocBox.Checked;

end;

procedure TPomiarSheetFrame.LaserPomocBoxClick(Sender: TObject);
var
  ev : TNotifyEvent;
begin
  inherited;
  ev := LaserBox.OnClick;
  LaserBox.OnClick := nil;
  LaserBox.Checked := false;
  LaserBox.OnClick := ev;

  ZmRightAxisBox.Checked := false;
  mChart.RightAxis.Automatic := true;

  LaserSeries.Visible := LaserBox.Checked;
  LaserPomocSeries.Visible := LaserPomocBox.Checked;
end;

procedure TPomiarSheetFrame.PaintLedLineBoxClick(Sender: TObject);
begin
  inherited;
  mChart.Invalidate;
end;

procedure TPomiarSheetFrame.mChartAfterDraw(Sender: TObject);
var
  cv: TCanvas;
  RW: TRect;
  Chart: TChart;
  Ybase : single;

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
    Ybase := mViewData.Info.MeasKalibrRec.minWydech;

    Chart := mChart;
    cv := Chart.Canvas.ReferenceCanvas;
    RW := TBaseChartFrame.getChartWorkRect(Chart);
    TBaseChartFrame.DrawChartCursor(Chart, pomiarChartDt1, clGreen);
    TBaseChartFrame.DrawChartCursor(Chart, pomiarChartDt2, clMaroon);
    if PaintLedLineBox.Checked then
    begin
      // DrawHorizLine(mViewData.Info.CharPar.tabLevel[7]-Ybase, clRED);
      DrawHorizLine(mViewData.Info.CharPar.tabLevel[7]-Ybase, clGreen);
      DrawHorizLine(mViewData.Info.CharPar.tabLevel[3]-Ybase, clGreen);
      DrawHorizLine(mViewData.Info.CharPar.tabLevel[0]-Ybase, clRed);

    end;
  end;

end;

procedure TPomiarSheetFrame.mChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  procedure FillGrid(nr: Integer; const dt: TKalibrChartDt);
  begin
    PomMeasGrid.Cells[1, nr] := FormatFloat('0.00', dt.valX) + ' [s]';
    PomMeasGrid.Cells[2, nr] := FormatFloat('0.00', dt.valY_L) + ' [mm]';
    PomMeasGrid.Cells[3, nr] := FormatFloat('0.00', dt.valY_R) + ' [mm]';
    PomMeasGrid.Cells[4, nr] := FormatFloat('0.00', dt.valY_R - dt.valY_L) + ' [mm]';
  end;

begin
  if ssCtrl in Shift then
    pomiarChartDt2.setPos(mChart, X, Y)
  else
    pomiarChartDt1.setPos(mChart, X, Y);

  FillGrid(1, pomiarChartDt1);
  FillGrid(2, pomiarChartDt2);

  PomMeasGrid.Cells[1, 3] := FormatFloat('0.00', pomiarChartDt1.valX - pomiarChartDt2.valX) + ' [s]';
  PomMeasGrid.Cells[2, 3] := FormatFloat('0.00', pomiarChartDt1.valY_L - pomiarChartDt2.valY_L) + ' [mm]';
  PomMeasGrid.Cells[3, 3] := FormatFloat('0.00', pomiarChartDt1.valY_R - pomiarChartDt2.valY_R) + ' [mm]';
  PomMeasGrid.Cells[4, 3] := '';

  LiczLeds(X);
end;

procedure TPomiarSheetFrame.mChartMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if PaintOnMouseMove.Checked then
    LiczLeds(X);
end;

procedure TPomiarSheetFrame.LiczLeds(X: Integer);
var
  i: Integer;
  b: byte;
  time: double;
  idx: Integer;
  Y: double;

begin

  time := mChart.BottomAxis.CalcPosPoint(X);
  idx := round(time * MEAS_PER_SEK_DIV);
  if (idx < PasSeries.Count) and (idx >= 0) then
  begin
    Y := PasSeries.YValue[idx] + mViewData.Info.MeasKalibrRec.minWydech;

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
    OutputDebugString(PChar(format('Led=%02X, y=%f t=%f idx=%d', [b, Y, time, idx])));
  end;
end;

procedure TPomiarSheetFrame.doOnShow;
var
  i, n: Integer;
  X: double;
  Y1, y2: double;
  chCnt: Integer;
begin
  PomMeasGrid.Rows[0].CommaText := 'lp. Czas Dystans "Dyst.pom" Ró¿nica';
  PomMeasGrid.Cols[0].CommaText := 'lp. kursor odniesienie ró¿nica';

  PasSeries.Clear;
  LaserSeries.Clear;
  LaserPomocSeries.Clear;

  if Assigned(mViewData) then
  begin
    LaserBox.Enabled := mViewData.MeasData.isLaserData;
    LaserPomocBox.Enabled := mViewData.MeasData.isLaserPomocData;

    chCnt := mViewData.MeasData.getChannelCnt;
    n := mViewData.MeasData.getCnt div chCnt;
    for i := 0 to n - 1 do
    begin
      X := i / MEAS_PER_SEK_DIV;
      if mViewData.MeasData.isPasData then
      begin
        Y1 := mViewData.MeasData.getDistVal(i);
        PasSeries.AddXY(X, Y1);
      end;
      if mViewData.MeasData.isLaserData then
      begin
        Y1 := mViewData.MeasData.getLaserVal(i);
        LaserSeries.AddXY(X, Y1);
      end;
      if mViewData.MeasData.isLaserPomocData then
      begin
        Y1 := mViewData.MeasData.getPomDistVal(i);
        LaserPomocSeries.AddXY(X, Y1);
      end;
    end;

  end;
end;

procedure TPomiarSheetFrame.doAfterdataLoaded(oncoData: TOncoObject);
begin

end;

procedure TPomiarSheetFrame.saveToReg(reg: TGkRegistry);
begin
  reg.WriteBool('LaserBox', LaserBox.Checked);
  reg.WriteBool('LaserPomocBox', LaserPomocBox.Checked);
  reg.WriteBool('PaintOnMouseMove', PaintOnMouseMove.Checked);
  reg.WriteBool('PaintLedLineBox', PaintLedLineBox.Checked);
  reg.WriteBool('GridLeftBox', GridLeftBox.Checked);
  reg.WriteBool('GridRightBox', GridRightBox.Checked);
  reg.WriteBool('GridBottomBox', GridBottomBox.Checked);
end;

procedure TPomiarSheetFrame.ZmRightAxisBoxClick(Sender: TObject);
var
  min, max, del: double;
begin
  inherited;
  if ZmRightAxisBox.Checked then
  begin
    min := mChart.RightAxis.Minimum;
    max := mChart.RightAxis.Maximum;
    del := max - min;
    min := min - 0.1*del;
    max := max + 0.1*del;
    mChart.RightAxis.SetMinMax(min, max);
  end
  else
  begin
    mChart.RightAxis.Automatic := true;
    mChart.UndoZoom;
  end;
end;

procedure TPomiarSheetFrame.loadFromReg(reg: TGkRegistry);
begin
  reg.RegCheckBox('LaserBox', LaserBox);
  reg.RegCheckBox('LaserPomocBox', LaserPomocBox);
  reg.RegCheckBox('GridLeftBox', GridLeftBox);
  reg.RegCheckBox('GridRightBox', GridRightBox);
  reg.RegCheckBox('GridBottomBox', GridBottomBox);
  reg.RegCheckBox('PaintOnMouseMove', PaintOnMouseMove);
  reg.RegCheckBox('PaintLedLineBox', PaintLedLineBox);
end;

end.
