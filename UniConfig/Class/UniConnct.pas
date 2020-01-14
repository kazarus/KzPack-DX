unit UniConnct;
//YXC_2012_07_28_15_10_27_Add_Method_ChkConnection
//YXC_2012_08_02_08_37_01_uniconnctentity->uniconnctex
//YXC_2012_08_03_15_20_00_add_connctmode
//YXC_2012_08_03_15_20_18_add_GetConnection(aNull:Integer;aConnectionMark:string)
//YXC_2012_09_05_14_25_43_add_ConnctMark
//YXC_2013_07_31_11_18_37_add_ActiveHint

interface
uses
  Classes,SysUtils,Uni,UniEngine,UniConfig;
  
type
  TConnctMode=(cmBySQL,cmByOBJ);
  TUniConnctCustomConnectionEventBySQL=procedure (aConnectionMark:string;var SQLA:string) of object;
  TUniConnctCustomConnectionEventByOBJ=procedure (aConnectionMark:string;var OBJA:TUniConfig) of object;

  //供Dialig_ListUniConfig调用
  TDialogListUniConfigCustomStyleEvent=procedure (Sender:TObject) of object;
  //供Dialig_EditUniConfig调用  
  TUniConfigCustomGetUnixMemo         =procedure (Sender:TObject;var AUnixMemo:string) of object;    

  TUniConfigCustomEncryptEvent        =procedure (Sender:TObject;var aUniConfig:TUniConfig) of object;
  TUniConfigCustomDecryptEnent        =procedure (Sender:TObject;var aUniConfig:TUniConfig) of object;



  TUniConnct=class(TUniEngine)
  public
    ConnctMode:TConnctMode;

    //供Dialig_ListUniConfig调用
    ConnctMark:string; //连接标志,多个以逗号相隔.
    ActiveHint:Boolean;//当链接非活动时,是否提示设为活动.
    ActiveCnfg:string; //当前链接.TUniConfig.GetActvStat
        
    ConnctType:Integer;//当前.连接类型
    ConnctLast:Integer;//上次.连接配置
  public
    OnUniConnctCustomConnectionEventBySQL: TUniConnctCustomConnectionEventBySQL;
    OnUniConnctCustomConnectionEventByOBJ: TUniConnctCustomConnectionEventByOBJ;

    //供Dialig_ListUniConfig调用
    OnUniConfigCustomGetUnixMemo         : TUniConfigCustomGetUnixMemo;
    OnDialogListUniConfigCustomStyleEvent: TDialogListUniConfigCustomStyleEvent;

    //
    OnUniConfigCustomEncryptEvent        : TUniConfigCustomEncryptEvent;
    OnUniConfigCustomDecryptEvent        : TUniConfigCustomDecryptEnent;
  public
    function  getConfig(aConnectionMark: string; var aCnfg: TUniConfig): Boolean;
  public
    function  GetConnection:TUniConnection;overload;
    function  GetConnection(aConnectionMark:string):TUniConnection;overload;
    
    function  GetConnection(aNull:Integer;aConnectionMark:string):TUniConnection;overload;
    function  GetConnection(aUniConfig: TUniConfig; aTimeOut: Integer = 30): TUniConnection; overload;

    function  TstConnection(aUniConfig:TUniConfig):Boolean;
    function  ChkConnection(aConnectionMark:string):Boolean;
  public
    procedure UniConnctCustomConnectionEventBySQL(aConnectionMark:string;var SQLA:string);
  public
    constructor Create;
    destructor Destroy; override;      
  end;

var
  UniConnctEx:TUniConnct;
    
implementation


function TUniConnct.ChkConnection(aConnectionMark: string): Boolean;
var
  SQLA:string;
  UniConfig:TUniConfig;
  UniConnct:TUniConnection;
begin
  Result:=False;

  if ConnctMode=cmbySQL then
  begin
    if not Assigned(OnUniConnctCustomConnectionEventBySQL) then raise Exception.Create('You should be implementation method [OnUniConnctCustomConnectionEventBySQL]');
    OnUniConnctCustomConnectionEventBySQL(aConnectionMark,SQLA);

    if SQLA='' then Exit;

    UniConfig:=nil;
    try
      UniConnct:=UniConnctEx.GetConnection;
      UniConfig:=TUniConfig(TUniConfig.ReadDB(SQLA,UniConnct));
    finally
      FreeAndNil(UniConnct);
    end;

    //YXC_2014_03_21_15_37_59_<
    if UniConfig = nil then raise Exception.Create('没有设置为[活动]的数据链接.请检查配置.');

    if Assigned(OnUniConfigCustomDecryptEvent) then
    begin
      OnUniConfigCustomDecryptEvent(UniConfig,UniConfig);
    end;
    //YXC_2014_03_21_15_37_59_>
  end else
  if ConnctMode=cmByOBJ then
  begin
    if not Assigned(OnUniConnctCustomConnectionEventByOBJ) then raise Exception.Create('You should be implementation method [OnUniConnctCustomConnectionEventByOBJ]');
    UniConfig:=TUniConfig.Create;
    OnUniConnctCustomConnectionEventByOBJ(aConnectionMark,UniConfig);
  end;

  Result := UniConfig <> nil;
  if UniConfig <> nil then
  begin
    Result := TstConnection(UniConfig);
  end;

  FreeAndNil(UniConfig);
end;

constructor TUniConnct.Create;
begin
  ConnctLast:=1;
  ActiveHint:=False;
end;

destructor TUniConnct.Destroy;
begin

  inherited;
end;

function TUniConnct.getConfig(aConnectionMark: string;
  var aCnfg: TUniConfig): Boolean;
var
  cSQL: string;
  cUniC: TUniConnection;
begin
  Result := False;
  if aCnfg = nil then Exit;

  if ConnctMode = cmbySQL then
  begin
    if not Assigned(OnUniConnctCustomConnectionEventBySQL) then raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniConnct.GetConnection] AT [UniConnct.pas]' + #13 + '此函数已被更新或弃用,请向开发人员报告错误场合.');
    OnUniConnctCustomConnectionEventBySQL(aConnectionMark,cSQL);

    try
      cUniC:=UniConnctEx.GetConnection;
      TUniConfig.ReadDB(cSQL,cUniC,TUniEngine(aCnfg));
    finally
      FreeAndNil(cUniC);
    end;
  end else
  if ConnctMode = cmByOBJ then
  begin
    if not Assigned(OnUniConnctCustomConnectionEventByOBJ) then raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniConnct.GetConnection] AT [UniConnct.pas]' + #13 + '此函数已被更新或弃用,请向开发人员报告错误场合.');
    OnUniConnctCustomConnectionEventByOBJ(aConnectionMark, aCnfg);
  end;

  Result := True;
end;

function TUniConnct.GetConnection(aUniConfig: TUniConfig; aTimeOut: Integer): TUniConnection;
begin
  Result:=nil;
  if aUniConfig=nil then raise Exception.CreateFmt('连接配置对象为空!',[]);

  if aUniConfig.UnicType='' then raise Exception.CreateFmt('aUniConfig.UnicType=nil',[]);

  if aUniConfig.UnicType=CONST_PROVIDER_ORACLE then
  begin
    if aUniConfig.UnicUser='' then raise Exception.CreateFmt('aUniConfig.UnicUser=nil',[]);
    //#if aUniConfig.UNICPSWD='' then raise Exception.CreateFmt('aUniConfig.UNICPSWD=nil',[]);
    if aUniConfig.UnicSrvr='' then raise Exception.CreateFmt('aUniConfig.UnicSrvr=nil',[]);
  end else
  if aUniConfig.UnicType=CONST_PROVIDER_SQLSRV then
  begin
    if aUniConfig.DataBase='' then raise Exception.CreateFmt('aUniConfig.DataBase=nil',[]);
    if aUniConfig.UnicUser='' then raise Exception.CreateFmt('aUniConfig.UnicUser=nil',[]);
    //#if aUniConfig.UNICPSWD='' then raise Exception.CreateFmt('aUniConfig.UNICPSWD=nil',[]);
    if aUniConfig.UnicSrvr='' then raise Exception.CreateFmt('aUniConfig.UnicSrvr=nil',[]);
  end else
  if aUniConfig.UnicType=CONST_PROVIDER_ACCESS then
  begin
    if aUniConfig.DataBase='' then raise Exception.CreateFmt('aUniConfig.DataBase=nil',[]);
  end;  

  //YXC_2013_08_14_10_00_01
  ActiveCnfg:=aUniConfig.GetActvStat('当前连接');

  Result:=TUniConnection.Create(nil);
  Result.LoginPrompt:=False;
  Result.ProviderName:=aUniConfig.UnicType;
  Result.Username    :=aUniConfig.UnicUser;
  Result.Password    :=aUniConfig.UNICPSWD;
  Result.Database    :=aUniConfig.DataBase;
  Result.Server      :=aUniConfig.UnicSrvr;
  Result.Port        :=StrToIntDef(aUniConfig.UNICPORT,0);

  if Result.ProviderName=CONST_PROVIDER_ORACLE then
  begin
    if aUniConfig.IsDirect=1 then
    begin
     //Result.SpecificOptions.Clear;
      Result.SpecificOptions.Add('Oracle.Direct=True');
    end;
  end else
  if Result.ProviderName=CONST_PROVIDER_SQLITE then
  begin
    Result.SpecificOptions.Add('SQLite.ForceCreateDatabase=True');
  end else
  if Result.ProviderName=CONST_PROVIDER_SQLSRV then
  begin
    Result.SpecificOptions.Add(Format('SQL Server.ConnectionTimeout=%d',[aTimeOut]));
    Result.SpecificOptions.Add('SQL Server.OLEDBProvider=prSQL');
  end else
  if Result.ProviderName=CONST_PROVIDER_MYSQLX then
  begin
    Result.SpecificOptions.Add('MySQL.UseUnicode=True');
  end;

  try
    Result.Connected :=True;
  except
    on E:Exception do
    begin
      raise Exception.CreateFmt('该数据库连接无效:%S',[E.Message]);
    end;
  end;
end;

function TUniConnct.GetConnection(aConnectionMark: string): TUniConnection;
var
  uCnfg: TUniConfig;
begin
  //YXC_2014_04_28_10_39_37_<
  if Trim(aConnectionMark) = '' then
  begin
    //default connect to sqllite
    Result := GetConnection;
    Exit;
  end;
  //YXC_2014_04_28_10_39_37_>

  if ConnctMode = cmbySQL then
  begin
    Result := GetConnection(0, aConnectionMark);
  end else
  if ConnctMode = cmByOBJ then
  begin
    if not Assigned(OnUniConnctCustomConnectionEventByOBJ) then raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniConnct.GetConnection] AT [UniConnct.pas]' + #13 + '此函数已被更新或弃用,请向开发人员报告错误场合.');
    uCnfg := TUniConfig.Create;
    OnUniConnctCustomConnectionEventByOBJ(aConnectionMark, uCnfg);
    Result := GetConnection(uCnfg);
    FreeAndNil(uCnfg);
  end;
end;


function TUniConnct.GetConnection: TUniConnection;
begin
  Result:=nil;
  if not FileExists(ExtractFilePath(ParamStr(0))+CONST_DB_UNICONFIG) then
  begin
    TUniConfig.Initialize;
  end;
  
  Result:=TUniConnection.Create(nil);
  Result.LoginPrompt :=False;
  Result.ProviderName:=CONST_PROVIDER_SQLITE;
  Result.Database    :=ExtractFilePath(ParamStr(0))+CONST_DB_UNICONFIG;
  Result.SpecificOptions.Add('SQLite.ForceCreateDatabase=True');
  Result.Connected   :=True;
end;

function TUniConnct.GetConnection(aNull: Integer;
  aConnectionMark: string): TUniConnection;
var
  SQLA:string;
  UniConfig:TUniConfig;
  UniConnct:TUniConnection;
begin
  Result:=nil;
  if not Assigned(OnUniConnctCustomConnectionEventBySQL) then raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniConfig.GetConnection] AT [UniConfig.pas]');

  OnUniConnctCustomConnectionEventBySQL(aConnectionMark,SQLA);

  UniConfig:=nil;
  try
    UniConnct:=UniConnctEx.GetConnection;
    UniConfig:=TUniConfig(TUniConfig.ReadDB(SQLA,UniConnct));
  finally
    FreeAndNil(UniConnct);
  end;

  if UniConfig=nil then
  begin
    raise Exception.CreateFmt('未发现:%S的配置值',[aConnectionMark]);
    Exit;
  end;
  //if UniConfig=nil then raise Exception.CreateFmt('未发现:%S的配置值',[aConnectionMark]);

  if Assigned(OnUniConfigCustomDecryptEvent) then
  begin
    OnUniConfigCustomDecryptEvent(UniConfig,UniConfig);
  end;
    
  //YXC_2013_08_14_10_00_01
  ActiveCnfg:=UniConfig.GetActvStat('当前连接');

  Result:=TUniConnection.Create(nil);
  Result.LoginPrompt:=False;
  Result.ProviderName:=UniConfig.UnicType;
  Result.Username    :=UniConfig.UnicUser;
  Result.Password    :=UniConfig.UNICPSWD;
  Result.Database    :=UniConfig.DataBase;
  Result.Server      :=UniConfig.UnicSrvr;
  Result.Port        :=StrToIntDef(UniConfig.UNICPORT,0);

  if Result.ProviderName=CONST_PROVIDER_ORACLE then
  begin
    if UniConfig.IsDirect=1 then
    begin
     //Result.SpecificOptions.Clear;
      Result.SpecificOptions.Add('Oracle.Direct=True');
    end;  
  end else
  if Result.ProviderName=CONST_PROVIDER_SQLITE then
  begin
    Result.SpecificOptions.Add('SQLite.ForceCreateDatabase=True');
  end else
  if Result.ProviderName=CONST_PROVIDER_SQLSRV then
  begin
    Result.SpecificOptions.Add('SQL Server.ConnectionTimeout=30');
    Result.SpecificOptions.Add('SQL Server.OLEDBProvider=prSQL');
  end else
  if Result.ProviderName=CONST_PROVIDER_MYSQLX then
  begin
    Result.SpecificOptions.Add('MySQL.UseUnicode=True');
  end;
  
  try
    Result.Connected :=True;
  except
    on E:Exception do
    begin
      raise Exception.CreateFmt('该数据库连接无效:%S',[E.Message]);
    end;  
  end;

  FreeAndNil(UniConfig);
end;

function TUniConnct.TstConnection(aUniConfig: TUniConfig): Boolean;
var
  UniConnectionA:TUniConnection;
begin
  Result:=False;
  if aUniConfig=nil then raise Exception.CreateFmt('连接配置对象为空!',[]);

  UniConnectionA:=TUniConnection.Create(nil);
  UniConnectionA.LoginPrompt:=False;
  UniConnectionA.ProviderName:=aUniConfig.UnicType;
  UniConnectionA.Username    :=aUniConfig.UnicUser;
  UniConnectionA.Password    :=aUniConfig.UNICPSWD;
  UniConnectionA.Database    :=aUniConfig.DataBase;
  UniConnectionA.Server      :=aUniConfig.UnicSrvr;
  UniConnectionA.Port        :=StrToIntDef(aUniConfig.UNICPORT,0);

  if UniConnectionA.ProviderName=CONST_PROVIDER_ORACLE then
  begin
    if aUniConfig.IsDirect=1 then
    begin
     //UniConnectionA.SpecificOptions.Clear;
      UniConnectionA.SpecificOptions.Add('Oracle.Direct=True');
    end;  
  end else
  if UniConnectionA.ProviderName=CONST_PROVIDER_SQLSRV then 
  begin
    UniConnectionA.SpecificOptions.Add('SQL Server.ConnectionTimeout=30');
    UniConnectionA.SpecificOptions.Add('SQL Server.OLEDBProvider=prSQL');
  end;

  try
    try
      UniConnectionA.Connected:=True;
    except
      on E:Exception do
      begin
        raise Exception.CreateFmt('%S',[E.Message]);
      end;
    end;
  finally
    FreeAndNil(UniConnectionA);
  end;

  Result:=True;
end;

procedure TUniConnct.UniConnctCustomConnectionEventBySQL(
  aConnectionMark: string; var SQLA: string);
begin

end;

initialization
begin
  UniConnctEx:=TUniConnct.Create;
  UniConnctEx.OnUniConnctCustomConnectionEventBySQL:=UniConnctEx.UniConnctCustomConnectionEventBySQL;
end;

finalization
begin
  if UniConnctEx <> nil then FreeAndNil(UniConnctEx);
end;

end.



{var
  SQLA:string;
  UniConfig:TUniConfig;
  UniConnct:TUniConnection;
begin
  if not Assigned(OnUniConnctCustomConnectionEvent) then raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniConfig.GetConnection] AT [UniConfig.pas]');
  OnUniConnctCustomConnectionEvent(aConnectionMark,SQLA);

  UniConfig:=nil;
  try
    UniConnct:=UniConnctEx.GetConnection;
    UniConfig:=TUniConfig(TUniConfig.ReadDB(SQLA,UniConnct));
  finally
    FreeAndNil(UniConnct);
  end;

  if UniConfig=nil then raise Exception.CreateFmt('未发现:%S的配置值',[aConnectionMark]);

  Result:=TUniConnection.Create(nil);
  Result.LoginPrompt:=False;
  Result.ProviderName:=UniConfig.UnicType;
  Result.Username    :=UniConfig.UnicUser;
  Result.Password    :=UniConfig.UNICPSWD;
  Result.Database    :=UniConfig.DataBase;
  Result.Server      :=UniConfig.UnicSrvr;
  Result.Port        :=StrToIntDef(UniConfig.UNICPORT,0);

  if Result.ProviderName=CONST_PROVIDER_ORACLE then
  begin
    if UniConfig.IsDirect=1 then
    begin
     //Result.SpecificOptions.Clear;
      Result.SpecificOptions.Add('Oracle.Direct=True');
    end;  
  end;   
  
  try
    Result.Connected :=True;
  except
    raise Exception.Create('该数据库连接无效.');
  end;

  FreeAndNil(UniConfig);
end; }
