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
    KalibrPasSeries: TLineSeries;
    KalibrLaserSeries: TLineSeries;
    KalibrPasOblSer: TLineSeries;
    KalibrPasErrSer: TLineSeries;

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
    KalibrLaserBox: TCheckBox;
    BuildTransTableAct: TAction;
    LiczABBtn: TButton;
    LiczABAct: TAction;
    WspAEdit: TLabeledEdit;
    WspBEdit: TLabeledEdit;
    AutoBBtn: TButton;
    AutoBAct: TAction;
    Memo2: TMemo;
    GroupBox1: TGroupBox;
    StabRegTimeEdit: TLabeledEdit;
    StabRegAmplEdit: TLabeledEdit;
    Button1: TButton;
    LiczStabReg: TAction;
    Splitter2: TSplitter;
    ShowStabRegPcBox: TCheckBox;
    ShowStabRegStmBox: TCheckBox;
    ChartPanel: TPanel;
    PasLaserTransChart: TChart;
    PasLaserAvrSeries: TPointSeries;
    HideChartPanel: TButton;
    showTranclChartBtn: TButton;
    showTranclChartAct: TAction;
    PasLaserLineSeries: TLineSeries;
    KalibrShowPasOblBox: TCheckBox;
    KalibrShowPasErrBox: TCheckBox;
    GridPanel: TPanel;
    HideKalibrGridBtn: TButton;
    KalibrGrid: TStringGrid;
    ShowKalibrptGridBtn: TButton;
    ShowKalibrptGridAct: TAction;
    MaxErrorTxt: TStaticText;
    GroupBox2: TGroupBox;
    KalibrMaxLaserSrKwEdit: TLabeledEdit;
    KalibrMaxPointOdchylEdit: TLabeledEdit;
    MinLaserDataEdit: TLabeledEdit;
    MaxLaserDataEdit: TLabeledEdit;
    ShowPointlabelBox: TCheckBox;
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
    procedure KalibrLaserBoxClick(Sender: TObject);
    procedure BuildTransTableActUpdate(Sender: TObject);
    procedure WspAEditKeyPress(Sender: TObject; var Key: Char);
    procedure AutoBActExecute(Sender: TObject);
    procedure StabRegAmplEditKeyPress(Sender: TObject; var Key: Char);
    procedure LiczStabRegUpdate(Sender: TObject);
    procedure LiczStabRegExecute(Sender: TObject);
    procedure LiczABActExecute(Sender: TObject);
    procedure HideChartPanelClick(Sender: TObject);
    procedure showTranclChartActUpdate(Sender: TObject);
    procedure showTranclChartActExecute(Sender: TObject);
    procedure PasLaserTransChartAfterDraw(Sender: TObject);
    procedure KalibrShowPasErrBoxClick(Sender: TObject);
    procedure KalibrShowPasOblBoxClick(Sender: TObject);
    procedure ShowKalibrptGridActUpdate(Sender: TObject);
    procedure ShowKalibrptGridActExecute(Sender: TObject);
    procedure HideKalibrGridBtnClick(Sender: TObject);
    procedure ShowPointlabelBoxClick(Sender: TObject);
    procedure KalibrGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);

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
    procedure SaveKonfigDataToCvs(Fname: string);

    procedure LiczLeds(X: Integer);
    procedure saveToReg;
    procedure loadFromReg;
    procedure ZoomTime(m: double);
    procedure LoadKalibrRightSeries;
    procedure MakeLaserSymul;
    procedure FillMemoDt;
    procedure LiczKalibrStabRegion(oncoData: TOncoObject);
    procedure AddKalibrChartItems;
    procedure AfterDataLoadedProc(Sender: TObject);
    procedure ReloadKalibrPtGrid;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
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
      registry.WriteBool('KalibrShowPasOblBox', KalibrShowPasOblBox.Checked);
      registry.WriteBool('KalibrShowPasErrBox', KalibrShowPasErrBox.Checked);
      registry.WriteBool('GridLeftBox', GridLeftBox.Checked);
      registry.WriteBool('GridRightBox', GridRightBox.Checked);
      registry.WriteBool('GridBottomBox', GridBottomBox.Checked);
      registry.WriteBool('Grid0LeftBox', Grid0LeftBox.Checked);
      registry.WriteBool('Grid0RightBox', Grid0RightBox.Checked);
      registry.WriteBool('Grid0BottomBox', Grid0BottomBox.Checked);
      registry.WriteBool('ShowStabRegStmBox', ShowStabRegStmBox.Checked);
      registry.WriteBool('ShowStabRegPcBox', ShowStabRegPcBox.Checked);
      registry.WriteString('StabRegAmplEdit', StabRegAmplEdit.Text);
      registry.WriteString('StabRegTimeEdit', StabRegTimeEdit.Text);

      registry.WriteString('MinLaserDataEdit', MinLaserDataEdit.Text);
      registry.WriteString('MaxLaserDataEdit', MaxLaserDataEdit.Text);
      registry.WriteString('KalibrMaxLaserSrKwEdit', KalibrMaxLaserSrKwEdit.Text);
      registry.WriteString('KalibrMaxPointOdchylEdit', KalibrMaxPointOdchylEdit.Text);

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

  procedure RegLabEdit(KeyName: string; edit: TLabeledEdit);
  begin
    if registry.ValueExists(KeyName) then
      edit.Text := registry.ReadString(KeyName);
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
      RegCheckBox('KalibrShowPasOblBox', KalibrShowPasOblBox);
      RegCheckBox('KalibrShowPasErrBox', KalibrShowPasErrBox);
      RegCheckBox('Grid0LeftBox', Grid0LeftBox);
      RegCheckBox('Grid0RightBox', Grid0RightBox);
      RegCheckBox('Grid0BottomBox', Grid0BottomBox);
      RegCheckBox('ShowStabRegStmBox', ShowStabRegStmBox);
      RegCheckBox('ShowStabRegPcBox', ShowStabRegPcBox);
      RegLabEdit('StabRegAmplEdit', StabRegAmplEdit);
      RegLabEdit('StabRegTimeEdit', StabRegTimeEdit);

      RegLabEdit('MinLaserDataEdit', MinLaserDataEdit);
      RegLabEdit('MaxLaserDataEdit', MaxLaserDataEdit);
      RegLabEdit('KalibrMaxLaserSrKwEdit', KalibrMaxLaserSrKwEdit);
      RegLabEdit('KalibrMaxPointOdchylEdit', KalibrMaxPointOdchylEdit);
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
  MeasKalibrGrid.Rows[0].CommaText := 'lp. Start[s] D³[s] Typ Status PasAvr PasSrKw LaserAvr LaserSrKw AmplOk';
  PomMeasGrid.Rows[0].CommaText := 'lp. Czas Dystans "Dyst.pom" Ró¿nica';
  PomMeasGrid.Cols[0].CommaText := 'lp. kursor odniesienie ró¿nica';
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
    AfterDataLoadedProc(mViewData);
    MainPageControl.ActivePage.OnShow(nil);
  end;
end;

procedure TForm1.OpenOnpFile(Fname: string);
var
  OncoObject: TOncoObject;
  LI: TListItem;
begin
  OncoObject := TOncoObject.Create(AfterDataLoadedProc);
  if OncoObject.LoadFromFile(Fname) then
  begin
    LI := LV.Items.Add;
    LI.Caption := OncoObject.Info.patientID;
    LI.SubItems.Add(OncoObject.Info.measTime);
    LI.Data := OncoObject;
    LI.Selected := true;
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
      OncoObject := TOncoObject.Create(AfterDataLoadedProc);

      try
        zip.Read(s, Stream, LocalHeader);

        if OncoObject.LoadFrom(Stream) then
        begin
          LI := LV.Items.Add;
          LI.Caption := OncoObject.Info.patientID;
          LI.SubItems.Add(OncoObject.Info.measTime);
          LI.Data := OncoObject;
          if i = 0 then
            LI.Selected := true;
        end
        else
          OncoObject.Free;

      finally
        Stream.Free;
      end;

    end;

  finally
    zip.Free;
  end;

end;

procedure TForm1.MakeLaserSymul;
var
  wspA, wspB: single;
begin
  if Assigned(mViewData) then
  begin
    try
      wspA := StrToFloat(WspAEdit.Text);
      wspB := StrToFloat(WspBEdit.Text);
      mViewData.KonfigData.SetSymulParams(wspA, wspB);
      KalibrSheetShow(nil);
    except

    end;
  end;
end;

procedure TForm1.WspAEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    MakeLaserSymul;
  end;
end;

procedure TForm1.LiczABActExecute(Sender: TObject);
var
  maxPointError: double;
begin
  maxPointError := StrToFloat(KalibrMaxPointOdchylEdit.Text);

  mViewData.KonfigData.LiczAB(maxPointError);
  WspAEdit.Text := FormatFloat('0.00000', mViewData.KonfigData.getWspA);
  WspBEdit.Text := FormatFloat('0.00000', mViewData.KonfigData.getWspB);
  MakeLaserSymul;
end;

procedure TForm1.showTranclChartActUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := Assigned(mViewData);
end;

procedure TForm1.showTranclChartActExecute(Sender: TObject);
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

procedure TForm1.HideKalibrGridBtnClick(Sender: TObject);
begin
  GridPanel.Visible := false;
end;

procedure TForm1.ShowKalibrptGridActUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := Assigned(mViewData) and mViewData.Info.isKalibrLaserData;
end;

procedure TForm1.ShowPointlabelBoxClick(Sender: TObject);
begin
  PasLaserAvrSeries.Marks.Visible := ShowPointlabelBox.Checked;
end;

procedure TForm1.ReloadKalibrPtGrid;
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

procedure TForm1.ShowKalibrptGridActExecute(Sender: TObject);
begin
  GridPanel.Visible := not(GridPanel.Visible);
  ReloadKalibrPtGrid;
end;

procedure TForm1.PasLaserTransChartAfterDraw(Sender: TObject);
var
  cv: TCanvas;
  Chart: TChart;
  RW: TRect;
begin

  Chart := KalibrChart;
  cv := Chart.Canvas.ReferenceCanvas;
  RW := getChartWorkRect(Chart);
  DrawChartCursor(Chart, kalibrChartDt, clGreen);

end;

procedure TForm1.AutoBActExecute(Sender: TObject);
begin
  mViewData.KonfigData.liczAutoB;
  WspBEdit.Text := FormatFloat('0.00000', mViewData.KonfigData.getWspB);
  MakeLaserSymul;
end;

procedure TForm1.StabRegAmplEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    LiczKalibrStabRegion(mViewData);
    KalibrSheetShow(nil);
  end;
end;

procedure TForm1.LiczKalibrStabRegion(oncoData: TOncoObject);
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

procedure TForm1.LiczStabRegExecute(Sender: TObject);
begin
  LiczKalibrStabRegion(mViewData);
  KalibrSheetShow(nil);
end;

procedure TForm1.LiczStabRegUpdate(Sender: TObject);
begin
  if Assigned(mViewData) then
    (Sender as TAction).Enabled := mViewData.Info.isKalibrPasData
  else
    (Sender as TAction).Enabled := false;

end;

procedure TForm1.AfterDataLoadedProc(Sender: TObject);
var
  oncoData: TOncoObject;
  maxPointError: double;
begin
  maxPointError := StrToFloat(KalibrMaxPointOdchylEdit.Text);
  oncoData := Sender as TOncoObject;
  LiczKalibrStabRegion(oncoData);
  oncoData.KonfigData.LiczAB(maxPointError);
  WspAEdit.Text := FormatFloat('0.00000', oncoData.KonfigData.getWspA);
  WspBEdit.Text := FormatFloat('0.00000', oncoData.KonfigData.getWspB);
  KalibrShowPasOblBox.Enabled := oncoData.Info.isKalibrLaserData;
  KalibrShowPasErrBox.Enabled := oncoData.Info.isKalibrLaserData;
  ReloadKalibrPtGrid;
end;

// -----------------------------------------------------------------------------------
procedure TForm1.LedsPBPaint(Sender: TObject);
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

const
  PageSaveCvs: set of byte = [1, 2, 4];

procedure TForm1.actSaveCsvUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := Assigned(mViewData) and (MainPageControl.ActivePageIndex in PageSaveCvs);
end;

procedure TForm1.actSaveCsvExecute(Sender: TObject);
var
  dlg: TSaveDialog;
  nm: string;
begin
  dlg := TSaveDialog.Create(self);
  try
    dlg.Filter := 'Pliki Excel|*.csv|Wszystkie pliki|*.*';
    dlg.DefaultExt := 'csv';
    nm := '';

    case MainPageControl.ActivePageIndex of
      1:
        nm := 'KonfiData_';
      2:
        nm := 'MeasData_';
      4:
        nm := 'TransTable_';
    end;

    dlg.FileName := nm + mViewData.Info.patientID + '_' + mViewData.Info.measTime;
    if dlg.Execute then
    begin
      case MainPageControl.ActivePageIndex of
        1:
          SaveKonfigDataToCvs(dlg.FileName);
        2:
          SaveMeasDataToCvs(dlg.FileName);

      end;
    end;
  finally
    dlg.Free;
  end;
end;

procedure TForm1.SaveMeasDataToCvs(Fname: string);
begin
  mViewData.MeasData.SaveTxtTab(Fname);
end;

procedure TForm1.SaveKonfigDataToCvs(Fname: string);
begin
  mViewData.KonfigData.SaveTxtTab(Fname);
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

procedure TForm1.BuildTransTableActUpdate(Sender: TObject);
begin
  if Assigned(mViewData) then
    (Sender as TAction).Enabled := mViewData.Info.isKalibrPasData and mViewData.Info.isKalibrLaserData
  else
    (Sender as TAction).Enabled := false;
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

    StmVLE.Values['DistanceChannelNr'] := intToStr(Cfg.SpecSett.distanceChannelNr);
    StmVLE.Values['PressureChannelNr'] := intToStr(Cfg.SpecSett.pressureChannelNr);
    StmVLE.Values['TestDistChannelNr'] := intToStr(Cfg.SpecSett.testDistChannelNr);

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
      StmVLE.Values['Led_step_' + intToStr(i)] := DistStr(Cfg.Param.TabStep[i]);
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
    WersjaDanychText.Caption := intToStr(mViewData.Info.DataVer);

    Kalibr := mViewData.Info.MeasKalibrRec;

    MeasKalibrGrid.RowCount := TOncoInfo.POINT_CNT + 1;
    for i := 0 to TOncoInfo.POINT_CNT - 1 do
    begin
      if Kalibr.tabPoint[i].tmStart >= 0 then
      begin
        MeasKalibrGrid.Cells[0, 1 + i] := intToStr(i + 1);
        MeasKalibrGrid.Cells[1, 1 + i] := FormatFloat('0.00', Kalibr.tabPoint[i].tmStart / KALIBR_PER_SEK_DIV);
        MeasKalibrGrid.Cells[2, 1 + i] := FormatFloat('0.00', Kalibr.tabPoint[i].tmLen / KALIBR_PER_SEK_DIV);
        MeasKalibrGrid.Cells[3, 1 + i] := Kalibr.tabPoint[i].getTyp;
        MeasKalibrGrid.Cells[4, 1 + i] := Kalibr.tabPoint[i].getStatus;
        MeasKalibrGrid.Cells[5, 1 + i] := FormatFloat('0.00', Kalibr.tabPoint[i].pasVal);
        MeasKalibrGrid.Cells[6, 1 + i] := FormatFloat('0.00', Kalibr.tabPoint[i].pasSrKw);
        MeasKalibrGrid.Cells[7, 1 + i] := FormatFloat('0.00', Kalibr.tabPoint[i].laserVal);
        MeasKalibrGrid.Cells[8, 1 + i] := FormatFloat('0.00', Kalibr.tabPoint[i].laserSrKw);
        MeasKalibrGrid.Cells[9, 1 + i] := Kalibr.tabPoint[i].getAmpl;



      end
      else
        MeasKalibrGrid.Rows[1 + i].CommaText := intToStr(i + 1);
    end;

    PomiarVLE.Values['Lokalizacja'] := mViewData.Info.getLokalizacjaStr;
    PomiarVLE.Values['TrybPomiaru'] := mViewData.Info.getTrybPomiaruStr;
    PomiarVLE.Values['Wdech/wydech'] := mViewData.Info.getWdechStr;
    PomiarVLE.Values['Kana³y'] := mViewData.Info.ChnKalibrExis;

    PomiarVLE.Values['avrMax'] := DistStr(Kalibr.avrMax);
    PomiarVLE.Values['avrAmpl'] := DistStr(Kalibr.avrAmpl);
    PomiarVLE.Values['valSuggested'] := DistStr(Kalibr.valSuggested);
    PomiarVLE.Values['valApproved'] := DistStr(Kalibr.valApproved);

    PomiarVLE.Values['wspA'] := FormatFloat('0.000', Kalibr.wspolA);
    PomiarVLE.Values['wspB'] := FormatFloat('0.000', Kalibr.wspolB);
    PomiarVLE.Values['wspStatus'] := intToStr(Kalibr.wspolStatus);

  end;
end;

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

procedure TForm1.GridRightBoxClick(Sender: TObject);
begin
  PomiarChart.RightAxis.Grid.Visible := (Sender as TCheckBox).Checked;
end;

procedure TForm1.HideChartPanelClick(Sender: TObject);
begin
  ChartPanel.Visible := false;
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
  Chart := KalibrChart;
  cv := Chart.Canvas.ReferenceCanvas;
  RW := getChartWorkRect(Chart);
  DrawChartCursor(Chart, kalibrChartDt, clGreen);

  if Assigned(mViewData) then
  begin

    dataPerSek := mViewData.KonfigData.getDataperSek;

    if ShowStabRegStmBox.Checked then
    begin

      for i := 0 to TOncoInfo.POINT_CNT - 1 do
      begin

//        drawVLine(mViewData.Info.MeasKalibrRec.tabPoint[i].idxMin, clGreen);  todo
//        drawVLine(mViewData.Info.MeasKalibrRec.tabPoint[i].idxMax, clBlue);
      end;

      v := mViewData.Info.MeasKalibrRec.avrMax;
      Y := Chart.LeftAxis.CalcYPosValue(v);
      cv.Pen.color := clRed;
      cv.MoveTo(RW.Left, Y);
      cv.LineTo(RW.Right, Y);
    end;

    // rysowanie poziomych kresek zgodnie z tabel¹ "ocena.stabRegTab"
    if ShowStabRegPcBox.Checked then
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

procedure TForm1.KalibrChartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ssCtrl in Shift then
    kalibrChartDt.setPos(KalibrChart, X, Y);
end;

procedure TForm1.KalibrDystPomBoxClick(Sender: TObject);
begin
  KalibrLaserBox.Checked := false;
  KalibrLaserSeries.Visible := KalibrDystPomBox.Checked;
  LoadKalibrRightSeries;
end;

procedure TForm1.KalibrGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Gr: TStringGrid;
  color: TColor;
  reg: TOncoObject.TStabReg;
begin
  Gr := Sender as TStringGrid;
  color := clBLACK;
  if ARow > 0 then
  begin
    reg := mViewData.KonfigData.stabRegTab.tab[ARow - 1];
    color := reg.getPointColor;
  end;
  Gr.Canvas.Font.color := color;
  Gr.Canvas.FillRect(Rect);
  Gr.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Gr.Cells[ACol, ARow]);
end;

procedure TForm1.KalibrLaserBoxClick(Sender: TObject);
begin
  KalibrDystPomBox.Checked := false;
  KalibrLaserSeries.Visible := KalibrLaserBox.Checked;
  LoadKalibrRightSeries;
end;

procedure TForm1.KalibrShowPasErrBoxClick(Sender: TObject);
begin
  KalibrSheetShow(nil);
end;

procedure TForm1.KalibrShowPasOblBoxClick(Sender: TObject);
begin
  KalibrSheetShow(nil);

end;

procedure TForm1.PaintLedLineBoxClick(Sender: TObject);
begin
  PomiarChart.Invalidate;
end;

procedure TForm1.PomiarChartAfterDraw(Sender: TObject);
var
  cv: TCanvas;
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
      DrawHorizLine(mViewData.Info.CharPar.tabLevel[0], clRed);

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
    OutputDebugString(PChar(format('Led=%02X, y=%f t=%f idx=%d', [b, Y, time, idx])));
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
  yLaser: double;
  yObl: double;
  chCnt: Integer;
  dataPerSek: single;
begin
  KalibrPasOblSer.Visible := KalibrShowPasOblBox.Checked;
  KalibrPasErrSer.Visible := KalibrShowPasErrBox.Checked;

  KalibrPasSeries.Clear;
  KalibrPasOblSer.Clear;
  KalibrPasErrSer.Clear;

  if Assigned(mViewData) then
  begin
    chCnt := mViewData.Info.getKalibrChannelCnt;
    n := mViewData.KonfigData.getCnt;
    n := n div chCnt;

    dataPerSek := mViewData.KonfigData.getDataperSek;
    for i := 0 to n - 1 do
    begin

      X := i / dataPerSek;
      Y := mViewData.KonfigData.tab[chCnt * i + 0];
      KalibrPasSeries.AddXY(X, Y);

      if mViewData.KonfigData.isOblRdy then
      begin
        yLaser := mViewData.KonfigData.tab[chCnt * i + 1];
        yObl := mViewData.KonfigData.getPasObl(yLaser);
        KalibrPasOblSer.AddXY(X, yObl);
        KalibrPasErrSer.AddXY(X, Y - yObl);
      end;

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
  AddKalibrChartItems;
  FillMemoDt;
end;

procedure TForm1.FillMemoDt;
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

procedure TForm1.AddKalibrChartItems;
begin

end;

procedure TForm1.LoadKalibrRightSeries;
var
  i, n: Integer;
  X: double;
  yPom: double;
  chCnt: Integer;
  dtOfs: Integer;
  dataPerSek: single;
begin
  KalibrLaserSeries.Clear;
  KalibrLaserSeries.Visible := KalibrDystPomBox.Checked or KalibrLaserBox.Checked;

  if Assigned(mViewData) then
  begin
    chCnt := mViewData.Info.getKalibrChannelCnt;
    n := mViewData.KonfigData.getCnt div chCnt;
    if chCnt >= 2 then
    begin
      if KalibrLaserBox.Checked then
        dtOfs := 1
      else
        dtOfs := 2;

      dataPerSek := mViewData.KonfigData.getDataperSek;
      for i := 0 to n - 1 do
      begin
        X := i / dataPerSek;
        yPom := mViewData.KonfigData.tab[chCnt * i + dtOfs];
        KalibrLaserSeries.AddXY(X, yPom);
      end;
    end;
  end;
end;

procedure TForm1.KalibrShowPointsBoxClick(Sender: TObject);
begin
  KalibrPasSeries.Pointer.Visible := KalibrShowPointsBox.Checked;
end;

procedure TForm1.MeasDystPomBoxClick(Sender: TObject);
begin
  PomiarSer2.Visible := MeasDystPomBox.Checked;
end;

procedure TForm1.MeasSheetShow(Sender: TObject);
var
  i, n: Integer;
  X: double;
  Y1, y2: double;
  chCnt: Integer;
begin
  PomiarSer1.Clear;
  PomiarSer2.Clear;
  if Assigned(mViewData) then
  begin
    chCnt := mViewData.Info.getKalibrChannelCnt;
    n := mViewData.MeasData.getCnt div chCnt;
    for i := 0 to n - 1 do
    begin
      X := i / MEAS_PER_SEK_DIV;
      Y1 := mViewData.MeasData.tab[chCnt * i + 0];
      PomiarSer1.AddXY(X, Y1);
      if chCnt >= 2 then
      begin
        y2 := mViewData.MeasData.tab[chCnt * i + 1];
        PomiarSer2.AddXY(X, y2);
      end;
    end;

  end;
end;

end.
