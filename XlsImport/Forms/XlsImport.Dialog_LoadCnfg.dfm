object DialogLoadCnfg: TDialogLoadCnfg
  Left = 270
  Top = 256
  Caption = 'DialogLoadCnfg'
  ClientHeight = 192
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
    Left = 18
    Top = 74
    Width = 46
    Height = 13
    Caption = #26631#39064#34892':'
  end
  object Labl_2: TRzLabel
    Left = 18
    Top = 99
    Width = 46
    Height = 13
    Caption = #36215#22987#34892':'
  end
  object Labl_3: TRzLabel
    Left = 5
    Top = 24
    Width = 59
    Height = 13
    Caption = #25991#20214#36335#24452':'
  end
  object Labl_4: TRzLabel
    Left = 5
    Top = 124
    Width = 59
    Height = 13
    Caption = #23548#20837#26399#38388':'
    Visible = False
  end
  object Labl_5: TRzLabel
    Left = 18
    Top = 49
    Width = 46
    Height = 13
    Caption = #26631#31614#39029':'
  end
  object Edit_RowTitle: TRzButtonEdit
    Left = 68
    Top = 70
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
    Left = 68
    Top = 95
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
    Left = 70
    Top = 20
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
    Left = 238
    Top = 159
    Width = 75
    Height = 25
    Caption = 'Btnv_Mrok'
    TabOrder = 3
    OnClick = Btnv_MrokClick
  end
  object Btnv_Quit: TButton
    Left = 313
    Top = 159
    Width = 75
    Height = 25
    Caption = 'Btnv_1'
    TabOrder = 4
    OnClick = Btnv_QuitClick
  end
  object Comb_KJQJ: TRzComboBox
    Left = 68
    Top = 120
    Width = 320
    Height = 21
    Ctl3D = False
    FrameVisible = True
    FramingPreference = fpCustomFraming
    ParentCtl3D = False
    TabOrder = 5
    Visible = False
  end
  object Comb_RealPage: TRzComboBox
    Left = 68
    Top = 45
    Width = 320
    Height = 21
    Ctl3D = False
    FrameVisible = True
    FramingPreference = fpCustomFraming
    ParentCtl3D = False
    TabOrder = 6
  end
  object Chkb_FileHead: TRzCheckBox
    Left = 18
    Top = 149
    Width = 110
    Height = 15
    Caption = #25353#26639#30446#24207#21495#21305#37197
    State = cbUnchecked
    TabOrder = 7
  end
  object XLSReadWriteII51: TXLSReadWriteII5
    ComponentVersion = '5.20.62'
    Version = xvExcel2007
    DirectRead = False
    DirectWrite = False
    Left = 88
    Top = 152
  end
end
