object DialogEditUniConfig: TDialogEditUniConfig
  Left = 361
  Top = 275
  Caption = 'DialogEditUniConfig'
  ClientHeight = 263
  ClientWidth = 431
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
    Left = 20
    Top = 17
    Width = 59
    Height = 13
    AutoSize = False
    Caption = #39537#21160#31867#22411':'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 20
    Top = 42
    Width = 59
    Height = 13
    Caption = #30331#24405#29992#25143':'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 20
    Top = 67
    Width = 59
    Height = 13
    Caption = #30331#24405#23494#30721':'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 33
    Top = 92
    Width = 46
    Height = 13
    Caption = #26381#21153#22120':'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 33
    Top = 117
    Width = 46
    Height = 13
    AutoSize = False
    Caption = #25968#25454#24211':'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl6: TLabel
    Left = 33
    Top = 142
    Width = 46
    Height = 13
    Caption = #31471#21475#21495':'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl7: TLabel
    Left = 20
    Top = 167
    Width = 59
    Height = 13
    Caption = #36830#25509#26631#35782':'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl8: TLabel
    Left = 20
    Top = 192
    Width = 59
    Height = 13
    Caption = #25351#23450#24180#24230':'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Comb_DataBase: TRzComboBox
    Left = 83
    Top = 113
    Width = 301
    Height = 21
    Ctl3D = False
    FrameVisible = True
    FramingPreference = fpCustomFraming
    ParentCtl3D = False
    TabOrder = 4
  end
  object Btnx_Mrok: TButton
    Left = 253
    Top = 222
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 10
    OnClick = Btnx_MrokClick
  end
  object Btnx_Quit: TButton
    Left = 328
    Top = 222
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 11
    OnClick = Btnx_QuitClick
  end
  object Btnx_Test: TButton
    Left = 178
    Top = 222
    Width = 75
    Height = 25
    Caption = #27979#35797
    TabOrder = 9
    OnClick = Btnx_TestClick
  end
  object Edit_UnicUser: TRzEdit
    Left = 83
    Top = 38
    Width = 320
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 1
  end
  object Edit_UnicPswd: TRzEdit
    Left = 83
    Top = 63
    Width = 320
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 2
    OnExit = Edit_UnicPswdExit
  end
  object Edit_UnicSrvr: TRzEdit
    Left = 83
    Top = 88
    Width = 320
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 3
    OnDblClick = Edit_UnicSrvrDblClick
  end
  object Edit_UnicPort: TRzEdit
    Left = 83
    Top = 138
    Width = 320
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 6
  end
  object Edit_UnicYear: TRzEdit
    Left = 83
    Top = 188
    Width = 320
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    TabOrder = 8
  end
  object Comb_Type: TRzComboBox
    Left = 83
    Top = 13
    Width = 320
    Height = 21
    Ctl3D = False
    FrameVisible = True
    FramingPreference = fpCustomFraming
    ParentCtl3D = False
    TabOrder = 0
    OnCloseUp = Comb_TypeCloseUp
  end
  object Edit_DataBase: TRzButtonEdit
    Left = 384
    Top = 113
    Width = 19
    Height = 21
    Text = ''
    FrameVisible = True
    FramingPreference = fpCustomFraming
    ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
    TabOrder = 5
    OnDblClick = Edit_DataBaseDblClick
    AltBtnKind = bkFolder
    AltBtnWidth = 15
    ButtonWidth = 15
    OnAltBtnClick = Edit_DataBaseAltBtnClick
    OnButtonClick = Edit_DataBaseButtonClick
  end
  object Comb_Mark: TRzComboBox
    Left = 83
    Top = 163
    Width = 320
    Height = 21
    Ctl3D = False
    FrameVisible = True
    FramingPreference = fpCustomFraming
    ParentCtl3D = False
    TabOrder = 7
  end
  object ChkBox_Direct: TRzCheckBox
    Left = 20
    Top = 227
    Width = 45
    Height = 15
    AlignmentVertical = avCenter
    Caption = #30452#32852
    State = cbUnchecked
    TabOrder = 12
  end
  object con1: TUniConnection
    Left = 560
    Top = 248
  end
end
