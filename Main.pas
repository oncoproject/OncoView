unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  System.zip,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, System.Actions,
  Vcl.ActnList, Vcl.ComCtrls, System.ImageList, Vcl.ImgList, VclTee.TeEngine,
  Vcl.ExtCtrls, VclTee.TeeProcs, VclTee.Chart, Vcl.ToolWin, registry,

  InfoDataUnit, Vcl.Grids, Vcl.ValEdit, Vcl.StdCtrls, VclTee.Series,
  frameBaseChartUnit,
  frameKalibrUnit, framePomiarUnit, framePomiarNewUnit;

type

  TMainForm = class(TForm)
    ToolBar1: TToolBar;
    LV: TListView;
    MainPageControl: TPageControl;

    InfoSheet: TTabSheet;
    KalibrSheet: TTabSheet;
    MeasSheet: TTabSheet;
    MeasSheetNew: TTabSheet;
    CfgStmSheet: TTabSheet;

    ImageList1: TImageList;
    ActionList1: TActionList;
    ToolButton1: TToolButton;
    actOpen: TAction;
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
    Memo1: TMemo;
    HelpPanel: TPanel;
    HideHelpBtn: TButton;
    ToolButton2: TToolButton;
    actShowHelp: TAction;
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
    Label4: TLabel;
    WersjaDanychText: TStaticText;
    KalibrSheetFrame: TKalibrSheetFrame;
    PomiarSheetFrame: TPomiarSheetFrame;
    PomiarNewSheetFrame: TPomiarNewSheetFrame;
    procedure LVDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InfoSheetShow(Sender: TObject);
    procedure MeasSheetNewShow(Sender: TObject);
    procedure KalibrSheetShow(Sender: TObject);
    procedure KalibrTabControlChange(Sender: TObject);
    procedure CfgStmSheetShow(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HideHelpBtnClick(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actShowHelpExecute(Sender: TObject);
    procedure actSaveCsvUpdate(Sender: TObject);
    procedure actSaveCsvExecute(Sender: TObject);
    procedure actZoomInTimeUpdate(Sender: TObject);
    procedure actUndoZoomExecute(Sender: TObject);
    procedure actZoomInTimeExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actZoomOutTimeExecute(Sender: TObject);
    procedure LVCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure ShowKalibrptGridActUpdate(Sender: TObject);
    procedure KalibrGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure MeasSheetShow(Sender: TObject);

  private

    mViewData: TOncoObject;
    procedure OpenOnpFile(Fname: string);
    procedure OpenZipFile(Fname: string);
    procedure FillKalibrTabControl;

    procedure SaveMeasDataToCvs(Fname: string);
    procedure SaveKonfigDataToCvs(Fname: string);

    procedure saveToReg;
    procedure loadFromReg;
    procedure ZoomTime(m: double);
    procedure AfterDataLoadedProc(Sender: TObject);
    function getViewData(Sender: TBaseChartFrame): TOncoObject;

  public
  end;

var
  MainForm: TMainForm;

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




// ------------------------------------------------------------------------------
// TForm1
// ------------------------------------------------------------------------------

function TMainForm.getViewData(Sender: TBaseChartFrame): TOncoObject;
begin
  Result := mViewData;
end;

procedure TMainForm.saveToReg;
var
  registry: TGkRegistry;
begin
  registry := TGkRegistry.Create;
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

      if registry.OpenKey(REG_KEY + '\PomiarSheet', true) then
        PomiarSheetFrame.saveToReg(registry);

      if registry.OpenKey(REG_KEY + '\KalibrSheet', true) then
        KalibrSheetFrame.saveToReg(registry);

    end;
  finally
    registry.Free;
  end;
end;

procedure TMainForm.loadFromReg;
var
  reg: TGkRegistry;

begin
  reg := TGkRegistry.Create;
  try
    if reg.OpenKey(REG_KEY, true) then
    begin
      Top := reg.RegInt('Top', Top);
      Left := reg.RegInt('Left', Left);
      LV.Width := reg.RegInt('LV_WIDTH', LV.Width);
      if LV.Width = 0 then
        LV.Width := 200;

      LV.Columns[0].Width := reg.RegInt('LV_1Col_WIDTH', LV.Columns[0].Width);
      LV.Columns[1].Width := reg.RegInt('LV_2Col_WIDTH', LV.Columns[1].Width);

      if reg.OpenKey(REG_KEY + '\PomiarSheet', true) then
        PomiarSheetFrame.loadFromReg(reg);

      if reg.OpenKey(REG_KEY + '\KalibrSheet', true) then
        KalibrSheetFrame.loadFromReg(reg);

    end;
  finally
    reg.Free;
  end;
end;

procedure TMainForm.actOpenExecute(Sender: TObject);
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

procedure TMainForm.FormCreate(Sender: TObject);
begin
  mViewData := nil;
  KalibrSheetFrame.OnGetViewData := getViewData;
  PomiarSheetFrame.OnGetViewData := getViewData;
  PomiarNewSheetFrame.OnGetViewData := getViewData;

  loadFromReg;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  saveToReg;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  MeasKalibrGrid.Rows[0].CommaText := 'lp. Start[s] D³[s] Typ Status PasAvr PasSrKw LaserAvr LaserSrKw AmplOk';
end;

procedure TMainForm.LVCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
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

procedure TMainForm.LVDblClick(Sender: TObject);
begin
  if Assigned(LV.Selected) then
  begin
    mViewData := TOncoObject(LV.Selected.Data);
    AfterDataLoadedProc(mViewData);
    MainPageControl.ActivePage.OnShow(nil);
  end;
end;

procedure TMainForm.OpenOnpFile(Fname: string);
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

procedure TMainForm.OpenZipFile(Fname: string);
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

procedure TMainForm.ShowKalibrptGridActUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := Assigned(mViewData) and mViewData.KonfigData.isLaserData;
end;

procedure TMainForm.AfterDataLoadedProc(Sender: TObject);
var
  oncoData: TOncoObject;
begin
  oncoData := Sender as TOncoObject;
  KalibrSheetFrame.doAfterdataLoaded(oncoData);
  PomiarSheetFrame.doAfterdataLoaded(oncoData);
  PomiarNewSheetFrame.doAfterdataLoaded(oncoData);

end;

// -----------------------------------------------------------------------------------

procedure TMainForm.KalibrTabControlChange(Sender: TObject);
begin
  FillKalibrTabControl;
end;

procedure TMainForm.FillKalibrTabControl;
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
  PageSaveCvs: set of byte = [1, 2, 3];

procedure TMainForm.actSaveCsvUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := Assigned(mViewData) and (MainPageControl.ActivePageIndex in PageSaveCvs);
end;

procedure TMainForm.actSaveCsvExecute(Sender: TObject);
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
      2,3:
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
        3:
          SaveMeasDataToCvs(dlg.FileName);

      end;
    end;
  finally
    dlg.Free;
  end;
end;

procedure TMainForm.SaveMeasDataToCvs(Fname: string);
begin
  mViewData.MeasData.SaveTxtTab(mViewData.Info, Fname);
end;

procedure TMainForm.SaveKonfigDataToCvs(Fname: string);
begin

  mViewData.KonfigData.SaveTxtTab(mViewData.Info, Fname);
end;

procedure TMainForm.actShowHelpExecute(Sender: TObject);
begin
  HelpPanel.Visible := not HelpPanel.Visible;
end;

procedure TMainForm.actUndoZoomExecute(Sender: TObject);
begin
  case MainPageControl.ActivePageIndex of
    1:
      KalibrSheetFrame.mChart.UndoZoom;
    2:
      ;
  end;
end;

procedure TMainForm.ZoomTime(m: double);
var
  Chart: TChart;
  R: TRect;
  dx, sx: Integer;
begin
  case MainPageControl.ActivePageIndex of
    1:
      begin
        Chart := KalibrSheetFrame.mChart;
        R := Chart.ChartRect;
        sx := R.CenterPoint.X;
        dx := R.Width div 2;
        dx := round(m * dx);
        R.Left := sx - dx;
        R.Right := sx + dx;
        Chart.ZoomRect(R);
      end;
    2:
    else
      Chart := nil;
  end;
end;

procedure TMainForm.actZoomInTimeExecute(Sender: TObject);
begin
  ZoomTime(0.8);
end;

procedure TMainForm.actZoomOutTimeExecute(Sender: TObject);
begin
  ZoomTime(1 / 0.8);
end;

procedure TMainForm.actZoomInTimeUpdate(Sender: TObject);
var
  q: boolean;
begin
  q := (MainPageControl.ActivePageIndex = 1) or (MainPageControl.ActivePageIndex = 2);
  q := q and Assigned(mViewData);

  (Sender as TAction).Enabled := q;
end;

procedure TMainForm.CfgStmSheetShow(Sender: TObject);
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

procedure TMainForm.InfoSheetShow(Sender: TObject);
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
    PomiarVLE.Values['Kana³y_kalibr'] := mViewData.Info.ChnKalibrExis;
    PomiarVLE.Values['Kana³y_pomiar'] := mViewData.Info.ChnMeasExis;

    PomiarVLE.Values['avrMax'] := DistStr(Kalibr.avrMax);
    PomiarVLE.Values['avrAmpl'] := DistStr(Kalibr.avrAmpl);

    PomiarVLE.Values['valSuggested'] := DistStr(Kalibr.valSuggested);
    PomiarVLE.Values['valApproved'] := DistStr(Kalibr.valApproved);

    PomiarVLE.Values['wspA'] := FormatFloat('0.000', Kalibr.wspolA);
    PomiarVLE.Values['wspB'] := FormatFloat('0.000', Kalibr.wspolB);
    PomiarVLE.Values['wspStatus'] := intToStr(Kalibr.wspolStatus);

    PomiarVLE.Values['maxAmpl'] := FormatFloat('0.000', Kalibr.maxAmpl);
    PomiarVLE.Values['maxWdech'] := FormatFloat('0.000', Kalibr.maxWdech);
    PomiarVLE.Values['minWydech'] := FormatFloat('0.000', Kalibr.minWydech);

  end;
end;

procedure TMainForm.HideHelpBtnClick(Sender: TObject);
begin
  HelpPanel.Visible := false;
end;

procedure TMainForm.KalibrGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
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

procedure TMainForm.KalibrSheetShow(Sender: TObject);
begin
  KalibrSheetFrame.doOnShow;
end;

procedure TMainForm.MeasSheetNewShow(Sender: TObject);
begin
  PomiarNewSheetFrame.doOnShow;
end;

procedure TMainForm.MeasSheetShow(Sender: TObject);
begin
  PomiarSheetFrame.doOnShow;
end;

end.
