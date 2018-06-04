unit UniFieldX;

interface
uses
  Classes,SysUtils,Uni,UniEngine,UniConfig,StrUtils{$IFDEF MSWINDOWS},ADODB,DB{$IFEND};

type
  TSqlExecuteMode=(semUpdate,semInsert);
  
  TUniFieldX=class(TUniEngine)
  private
    FCOLINDEX: Integer;
    FTABLNAME: string; //ETC:TBL_UNIT
    FCOLVNAME: string; //ETC:UNIT_LINK
    FCOLVTYPE: Integer;//ETC:167
    FTYPENAME: string; //ETC:VARCHAR,from:type_name
    FDATASIZE: Integer;//ETC:18,from:precision
    FDATASCAL: Integer;//ETC:4,from:scale
  private
    FDATATYPE: string; //ETC:INTEGER,STRING
    FOBJTNAME: string; //ETC:UNITLINK
    FPROPNAME: string; //ETC:UNITLINK
  private
    FIsKey   : Boolean;
    FIsInc   : Boolean;
  protected
    procedure SetParameters;override;
    function  GetStrInsert:string;override;
    function  GetStrUpdate:string;override;
    function  GetStrDelete:string;override;
  public
    function  GetStrsIndex:string;override;
  public
    function  CheckExist(AUniConnection:TUniConnection):Boolean;override;
    function  GetAsValue:string;
    function  GetPropName(AValue:string):string;//以'_'为间隔
    function  GetObjtName(AValue:string):string;//没有'_'间隔
    function  GetDataType(AValue:string):string;
  published
    property  COLINDEX:Integer read FCOLINDEX write FCOLINDEX;
    property  TABLNAME:string  read FTABLNAME write FTABLNAME;
    property  COLVNAME:string  read FCOLVNAME write FCOLVNAME;
    property  COLVTYPE:Integer read FCOLVTYPE write FCOLVTYPE;
    property  TYPENAME:string  read FTYPENAME write FTYPENAME;
    property  DATASIZE:Integer read FDATASIZE write FDATASIZE;
    property  DATASCAL:Integer read FDATASCAL write FDATASCAL;
  published
    property  DATATYPE:string  read FDATATYPE write FDATATYPE;
    property  OBJTNAME:string  read FOBJTNAME write FOBJTNAME;
    property  PROPNAME:string  read FPROPNAME write FPROPNAME;
  published
    property  IsKey   :Boolean read FIsKey    write FIsKey;
    property  IsInc   :Boolean read FIsInc    write FIsInc;
  public
    class function  ReadDS(aUniQuery: TUniQuery): TUniEngine; override;
    class procedure ReadDS(aUniQuery: TUniQuery; var Result: TUniEngine); override;

    class function  CopyIt(aUniFieldX:TUniFieldX):TUniFieldX;overload;
    class procedure CopyIt(aUniFieldX:TUniFieldX;var Result:TUniFieldX);overload;

    class function  CopyIt(aUniEngine:TUniEngine):TUniEngine;overload;override;
    class procedure CopyIt(aUniEngine:TUniEngine;var Result:TUniEngine)overload;override;
  public
    class function  GetListCols(aTabl:string;AUniConnection:TUniConnection):TStringList;
  public
    class function  ExpSQLInSQLSRV:string;overload;
    class function  ExpSQLInORACLE:string;overload;

    class function  ExpSqlInSQLSRV(aTabl:string):string;overload;
    class function  ExpSqlInORACLE(aTabl:string):string;overload;
    class function  ExpSQLInPOSTGR(aTabl:string):string;overload;

    class function  ExpSqlInSQLSRV(aTabl:string;aColv:string):string;overload;
    class function  ExpSqlInORACLE(aTabl:string;aColv:string):string;overload;
  public
    {$IFDEF MSWINDOWS}
    class function GetKeyInACCESS(aTabl,ADataBase:string):TStringList;overload;
    class function GetKeyInACCESS(aTabl:string;AUniConfig:TUniConfig):TStringList;overload;

    class function CheckExistKeyInACCESS(AConstraintType,AConstraintName,aTabl:string;ADataBase:string):Boolean;overload;
    class function CheckExistKeyInACCESS(AConstraintType,AConstraintName,aTabl:string;AADOConnection:TADOConnection):Boolean;overload;
    {$IFEND}
  end;

  TIdentity=class(TUniEngine)
  public
    Name:string;
  public
    function  GetStrsIndex:string;override;
  public
    class function ReadDS(AUniQuery:TUniQuery):TUniEngine;override;      
  end;

implementation

uses
  Variants;


{ TUniFieldX }

function TUniFieldX.CheckExist(AUniConnection: TUniConnection): Boolean;
begin

end;



class function TUniFieldX.ExpSqlInSQLSRV(aTabl: string): string;
begin
  Result:='SELECT SYSCOLUMNS.COLID AS COLINDEX,SYSCOLUMNS.NAME AS COLVNAME,SYSCOLUMNS.XTYPE AS COLVTYPE,SYSTYPES.NAME AS TYPENAME,SYSCOLUMNS.PREC AS DATASIZE,SYSCOLUMNS.SCALE AS DATASCAL,'
         +'    CASE WHEN EXISTS(SELECT 1 FROM SYSINDEXKEYS WHERE ID =OBJECT_ID($TABL) AND COLID=SYSCOLUMNS.COLID'
         +'        AND INDID = (SELECT INDID FROM SYSINDEXES WHERE NAME =(SELECT NAME FROM SYSOBJECTS WHERE XTYPE=$PK AND PARENT_OBJ=OBJECT_ID($TABL)))) '
         +'    THEN 1 ELSE 0 END AS ISKEY'
         +'    FROM SYSCOLUMNS'
         +'    INNER JOIN SYSOBJECTS  ON SYSOBJECTS.ID=SYSCOLUMNS.ID'
         +'    INNER JOIN SYSTYPES   ON SYSCOLUMNS.XTYPE=SYSTYPES.XTYPE AND SYSTYPES.XUSERTYPE<256'
         +'    WHERE SYSOBJECTS.XTYPE=$U AND SYSOBJECTS.NAME=$TABL'
         +'    ORDER BY SYSOBJECTS.ID,SYSCOLUMNS.COLID';
  Result:=StringReplace(Result,'$PK',QuotedStr('PK'),[rfReplaceAll]);
  Result:=StringReplace(Result,'$U',QuotedStr('U'),[rfReplaceAll]);
  Result:=StringReplace(Result,'$TABL',QuotedStr(aTabl),[rfReplaceAll]);
end;

function TUniFieldX.GetStrDelete: string;
begin

end;

function TUniFieldX.GetStrInsert: string;
begin

end;

function TUniFieldX.GetStrsIndex: string;
begin
  Result := Format('%S-%S',[TablName,ColvName]);
end;

function TUniFieldX.GetStrUpdate: string;
begin

end;

class procedure TUniFieldX.ReadDS(AUniQuery: TUniQuery; var Result: TUniEngine);
var
  I:Integer;
  Field:TField;
  FieldName:string;
begin
  if Result = nil then Exit;

  with TUniFieldX(Result) do
  begin
    for I:=0 to aUniQuery.Fields.Count-1 do
    begin
      Field := aUniQuery.Fields.Fields[I];
      //if field.fieldname is not all uppercase,please use uppercase().
      FieldName := UpperCase(Field.FieldName);
      if FieldName = 'COLINDEX' then
      begin
        COLINDEX  := Field.AsInteger;
      end else
      if FieldName = 'TABLNAME' then
      begin
        TABLNAME  := Field.AsString;
      end else
      if FieldName = 'COLVNAME' then
      begin
        COLVNAME  := Field.AsString;
        ObjtName  := GetObjtName(ColvName);
        PropName  := GetObjtName(ColvName);
      end else
      if FieldName = 'COLVTYPE' then
      begin
        COLVTYPE  := Field.AsInteger;
      end else
      if FieldName = 'TYPENAME' then
      begin
        TYPENAME  := UpperCase(Field.AsString);
        DataType  := GetDataType(TypeName);
      end else
      if FieldName = 'DATASIZE' then
      begin
        DATASIZE  := Field.AsInteger;
      end else
      if FieldName = 'DATASCAL' then
      begin
        DATASCAL  := Field.AsInteger;
      end else
      if FieldName = 'ISKEY' then
      begin
        IsKey     := Field.AsInteger = 1;
      end;

      IsInc := False;
    end
  end;
end;

class function TUniFieldX.ReadDS(AUniQuery: TUniQuery): TUniEngine;
begin
  Result := TUniFieldX.Create;
  ReadDS(AUniQuery, Result);
end;

procedure TUniFieldX.SetParameters;
begin
  inherited;

end;

class function TUniFieldX.GetListCols(aTabl: string;
  AUniConnection: TUniConnection): TStringList;
var
  SQLA:string;  
begin
  if Pos('[',aTabl)>0 then
  begin
    aTabl:=StringReplace(aTabl,'[','',[rfReplaceAll]);
  end;

  if Pos(']',aTabl)>0 then
  begin
    aTabl:=StringReplace(aTabl,']','',[rfReplaceAll]);
  end;  

  if AUniConnection.ProviderName=CONST_PROVIDER_ACCESS then
  begin
    raise Exception.Create('ERROR:UniFieldx.pas.TUniFieldX.GetListCols.LINE:131.INFO:No Support');
  end else
  if AUniConnection.ProviderName=CONST_PROVIDER_SQLSRV then
  begin
    SQLA:=ExpSqlInSQLSRV(aTabl);
  end else
  if AUniConnection.ProviderName=CONST_PROVIDER_ORACLE then
  begin
    SQLA:=ExpSqlInORACLE(aTabl);
  end else
  if AUniConnection.ProviderName=CONST_PROVIDER_POSTGR then
  begin
    SQLA:=ExpSQLInPOSTGR(LowerCase(aTabl));
  end;

  Result:=ListDB(SQLA,AUniConnection,False);
end;

function TUniFieldX.GetAsValue: string;
begin
  if DataType='Integer' then
  begin
    Result:='AsInteger';
  end else
  if DataType='string' then
  begin
    Result:='AsString';
  end else
  if DataType='Extended' then
  begin
    Result:='AsFloat';
  end else  
  if DataType='Double' then 
  begin
    Result:='AsFloat';
  end else
  if DataType='Boolean' then
  begin
    Result:='AsBoolean';
  end else
  if DataType='TDateTime' then
  begin
    Result:='AsDateTime';
  end;  
end;

function TUniFieldX.GetObjtName(AValue: string): string;
begin
  Result:=StringReplace(AValue,'_','',[rfReplaceAll]);
end;

function TUniFieldX.GetPropName(AValue: string): string;
var
  I:Integer;  
  StrsA:TStringList;
  TempA:string;
  TempB:string;
  TempC:string;
begin
  Result:='';
  if Pos('_',AValue)=0 then
  begin
    Result:=AValue;
    Exit;
  end;  

  StrsA:=TStringList.Create;
  StrsA.Delimiter:='_';
  StrsA.DelimitedText:=AValue;

  for I:=0 to StrsA.Count-1 do
  begin
    TempA:=StrsA.Strings[I];

    TempB:=Copy(TempA,1,1);
    TempC:=Copy(TempA,2,MaxInt);

    TempB:=UpperCase(TempB);
    TempC:=LowerCase(TempC);

    Result:=Result+TempB+TempC;
  end;  

  FreeAndNil(StrsA);  
end;


function TUniFieldX.GetDataType(AValue: string): string;
begin
  if AValue='BINARY' then
  begin
    Result:='TMemoryStream';
  end else
  if AValue='IMAGE' then
  begin
    Result:='TMemoryStream';
  end else
  if AValue='INT4' then
  begin
    Result:='Integer';
  end else
  if AValue='INT' then
  begin
    Result:='Integer';
  end else
  if AValue='VARCHAR' then
  begin
    Result:='string';
  end else
  if AValue='MONEY' then
  begin
    Result:='Extended';
  end else
  if AValue='FLOAT8' then
  begin
    Result:='Extended';
  end else
  if AValue='DATETIME' then
  begin
    Result:='TDateTime';
  end else
  if AValue='CHAR' then
  begin
    Result:='string';
  end else
  if AValue='TEXT' then
  begin
    Result:='TStringStream';
  end else
  if AValue='NUMERIC' then
  begin
    Result:='Integer';
  end else
  if AValue='NTEXT' then
  begin
    Result:='TStringStream';
  end else
  if AValue='SMALLINT' then
  begin
    Result:='Integer';
  end else
  if AValue='DECIMAL' then
  begin
    Result:='Extended';
  end else
  if AValue='FLOAT' then
  begin
    Result:='Extended';
  end else
  if AValue='NVARCHAR' then
  begin
    Result:='string';
  end else
  if AValue='TINYINT' then
  begin
    Result:='Integer';
  end else
  if AValue='REAL' then
  begin
    Result:='Extended';
  end else
  if AValue='SMALLDATETIME' then
  begin
    Result:='TDateTime'
  end else
  if AValue='TIMESTAMP' then
  begin
    Result:='string'
  end else
  if AValue='BIT' then
  begin
    Result:='Boolean';
  end else                                       //follows are oracle's datatype
  if AValue='NUMBER' then
  begin
    Result:='Extended';
  end else
  if AValue='VARCHAR2' then
  begin
    Result:='string';
  end else
  if AValue='DATE' then
  begin
    Result:='TDateTime';
  end else
  if AValue='CLOB' then
  begin
    Result:='TStringStream';
  end else
  begin
    Result:=Format('<unkown>:%S',[AValue]);
  end;
end;

{$IFDEF MSWINDOWS}
class function TUniFieldX.GetKeyInACCESS(aTabl: string;
  AUniConfig: TUniConfig): TStringList;
var
  I:Integer;
  PrimaryKey    :string;
  AADOTable     :TADOTable;
  AADOConnection:TADOConnection;
begin
  Result:=nil;
  if AUniConfig=nil then Exit;
  if AUniConfig.UnicType<>CONST_PROVIDER_ACCESS then Exit;

  Result:=GetKeyInACCESS(aTabl,AUniConfig.DataBase);
end;

class function TUniFieldX.GetKeyInACCESS(aTabl,
  ADataBase: string): TStringList;
var
  I:Integer;
  PrimaryKey    :string;
  AADOTable     :TADOTable;
  AADOConnection:TADOConnection;
begin
  Result:=nil;
  aTabl:=StringReplace(aTabl,'[','',[rfReplaceAll]);
  aTabl:=StringReplace(aTabl,']','',[rfReplaceAll]);
    
  if Trim(aTabl)=''     then Exit;
  if Trim(ADataBase)='' then Exit;

  PrimaryKey:='';
  try
    AADOConnection:=TADOConnection.Create(nil);
    AADOConnection.ConnectionString:=Format('Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%S;Persist Security Info=False',[ADataBase]);
    AADOConnection.LoginPrompt:=False;
    AADOConnection.Connected:=True;

    AADOTable     :=TADOTable.Create(nil);
    AADOTable.Connection:=AADOConnection;
    AADOTable.TableName :=aTabl;
    AADOTable.Active    :=False;
    AADOTable.IndexDefs.Update;

    for I := 0 to AADOTable.IndexDefs.Count - 1 do
    begin
      if ixprimary in AADOTable.IndexDefs[I].Options then
      begin
        PrimaryKey := PrimaryKey + AADOTable.IndexDefs.Items[I].Fields;
      end;  
    end;
  finally
    FreeAndNil(AADOConnection);
    FreeAndNil(AADOTable);
  end;

  if PrimaryKey<>'' then
  begin
    Result:=TStringList.Create;
    Result.Delimiter:=';';
    Result.DelimitedText:=PrimaryKey;
  end;  
end;



class function TUniFieldX.CheckExistKeyInACCESS(AConstraintType,
  AConstraintName, aTabl: string; AADOConnection: TADOConnection): Boolean;
var
  ADataSet:TADODataSet;
  ConstraintName:string;
begin
  Result:=False;
  
  try
    ADataSet:=TADODataSet.Create(nil);

    if AConstraintType='PK' then
    begin
      AADOConnection.OpenSchema(siPrimaryKeys,VarArrayOf([Unassigned, Unassigned, aTabl]),EmptyParam,ADataSet);
      if ADataSet.RecordCount=0 then Exit;

      ADataSet.First;
      while not ADataSet.Eof do
      begin
        ConstraintName:=ADataSet.FieldByName('PK_NAME').AsString;
        if ConstraintName = AConstraintName then
        begin
          Result:=True;
          Break;
        end;
        ADataSet.Next;
      end;
    end else
    if AConstraintType='FK' then
    begin
      AADOConnection.OpenSchema(siForeignKeys,VarArrayOf([Unassigned, Unassigned, aTabl]),EmptyParam,ADataSet);
      if ADataSet.RecordCount=0 then Exit;

      ADataSet.First;
      while not ADataSet.Eof do
      begin
        ConstraintName:=ADataSet.FieldByName('FK_NAME').AsString;
        if ConstraintName = AConstraintName then
        begin
          Result:=True;
          Break;
        end;
        ADataSet.Next;
      end;      
    end;    
  finally
    FreeAndNil(ADataSet);
  end;
end;

{$IFEND}

class function TUniFieldX.CopyIt(aUniFieldX: TUniFieldX): TUniFieldX;
begin
  Result:=TUniFieldX.Create;
  TUniFieldX.CopyIt(aUniFieldX,Result);
end;

class procedure TUniFieldX.CopyIt(aUniFieldX: TUniFieldX;
  var Result: TUniFieldX);
begin
  if Result=nil then  Exit;
  if aUniFieldX=nil then Exit;

  Result.ColIndex := aUniFieldX.ColIndex;
  Result.TablName := aUniFieldX.TablName;
  Result.ColvName := aUniFieldX.ColvName;
  Result.ColvType := aUniFieldX.ColvType;
  Result.TypeName := aUniFieldX.TypeName;
  Result.DataSize := aUniFieldX.DataSize;
  Result.DataType := aUniFieldX.DataType;
  Result.ObjtName := aUniFieldX.ObjtName;
  Result.PropName := aUniFieldX.PropName;

  Result.IsKey    := aUniFieldX.IsKey;
  Result.IsInc    := aUniFieldX.IsInc;
end;

class function TUniFieldX.CopyIt(aUniEngine: TUniEngine): TUniEngine;
begin
  Result := TUniFieldX.Create;
  TUniEngine.CopyIt(aUniEngine,Result);
end;

class procedure TUniFieldX.CopyIt(aUniEngine: TUniEngine;
  var Result: TUniEngine);
begin
  if Result = nil then Exit;
  TUniFieldX.CopyIt(TUniFieldX(aUniEngine),TUniFieldX(Result));
end;

{$IFDEF MSWINDOWS}
class function TUniFieldX.CheckExistKeyInACCESS(AConstraintType,
  AConstraintName, aTabl, ADataBase: string): Boolean;
var
  ADOConnection:TADOConnection;
begin
  Result:=False;
  try
    ADOConnection:=TADOConnection.Create(nil);
    ADOConnection.ConnectionString:=Format('Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%S;Persist Security Info=False',[ADataBase]);
    ADOConnection.LoginPrompt:=False;
    ADOConnection.Connected:=True;

    Result:=CheckExistKeyInACCESS(AConstraintType,AConstraintName,aTabl,ADOConnection);
  finally
    FreeAndNil(ADOConnection);
  end;
end;
{$IFEND}

class function TUniFieldX.ExpSqlInORACLE(aTabl: string): string;
begin
  Result:='SELECT COLUMN_ID AS COLINDEX,COLUMN_NAME AS COLVNAME,1 AS COLVTYPE,DATA_TYPE AS TYPENAME,DATA_LENGTH AS DATASIZE,'
         +'    CASE WHEN EXISTS (SELECT 1 FROM USER_CONS_COLUMNS WHERE TABLE_NAME=$TABL AND POSITION >0 AND USER_CONS_COLUMNS.COLUMN_NAME=USER_TAB_COLUMNS.COLUMN_NAME) THEN 1 ELSE 0 END AS ISKEY'
         +'    FROM USER_TAB_COLUMNS'
         +'    WHERE  TABLE_NAME=$TABL ORDER BY COLUMN_ID';
  Result:=StringReplace(Result,'$TABL',QuotedStr(aTabl),[rfReplaceAll]);
end;

class function TUniFieldX.ExpSQLInORACLE: string;
begin

end;

class function TUniFieldX.ExpSQLInORACLE(aTabl, aColv: string): string;
begin
  Result:='SELECT COLUMN_ID AS COLINDEX,COLUMN_NAME AS COLVNAME,1 AS COLVTYPE,DATA_TYPE AS TYPENAME,DATA_LENGTH AS DATASIZE,'
         +'    CASE WHEN EXISTS (SELECT 1 FROM USER_CONS_COLUMNS WHERE TABLE_NAME=$TABL AND POSITION >0 AND USER_CONS_COLUMNS.COLUMN_NAME=USER_TAB_COLUMNS.COLUMN_NAME) THEN 1 ELSE 0 END AS ISKEY'
         +'    FROM USER_TAB_COLUMNS'
         +'    WHERE  TABLE_NAME=$TABL AND COLUMN_NAME=$COLV ORDER BY COLUMN_ID';
  Result:=StringReplace(Result,'$TABL',QuotedStr(aTabl),[rfReplaceAll]);
  Result:=StringReplace(Result,'$COLV',QuotedStr(aColv),[rfReplaceAll]);
end;

class function TUniFieldX.ExpSQLInPOSTGR(aTabl: string): string;
begin
  Result:='SELECT ATTNUM AS COLINDEX,ATTNAME AS COLVNAME,1 AS COLVTYPE,PG_TYPE.TYPNAME AS TYPENAME,PG_TYPE.TYPLEN AS DATASIZE ,'
         +'    CASE WHEN EXISTS (SELECT 1 FROM PG_CONSTRAINT WHERE PG_CONSTRAINT.CONRELID = PG_CLASS.OID  AND PG_CONSTRAINT.CONTYPE=%S AND ATTNUM = ANY(CONKEY) ) THEN 1 ELSE 0 END AS ISKEY'
         +'    FROM PG_ATTRIBUTE'
         +'    LEFT JOIN PG_TYPE ON PG_TYPE.OID = PG_ATTRIBUTE.ATTTYPID'
         +'    LEFT JOIN PG_CLASS ON  PG_ATTRIBUTE.ATTRELID = PG_CLASS.OID'
         +'    WHERE PG_CLASS.RELNAME = %S AND ATTSTATTARGET=-1';
  Result:=Format(Result,[QuotedStr('p'),QuotedStr(aTabl)]);
end;

class function TUniFieldX.ExpSQLInSQLSRV(aTabl, aColv: string): string;
begin
  Result:='SELECT SYSCOLUMNS.COLID AS COLINDEX,SYSCOLUMNS.NAME AS COLVNAME,SYSCOLUMNS.XTYPE AS COLVTYPE,SYSTYPES.NAME AS TYPENAME,SYSCOLUMNS.PREC AS DATASIZE,SYSCOLUMNS.SCALE AS DATASCAL,'
         +'    CASE WHEN EXISTS(SELECT 1 FROM SYSINDEXKEYS WHERE ID =OBJECT_ID($TABL) AND COLID=SYSCOLUMNS.COLID'
         +'        AND INDID = (SELECT INDID FROM SYSINDEXES WHERE NAME =(SELECT NAME FROM SYSOBJECTS WHERE XTYPE=$PK AND PARENT_OBJ=OBJECT_ID($TABL)))) '
         +'    THEN 1 ELSE 0 END AS ISKEY'
         +'    FROM SYSCOLUMNS'
         +'    INNER JOIN SYSOBJECTS  ON SYSOBJECTS.ID=SYSCOLUMNS.ID'
         +'    INNER JOIN SYSTYPES   ON SYSCOLUMNS.XTYPE=SYSTYPES.XTYPE AND SYSTYPES.XUSERTYPE<256'
         +'    WHERE SYSOBJECTS.XTYPE=$U AND SYSOBJECTS.NAME=$TABL AND SYSCOLUMNS.NAME=$COLV'
         +'    ORDER BY SYSOBJECTS.ID,SYSCOLUMNS.COLID';
  Result:=StringReplace(Result,'$PK',QuotedStr('PK'),[rfReplaceAll]);
  Result:=StringReplace(Result,'$U',QuotedStr('U'),[rfReplaceAll]);
  Result:=StringReplace(Result,'$TABL',QuotedStr(aTabl),[rfReplaceAll]);
  Result:=StringReplace(Result,'$COLV',QuotedStr(aColv),[rfReplaceAll]);
end;

class function TUniFieldX.ExpSQLInSQLSRV: string;
begin
  Result := 'SELECT A.NAME AS COLVNAME,B.NAME AS TABLNAME,PREC AS DATASIZE,SCALE AS DATASCAL FROM SYSCOLUMNS A'
          + '    LEFT JOIN SYSOBJECTS B ON A.ID=B.ID'
          + '    WHERE B.TYPE=%S'
          + '    ORDER BY B.NAME';

  Result := Format(Result,[QuotedStr('U')]);
end;

function TIdentity.GetStrsIndex: string;
begin
  Result:=Name;
end;

class function TIdentity.ReadDS(AUniQuery: TUniQuery): TUniEngine;
begin
  Result:=TIdentity.Create;
  with TIdentity(Result) do
  begin
    Name:=AUniQuery.FieldByName('NAME').AsString;
  end;
end;

end.
