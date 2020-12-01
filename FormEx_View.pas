unit FormEx_View;
//#YXC_2012_08_29_10_18_51
//#�и�Form_View��MDI��ʽ��.�������.


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPanel, RzCommon, RzBtnEdt;

type
  TFormExView = class(TForm)
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FBtnWidthWhenEdit: Integer;    //#TRzButtonEdit.Button
    FAltWidthWhenEdit: Integer;    //#TRzButtonEdit.AltBtn
  protected
    procedure SetInitialize;virtual;
    procedure SetGridParams;virtual;
    procedure SetCommParams;virtual;
    procedure SetComboItems;virtual;
    procedure TryFreeAndNil;virtual;
  published
    property BtnWidthWhenEdit: Integer read FBtnWidthWhenEdit write FBtnWidthWhenEdit;
    property AltWidthWhenEdit: Integer read FAltWidthWhenEdit write FAltWidthWhenEdit;
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
var
  I:Integer;
begin
  Font.Name:='����';
  Font.Size:=10;
  Font.Charset:=GB2312_CHARSET;

  //#ȥ������
  for I := 0 to ComponentCount -1 do
  begin
    if Components[I] is TRzToolbar then
    begin
      TRzToolbar(Components[I]).BorderSides := TRzToolbar(Components[I]).BorderSides - [sdTop];
    end else
    if Components[I] is TRzButtonEdit then
    begin
      TRzButtonEdit(Components[I]).ButtonWidth := 25;
      TRzButtonEdit(Components[I]).AltBtnWidth := 25;
    end;
  end;
end;

procedure TFormExView.SetGridParams;
begin

end;

procedure TFormExView.SetInitialize;
begin
  Font.Size:=10;
  Font.Name:='����';

  SetCommParams;
  SetComboItems;
  SetGridParams;
end;

procedure TFormExView.TryFreeAndNil;
begin

end;

end.
