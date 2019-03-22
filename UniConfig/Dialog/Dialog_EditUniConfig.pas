unit Dialog_EditUniConfig;
//编辑数据库配置
//#Edit_UnicSrvr


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Dialog_View, RzCmboBx, Mask, RzEdit,Uni,UniConfig,UniConnct,
  RzBtnEdt, RzButton, RzRadChk,DateUtils,StrUtils,Class_FilX, Data.DB, DBAccess;

type
  TDialogEditUniConfigEditMode = (deuemADDV, deuemEDIT, deuemCNFG);

  TDialogEditUniConfig = class(TDialogView)
    Btnx_Mrok: TButton;
    Btnx_Quit: TButton;
    Btnv_Mock: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    Edit_UnicUser: TRzEdit;
    Edit_UnicPswd: TRzEdit;
    Edit_UnicSrvr: TRzEdit;
    Edit_UnicPort: TRzEdit;
    Edit_UnicYear: TRzEdit;
    Comb_Type: TRzComboBox;
    Edit_DataBase: TRzButtonEdit;
    Comb_Mark: TRzComboBox;
    ChkBox_Direct: TRzCheckBox;
    Comb_DataBase: TRzComboBox;
    con1: TUniConnection;
    procedure Btnx_QuitClick(Sender: TObject);
    procedure Btnx_MrokClick(Sender: TObject);
    procedure Edit_DataBaseDblClick(Sender: TObject);
    procedure Edit_DataBaseButtonClick(Sender: TObject);
    procedure Btnv_MockClick(Sender: TObject);
    procedure Edit_UnicSrvrDblClick(Sender: TObject);
    procedure Comb_TypeCloseUp(Sender: TObject);
    procedure Edit_DataBaseAltBtnClick(Sender: TObject);
    procedure Edit_UnicPswdExit(Sender: TObject);
  private
    FRealCnfg: TUniConfig;        //&
    FRealPswd: string;
    FEditMode: TDialogEditUniConfigEditMode;
    FLoadLast: Boolean;          //是否记忆上次配置
    FDefaultExt: string;
    FConnectionMark:string;
  protected
    procedure SetInitialize;override;
    procedure SetComboItems;override;
    procedure SetCommParams;override;
    procedure SetGridParams;override;
    procedure TryFreeAndNil;override;
  public
    procedure ViewPath;
    procedure ViewDataBase(AUnixType:string='');
    function  ChkValid:Boolean;
  public
    procedure InsertDB;
    procedure UpdateDB;
    procedure InitCnfg;
  public
    procedure ReadCnfg;
    procedure ImptCnfg(var aRealCnfg:TUniConfig);
  end;

var
  DialogEditUniConfig: TDialogEditUniConfig;

function ViewEditCnfg(aEditMode: TDialogEditUniConfigEditMode; var aRealCnfg: TUniConfig; aConnectionMark: string = ''; aLoadLast: Boolean = False; aDefaultExt: string = '*.bac|*.bac|*.mdb|*.mdb'): Integer; overload;
function ViewCnfgCnfg(aEditMode: TDialogEditUniConfigEditMode; var aRealCnfg: TUniConfig; aConnectionMark: string = ''; aLoadLast: Boolean = False; aDefaultExt: string = '*.bac|*.bac|*.mdb|*.mdb'): Integer; overload;

implementation
uses
  Class_KzUtils,Helpr_UniEngine;


{$R *.dfm}


function ViewEditCnfg(aEditMode: TDialogEditUniConfigEditMode; var aRealCnfg: TUniConfig; aConnectionMark: string; aLoadLast: Boolean; aDefaultExt: string): Integer;
begin
  try
    DialogEditUniConfig := TDialogEditUniConfig.Create(nil);
    DialogEditUniConfig.FEditMode := aEditMode;
    DialogEditUniConfig.FRealCnfg := aRealCnfg;
    DialogEditUniConfig.FLoadLast := aLoadLast;

    DialogEditUniConfig.BorderStyle := bsSizeable;
    DialogEditUniConfig.FDefaultExt := aDefaultExt;
    DialogEditUniConfig.FConnectionMark := aConnectionMark;

    Result := DialogEditUniConfig.ShowModal;
  finally
    FreeAndNil(DialogEditUniConfig);
  end;
end;

function ViewCnfgCnfg(aEditMode: TDialogEditUniConfigEditMode; var aRealCnfg: TUniConfig; aConnectionMark: string; aLoadLast: Boolean; aDefaultExt: string): Integer; overload;
begin
  try
    DialogEditUniConfig:=TDialogEditUniConfig.Create(nil);
    DialogEditUniConfig.FEditMode := deuemCnfg;
    DialogEditUniConfig.FRealCnfg := aRealCnfg;
    DialogEditUniConfig.FLoadLast := aLoadLast;

    DialogEditUniConfig.FDefaultExt := aDefaultExt;
    DialogEditUniConfig.BorderStyle := bsSizeable;
    DialogEditUniConfig.FConnectionMark := aConnectionMark;

    Result:=DialogEditUniConfig.ShowModal;
    if Result=Mrok then
    begin
      DialogEditUniConfig.ImptCnfg(aRealCnfg);
    end;  
  finally
    FreeAndNil(DialogEditUniConfig);
  end;
end;  


procedure TDialogEditUniConfig.Btnx_QuitClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TDialogEditUniConfig.Btnx_MrokClick(Sender: TObject);
begin
  if not ChkValid then Exit;
  
  case FEditMode of
    deuemAddv:
    begin
      InsertDB;
    end;
    deuemEdit:
    begin
      UpdateDB;
    end;
    deuemCnfg:
    begin
      ReadCnfg;
    end;   
  end;

  ModalResult:=mrOk;
end;

procedure TDialogEditUniConfig.InsertDB;
var
  cUniC: TUniConnection;
begin
  try
    cUniC:=UniConnctEx.GetConnection(FConnectionMark);

    if FRealCnfg = nil then Exit;

    FRealCnfg.UnicIndx := FRealCnfg.GetNextIdex(cUniC);
    FRealCnfg.UnicType := Comb_Type.Text;
    FRealCnfg.UnicUser := Edit_UnicUser.Text;
    FRealCnfg.UnicPswd := Edit_UnicPswd.Text;
    FRealCnfg.UnicSrvr := Edit_UnicSrvr.Text;
    FRealCnfg.DataBase := Comb_DataBase.Text;
    FRealCnfg.UnicPort := Edit_UnicPort.Text;
    FRealCnfg.UnicYear := StrToIntDef(Edit_UnicYear.Text, 0);
    FRealCnfg.UnicMark := Comb_Mark.Text;
    FRealCnfg.IsDirect:=0;
    if ChkBox_Direct.Checked then
    begin
      FRealCnfg.IsDirect:=1;
    end;
    FRealCnfg.UnicOrdr:=FRealCnfg.UnicIndx;


    if Assigned(UniConnctEx.OnUniConfigCustomGetUnixMemo) then
    begin
      UniConnctEx.OnUniConfigCustomGetUnixMemo(FRealCnfg,FRealCnfg.FUnicMemo);
    end;

    if Assigned(UniConnctEx.OnUniConfigCustomEncryptEvent) then
    begin
      UniConnctEx.OnUniConfigCustomEncryptEvent(FRealCnfg,FRealCnfg);
    end;

    FRealCnfg.InsertDB(cUniC);

    if FLoadLast then
    begin
      if FRealCnfg <> nil then
      begin
        FRealCnfg.ToFILE(TKzUtils.ExePath+Format('config-default-%s.json',[LowerCase(FRealCnfg.UnicType)]));
      end;
    end;
  finally
    FreeAndNil(cUniC);
  end;
end;

procedure TDialogEditUniConfig.SetCommParams;
begin
  inherited;
  Caption := '数据连接';
  Edit_UnicPswd.PasswordChar := '*';
  Edit_UnicYear.Text := IntToStr(YearOf(Now));

  if FEditMode=deuemCnfg then
  begin
    Edit_UnicYear.Clear;
    Edit_UnicYear.Enabled := False;
    Comb_Mark.Enabled := False;
  end;
end;

procedure TDialogEditUniConfig.SetGridParams;
begin
  inherited;

end;

procedure TDialogEditUniConfig.SetInitialize;
begin
  inherited;

  if FLoadLast then
  begin
    if FRealCnfg = nil then
    begin
      FRealCnfg := TUniConfig.Create;
    end;
    if FileExists(TKzUtils.ExePath+'config-default.json') then
    begin
      FRealCnfg.InFILE(TKzUtils.ExePath+'config-default.json');
    end;
  end;

  InitCnfg;
end;

procedure TDialogEditUniConfig.UpdateDB;
var
  cUniC:TUniConnection;
begin
  try
    cUniC := UniConnctEx.GetConnection(FConnectionMark);

    FRealCnfg.UnicType := Comb_Type.Text;
    FRealCnfg.UnicUser := Edit_UnicUser.Text;
    FRealCnfg.UnicPswd := Edit_UnicPswd.Text;
    FRealCnfg.UnicSrvr := Edit_UnicSrvr.Text;
    FRealCnfg.DataBase := Comb_DataBase.Text;
    FRealCnfg.UnicPort := Edit_UnicPort.Text;
    FRealCnfg.UnicYear := StrToIntDef(Edit_UnicYear.Text, 0);
    FRealCnfg.UnicMark := Comb_Mark.Text;
    FRealCnfg.IsDirect := 0;
    if ChkBox_Direct.Checked then
    begin
      FRealCnfg.IsDirect:=1;
    end;

    if Assigned(UniConnctEx.OnUniConfigCustomGetUnixMemo) then
    begin
      UniConnctEx.OnUniConfigCustomGetUnixMemo(FRealCnfg,FRealCnfg.FUnicMemo);
    end;

    FRealCnfg.UnicPswd:=FRealPswd;
    if Assigned(UniConnctEx.OnUniConfigCustomEncryptEvent) then
    begin
      UniConnctEx.OnUniConfigCustomEncryptEvent(FRealCnfg,FRealCnfg);
    end;

    FRealCnfg.UpdateDB(cUniC);
  finally
    FreeAndNil(cUniC);
  end;
end;

procedure TDialogEditUniConfig.SetComboItems;
begin
  Comb_Type.Items.Clear;

  //Comb_Type.Add(CONST_PROVIDER_SQLITE);
  Comb_Type.Add(CONST_PROVIDER_ACCESS);
  Comb_Type.Add(CONST_PROVIDER_SQLSRV);    
  Comb_Type.Add(CONST_PROVIDER_ORACLE);
  Comb_Type.Add(CONST_PROVIDER_MYSQLX);
  Comb_Type.Add(CONST_PROVIDER_POSTGR);
  Comb_Type.Style:=csDropDownList;
  Comb_Type.ItemIndex:=0;
  Comb_TypeCloseUp(Comb_Type);

  Comb_Mark.Items.Clear;
  Comb_Mark.Style:=csDropDownList;

  //YXC_2012_07_10_20_33_13_<
  if UniConnctEx.ConnctMark<>'' then
  begin
    Comb_Mark.Items.Delimiter:=',';
    Comb_Mark.Items.DelimitedText:=UniConnctEx.ConnctMark;
  end;  
  {if Assigned(FOnUnicMarkEvent) then
  begin
    FOnUnicMarkEvent(Comb_Mark);
  end;}
  //YXC_2012_07_10_20_33_15_>
  
  Comb_Mark.ItemIndex:=0;
end;

procedure TDialogEditUniConfig.InitCnfg;
begin
  if FRealCnfg = nil then Exit;

  Comb_Type.ItemIndex := Comb_Type.Items.IndexOf(FRealCnfg.UnicType);
  Comb_TypeCloseUp(Comb_Type);

  Edit_UnicYear.Text := Format('%D',[FRealCnfg.UnicYear]);
  Edit_UnicUser.Text := FRealCnfg.UnicUser;

  if Assigned(UniConnctEx.OnUniConfigCustomDecryptEvent) then
  begin
    UniConnctEx.OnUniConfigCustomDecryptEvent(FRealCnfg, FRealCnfg);
  end;
  FRealPswd := FRealCnfg.UnicPswd;
  Edit_UnicPswd.Text := FRealPswd;

  Edit_UnicSrvr.Text := FRealCnfg.UnicSrvr;
  Comb_DataBase.Text := FRealCnfg.DataBase;
  Edit_UnicPort.Text := FRealCnfg.UnicPort;
  Comb_Mark.ItemIndex := Comb_Mark.Items.IndexOf(FRealCnfg.UnicMark);

  ChkBox_Direct.Checked := False;
  if FRealCnfg.IsDirect = 1 then
  begin
    ChkBox_Direct.Checked := True;
  end;
end;

procedure TDialogEditUniConfig.Edit_DataBaseDblClick(Sender: TObject);
begin
  inherited;
  ViewPath;
end;

procedure TDialogEditUniConfig.ViewPath;
var
  OD:TOpenDialog;
  cRoot:string;
  cPath:string;
begin
  if Trim(Comb_Type.Text) = CONST_PROVIDER_ACCESS then
  begin
    OD := TOpenDialog.Create(nil);

    if FDefaultExt <> '' then
    begin
      OD.Filter := FDefaultExt;
    end else
    begin
      OD.Filter := '*.mdb|*.mdb|*.bac|*.bac';
    end;


    cRoot := Trim(Comb_DataBase.Text);
    if (cRoot <> '') and (Pos('\\', cRoot) < 0) then
    begin
      cPath := ExtractFileDir(Comb_DataBase.Text);
      OD.InitialDir := cPath;
    end;

    if OD.Execute then
    begin
      Comb_DataBase.Text := OD.FileName;
    end;
    FreeAndNil(OD);
  end;
end;

procedure TDialogEditUniConfig.Edit_DataBaseButtonClick(Sender: TObject);
begin
  inherited;
  ViewPath;
end;

procedure TDialogEditUniConfig.Btnv_MockClick(Sender: TObject);
var
  CnfgA:TUniConfig;
begin
  inherited;
  if not ChkValid then Exit;

  try
    CnfgA:=TUniConfig.Create;
    CnfgA.UnicType := Comb_Type.Text;
    CnfgA.UnicUser := Edit_UnicUser.Text;

    if FEditMode = deuemEdit then
    begin
      CnfgA.UnicPswd := FRealPswd;
    end else
    begin
      CnfgA.UnicPswd := Edit_UnicPswd.Text;
    end;

    CnfgA.UnicSrvr := Edit_UnicSrvr.Text;
    CnfgA.DataBase := Comb_DataBase.Text;
    CnfgA.UnicPort := Edit_UnicPort.Text;
    CnfgA.UnicYear := StrToIntDef(Edit_UnicYear.Text, 0);
    CnfgA.UnicMark := Comb_Mark.Text;

    CnfgA.IsDirect := 0;
    if ChkBox_Direct.Checked then
    begin
      CnfgA.IsDirect := 1;
    end;

    if not CnfgA.TstConnection(CnfgA) then  Exit;

    TKzUtils.ShowMsg('该数据库连接有效.');
  finally
    FreeAndNil(CnfgA);
  end;
end;

procedure TDialogEditUniConfig.ViewDataBase(AUnixType:string);
var
  cList: TStringList;
  cUniC: TUniConnection;
begin
  inherited;
  Screen.Cursor:=crSQLWait;
  
  Comb_DataBase.Items.Clear;
  try
    cList:=TStringList.Create;

    cUniC:=TUniConnection.Create(nil);
    cUniC.LoginPrompt :=False;

    if Trim(AUnixType)='' then
    begin
      cUniC.ProviderName:=CONST_PROVIDER_SQLSRV;
    end else
    begin
      cUniC.ProviderName:=AUnixType;
    end;

    cUniC.Username    :=Trim(Edit_UnicUser.Text);
    cUniC.Password    :=Trim(Edit_UnicPswd.Text);
    cUniC.Server      :=Trim(Edit_UnicSrvr.Text);
    cUniC.Port        :=StrToIntDef(Trim(Edit_UnicPort.Text),0);
    
    cUniC.SpecificOptions.Add('SQL Server.ConnectionTimeout=3');
    cUniC.SpecificOptions.Add('SQL Server.OLEDBProvider=prSQL');

    try
      cUniC.Connected:=True;
      cUniC.GetDatabaseNames(cList);

      Comb_DataBase.Items.AddStrings(cList);
      Comb_DataBase.DropDownCount := cList.Count;
    except
      on E:Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(cList);
    FreeAndNil(cUniC);
    
    Screen.Cursor:=crDefault;
  end;
end;

procedure TDialogEditUniConfig.Edit_UnicSrvrDblClick(Sender: TObject);
begin
  inherited;
  ViewDataBase(Comb_Type.Text);
end;

procedure TDialogEditUniConfig.TryFreeAndNil;
begin
  inherited;
  //YXC_2014_06_20_09_14_13
  {if FEditMode=deuemCnfg then
  begin
    if FRealCnfg<>nil then
    begin
      FreeAndNil(FRealCnfg);
    end;
  end;}
end;

procedure TDialogEditUniConfig.ImptCnfg(var aRealCnfg: TUniConfig);
begin
  if aRealCnfg = nil then Exit;
  if FRealCnfg = nil then Exit;

  TUniConfig.CopyIt(FRealCnfg,aRealCnfg);
end;

procedure TDialogEditUniConfig.ReadCnfg;
var
  I: Integer;
  DataBase: TDataBase;
begin
  if FRealCnfg = nil then
  begin
    FRealCnfg := TUniConfig.Create;
  end;
  FRealCnfg.UnicIndx := 0;

  FRealCnfg.UnicType := Comb_Type.Text;
  FRealCnfg.UnicUser := Edit_UnicUser.Text;
  FRealCnfg.UnicPswd := Edit_UnicPswd.Text;
  FRealCnfg.UnicSrvr := Edit_UnicSrvr.Text;
  FRealCnfg.DataBase := Comb_DataBase.Text;
  FRealCnfg.UnicPort := Edit_UnicPort.Text;
  FRealCnfg.UnicYear := StrToIntDef(Edit_UnicYear.Text, 0);
  FRealCnfg.UnicMark := Comb_Mark.Text;
  FRealCnfg.IsDirect := 0;
  if ChkBox_Direct.Checked then
  begin
    FRealCnfg.IsDirect := 1;
  end;
  FRealCnfg.UnicOrdr := FRealCnfg.UnicIndx;

  if FLoadLast then
  begin
    if FRealCnfg <> nil then
    begin
      //
      if FRealCnfg.ListDATA = nil then
      begin
        FRealCnfg.ListDATA := TCollection.Create(TDataBase);
      end;
      TKzUtils.JustCleanList(FRealCnfg.FListDATA);

      if (Comb_DataBase.Items.Count > 0) then
      begin
        for I := 0 to Comb_DataBase.Items.Count-1 do
        begin
          DataBase := TDataBase(FRealCnfg.ListDATA.Add);
          DataBase.DataBase := Comb_DataBase.Items.Strings[I];
        end;
      end;

      FRealCnfg.ToFILE(TKzUtils.ExePath+Format('config-default-%s.json',[LowerCase(FRealCnfg.UnicType)]));
    end;
  end;
end;

function TDialogEditUniConfig.ChkValid: Boolean;
begin
  Result := False;

  if Comb_Type.Text = CONST_PROVIDER_SQLSRV then
  begin
    if Trim(Comb_DataBase.Text) = '' then
    begin
      TKzUtils.WarnMsg('请填写数据库.');
      Exit;
    end;
  end;

  Result := True;
end;

procedure TDialogEditUniConfig.Comb_TypeCloseUp(Sender: TObject);
begin
  inherited;
  Edit_UnicYear.Enabled := True;
  Edit_UnicUser.Enabled := True;
  Edit_UnicPswd.Enabled := True;
  Edit_UnicSrvr.Enabled := True;
  Edit_UnicPort.Enabled := True;
  Edit_UnicPort.Enabled := True;
  Edit_DataBase.Enabled := True;

  ChkBox_Direct.Checked := False;
  ChkBox_Direct.Visible := False;

  if (Trim(Comb_Type.Text) = CONST_PROVIDER_ACCESS) or (Trim(Comb_Type.Text) = CONST_PROVIDER_SQLITE) then
  begin
    Caption:='数据连接';
      
    Edit_UnicUser.Enabled := False;
    Edit_UnicUser.Clear;
    Edit_UnicPswd.Enabled := False;
    Edit_UnicPswd.Clear;
    Edit_UnicSrvr.Enabled := False;
    Edit_UnicSrvr.Clear;
    Edit_UnicPort.Enabled := False;
    Edit_UnicPort.Clear;

  end else
  if Trim(Comb_Type.Text)=CONST_PROVIDER_SQLSRV then
  begin
    Caption:='提示:双击服务器框,加载服务器.';

    if FileExists(TKzUtils.ExePath+'kazarus') then
    begin
      Edit_UnicUser.Text := 'sa';
      Edit_UnicPswd.Text := 'sa@nbyt';
      Edit_UnicSrvr.Text := '.';
      Edit_UnicPort.Text := '1433';
    end;

  end else
  if Trim(Comb_Type.Text)=CONST_PROVIDER_POSTGR then
  begin
    Caption:='提示:双击服务器框,加载服务器.';

    if FileExists(TKzUtils.ExePath+'kazarus') then
    begin
      Edit_UnicUser.Text := 'postgres';
      Edit_UnicPswd.Text := 'root';
      Edit_UnicSrvr.Text := 'localhost';
      Edit_UnicPort.Text := '5432';
    end;

  end else
  if Trim(Comb_Type.Text)=CONST_PROVIDER_ORACLE then
  begin
    Caption:='直联示例:IP地址:端口:实例名';
    
    Edit_UnicPort.Text := '1521';
    ChkBox_Direct.Visible := True;
    ChkBox_Direct.Checked := True;

    Edit_UnicUser.Clear;
    Edit_UnicPswd.Clear;
    Edit_UnicSrvr.Clear;
  end else
  if Trim(Comb_Type.Text)=CONST_PROVIDER_MYSQLX then
  begin
    Caption:='数据连接';

    {#if FEditMode=deuemAddv then
    begin
      ViewDataBase(CONST_PROVIDER_MYSQLX);
    end;}
  end;

  if FLoadLast then
  begin
    if FRealCnfg = nil then
    begin
      FRealCnfg := TUniConfig.Create;
    end;
    if FileExists(TKzUtils.ExePath+Format('config-default-%s.json',[LowerCase(Comb_Type.Text)])) then
    begin
      FRealCnfg.InFILE(TKzUtils.ExePath+Format('config-default-%s.json',[LowerCase(Comb_Type.Text)]));
      //@InitCnfg;
    end;
  end;
end;

procedure TDialogEditUniConfig.Edit_DataBaseAltBtnClick(Sender: TObject);
var
  SD:TSaveDialog;
  FilePath:string;
begin
  try
    SD:=TSaveDialog.Create(nil);
    if SD.Execute then
    begin
      FilePath:=SD.FileName;
      if UpperCase(RightStr(FilePath,4))<>'.mdb' then
      begin
        FilePath:=FilePath + '.mdb';
        //@TBuildMdb.BuildMdb(FilePath);
      end;
    end;
  finally
    FreeAndNil(SD);
  end;
end;

procedure TDialogEditUniConfig.Edit_UnicPswdExit(Sender: TObject);
begin
  inherited;
  if FEditMode=deuemEdit then
  begin
    FRealPswd:=TRzEdit(Sender).Text;
  end;
end;

end.
