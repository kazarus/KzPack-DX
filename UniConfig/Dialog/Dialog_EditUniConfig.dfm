object DialogEditUniConfig: TDialogEditUniConfig
  Left = 361
  Top = 275
  Caption = 'DialogEditUniConfig'
  ClientHeight = 251
  ClientWidth = 260
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 32
    Top = 16
    Width = 28
    Height = 13
    AutoSize = False
    Caption = #39537#21160
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 34
    Top = 41
    Width = 26
    Height = 13
    Caption = #29992#25143
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 34
    Top = 66
    Width = 26
    Height = 13
    Caption = #23494#30721
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 21
    Top = 91
    Width = 39
    Height = 13
    Caption = #26381#21153#22120
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 19
    Top = 116
    Width = 41
    Height = 13
    AutoSize = False
    Caption = #25968#25454#24211
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl6: TLabel
    Left = 21
    Top = 141
    Width = 39
    Height = 13
    Caption = #31471#21475#21495
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl7: TLabel
    Left = 34
    Top = 166
    Width = 26
    Height = 13
    Caption = #26631#24535
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl8: TLabel
    Left = 34
    Top = 191
    Width = 26
    Height = 13
    Caption = #24180#24230
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Comb_DataBase: TRzComboBox
    Left = 64
    Top = 112
    Width = 180
    Height = 21
    Ctl3D = False
    FrameVisible = True
    FramingPreference = fpCustomFraming
    ParentCtl3D = False
    TabOrder = 12
  end
  object Btnx_Mrok: TButton
    Left = 126
    Top = 215
    Width = 60
    Height = 25
    Caption = #30830#23450
    TabOrder = 0
    OnClick = Btnx_MrokClick
  end
  object Btnx_Quit: TButton
    Left = 186
    Top = 215
    Width = 60
    Height = 25
    Caption = #21462#28040
    TabOrder = 1
    OnClick = Btnx_QuitClick
  end
  object Btnx_Test: TButton
    Left = 66
    Top = 215
    Width = 60
    Height = 25
    Caption = #27979#35797
    TabOrder = 2
    OnClick = Btnx_TestClick
  end
  object Edit_UnixUser: TRzEdit
    Left = 64
    Top = 37
    Width = 180
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 3
  end
  object Edit_UnixPswd: TRzEdit
    Left = 64
    Top = 62
    Width = 180
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 4
    OnExit = Edit_UnixPswdExit
  end
  object Edit_UnixServ: TRzEdit
    Left = 64
    Top = 87
    Width = 180
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 5
    OnDblClick = Edit_UnixServDblClick
  end
  object Edit_UnixPort: TRzEdit
    Left = 64
    Top = 137
    Width = 180
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 6
  end
  object Edit_UnixYear: TRzEdit
    Left = 64
    Top = 187
    Width = 180
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 7
  end
  object Comb_Type: TRzComboBox
    Left = 64
    Top = 12
    Width = 180
    Height = 21
    Ctl3D = False
    FrameVisible = True
    FramingPreference = fpCustomFraming
    ParentCtl3D = False
    TabOrder = 8
    OnCloseUp = Comb_TypeCloseUp
  end
  object Edit_DataBase: TRzButtonEdit
    Left = 64
    Top = 112
    Width = 180
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
    TabOrder = 9
    OnDblClick = Edit_DataBaseDblClick
    AltBtnKind = bkFolder
    AltBtnVisible = True
    AltBtnWidth = 15
    ButtonWidth = 15
    OnAltBtnClick = Edit_DataBaseAltBtnClick
    OnButtonClick = Edit_DataBaseButtonClick
  end
  object Comb_Mark: TRzComboBox
    Left = 64
    Top = 162
    Width = 180
    Height = 21
    Ctl3D = False
    FrameVisible = True
    FramingPreference = fpCustomFraming
    ParentCtl3D = False
    TabOrder = 10
  end
  object ChkBox_Direct: TRzCheckBox
    Left = 8
    Top = 220
    Width = 45
    Height = 15
    Caption = #30452#32852
    State = cbUnchecked
    TabOrder = 11
  end
  object con1: TUniConnection
    Left = 160
    Top = 128
  end
end
