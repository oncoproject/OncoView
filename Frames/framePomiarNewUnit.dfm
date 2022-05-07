inherited PomiarNewSheetFrame: TPomiarNewSheetFrame
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
  object Panel2: TPanel
    Left = 0
    Top = 637
    Width = 947
    Height = 104
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
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
      TabOrder = 0
    end
    object PaintOnMouseMove: TCheckBox
      Left = 8
      Top = 9
      Width = 129
      Height = 17
      Caption = 'Paint On MouseMove'
      TabOrder = 1
    end
    object PaintLedLineBox: TCheckBox
      Left = 8
      Top = 33
      Width = 129
      Height = 17
      Caption = 'Rysuj linie LED'
      TabOrder = 2
    end
  end
end
