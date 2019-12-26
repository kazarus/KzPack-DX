unit UniConfig;
//YXC_2012_06_19_12_25_16
//数据库配置类.
//UniConfig
//UniConnct

interface
uses
  Classes, SysUtils, Uni, UniEngine, DB;

type
  TLitConfig = class(TUniEngine)
  private
    FUNICTYPE: string;    //*驱动类型
    FDATABASE: string;    //*数据库
    FUNICUSER: string;    //*用户
    FUNICSRVR: string;    //*服务器
    FUNICPSWD: string;    //*密码
  published
    property UNICTYPE : string READ FUNICTYPE  WRITE FUNICTYPE;
    property DATABASE : string READ FDATABASE  WRITE FDATABASE;
    property UNICUSER : string READ FUNICUSER  WRITE FUNICUSER;
    property UNICSRVR : string READ FUNICSRVR  WRITE FUNICSRVR;
    property UNICPSWD : string READ FUNICPSWD  WRITE FUNICPSWD;
  end;

  TDataBase = class(TUniEngine)
  private
    FDataBase:string;
  published
    property DataBase:string read FDataBase write FDataBase;
  end;

  TUniConfig=class(TUniEngine)
  public
    FUNICINDX: integer;   //配置序列
    FUNICSTAT: integer;   //配置状态
    FUNICYEAR: integer;   //配置年度
    FUNICMARK: string;    //配置代号
    FUNICTYPE: string;    //*驱动类型
    FUNICPSWD: string;    //*密码
    FUNICUSER: string;    //*用户
    FUNICSRVR: string;    //*服务器
    FDATABASE: string;    //*数据库
    FUNICPORT: string;    //*端口号
    FISDIRECT: integer;   //*是否直联
    FUNICORDR: integer;   //排序
    FUNICMEMO: string;    //备注
    FWHOBUILD: integer;   //机器码
  public
    IsDecrypt: Boolean;    //
    IsEncrypt: Boolean;    //
  public
    FListData: TCollection;//*list of *tdatabase;
  protected
    procedure SetParameters;override;
    function  GetStrInsert:string;override;
    function  GetStrUpdate:string;override;
    function  GetStrDelete:string;override;
    function  GetStrsIndex:string;override;
  public
    function  GetNextIdex:integer;overload;
    function  GetNextIdex(AUniConnection:TUniConnection):integer;overload;
    function  GetIsDirect:string;
    function  GetUNICSTAT:string;
    function  GetActvStat: string; overload;
    function  GetActvStat(Value: string): string; overload;
  public
    function  CheckExist(AUniConnection:TUniConnection):Boolean;override;
    function  toLittle:TLitConfig;
    function  toAccess:string;
  public
    function  TstConnection(uCnfg:TUniConfig):Boolean;
  protected
    function  GetLISTDATA:TCollection;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property UNICINDX: integer READ FUNICINDX WRITE FUNICINDX;
    property UNICSTAT: integer READ FUNICSTAT WRITE FUNICSTAT;
    property UNICYEAR: integer READ FUNICYEAR WRITE FUNICYEAR;
    property UNICMARK: string READ FUNICMARK WRITE FUNICMARK;
    property UNICTYPE: string READ FUNICTYPE WRITE FUNICTYPE;
    property UNICPSWD: string READ FUNICPSWD WRITE FUNICPSWD;
    property UNICUSER: string READ FUNICUSER WRITE FUNICUSER;
    property UNICSRVR: string READ FUNICSRVR WRITE FUNICSRVR;
    property DATABASE: string READ FDATABASE WRITE FDATABASE;
    property UNICPORT: string READ FUNICPORT WRITE FUNICPORT;
    property ISDIRECT: integer READ FISDIRECT WRITE FISDIRECT;
    property UNICORDR: integer READ FUNICORDR WRITE FUNICORDR;
    property UNICMEMO: string READ FUNICMEMO WRITE FUNICMEMO;
    property WHOBUILD: integer READ FWHOBUILD WRITE FWHOBUILD;
  published
    property ListDATA: TCollection read GetLISTDATA write FListData;
  public
    class function  ReadDS(AUniQuery: TUniQuery): TUniEngine; override;
    class procedure ReadDS(AUniQuery: TUniQuery; var Result: TUniEngine); override;

    class function  CopyIt(uCnfg: TUniConfig): TUniConfig; overload;
    class procedure CopyIt(uCnfg: TUniConfig; var Result: TUniConfig); overload;

    class function  CopyIt(aUniEngine: TUniEngine): TUniEngine; overload; override;
    class procedure CopyIt(aUniEngine: TUniEngine; var Result: TUniEngine)overload; override;
  public
    class procedure Initialize(ADataBase:string='-1');
    class function  ADD_TBL_UNICNFG:string;
    class function  ADD_TBL_UNIDICT:string;
  end;



   
const
  CONST_DB_UNICONFIG    = 'config.db';
  
  CONST_PROVIDER_SQLSRV = 'SQL Server';
  CONST_PROVIDER_ORACLE = 'Oracle';
  CONST_PROVIDER_ACCESS = 'Access';
  CONST_PROVIDER_SQLITE = 'SQLite';
  CONST_PROVIDER_MYSQLX = 'MySQL';
  CONST_PROVIDER_POSTGR = 'PostgreSQL';


implementation

uses
  Helpr_UniEngine,Class_KzUtils;

function TUniConfig.CheckExist(AUniConnection: TUniConnection): Boolean;
begin

end;

function TUniConfig.GetNextIdex: integer;
begin

end;


function TUniConfig.GetNextIdex(AUniConnection: TUniConnection): integer;
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
    TempA:=Trim(UniQuery.FieldByName('MAX').Asstring);
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
  Result := UnicMark;
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
  Result := TUniConfig.Create;
  ReadDS(AUniQuery, Result);
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

function TUniConfig.toAccess: string;
var
  Little:TLitConfig;
begin
  try
    Little := self.toLittle;
    Result := Little.ToJSON();
  finally
    FreeAndNil(Little);
  end;
end;

function TUniConfig.toLittle: TLitConfig;
begin
  Result := TLitConfig.Create;
  Result.UnicType := self.UnicType;
  Result.DataBase := self.DataBase;
  Result.UnicUser := self.UnicUser;
  Result.UnicPswd := self.UnicPswd;
  Result.UnicSrvr := self.UnicSrvr;
end;

function TUniConfig.GetIsDirect: string;
begin
  Result := '否';
  if IsDirect = 1 then
  begin
    Result := '是';
  end;
end;

function TUniConfig.GetLISTDATA: TCollection;
begin
  if FLISTDATA = nil then
  begin
    FLISTDATA := TCollection.Create(TDataBase);
  end;

  Result:=FLISTDATA;
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
  Result := '挂起';
  if UNICSTAT = 1 then
  begin
    Result := '活动';
  end;
end;

function TUniConfig.GetActvStat: string;
begin
  if UNICTYPE = CONST_PROVIDER_ACCESS then
  begin
    Result := Format('当前连接:%S', [UpperCase(DataBase)]);
  end else
  if UNICTYPE = CONST_PROVIDER_SQLSRV then
  begin
    Result := Format('当前连接:%S.%S', [UpperCase(UNICSRVR), UpperCase(DataBase)]);
  end else
  if UNICTYPE = CONST_PROVIDER_ORACLE then
  begin
    Result := Format('当前连接:%S', [UpperCase(UNICSRVR)]);
  end;
end;

function TUniConfig.GetActvStat(Value: string): string;
begin
  if UNICTYPE = CONST_PROVIDER_ACCESS then
  begin
    Result := Format('%S:%S', [Value, UpperCase(DataBase)]);
  end else
  if UNICTYPE = CONST_PROVIDER_SQLSRV then
  begin
    Result := Format('%S:%S.%S', [Value, UpperCase(UNICSRVR), UpperCase(DataBase)]);
  end else
   if UNICTYPE = CONST_PROVIDER_ORACLE then
  begin
    Result := Format('%S:%S', [Value, UpperCase(UNICSRVR)]);
  end;
end;

constructor TUniConfig.Create;
begin
  UNICINDX := -1;
  WHOBUILD := 1;
  IsDecrypt := False;
  IsEncrypt := False;
end;

destructor TUniConfig.Destroy;
begin
  if FListData <> nil then TKzUtils.TryFreeAndNil(FListData);

  inherited;
end;

class procedure TUniConfig.ReadDS(AUniQuery: TUniQuery;
  var Result: TUniEngine);
var
  I: integer;
  Field: TField;
  FieldName: string;
begin
  if Result = nil then Exit;

  with TUniConfig(Result) do
  begin
    for I:=0 to aUniQuery.Fields.Count-1 do
    begin
      Field := aUniQuery.Fields.Fields[I];
      //if field.fieldname is not all uppercase,please use uppercase().
      FieldName := UpperCase(Field.FieldName);
      if FieldName = 'UNIX_IDEX' then
      begin
        UNICINDX  := Field.AsInteger;
      end else
      if FieldName = 'UNIX_STAT' then
      begin
        UNICSTAT  := Field.AsInteger;
      end else
      if FieldName = 'UNIX_YEAR' then
      begin
        UNICYEAR  := Field.AsInteger;
      end else
      if FieldName = 'UNIX_MARK' then
      begin
        UNICMARK  := Field.AsString;
      end else
      if FieldName = 'UNIX_TYPE' then
      begin
        UNICTYPE  := Field.AsString;
      end else
      if FieldName = 'UNIX_PSWD' then
      begin
        UNICPSWD  := Field.AsString;
      end else
      if FieldName = 'UNIX_USER' then
      begin
        UNICUSER  := Field.AsString;
      end else
      if FieldName = 'UNIX_SERV' then
      begin
        UNICSRVR  := Field.AsString;
      end else
      if FieldName = 'DATA_BASE' then
      begin
        DATABASE  := Field.AsString;
      end else
      if FieldName = 'UNIX_PORT' then
      begin
        UNICPORT  := Field.AsString;
      end else
      if FieldName = 'IS_DIRECT' then
      begin
        ISDIRECT  := Field.AsInteger;
      end else
      if FieldName = 'UNIX_ORDR' then
      begin
        UNICORDR  := Field.AsInteger;
      end else
      if FieldName = 'UNIX_MEMO' then
      begin
        UNICMEMO  := Field.AsString;
      end;
    end;
  end;
end;

class function TUniConfig.CopyIt(aUniEngine: TUniEngine): TUniEngine;
begin
  Result := TUniConfig.Create;
  TUniEngine.CopyIt(aUniEngine,Result);
end;

class procedure TUniConfig.CopyIt(aUniEngine: TUniEngine;
  var Result: TUniEngine);
begin
  if Result = nil then Exit;
  TUniConfig.CopyIt(TUniConfig(aUniEngine),TUniConfig(Result));
end;

end.
