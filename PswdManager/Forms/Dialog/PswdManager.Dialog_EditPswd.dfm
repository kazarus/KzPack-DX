object DialogEditPswd: TDialogEditPswd
  Left = 0
  Top = 0
  Caption = 'DialogEditPswd'
  ClientHeight = 238
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 17
  object RzLabel2: TRzLabel
    Left = 41
    Top = 98
    Width = 51
    Height = 17
    Caption = #21407#22987#23494#30721':'
  end
  object RzLabel3: TRzLabel
    Left = 41
    Top = 40
    Width = 51
    Height = 17
    Caption = #29992#25143#21517#31216':'
  end
  object RzLabel4: TRzLabel
    Left = 41
    Top = 127
    Width = 51
    Height = 17
    Caption = #26356#25442#23494#30721':'
  end
  object RzLabel5: TRzLabel
    Left = 41
    Top = 156
    Width = 51
    Height = 17
    Caption = #30830#35748#23494#30721':'
  end
  object RzLabel6: TRzLabel
    Left = 41
    Top = 69
    Width = 51
    Height = 17
    Caption = #30331#24405#36134#21495':'
  end
  object Labl_ChangQD: TRzLabel
    Left = 401
    Top = 127
    Width = 39
    Height = 17
    Caption = #24378#24230':'#31354
  end
  object Labl_UpdateQD: TRzLabel
    Left = 401
    Top = 156
    Width = 39
    Height = 17
    Caption = #24378#24230':'#31354
  end
  object Edit_UserName: TRzButtonEdit
    Left = 96
    Top = 36
    Width = 300
    Height = 25
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 0
    AltBtnWidth = 15
    ButtonWidth = 15
  end
  object Edit_UserCode: TRzButtonEdit
    Left = 96
    Top = 65
    Width = 300
    Height = 25
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 1
    AltBtnWidth = 15
    ButtonWidth = 15
  end
  object Edit_PassWord: TRzButtonEdit
    Left = 96
    Top = 94
    Width = 300
    Height = 25
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 2
    AltBtnWidth = 15
    ButtonWidth = 15
  end
  object Edit_ChangeMM: TRzButtonEdit
    Left = 96
    Top = 123
    Width = 300
    Height = 25
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 3
    OnChange = Edit_ChangeMMChange
    AltBtnWidth = 15
    ButtonWidth = 15
  end
  object Edit_UpdateMM: TRzButtonEdit
    Left = 96
    Top = 152
    Width = 300
    Height = 25
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 4
    OnChange = Edit_UpdateMMChange
    AltBtnWidth = 15
    ButtonWidth = 15
  end
  object Panl_Main: TRzPanel
    Left = 0
    Top = 202
    Width = 451
    Height = 36
    Align = alBottom
    BorderOuter = fsNone
    TabOrder = 5
    object Btnv_Mrok: TRzButton
      Left = 249
      Top = 5
      Caption = 'Btnv_Mrok'
      TabOrder = 0
      OnClick = Btnv_MrokClick
    end
    object Btnv_Quit: TRzButton
      Left = 328
      Top = 5
      Caption = 'RzButton1'
      TabOrder = 1
      OnClick = Btnv_QuitClick
    end
    object Chkb_ShowPSWD: TRzCheckBox
      Left = 43
      Top = 8
      Width = 67
      Height = 19
      Caption = #26174#31034#23494#30721
      State = cbUnchecked
      TabOrder = 2
      OnClick = Chkb_ShowPSWDClick
    end
  end
end