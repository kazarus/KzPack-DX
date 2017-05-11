unit XlsImport.Form_PickNode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormEx_View, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxCore, dxCoreClasses,
  dxHashUtils, dxSpreadSheetCore, dxSpreadSheetCoreHistory,
  dxSpreadSheetConditionalFormatting, dxSpreadSheetConditionalFormattingRules,
  dxSpreadSheetClasses, dxSpreadSheetContainers, dxSpreadSheetFormulas,
  dxSpreadSheetHyperlinks, dxSpreadSheetFunctions, dxSpreadSheetGraphics,
  dxSpreadSheetPrinting, dxSpreadSheetTypes, dxSpreadSheetUtils, dxSpreadSheet,
  RzButton, RzPanel, RzStatus, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList;

type
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
  protected
    procedure SetInitialize;override;
    procedure SetCommParams;override;
    procedure SetGridParams;override;
    procedure SetComboItems;override;
    procedure TryFreeAndNil;override;
  public
    procedure ViewPath;
  public
    procedure ReadNode(var aList:TStringList);
  end;

var
  FormPickNode: TFormPickNode;

function ViewPickNode(var aList:TStringList):Integer;

implementation

uses
  XlsImport.NodeManager;

{$R *.dfm}

function ViewPickNode(var aList:TStringList):Integer;
begin
  try
    FormPickNode:=TFormPickNode.Create(nil);
    Result:=FormPickNode.ShowModal;
    if Result = Mrok then
    begin

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

procedure TFormPickNode.ReadNode(var aList: TStringList);
begin
  TNodeManager.ReadNode(Excl_Main,aList);
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
  OD:TOpenDialog;
begin
  try
    OD:=TOpenDialog.Create(nil);
    if OD.Execute then
    begin
      Excl_Main.LoadFromFile(OD.FileName);
    end;
  finally
    FreeAndNil(OD);
  end;
end;

end.
