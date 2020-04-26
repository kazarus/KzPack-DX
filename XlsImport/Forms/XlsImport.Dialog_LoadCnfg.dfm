object DialogLoadCnfg: TDialogLoadCnfg
  Left = 270
  Top = 256
  Caption = 'DialogLoadCnfg'
  ClientHeight = 200
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 17
  object Labl_1: TRzLabel
    Left = 24
    Top = 86
    Width = 39
    Height = 17
    Caption = #26631#39064#34892':'
  end
  object Labl_2: TRzLabel
    Left = 24
    Top = 115
    Width = 39
    Height = 17
    Caption = #36215#22987#34892':'
  end
  object Labl_3: TRzLabel
    Left = 24
    Top = 28
    Width = 51
    Height = 17
    Caption = #25991#20214#36335#24452':'
  end
  object Labl_4: TRzLabel
    Left = 24
    Top = 144
    Width = 51
    Height = 17
    Caption = #23548#20837#26399#38388':'
    Visible = False
  end
  object Labl_5: TRzLabel
    Left = 24
    Top = 57
    Width = 39
    Height = 17
    Caption = #26631#31614#39029':'
  end
  object Edit_RowTitle: TRzButtonEdit
    Left = 87
    Top = 82
    Width = 360
    Height = 25
    Text = '5'
    Alignment = taCenter
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 0
    AltBtnWidth = 15
    ButtonWidth = 15
  end
  object Edit_RowStart: TRzButtonEdit
    Left = 87
    Top = 111
    Width = 360
    Height = 25
    Text = '6'
    Alignment = taCenter
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 1
    AltBtnWidth = 15
    ButtonWidth = 15
  end
  object Edit_FilePath: TRzButtonEdit
    Left = 87
    Top = 24
    Width = 360
    Height = 25
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 2
    AltBtnWidth = 15
    ButtonWidth = 15
    OnButtonClick = Edit_FilePathButtonClick
  end
  object Btnv_Mrok: TButton
    Left = 297
    Top = 170
    Width = 75
    Height = 25
    Caption = 'Btnv_Mrok'
    TabOrder = 3
    OnClick = Btnv_MrokClick
  end
  object Btnv_Quit: TButton
    Left = 372
    Top = 170
    Width = 75
    Height = 25
    Caption = 'Btnv_1'
    TabOrder = 4
    OnClick = Btnv_QuitClick
  end
  object Comb_KJQJ: TRzComboBox
    Left = 87
    Top = 140
    Width = 360
    Height = 25
    Ctl3D = False
    FrameVisible = True
    FramingPreference = fpCustomFraming
    ParentCtl3D = False
    TabOrder = 5
    Visible = False
  end
  object Comb_RealPage: TRzComboBox
    Left = 87
    Top = 53
    Width = 360
    Height = 25
    Ctl3D = False
    FrameVisible = True
    FramingPreference = fpCustomFraming
    ParentCtl3D = False
    TabOrder = 6
  end
  object Chkb_FileHead: TRzCheckBox
    Left = 24
    Top = 173
    Width = 103
    Height = 19
    Caption = #25353#26639#30446#24207#21495#21305#37197
    State = cbUnchecked
    TabOrder = 7
  end
  object XLSReadWriteII51: TXLSReadWriteII5
    ComponentVersion = '5.20.62'
    Version = xvExcel2007
    DirectRead = False
    DirectWrite = False
    Left = 160
    Top = 176
  end
end
