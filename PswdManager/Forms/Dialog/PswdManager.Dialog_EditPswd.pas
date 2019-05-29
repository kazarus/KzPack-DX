unit PswdManager.Dialog_EditPSWD;


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PswdManager, Dialog_View,
  Vcl.StdCtrls, Vcl.Mask, RzEdit, RzBtnEdt, RzLabel, RzButton, Vcl.ExtCtrls,
  RzPanel, PswdManager.Class_User, RzRadChk;

type
  TDialogEditPSWD = class(TDialogView)
    Edit_UserName: TRzButtonEdit;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    Edit_UserCode: TRzButtonEdit;
    Edit_PassWord: TRzButtonEdit;
    Edit_ChangeMM: TRzButtonEdit;
    Edit_UpdateMM: TRzButtonEdit;
    Panl_Main: TRzPanel;
    Btnv_Mrok: TRzButton;
    Btnv_Quit: TRzButton;
    Chkb_ShowPSWD: TRzCheckBox;
    RzLabel1: TRzLabel;
    RzLabel7: TRzLabel;
    procedure Btnv_QuitClick(Sender: TObject);
    procedure Btnv_MrokClick(Sender: TObject);
    procedure Chkb_ShowPSWDClick(Sender: TObject);
  private
    FRealUSER: TUSER4PSWD;
  protected
    procedure SetInitialize;override;
    procedure SetCommParams;override;
    procedure SetGridParams;override;
    procedure SetComboItems;override;
    procedure TryFreeAndNil;override;
  public
    procedure InitUSER;
    procedure ReadUSER(var aUSER: TUSER4PSWD);
  end;

var
  DialogEditPSWD: TDialogEditPSWD;

function ViewEditPSWD(var aUSER: TUSER4PSWD; mustLevel: TPasswordStrongLevel = pslStrong): Integer;

implementation

uses
  Class_KzUtils;

{$R *.dfm}

function ViewEditPSWD(var aUSER: TUSER4PSWD; mustLevel: TPasswordStrongLevel = pslStrong): Integer;
begin
  try
    DialogEditPSWD := TDialogEditPSWD.Create(nil);
    DialogEditPSWD.FRealUSER := aUSER;
    Result := DialogEditPSWD.ShowModal;

    if Result = Mrok then
    begin
      DialogEditPSWD.ReadUSER(aUSER);
    end;
  finally
    FreeAndNil(DialogEditPSWD);
  end;
end;

procedure TDialogEditPSWD.Btnv_MrokClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TDialogEditPSWD.Btnv_QuitClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TDialogEditPSWD.Chkb_ShowPSWDClick(Sender: TObject);
begin
  if TRzCheckBox(Sender).Checked then
  begin
    Edit_PassWord.PasswordChar := #0;
    Edit_ChangeMM.PasswordChar := #0;
    Edit_UpdateMM.PasswordChar := #0;
  end else
  begin
    Edit_PassWord.PasswordChar := '*';
    Edit_ChangeMM.PasswordChar := '*';
    Edit_UpdateMM.PasswordChar := '*';
  end;
end;

procedure TDialogEditPSWD.InitUSER;
begin
  Edit_UserName.Text := FRealUSER.UserName;
  Edit_UserCode.Text := FRealUSER.UserCode;
  Edit_PassWord.Text := FRealUSER.PassWord;
end;

procedure TDialogEditPSWD.ReadUSER(var aUSER: TUSER4PSWD);
begin
  aUSER.UpdateMM := Trim(Edit_UpdateMM.Text);
end;

procedure TDialogEditPSWD.SetComboItems;
begin
  inherited;

end;

procedure TDialogEditPSWD.SetCommParams;
begin
  inherited;
  Caption := '密码修改';
  Font.Name := '微软雅黑';
  Font.Size := 9;
  Btnv_Mrok.Caption := '确认';
  Btnv_Quit.Caption := '取消';
  self.Color := clWhite;
  self.Panl_Main.Color := clWhite;

  Edit_UserName.ReadOnly := True;
  Edit_UserCode.ReadOnly := True;
  Edit_PassWord.ReadOnly := True;

  Edit_PassWord.PasswordChar := '*';
  Edit_ChangeMM.PasswordChar := '*';
  Edit_UpdateMM.PasswordChar := '*';
end;

procedure TDialogEditPSWD.SetGridParams;
begin
  inherited;

end;

procedure TDialogEditPSWD.SetInitialize;
begin
  inherited;
  InitUSER;
end;

procedure TDialogEditPSWD.TryFreeAndNil;
begin
  inherited;

end;

end.
