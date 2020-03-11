unit XlsImport.Form_PickNode;


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  FormEx_View, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxCore, dxCoreClasses, dxHashUtils, dxSpreadSheetCore,
  dxSpreadSheetCoreHistory, dxSpreadSheetConditionalFormatting,
  dxSpreadSheetConditionalFormattingRules, dxSpreadSheetClasses,
  dxSpreadSheetContainers, dxSpreadSheetFormulas, dxSpreadSheetHyperlinks,
  dxSpreadSheetFunctions, dxSpreadSheetGraphics, dxSpreadSheetPrinting,
  dxSpreadSheetTypes, dxSpreadSheetUtils, dxSpreadSheet, RzButton, RzPanel,
  RzStatus, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList;

type
  TFormPickNodePickType = (fpnptNull, fpnptNodeH, fpnptNodeV, fpnptExpt);

  TFormPickNode = class(TFormExView)
    Panl_1: TRzStatusBar;
    Panl_2: TRzStatusPane;
    Prog_1: TRzProgressStatus;
    Tool_1: TRzToolbar;
    Btnv_View: TRzToolButton;
    Btnv_Quit: TRzToolButton;
    Excl_Main: TdxSpreadSheet;
    il1: TImageList;
    Btnv_Mrok: TRzToolButton;
    procedure Btnv_QuitClick(Sender: TObject);
    procedure Btnv_MrokClick(Sender: TObject);
    procedure Btnv_ViewClick(Sender: TObject);
  private
    FPickType : TFormPickNodePickType;
  protected
    procedure SetInitialize;override;
    procedure SetCommParams;override;
    procedure SetGridParams;override;
    procedure SetComboItems;override;
    procedure TryFreeAndNil;override;
  public
    procedure ViewPath;
  public
    procedure ReadNode(var aList: TStringList); overload;
    procedure ReadNode(var aList: TCollection); overload;
  end;

var
  FormPickNode: TFormPickNode;

function ViewPickNode(var aList: TStringList; aPickType: TFormPickNodePickType = fpnptNodeH): Integer; overload;
function ViewPickNode(var aList: TCollection; aPickType: TFormPickNodePickType = fpnptNodeH): Integer; overload;

implementation

uses
  XlsImport.NodeManager, Class_KzUtils, XlsImport.Class_Cell_Node;

{$R *.dfm}

function ViewPickNode(var aList: TStringList; aPickType: TFormPickNodePickType): Integer;
begin
  try
    FormPickNode:=TFormPickNode.Create(nil);
    FormPickNode.FPickType := aPickType;
    Result:=FormPickNode.ShowModal;
    if Result = Mrok then
    begin
      FormPickNode.ReadNode(aList);
    end;
  finally
    FreeAndNil(FormPickNode);
  end;
end;

function ViewPickNode(var aList: TCollection; aPickType: TFormPickNodePickType): Integer;
begin
  try
    FormPickNode:=TFormPickNode.Create(nil);
    FormPickNode.FPickType := aPickType;
    Result:=FormPickNode.ShowModal;
    if Result = Mrok then
    begin
      FormPickNode.ReadNode(aList);
    end;
  finally
    FreeAndNil(FormPickNode);
  end;
end;

procedure TFormPickNode.Btnv_MrokClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFormPickNode.Btnv_QuitClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFormPickNode.Btnv_ViewClick(Sender: TObject);
begin
  ViewPath;
end;

procedure TFormPickNode.ReadNode(var aList: TCollection);
var
  xList: TStringList;
begin
  try
    xList := TStringList.Create;
    case FPickType of
      fpnptNodeH:
      begin
        TNodeManager.ReadNodeH(Excl_Main, xList);
        TCellNode.CopyIt(xList, aList);
      end;
      fpnptNodeV:
      begin
        TNodeManager.ReadNodeV(Excl_Main, xList);
        TCellNode.CopyIt(xList, aList);
      end;
      {fpnptExpt:
      begin
        TNodeManager.ReadExpt(Excl_Main,xList);
      end;}
    end;
  finally
    TKzUtils.TryFreeAndNil(xList);
  end;
end;

procedure TFormPickNode.ReadNode(var aList: TStringList);
begin
  case FPickType of
    fpnptNodeH:
    begin
      TNodeManager.ReadNodeH(Excl_Main,aList);
    end;
    fpnptNodeV:
    begin
      TNodeManager.ReadNodeV(Excl_Main,aList);
    end;
    {@fpnptExpt:
    begin
      TNodeManager.ReadExpt(Excl_Main,aList);
    end;}
  end;
end;

procedure TFormPickNode.SetComboItems;
begin
  inherited;

end;

procedure TFormPickNode.SetCommParams;
begin
  inherited;
  Caption := '表头采样';
  Btnv_Quit.Caption := '退出';
  Btnv_View.Caption := '文件';
  Btnv_Mrok.Caption := '确定';

  Font.Name := '微软雅黑';
  Font.Size := 10;
end;

procedure TFormPickNode.SetGridParams;
begin
  inherited;

end;

procedure TFormPickNode.SetInitialize;
begin
  inherited;
  Btnv_ViewClick(Btnv_View);
end;

procedure TFormPickNode.TryFreeAndNil;
begin
  inherited;

end;

procedure TFormPickNode.ViewPath;
var
  OD: TOpenDialog;
begin
  try
    OD := TOpenDialog.Create(nil);
    OD.Filter := '*.xls|*.xls|*.xlsx|*.xlsx';
    if not OD.Execute then Exit;
    Excl_Main.LoadFromFile(OD.FileName);
  finally
    FreeAndNil(OD);
  end;
end;

end.
