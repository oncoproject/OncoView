unit framePomiarNewUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frameBaseChartUnit, VclTee.TeeGDIPlus,
  Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls, VclTee.TeEngine, VclTee.Series,
  VclTee.TeeProcs, VclTee.Chart,
  InfoDataUnit, Wykres3Unit, WykresEngUnit;

type
  TPomiarNewSheetFrame = class(TBaseChartFrame)
    PomMeasGrid: TStringGrid;
    LedsPB: TPaintBox;
    PaintLedLineBox: TCheckBox;
    PaintOnMouseMove: TCheckBox;
    Panel2: TPanel;
    procedure LedsPBPaint(Sender: TObject);

  private
    mLedState: byte;
    wykres: TElWykres;
    PanelTab: array [1 .. 4] of TAnalogPanel;
    procedure LiczLeds(val: double);
    procedure OnWykresGetValue(Sender: TObject; DtNr: Integer; NrProb: Cardinal; var val: double; var Exist: boolean);
    procedure OnWykresMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure OnWykresOnTagNotify(Sender: TObject; Panel: TChartPanel; Tag: TTag; Func: TTagFunc);

  public
    constructor Create(AOwner: TComponent); override;
    procedure doOnShow;
    procedure doAfterdataLoaded(oncoData: TOncoObject);
    procedure saveToReg(reg: TGkRegistry);
    procedure loadFromReg(reg: TGkRegistry);
  end;

implementation

{$R *.dfm}

constructor TPomiarNewSheetFrame.Create(AOwner: TComponent);
var
  pn: TAnalogPanel;
  ser: TAnalogSerie;

begin
  inherited;
  wykres := TElWykres.Create(self);
  wykres.Parent := self;
  wykres.Align := alClient;
  wykres.InfoFileds := [ifAVR, ifMAX, ifMIN];
  wykres.ShowPoints := true;

  pn := wykres.AddAnalogPanel;
  pn.Title := 'PAS';
  pn.PropHeigh := 4;
  ser := pn.Series.CreateNew(0);
  ser.PenColor := clBlack;
  PanelTab[1] := pn;

  pn := wykres.AddAnalogPanel;
  pn.Title := 'LASER';
  pn.PropHeigh := 3;
  ser := pn.Series.CreateNew(1);
  ser.PenColor := clBlack;
  PanelTab[2] := pn;

  pn := wykres.AddAnalogPanel;
  pn.Title := 'LASER-POM';
  pn.PropHeigh := 3;
  ser := pn.Series.CreateNew(2);
  ser.PenColor := clBlack;
  PanelTab[3] := pn;

  pn := wykres.AddAnalogPanel;
  pn.Title := 'KEYS';
  pn.MinR := -0.2;
  pn.MaxR := 1.2;
  ser := pn.Series.CreateNew(3);
  ser.PenColor := clRED;
  ser := pn.Series.CreateNew(4);
  ser.PenColor := clBLUE;
  PanelTab[4] := pn;

  wykres.OnGetAnValue := OnWykresGetValue;
  wykres.OnMouseMove := OnWykresMouseMove;
  wykres.OnTagNotify := OnWykresOnTagNotify;
end;

procedure TPomiarNewSheetFrame.OnWykresGetValue(Sender: TObject; DtNr: Integer; NrProb: Cardinal; var val: double;
  var Exist: boolean);
begin
  Exist := false;
  if assigned(mViewData) then
  begin

    case DtNr of
      0:
        begin
          Exist := mViewData.MeasData.isPasData;
          if Exist then
            val := mViewData.MeasData.getDistVal(NrProb);
        end;
      1:
        begin
          Exist := mViewData.MeasData.isLaserData;
          if Exist then
            val := mViewData.MeasData.getLaserVal(NrProb);

        end;
      2:
        begin
          Exist := mViewData.MeasData.isLaserPomocData;
          if Exist then
            val := mViewData.MeasData.getPomDistVal(NrProb);
        end;
      3:
        begin
          Exist := mViewData.MeasData.isKeysData;
          if Exist then
            val := mViewData.MeasData.getKey1Val(NrProb);
        end;
      4:
        begin
          Exist := mViewData.MeasData.isKeysData;
          if Exist then
            val := mViewData.MeasData.getKey2Val(NrProb);

        end;
    end;
  end;
end;

procedure TPomiarNewSheetFrame.OnWykresMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  tmWzgl: double;
  NrProb: Integer;
  val: double;
begin
  if assigned(mViewData) and assigned(mViewData.MeasData) then
  begin
    tmWzgl := wykres.Engine.PixelToReal(X);
    NrProb := wykres.Engine.GetNrProb4Real(tmWzgl);
    val := mViewData.MeasData.getDistVal(NrProb);
    // OutputDebugString(pchar(Format('tmWzgl=%.5f, NrProb=%d, Val=%.2f', [tmWzgl, NrProb, Val])));
    if PaintOnMouseMove.Checked then
      LiczLeds(val);
  end;

end;

procedure TPomiarNewSheetFrame.OnWykresOnTagNotify(Sender: TObject; Panel: TChartPanel; Tag: TTag; Func: TTagFunc);
var
  i: Integer;
  tm: double;
  mtag: TTag;
  tmWzgl: double;
  NrProb: Integer;
begin
  if assigned(mViewData) and assigned(mViewData.MeasData) then
  begin
    for i := 0 to wykres.Engine.TagList.Count - 1 do
    begin
      mtag := wykres.Engine.TagList.Items[i];
      tm := mtag.TagPos;
      tmWzgl := wykres.Engine.TimeToReal(tm);
      NrProb := wykres.Engine.GetNrProb4Real(tmWzgl);

      PomMeasGrid.Cells[0, i + 1] := mtag.Caption;
      PomMeasGrid.Cells[1, i + 1] := format('%.1f[s]', [tm]);
      PomMeasGrid.Cells[2, i + 1] := format('%.1f[mm]', [mViewData.MeasData.getDistVal(NrProb)]);
      PomMeasGrid.Cells[3, i + 1] := format('%.1f[mm]', [mViewData.MeasData.getLaserVal(NrProb)]);
      PomMeasGrid.Cells[4, i + 1] := format('%.1f[mm]', [mViewData.MeasData.getPomDistVal(NrProb)]);

      if i = 2 then
        break;
    end;
  end;
end;

procedure TPomiarNewSheetFrame.LedsPBPaint(Sender: TObject);
  procedure PanitLedBox(idx: Integer; posX: single; State: boolean);
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

procedure TPomiarNewSheetFrame.LiczLeds(val: double);
var
  i: Integer;
  b: byte;
  Y: double;
begin
  Y := val + mViewData.Info.MeasKalibrRec.minWydech;

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
  OutputDebugString(PChar(format('Led=%02X, y=%f t=%f', [b, Y, time])));
end;

procedure TPomiarNewSheetFrame.doOnShow;
var
  i, n: Integer;
  chCnt: Integer;
  minV, maxV: double;
  del: double;
begin
  PomMeasGrid.Rows[0].CommaText := 'lp. Czas Dystans Laser "Dyst.pom"';
  PomMeasGrid.Cols[0].CommaText := 'lp.';

  if assigned(mViewData) then
  begin

    chCnt := mViewData.MeasData.getChannelCnt;
    n := mViewData.MeasData.getCnt div chCnt;

    wykres.DtPerProbka := 1 / mViewData.MeasData.getDataPerSek;
    wykres.ProbCnt := n;

    PanelTab[1].Visible := mViewData.MeasData.isPasData;
    PanelTab[2].Visible := mViewData.MeasData.isLaserData;
    PanelTab[3].Visible := mViewData.MeasData.isLaserPomocData;
    PanelTab[4].Visible := mViewData.MeasData.isKeysData;

    wykres.Engine.ValFullZoom;

    for i := 1 to 4 do
    begin
      minV := PanelTab[i].Series.minV;
      maxV := PanelTab[i].Series.maxV;
      del := maxV - minV;

      if del > 0 then
      begin
        minV := minV - 0.1 * del;
        maxV := maxV + 0.1 * del;
        PanelTab[i].SetMinMaxR(minV, maxV)
      end
      else
        PanelTab[i].SetMinMaxR(0, 10);

    end;

    wykres.Invalidate;
  end;

end;

procedure TPomiarNewSheetFrame.doAfterdataLoaded(oncoData: TOncoObject);
begin

end;

procedure TPomiarNewSheetFrame.saveToReg(reg: TGkRegistry);
begin
  reg.WriteBool('PaintOnMouseMove', PaintOnMouseMove.Checked);
  reg.WriteBool('PaintLedLineBox', PaintLedLineBox.Checked);
end;

procedure TPomiarNewSheetFrame.loadFromReg(reg: TGkRegistry);
begin
  reg.RegCheckBox('PaintOnMouseMove', PaintOnMouseMove);
  reg.RegCheckBox('PaintLedLineBox', PaintLedLineBox);
end;

end.
