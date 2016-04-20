object DialogSrvrCnfg: TDialogSrvrCnfg
  Left = 0
  Top = 0
  Caption = 'DialogSrvrCnfg'
  ClientHeight = 282
  ClientWidth = 384
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
    Width = 59
    Height = 13
    Caption = #26381#21153#22320#22336':'
    ParentColor = False
  end
  object Labl_2: TRzLabel
    Left = 20
    Top = 45
    Width = 59
    Height = 13
    Caption = #26381#21153#31471#21475':'
  end
  object Labl_3: TRzLabel
    Left = 20
    Top = 70
    Width = 59
    Height = 13
    Caption = #26381#21153#26631#35782':'
  end
  object Edit_SrvrPort: TRzButtonEdit
    Left = 83
    Top = 41
    Width = 282
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 0
    AltBtnWidth = 15
    ButtonWidth = 15
  end
  object Edit_SrvrAddr: TRzButtonEdit
    Left = 83
    Top = 16
    Width = 282
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 1
    AltBtnWidth = 15
    ButtonWidth = 15
  end
  object Btnx_Mrok: TRzButton
    Left = 218
    Top = 249
    Caption = 'Btnx_Mrok'
    TabOrder = 2
    OnClick = Btnx_MrokClick
  end
  object Btnx_Quit: TRzButton
    Left = 290
    Top = 249
    Caption = 'Btnx_1'
    TabOrder = 3
    OnClick = Btnx_QuitClick
  end
  object Edit_SrvrMemo: TRzButtonEdit
    Left = 83
    Top = 66
    Width = 282
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 4
    AltBtnWidth = 15
    ButtonWidth = 15
  end
end
