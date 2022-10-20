unit InfoDataUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  System.zip, registry, Vcl.StdCtrls, Vcl.ExtCtrls,
  RegKwadr;

const
  KALIBR_PER_SEK_DIV = 50.0; // 50 pomiarów na sekundê dla fazy kalibracji
  MEAS_PER_SEK_DIV = 10.0; // 10 pomiarów na sekundê dla fazy pomiaru

type

  TOncoInfo = class(TObject)
  const
    LEVEL_CNT = 8;
    POINT_CNT = 30;
    CALIBR_PT_CNT = 2;
    CHANNEL_CNT = 4;
    TAB_STEP_LEN = 7;
    DATA_VER_0 = 0;
    DATA_VER_1 = 1;
    DATA_VER_2 = 2;
    DATA_VER_3 = 3;

  type
    TInpStrList = class(TStringList)
    public
      SecName: string;
      function readAsFloat(KeyName: string): single;
      function readAsInt(KeyName: string): integer; overload;
      function readAsInt(KeyName: string; default: integer): integer; overload;
      function readAsStr(KeyName: string): string;
      function readAsBool(KeyName: string): boolean;
    end;

    TCharPar = record
      ChartMin: single;
      ChartMax: single;
      ChartRedMin: single;
      ChartRedMax: single;
      ChartGreenMin: single;
      ChartGreenMax: single;
      tabLevel: array [0 .. LEVEL_CNT - 1] of single;
      procedure loadFromSL(SL: TInpStrList);
    end;

    TMeasRecPoint = record
      tmStart: integer;
      tmLen: integer;
      typ: integer;
      status: integer;
      pasVal: single;
      pasSrKw: single;
      laserVal: single;
      laserSrKw: single;
      AmplOk: boolean;
      procedure loadFromSL(SL: TInpStrList);
      function getTyp: string;
      function getStatus: string;
      function getAmpl: string;
    end;

    TMeasKalibrRec = record
      maxAmpl: single;
      maxWdech: single;
      minWydech: single;
      avrMax: single;
      avrAmpl: single;
      valSuggested: single;
      valApproved: single;
      wspolA: single;
      wspolB: single;
      wspolStatus: integer;

      tabPoint: array [0 .. POINT_CNT - 1] of TMeasRecPoint;
      procedure loadFromSL(SL: TInpStrList);
    end;

    // STM_CFG

    TSpecSett = record
      distanceChannelNr: integer;
      pressureChannelNr: integer;
      testDistChannelNr: integer;
      procedure loadFromSL(SL: TInpStrList);
    end;

    TTcpCfg = record
      tcp_ip: string;
      tcp_mask: string;
      tcp_gw: string;
      procedure loadFromSL(SL: TInpStrList);
    end;

    TCalibrPt = record
      valMeas: single; // wartoœæ zmierzona podczas kalibracji
      valFiz: single; // wartoœæ w jednostkach fizycznych, zadana podczas kalibracji
      procedure loadFromSL(SL: TInpStrList);
    end;

    TCalibrChan = record
      CalibrPt: array [0 .. CALIBR_PT_CNT - 1] of TCalibrPt;
      wspol_a: single;
      wspol_b: single;
      procedure loadFromSL(SL: TInpStrList);
    end;

    TStmCalibr = record
      Chan: array [0 .. CHANNEL_CNT - 1] of TCalibrChan;
      procedure loadFromSL(SL: TInpStrList);
    end;

    TStmLimits = record
      pressurePmax: single; // maksymalne bezpieczne ciœnienie
      distHmax: single; // maksymalny bezpieczny dystans
      timeT1d: single; // max czas na opróŸnienie
      timeT1u: single; // max czas na nape³nienie
      procedure loadFromSL(SL: TInpStrList);
    end;

    TStmParam = record
      // parametry wspólne
      distH1: single; // wartoœæ ciœnienia do którego musi spaœæ przy opró¿nianiu
      pressureP1: single; // maxymalna wartoœæ ciœnienia jaka mo¿e pozostaæ podczas opró¿niania
      // parametry  selftestu
      distH2: single; // dystans na wykonanie testu szczelnoœci
      distH3: single; // maksymalne obni¿enie odleg³oœci podczas testu szczelnoœci
      distH4: single; // wartoœæ ciœnienia do którego musi wzrosn¹æ przy nape³nianiu
      timeT2: single; // czas pauzy przed testem szczelnoœci
      timeT3: single; // czas testu szczelnoœci
      pressureP2: single; // minimalna wartoœæ ciœnienie na dystansie do wykonania testu szczelnoœci
      // parametry pomiaru
      distH5: single; // Poziom przed zak³adaniem pasa.
      distH6: single; // Zwiêkszenie poziomu podczas zak³adania pasa.
      distH7: single; // Minimum podczas pomiaru oddechu.
      distHw: single; // Procent do wyznaczania wartoœci granicznej.
      distH11: single; // Minimalny podskok traktowany jako oddech
      timeT4: single; // Czas sprawdzania popr. doci¹gniêcia pasa
      minBreathPerMin: single; // Minmalna iloœæ oddechów na minute
      maxBreathPerMin: single; // Maksymalna iloœæ oddechów na minute
      configAfterChart: boolean; // czy cze
      TabStep: array [0 .. TAB_STEP_LEN - 1] of single;
      procedure loadFromSL(SL: TInpStrList);
    end;

    TStmCfg = record
      Param: TStmParam;
      Limits: TStmLimits;
      Calibr: TStmCalibr;
      TcpCfg: TTcpCfg;
      SpecSett: TSpecSett;
      procedure loadFromSL(SL: TInpStrList);
    end;

    TChnInfo = record
      PasExist: boolean;
      LaserExist: boolean;
      LaserPomocExist: boolean;
      KeysExist: boolean;
      chnCnt: integer;

      PasOffset: integer;
      LaserOffset: integer;
      DistPomOffset: integer;
      KeysOffset: integer;

      procedure init(s: string);
    end;

  private
    function getDataCnt(s: string): integer;
  public
    measTime: string;
    patientID: string;
    DataVer: integer;

    ChnKalibrExis: string;
    ChnMeasExis: string;
    DevLokaliz: integer;
    TrybMeas: integer;
    WdechMode: integer;
    PomPerSecKalibr: single;
    PomPerSecMeasure: single;

    CharPar: TCharPar;
    MeasKalibrRec: TMeasKalibrRec;
    StmCfg: TStmCfg;

    constructor Create;
    destructor Destroy; override;
    procedure LoadFrom(Stream: TStream);
    function getLokalizacjaStr: string;
    function getTrybPomiaruStr: string;
    function getWdechStr: string;

    function getKalibrChnInfo: TChnInfo;
    function getMeasChnInfo: TChnInfo;
  end;

  TOncoObject = class(TObject)
  type
    TTeachItem = record
      val: single;
      cnt: integer;
    end;

    TKonfigData = class;

    TFloatData = class(TObject)
    protected
      mChInfo: TOncoInfo.TChnInfo;
      mPerSekDiv: single;
    public
      tab: array of single;
      constructor Create(aPerSekDiv: single);
      function getDistVal(idx: integer): single;
      function getLaserVal(idx: integer): single;
      function getPomDistVal(idx: integer): single;
      function getKey1Bool(idx: integer): boolean;
      function getKey2Bool(idx: integer): boolean;
      function getKey1Val(idx: integer): single;
      function getKey2Val(idx: integer): single;

      function getCnt: integer;
      function getPrCnt: integer;
      function getDataPerSek: single;
      procedure loadFromStream(Stream: TStream; aChInfo: TOncoInfo.TChnInfo);
      procedure SaveTxtTab(const Info: TOncoInfo; Fname: string);
      function getChannelCnt: integer;
      function isPasData: boolean;
      function isLaserData: boolean;
      function isLaserPomocData: boolean;
      function isKeysData: boolean;

    end;

    TStabReg = record
      begIdx: integer;
      len: integer;
      pasAvr: single;
      pasSrKw: single;
      laserAvr: single;
      laserSrKw: single;
      pasObl: single;
      errorLaserVal: boolean; // pomiar laserem poza zakresem;
      wdech: boolean; // odcinek jest wdechem (powy¿ej œredniego wskazana)
      errorBeforeWdech: boolean; // punkt wyrzucony poniewa¿ by³ przed pierwszym wdechem
      errorLaserSrKwTooBig: boolean; // odchy³ka laser œrednikwadratowa zbyt du¿a
      errorLineAB_ToBig: boolean; // zbyt du¿a odchy³ka od prostej
      function Err: single;
      function ErrAbs: single;
      function getPointColor: TColor;
      function isOkPoint: boolean;

    end;

    TStabRegTab = record
      tab: array of TStabReg;
      mAvrMiddle: double; // wartoœæ œrednia rozgraniczaj¹ca wdech od wydechu
      procedure copyfrom(src: TStabRegTab);
      procedure clear;
      function getCnt: integer;
      function getMaxErrorIdx: integer;
      procedure clearErrorFlags;
      function getNoErrorCnt: integer;
      procedure remoovePointBeforeWdech;

    end;

    TOcenaTranslRec = record
      isOblRdy: boolean;
      errAvr: double;
      errAvrAbs: double;
      stabRegTab: TStabRegTab;
    end;

    TKonfigData = class(TFloatData)
    private
      mWspA: single;
      mWspB: single;
      mOblRdy: boolean;
    public
      stabRegTab: TStabRegTab;
      procedure loadFromStream(Stream: TStream; aChInfo: TOncoInfo.TChnInfo);
      function LiczAB(maxPointError: double): boolean;

      function getWspA: single;
      function getWspB: single;
      procedure SetSymulParams(wspA, wspB: single);
      procedure liczAutoB;
      function isOblRdy: boolean;
      function getPasObl(laser: double): double;
      procedure getOcena(var ocenaTranslRec: TOcenaTranslRec);
      procedure FindStabReg(minTime, maxAmpl, maxLaserSrKw, maxLaser, minLaser: double);
    end;

    TMeasData = class(TFloatData)
    public

    end;

  public
    Info: TOncoInfo;
    KonfigData: TKonfigData;
    MeasData: TMeasData;
    OnAfterDataLoaded: TNotifyEvent;
    constructor Create(aOnAfterDataLoaded: TNotifyEvent);
    destructor Destroy; override;
    function LoadFromFile(Fname: string): boolean;
    function LoadFrom(Stream: TStream): boolean;
  end;

  TGkRegistry = class(TRegistry)
  public
    function RegInt(KeyName: string; default: integer): integer;
    function RegBool(KeyName: string; default: boolean): boolean;
    procedure RegCheckBox(KeyName: string; box: TCheckBox);
    procedure RegLabEdit(KeyName: string; edit: TLabeledEdit);
  end;

implementation

var
  DotFormatSettings: TFormatSettings;

constructor TOncoInfo.Create;
begin

end;

destructor TOncoInfo.Destroy;
begin

end;

procedure TOncoInfo.LoadFrom(Stream: TStream);
var
  SL: TInpStrList;
begin
  SL := TInpStrList.Create;
  try
    SL.loadFromStream(Stream);
    SL.SecName := 'MAIN';
    measTime := SL.readAsStr('TIME');
    patientID := SL.readAsStr('PATIENT_ID');
    DataVer := SL.readAsInt('DATA_VER');

    ChnKalibrExis := SL.readAsStr('CHN_KALIBR_EXIST');
    ChnMeasExis := SL.readAsStr('CHN_MEAS_EXIST');
    DevLokaliz := SL.readAsInt('DEV_LOKALIZA');
    TrybMeas := SL.readAsInt('MEAS_TRYB');
    PomPerSecKalibr := SL.readAsFloat('POM_PER_SEC_KALIBR');
    PomPerSecMeasure := SL.readAsFloat('POM_PER_SEC_MEASURE');
    WdechMode := SL.readAsInt('WDECH_MODE');

    CharPar.loadFromSL(SL);
    MeasKalibrRec.loadFromSL(SL);
    StmCfg.loadFromSL(SL);
  finally
    SL.Free;
  end;
end;

function TOncoInfo.getDataCnt(s: string): integer;
begin
  case DataVer of
    DATA_VER_0:
      Result := 1;
    DATA_VER_1:
      Result := 2;
    DATA_VER_2, DATA_VER_3:
      begin
        Result := s.Length;
      end;
  else
    Result := 0;
  end;

end;

procedure TOncoInfo.TChnInfo.init(s: string);
  function decKontr(x: integer): integer;
  begin
    dec(x);
    if x >= chnCnt then
      x := 0;
    Result := x;
  end;

var
  p, l, t, k: integer;
begin
  p := pos('D', s);
  l := pos('L', s);
  t := pos('T', s);
  k := pos('K', s);

  PasExist := (p > 0);
  LaserExist := (l > 0);
  LaserPomocExist := (t > 0);
  KeysExist := (k > 0);

  chnCnt := 0;
  if PasExist then
    inc(chnCnt);
  if LaserExist then
    inc(chnCnt);
  if LaserPomocExist then
    inc(chnCnt);
  if KeysExist then
    inc(chnCnt);

  PasOffset := decKontr(p);
  LaserOffset := decKontr(l);
  DistPomOffset := decKontr(t);
  KeysOffset := decKontr(k);

end;

function TOncoInfo.getKalibrChnInfo: TChnInfo;
begin
  Result.init(ChnKalibrExis);
end;

function TOncoInfo.getMeasChnInfo: TChnInfo;
begin
  Result.init(ChnMeasExis);
end;

function TOncoInfo.getLokalizacjaStr: string;
begin
  case DevLokaliz of
    0:
      Result := 'CT';
    1:
      Result := 'MR';
    2:
      Result := 'LA';
    3:
      Result := 'PR';
  else
    Result := '??';

  end;
end;

function TOncoInfo.getTrybPomiaruStr: string;
begin
  case TrybMeas of
    0:
      Result := 'PAS';
    1:
      Result := 'PAS+LASER';
    2:
      Result := 'LASER';
  else
    Result := '???';

  end;

end;

function TOncoInfo.getWdechStr: string;
begin
  if WdechMode = 0 then
    Result := 'Wdech'
  else
    Result := 'Wydech';
end;

function TOncoInfo.TInpStrList.readAsStr(KeyName: string): string;
begin
  Result := Values[SecName + '_' + KeyName];
end;

function TOncoInfo.TInpStrList.readAsFloat(KeyName: string): single;
begin
  try
    Result := StrToFloat(readAsStr(KeyName), DotFormatSettings);
  except
    Result := 0;
  end;
end;

function TOncoInfo.TInpStrList.readAsInt(KeyName: string; default: integer): integer;
begin
  try
    Result := StrToInt(readAsStr(KeyName));
  except
    Result := default;
  end;
end;

function TOncoInfo.TInpStrList.readAsInt(KeyName: string): integer;
begin
  Result := readAsInt(KeyName, 0);
end;

function TOncoInfo.TInpStrList.readAsBool(KeyName: string): boolean;
var
  s1: string;
begin
  s1 := UpperCase(readAsStr(KeyName));
  Result := (s1 = '1') or (s1 = 'TRUE') or (s1 = 'YES');
end;

procedure TOncoInfo.TCharPar.loadFromSL(SL: TInpStrList);
var
  i: integer;
begin
  SL.SecName := 'CHART_PARAMS';
  ChartMin := SL.readAsFloat('ChartMin');
  ChartMax := SL.readAsFloat('ChartMax');
  ChartRedMin := SL.readAsFloat('ChartRedMin');
  ChartRedMax := SL.readAsFloat('ChartRedMax');
  ChartGreenMin := SL.readAsFloat('ChartGreenMin');
  ChartGreenMax := SL.readAsFloat('ChartGreenMax');
  for i := 0 to LEVEL_CNT - 1 do
  begin
    tabLevel[i] := SL.readAsFloat('Lev_' + inttostr(i));
  end;
end;

procedure TOncoInfo.TMeasRecPoint.loadFromSL(SL: TInpStrList);
begin
  tmStart := SL.readAsInt('start', -1);
  if tmStart >= 0 then
  begin
    tmLen := SL.readAsInt('len');
    typ := SL.readAsInt('stabRegType');
    status := SL.readAsInt('status');
    pasVal := SL.readAsFloat('val');
    pasSrKw := SL.readAsFloat('odchSrKw');
    laserVal := SL.readAsFloat('avrValL');
    laserSrKw := SL.readAsFloat('odchSrKwL');
    AmplOk := SL.readAsBool('amplOk');
  end;
end;

function TOncoInfo.TMeasRecPoint.getTyp: string;
begin
  case typ of
    0:
      Result := '?';
    1:
      Result := 'W';
    2:
      Result := 'Y'
  else
    Result := '???'
  end;
end;

function TOncoInfo.TMeasRecPoint.getStatus: string;
begin
  case status of
    0:
      Result := 'ptOk';
    1:
      Result := 'ptNoWdechYet';
    2:
      Result := 'ptMaxSrKw';
    3:
      Result := 'ptDiffError';
  else
    Result := '???';
  end;
end;

function TOncoInfo.TMeasRecPoint.getAmpl: string;
begin
  if AmplOk then
    Result := 'Ok'
  else
    Result := 'TooSmall';

end;

procedure TOncoInfo.TMeasKalibrRec.loadFromSL(SL: TInpStrList);
var
  i: integer;
begin
  SL.SecName := 'KALIBR_REC';
  maxAmpl := SL.readAsFloat('maxAmpl');
  maxWdech := SL.readAsFloat('maxWdech');
  minWydech := SL.readAsFloat('minWydech');

  avrMax := SL.readAsFloat('avrMax');
  avrAmpl := SL.readAsFloat('avrAmpl');
  valSuggested := SL.readAsFloat('valSuggested');
  valApproved := SL.readAsFloat('valApproved');
  wspolA := SL.readAsFloat('wspA');
  wspolB := SL.readAsFloat('wspB');
  wspolStatus := SL.readAsInt('wspStatus');

  for i := 0 to POINT_CNT - 1 do
  begin
    SL.SecName := 'KALIBR_REC_pt_' + inttostr(i);
    tabPoint[i].loadFromSL(SL);
  end;
end;

procedure TOncoInfo.TSpecSett.loadFromSL(SL: TInpStrList);
begin
  distanceChannelNr := SL.readAsInt('distanceChannelNr', -1);
  pressureChannelNr := SL.readAsInt('pressureChannelNr', -1);
  testDistChannelNr := SL.readAsInt('testDistChannelNr', -1);
end;

procedure TOncoInfo.TTcpCfg.loadFromSL(SL: TInpStrList);
begin
  tcp_ip := SL.readAsStr('tcp_ip');
  tcp_mask := SL.readAsStr('tcp_mask');
  tcp_gw := SL.readAsStr('tcp_gw');
end;

procedure TOncoInfo.TCalibrPt.loadFromSL(SL: TInpStrList);
begin
  valMeas := SL.readAsFloat('valMeas');
  valFiz := SL.readAsFloat('valFiz');
end;

procedure TOncoInfo.TCalibrChan.loadFromSL(SL: TInpStrList);
var
  i: integer;
  mem: string;
begin
  mem := SL.SecName;
  for i := 0 to CALIBR_PT_CNT - 1 do
  begin
    SL.SecName := mem + '_pt' + inttostr(i);
    CalibrPt[i].loadFromSL(SL);
  end;
  SL.SecName := mem;
  wspol_a := SL.readAsFloat('wspol_a');
  wspol_b := SL.readAsFloat('wspol_b');
end;

procedure TOncoInfo.TStmCalibr.loadFromSL(SL: TInpStrList);
var
  i: integer;
  mem: string;
begin
  mem := SL.SecName;
  for i := 0 to CHANNEL_CNT - 1 do
  begin
    SL.SecName := mem + '_calibr_ch' + inttostr(i);
    Chan[i].loadFromSL(SL);
  end;
  SL.SecName := mem;
end;

procedure TOncoInfo.TStmLimits.loadFromSL(SL: TInpStrList);
begin
  pressurePmax := SL.readAsFloat('pressurePmax');
  distHmax := SL.readAsFloat('distHmax');
  timeT1d := SL.readAsFloat('timeT1d');
  timeT1u := SL.readAsFloat('timeT1u');
end;

procedure TOncoInfo.TStmParam.loadFromSL(SL: TInpStrList);
var
  i: integer;
begin
  distH1 := SL.readAsFloat('distH1');
  distH2 := SL.readAsFloat('distH2');
  distH3 := SL.readAsFloat('distH3');
  distH4 := SL.readAsFloat('distH4');
  timeT2 := SL.readAsFloat('timeT2');
  timeT3 := SL.readAsFloat('timeT3');
  distH5 := SL.readAsFloat('distH5');
  distH6 := SL.readAsFloat('distH6');
  distH7 := SL.readAsFloat('distH7');
  distHw := SL.readAsFloat('distHw');
  distH11 := SL.readAsFloat('distH11');
  pressureP1 := SL.readAsFloat('pressureP1');
  pressureP2 := SL.readAsFloat('pressureP2');
  timeT4 := SL.readAsFloat('timeT4');
  minBreathPerMin := SL.readAsFloat('minBreathPerMin');
  maxBreathPerMin := SL.readAsFloat('maxBreathPerMin');
  configAfterChart := SL.readAsBool('configAfterChart');
  for i := 0 to TAB_STEP_LEN - 1 do
  begin
    TabStep[i] := SL.readAsFloat('TabStep_' + inttostr(i));
  end;
end;

procedure TOncoInfo.TStmCfg.loadFromSL(SL: TInpStrList);
begin
  SL.SecName := 'STM_CFG';
  Param.loadFromSL(SL);
  Limits.loadFromSL(SL);
  Calibr.loadFromSL(SL);
  TcpCfg.loadFromSL(SL);
  SpecSett.loadFromSL(SL);
end;



// ------ TOncoObject.TFloatData --------------------------------------------

constructor TOncoObject.TFloatData.Create(aPerSekDiv: single);
begin
  inherited Create;
  mPerSekDiv := aPerSekDiv;
end;

function TOncoObject.TFloatData.getDistVal(idx: integer): single;
begin

  Result := tab[mChInfo.chnCnt * idx + mChInfo.PasOffset];
end;

function TOncoObject.TFloatData.getLaserVal(idx: integer): single;
begin
  Result := tab[mChInfo.chnCnt * idx + mChInfo.LaserOffset];
end;

function TOncoObject.TFloatData.getPomDistVal(idx: integer): single;
begin
  Result := tab[mChInfo.chnCnt * idx + mChInfo.DistPomOffset]
end;

function TOncoObject.TFloatData.getKey1Bool(idx: integer): boolean;
var
  v: single;
begin
  v := tab[mChInfo.chnCnt * idx + mChInfo.KeysOffset];
  Result := (v = 2) or (v = 3);
end;

function TOncoObject.TFloatData.getKey2Bool(idx: integer): boolean;
var
  v: single;
begin
  v := tab[mChInfo.chnCnt * idx + mChInfo.KeysOffset];
  Result := (v = 1) or (v = 3);
end;

function TOncoObject.TFloatData.getKey1Val(idx: integer): single;
begin
  if getKey1Bool(idx) then
    Result := 0.4
  else
    Result := 0;
end;

function TOncoObject.TFloatData.getKey2Val(idx: integer): single;
begin
  if getKey2Bool(idx) then
    Result := 1
  else
    Result := 0.6;
end;

function TOncoObject.TFloatData.getDataPerSek: single;
begin
  Result := mPerSekDiv;
end;

function TOncoObject.TFloatData.getCnt: integer;
begin
  Result := Length(tab);
end;

function TOncoObject.TFloatData.getPrCnt: integer;
begin
  Result := getCnt div mChInfo.chnCnt;
end;

procedure TOncoObject.TFloatData.loadFromStream(Stream: TStream; aChInfo: TOncoInfo.TChnInfo);
var
  n: integer;
begin
  mChInfo := aChInfo;
  Stream.seek(0, soFromBeginning);
  n := Stream.Size div 4;
  setlength(tab, n);
  Stream.Read(tab[0], 4 * n);
end;

function TOncoObject.TFloatData.getChannelCnt: integer;
begin
  Result := mChInfo.chnCnt;
end;

function TOncoObject.TFloatData.isPasData: boolean;
begin
  Result := mChInfo.PasExist;
end;

function TOncoObject.TFloatData.isLaserData: boolean;
begin
  Result := mChInfo.LaserExist;
end;

function TOncoObject.TFloatData.isLaserPomocData: boolean;
begin
  Result := mChInfo.LaserPomocExist;
end;

function TOncoObject.TFloatData.isKeysData: boolean;
begin
  Result := mChInfo.KeysExist;
end;

procedure TOncoObject.TFloatData.SaveTxtTab(const Info: TOncoInfo; Fname: string);
var
  SL: TStringList;
  SL2: TStringList;
  n, i, j: integer;
  s: string;
  chCnt: integer;
begin
  SL := TStringList.Create;
  SL2 := TStringList.Create;
  try
     SL2.Delimiter := ';';

    SL2.add('ID');
    SL2.add(Info.patientID);
    SL.add(SL2.DelimitedText);

    SL2.clear;
    SL2.add('Time');
    SL2.add(Info.measTime);
    SL.add(SL2.DelimitedText);

    SL2.clear;
    SL2.add('valApproved');
    SL2.add(FormatFloat('0.000',Info.MeasKalibrRec.valApproved));
    SL.add(SL2.DelimitedText);


    SL.add('');

    n := getPrCnt;
    for i := 0 to n - 1 do
    begin
      SL2.clear;
      SL2.add(inttostr(i));
      SL2.add(FormatFloat('0.000', i / mPerSekDiv));

      chCnt := mChInfo.chnCnt;
      if mChInfo.KeysExist then
        dec(chCnt);

      for j := 0 to chCnt - 1 do
      begin
        SL2.add(FormatFloat('0.000', tab[mChInfo.chnCnt * i + j]));
      end;
      if mChInfo.KeysExist then
      begin
        SL2.add(inttostr(byte(getKey1Bool(i))));
        SL2.add(inttostr(byte(getKey2Bool(i))));
      end;

      s := SL2.DelimitedText;
      SL.add(s);
    end;
    SL.SaveToFile(Fname);
  finally
    SL.Free;
    SL2.Free;
  end;
end;

// ------ TOncoObject.TStabRegTab ----------------------------------------------------------

function TOncoObject.TStabReg.Err: single;
begin
  Result := pasAvr - pasObl;
end;

function TOncoObject.TStabReg.ErrAbs: single;
begin
  Result := abs(pasAvr - pasObl);
end;

function TOncoObject.TStabReg.getPointColor: TColor;
begin
  Result := clBLACK;
  if errorLineAB_ToBig then
    Result := clFuchsia;
  if errorBeforeWdech then
    Result := clBlue;
  if errorLaserSrKwTooBig then
    Result := clRed;
  if errorLaserVal then
    Result := clGreen;

end;

function TOncoObject.TStabReg.isOkPoint: boolean;
begin
  Result := not(errorLineAB_ToBig or errorBeforeWdech or errorLaserSrKwTooBig or errorLaserVal);
end;

procedure TOncoObject.TStabRegTab.copyfrom(src: TStabRegTab);
var
  n, i: integer;
begin
  n := Length(src.tab);
  setlength(tab, n);
  for i := 0 to n - 1 do
    tab[i] := src.tab[i];
end;

procedure TOncoObject.TStabRegTab.clear;
begin
  setlength(tab, 0);
end;

function TOncoObject.TStabRegTab.getCnt: integer;
begin
  Result := Length(tab);
end;

function TOncoObject.TStabRegTab.getMaxErrorIdx: integer;
var
  i, n: integer;
  mx: double;
begin
  Result := -1;
  n := getCnt;
  if n > 0 then
  begin
    mx := -1;
    Result := 0;
    for i := 0 to n - 1 do
    begin
      if tab[i].isOkPoint then
      begin
        if (tab[i].ErrAbs > mx) or (mx < 0) then
        begin
          Result := i;
          mx := tab[i].ErrAbs;
        end;
      end;
    end;
  end;
end;

procedure TOncoObject.TStabRegTab.clearErrorFlags;
var
  i, n: integer;
begin
  n := getCnt;
  for i := 0 to n - 1 do
  begin
    tab[i].errorLineAB_ToBig := false;
  end;
end;

function TOncoObject.TStabRegTab.getNoErrorCnt: integer;
var
  i, n: integer;
begin
  n := getCnt;
  Result := 0;
  for i := 0 to n - 1 do
  begin
    if tab[i].isOkPoint then
      inc(Result);
  end;
end;

// wyrzucenie punktów, sprzed wydechu
procedure TOncoObject.TStabRegTab.remoovePointBeforeWdech;
var
  i, n: integer;
  wasWdech: boolean;
begin
  wasWdech := false;
  n := Length(tab);
  for i := 0 to n - 1 do
  begin
    tab[i].wdech := tab[i].pasAvr > mAvrMiddle;
    wasWdech := wasWdech or tab[i].wdech;
    if not(tab[i].wdech) then
    begin
      if not(wasWdech) then
        tab[i].errorBeforeWdech := true;

    end;

  end;

end;




// ------ TOncoObject.TKonfigData ----------------------------------------------------------

procedure TOncoObject.TKonfigData.loadFromStream(Stream: TStream; aChInfo: TOncoInfo.TChnInfo);
begin
  inherited loadFromStream(Stream, aChInfo);
  mOblRdy := false;
  stabRegTab.clear;
end;

function TOncoObject.TKonfigData.getWspA: single;
begin
  Result := mWspA;
end;

function TOncoObject.TKonfigData.getWspB: single;
begin
  Result := mWspB;
end;

procedure TOncoObject.TKonfigData.SetSymulParams(wspA, wspB: single);
var
  i: integer;
begin
  mWspA := wspA;
  mWspB := wspB;
  mOblRdy := true;
  for i := 0 to stabRegTab.getCnt - 1 do
  begin
    stabRegTab.tab[i].pasObl := getPasObl(stabRegTab.tab[i].laserAvr);
  end;
end;

function TOncoObject.TKonfigData.isOblRdy: boolean;
begin
  Result := mOblRdy;
end;

function TOncoObject.TKonfigData.getPasObl(laser: double): double;
begin
  Result := laser * mWspA + mWspB;
end;

function TOncoObject.TKonfigData.LiczAB(maxPointError: double): boolean;

  function LiczWsp(var wsp: TRegresjaKwadr.TWspol): boolean;
  var
    RegKw: TRegresjaKwadr;
    i, k, n: integer;
  begin
    n := stabRegTab.getCnt;
    RegKw := TRegresjaKwadr.Create(n);
    try
      k := 0;
      for i := 0 to n - 1 do
      begin
        if stabRegTab.tab[i].isOkPoint then
        begin
          RegKw.tab[k].x := stabRegTab.tab[i].laserAvr;
          RegKw.tab[k].y := stabRegTab.tab[i].pasAvr;
          inc(k);
        end;
      end;
      RegKw.ShrinkTab(k);

      Result := RegKw.getWspol(wsp);
    finally
      RegKw.Free;
    end;
  end;

var
  i, n: integer;
  wsp: TRegresjaKwadr.TWspol;
  doAgain: boolean;
  Err: boolean;
begin
  stabRegTab.clearErrorFlags;
  Result := LiczWsp(wsp);
  if Result then
  begin
    SetSymulParams(wsp.a, wsp.b);
    // wyrzucenie punktów, dla ktorych b³ad jest zbyt du¿y
    doAgain := false;
    n := stabRegTab.getCnt;

    for i := 0 to n - 1 do
    begin
      Err := stabRegTab.tab[i].ErrAbs > maxPointError;
      stabRegTab.tab[i].errorLineAB_ToBig := Err;
      if Err then
        doAgain := true;
    end;
    if doAgain then
    begin
      if LiczWsp(wsp) then
        SetSymulParams(wsp.a, wsp.b);
    end;
  end;

end;

procedure TOncoObject.TKonfigData.getOcena(var ocenaTranslRec: TOcenaTranslRec);
var
  i, n: integer;
  sumAvr: double;
  sumAbsAvr: double;
  dist, distobl: double;
begin
  ocenaTranslRec.isOblRdy := isOblRdy;
  if isOblRdy then
  begin
    n := getPrCnt;
    sumAvr := 0;
    sumAbsAvr := 0;
    for i := 0 to n - 1 do
    begin
      dist := getDistVal(i);
      distobl := getPasObl(getLaserVal(i));
      sumAvr := sumAvr + (dist - distobl);
      sumAbsAvr := sumAbsAvr + abs(dist - distobl);
    end;
    ocenaTranslRec.errAvr := sumAvr / n;
    ocenaTranslRec.errAvrAbs := sumAbsAvr / n;
  end;
  ocenaTranslRec.stabRegTab := stabRegTab;
end;

procedure TOncoObject.TKonfigData.liczAutoB;
var
  i, n: integer;
  sum: double;
  dist, distobl: double;
begin
  n := getPrCnt;
  mWspB := 0;
  sum := 0;
  for i := 0 to n - 1 do
  begin
    dist := getDistVal(i);
    distobl := getPasObl(getLaserVal(i));
    sum := sum + (dist - distobl);
  end;
  mWspB := sum / n;

end;

procedure TOncoObject.TKonfigData.FindStabReg(minTime, maxAmpl, maxLaserSrKw, maxLaser, minLaser: double);
  procedure liczRegParam(var reg: TStabReg);
  var
    avr: double;
    srKw: double;
    avrL: double;
    srKwL: double;
    v: single;
    i: integer;
  begin
    avr := 0;
    avrL := 0;
    reg.errorLaserVal := false;
    for i := 0 to reg.len - 1 do
    begin
      avr := avr + getDistVal(reg.begIdx + i);
      v := getLaserVal(reg.begIdx + i);
      avrL := avrL + v;
      if (v < minLaser) or (v > maxLaser) then
        reg.errorLaserVal := true;
    end;
    reg.pasAvr := avr / reg.len;
    reg.laserAvr := avrL / reg.len;
    reg.pasObl := 0;

    srKw := 0;
    srKwL := 0;
    for i := 0 to reg.len - 1 do
    begin
      v := getDistVal(reg.begIdx + i) - reg.pasAvr;
      srKw := srKw + v * v;

      v := getLaserVal(reg.begIdx + i) - reg.laserAvr;
      srKwL := srKwL + v * v;
    end;
    reg.pasSrKw := sqrt(srKw / reg.len);
    reg.laserSrKw := sqrt(srKwL / reg.len);
    reg.errorLaserSrKwTooBig := reg.laserSrKw > maxLaserSrKw;
    reg.errorLineAB_ToBig := false;
    reg.errorBeforeWdech := false;
  end;

// wyszukanie podobnego regionu metod¹ "rozgl¹dania si¹ od œrodka"
  function getAlternateReg(inpR: TStabReg): TStabReg;
  var
    v: single;
    m: integer;
    idx: integer;

  begin
    v := inpR.pasAvr;
    idx := inpR.begIdx + inpR.len div 2;

    // spogl¹danie do ty³u
    m := -1;
    while idx + m > 0 do
    begin
      if abs(getDistVal(idx + m) - v) > maxAmpl then
        break;
      dec(m);
    end;
    Result.begIdx := idx + m + 1;
    // spogl¹danie do przodu
    m := 1;
    while idx + m > 0 do
    begin
      if abs(getDistVal(idx + m) - v) > maxAmpl then
        break;
      inc(m);
    end;
    Result.len := (idx + m - 1) - Result.begIdx;
    liczRegParam(Result);
  end;

var
  idx: integer;
  m, n: integer;
  reg: TStabReg;
  minLen: integer;
  v: single;
  rIdx: integer;
  mMax, mMin: double;
begin
  n := getPrCnt;
  minLen := round(minTime * getDataPerSek);
  setlength(stabRegTab.tab, 0);

  idx := 0;
  mMin := getDistVal(idx);
  mMax := mMin;

  while idx < n - minLen do
  begin
    v := getDistVal(idx);
    if mMax < v then
      mMax := v;
    if mMin > v then
      mMin := v;

    m := 1;
    while idx + m < n do
    begin
      if abs(getDistVal(idx + m) - v) > maxAmpl then
        break;
      inc(m);
    end;
    if m >= minLen then
    begin
      rIdx := Length(stabRegTab.tab);
      setlength(stabRegTab.tab, rIdx + 1);
      stabRegTab.tab[rIdx].begIdx := idx;
      stabRegTab.tab[rIdx].len := m - 1;
      liczRegParam(stabRegTab.tab[rIdx]);
      reg := getAlternateReg(stabRegTab.tab[rIdx]);
      if reg.len > stabRegTab.tab[rIdx].len then
        stabRegTab.tab[rIdx] := reg;

      idx := idx + stabRegTab.tab[rIdx].len;
      stabRegTab.tab[rIdx].len := minLen;
    end
    else
      inc(idx);
  end;

  // wyrzucenie punktów, sprzed wydechu
  stabRegTab.mAvrMiddle := (mMin + mMax) / 2;
  stabRegTab.remoovePointBeforeWdech;
end;



// ------ TOncoObject ----------------------------------------------------------

constructor TOncoObject.Create(aOnAfterDataLoaded: TNotifyEvent);
begin
  inherited Create;
  Info := TOncoInfo.Create;
  KonfigData := TKonfigData.Create(KALIBR_PER_SEK_DIV);
  MeasData := TMeasData.Create(MEAS_PER_SEK_DIV);
  OnAfterDataLoaded := aOnAfterDataLoaded;
end;

destructor TOncoObject.Destroy;
begin
  Info.Free;
  KonfigData.Free;
  MeasData.Free;
end;

function TOncoObject.LoadFromFile(Fname: string): boolean;
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    Stream.LoadFromFile(Fname);
    Result := LoadFrom(Stream);
  finally
    Stream.Free;
  end;
end;

function TOncoObject.LoadFrom(Stream: TStream): boolean;
const
  KONFIG_DATA = 'konfig.data';
  MEAS_DATA = 'measure.data';
  TXT_INFO = 'info.txt';

var
  CopyStream: TMemoryStream;
  zip: TZipFile;
  dataStream: TStream;
  Header: TZipHeader;
begin
  zip := TZipFile.Create;
  CopyStream := TMemoryStream.Create;
  try
    Stream.seek(0, soFromBeginning);
    CopyStream.loadFromStream(Stream);
    zip.Open(CopyStream, zmRead);

    if (zip.IndexOf(KONFIG_DATA) >= 0) and (zip.IndexOf(TXT_INFO) >= 0) then
    begin

      try
        zip.Read(TXT_INFO, dataStream, Header);
        Info.LoadFrom(dataStream);
      finally
        dataStream.Free;
      end;

      try
        zip.Read(KONFIG_DATA, dataStream, Header);
        KonfigData.loadFromStream(dataStream, Info.getKalibrChnInfo);
      finally
        dataStream.Free;
      end;

      if (zip.IndexOf(MEAS_DATA) >= 0) then
      begin
        try
          zip.Read(MEAS_DATA, dataStream, Header);
          MeasData.loadFromStream(dataStream, Info.getMeasChnInfo);
        finally
          dataStream.Free;
        end;
      end;

      if Assigned(OnAfterDataLoaded) then
        OnAfterDataLoaded(self);

      Result := true;
    end
    else
      Result := false;
  finally

  end;

end;

function TGkRegistry.RegInt(KeyName: string; default: integer): integer;
begin
  if ValueExists(KeyName) then
    Result := ReadInteger(KeyName)
  else
    Result := Default;
end;

function TGkRegistry.RegBool(KeyName: string; default: boolean): boolean;
begin
  if ValueExists(KeyName) then
    Result := ReadBool(KeyName)
  else
    Result := Default;
end;

procedure TGkRegistry.RegCheckBox(KeyName: string; box: TCheckBox);
begin
  if ValueExists(KeyName) then
    box.Checked := ReadBool(KeyName);
end;

procedure TGkRegistry.RegLabEdit(KeyName: string; edit: TLabeledEdit);
begin
  if ValueExists(KeyName) then
    edit.Text := ReadString(KeyName);
end;

initialization

{$WARN SYMBOL_PLATFORM OFF}
  DotFormatSettings := TFormatSettings.Create(LOCALE_USER_DEFAULT);
{$WARN SYMBOL_PLATFORM ON}
DotFormatSettings.DecimalSeparator := '.';

end.
