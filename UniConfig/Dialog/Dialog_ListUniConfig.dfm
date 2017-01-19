object DialogListUniConfig: TDialogListUniConfig
  Left = 285
  Top = 75
  Caption = 'DialogListUniConfig'
  ClientHeight = 594
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panl_1: TPanel
    Left = 0
    Top = 545
    Width = 1008
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Btnx_Edit: TButton
      Left = 715
      Top = 2
      Width = 75
      Height = 25
      Caption = #32534#36753
      TabOrder = 5
      OnClick = Btnx_EditClick
    end
    object Btnx_Addx: TButton
      Left = 640
      Top = 2
      Width = 75
      Height = 25
      Caption = #26032#22686
      TabOrder = 4
      OnClick = Btnx_AddxClick
    end
    object Btnx_Delt: TButton
      Left = 790
      Top = 2
      Width = 75
      Height = 25
      Caption = #21024#38500
      TabOrder = 6
      OnClick = Btnx_DeltClick
    end
    object Btnx_Test: TButton
      Left = 490
      Top = 2
      Width = 75
      Height = 25
      Caption = #27979#35797
      TabOrder = 2
      OnClick = Btnx_TestClick
    end
    object Btnx_Mrok: TButton
      Left = 865
      Top = 2
      Width = 75
      Height = 25
      Caption = #30830#23450
      TabOrder = 7
      OnClick = Btnx_MrokClick
    end
    object Btnx_Quit: TButton
      Left = 940
      Top = 2
      Width = 75
      Height = 25
      Caption = #21462#28040
      TabOrder = 8
      OnClick = Btnx_QuitClick
    end
    object ChkBox_All: TRzCheckBox
      Left = 9
      Top = 7
      Width = 45
      Height = 15
      Caption = #20840#36873
      State = cbUnchecked
      TabOrder = 9
      OnClick = ChkBox_AllClick
    end
    object Btnx_1: TButton
      Left = 415
      Top = 2
      Width = 75
      Height = 25
      Caption = #35774#20026#27963#21160
      TabOrder = 1
      OnClick = Btnx_1Click
    end
    object Btnx_2: TButton
      Left = 340
      Top = 2
      Width = 75
      Height = 25
      Caption = #20445#23384#25490#24207
      TabOrder = 0
      OnClick = Btnx_2Click
    end
    object Btnx_Copy: TButton
      Left = 565
      Top = 2
      Width = 75
      Height = 25
      Caption = #22797#21046
      TabOrder = 3
      OnClick = Btnx_CopyClick
    end
    object Comb_UnixMark: TRzComboBox
      Left = 140
      Top = 4
      Width = 100
      Height = 21
      Ctl3D = False
      FrameVisible = True
      FramingPreference = fpCustomFraming
      ParentCtl3D = False
      TabOrder = 10
    end
    object Comb_UnixType: TRzComboBox
      Left = 54
      Top = 4
      Width = 100
      Height = 21
      Ctl3D = False
      FrameVisible = True
      FramingPreference = fpCustomFraming
      ParentCtl3D = False
      TabOrder = 11
      OnCloseUp = Comb_UnixTypeCloseUp
    end
  end
  object RzStatusBar1: TRzStatusBar
    Left = 0
    Top = 575
    Width = 1008
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 1
    VisualStyle = vsClassic
    object Panl_UnixMemo: TRzStatusPane
      Left = 679
      Top = 0
      Width = 329
      Height = 19
      Align = alRight
      Caption = ''
      ExplicitLeft = 687
    end
    object Panl_DataBase: TRzStatusPane
      Left = 0
      Top = 0
      Width = 679
      Height = 19
      Align = alClient
      Caption = ''
      ExplicitWidth = 687
    end
  end
  object Grid_Cnfg: TAdvStringGrid
    Left = 0
    Top = 0
    Width = 1008
    Height = 545
    Cursor = crDefault
    Align = alClient
    DrawingStyle = gdsClassic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
    OnDblClick = Grid_CnfgDblClick
    OnRowMoved = Grid_CnfgRowMoved
    OnSelectCell = Grid_CnfgSelectCell
    HoverRowCells = [hcNormal, hcSelected]
    OnGetAlignment = Grid_CnfgGetAlignment
    OnClickCell = Grid_CnfgClickCell
    OnCanEditCell = Grid_CnfgCanEditCell
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ControlLook.FixedGradientHoverFrom = clGray
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientDownFrom = clGray
    ControlLook.FixedGradientDownTo = clSilver
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'MS Sans Serif'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -11
    FilterDropDown.Font.Name = 'MS Sans Serif'
    FilterDropDown.Font.Style = []
    FilterDropDownClear = '(All)'
    FilterEdit.TypeNames.Strings = (
      'Starts with'
      'Ends with'
      'Contains'
      'Not contains'
      'Equal'
      'Not equal'
      'Larger than'
      'Smaller than'
      'Clear')
    FixedRowHeight = 22
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    HoverButtons.Buttons = <>
    HoverButtons.Position = hbLeftFromColumnLeft
    HTMLSettings.ImageFolder = 'images'
    HTMLSettings.ImageBaseName = 'img'
    Look = glSoft
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'MS Sans Serif'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'MS Sans Serif'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'MS Sans Serif'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'MS Sans Serif'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    SearchFooter.Color = clBtnFace
    SearchFooter.FindNextCaption = 'Find &next'
    SearchFooter.FindPrevCaption = 'Find &previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'MS Sans Serif'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurrence'
    SearchFooter.HintFindPrev = 'Find previous occurrence'
    SearchFooter.HintHighlight = 'Highlight occurrences'
    SearchFooter.MatchCaseCaption = 'Match case'
    SelectionColor = clHighlight
    SelectionTextColor = clHighlightText
    SortSettings.DefaultFormat = ssAutomatic
    Version = '7.8.4.0'
    ColWidths = (
      64
      64
      64
      64
      64)
  end
end
