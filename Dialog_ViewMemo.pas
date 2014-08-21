unit Dialog_ViewMemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzEdit, ExtCtrls,Dialog_View;

type
  TDialogViewMemo = class(TDialogView)
    Panl_1: TPanel;
    Memo_1: TRzMemo;
    Btnx_Mrok: TButton;
    Btnx_Quit: TButton;
    procedure Btnx_QuitClick(Sender: TObject);
    procedure Btnx_MrokClick(Sender: TObject);
  private
    FTitl:string;
    FMemo:string;
    FMrokLabl:string;
    FQuitLabl:string;
  protected
    procedure SetInitialize;override;
    procedure SetCommParams;override;
    procedure SetGridParams;override;
    procedure SetComboItems;override;
    procedure TryFreeAndNil;override;  
  public
  end;

var
  DialogViewMemo: TDialogViewMemo;

function ViewMemo(ATitl:string;AMemo:string;AMrokLabl:string='';AQuitLabl:string=''):Integer;

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

procedure TDialogViewMemo.Btnx_QuitClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TDialogViewMemo.Btnx_MrokClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TDialogViewMemo.SetComboItems;
begin
  inherited;

end;

procedure TDialogViewMemo.SetCommParams;
begin
  inherited;

  Btnx_Mrok.Caption:='确定';
  Btnx_Quit.Caption:='取消';

  if Trim(FMrokLabl)<>'' then
  begin
    Btnx_Mrok.Caption:=FMrokLabl;
  end;
  if Trim(FQuitLabl)<>'' then
  begin
    Btnx_Quit.Caption:=FQuitLabl;
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
  Memo_1.Lines.Clear;
  Memo_1.Lines.Add(FMemo);
end;

procedure TDialogViewMemo.TryFreeAndNil;
begin
  inherited;

end;

end.
