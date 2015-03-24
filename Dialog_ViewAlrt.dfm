object DialogViewAlrt: TDialogViewAlrt
  Left = 257
  Top = 235
  Width = 440
  Height = 224
  Caption = 'DialogViewAlrt'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Labl_Text: TLabel
    Left = 11
    Top = 14
    Width = 400
    Height = 137
    AutoSize = False
    Caption = 'Labl_Text'
    WordWrap = True
  end
  object Btnx_Mrok: TButton
    Left = 267
    Top = 157
    Width = 75
    Height = 25
    Caption = 'Btnx_Mrok'
    TabOrder = 0
    OnClick = Btnx_MrokClick
  end
  object Btnx_Quit: TButton
    Left = 342
    Top = 157
    Width = 75
    Height = 25
    Caption = 'Btnx_1'
    TabOrder = 1
    OnClick = Btnx_QuitClick
  end
  object Chkb_KEEP: TCheckBox
    Left = 11
    Top = 161
    Width = 97
    Height = 17
    Caption = #35760#20303#35813#25805#20316
    TabOrder = 2
  end
end
