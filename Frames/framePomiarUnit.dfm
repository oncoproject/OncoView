inherited PomiarSheetFrame: TPomiarSheetFrame
  Width = 947
  Height = 741
  ExplicitWidth = 947
  ExplicitHeight = 741
  object LedsPB: TPaintBox
    Left = 871
    Top = 0
    Width = 76
    Height = 637
    Align = alRight
    OnPaint = LedsPBPaint
    ExplicitLeft = 872
    ExplicitHeight = 659
  end
  object mChart: TChart
    Left = 0
    Top = 0
    Width = 871
    Height = 637
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
    OnAfterDraw = mChartAfterDraw
    Align = alClient
    Color = clWindow
    TabOrder = 0
    OnMouseDown = mChartMouseDown
    OnMouseMove = mChartMouseMove
    DesignSize = (
      871
      637)
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object ZmRightAxisBox: TCheckBox
      Left = 800
      Top = 0
      Width = 49
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Zm'
      TabOrder = 0
      OnClick = ZmRightAxisBoxClick
    end
    object PasSeries: TLineSeries
      SeriesColor = clBlue
      Title = 'Pas'
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object LaserSeries: TLineSeries
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
      SeriesColor = clRed
      Title = 'Laser pomoc.'
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
    Top = 637
    Width = 947
    Height = 104
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
    object LaserPomocBox: TCheckBox
      Left = 8
      Top = 34
      Width = 129
      Height = 17
      Caption = 'Laser pomocniczy'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = LaserPomocBoxClick
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
      Top = 57
      Width = 129
      Height = 17
      Caption = 'Paint On MouseMove'
      TabOrder = 5
    end
    object PaintLedLineBox: TCheckBox
      Left = 8
      Top = 81
      Width = 129
      Height = 17
      Caption = 'Rysuj linie LED'
      TabOrder = 6
      OnClick = PaintLedLineBoxClick
    end
    object LaserBox: TCheckBox
      Left = 8
      Top = 11
      Width = 129
      Height = 17
      Caption = 'Laser'
      Checked = True
      State = cbChecked
      TabOrder = 7
      OnClick = LaserBoxClick
    end
  end
end
