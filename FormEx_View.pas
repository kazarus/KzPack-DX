unit FormEx_View;
//YXC_2012_08_29_10_18_51
//有个Form_View是MDI方式的.避免混淆.
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TFormExView = class(TForm)
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  protected
    procedure SetInitialize;virtual;
    procedure SetGridParams;virtual;
    procedure SetCommParams;virtual;
    procedure SetComboItems;virtual;
    procedure TryFreeAndNil;virtual;
  end;

var
  FormExView: TFormExView;

implementation

{$R *.dfm}

procedure TFormExView.FormShow(Sender: TObject);
begin
  SetInitialize;
end;

procedure TFormExView.FormDestroy(Sender: TObject);
begin
  TryFreeAndNil;
end;

procedure TFormExView.SetComboItems;
begin

end;

procedure TFormExView.SetCommParams;
begin

end;

procedure TFormExView.SetGridParams;
begin

end;

procedure TFormExView.SetInitialize;
begin
  Font.Size:=10;
  Font.Name:='宋体';

  SetCommParams;
  SetComboItems;
  SetGridParams;
end;

procedure TFormExView.TryFreeAndNil;
begin

end;

end.
