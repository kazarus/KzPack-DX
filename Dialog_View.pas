unit Dialog_View;
//YXC_2010_07_08_12_21_00
//父级 

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPanel, RzCommon;

type
  TDialogViewEditMode = (dvemNULL, dvemADDV, dvemEDIT);
  TDialogViewViewMode = (dvvmNULL, dvvmSingle, dvvmCouple);
  TDialogViewDoneMode = (dvdmNULL, dvdmCancel, dvdmCommit);

  TDialogView = class(TForm)
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  protected
    procedure SetInitialize;virtual;
    procedure SetGridParams;virtual;
    procedure SetCommParams;virtual;
    procedure SetComboItems;virtual;
    procedure TryFreeAndNil;virtual;
  public
  end;

var
  DialogView: TDialogView;

implementation

{$R *.dfm}

procedure TDialogView.FormShow(Sender: TObject);
begin
  SetInitialize;
end;

procedure TDialogView.SetComboItems;
begin

end;

procedure TDialogView.SetCommParams;
var
  I:Integer;
begin
  Font.Name:='宋体';
  Font.Size:=10;
  Font.Charset:=GB2312_CHARSET;

  //#去掉顶栏
  for I := 0 to ComponentCount -1 do
  begin
    if Components[I] is TRzToolbar then
    begin
      TRzToolbar(Components[I]).BorderSides := TRzToolbar(Components[I]).BorderSides - [sdTop];
    end;
  end;
end;

procedure TDialogView.SetGridParams;
begin

end;

procedure TDialogView.SetInitialize;
begin
  Font.Size:=10;
  Font.Name:='宋体';
  
  SetCommParams;
  SetComboItems;
  SetGridParams;
end;



procedure TDialogView.TryFreeAndNil;
begin

end;

procedure TDialogView.FormDestroy(Sender: TObject);
begin
  TryFreeAndNil;
end;

end.
