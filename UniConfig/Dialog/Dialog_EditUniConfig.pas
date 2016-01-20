unit Dialog_EditUniConfig;
//编辑数据库配置
//YXC_2012_09_05_14_25_21_setcomboitems.


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Dialog_View, RzCmboBx, Mask, RzEdit,Uni,UniConfig,UniConnct,
  RzBtnEdt, RzButton, RzRadChk,DateUtils,StrUtils,Class_FilX;

type
  TDialogEditUniConfigEditMode=(deuemAddx,deuemEdit,deuemCnfg);

  TDialogEditUniConfig = class(TDialogView)
    Btnx_Mrok: TButton;
    Btnx_Quit: TButton;
    Btnx_Test: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    Edit_UnixUser: TRzEdit;
    Edit_UnixPswd: TRzEdit;
    Edit_UnixServ: TRzEdit;
    Edit_UnixPort: TRzEdit;
    Edit_UnixYear: TRzEdit;
    Comb_Type: TRzComboBox;
    Edit_DataBase: TRzButtonEdit;
    Comb_Mark: TRzComboBox;
    ChkBox_Direct: TRzCheckBox;
    Comb_DataBase: TRzComboBox;
    procedure Btnx_QuitClick(Sender: TObject);
    procedure Btnx_MrokClick(Sender: TObject);
    procedure Edit_DataBaseDblClick(Sender: TObject);
    procedure Edit_DataBaseButtonClick(Sender: TObject);
    procedure Btnx_TestClick(Sender: TObject);
    procedure Edit_UnixServDblClick(Sender: TObject);
    procedure Comb_TypeCloseUp(Sender: TObject);
    procedure Edit_DataBaseAltBtnClick(Sender: TObject);
    procedure Edit_UnixPswdExit(Sender: TObject);
  private
    FRealCnfg:TUniConfig;
    FRealPswd:string;
    FEditMode:TDialogEditUniConfigEditMode;

    //YXC_2014_04_28_10_43_31
    FConnectionMark:string;    
  protected
    procedure SetInitialize;override;
    procedure SetComboItems;override;
    procedure SetCommParams;override;
    procedure SetGridParams;override;
    procedure TryFreeAndNil;override;
  public
    procedure ViewFilePath;
    procedure ViewDataBase(AUnixType:string='');
    function  CheckLicit:Boolean; 
  public
    procedure InsertDB;
    procedure UpdateDB;
    procedure ReadCnfg;
    procedure InitCnfg;
    procedure ImptCnfg(var ACnfg:TUniConfig);
  end;

var
  DialogEditUniConfig: TDialogEditUniConfig;

function ViewEditCnfg(AEditMode:TDialogEditUniConfigEditMode;ACnfg:TUniConfig;AConnectionMark:string=''):Integer;overload;
function ViewCnfgCnfg(AEditMode:TDialogEditUniConfigEditMode;var ACnfg:TUniConfig;AConnectionMark:string=''):Integer;overload;

implementation


{$R *.dfm}


function ViewEditCnfg(AEditMode:TDialogEditUniConfigEditMode;ACnfg:TUniConfig;AConnectionMark:string):Integer;
begin
  try
    DialogEditUniConfig:=TDialogEditUniConfig.Create(nil);
    DialogEditUniConfig.FEditMode:=AEditMode;
    DialogEditUniConfig.FRealCnfg:=ACnfg;
    DialogEditUniConfig.FConnectionMark:=AConnectionMark;
    DialogEditUniConfig.BorderStyle:=bsSizeable;
    Result:=DialogEditUniConfig.ShowModal;
  finally
    FreeAndNil(DialogEditUniConfig);
  end;
end;

function ViewCnfgCnfg(AEditMode:TDialogEditUniConfigEditMode;var ACnfg:TUniConfig;AConnectionMark:string):Integer;overload;
begin
  try
    DialogEditUniConfig:=TDialogEditUniConfig.Create(nil);
    DialogEditUniConfig.FEditMode:=deuemCnfg;
    DialogEditUniConfig.FRealCnfg:=ACnfg;
    DialogEditUniConfig.FConnectionMark:=AConnectionMark;
        
    Result:=DialogEditUniConfig.ShowModal;
    if Result=Mrok then
    begin
      DialogEditUniConfig.ImptCnfg(ACnfg);
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
  if not CheckLicit then Exit;
  
  case FEditMode of
    deuemAddx:
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
  UniConnct:TUniConnection;
begin
  try
    UniConnct:=UniConnctEx.GetConnection(FConnectionMark);

    if FRealCnfg=nil then
    begin
      FRealCnfg:=TUniConfig.Create;
    end;

    FRealCnfg.UnixIdex:=FRealCnfg.GetNextIdex(UniConnct);
    FRealCnfg.UnixType:=Comb_Type.Text;
    FRealCnfg.UnixUser:=Edit_UnixUser.Text;
    FRealCnfg.UnixPswd:=Edit_UnixPswd.Text;
    FRealCnfg.UnixServ:=Edit_UnixServ.Text;

    //YXC_2012_12_04_09_36_39_<
    if (FRealCnfg.UnixType=CONST_PROVIDER_SQLSRV) or (FRealCnfg.UnixType=CONST_PROVIDER_MYSQLX) then
    begin
      FRealCnfg.DataBase:=Comb_DataBase.Text;
    end else
    begin
      FRealCnfg.DataBase:=Edit_DataBase.Text;
    end;
    //YXC_2012_12_04_09_36_46_>

    FRealCnfg.UnixPort:=Edit_UnixPort.Text;
    FRealCnfg.UnixYear:=StrToIntDef(Edit_UnixYear.Text,0);
    FRealCnfg.UnixMark:=Comb_Mark.Text;
    FRealCnfg.IsDirect:=0;
    if ChkBox_Direct.Checked then
    begin
      FRealCnfg.IsDirect:=1;
    end;
    FRealCnfg.UnixOrdr:=FRealCnfg.UnixIdex;


    if Assigned(UniConnctEx.OnUniConfigCustomGetUnixMemo) then
    begin
      UniConnctEx.OnUniConfigCustomGetUnixMemo(FRealCnfg,FRealCnfg.FUnixMemo);
    end;

    if Assigned(UniConnctEx.OnUniConfigCustomEncryptEvent) then
    begin
      UniConnctEx.OnUniConfigCustomEncryptEvent(FRealCnfg,FRealCnfg);
    end;

    FRealCnfg.InsertDB(UniConnct);
  finally
    FreeAndNil(UniConnct);
    FreeAndNil(FRealCnfg);
  end;
end;

procedure TDialogEditUniConfig.SetCommParams;
begin
  inherited;
  Caption:='数据连接';
  Edit_UnixPswd.PasswordChar:='*';
  Edit_UnixYear.Text:=IntToStr(YearOf(Now));

  if FEditMode=deuemCnfg then
  begin
    Edit_UnixYear.Clear;
    Edit_UnixYear.Enabled:=False;
    Comb_Mark.Enabled:=False;
  end;  
end;

procedure TDialogEditUniConfig.SetGridParams;
begin
  inherited;

end;

procedure TDialogEditUniConfig.SetInitialize;
begin
  inherited;

  InitCnfg;
end;

procedure TDialogEditUniConfig.UpdateDB;
var
  UniConnct:TUniConnection;
begin
  try
    UniConnct:=UniConnctEx.GetConnection(FConnectionMark);

    FRealCnfg.UnixType:=Comb_Type.Text;
    FRealCnfg.UnixUser:=Edit_UnixUser.Text;
    FRealCnfg.UnixPswd:=Edit_UnixPswd.Text;
    FRealCnfg.UnixServ:=Edit_UnixServ.Text;

    //YXC_2012_12_04_09_36_39_<
    if (FRealCnfg.UnixType=CONST_PROVIDER_SQLSRV) or (FRealCnfg.UnixType=CONST_PROVIDER_MYSQLX) then
    begin
      FRealCnfg.DataBase:=Comb_DataBase.Text;
    end else
    begin
      FRealCnfg.DataBase:=Edit_DataBase.Text;
    end;
    //YXC_2012_12_04_09_36_46_>

    FRealCnfg.UnixPort:=Edit_UnixPort.Text;
    FRealCnfg.UnixYear:=StrToIntDef(Edit_UnixYear.Text,0);
    FRealCnfg.UnixMark:=Comb_Mark.Text;
    FRealCnfg.IsDirect:=0;
    if ChkBox_Direct.Checked then
    begin
      FRealCnfg.IsDirect:=1;
    end;

    if Assigned(UniConnctEx.OnUniConfigCustomGetUnixMemo) then
    begin
      UniConnctEx.OnUniConfigCustomGetUnixMemo(FRealCnfg,FRealCnfg.FUnixMemo);
    end;

    FRealCnfg.UnixPswd:=FRealPswd;
    if Assigned(UniConnctEx.OnUniConfigCustomEncryptEvent) then
    begin
      UniConnctEx.OnUniConfigCustomEncryptEvent(FRealCnfg,FRealCnfg);
    end;

    FRealCnfg.UpdateDB(UniConnct);
  finally
    FreeAndNil(UniConnct);
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
  {if Assigned(FOnUnixMarkEvent) then
  begin
    FOnUnixMarkEvent(Comb_Mark);
  end;}
  //YXC_2012_07_10_20_33_15_>
  
  Comb_Mark.ItemIndex:=0;
end;

procedure TDialogEditUniConfig.InitCnfg;
begin
  if FRealCnfg<>nil then
  begin
    Comb_Type.ItemIndex:=Comb_Type.Items.IndexOf(FRealCnfg.UnixType);
    Comb_TypeCloseUp(Comb_Type);

    Edit_UnixYear.Text:=IntToStr(FRealCnfg.UnixYear);
    Edit_UnixUser.Text:=FRealCnfg.UnixUser;

    if Assigned(UniConnctEx.OnUniConfigCustomDecryptEvent) then
    begin
      UniConnctEx.OnUniConfigCustomDecryptEvent(FRealCnfg,FRealCnfg);
    end;
    FRealPswd:=FRealCnfg.UnixPswd;
    Edit_UnixPswd.Text:='helloworld';

    Edit_UnixServ.Text:=FRealCnfg.UnixServ;

    //YXC_2012_12_04_09_39_28_<
    if FRealCnfg.UnixType=UniConfig.CONST_PROVIDER_SQLSRV then
    begin
      Comb_DataBase.Text:=FRealCnfg.DataBase;
    end else
    begin
      Edit_DataBase.Text:=FRealCnfg.DataBase;
    end;    
    //YXC_2012_12_04_09_39_28_>

    Edit_UnixPort.Text:=FRealCnfg.UnixPort;
    
    Comb_Mark.ItemIndex:=Comb_Mark.Items.IndexOf(FRealCnfg.UnixMark);

    ChkBox_Direct.Checked:=False;
    if FRealCnfg.IsDirect=1 then
    begin
      ChkBox_Direct.Checked:=True;
    end;  
  end;  
end;

procedure TDialogEditUniConfig.Edit_DataBaseDblClick(Sender: TObject);
begin
  inherited;
  ViewFilePath;
end;

procedure TDialogEditUniConfig.ViewFilePath;
var
  OD:TOpenDialog;
  PathA:string;
begin
  if Trim(Comb_Type.Text)=CONST_PROVIDER_ACCESS then
  begin
    OD:=TOpenDialog.Create(nil);
    OD.Filter:='*.mdb';

    if Trim(Edit_DataBase.Text)<>'' then
    begin
      PathA:=ExtractFileDir(Edit_DataBase.Text);
      OD.InitialDir:=PathA;
    end;  

    if OD.Execute then
    begin
      Edit_DataBase.Text:=OD.FileName;
    end;  
    FreeAndNil(OD);
  end;  
end;

procedure TDialogEditUniConfig.Edit_DataBaseButtonClick(Sender: TObject);
begin
  inherited;
  ViewFilePath;
end;

procedure TDialogEditUniConfig.Btnx_TestClick(Sender: TObject);
var
  DateA:TDateTime;
  CnfgA:TUniConfig;
begin
  inherited;
  if not CheckLicit then Exit;
    
  try
    CnfgA:=TUniConfig.Create;
    CnfgA.UnixType:=Comb_Type.Text;
    CnfgA.UnixUser:=Edit_UnixUser.Text;

    if FEditMode = deuemEdit then
    begin
      CnfgA.UnixPswd:=FRealPswd;
    end else
    begin
      CnfgA.UnixPswd:=Edit_UnixPswd.Text;
    end;

    CnfgA.UnixServ:=Edit_UnixServ.Text;

    //YXC_2012_12_04_09_36_39_<
    if (CnfgA.UnixType=CONST_PROVIDER_SQLSRV) or (CnfgA.UnixType=CONST_PROVIDER_MYSQLX) then
    begin
      CnfgA.DataBase:=Comb_DataBase.Text;
    end else
    begin
      CnfgA.DataBase:=Edit_DataBase.Text;
    end;
    //YXC_2012_12_04_09_36_46_>
    
    CnfgA.UnixPort:=Edit_UnixPort.Text;
    CnfgA.UnixYear:=StrToIntDef(Edit_UnixYear.Text,0);
    CnfgA.UnixMark:=Comb_Mark.Text;
    
    CnfgA.IsDirect:=0;
    if ChkBox_Direct.Checked then
    begin
      CnfgA.IsDirect:=1;
    end;

    if not CnfgA.TstConnection(CnfgA) then  Exit;

    ShowMessage('该数据库连接有效.');
  finally
    FreeAndNil(CnfgA);
  end;
end;

procedure TDialogEditUniConfig.ViewDataBase(AUnixType:string);
var
  ListA:TStringList;
  UniConnct:TUniConnection;
begin
  inherited;
  Screen.Cursor:=crSQLWait;
  
  Comb_DataBase.Items.Clear;
  try
    ListA:=TStringList.Create;

    UniConnct:=TUniConnection.Create(nil);
    UniConnct.LoginPrompt :=False;

    if Trim(AUnixType)='' then
    begin
      UniConnct.ProviderName:=CONST_PROVIDER_SQLSRV;
    end else
    begin
      UniConnct.ProviderName:=AUnixType;
    end;

    UniConnct.Username    :=Trim(Edit_UnixUser.Text);
    UniConnct.Password    :=Trim(Edit_UnixPswd.Text);
    UniConnct.Server      :=Trim(Edit_UnixServ.Text);
    UniConnct.Port        :=StrToIntDef(Trim(Edit_UnixPort.Text),0);
    
    UniConnct.SpecificOptions.Add('SQL Server.ConnectionTimeout=3');
    UniConnct.SpecificOptions.Add('SQL Server.OLEDBProvider=prSQL');

    try
      UniConnct.Connected:=True;
      UniConnct.GetDatabaseNames(ListA);

      Comb_DataBase.Items.AddStrings(ListA);
    except
      on E:Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(ListA);
    FreeAndNil(UniConnct);
    
    Screen.Cursor:=crDefault;
  end;
end;

procedure TDialogEditUniConfig.Edit_UnixServDblClick(Sender: TObject);
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

procedure TDialogEditUniConfig.ImptCnfg(var ACnfg: TUniConfig);
begin
  if ACnfg    =nil then Exit;
  if FRealCnfg=nil then Exit;

  TUniConfig.CopyIt(FRealCnfg,ACnfg);
end;

procedure TDialogEditUniConfig.ReadCnfg;
begin
  if FRealCnfg=nil then
  begin
    FRealCnfg:=TUniConfig.Create;
  end;
  FRealCnfg.UnixIdex:=0;
  
  FRealCnfg.UnixType:=Comb_Type.Text;
  FRealCnfg.UnixUser:=Edit_UnixUser.Text;
  FRealCnfg.UnixPswd:=Edit_UnixPswd.Text;
  FRealCnfg.UnixServ:=Edit_UnixServ.Text;

  //YXC_2012_12_04_09_36_39_<
  if (FRealCnfg.UnixType=CONST_PROVIDER_SQLSRV) or (FRealCnfg.UnixType=CONST_PROVIDER_MYSQLX) then
  begin
    FRealCnfg.DataBase:=Comb_DataBase.Text;
  end else
  begin
    FRealCnfg.DataBase:=Edit_DataBase.Text;
  end;
  //YXC_2012_12_04_09_36_46_>

  FRealCnfg.UnixPort:=Edit_UnixPort.Text;
  FRealCnfg.UnixYear:=StrToIntDef(Edit_UnixYear.Text,0);
  FRealCnfg.UnixMark:=Comb_Mark.Text;
  FRealCnfg.IsDirect:=0;
  if ChkBox_Direct.Checked then
  begin
    FRealCnfg.IsDirect:=1;
  end;
  FRealCnfg.UnixOrdr:=FRealCnfg.UnixIdex; 
end;

function TDialogEditUniConfig.CheckLicit: Boolean;
begin
  Result:=False;
  if Comb_Type.Text=CONST_PROVIDER_SQLSRV then
  begin
    if Trim(Comb_DataBase.Text)='' then
    begin
      ShowMessage('请填写数据库.');
      Exit;
    end;  
  end;  
  Result:=True;
end;

procedure TDialogEditUniConfig.Comb_TypeCloseUp(Sender: TObject);
begin
  inherited;
  Edit_UnixYear.Enabled:=True;
  Edit_UnixUser.Enabled:=True;
  Edit_UnixPswd.Enabled:=True;
  Edit_UnixServ.Enabled:=True;
  Edit_UnixPort.Enabled:=True;
  Edit_UnixPort.Enabled:=True;
  Edit_DataBase.Enabled:=True;

  ChkBox_Direct.Checked:=False;
  ChkBox_Direct.Visible:=False;

  Edit_DataBase.Visible:=False;
  Comb_DataBase.Visible:=False;

  if (Trim(Comb_Type.Text)=CONST_PROVIDER_ACCESS) OR (Trim(Comb_Type.Text)=CONST_PROVIDER_SQLITE) then
  begin
    Caption:='数据连接';
      
    Edit_UnixUser.Enabled:=False;
    Edit_UnixUser.Clear;
    Edit_UnixPswd.Enabled:=False;
    Edit_UnixPswd.Clear;
    Edit_UnixServ.Enabled:=False;
    Edit_UnixServ.Clear;
    Edit_UnixPort.Enabled:=False;
    Edit_UnixPort.Clear;

    Edit_DataBase.Visible:=True;
    Edit_DataBase.AltBtnVisible:=True;
  end else
  if Trim(Comb_Type.Text)=CONST_PROVIDER_SQLSRV then
  begin
    Caption:='提示:双击服务器框,加载服务器.';
      
    Edit_UnixUser.Text:='sa';
    Edit_UnixPswd.Text:='sa';
    Edit_UnixServ.Text:='.';
    Edit_UnixPort.Text:='1433';

    Comb_DataBase.Visible:=True;

    {if FEditMode=deuemAddx then
    begin
      ViewDataBase;
    end;}
  end else
  if Trim(Comb_Type.Text)=CONST_PROVIDER_ORACLE then
  begin
    Caption:='直联示例:IP地址:端口:实例名';

    Edit_DataBase.Visible:=True;
    Edit_DataBase.Enabled:=False;
    
    Edit_UnixPort.Text   :='1521';
    ChkBox_Direct.Visible:=True;
    ChkBox_Direct.Checked:=True;

    Edit_DataBase.Clear;
    Edit_UnixUser.Clear;
    Edit_UnixPswd.Clear;    
    Edit_UnixServ.Clear;    
  end else
  if Trim(Comb_Type.Text)=CONST_PROVIDER_MYSQLX then
  begin
    Caption:='数据连接';
      
    Edit_UnixUser.Text:='root';
    Edit_UnixPswd.Text:='root';
    Edit_UnixServ.Text:='localhost';
    Edit_UnixPort.Text:='0';

    Comb_DataBase.Visible:=True;

    if FEditMode=deuemAddx then
    begin
      ViewDataBase(CONST_PROVIDER_MYSQLX);
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
        TBuildMdb.BuildMdb(FilePath);
      end;
    end;
  finally
    FreeAndNil(SD);
  end;
end;

procedure TDialogEditUniConfig.Edit_UnixPswdExit(Sender: TObject);
begin
  inherited;
  if FEditMode=deuemEdit then
  begin
    FRealPswd:=TRzEdit(Sender).Text;
  end;
end;

end.
