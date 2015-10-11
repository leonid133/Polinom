object Form1: TForm1
  Left = 284
  Top = 150
  Width = 546
  Height = 559
  AlphaBlendValue = 230
  Caption = #1040#1087#1088#1086#1082#1089#1080#1084#1072#1094#1080#1103' '#1092#1091#1085#1082#1094#1080#1080' '#1087#1086#1083#1080#1085#1086#1084#1086#1084' '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnResize = FormResize
  PixelsPerInch = 120
  TextHeight = 16
  object Image1: TImage
    Left = 10
    Top = 329
    Width = 890
    Height = 461
  end
  object Bevel2: TBevel
    Left = 5
    Top = 160
    Width = 890
    Height = 11
    Shape = bsTopLine
  end
  object Bevel4: TBevel
    Left = 4
    Top = 313
    Width = 890
    Height = 11
    Shape = bsTopLine
  end
  object Button1: TButton
    Left = 140
    Top = 183
    Width = 90
    Height = 30
    Hint = #1040#1087#1088#1086#1082#1089#1080#1084#1072#1094#1080#1103' '#1074#1074#1077#1076#1077#1085#1085#1099#1093' '#1076#1072#1085#1085#1099#1093' '#1087#1086#1083#1080#1085#1086#1084#1086#1084
    Caption = #1056#1072#1089#1095#1077#1090
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = Button1Click
  end
  object LabeledEdit1: TLabeledEdit
    Left = 10
    Top = 182
    Width = 90
    Height = 32
    Hint = #1057#1090#1077#1087#1077#1085#1100' '#1072#1087#1088#1086#1082#1089#1080#1084#1080#1088#1091#1102#1097#1077#1075#1086' '#1087#1086#1083#1080#1085#1086#1084#1072
    EditLabel.Width = 98
    EditLabel.Height = 19
    EditLabel.Caption = 'LabeledEdit1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    LabelPosition = lpAbove
    LabelSpacing = 3
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = '0'
    OnChange = LabeledEdit1Change
    OnKeyPress = LabeledEdit2KeyPress
  end
  object LabeledEdit2: TLabeledEdit
    Left = 10
    Top = 15
    Width = 90
    Height = 32
    Hint = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1090#1086#1095#1077#1082' '#1076#1072#1085#1085#1099#1093
    EditLabel.Width = 98
    EditLabel.Height = 20
    EditLabel.Caption = 'LabeledEdit2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    LabelPosition = lpAbove
    LabelSpacing = 3
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = '2'
    OnChange = LabeledEdit2Change
    OnKeyPress = LabeledEdit2KeyPress
  end
  object SG_data: TStringGrid
    Left = 10
    Top = 50
    Width = 191
    Height = 87
    ColCount = 2
    DefaultColWidth = 55
    DefaultRowHeight = 25
    RowCount = 3
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ScrollBars = ssHorizontal
    TabOrder = 1
    OnKeyPress = SG_dataKeyPress
    OnKeyUp = SG_dataKeyUp
    OnSelectCell = SG_dataSelectCell
  end
  object SG_koef: TStringGrid
    Left = 10
    Top = 220
    Width = 199
    Height = 58
    ColCount = 1
    DefaultColWidth = 55
    DefaultRowHeight = 25
    FixedCols = 0
    RowCount = 2
    ScrollBars = ssHorizontal
    TabOrder = 8
    OnKeyPress = SG_koefKeyPress
    OnSelectCell = SG_koefSelectCell
  end
  object Button2: TButton
    Left = 140
    Top = 15
    Width = 90
    Height = 31
    Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1080#1079' '#1092#1072#1081#1083#1072
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 240
    Top = 15
    Width = 90
    Height = 31
    Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' '#1092#1072#1081#1083
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 560
    Top = 15
    Width = 41
    Height = 31
    Caption = '?'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGreen
    Font.Height = -18
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = Button4Click
  end
  object ButtonDelColl: TButton
    Left = 450
    Top = 15
    Width = 90
    Height = 31
    Caption = #1059#1076#1072#1083#1080#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = ButtonDelCollClick
  end
  object Button5: TButton
    Left = 340
    Top = 16
    Width = 90
    Height = 30
    Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
    Caption = #1069#1082#1089#1087#1086#1088#1090
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = Button5Click
  end
  object SaveDialog1: TSaveDialog
    Left = 877
    Top = 6
  end
  object OpenDialog1: TOpenDialog
    Left = 883
    Top = 46
  end
end
