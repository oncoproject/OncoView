unit InfoDataUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  System.zip;

type

  TOncoInfo = class(TObject)
  const
    LEVEL_CNT = 8;
    POINT_CNT = 3;
    CALIBR_PT_CNT = 2;
    CHANNEL_CNT = 4;
    TAB_STEP_LEN = 7;
    DATA_VER_0 = 0;
    DATA_VER_1 = 1;
    DATA_VER_2 = 2;

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
      minVal: single;
      idxMin: integer;
      maxVal: single;
      idxMax: integer;
      Amplituda: single;
      procedure loadFromSL(SL: TInpStrList);
    end;

    TMeasKalibrRec = record
      avrMax: single;
      avrAmpl: single;
      valSuggested: single;
      valApproved: single;
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
    function getMeasureDataCnt: integer;
    function getKalibrDataCnt: integer;
    function getLokalizacjaStr: string;
    function getTrybPomiaruStr: string;
    function getWdechStr: string;
    function isKalibrPasData: boolean;
    function isKalibrLaserData: boolean;
    function isKalibrTestData: boolean;

  end;

  TOncoObject = class(TObject)
  type
    TTeachItem = record
      val: single;
      cnt: integer;
    end;

    TTeachData = record
      tab: array of TTeachItem;
      procedure clear;
      procedure loadFromStream(Stream: TStream);
      function isRdy: boolean;
      function getCnt: integer;
    end;

  public
    Info: TOncoInfo;
    KonfigData: array of single;
    MeasData: array of single;
    TeachData: TTeachData;
    constructor Create;
    destructor Destroy; override;
    function LoadFromFile(Fname: string): boolean;
    function LoadFrom(Stream: TStream): boolean;
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
    DATA_VER_2:
      begin
        Result := s.Length;
      end;
  end;

end;

function TOncoInfo.getKalibrDataCnt: integer;
begin
  Result := getDataCnt(ChnKalibrExis);
end;

function TOncoInfo.isKalibrPasData: boolean;
begin
  Result := (pos('D',ChnKalibrExis) > 0);
end;

function TOncoInfo.isKalibrLaserData: boolean;
begin
  Result := (pos('L',ChnKalibrExis) > 0);
end;

function TOncoInfo.isKalibrTestData: boolean;
begin
  Result := (pos('T',ChnKalibrExis) > 0);
end;

function TOncoInfo.getMeasureDataCnt: integer;
begin
  Result := getDataCnt(ChnMeasExis);
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
  minVal := SL.readAsFloat('Min');
  idxMin := SL.readAsInt('idxMin');
  maxVal := SL.readAsFloat('Max');
  idxMax := SL.readAsInt('idxMax');
  Amplituda := SL.readAsFloat('Ampl');
end;

procedure TOncoInfo.TMeasKalibrRec.loadFromSL(SL: TInpStrList);
var
  i: integer;
begin
  SL.SecName := 'KALIBR_REC';
  avrMax := SL.readAsFloat('avrMax');
  avrAmpl := SL.readAsFloat('avrAmpl');
  valSuggested := SL.readAsFloat('valSuggested');
  valApproved := SL.readAsFloat('valApproved');
  for i := 0 to POINT_CNT - 1 do
  begin
    SL.SecName := 'KALIBR_REC_pt' + inttostr(i);
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

procedure TOncoObject.TTeachData.clear;
begin
  setlength(tab, 0);
end;

procedure TOncoObject.TTeachData.loadFromStream(Stream: TStream);
var
  n: integer;
begin
  Stream.seek(0, soFromBeginning);
  n := Stream.Size div 8;
  setlength(tab, n);
  Stream.Read(tab[0], 8 * n);
end;

function TOncoObject.TTeachData.getCnt: integer;
begin
  Result := Length(tab);
end;

function TOncoObject.TTeachData.isRdy: boolean;
begin
  Result := Length(tab) > 0;
end;

constructor TOncoObject.Create;
begin
  Info := TOncoInfo.Create;

end;

destructor TOncoObject.Destroy;
begin
  Info.Free;
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
  TEACH_TAB = 'teachLaserTab.data';
  TXT_INFO = 'info.txt';

var
  CopyStream: TMemoryStream;
  zip: TZipFile;
  dataStream: TStream;
  Header: TZipHeader;
  n: integer;
begin
  zip := TZipFile.Create;
  CopyStream := TMemoryStream.Create;
  try
    Stream.seek(0, soFromBeginning);
    CopyStream.loadFromStream(Stream);
    zip.Open(CopyStream, zmRead);

    if (zip.IndexOf(KONFIG_DATA) >= 0) and (zip.IndexOf(MEAS_DATA) >= 0) and (zip.IndexOf(TXT_INFO) >= 0) then
    begin

      try
        zip.Read(KONFIG_DATA, dataStream, Header);
        dataStream.seek(0, soFromBeginning);
        n := dataStream.Size div 4;
        setlength(KonfigData, n);
        dataStream.Read(KonfigData[0], 4 * n);
      finally
        dataStream.Free;
      end;

      try
        zip.Read(MEAS_DATA, dataStream, Header);
        dataStream.seek(0, soFromBeginning);
        n := dataStream.Size div 4;
        setlength(MeasData, n);
        dataStream.Read(MeasData[0], 4 * n);
      finally
        dataStream.Free;
      end;

      try
        zip.Read(TXT_INFO, dataStream, Header);
        Info.LoadFrom(dataStream);
      finally
        dataStream.Free;
      end;

      TeachData.clear;
      try
        zip.Read(TEACH_TAB, dataStream, Header);
        TeachData.loadFromStream(dataStream);
      finally
        dataStream.Free;
      end;

      Result := True;
    end
    else
      Result := false;
  finally

  end;

end;

initialization

{$WARN SYMBOL_PLATFORM OFF}
  DotFormatSettings := TFormatSettings.Create(LOCALE_USER_DEFAULT);
{$WARN SYMBOL_PLATFORM ON}
DotFormatSettings.DecimalSeparator := '.';

end.
