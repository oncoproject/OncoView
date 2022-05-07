inherited KalibrSheetFrame: TKalibrSheetFrame
  Width = 966
  Height = 713
  ParentFont = False
  ExplicitWidth = 966
  ExplicitHeight = 713
  object Splitter2: TSplitter
    Left = 0
    Top = 536
    Width = 966
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 0
    ExplicitWidth = 496
  end
  object mChart: TChart
    Left = 123
    Top = 0
    Width = 843
    Height = 536
    Legend.Alignment = laBottom
    Legend.LegendStyle = lsSeries
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Grid.Style = psDash
    BottomAxis.LabelsSeparation = 30
    LeftAxis.Grid.Color = 452984832
    LeftAxis.Grid.Style = psDash
    LeftAxis.Grid.Width = 0
    View3D = False
    OnAfterDraw = mChartAfterDraw
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    TabOrder = 0
    OnMouseDown = mChartMouseDown
    DesignSize = (
      843
      536)
    DefaultCanvas = 'TGDIPlusCanvas'
    PrintMargins = (
      15
      5
      15
      5)
    ColorPaletteIndex = 13
    object LeftAxisUpBtn: TButton
      Left = 6
      Top = 6
      Width = 20
      Height = 20
      Caption = '^'
      TabOrder = 0
      OnClick = LeftAxisUpBtnClick
    end
    object LeftAxisDnBtn: TButton
      Left = 31
      Top = 6
      Width = 20
      Height = 20
      Caption = 'v'
      TabOrder = 1
      OnClick = LeftAxisDnBtnClick
    end
    object RightAxisDnBtn: TButton
      Left = 782
      Top = 6
      Width = 20
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'v'
      TabOrder = 2
      OnClick = RightAxisDnBtnClick
    end
    object RightAxisUpBtn: TButton
      Left = 808
      Top = 6
      Width = 20
      Height = 20
      Anchors = [akTop, akRight]
      Caption = '^'
      TabOrder = 3
      OnClick = RightAxisUpBtnClick
    end
    object LeftAxisZeroBtn: TButton
      Left = 57
      Top = 6
      Width = 20
      Height = 20
      Caption = 'x'
      TabOrder = 4
      OnClick = LeftAxisZeroBtnClick
    end
    object RightAxisZeroBtn: TButton
      Left = 756
      Top = 6
      Width = 20
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'x'
      TabOrder = 5
      OnClick = RightAxisZeroBtnClick
    end
    object PasSeries: TLineSeries
      SeriesColor = clBlue
      Title = 'Pas'
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
    object LaserSeries: TLineSeries
      SeriesColor = 33023
      Title = 'Laser'
      VertAxis = aRightAxis
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object LaserPomocSeries: TLineSeries
      Title = 'LaserPomoc'
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object PasOblSeries: TLineSeries
      SeriesColor = clGreen
      Title = 'PasObl'
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object PasErrSeries: TLineSeries
      SeriesColor = clRed
      Title = 'PasError'
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
    Top = 539
    Width = 966
    Height = 174
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      962
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
    object Grid0BottomBox: TCheckBox
      Left = 8
      Top = 33
      Width = 98
      Height = 17
      Caption = 'Siatka pionowa'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = Grid0BottomBoxClick
    end
    object Grid0LeftBox: TCheckBox
      Left = 8
      Top = 56
      Width = 82
      Height = 17
      Caption = 'Siatka lewa'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = Grid0LeftBoxClick
    end
    object Grid0RightBox: TCheckBox
      Left = 8
      Top = 79
      Width = 82
      Height = 17
      Caption = 'Siatka prawa'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = Grid0RightBoxClick
    end
    object LiczABBtn: TButton
      Left = 544
      Top = 20
      Width = 66
      Height = 25
      Caption = 'Licz AB'
      TabOrder = 4
    end
    object WspAEdit: TLabeledEdit
      Left = 441
      Top = 24
      Width = 80
      Height = 21
      EditLabel.Width = 29
      EditLabel.Height = 13
      EditLabel.Caption = 'wsp A'
      TabOrder = 5
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
      TabOrder = 6
      Text = '0'
    end
    object AutoBBtn: TButton
      Left = 544
      Top = 56
      Width = 66
      Height = 25
      Caption = 'Licz B'
      TabOrder = 7
    end
    object Memo2: TMemo
      Left = 704
      Top = 4
      Width = 646
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
      TabOrder = 8
    end
    object GroupBox1: TGroupBox
      Left = 127
      Top = 4
      Width = 122
      Height = 162
      Anchors = [akLeft, akTop, akBottom]
      Caption = 'Stabilne regiony'
      TabOrder = 9
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
      end
      object Button1: TButton
        Left = 16
        Top = 107
        Width = 89
        Height = 25
        Action = LiczStabReg
        TabOrder = 2
        OnKeyPress = Button1KeyPress
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
        OnClick = ShowStabRegPcBoxClick
      end
    end
    object ShowStabRegStmBox: TCheckBox
      Left = 8
      Top = 102
      Width = 113
      Height = 17
      Caption = 'Pokaz reg. z STM'
      Checked = True
      State = cbChecked
      TabOrder = 10
    end
    object showTranclChartBtn: TButton
      Left = 544
      Top = 93
      Width = 81
      Height = 25
      Action = showTranslChartAct
      TabOrder = 11
    end
    object ShowKalibrptGridBtn: TButton
      Left = 544
      Top = 130
      Width = 81
      Height = 25
      Caption = 'Poka'#380' tabelk'#281
      TabOrder = 12
      OnClick = ShowKalibrptGridBtnClick
    end
    object GroupBox2: TGroupBox
      Left = 255
      Top = 4
      Width = 154
      Height = 162
      Caption = 'GroupBox2'
      TabOrder = 13
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
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 123
    Height = 536
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel4'
    ShowCaption = False
    TabOrder = 2
    inline OsRightSwitchFrame: TOsSwitchFrame
      Left = 0
      Top = 201
      Width = 123
      Height = 200
      Align = alTop
      Padding.Top = 2
      Padding.Right = 2
      Padding.Bottom = 2
      TabOrder = 0
      ExplicitTop = 201
      ExplicitWidth = 123
      ExplicitHeight = 200
      inherited Panel1: TPanel
        Width = 121
        Height = 196
        ExplicitWidth = 121
        ExplicitHeight = 196
      end
    end
    inline OsLeftSwitchFrame: TOsSwitchFrame
      Left = 0
      Top = 0
      Width = 123
      Height = 201
      Align = alTop
      Padding.Top = 2
      Padding.Right = 2
      Padding.Bottom = 2
      TabOrder = 1
      ExplicitWidth = 123
      ExplicitHeight = 201
      inherited Panel1: TPanel
        Width = 121
        Height = 197
        ExplicitWidth = 121
        ExplicitHeight = 197
      end
    end
  end
  object ChartPanel: TPanel
    Left = 230
    Top = 48
    Width = 592
    Height = 349
    DragKind = dkDock
    DragMode = dmAutomatic
    TabOrder = 3
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
      Title.Visible = False
      BottomAxis.LabelStyle = talValue
      BottomAxis.Title.Caption = 'Laser[%]'
      LeftAxis.Title.Caption = 'Pas[mm]'
      View3D = False
      OnAfterDraw = PasLaserTransChartAfterDraw
      Align = alBottom
      TabOrder = 0
      Anchors = [akLeft, akTop, akRight, akBottom]
      ExplicitLeft = 0
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
        XValues.Order = loNone
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object PasLaserLineSeries: TLineSeries
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loNone
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
    Left = 180
    Top = 423
    Width = 729
    Height = 242
    DragKind = dkDock
    DragMode = dmAutomatic
    TabOrder = 4
    Visible = False
    DesignSize = (
      729
      242)
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
    object MaxErrorTxt: TStaticText
      Left = 16
      Top = 10
      Width = 28
      Height = 17
      BevelInner = bvNone
      BevelOuter = bvNone
      Caption = '...'
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Lucida Console'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object KalibrGrid: TStringGrid
      Left = 1
      Top = 41
      Width = 727
      Height = 200
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = clInfoBk
      ColCount = 7
      DefaultColWidth = 30
      DefaultDrawing = False
      DoubleBuffered = False
      RowCount = 7
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 2
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
  end
  object ActionList1: TActionList
    Left = 843
    Top = 104
    object showTranslChartAct: TAction
      Caption = 'Poka'#380' wykres'
      OnExecute = showTranslChartActExecute
      OnUpdate = showTranslChartActUpdate
    end
    object LiczABAct: TAction
      Caption = 'Licz AB'
      OnExecute = LiczABActExecute
    end
    object LiczStabReg: TAction
      Caption = 'Licz Stab.Reg.'
      OnExecute = LiczStabRegExecute
      OnUpdate = LiczStabRegUpdate
    end
    object BuildTransTableAct: TAction
      Caption = 'Buduj z KonfigData'
      OnUpdate = BuildTransTableActUpdate
    end
    object AutoBAct: TAction
      Caption = 'Licz B'
      OnExecute = AutoBActExecute
    end
  end
end
