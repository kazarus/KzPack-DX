unit Form_View;
//YXC_2010_07_08_12_21_52
//¸¸¼¶
{
    procedure SetInitialize;override;
    procedure SetCommParams;override;
    procedure SetGridParams;override;
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, ImgList;

type
  TFormView = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  protected
    procedure SetInitialize;virtual;
    procedure SetCommParams;virtual;
    procedure SetGridParams;virtual;
//  public
//    procedure CreateParams(var Params: TCreateParams); override;    
  end;

var
  FormView: TFormView;

implementation
uses
  Main;
  
{$R *.dfm}

//procedure TFormView.CreateParams(var Params: TCreateParams);
//begin
//  inherited;
////  ParentWindow:=GetDesktopWindow;
//end;

procedure TFormView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  Form_Main.RemoveView(Self);
end;

procedure TFormView.FormShow(Sender: TObject);
begin
  SetInitialize;
end;

procedure TFormView.SetCommParams;
begin
  Font.Name:='ËÎÌå';
  Font.Size:=10;
  Font.Charset:=GB2312_CHARSET;
end;

procedure TFormView.SetGridParams;
begin

end;

procedure TFormView.SetInitialize;
begin
  SetGridParams;
  SetCommParams;
end;

end.
