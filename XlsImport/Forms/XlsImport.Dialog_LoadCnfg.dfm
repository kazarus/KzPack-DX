object DialogLoadCnfg: TDialogLoadCnfg
  Left = 270
  Top = 256
  Caption = 'DialogLoadCnfg'
  ClientHeight = 243
  ClientWidth = 404
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Labl_1: TRzLabel
    Left = 20
    Top = 20
    Width = 39
    Height = 13
    Caption = #26631#39064#34892
  end
  object Labl_2: TRzLabel
    Left = 20
    Top = 45
    Width = 39
    Height = 13
    Caption = #36215#22987#34892
  end
  object Labl_3: TRzLabel
    Left = 7
    Top = 70
    Width = 52
    Height = 13
    Caption = #25991#20214#36335#24452
  end
  object Labl_4: TRzLabel
    Left = 7
    Top = 95
    Width = 52
    Height = 13
    Caption = #23548#20837#26399#38388
  end
  object Edit_RowTitle: TRzButtonEdit
    Left = 63
    Top = 16
    Width = 320
    Height = 21
    Text = '5'
    Alignment = taCenter
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 0
    AltBtnWidth = 15
    ButtonWidth = 15
  end
  object Edit_RowStart: TRzButtonEdit
    Left = 63
    Top = 41
    Width = 320
    Height = 21
    Text = '6'
    Alignment = taCenter
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 1
    AltBtnWidth = 15
    ButtonWidth = 15
  end
  object Edit_FilePath: TRzButtonEdit
    Left = 63
    Top = 66
    Width = 320
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 2
    AltBtnWidth = 15
    ButtonWidth = 15
    OnButtonClick = Edit_FilePathButtonClick
  end
  object Btnv_Mrok: TButton
    Left = 225
    Top = 207
    Width = 75
    Height = 25
    Caption = 'Btnv_Mrok'
    TabOrder = 3
    OnClick = Btnv_MrokClick
  end
  object Btnv_Quit: TButton
    Left = 300
    Top = 207
    Width = 75
    Height = 25
    Caption = 'Btnv_1'
    TabOrder = 4
    OnClick = Btnv_QuitClick
  end
  object Comb_KJQJ: TRzComboBox
    Left = 63
    Top = 91
    Width = 321
    Height = 21
    Ctl3D = False
    FrameVisible = True
    FramingPreference = fpCustomFraming
    ParentCtl3D = False
    TabOrder = 5
  end
end