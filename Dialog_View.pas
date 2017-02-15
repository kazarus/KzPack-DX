unit Dialog_View;
//YXC_2010_07_08_12_21_00
//¸¸¼¶ 

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TDialogViewEditMode  = (dvemNULL,dvemADDV,dvemEDIT);
  TDialogViewViewMode  = (dvvmNULL,dvvmCoupl,dvvmSingl);

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
begin
  Font.Name:='ËÎÌå';
  Font.Size:=10;
  Font.Charset:=GB2312_CHARSET;
end;

procedure TDialogView.SetGridParams;
begin

end;

procedure TDialogView.SetInitialize;
begin
  Font.Size:=10;
  Font.Name:='ËÎÌå';
  
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
