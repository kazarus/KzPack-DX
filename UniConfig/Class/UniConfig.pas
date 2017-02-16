unit UniConfig;
//YXC_2012_06_19_12_25_16
//数据库配置类.
//UniConfig
//UniConnct

interface
uses
  Classes,SysUtils,Uni,UniEngine;

type
  TUniConfig=class(TUniEngine)
  public
    FUnicIndx: Integer;   //配置序列
    FUnicStat: Integer;   //配置状态
    FUnicYear: Integer;   //配置年度
    FUnicMark: string;    //配置代号

    FUnicType: string;    //*驱动类型
    FUnicPswd: string;    //*密码
    FUnicUser: string;    //*用户
    FUnicSrvr: string;    //*服务器
    FDataBase: string;    //*数据库
    FUnicPort: string;    //*端口号
    FIsDirect: Integer;   //*是否直联
    FUnicOrdr: Integer;   //排序
    FUnicMemo: string;    //备注
    FWhoBuild: Integer;   //机器码
  public
    IsDecrypt:Boolean;   //
    IsEncrypt:Boolean;   //
  protected
    procedure SetParameters;override;
    function  GetStrInsert:string;override;
    function  GetStrUpdate:string;override;
    function  GetStrDelete:string;override;
    function  GetStrsIndex:string;override;
  public
    function  GetNextIdex:Integer;overload;
    function  GetNextIdex(AUniConnection:TUniConnection):Integer;overload;
    function  GetIsDirect:string;
    function  GetUNICSTAT:string;
    function  GetActvStat:string;overload;
    function  GetActvStat(AValue:string):string;overload;
  public
    function  CheckExist(AUniConnection:TUniConnection):Boolean;override;
  public
    function  TstConnection(uCnfg:TUniConfig):Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property UnicIndx : Integer read FUnicIndx  write FUnicIndx;
    property UnicStat : Integer read FUnicStat  write FUnicStat;
    property UnicYear : Integer read FUnicYear  write FUnicYear;
    property UnicMark : string read FUnicMark  write FUnicMark;
    property UnicType : string read FUnicType  write FUnicType;
    property UnicPswd : string read FUnicPswd  write FUnicPswd;
    property UnicUser : string read FUnicUser  write FUnicUser;
    property UnicSrvr : string read FUnicSrvr  write FUnicSrvr;
    property DataBase : string read FDataBase  write FDataBase;
    property UnicPort : string read FUnicPort  write FUnicPort;
    property IsDirect : Integer read FIsDirect  write FIsDirect;
    property UnicOrdr : Integer read FUnicOrdr  write FUnicOrdr;
    property UnicMemo : string read FUnicMemo  write FUnicMemo;
    property WhoBuild : Integer read FWhoBuild write FWhoBuild;
  public
    class function  ReadDS(AUniQuery:TUniQuery):TUniEngine;override;
    class procedure ReadDS(AUniQuery: TUniQuery;var Result:TUniEngine);override;
    
    class function  CopyIt(uCnfg:TUniConfig):TUniConfig;overload;
    class procedure CopyIt(uCnfg:TUniConfig;var Result:TUniConfig);overload;
  public
    class procedure Initialize(ADataBase:string='-1');
    class function  ADD_TBL_UNICNFG:string;
    class function  ADD_TBL_UNIDICT:string;
  end;


{var
  UniConfigEntity:TUniConfig;}
   
const
  CONST_DB_UNICONFIG='config.db';
  
  CONST_PROVIDER_SQLSRV='SQL Server';
  CONST_PROVIDER_ORACLE='Oracle';
  CONST_PROVIDER_ACCESS='Access';
  CONST_PROVIDER_SQLITE='SQLite';
  CONST_PROVIDER_MYSQLX='MySQL';
  CONST_PROVIDER_POSTGR='PostgreSQL';




implementation

function TUniConfig.CheckExist(AUniConnection: TUniConnection): Boolean;
begin

end;

function TUniConfig.GetNextIdex: Integer;
begin

end;


function TUniConfig.GetNextIdex(AUniConnection: TUniConnection): Integer;
var
  TempA:string;
  UniQuery:TUniQuery;
begin
  Result:=1;
  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.SQL.Text:='SELECT MAX(UNIX_IDEX)+1 AS MAX FROM TBL_UNICONFIG';
    UniQuery.Connection:=AUniConnection;
    UniQuery.Open;

    if UniQuery.RecordCount=0 then Exit;
    TempA:=Trim(UniQuery.FieldByName('MAX').AsString);
    if TempA='' then Exit;
    Result:=StrToIntDef(TempA,1);
  finally
    FreeAndNil(UniQuery);
  end;
end;

function TUniConfig.GetStrDelete: string;
begin
  Result:='DELETE FROM TBL_UNICONFIG WHERE UNIX_IDEX=:UNIX_IDEX';
end;

function TUniConfig.GetStrsIndex: string;
begin
  Result:='';
end;

function TUniConfig.GetStrInsert: string;
begin
  Result:='INSERT INTO TBL_UNICONFIG '
        + '    (UNIX_IDEX, UNIX_STAT, UNIX_YEAR, UNIX_MARK, UNIX_TYPE, UNIX_PSWD, '
        + '    UNIX_USER, UNIX_SERV, DATA_BASE, UNIX_PORT, IS_DIRECT,UNIX_ORDR,UNIX_MEMO)'
        + '    VALUES(:UNIX_IDEX, :UNIX_STAT, :UNIX_YEAR, :UNIX_MARK, :UNIX_TYPE, :UNIX_PSWD, '
        + '    :UNIX_USER, :UNIX_SERV, :DATA_BASE, :UNIX_PORT, :IS_DIRECT,:UNIX_ORDR,:UNIX_MEMO)';
end;

function TUniConfig.GetStrUpdate: string;
begin
  Result:='UPDATE TBL_UNICONFIG SET'
        + '    UNIX_STAT = :UNIX_STAT,'
        + '    UNIX_YEAR = :UNIX_YEAR,'
        + '    UNIX_MARK = :UNIX_MARK,'
        + '    UNIX_TYPE = :UNIX_TYPE,'
        + '    UNIX_PSWD = :UNIX_PSWD,'
        + '    UNIX_USER = :UNIX_USER,'
        + '    UNIX_SERV = :UNIX_SERV,'
        + '    DATA_BASE = :DATA_BASE,'
        + '    UNIX_PORT = :UNIX_PORT,'
        + '    IS_DIRECT = :IS_DIRECT,'
        + '    UNIX_ORDR = :UNIX_ORDR,'
        + '    UNIX_MEMO = :UNIX_MEMO'
        + '    WHERE UNIX_IDEX = :UNIX_IDEX';
end;

class procedure TUniConfig.Initialize(ADataBase:string);
var
  ExePath:string;
  FilPath:string;
  UniConnection:TUniConnection;
begin
  if ADataBase='-1' then
  begin
    ExePath:=ExtractFilePath(ParamStr(0));
    FilPath:=ExePath+CONST_DB_UNICONFIG;
  end else
  begin
    FilPath:=ADataBase;
  end;    

  {if not FileExists(FilPath) then
  begin

  end;}
  UniConnection:=TUniConnection.Create(nil);
  UniConnection.LoginPrompt:=False;

  UniConnection.ProviderName:=CONST_PROVIDER_SQLITE;
  UniConnection.Database    :=FilPath;
  UniConnection.SpecificOptions.Add('SQLite.ForceCreateDatabase=True');
  UniConnection.Connected   :=True;


  if not ExistTable('TBL_UNICONFIG',UniConnection) then
  begin
    UniConnection.ExecSQL(ADD_TBL_UNICNFG,[]);
  end;
  if not ExistTable('TBL_UNIDICT',UniConnection) then
  begin
    UniConnection.ExecSQL(ADD_TBL_UNIDICT,[]);
  end;

  UniConnection.Connected:=False;    

  if UniConnection<>nil then
  begin
    FreeAndNil(UniConnection);
  end;  
end;

class function TUniConfig.ReadDS(AUniQuery: TUniQuery): TUniEngine;
begin
  Result:=TUniConfig.Create;
  with TUniConfig(Result) do
  begin
    UNICINDX := AUniQuery.FieldByName('UNIX_IDEX').AsInteger;
    UNICSTAT := AUniQuery.FieldByName('UNIX_STAT').AsInteger;
    UNICYEAR := AUniQuery.FieldByName('UNIX_YEAR').AsInteger;
    UNICMARK := Trim(AUniQuery.FieldByName('UNIX_MARK').AsString);
    UNICTYPE := Trim(AUniQuery.FieldByName('UNIX_TYPE').AsString);
    UNICPSWD := Trim(AUniQuery.FieldByName('UNIX_PSWD').AsString);
    UNICUSER := Trim(AUniQuery.FieldByName('UNIX_USER').AsString);
    UNICSRVR := Trim(AUniQuery.FieldByName('UNIX_SERV').AsString);
    DATABASE := Trim(AUniQuery.FieldByName('DATA_BASE').AsString);
    UNICPORT := Trim(AUniQuery.FieldByName('UNIX_PORT').AsString);
    ISDIRECT := AUniQuery.FieldByName('IS_DIRECT').AsInteger;
    UNICORDR := AUniQuery.FieldByName('UNIX_ORDR').AsInteger;
    
    if AUniQuery.FindField('UNIX_MEMO')<>nil then
    begin
      UNICMEMO := AUniQuery.FieldByName('UNIX_MEMO').AsString;
    end;
  end;
end;



procedure TUniConfig.SetParameters;
begin
  inherited;
  with FUniSQL.Params do
  begin
    case FOptTyp of
      otAddx:
      begin
        ParamByName('UNIX_IDEX').Value := UNICINDX;
        ParamByName('UNIX_STAT').Value := UNICSTAT;
        ParamByName('UNIX_YEAR').Value := UNICYEAR;
        ParamByName('UNIX_MARK').Value := UNICMARK;
        ParamByName('UNIX_TYPE').Value := UNICTYPE;
        ParamByName('UNIX_PSWD').Value := UNICPSWD;
        ParamByName('UNIX_USER').Value := UNICUSER;
        ParamByName('UNIX_SERV').Value := UNICSRVR;
        ParamByName('DATA_BASE').Value := DATABASE;
        ParamByName('UNIX_PORT').Value := UNICPORT;
        ParamByName('IS_DIRECT').Value := ISDIRECT;
        ParamByName('UNIX_ORDR').Value := UNICORDR;
        ParamByName('UNIX_MEMO').Value := UNICMEMO;
      end;
      otEdit:
      begin
        ParamByName('UNIX_IDEX').Value := UNICINDX;
        ParamByName('UNIX_STAT').Value := UNICSTAT;
        ParamByName('UNIX_YEAR').Value := UNICYEAR;
        ParamByName('UNIX_MARK').Value := UNICMARK;
        ParamByName('UNIX_TYPE').Value := UNICTYPE;
        ParamByName('UNIX_PSWD').Value := UNICPSWD;
        ParamByName('UNIX_USER').Value := UNICUSER;
        ParamByName('UNIX_SERV').Value := UNICSRVR;
        ParamByName('DATA_BASE').Value := DATABASE;
        ParamByName('UNIX_PORT').Value := UNICPORT;
        ParamByName('IS_DIRECT').Value := ISDIRECT;        
        ParamByName('UNIX_ORDR').Value := UNICORDR;
        ParamByName('UNIX_MEMO').Value := UNICMEMO;
      end;  
      otDelt:
      begin
        ParamByName('UNIX_IDEX').Value := UNICINDX;
      end;  
    end;

  end;  
end;

function TUniConfig.GetIsDirect: string;
begin
  Result:='否';
  if IsDirect=1 then
  begin
    Result:='是';
  end;  
end;

class function TUniConfig.CopyIt(uCnfg: TUniConfig): TUniConfig;
begin
  Result:=TUniConfig.Create;

  TUniConfig.CopyIt(uCnfg,Result);
end;

class function TUniConfig.ADD_TBL_UNICNFG: string;
begin
  Result:='CREATE TABLE TBL_UNICONFIG ('
         +'    UNIX_IDEX INT NOT NULL ,'
         +'    UNIX_STAT INT NULL ,'
         +'    UNIX_YEAR INT NULL ,'
         +'    UNIX_MARK VARCHAR (50)  NULL ,'
         +'    UNIX_TYPE VARCHAR (50)  NULL ,'
         +'    UNIX_PSWD VARCHAR (50)  NULL ,'
         +'    UNIX_USER VARCHAR (50)  NULL ,'
         +'    UNIX_SERV VARCHAR (50)  NULL ,'
         +'    DATA_BASE VARCHAR (500) NULL ,'
         +'    UNIX_PORT VARCHAR (50)  NULL ,'
         +'    IS_DIRECT INT NULL ,'
         +'    UNIX_ORDR INT NULL ,'
         +'    UNIX_MEMO VARCHAR (100) NULL,'
         +'    PRIMARY KEY (UNIX_IDEX)'
         +')';
end;

class function TUniConfig.ADD_TBL_UNIDICT: string;
begin
  Result:='CREATE TABLE TBL_UNIDICT ('
         +'    DICT_IDEX INT NOT NULL ,'
         +'    DICT_MODE VARCHAR (10)  NULL,'
         +'    DICT_INFO VARCHAR(100)  NULL,'         
         +'    DICT_CODE VARCHAR (50)  NULL,'
         +'    DICT_NAME VARCHAR (50)  NULL,'
         +'    DICT_MEMO VARCHAR (50)  NULL,'
         +'    PRIMARY KEY (DICT_IDEX)'
         +')';
end;



function TUniConfig.TstConnection(uCnfg: TUniConfig): Boolean;
var
  UniConnectionA:TUniConnection;
begin
  Result:=False;
  if uCnfg=nil then raise Exception.CreateFmt('连接配置对象为空!',[]);

  UniConnectionA:=TUniConnection.Create(nil);
  UniConnectionA.LoginPrompt:=False;
  UniConnectionA.ProviderName:=uCnfg.UNICTYPE;
  UniConnectionA.Username    :=uCnfg.UNICUSER;
  UniConnectionA.Password    :=uCnfg.UNICPSWD;
  UniConnectionA.Database    :=uCnfg.DataBase;
  UniConnectionA.Server      :=uCnfg.UNICSRVR;
  UniConnectionA.Port        :=StrToIntDef(uCnfg.UNICPORT,0);

  if UniConnectionA.ProviderName=CONST_PROVIDER_ORACLE then
  begin
    if uCnfg.IsDirect=1 then
    begin
     //UniConnectionA.SpecificOptions.Clear;
      UniConnectionA.SpecificOptions.Add('Oracle.Direct=True');
    end;  
  end else
  if UniConnectionA.ProviderName=CONST_PROVIDER_SQLSRV then
  begin
    UniConnectionA.SpecificOptions.Add('SQL Server.ConnectionTimeout=1');
    UniConnectionA.SpecificOptions.Add('SQL Server.OLEDBProvider=prSQL');    
  end;

  try
    try
      UniConnectionA.PerformConnect();
    except
      on E:Exception do
      begin
        raise Exception.CreateFmt('该数据库连接无效:%S',[E.Message]);
      end;
    end;
  finally
    FreeAndNil(UniConnectionA);
  end;

  Result:=True;
end;

class procedure TUniConfig.CopyIt(uCnfg: TUniConfig;
  var Result: TUniConfig);
begin
  if Result=nil then Exit;

  with Result do
  begin
    UNICINDX := uCnfg.UNICINDX;
    UNICSTAT := uCnfg.UNICSTAT;
    UNICYEAR := uCnfg.UNICYEAR;
    UNICMARK := uCnfg.UNICMARK;

    UNICTYPE := uCnfg.UNICTYPE;
    UNICPSWD := uCnfg.UNICPSWD;
    UNICUSER := uCnfg.UNICUSER;
    UNICSRVR := uCnfg.UNICSRVR;
    DataBase := uCnfg.DataBase;
    UNICPORT := uCnfg.UNICPORT;
    IsDirect := uCnfg.IsDirect;
    UNICORDR := uCnfg.UNICORDR;
    UNICMEMO := uCnfg.UNICMEMO;
    WhoBuild := uCnfg.WhoBuild;

    IsDecrypt:=uCnfg.IsDecrypt;
    IsEncrypt:=uCnfg.IsEncrypt;
  end;  
end;

function TUniConfig.GetUNICSTAT: string;
begin
  Result:='挂起';
  if UNICSTAT=1 then
  begin
    Result:='活动';
  end;  
end;

function TUniConfig.GetActvStat: string;
begin
  if UNICTYPE=CONST_PROVIDER_ACCESS then
  begin
    Result:=Format('当前连接:%S',[UpperCase(DataBase)]);
  end else
  if UNICTYPE=CONST_PROVIDER_SQLSRV then
  begin
    Result:=Format('当前连接:%S.%S',[UpperCase(UNICSRVR),UpperCase(DataBase)]);
  end else
  if UNICTYPE=CONST_PROVIDER_ORACLE then
  begin
    Result:=Format('当前连接:%S',[UpperCase(UNICSRVR)]);
  end;    
end;

function TUniConfig.GetActvStat(AValue: string): string;
begin
  if UNICTYPE=CONST_PROVIDER_ACCESS then
  begin
    Result:=Format('%S:%S',[AValue,UpperCase(DataBase)]);
  end else
  if UNICTYPE=CONST_PROVIDER_SQLSRV then
  begin
    Result:=Format('%S:%S.%S',[AValue,UpperCase(UNICSRVR),UpperCase(DataBase)]);
  end else
  if UNICTYPE=CONST_PROVIDER_ORACLE then
  begin
    Result:=Format('%S:%S',[AValue,UpperCase(UNICSRVR)]);
  end;    
end;

constructor TUniConfig.Create;
begin
  UNICINDX :=-1;
  WHOBUILD := 1;
  IsDecrypt:=False;
  IsEncrypt:=False;
end;

destructor TUniConfig.Destroy;
begin

  inherited;
end;

class procedure TUniConfig.ReadDS(AUniQuery: TUniQuery;
  var Result: TUniEngine);
begin
  inherited;
  if Result=nil then Exit;

  with TUniConfig(Result) do
  begin
    UNICINDX := AUniQuery.FieldByName('UNIX_IDEX').AsInteger;
    UNICSTAT := AUniQuery.FieldByName('UNIX_STAT').AsInteger;
    UNICYEAR := AUniQuery.FieldByName('UNIX_YEAR').AsInteger;
    UNICMARK := Trim(AUniQuery.FieldByName('UNIX_MARK').AsString);
    UNICTYPE := Trim(AUniQuery.FieldByName('UNIX_TYPE').AsString);
    UNICPSWD := Trim(AUniQuery.FieldByName('UNIX_PSWD').AsString);
    UNICUSER := Trim(AUniQuery.FieldByName('UNIX_USER').AsString);
    UNICSRVR := Trim(AUniQuery.FieldByName('UNIX_SERV').AsString);
    DATABASE := Trim(AUniQuery.FieldByName('DATA_BASE').AsString);
    UNICPORT := Trim(AUniQuery.FieldByName('UNIX_PORT').AsString);
    ISDIRECT := AUniQuery.FieldByName('IS_DIRECT').AsInteger;
    UNICORDR := AUniQuery.FieldByName('UNIX_ORDR').AsInteger;
    
    if AUniQuery.FindField('UNIX_MEMO')<>nil then
    begin
      UNICMEMO := AUniQuery.FieldByName('UNIX_MEMO').AsString;
    end;
  end;
end;

end.
