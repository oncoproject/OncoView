object OsSwitchFrame: TOsSwitchFrame
  Left = 0
  Top = 0
  Width = 140
  Height = 232
  Padding.Top = 2
  Padding.Right = 2
  Padding.Bottom = 2
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 2
    Width = 138
    Height = 228
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitHeight = 191
    object OsLabel: TLabel
      Left = 16
      Top = 14
      Width = 50
      Height = 16
      Caption = 'O'#347' lewa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object OffButton: TRadioButton
      Left = 16
      Top = 36
      Width = 81
      Height = 17
      Caption = 'OFF'
      TabOrder = 0
      OnClick = OffButtonClick
    end
    object PasButton: TRadioButton
      Left = 16
      Top = 59
      Width = 81
      Height = 17
      Caption = 'Pas'
      TabOrder = 1
      OnClick = OffButtonClick
    end
    object LaserButton: TRadioButton
      Left = 16
      Top = 79
      Width = 81
      Height = 17
      Caption = 'Laser'
      TabOrder = 2
      OnClick = OffButtonClick
    end
    object AddPasOblBox: TCheckBox
      Left = 16
      Top = 152
      Width = 97
      Height = 17
      Caption = 'Dodaj Pas Obl.'
      TabOrder = 3
      OnClick = OffButtonClick
    end
    object AddErrorBox: TCheckBox
      Left = 16
      Top = 175
      Width = 97
      Height = 17
      Caption = 'Dodaj b'#322#261'd'
      TabOrder = 4
      OnClick = OffButtonClick
    end
    object LaserPomocButton: TRadioButton
      Left = 16
      Top = 125
      Width = 97
      Height = 17
      Caption = 'OFF'
      TabOrder = 5
      OnClick = LaserPomocButtonClick
    end
    object LaserPomocBtn: TRadioButton
      Left = 16
      Top = 102
      Width = 81
      Height = 17
      Caption = 'Laser pomocn.'
      TabOrder = 6
      OnClick = OffButtonClick
    end
  end
end
