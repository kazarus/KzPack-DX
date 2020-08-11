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
    procedure Btnv_MrokClick(Sender: TObject);
    procedure Btnv_QuitClick(Sender: TObject);
    procedure Btnv_ExptClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    FTitlText: string;
    FMemoText: string;
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

function ViewMemo(aTitlText: string; aMemoText: string; aMrokLabl: string = ''; aQuitLabl: string = ''): Integer;
function EditMemo(aTitlText: string; aMemoText: string; var aTextEdit: string; aMrokLabl: string = ''; aQuitLabl: string = ''): Integer;

implementation

uses
  StylManager;

{$R *.dfm}

function ViewMemo(aTitlText: string; aMemoText: string; aMrokLabl: string = ''; aQuitLabl: string = ''): Integer;
begin
  try
    DialogViewMemo := TDialogViewMemo.Create(nil);
    DialogViewMemo.FTitlText := aTitlText;
    DialogViewMemo.FMemoText := aMemoText;
    DialogViewMemo.FMrokLabl := aMrokLabl;
    DialogViewMemo.FQuitLabl := aQuitLabl;
    Result := DialogViewMemo.ShowModal;
  finally
    FreeAndNil(DialogViewMemo);
  end;
end;

function EditMemo(aTitlText: string; aMemoText: string; var aTextEdit: string; aMrokLabl: string = ''; aQuitLabl: string = ''): Integer;
begin
  try
    DialogViewMemo := TDialogViewMemo.Create(nil);
    DialogViewMemo.FTitlText := aTitlText;
    DialogViewMemo.FMemoText := aMemoText;
    DialogViewMemo.FMrokLabl := aMrokLabl;
    DialogViewMemo.FQuitLabl := aQuitLabl;
    Result := DialogViewMemo.ShowModal;
    if Result = Mrok then
    begin
      aTextEdit := Trim(DialogViewMemo.Memo_Main.Lines.Text);
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
  self.Color := clWhite;

  Font.Name := '微软雅黑';
  self.Tool_Main.Color := clWhite;

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
  Caption := FTitlText;
  Memo_Main.Lines.Clear;
  Memo_Main.Lines.Add(FMemoText);
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

procedure TDialogViewMemo.FormActivate(Sender: TObject);
begin
  TStylManager.InitFormSize(self.ClassName,self);
end;

procedure TDialogViewMemo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TStylManager.SaveFormSize(self.ClassName,self);
end;

procedure TDialogViewMemo.FormCreate(Sender: TObject);
begin
  self.BorderStyle := bsSizeable;
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

end.
