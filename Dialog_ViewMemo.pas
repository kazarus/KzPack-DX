unit Dialog_ViewMemo;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzEdit, ExtCtrls,Dialog_View, RzButton, RzStatus, RzPanel,
  System.ImageList, Vcl.ImgList;

type
  TDialogViewMemo = class(TDialogView)
    Memo_Main: TRzMemo;
    Tool_Main: TRzToolbar;
    RzStatusBar1: TRzStatusBar;
    Panl_Text: TRzStatusPane;
    Btnv_Mrok: TRzToolButton;
    Btnv_Quit: TRzToolButton;
    Btnv_Expt: TRzToolButton;
    ImageList1: TImageList;
    procedure Btnx_ExptClick(Sender: TObject);
    procedure Btnv_MrokClick(Sender: TObject);
    procedure Btnv_ExptClick(Sender: TObject);
    procedure Btnv_QuitClick(Sender: TObject);
  private
    FTitl: string;
    FMemo: string;
    FMrokLabl: string;
    FQuitLabl: string;
  protected
    procedure SetInitialize;override;
    procedure SetCommParams;override;
    procedure SetGridParams;override;
    procedure SetComboItems;override;
    procedure TryFreeAndNil;override;  
  public
    procedure ExptText;
  end;

var
  DialogViewMemo: TDialogViewMemo;

function ViewMemo(ATitl: string; AMemo: string; AMrokLabl: string = ''; AQuitLabl: string = ''): Integer;
function EditMemo(ATitl: string; AMemo: string; var AText: string; AMrokLabl: string = ''; AQuitLabl: string = ''): Integer;

implementation

{$R *.dfm}
function ViewMemo(ATitl:string;AMemo:string;AMrokLabl:string='';AQuitLabl:string=''):Integer;
begin
  try
    DialogViewMemo:=TDialogViewMemo.Create(nil);
    DialogViewMemo.FTitl:=ATitl;
    DialogViewMemo.FMemo:=AMemo;
    DialogViewMemo.FMrokLabl:=AMrokLabl;
    DialogViewMemo.FQuitLabl:=AQuitLabl;
    Result:=DialogViewMemo.ShowModal;
  finally
    FreeAndNil(DialogViewMemo);
  end;
end;      

function EditMemo(ATitl:string;AMemo:string;var AText:string;AMrokLabl:string='';AQuitLabl:string=''):Integer;
begin
  try
    DialogViewMemo:=TDialogViewMemo.Create(nil);
    DialogViewMemo.FTitl:=ATitl;
    DialogViewMemo.FMemo:=AMemo;
    DialogViewMemo.FMrokLabl:=AMrokLabl;
    DialogViewMemo.FQuitLabl:=AQuitLabl;
    Result:=DialogViewMemo.ShowModal;
    if Result=Mrok then
    begin
      AText:=Trim(DialogViewMemo.Memo_Main.Lines.Text);
    end;
  finally
    FreeAndNil(DialogViewMemo);
  end;
end;              

procedure TDialogViewMemo.SetComboItems;
begin
  inherited;

end;

procedure TDialogViewMemo.SetCommParams;
begin
  inherited;

  Btnv_Mrok.Caption := '确定';
  Btnv_Quit.Caption := '取消';
  Btnv_Expt.Caption := '导出';

  if Trim(FMrokLabl)<>'' then
  begin
    Btnv_Mrok.Caption := FMrokLabl;
  end;
  if Trim(FQuitLabl)<>'' then
  begin
    Btnv_Quit.Caption := FQuitLabl;
  end;
end;

procedure TDialogViewMemo.SetGridParams;
begin
  inherited;

end;

procedure TDialogViewMemo.SetInitialize;
begin
  inherited;

  Caption:=FTitl;
  Memo_Main.Lines.Clear;
  Memo_Main.Lines.Add(FMemo);
end;

procedure TDialogViewMemo.TryFreeAndNil;
begin
  inherited;

end;

procedure TDialogViewMemo.ExptText;
var
  FN:string;
  SD:TSaveDialog;
begin
  try
    SD:=TSaveDialog.Create(nil);
    SD.Filter:='*.txt';
    if SD.Execute then
    begin
      FN:=SD.FileName;
      if ExtractFileExt(FN)='' then
      begin
        FN:=Format('%S.txt',[FN]);
      end;
      Memo_Main.Lines.SaveToFile(FN);    
    end;
  finally
    FreeAndNil(SD);
  end;
end;

procedure TDialogViewMemo.Btnv_ExptClick(Sender: TObject);
begin
  ExptText;
end;

procedure TDialogViewMemo.Btnv_MrokClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TDialogViewMemo.Btnv_QuitClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TDialogViewMemo.Btnx_ExptClick(Sender: TObject);
begin
  ExptText;
end;

end.
