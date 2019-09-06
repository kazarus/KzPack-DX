unit Dialog_SrvrCnfg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, RzLabel, Vcl.Mask, RzEdit,
  RzBtnEdt, RzButton, Dialog_View,Class_AppCnfg,Helpr_UniEngine, RzRadChk;

type
  TDialogSrvrCnfg = class(TDialogView)
    Labl_1: TRzLabel;
    Labl_2: TRzLabel;
    Edit_SrvrPort: TRzButtonEdit;
    Edit_SrvrAddr: TRzButtonEdit;
    Btnx_Mrok: TRzButton;
    Btnx_Quit: TRzButton;
    Labl_3: TRzLabel;
    Edit_SrvrMemo: TRzButtonEdit;
    Chkb_InUseZIP: TRzCheckBox;
    Chkb_InUseTLS: TRzCheckBox;
    procedure Btnx_MrokClick(Sender: TObject);
    procedure Btnx_QuitClick(Sender: TObject);
  private
    FRealCnfg: TAppCnfg;   //*
  protected
    procedure SetInitialize;override;
    procedure SetCommParams;override;
    procedure SetGridParams;override;
    procedure SetComboItems;override;
    procedure TryFreeAndNil;override;
  public
    function  CheckLicit:string;

    procedure InitCnfg;
    procedure ImptCnfg(var ACnfg:TAppCnfg);
  end;

const
  CONST_MARK_NULL = 'NULL';

const
  CONST_CONFIG_JSON = 'config.json';


var
  DialogSrvrCnfg: TDialogSrvrCnfg;

function ViewSrvrCnfg(var ACnfg:TAppCnfg):Integer;

implementation

uses
  Class_AppUtil,QJSON,Class_KzUtils;

{$R *.dfm}

function ViewSrvrCnfg(var ACnfg:TAppCnfg):Integer;
begin
  try
    DialogSrvrCnfg:=TDialogSrvrCnfg.Create(nil);
    Result:=DialogSrvrCnfg.ShowModal;
    if Result=Mrok then
    begin
      DialogSrvrCnfg.ImptCnfg(ACnfg);
    end;
  finally
    FreeAndNil(DialogSrvrCnfg);
  end;
end;

procedure TDialogSrvrCnfg.Btnx_MrokClick(Sender: TObject);
begin
  if CheckLicit<>CONST_MARK_NULL then
  begin
    ShowMessageFmt('%S',[CheckLicit]);
    Exit;
  end;
  

  ModalResult:=mrOk;
end;

procedure TDialogSrvrCnfg.Btnx_QuitClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

function TDialogSrvrCnfg.CheckLicit: string;
begin
  Result:='NULL';

  if Trim(Edit_SrvrPort.Text)='' then
  begin
    Exit('端口不能为空.');
  end;

  if Trim(Edit_SrvrAddr.Text)='' then
  begin
    Exit('地址不能为空.');
  end;
end;

procedure TDialogSrvrCnfg.ImptCnfg(var ACnfg: TAppCnfg);
begin
  ACnfg.SrvrAddr:=Trim(Edit_SrvrAddr.Text);
  ACnfg.SrvrPort:=Trim(Edit_SrvrPort.Text);
  ACnfg.SrvrMemo:=Trim(Edit_SrvrMemo.Text);
  ACnfg.InUseZIP:=TKzUtils.IfThen(Chkb_InUseZIP.Checked,1,0);
  ACnfg.InUseTLS:=TKzUtils.IfThen(Chkb_InUseTLS.Checked,1,0);
  ACnfg.ToFILE(TKzUtils.ExePath+'config.json');
end;

procedure TDialogSrvrCnfg.InitCnfg;
begin
  if not FileExists(TKzUtils.ExePath+'config.json') then Exit;

  if FRealCnfg=nil then
  begin
    FRealCnfg:=TAppCnfg.Create;
  end;
  FRealCnfg.InFILE(TKzUtils.ExePath+'config.json');

  Edit_SrvrAddr.Text:=FRealCnfg.SrvrAddr;
  Edit_SrvrPort.Text:=FRealCnfg.SrvrPort;
  Edit_SrvrMemo.Text:=FRealCnfg.SrvrMemo;
  Chkb_InUseZIP.Checked:=FRealCnfg.InUseZIP=1;
  Chkb_InUseTLS.Checked:=FRealCnfg.InUseTLS=1;
end;

procedure TDialogSrvrCnfg.SetComboItems;
begin
  inherited;

end;

procedure TDialogSrvrCnfg.SetCommParams;
begin
  inherited;
  Caption:='服务配置';
  Btnx_Mrok.Caption:='确定';
  Btnx_Quit.Caption:='取消';
end;

procedure TDialogSrvrCnfg.SetGridParams;
begin
  inherited;

end;

procedure TDialogSrvrCnfg.SetInitialize;
begin
  inherited;
  InitCnfg;
end;

procedure TDialogSrvrCnfg.TryFreeAndNil;
begin
  inherited;
  if FRealCnfg<>nil then FreeAndNil(FRealCnfg);
  
end;

end.
