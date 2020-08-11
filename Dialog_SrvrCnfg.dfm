object DialogSrvrCnfg4CORE: TDialogSrvrCnfg4CORE
  Left = 0
  Top = 0
  Caption = 'DialogSrvrCnfg4CORE'
  ClientHeight = 181
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
    Left = 20
    Top = 28
    Width = 51
    Height = 17
    Caption = #26381#21153#22320#22336':'
    ParentColor = False
  end
  object Labl_2: TRzLabel
    Left = 20
    Top = 57
    Width = 51
    Height = 17
    Caption = #26381#21153#31471#21475':'
  end
  object Labl_3: TRzLabel
    Left = 20
    Top = 86
    Width = 51
    Height = 17
    Caption = #26381#21153#26631#35782':'
  end
  object Edit_SrvrPort: TRzButtonEdit
    Left = 83
    Top = 53
    Width = 360
    Height = 25
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 0
    AltBtnWidth = 15
    ButtonWidth = 15
  end
  object Edit_SrvrAddr: TRzButtonEdit
    Left = 83
    Top = 24
    Width = 360
    Height = 25
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 1
    AltBtnWidth = 15
    ButtonWidth = 15
  end
  object Btnx_Mrok: TRzButton
    Left = 293
    Top = 143
    Caption = 'Btnx_Mrok'
    TabOrder = 2
    OnClick = Btnx_MrokClick
  end
  object Btnx_Quit: TRzButton
    Left = 368
    Top = 143
    Caption = 'Btnx_1'
    TabOrder = 3
    OnClick = Btnx_QuitClick
  end
  object Edit_SrvrMemo: TRzButtonEdit
    Left = 83
    Top = 82
    Width = 360
    Height = 25
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 4
    AltBtnWidth = 15
    ButtonWidth = 15
  end
  object Chkb_InUseZIP: TRzCheckBox
    Left = 20
    Top = 131
    Width = 69
    Height = 19
    AlignmentVertical = avCenter
    Caption = 'inUseZIP'
    State = cbUnchecked
    TabOrder = 5
  end
  object Chkb_InUseTLS: TRzCheckBox
    Left = 20
    Top = 146
    Width = 71
    Height = 19
    AlignmentVertical = avCenter
    Caption = 'inUseTLS'
    State = cbUnchecked
    TabOrder = 6
  end
end
