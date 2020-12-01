unit Dialog_View;
//#YXC_2010_07_08_12_21_00
//#¸¸¼¶


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPanel, RzCommon, RzBtnEdt;

type
  TDialogViewEditMode = (dvemNULL, dvemADDV, dvemEDIT, dvemVIEW, dvemCOPY, dvemFIND, dvemInsert, dvemDelete, dvemUpdate, dvemSelect, dvemAppend, dvemBrowse, dvemModify);
  TDialogViewViewMode = (dvvmNULL, dvvmSingle, dvvmCouple);
  TDialogViewDoneMode = (dvdmNULL, dvdmCancel, dvdmCommit, dvdmReload);

  TDialogView = class(TForm)
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
  public
  published
    property BtnWidthWhenEdit: Integer read FBtnWidthWhenEdit write FBtnWidthWhenEdit;
    property AltWidthWhenEdit: Integer read FAltWidthWhenEdit write FAltWidthWhenEdit;
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
  I: Integer;
begin
  Font.Name := 'Î¢ÈíÑÅºÚ';
  Font.Size := 9;
  Font.Charset := GB2312_CHARSET;

  //#È¥µô¶¥À¸
  for I := 0 to ComponentCount - 1 do
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

procedure TDialogView.SetGridParams;
begin

end;

procedure TDialogView.SetInitialize;
begin
  Font.Size := 9;
  Font.Name := 'Î¢ÈíÑÅºÚ';

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
