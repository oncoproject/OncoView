object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'OncoProject viewer, ver 2.0.8'
  ClientHeight = 722
  ClientWidth = 1373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    1373
    722)
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 313
    Top = 24
    Height = 698
    ExplicitLeft = 640
    ExplicitTop = 328
    ExplicitHeight = 100
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 1373
    Height = 24
    ButtonWidth = 40
    Caption = 'ToolBar1'
    Images = ImageList1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actOpen
    end
    object ToolButton2: TToolButton
      Left = 40
      Top = 0
      Action = actShowHelp
    end
    object ToolButton3: TToolButton
      Left = 80
      Top = 0
      Action = actSaveCsv
    end
    object ToolButton4: TToolButton
      Left = 120
      Top = 0
      Width = 17
      Caption = 'ToolButton4'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 137
      Top = 0
      Action = actUndoZoom
    end
    object ToolButton6: TToolButton
      Left = 177
      Top = 0
      Action = actZoomInTime
    end
    object ToolButton7: TToolButton
      Left = 217
      Top = 0
      Action = actZoomOutTime
    end
  end
  object LV: TListView
    Left = 0
    Top = 24
    Width = 313
    Height = 698
    Align = alLeft
    Columns = <
      item
        Caption = 'Identyfikator'
        Width = 100
      end
      item
        Caption = 'Data wykonania'
        Width = 200
      end>
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Cambria'
    Font.Style = []
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    SortType = stData
    TabOrder = 1
    ViewStyle = vsReport
    OnCompare = LVCompare
    OnDblClick = LVDblClick
  end
  object MainPageControl: TPageControl
    Left = 316
    Top = 24
    Width = 1057
    Height = 698
    ActivePage = InfoSheet
    Align = alClient
    TabOrder = 2
    object InfoSheet: TTabSheet
      Caption = 'Informacje'
      OnShow = InfoSheetShow
      DesignSize = (
        1049
        670)
      object Label1: TLabel
        Left = 3
        Top = 3
        Width = 77
        Height = 16
        Caption = 'ID pacjenta'
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 3
        Top = 55
        Width = 31
        Height = 16
        Caption = 'Data'
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 3
        Top = 162
        Width = 119
        Height = 16
        Caption = 'Kalibracja pomiaru'
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 3
        Top = 105
        Width = 97
        Height = 16
        Caption = 'Wersja danych'
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object PatiendIdText: TStaticText
        Left = 22
        Top = 25
        Width = 881
        Height = 24
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        BevelKind = bkFlat
        Caption = '...'
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Lucida Console'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object DateText: TStaticText
        Left = 22
        Top = 77
        Width = 881
        Height = 24
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        BevelKind = bkFlat
        Caption = '...'
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Lucida Console'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object MeasKalibrGrid: TStringGrid
        Left = 22
        Top = 419
        Width = 1011
        Height = 238
        Anchors = [akLeft, akTop, akRight, akBottom]
        ColCount = 10
        DefaultColWidth = 100
        RowCount = 4
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object PomiarVLE: TValueListEditor
        Left = 22
        Top = 184
        Width = 427
        Height = 207
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Lucida Console'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goAlwaysShowEditor, goThumbTracking]
        ParentFont = False
        TabOrder = 3
        ColWidths = (
          150
          271)
      end
      object WersjaDanychText: TStaticText
        Left = 22
        Top = 127
        Width = 78
        Height = 24
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        AutoSize = False
        BevelKind = bkFlat
        Caption = '...'
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Lucida Console'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
    end
    object KalibrSheet: TTabSheet
      Caption = 'Kalibracja'
      ImageIndex = 1
      OnShow = KalibrSheetShow
      object Splitter2: TSplitter
        Left = 0
        Top = 493
        Width = 1049
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 0
        ExplicitWidth = 496
      end
      object KalibrChart: TChart
        Left = 0
        Top = 0
        Width = 1049
        Height = 493
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        BottomAxis.Grid.Style = psDash
        BottomAxis.LabelsSeparation = 30
        LeftAxis.Grid.Color = 452984832
        LeftAxis.Grid.Style = psDash
        LeftAxis.Grid.Width = 0
        View3D = False
        OnAfterDraw = KalibrChartAfterDraw
        Align = alClient
        BevelOuter = bvNone
        Color = clWindow
        TabOrder = 0
        OnMouseDown = KalibrChartMouseDown
        DefaultCanvas = 'TGDIPlusCanvas'
        PrintMargins = (
          15
          5
          15
          5)
        ColorPaletteIndex = 13
        object KalibrPasSeries: TLineSeries
          SeriesColor = clBlue
          Title = 'KalibrData'
          Brush.BackColor = clDefault
          DrawStyle = dsCurve
          Pointer.HorizSize = 3
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.VertSize = 3
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object KalibrLaserSeries: TLineSeries
          SeriesColor = 33023
          Title = 'KalibrLaser'
          VertAxis = aRightAxis
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object KalibrPasOblSer: TLineSeries
          SeriesColor = clGreen
          Title = 'KalibrPasObl'
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object KalibrPasErrSer: TLineSeries
          SeriesColor = clRed
          Title = 'KalibrPasError'
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 496
        Width = 1049
        Height = 174
        Align = alBottom
        BevelKind = bkFlat
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          1045
          170)
        object KalibrShowPointsBox: TCheckBox
          Left = 8
          Top = 10
          Width = 97
          Height = 17
          Caption = 'Poka'#380' punkty'
          TabOrder = 0
          OnClick = KalibrShowPointsBoxClick
        end
        object KalibrDystPomBox: TCheckBox
          Left = 8
          Top = 56
          Width = 129
          Height = 17
          Caption = 'Dystans pomocniczy'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = KalibrDystPomBoxClick
        end
        object Grid0BottomBox: TCheckBox
          Left = 8
          Top = 79
          Width = 98
          Height = 17
          Caption = 'Siatka pionowa'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = Grid0BottomBoxClick
        end
        object Grid0LeftBox: TCheckBox
          Left = 8
          Top = 102
          Width = 82
          Height = 17
          Caption = 'Siatka lewa'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = Grid0LeftBoxClick
        end
        object Grid0RightBox: TCheckBox
          Left = 8
          Top = 125
          Width = 82
          Height = 17
          Caption = 'Siatka prawa'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = Grid0RightBoxClick
        end
        object KalibrLaserBox: TCheckBox
          Left = 8
          Top = 33
          Width = 129
          Height = 17
          Caption = 'Laser'
          Checked = True
          State = cbChecked
          TabOrder = 5
          OnClick = KalibrLaserBoxClick
        end
        object LiczABBtn: TButton
          Left = 544
          Top = 20
          Width = 66
          Height = 25
          Action = LiczABAct
          TabOrder = 6
        end
        object WspAEdit: TLabeledEdit
          Left = 441
          Top = 24
          Width = 80
          Height = 21
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'wsp A'
          TabOrder = 7
          Text = '1'
          OnKeyPress = WspAEditKeyPress
        end
        object WspBEdit: TLabeledEdit
          Left = 441
          Top = 64
          Width = 80
          Height = 21
          EditLabel.Width = 28
          EditLabel.Height = 13
          EditLabel.Caption = 'wsp B'
          TabOrder = 8
          Text = '0'
          OnKeyPress = WspAEditKeyPress
        end
        object AutoBBtn: TButton
          Left = 544
          Top = 56
          Width = 66
          Height = 25
          Action = AutoBAct
          TabOrder = 9
        end
        object Memo2: TMemo
          Left = 704
          Top = 4
          Width = 337
          Height = 165
          Anchors = [akLeft, akTop, akRight, akBottom]
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Lucida Console'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 10
        end
        object GroupBox1: TGroupBox
          Left = 127
          Top = 4
          Width = 122
          Height = 162
          Anchors = [akLeft, akTop, akBottom]
          Caption = 'Stabilne regiony'
          TabOrder = 11
          object StabRegTimeEdit: TLabeledEdit
            Left = 16
            Top = 31
            Width = 89
            Height = 21
            EditLabel.Width = 57
            EditLabel.Height = 13
            EditLabel.Caption = 'min.czas [s]'
            TabOrder = 0
            Text = '1,0'
            OnKeyPress = StabRegAmplEditKeyPress
          end
          object StabRegAmplEdit: TLabeledEdit
            Left = 16
            Top = 71
            Width = 89
            Height = 21
            EditLabel.Width = 74
            EditLabel.Height = 13
            EditLabel.Caption = 'max.Ampl [mm]'
            TabOrder = 1
            Text = '0,5'
            OnKeyPress = StabRegAmplEditKeyPress
          end
          object Button1: TButton
            Left = 16
            Top = 107
            Width = 89
            Height = 25
            Action = LiczStabReg
            TabOrder = 2
          end
          object ShowStabRegPcBox: TCheckBox
            Left = 16
            Top = 138
            Width = 105
            Height = 17
            Caption = 'Pokaz na wykresie'
            Checked = True
            State = cbChecked
            TabOrder = 3
            OnClick = Grid0RightBoxClick
          end
        end
        object ShowStabRegStmBox: TCheckBox
          Left = 8
          Top = 148
          Width = 113
          Height = 17
          Caption = 'Pokaz reg. z STM'
          Checked = True
          State = cbChecked
          TabOrder = 12
          OnClick = Grid0RightBoxClick
        end
        object showTranclChartBtn: TButton
          Left = 544
          Top = 93
          Width = 81
          Height = 25
          Action = showTranclChartAct
          TabOrder = 13
        end
        object KalibrShowPasOblBox: TCheckBox
          Left = 441
          Top = 109
          Width = 80
          Height = 17
          Caption = 'Poka'#380' Pas Obl'
          Checked = True
          State = cbChecked
          TabOrder = 14
          OnClick = KalibrShowPasOblBoxClick
        end
        object KalibrShowPasErrBox: TCheckBox
          Left = 441
          Top = 132
          Width = 80
          Height = 17
          Caption = 'Poka'#380' B'#322#261'd'
          Checked = True
          State = cbChecked
          TabOrder = 15
          OnClick = KalibrShowPasErrBoxClick
        end
        object ShowKalibrptGridBtn: TButton
          Left = 544
          Top = 130
          Width = 81
          Height = 25
          Action = ShowKalibrptGridAct
          TabOrder = 16
        end
        object GroupBox2: TGroupBox
          Left = 255
          Top = 4
          Width = 154
          Height = 162
          Caption = 'GroupBox2'
          TabOrder = 17
          object KalibrMaxLaserSrKwEdit: TLabeledEdit
            Left = 5
            Top = 31
            Width = 123
            Height = 21
            Hint = 
              'Max. b'#322#261'd '#346'rednio kwadraowy dla pomiar'#243'w laserem. Brany pod uwag' +
              #281' przed wyliczaniem prostej.'
            EditLabel.Width = 146
            EditLabel.Height = 13
            EditLabel.Caption = 'Max. b'#322#261'd '#346'rKw dla lasera [%]'
            TabOrder = 0
            Text = '1,0'
            OnKeyPress = StabRegAmplEditKeyPress
          end
          object KalibrMaxPointOdchylEdit: TLabeledEdit
            Left = 5
            Top = 71
            Width = 123
            Height = 21
            Hint = 'Maksymalna odchy'#322'ka punktu od wyznaczonej prostej.'
            EditLabel.Width = 145
            EditLabel.Height = 13
            EditLabel.Caption = 'Max. odchy'#322'ki od prostej [mm]'
            TabOrder = 1
            Text = '1,0'
            OnKeyPress = StabRegAmplEditKeyPress
          end
          object MinLaserDataEdit: TLabeledEdit
            Left = 3
            Top = 114
            Width = 54
            Height = 21
            Hint = 'Maksymalna odchy'#322'ka punktu od wyznaczonej prostej.'
            EditLabel.Width = 64
            EditLabel.Height = 13
            EditLabel.Caption = 'Min Laser[%]'
            TabOrder = 2
            Text = '5'
            OnKeyPress = StabRegAmplEditKeyPress
          end
          object MaxLaserDataEdit: TLabeledEdit
            Left = 76
            Top = 114
            Width = 54
            Height = 21
            Hint = 'Maksymalna odchy'#322'ka punktu od wyznaczonej prostej.'
            EditLabel.Width = 68
            EditLabel.Height = 13
            EditLabel.Caption = 'Max Laser[%]'
            TabOrder = 3
            Text = '95'
            OnKeyPress = StabRegAmplEditKeyPress
          end
        end
      end
    end
    object MeasSheet: TTabSheet
      Caption = 'Pomiar'
      ImageIndex = 2
      OnShow = MeasSheetShow
      object LedsPB: TPaintBox
        Left = 973
        Top = 0
        Width = 76
        Height = 566
        Align = alRight
        OnPaint = LedsPBPaint
        ExplicitLeft = 872
        ExplicitHeight = 659
      end
      object PomiarChart: TChart
        Left = 0
        Top = 0
        Width = 973
        Height = 566
        Legend.Alignment = laBottom
        Legend.LegendStyle = lsSeries
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        BottomAxis.Axis.Style = psDash
        LeftAxis.Grid.Color = clBlue
        LeftAxis.Grid.Style = psDash
        LeftAxis.Grid.SmallDots = True
        RightAxis.Axis.Style = psDash
        RightAxis.Grid.Color = clRed
        RightAxis.Grid.SmallDots = True
        View3D = False
        OnAfterDraw = PomiarChartAfterDraw
        Align = alClient
        Color = clWindow
        TabOrder = 0
        OnMouseDown = PomiarChartMouseDown
        OnMouseMove = PomiarChartMouseMove
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object PomiarSer1: TLineSeries
          SeriesColor = clBlue
          Title = 'Dystans'
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object PomiarSer2: TLineSeries
          SeriesColor = clRed
          Title = 'Dystans pomocniczy'
          VertAxis = aRightAxis
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 566
        Width = 1049
        Height = 104
        Align = alBottom
        BevelKind = bkFlat
        BevelOuter = bvNone
        TabOrder = 1
        object MeasDystPomBox: TCheckBox
          Left = 8
          Top = 10
          Width = 129
          Height = 17
          Caption = 'Dystans pomocniczy'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = MeasDystPomBoxClick
        end
        object GridLeftBox: TCheckBox
          Left = 143
          Top = 34
          Width = 82
          Height = 17
          Caption = 'Siatka lewa'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = GridLeftBoxClick
        end
        object GridRightBox: TCheckBox
          Left = 143
          Top = 57
          Width = 82
          Height = 17
          Caption = 'Siatka prawa'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = GridRightBoxClick
        end
        object PomMeasGrid: TStringGrid
          Left = 319
          Top = 4
          Width = 514
          Height = 93
          DefaultColWidth = 100
          DefaultRowHeight = 20
          RowCount = 4
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Lucida Console'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object GridBottomBox: TCheckBox
          Left = 143
          Top = 11
          Width = 82
          Height = 17
          Caption = 'Siatka pionowa'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = GridBottomBoxClick
        end
        object PaintOnMouseMove: TCheckBox
          Left = 8
          Top = 33
          Width = 129
          Height = 17
          Caption = 'Paint On MouseMove'
          TabOrder = 5
        end
        object PaintLedLineBox: TCheckBox
          Left = 8
          Top = 57
          Width = 129
          Height = 17
          Caption = 'Rysuj linie LED'
          TabOrder = 6
          OnClick = PaintLedLineBoxClick
        end
      end
    end
    object CfgStmSheet: TTabSheet
      Caption = 'Konfiguracja ster.'
      ImageIndex = 3
      OnShow = CfgStmSheetShow
      DesignSize = (
        1049
        670)
      object KalibrTabControl: TTabControl
        Left = 3
        Top = 3
        Width = 422
        Height = 193
        TabOrder = 0
        Tabs.Strings = (
          'Dystans'
          'Ci'#347'nienie'
          'Laser'
          'Rez.dystans')
        TabIndex = 0
        OnChange = KalibrTabControlChange
        object CalibrVLE: TValueListEditor
          Left = 4
          Top = 24
          Width = 414
          Height = 165
          Align = alClient
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Lucida Console'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goAlwaysShowEditor, goThumbTracking]
          ParentFont = False
          TabOrder = 0
          ColWidths = (
            263
            145)
        end
      end
      object StmVLE: TValueListEditor
        Left = 3
        Top = 202
        Width = 422
        Height = 459
        Anchors = [akLeft, akTop, akBottom]
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Lucida Console'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goAlwaysShowEditor, goThumbTracking]
        ParentFont = False
        TabOrder = 1
        ColWidths = (
          150
          266)
      end
    end
  end
  object HelpPanel: TPanel
    Left = 317
    Top = 160
    Width = 744
    Height = 409
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'HelpPanel'
    Color = clMoneyGreen
    Ctl3D = True
    DockSite = True
    DoubleBuffered = False
    DragKind = dkDock
    DragMode = dmAutomatic
    ParentBackground = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    TabOrder = 3
    Visible = False
    DesignSize = (
      744
      409)
    object Memo1: TMemo
      Left = 18
      Top = 35
      Width = 712
      Height = 361
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelKind = bkTile
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Lines.Strings = (
        'Kr'#243'tka opis:'
        
          '1. Program mo'#380'e otwiera'#263' pliki z rozszerzeniem *.onp i spakowane' +
          ' pliki *.zip'
        
          '2. Na Wykresach je'#347'li naci'#347'niemy klawisz CTRL i przycisk myszki ' +
          'zostanie ustawiony kursor odniesienia'
        '3. Mo'#380'na odrysowywa'#263' stany LED'#243'w od ruchu kursora myszki'
        '4. Mo'#380'liwy jest eksport danych z fazy pomiar do Excela'
        
          '5. Zak'#322'adka Pas-Laser pojawia si'#281' tylko gdy dane by'#322'y zebrane w ' +
          'trybie PAS+LASER'
        '6. Plansza kalibracji: oznaczanie punkt'#243'w kolorem'
        '  a) czarny - punkt poprawny'
        
          '  b) czerwony - punkt o zbyt du'#380'ej warto'#347'ci "Suma Srednio Kwadra' +
          'towa" dla pomiaru laserem'
        
          '  c) r'#243#380'owy - punkt odrzucony podczas wyznaczania parametr'#243'w pro' +
          'stej'
        '  d) niebieski - wydechy, kt'#243're by'#322'y przed pierwszym wdechem'
        '  e) zielony - laser poza zakresem')
      ParentFont = False
      TabOrder = 0
    end
    object HideHelpBtn: TButton
      Left = 703
      Top = 4
      Width = 31
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'X'
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Lucida Console'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = HideHelpBtnClick
    end
  end
  object ChartPanel: TPanel
    Left = 399
    Top = 90
    Width = 592
    Height = 349
    DragKind = dkDock
    DragMode = dmAutomatic
    TabOrder = 4
    Visible = False
    DesignSize = (
      592
      349)
    object PasLaserTransChart: TChart
      Left = 1
      Top = 41
      Width = 590
      Height = 307
      Legend.Visible = False
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Title.Caption = 'Laser[%]'
      LeftAxis.Title.Caption = 'Pas[mm]'
      View3D = False
      Align = alBottom
      TabOrder = 0
      Anchors = [akLeft, akTop, akRight, akBottom]
      DesignSize = (
        590
        307)
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object ShowPointlabelBox: TCheckBox
        Left = 24
        Top = 282
        Width = 145
        Height = 17
        Anchors = [akLeft, akBottom]
        Caption = 'Poka'#380' opis punkt'#243'w'
        TabOrder = 0
        OnClick = ShowPointlabelBoxClick
      end
      object PasLaserAvrSeries: TPointSeries
        ClickableLine = False
        Pointer.InflateMargins = True
        Pointer.Pen.Visible = False
        Pointer.Style = psCircle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object PasLaserLineSeries: TLineSeries
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object HideChartPanel: TButton
      Left = 551
      Top = 10
      Width = 31
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'X'
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Lucida Console'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = HideChartPanelClick
    end
  end
  object GridPanel: TPanel
    Left = 377
    Top = 390
    Width = 729
    Height = 234
    DragKind = dkDock
    DragMode = dmAutomatic
    TabOrder = 5
    Visible = False
    DesignSize = (
      729
      234)
    object HideKalibrGridBtn: TButton
      Left = 690
      Top = 10
      Width = 31
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'X'
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Lucida Console'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = HideKalibrGridBtnClick
    end
    object KalibrGrid: TStringGrid
      Left = 1
      Top = 41
      Width = 727
      Height = 192
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColCount = 7
      DefaultColWidth = 30
      DefaultDrawing = False
      RowCount = 7
      TabOrder = 1
      OnDrawCell = KalibrGridDrawCell
      ColWidths = (
        30
        110
        110
        110
        110
        110
        110)
    end
    object MaxErrorTxt: TStaticText
      Left = 16
      Top = 10
      Width = 28
      Height = 17
      Caption = '...'
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Lucida Console'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object ImageList1: TImageList
    Left = 48
    Top = 656
    Bitmap = {
      494C010106002C00D00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      00000000000000000000000000000000000000000000000000000000000000FF
      00000000000000000000000000000000000000000000000000000000000000FF
      00000000000000000000000000000000000000000000000000000000000000FF
      00000000000000000000000000000000000000000000000000000000000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      00000000000000000000000000000000000000000000000000000000000000FF
      000000FF0000000000008000000080000000000000000000000000FF000000FF
      00000000000000000000000000000000000000000000000000000000000000FF
      000000FF00000000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000080000000800000000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000080000000000000000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      00008080800000000000000000000000000000000000808080000000000000FF
      000000FF0000800000000000000000000000000000000000000000FF000000FF
      00008080800000000000000000000000000000000000808080000000000000FF
      000000FF00008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      00000000000000000000000000000000000000000000000000000000000000FF
      00008000000000000000000000000000000000000000000000000000000000FF
      00000000000000000000000000000000000000000000000000000000000000FF
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      800000000000000000000000000000000000FFFF000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000008080
      800000000000000000000000000000000000FFFF000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00000000000000000000000000000000000000000000FFFF0000000000000000
      0000808080000000000000000000000000000000000080808000000000000000
      00000000000000000000000000000000000000000000FFFF0000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008080800000000000FFFF
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000080808000000000000000000000000000000000008080800000000000FFFF
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFF0000FFFFFF00FFFF0000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFF0000FFFFFF00FFFF0000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      00000000000000000000000000000000000000000000000000000000000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF00000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      0000000000000000000000000000000000000000000000000000FF00000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF00000000000000FFFFFF0000000000FF0000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000000000000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000FFFFFF0000000000FFFFFF0000000000FF00
      0000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000000000000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000000000000000000000000000FFFF00000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      800000000000000000000000000000000000000000000000000000000000FF00
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000FF0000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      000000000000008080000000000000000000000000000000000000FF000000FF
      000000000000000000000000000000000000FF000000000000000000000000FF
      000000FF0000FF000000000000000000000000000000FFFFFF0000FFFF000000
      0000008080000080800000808000008080000080800000808000008080000080
      80000080800000000000000000000000000000000000FF000000FF0000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0000000000FF00000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000808000000000000000000000000000000000000000000000FF
      000000000000000000000000000000000000FF000000000000000000000000FF
      000000000000FF00000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000080800000808000008080000080800000808000008080000080
      800000808000008080000000000000000000FF0000000000000000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF0000000000FF000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000008080000080800000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      000000000000FF000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000FF0000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000008080000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000808000000000000000000000000000FF000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000808000000000000000000000000000FF000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000808000000000000000000000000000FF000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000000000000000000000000000FF0000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      000000000000FF0000000000000000000000FF0000000000000000000000FF00
      00000000000000000000FF000000000000000000000000000000FF0000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      000000000000FF000000000000000000000000000000FF000000FF0000000000
      00000000000000000000FF00000000000000000000000000000000000000FF00
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000000000000000000000000000FF000000FF0000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF00000000000000FF0000000000000000000000FF00
      000000000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00EFEFEFEF00000000CFE4CFE400000000
      80008000000000008001800100000000C023C02300000000E787E78700000000
      CF4FCF4F000000009CA79FA700000000BCD7BFD700000000B037B03700000000
      A037A03700000000ACF7AFF70000000084E787E700000000C1CFC1CF00000000
      E79FE79F00000000F03FF03F00000000FFFFFFFFFFFFEFEDFFFFFE3FC001CFC7
      001FF81F80310001000FF40F803180030007E00780314F61000380038001EF6B
      0001400180017F790000000080010000001F00008FF13EFD001F80018FF13EFD
      001FC0038FF13EFD8FF1E00F8FF15DFDFFF9F07F8B615DFDFF75F8FF8B956BFD
      FF8FFFFF800177FDFFFFFFFFF1687FFD00000000000000000000000000000000
      000000000000}
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 120
    Top = 656
    object actOpen: TAction
      Caption = 'actOpen'
      Hint = 'Otw'#243'rz dane'
      ImageIndex = 0
      OnExecute = actOpenExecute
    end
    object actShowHelp: TAction
      Caption = 'actShowHelp'
      Hint = 'Poka'#380'/ukryj okienko z pomoc'#261
      ImageIndex = 1
      OnExecute = actShowHelpExecute
    end
    object actSaveCsv: TAction
      Caption = 'actSaveCsv'
      Hint = 'Zapisz dane do pliku csv (Excel)'
      ImageIndex = 2
      OnExecute = actSaveCsvExecute
      OnUpdate = actSaveCsvUpdate
    end
    object actUndoZoom: TAction
      Caption = 'actUndoZoom'
      Hint = 'Poka'#380' ca'#322'y przebieg'
      ImageIndex = 3
      OnExecute = actUndoZoomExecute
      OnUpdate = actZoomInTimeUpdate
    end
    object actZoomInTime: TAction
      Caption = 'actZoomTime'
      Hint = 'Rozci'#261'gnij czas'
      ImageIndex = 4
      OnExecute = actZoomInTimeExecute
      OnUpdate = actZoomInTimeUpdate
    end
    object actZoomOutTime: TAction
      Caption = 'actZoomOutTime'
      Hint = 'Zacie'#347'nij czas'
      ImageIndex = 5
      OnExecute = actZoomOutTimeExecute
      OnUpdate = actZoomInTimeUpdate
    end
    object BuildTransTableAct: TAction
      Caption = 'Buduj z KonfigData'
      OnUpdate = BuildTransTableActUpdate
    end
    object LiczABAct: TAction
      Caption = 'Licz AB'
      OnExecute = LiczABActExecute
    end
    object AutoBAct: TAction
      Caption = 'Licz B'
      OnExecute = AutoBActExecute
      OnUpdate = BuildTransTableActUpdate
    end
    object LiczStabReg: TAction
      Caption = 'Licz Stab.Reg.'
      OnExecute = LiczStabRegExecute
      OnUpdate = LiczStabRegUpdate
    end
    object showTranclChartAct: TAction
      Caption = 'Poka'#380' wykres'
      OnExecute = showTranclChartActExecute
      OnUpdate = showTranclChartActUpdate
    end
    object ShowKalibrptGridAct: TAction
      Caption = 'Poka'#380' tabelk'#281
      OnExecute = ShowKalibrptGridActExecute
      OnUpdate = ShowKalibrptGridActUpdate
    end
  end
end
