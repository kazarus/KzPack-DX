object DialogViewUniConfig: TDialogViewUniConfig
  Left = 0
  Top = 0
  Caption = 'DialogViewUniConfig'
  ClientHeight = 562
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Tree_View: TElTree
    Left = 0
    Top = 0
    Width = 464
    Height = 526
    Hint = ''
    Align = alClient
    HeaderHeight = 19
    HeaderSections.Data = {
      F1FFFFFF010000000000000000000000FFFFFFFF00000101010000009B010000
      000000001027000000010000980AB8340000000001000000FFFFFFFF00000100
      0000000000000000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000020000000000020000000000
      0000000000000000}
    HorzScrollBarStyles.Width = 17
    Items.Data = {
      F2FFFFFF00000000000000000000000000000000000000000000000000801002
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFF00000000000000000001000000F2FFFFFF0C0000
      003100390032002E003100360038002E0030002E003100320080000000FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFF83861602000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FFFFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FFFFFFFF000000
      0001000000000000000000000000}
    LineHeight = 17
    ShowColumns = True
    StoragePath = '\Tree'
    TabOrder = 0
    VertScrollBarStyles.ShowTrackHint = True
    VertScrollBarStyles.Width = 17
    OnDblClick = Tree_ViewDblClick
    ExplicitLeft = 112
    ExplicitTop = 160
    ExplicitWidth = 200
    ExplicitHeight = 100
  end
  object Panel1: TPanel
    Left = 0
    Top = 526
    Width = 464
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 176
    ExplicitTop = 392
    ExplicitWidth = 185
    object Btnv_Mrok: TButton
      Left = 295
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Btnv_Mrok'
      TabOrder = 0
      OnClick = Btnv_MrokClick
    end
    object Btnv_Quit: TButton
      Left = 376
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 1
      OnClick = Btnv_QuitClick
    end
  end
end
