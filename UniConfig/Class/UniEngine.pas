unit UniEngine;
//YXC_2010_10_19_16_32_21
//YXC_2011_06_14_10_31_40_add_saveitdb.
//YXC_2012_08_03_16_24_54_add_saveitwhennotexist
//YXC_2013_01_17_15_07_31_add_getdataset replacee getuniquery
//YXC_2013_01_17_15_08_10_add_existconst paramters:pk or f.
//YXC_2013_01_17_15_08_32_add_getservdat
//YXC_2014_05_13_21_48_18_add_tojson&injson
//YXC_2014_05_13_21_48_30_add_stridx&strdiy
//YXC_2014_06_11_10_34_05_add_listdb_add_withsorted

//must be override the follow metheds
{
  protected
    procedure SetParameters;override;
    function  GetStrInsert:string;override;
    function  GetStrUpdate:string;override;
    function  GetStrDelete:string;override;
  public  
    function  GetStrsIndex:string;override;    
  public
    function  GetNextIdex:Integer;overload;
    function  GetNextIdex(aUniConnection:TUniConnection):Integer;overload;
  public
    function  CheckExist(aUniConnection:TUniConnection):Boolean;override;
  public
    class function  ReadDS(AUniQuery:TUniQuery):TUniEngine;override;
  public
    class function  CopyIt(aUniEngine:TUniEngine):TUniEngine;overload;override;
    class procedure CopyIt(aUniEngine:TUniEngine;var Result:TUniEngine)overload;override;
}

interface
uses
  Classes,SysUtils,Variants,Uni,Types,TypInfo,Xml.XMLDoc,Xml.XMLIntf;

type
  TUniEngine     =class;
  TUniEngineClass=class of TUniEngine;
  TOperateType   =(otNone, otAddx, otEdit, otDelt,otNormal,otUpperCase,otLowerCase);

  TUniEngine=class(TCollectionItem)
  public
    FStrSQL:string;
    FUniSQL:TUniSQL;
    FOptTyp:TOperateType;
    TablNam:string;
  protected
    function  GetUniSQL:TUniSQL;
  protected
    procedure SetParameters;virtual;abstract;
    function  GetStrInsert:string;virtual;abstract;
    function  GetStrUpdate:string;virtual;abstract;
    function  GetStrDelete:string;virtual;abstract;
    function  GetStrDeltFL:string;virtual;abstract;
  public  
    function  GetStrsIndex:string;virtual;
  public
    procedure InsertDB(aUniConnection:TUniConnection);overload;virtual;
    procedure UpdateDB(aUniConnection:TUniConnection);overload;virtual;
    procedure DeleteDB(aUniConnection:TUniConnection);overload;virtual;
    procedure DeleteFL(aUniConnection:TUniConnection);overload;virtual;
    procedure SaveItDB(aUniConnection:TUniConnection);overload;virtual;
    procedure SaveItWhenNotExist(aUniConnection:TUniConnection);overload;virtual;

    procedure InsertDB;overload;virtual;
    procedure UpdateDB;overload;virtual;
    procedure DeleteDB;overload;virtual;
    procedure DeleteFL;overload;virtual;
    procedure SaveItDB;overload;virtual;

    function  CheckExist(aUniConnection:TUniConnection):Boolean;overload;virtual;

    //@replace with qjson
    //#function  TOJSON(AOperateType:TOperateType=otNormal):string;overload;
    //#procedure INJSON(AValue:string);overload;
    procedure TONODE(aNode:IXMLNode);overload;

    procedure DeleteDB(aTabs:array of string;aSQLWhere:string;aUniConnection:TUniConnection);overload;
  public
    constructor Create; virtual;
  public
    property UniSQL:TUniSQL read GetUniSQL;
  public
    class function  CopyIt(aUniEngine: TUniEngine): TUniEngine; overload; virtual; abstract;
    class procedure CopyIt(aUniEngine: TUniEngine; var Result: TUniEngine); overload; virtual; abstract;

    class function  ReadDS(AUniQuery: TUniQuery): TUniEngine;overload;virtual;abstract;
    class procedure ReadDS(AUniQuery: TUniQuery; var Result: TUniEngine); overload; virtual; abstract;

    class function  ReadDB(aSQL: string; aUniConnection: TUniConnection): TUniEngine; overload; virtual;
    class function  ReadDB(aSQL: string): TUniEngine; overload; virtual;
    class procedure ReadDB(aSQL: string; aUniConnection: TUniConnection; var Result: TUniEngine); overload; virtual;

    class function  StrsDB(aSQL: string; aUniConnection: TUniConnection; withSorted: Boolean = False): TStringList; overload; virtual;
    class function  StrsDB(aSQL: string; withSorted: Boolean = False): TStringList; overload; virtual;

    class function  StrsDB(aSQL: string; Fields: array of string; aUniConnection: TUniConnection; withSorted: Boolean = False): TStringList; overload; virtual;
    class function  StrsDB(aSQL: string; Fields: array of string; withSorted: Boolean = False): TStringList; overload; virtual;

    class function  ListDB(aSQL: string; aUniConnection: TUniConnection; withSorted: Boolean = False): TStringList; overload; virtual;
    class function  ListDB(aSQL: string; withSorted: Boolean = True): TStringList; overload; virtual;

    class function  ListDB(aSQL: string; Fields: array of string; aUniConnection: TUniConnection; withSorted: Boolean = False): TStringList; overload; virtual;
    class function  ListDB(aSQL: string; Fields: array of string; withSorted: Boolean = False): TStringList; overload; virtual;

    class procedure ListDB(aSQL: string; aUniConnection: TUniConnection; var Result: TStringList; withSorted: Boolean = False); overload; virtual;
    class procedure ListDB(aSQL: string; aUniConnection: TUniConnection; var Result: TCollection; withSorted: Boolean = False); overload; virtual;
    class procedure ListDB(aSQL: string; Fields: array of string; aUniConnection: TUniConnection; var Result: TStringList; withSorted: Boolean = False); overload; virtual;


    //@replace with qjson
    //#class function  TOJSON(aList:TStringList;AOperateType:TOperateType=otNormal):string;overload;
    //#class function  TOJSON(AObjt:TUniEngine;AOperateType:TOperateType=otNormal):string;overload;
    //#class procedure INJSON(AValue:string;AClass:TUniEngineClass;var aList:TStringList;ACleanList:Boolean=True);overload;
    //#class procedure INJSON(AValue:string;AClass:TUniEngineClass;var AObjt:TUniEngine;ACleanList:Boolean=True);overload;


    class procedure STRIDX(Args: array of string; aList: TStringList; aSeparator: string = '-'; withQuoted: Boolean = False); overload;
    class function  STRDIY(Args: array of string; aList: TStringList; aSeparator: string = ','; withQuoted: Boolean = False): string; overload;
    class function  STRDIY(Args: array of string; aList: TCollection; aSeparator: string = ','; bSeparator: string = '-'; withQuoted: Boolean = False): string; overload;

    //#s:source;t:target
    //#tstringlist->
    class procedure CopyIt(sList: TStringList; var tList: TCollection); overload;
    class procedure CopyIt(sList: TStringList; var tList: TStringList; aClass: TUniEngineClass); overload;
    //#tcollection->
    class procedure CopyIt(sList: TCollection; var tList: TCollection); overload;
    class procedure CopyIt(sList: TCollection; var tList: TStringList; aClass: TUniEngineClass); overload;


    class function  GetUniQuery(aSQL: string; aUniConnection: TUniConnection; aFetchAll: Boolean = False): TUniQuery; overload;
    class function  GetUniQuery(aSQL: string): TUniQuery; overload;

    class function  GetDataSet(aSQL: string; aUniConnection: TUniConnection; aFetchAll: Boolean = False): TUniQuery; overload;
    class function  GetDataSet(aSQL: string): TUniQuery; overload;
    class procedure GetDataSet(aSQL: string; Fields: array of string; aUniConnection: TUniConnection; var Result: TStringList; aSeparator: string = ','; aFetchAll: Boolean = False); overload;

    class function  GetServDat(aUniConnection: TUniConnection): TDateTime;

    class function  CheckExist(aTable: string; Args: array of Variant): Boolean; overload;
    class function  CheckField(aField, aTable: string; Args: array of Variant): Integer; overload;

    class function  CheckExist(aTable: string; Args: array of Variant; aUniConnection: TUniConnection; aSQLAddition: string = ''): Boolean; overload;
    class function  CheckField(aField, aTable: string; Args: array of Variant; aUniConnection: TUniConnection; aSQLAddition: string = ''): Integer; overload;
    class function  CheckCount(aField, aTable: string; Args: array of Variant; aUniConnection: TUniConnection; aSQLAddition: string = ''): Integer; overload;
    class function  CheckField(aSQL: string; aAsField: string; aUniConnection: TUniConnection): Variant; overload;
    class function  CheckField(aSQL: string; aAsField: string; aUniConnection: TUniConnection; aDefault: Variant): Variant; overload;

    class function  ExistTable(aTable: string; aUniConnection: TUniConnection): Boolean;
    class function  ExistField(aTable, aField: string; aUniConnection: TUniConnection): Boolean;
    class function  ExistFieldInOracle(aTable, aField: string; aUniConnection: TUniConnection): Boolean;
    class function  ExistConst(aConstraintType, aConstraintName: string; aUniConnection: TUniConnection): Boolean;
    class function  ExistIndex(aIndexName: string; aUniConnection: TUniConnection): Boolean;

    class function  ExistInKey(aConstraintType, aField, aTable: string; aUniConnection: TUniConnection): Boolean;
    class function  AlterField(aTable, aField: string; length: Integer; aUniConnection: TUniConnection): Boolean;

    class procedure toDropView(aSQL: string; aUniConnection: TUniConnection; aUpperCase: Boolean = False); overload;
    class procedure ExecuteSQL(aSQL: string; aUniConnection: TUniConnection; aUpperCase: Boolean = False); overload;
    class procedure ExecuteSQL(aSQL: string); overload;
  end;

implementation

uses
  UniConfig, Class_KzDebug;


class function TUniEngine.CheckExist(aTable: string;
  Args: array of Variant): Boolean;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.CheckExist] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

function TUniEngine.CheckExist(aUniConnection: TUniConnection): Boolean;
begin
  
end;

class function TUniEngine.CheckField(aField, aTable: string;
  Args: array of Variant): Integer;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.CheckField] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

procedure TUniEngine.DeleteDB(aUniConnection: TUniConnection);
begin
  try
    FStrSQL:=GetStrDelete;
    if FStrSQL='' then raise Exception.Create('you must be override getstrdelete method');

    FOptTyp:=otDelt;

    UniSQL.Connection:=aUniConnection;
    
    FUniSQL.SQL.Text :=FStrSQL;

    SetParameters;
    try
      FUniSQL.Execute;
    except
      On E:Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FUniSQL);
  end;
end;

procedure TUniEngine.DeleteDB;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.DeleteDB] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

procedure TUniEngine.DeleteDB(aTabs: array of string; aSQLWhere: string;
  aUniConnection: TUniConnection);
var
  I:Integer;
  cSQL:string;
begin
  for I := 0 to Length(aTabs)-1 do
  begin
    cSQL := Format('DELETE FROM %s WHERE 1=1 AND %s',[aTabs[I],aSQLWhere]);
    ExecuteSQL(cSQL,aUniConnection);
  end;
end;

procedure TUniEngine.DeleteFL;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.DeleteFL] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

procedure TUniEngine.DeleteFL(aUniConnection: TUniConnection);
begin
  try
    FStrSQL:=GetStrDeltFL;
    if FStrSQL='' then raise Exception.Create('you must be override getstrdeltfl method');
    FOptTyp:=otDelt;
    
    UniSQL.Connection:=aUniConnection;
    FUniSQL.SQL.Text :=FStrSQL;    

    SetParameters;
    
    try
      FUniSQL.Execute;
    except
      On E:Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FUniSQL);
  end;
end;

procedure TUniEngine.SaveItDB;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.SaveItDB] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

procedure TUniEngine.SaveItDB(aUniConnection: TUniConnection);
begin
  if CheckExist(aUniConnection) then
  begin
    UpdateDB(aUniConnection);
  end else
  begin
    InsertDB(aUniConnection);
  end;
end;

class procedure TUniEngine.ExecuteSQL(aSQL: string);
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.ExecuteSQL] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

class procedure TUniEngine.ExecuteSQL(aSQL: string; aUniConnection: TUniConnection; aUpperCase: Boolean);
var
  UniSQL: TUniSQL;
begin
  if Trim(aSQL) = '' then Exit;

  //#兼容性处理
  //#ORABLE:不支持BIGINT=NUMBER;
  //#ORABLE:不支持语句末尾分号;
  //#ORABLE:不支持ON UPDATE CASCADE;
  //#ORACLE:不支持TEXT=CLOB;
  if aUniConnection.ProviderName = UniConfig.CONST_PROVIDER_ORACLE then
  begin
    aSQL := LowerCase(aSQL);
    aSQL := StringReplace(aSQL, 'bigint', 'number', [rfReplaceAll]);
    aSQL := StringReplace(aSQL, ';', '', [rfReplaceAll]);
    aSQL := StringReplace(aSQL, 'on update cascade', '', [rfReplaceAll]);
    //@@aSQL := StringReplace(aSQL, 'text', 'clob', [rfReplaceAll]);
  end;


  try
    UniSQL:=TUniSQL.Create(nil);
    UniSQL.Connection := aUniConnection;

    if aUpperCase then
    begin
      UniSQL.SQL.Text := UpperCase(aSQL);
    end else
    begin
      UniSQL.SQL.Text := aSQL;
    end;

    //@KzDebug.FileFmt('%S:%S',['',aSQL]);
    try
      UniSQL.Execute;
    except
      on E:Exception do
      begin
        KzDebug.FileFmt('%S:%S', ['ERROR', aSQL]);
        KzDebug.FileFmt('%S:%S', ['ERROR', E.Message]);
      end;
    end;
  finally
    FreeAndNil(UniSQL);
  end;
end;

function TUniEngine.GetUniSQL: TUniSQL;
begin
  if FUniSQL = nil then
  begin
    FUniSQL := TUniSQL.Create(nil);
  end;
  Result := FUniSQL;
end;

class function TUniEngine.GetUniQuery(aSQL: string): TUniQuery;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.GetUniQuery] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

class function TUniEngine.GetUniQuery(aSQL: string; aUniConnection: TUniConnection; aFetchAll: Boolean): TUniQuery;
begin
  Result:=nil;
  if Trim(aSQL)='' then Exit;

  Result:=TUniQuery.Create(nil);

  if aFetchAll then
  begin
    Result.Options.QueryRecCount := True;
    //# OR
    //# SpecificOptions.Values['FetchAll'] := 'True';
  end;

  Result.Connection:=aUniConnection;
  Result.SQL.Text  :=aSQL;
  Result.Open;
end;

procedure TUniEngine.InsertDB;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.InsertDB] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');  
end;

procedure TUniEngine.InsertDB(aUniConnection: TUniConnection);
begin
  try
    FStrSQL:=GetStrInsert;
    if FStrSQL='' then raise Exception.Create('you must be override getstrinsert method');
    
    FOptTyp:=otAddx;
    
    UniSQL.Connection:=aUniConnection;
    FUniSQL.SQL.Text :=FStrSQL;

    SetParameters;
    
    try
      FUniSQL.Execute;
    except
      On E:Exception do
      begin
        raise Exception.Create(E.Message);
      end;  
    end;
  finally
    FreeAndNil(FUniSQL);
  end;
end;

class function TUniEngine.ReadDB(aSQL: string): TUniEngine;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.ExecuteSQL] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

class function TUniEngine.ReadDB(aSQL: string;
  aUniConnection: TUniConnection): TUniEngine;
var
  UniQuery:TUniQuery;
begin
  Result:=nil;
  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection :=aUniConnection;
    //UniQuery.Prepared   :=True;

    if aSQL='' then raise Exception.Create('SQL=NIL');

    UniQuery.SQL.Text:=aSQL;
    UniQuery.Open;

    if UniQuery.RecordCount=0 then Exit;
    while not UniQuery.Eof do
    begin
      Result:=ReadDS(UniQuery);
      UniQuery.Next;
    end;
  finally
    FreeAndNil(UniQuery);
  end;
end;


class function TUniEngine.StrsDB(aSQL: string; Fields: array of string;
  aUniConnection: TUniConnection;withSorted:Boolean): TStringList;
var
  UniQuery:TUniQuery;
  UniEngine:TUniEngine;
  //YXC_2010_08_09_11_30_01
  I:Integer;
  TMPA:string;
  TMPB:string;
begin
  Result:=nil;
  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection :=aUniConnection;

    if aSQL='' then raise Exception.Create('SQL=NIL');

    UniQuery.SQL.Text:=aSQL;
    UniQuery.Open;

    if UniQuery.RecordCount=0 then Exit;

    Result:=TStringList.Create;
    while not UniQuery.Eof do
    begin
      UniEngine:=ReadDS(UniQuery);

      TMPA:='';
      if Length(Fields)<>0 then
      begin
        for I:=0 to Length(Fields)-1 do
        begin
          TMPB:=Trim(UniQuery.FieldByName(Fields[I]).AsString);
          TMPA:=TMPA+'-'+TMPB;
        end;
        Delete(TMPA,1,1);
      end;

      Result.AddObject(TMPA,UniEngine);
      UniQuery.Next;
    end;

    if withSorted then
    begin
      Result.Sorted:=True;
    end;
  finally
    FreeAndNil(UniQuery);
  end;
end;

class function TUniEngine.StrsDB(aSQL: string;
  Fields: array of string;withSorted:Boolean): TStringList;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.StrsDB] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;


class procedure TUniEngine.toDropView(aSQL: string; aUniConnection: TUniConnection; aUpperCase: Boolean);
begin
  if aUniConnection.ProviderName = UniConfig.CONST_PROVIDER_POSTGR then
  begin
    ExecuteSQL(Format('%S CASCADE',[aSQL]), aUniConnection, aUpperCase);
  end else
  begin
    ExecuteSQL(aSQL, aUniConnection, aUpperCase);
  end;
end;

procedure TUniEngine.TONODE(aNode: IXMLNode);
var
  I:Integer;
  Count:Integer;
  PropInfo: PPropInfo;
  PropType: PTypeInfo;
  PropList: PPropList;
begin
  Count := GetTypeData(self.ClassInfo)^.PropCount;
  if Count > 0 then
  begin
    GetMem(PropList, Count * SizeOf(Pointer));
    try
      GetPropInfos(self.ClassInfo, PropList);
      for I := 0 to Count - 1 do
      begin
        PropInfo := PropList^[i];
        if PropInfo = nil then Continue;

        PropType := PPropInfo(PropInfo)^.PropType^;

        case PropType^.Kind of
          tkFloat:            aNode.AddChild(PropInfo.Name).Text := FloatToStr(GetFloatProp(self,PropInfo));
          tkString, tkLString:aNode.AddChild(PropInfo.Name).Text := GetStrProp(self, PropInfo);
          tkUString:          aNode.AddChild(PropInfo.Name).Text := GetStrProp(self, PropInfo);
        else ;
          raise Exception.CreateFmt('NO MATCH PROPTYPE',[]);
        end;
      end;
    finally
      FreeMem(PropList, Count * SizeOf(Pointer));
    end;
  end;
end;

class function TUniEngine.StrsDB(aSQL: string;
  aUniConnection: TUniConnection; withSorted:Boolean): TStringList;
var
  UniQuery:TUniQuery;
  UniEngine:TUniEngine;
begin
  Result:=nil;
  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection :=aUniConnection;

    if aSQL='' then raise Exception.Create('SQL=NIL');

    UniQuery.SQL.Text:=aSQL;
    UniQuery.Open;

    if UniQuery.RecordCount=0 then Exit;

    Result:=TStringList.Create;
    while not UniQuery.Eof do
    begin
      UniEngine:=ReadDS(UniQuery);
      Result.AddObject(UniEngine.GetStrsIndex,UniEngine);
      UniQuery.Next;
    end;

    if withSorted then
    begin
      Result.Sorted:=True;
    end;
  finally
    FreeAndNil(UniQuery);
  end;
end;

class function TUniEngine.StrsDB(aSQL: string;withSorted:Boolean): TStringList;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.StrsDB] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

procedure TUniEngine.UpdateDB(aUniConnection: TUniConnection);
begin
  try
    FStrSQL:=GetStrUpdate;
    if FStrSQL='' then raise Exception.Create('you must be override getstrupdate method');

    FOptTyp:=otEdit;

    UniSQL.Connection:=aUniConnection;
    FUniSQL.SQL.Text :=FStrSQL;    

    SetParameters;
    
    try
      FUniSQL.Execute;
    except
      On E:Exception do
      begin
        raise Exception.Create(E.Message);
      end;  
    end;
  finally
    FreeAndNil(FUniSQL);
  end;
end;

procedure TUniEngine.UpdateDB;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.UpdateDB] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

function TUniEngine.GetStrsIndex: string;
begin
  Result:='';
end;

class function TUniEngine.ExistField(aTable, aField: string;
  aUniConnection: TUniConnection): Boolean;
var
  IdexA:Integer;
  ListA:TStringList;
  UniTable:TUniTable;  
begin
  Result:=False;

  if not ExistTable(aTable,aUniConnection) then
  begin
    raise Exception.CreateFmt('NOT EXIST SUCH TABLE:%S',[aTable]);
  end;
  
  UniTable:=TUniTable.Create(nil);
  UniTable.Connection:=aUniConnection;
  UniTable.TableName:=aTable;
  ListA:=TStringList.Create;
  UniTable.GetFieldNames(ListA);
  
  ListA.Sorted:=True;
  Result:=ListA.IndexOf(aField)<>-1;
  {IdexA:=-1;
  if ListA.Find(aField,IdexA) then
  begin
    Result:=IdexA<>-1;
  end;}

  FreeAndNil(UniTable);
  FreeAndNil(ListA);  
end;

class function TUniEngine.ExistTable(aTable: string;
  aUniConnection: TUniConnection): Boolean;
var
  IdexA:Integer;
  ListA:TStringList;
begin
  Result:=False;
  if aUniConnection=nil then Exit;

  try
    ListA:=TStringList.Create;
    aUniConnection.GetTableNames(ListA);
    if (ListA<>nil) and (ListA.Count>0) then
    begin
      ListA.Sorted:=True;
      Result:=ListA.IndexOf(aTable)<>-1;
      {IdexA:=-1;
      if ListA.Find(aTable,IdexA) then
      begin
        Result:=IdexA<>-1;
      end;}
    end;
  finally
    FreeAndNil(ListA);
  end;
end;

class function TUniEngine.CheckExist(aTable: string;
  Args: array of Variant; aUniConnection: TUniConnection;aSQLAddition:string): Boolean;
var
  UniQuery:TUniQuery;
  aSQL :string;
  Temp :string;
  AValue:Variant;
  I,ALen:Integer;
begin
  Result:=False;
  
  if (Length(Args) mod 2)<>0 then
  begin
    raise Exception.Create('函数调用出错,[Length(Args) Mod 2 <> 0]');
  end;

  ALen:=Length(Args) div 2;

  aSQL:=Format('SELECT 1 FROM  %S  WHERE 1=1',[aTable]);

  if ALen<>0 then
  begin
    for I:=1 to ALen do
    begin
      AValue:=Args[I*2-1];
      Temp:='';
      if VarIsStr(AValue) then
      begin
        Temp:=QuotedStr(AValue);
      end else
      if VarIsNumeric(AValue) then
      begin
        Temp:=AValue;
      end;
      aSQL:=aSQL+Format('   AND  %s=%s',[VarToStr(Args[I*2-2]),Temp]);
    end;
  end;

  if Trim(aSQLAddition)<>'' then
  begin
    aSQL:=aSQL + '    ' + aSQLAddition;
  end;
    
  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection :=aUniConnection;
    UniQuery.SQL.Text   :=aSQL;
    UniQuery.Open;
    UniQuery.First;
    if UniQuery.RecordCount=0 then Exit;
    if UniQuery.RecordCount>0 then Result:=True;
  finally
    FreeAndNil(UniQuery);
  end;
end;


class function TUniEngine.CheckField(aField, aTable: string;
  Args: array of Variant; aUniConnection: TUniConnection;aSQLAddition:string): Integer;
var
  UniQuery:TUniQuery;
  aSQL :string;
  Temp :string;
  AValue:Variant;
  I,ALen :Integer;
begin
  Result:=-1;

  if (Length(Args) mod 2)<>0 then
  begin
    raise Exception.Create('函数调用出错,[Length(Args) Mod 2 <> 0]');
  end;

  ALen:=Length(Args) div 2;

  aSQL:=Format('SELECT MAX( %S )+1 AS MAXX FROM  %S  WHERE 1=1',[aField,aTable]);

  if ALen<>0 then
  begin
    for I:=1 to ALen do
    begin
      AValue:=Args[I*2-1];
      Temp:='';
      if VarIsStr(AValue) then
      begin
        Temp:=QuotedStr(AValue);
      end else
      if VarIsNumeric(AValue) then
      begin
        Temp:=AValue;
      end;
      aSQL:=aSQL+Format('   AND  %s=%s',[VarToStr(Args[I*2-2]),Temp]);
    end;
  end;

  if Trim(aSQLAddition)<>'' then
  begin
    aSQL:=aSQL + '    ' + aSQLAddition;
  end;

  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection:=aUniConnection;
    UniQuery.SQL.Text  :=aSQL;
    UniQuery.Open;

    if UniQuery.RecordCount=0 then Exit;
    Result:=StrToIntDef(UniQuery.FieldByName('MAXX').AsString,1);
    if Result=0 then Result:=1;
  finally
    FreeAndNil(UniQuery);
  end;
end;


class function TUniEngine.AlterField(aTable, aField: string; length: Integer;
  aUniConnection: TUniConnection): Boolean;
var
  cSQL:string;
  cSize:Integer;
begin
  Result := False;

  if aUniConnection.ProviderName = CONST_PROVIDER_SQLSRV then
  begin
    cSQL := 'SELECT 1 AS SIZE FROM SYSCOLUMNS WHERE ID=OBJECT_ID(%S) AND NAME=%S AND LENGTH >= %d';
    cSQL := Format(cSQL, [QuotedStr(aTable), QuotedStr(aField), length]);
    cSize := CheckField(cSQL, 'SIZE', aUniConnection);
    if cSize = 0 then
    begin
      cSQL := 'ALTER TABLE %S ALTER COLUMN %S VARCHAR(%d) NULL';
      cSQL := Format(cSQL, [aTable, aField, length]);
      ExecuteSQL(cSQL, aUniConnection);
    end;
  end;

  Result := True;
end;

class function TUniEngine.CheckCount(aField, aTable: string;
  Args: array of Variant; aUniConnection: TUniConnection;aSQLAddition:string): Integer;
var
  UniQuery:TUniQuery;
  aSQL :string;
  Temp :string;
  AValue:Variant;
  I,ALen :Integer;
begin
  Result:=-1;

  if (Length(Args) mod 2)<>0 then
  begin
    raise Exception.Create('函数调用出错,[Length(Args) Mod 2 <> 0]');
  end;

  ALen:=Length(Args) div 2;

  aSQL:=Format('SELECT COUNT( %S ) AS NUMB FROM  %S  WHERE 1=1',[aField,aTable]);

  if ALen<>0 then
  begin
    for I:=1 to ALen do
    begin
      AValue:=Args[I*2-1];
      Temp:='';
      if VarIsStr(AValue) then
      begin
        Temp:=QuotedStr(AValue);
      end else
      if VarIsNumeric(AValue) then
      begin
        Temp:=AValue;
      end;
      aSQL:=aSQL+Format('   AND  %s=%s',[VarToStr(Args[I*2-2]),Temp]);
    end;
  end;
  
  if Trim(aSQLAddition)<>'' then
  begin
    aSQL:=aSQL + '    ' + aSQLAddition;
  end;
  
  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection:=aUniConnection;
    UniQuery.SQL.Text  :=aSQL;
    UniQuery.Open;

    if UniQuery.RecordCount=0 then Exit;
    Result:=UniQuery.FieldByName('NUMB').AsInteger;
  finally
    FreeAndNil(UniQuery);
  end;
end;

procedure TUniEngine.SaveItWhenNotExist(aUniConnection: TUniConnection);
begin
  if not CheckExist(aUniConnection) then
  begin
    InsertDB(aUniConnection);
  end;
end;

class function TUniEngine.GetDataSet(aSQL: string; aUniConnection: TUniConnection; aFetchAll: Boolean): TUniQuery;
begin
  Result:=nil;
  if Trim(aSQL)='' then Exit;

  Result:=TUniQuery.Create(nil);

  if aFetchAll then
  begin
    Result.Options.QueryRecCount := True;
    //# OR
    //# SpecificOptions.Values['FetchAll'] := 'True';
  end;

  Result.Connection := aUniConnection;
  Result.SQL.Text   := aSQL;
  Result.Open;
end;

class function TUniEngine.GetDataSet(aSQL: string): TUniQuery;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.GetDataSet] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

class function TUniEngine.CheckField(aSQL, AAsField: string; aUniConnection: TUniConnection): Variant;
var
  aDataSet: TUniQuery;
begin
  Result := 0;

  try
    aDataSet := GetDataSet(aSQL, aUniConnection);
    if aDataSet.RecordCount = 0 then Exit;

    Result := aDataSet.FieldByName(AAsField).AsVariant;
    if VarIsNull(Result) then
    begin
      Result := 0;
    end;  
  finally
    FreeAndNil(aDataSet);
  end;
end;

class procedure TUniEngine.CopyIt(sList: TStringList; var tList: TCollection);
var
  I:Integer;

  cObject:TUniEngine;
  xObject:TUniEngine;
begin
  if tList = nil then Exit;

  if (sList = nil) or (sList.Count = 0) then Exit;
  //for I:=0 to sList.Count -1 do

  for I := 0 to sList.Count -1 do
  begin
    cObject := TUniEngine(sList.Objects[I]);

    xObject := TUniEngine(tList.Add);
    cObject.CopyIt(cObject,xObject);
  end;
end;


class procedure TUniEngine.CopyIt(sList: TStringList; var tList: TStringList;aClass:TUniEngineClass);
var
  I:Integer;

  cObject:TUniEngine;
  xObject:TUniEngine;
begin
  if tList = nil then Exit;

  if (sList = nil) or (sList.Count = 0) then Exit;
  //for I:=0 to sList.Count -1 do

  for I := 0 to sList.Count -1 do
  begin
    cObject := TUniEngine(sList.Objects[I]);

    xObject :=  aClass.Create;
    xObject.CopyIt(cObject,xObject);
    tList.AddObject(xObject.GetStrsIndex,xObject);
  end;
end;


class function TUniEngine.ExistConst(aConstraintType,
  aConstraintName: string; aUniConnection: TUniConnection): Boolean;
begin
  Result := False;
  if aUniConnection.ProviderName = CONST_PROVIDER_SQLSRV then
  begin
    if Trim(aConstraintType)='FK' then
    begin
      aConstraintType:='F';
    end;

    //because constraint include.PK,FK,TR,V,
    {if (Trim(aConstraintType)<>'PK') and (Trim(aConstraintType)<>'F') then
    begin
      raise Exception.Create('ERROR:UniEngine.pas.TUniEngine.ExistConst.LINE:725.INFO:OUT OF RANGE'+#13+'TRY PASS IT WITH "PK" OR "FK"');
    end;}

    Result := CheckExist('SYSOBJECTS',['XTYPE',aConstraintType,'NAME',aConstraintName],aUniConnection);
  end else
  if aUniConnection.ProviderName = CONST_PROVIDER_ACCESS then
  begin
    raise Exception.Create('ERROR:UniEngine.pas.TUniEngine.ExistConst.LINE:693.INFO:Not Support Access');
  end else
  if aUniConnection.ProviderName = CONST_PROVIDER_ORACLE then
  begin
    raise Exception.Create('ERROR:UniEngine.pas.TUniEngine.ExistConst.LINE:693.INFO:Not Support Oracle');
  end;
end;

class function TUniEngine.GetServDat(
  aUniConnection: TUniConnection): TDateTime;
var
  SQLA:string;
  UniDataSet:TUniQuery;
  UniConnct :TUniConnection;
begin
  Result:=Now;

  SQLA:='';
  if aUniConnection.ProviderName = CONST_PROVIDER_SQLSRV then
  begin
    SQLA:='SELECT GETDATE() AS SYSDATE';
  end else
  if aUniConnection.ProviderName = CONST_PROVIDER_ACCESS then
  begin
    SQLA:='SELECT DATE() AS SYSDATE'
  end else
  if aUniConnection.ProviderName = CONST_PROVIDER_ORACLE then
  begin
    SQLA:='SELECT SYSDATE FROM DUAL'
  end;

  if SQLA='' then Exit;
  try
    UniDataSet:=nil;
    UniDataSet:=GetDataSet(SQLA,aUniConnection);
    if (UniDataSet<>nil) and (UniDataSet.RecordCount=1) then
    begin
      Result:=UniDataSet.FieldByName('SYSDATE').AsDateTime;
    end;   
  finally
    FreeAndNil(UniDataSet);
  end;
end;

class function TUniEngine.ListDB(aSQL: string;withSorted:Boolean): TStringList;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.ListDB] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

class function TUniEngine.ListDB(aSQL: string;
  aUniConnection: TUniConnection;withSorted:Boolean): TStringList;
begin
  Result:=StrsDB(aSQL,aUniConnection,withSorted);
end;

class function TUniEngine.ListDB(aSQL: string;
  Fields: array of string;withSorted:Boolean): TStringList;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.ListDB] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

class function TUniEngine.ListDB(aSQL: string; Fields: array of string;
  aUniConnection: TUniConnection;withSorted:Boolean): TStringList;
begin
  Result:=StrsDB(aSQL,Fields,aUniConnection,withSorted);
end;

class procedure TUniEngine.ListDB(aSQL: string;
  aUniConnection: TUniConnection; var Result: TStringList;withSorted:Boolean);
var
  UniQuery :TUniQuery;
  UniEngine:TUniEngine;
begin
  if Result=nil then Exit;
  
  //make sure the list.sort = false. otherwise, it will be igonre same strsindex. code as follow.
  {if not Sorted then
    Result := FCount
  else
    if Find(S, Result) then
      case Duplicates of
        dupIgnore: Exit;
        dupError: Error(@SDuplicateString, 0);
      end;
  InsertItem(Result, S, AObject);}
  Result.Sorted:=False;
  
  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection :=aUniConnection;

    if aSQL='' then raise Exception.Create('SQL=NIL');

    UniQuery.SQL.Text:=aSQL;
    UniQuery.Open;

    if UniQuery.RecordCount=0 then Exit;

    while not UniQuery.Eof do
    begin
      UniEngine:=ReadDS(UniQuery);
      Result.AddObject(UniEngine.GetStrsIndex,UniEngine);
      UniQuery.Next;
    end;

    if withSorted then
    begin
      Result.Sorted:=True;
    end;
  finally
    FreeAndNil(UniQuery);
  end;
end;


class procedure TUniEngine.ListDB(aSQL: string; Fields: array of string;
  aUniConnection: TUniConnection; var Result: TStringList;withSorted:Boolean);
var
  UniQuery :TUniQuery;
  UniEngine:TUniEngine;
  //YXC_2010_08_09_11_30_01
  I:Integer;
  TMPA:string;
  TMPB:string;
begin
  if Result=nil then Exit;

  //make sure the list.sort = false. otherwise, it will be igonre same strsindex. code as follow.
  {if not Sorted then
    Result := FCount
  else
    if Find(S, Result) then
      case Duplicates of
        dupIgnore: Exit;
        dupError: Error(@SDuplicateString, 0);
      end;
  InsertItem(Result, S, AObject);}
  Result.Sorted:=False;
  
  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection :=aUniConnection;

    if aSQL='' then raise Exception.Create('SQL=NIL');
    
    UniQuery.SQL.Text:=aSQL;
    UniQuery.Open;
    
    if UniQuery.RecordCount=0 then Exit;

    while not UniQuery.Eof do
    begin
      UniEngine:=ReadDS(UniQuery);

      TMPA:='';
      if Length(Fields)<>0 then
      begin
        for I:=0 to Length(Fields)-1 do
        begin
          TMPB:=Trim(UniQuery.FieldByName(Fields[I]).AsString);
          TMPA:=TMPA+'-'+TMPB;
        end;
        Delete(TMPA,1,1);        
      end;

      Result.AddObject(TMPA,UniEngine);
      UniQuery.Next;
    end;

    if withSorted then
    begin
      Result.Sorted:=True;
    end;
  finally
    FreeAndNil(UniQuery);
  end;
end;

class procedure TUniEngine.ReadDB(aSQL: string;
  aUniConnection: TUniConnection; var Result: TUniEngine);
var
  UniQuery:TUniQuery;
begin
  if Result=nil then Exit;
  
  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection :=aUniConnection;
    //UniQuery.Prepared   :=True;

    if aSQL='' then raise Exception.Create('SQL=NIL');

    UniQuery.SQL.Text:=aSQL;
    UniQuery.Open;

    if UniQuery.RecordCount=0 then Exit;
    while not UniQuery.Eof do
    begin
      ReadDS(UniQuery,Result);
      UniQuery.Next;
    end;
  finally
    FreeAndNil(UniQuery);
  end;
end;


class function TUniEngine.ExistIndex(aIndexName: string;
  aUniConnection: TUniConnection): Boolean;
begin
  Result := False;
  if aUniConnection.ProviderName = CONST_PROVIDER_SQLSRV then
  begin
    Result := CheckExist('SYSINDEXES',['NAME',aIndexName],aUniConnection);
  end else
  if aUniConnection.ProviderName = CONST_PROVIDER_ACCESS then
  begin
    raise Exception.Create('ERROR:UniEngine.pas.TUniEngine.ExistConst.LINE:693.INFO:Not Support Access');
  end else
  if aUniConnection.ProviderName = CONST_PROVIDER_ORACLE then
  begin
    raise Exception.Create('ERROR:UniEngine.pas.TUniEngine.ExistConst.LINE:693.INFO:Not Support Oracle');
  end;
end;

class function TUniEngine.ExistInKey(aConstraintType, aField,
  aTable: string; aUniConnection: TUniConnection): Boolean;
begin

end;

//class function TUniEngine.TOJSON(aList: TStringList;AOperateType:TOperateType): string;
//var
//  I,M,N:Integer;
//  Instance:TUniEngine;
//
//  TMPA:string;
//
//  NameA:string;
//  Value:string;
//
//  PropList:PPropList;
//begin
//  Result:='';
//
//  if (aList=nil) or (aList.Count=0) then Exit;
//
//  for I:=0 to aList.Count -1 do
//  begin
//    Instance:=TUniEngine(aList.Objects[I]);
//
//    TMPA:='';
//    M:=GetPropList(Instance,PropList);
//    for N:=Low(PropList^) to M-1 do
//    begin
//      case AOperateType of
//        otUpperCase:NameA:=UpperCase(PropList[N]^.Name);
//        otLowerCase:NameA:=LowerCase(PropList[N]^.Name);
//      else;
//        NameA:=PropList[N]^.Name;
//      end;
//
//      Value:=GetPropValue(Instance,PropList[N]^.Name);
//      Value:=TKzUtils.jsencode(Value);
//
//      TMPA:=TMPA+Format(',"%s":"%s"',[NameA,Value]);
//    end;
//
//    Delete(TMPA,1,1);
//    TMPA :=Format('{%S}',[TMPA]);
//    Result:=Result+','+TMPA;
//
//    FreeMem(PropList);
//  end;
//
//  Delete(Result,1,1);
//  Result:=Format('[%S]',[Result]);
//end;

//class procedure TUniEngine.INJSON(AValue:string;AClass:TUniEngineClass;var aList: TStringList;ACleanList:Boolean);
//var
//  I,M,N:Integer; //for avlaue
//  X,Y,Z:Integer; //for rtti
//
//  TMPA:string;
//
//  ListA:TStrings;
//  ListB:TStrings;
//  NameA:string;
//  Value:string;
//
//  PropName:string;
//  PropList:PPropList;
//  Instance:TUniEngine;
//begin
//  if Trim(AValue)='' then Exit;
//
//  try
//    //if nothing to set propvalue
//    Y:=GetPropList(AClass.ClassInfo,PropList);
//    if Y=0 then Exit;
//
//    //make it clean and sorted is false.
//    if (aList=nil) then Exit;
//    if ACleanList  then
//    begin
//      TKzUtils.JustCleanList(aList);
//    end;
//    //make sure the list.sort = false. otherwise, it will be igonre same strsindex. code as follow.
//    {if not Sorted then
//      Result := FCount
//    else
//      if Find(S, Result) then
//        case Duplicates of
//          dupIgnore: Exit;
//          dupError: Error(@SDuplicateString, 0);
//        end;
//    InsertItem(Result, S, AObject);}
//    aList.Sorted:=False;
//
//    //delete head and tail
//    if AValue[1]='[' then
//    begin
//      Delete(AValue,1,1);
//    end;
//    if AValue[Length(AValue)]=']' then
//    begin
//      Delete(AValue,Length(AValue),1);
//    end;
//
//
//    ListA:=TKzUtils.StrsStrCutted(AValue,'\{*\}');
//    for I:=0 to ListA.Count-1 do
//    begin
//      TMPA:=Trim(ListA.Strings[I]);
//
//      TMPA:=TKzUtils.RegReplaceAll(TMPA,'\:','=');
//      TMPA:=TKzUtils.RegReplaceAll(TMPA,'\{','');
//      TMPA:=TKzUtils.RegReplaceAll(TMPA,'\"','');
//
//      if Trim(TMPA)='' then Continue;
//
//      ListB:=TKzUtils.StrsStrCutted(TMPA,'\,');
//
//      Instance:=AClass.Create;
//      for X:=Low(PropList^) to Y-1 do
//      begin
//        PropName:=PropList[X]^.Name;
//
//        for M:=0 to ListB.Count-1 do
//        begin
//          NameA:=UpperCase(ListB.Names[M]);
//
//          if UpperCase(PropName)=NameA then
//          begin
//            Value:=TKzUtils.jsdecode(ListB.ValueFromIndex[M]);
//            SetPropValue(Instance,PropName,Value);
//          end;
//        end;
//      end;
//
//      aList.AddObject(Instance.GetStrsIndex,Instance);
//      FreeAndNil(ListB);
//    end;
//  finally
//    FreeAndNil(ListA);
//    FreeMem(PropList);
//  end;
//end;

class procedure TUniEngine.STRIDX(Args: array of string;
  aList: TStringList; aSeparator: string; withQuoted:Boolean);
var
  I,M  :Integer;
  cName:string;
  cText:string;
  Instance:TUniEngine;
begin
  if (aList=nil) or (aList.Count=0) then Exit;
  aList.Sorted:=False;

  for I:=0 to aList.Count-1 do
  begin
    Instance:=TUniEngine(aList.Objects[I]);
    if Instance=nil then Continue;

    cText:='';
    for M:=0 to Length(Args)-1 do
    begin
      cName:=Args[M];

      cText:=cText + aSeparator + VarToStr(GetPropValue(Instance,cName));
      {if withQuoted then
      begin
        TMPA:=TMPA + aSeparator +QuotedStr(VarToStr(GetPropValue(Instance,NameA)));
      end else
      begin
        TMPA:=TMPA + aSeparator +VarToStr(GetPropValue(Instance,NameA));
      end;}
    end;
    Delete(cText,1,Length(aSeparator));

    if withQuoted then
    begin
      aList.Strings[I]:=QuotedStr(cText);
    end else
    begin
      aList.Strings[I]:=cText;
    end;
  end;
end;

class function TUniEngine.STRDIY(Args: array of string;
  aList: TStringList;aSeparator: string;withQuoted:Boolean): string;
var
  I,M:Integer;
  Instance:TUniEngine;
  cName:string;
  cText:string;
begin
  Result:='';
  if (aList=nil) or (aList.Count=0) then Exit;

  for I:=0 to aList.Count -1 do
  begin
    Instance:=TUniEngine(aList.Objects[I]);
    if Instance=nil then Continue;

    cText:='';
    for M:=0 to Length(Args)-1 do
    begin
      cName:=Args[M];
      
      cText:=cText + '-' + VarToStr(GetPropValue(Instance,cName));
    end;
    Delete(cText,1,1);

    if withQuoted then
    begin
      Result:=Result +  aSeparator +QuotedStr(cText);
    end else
    begin
      Result:=Result +  aSeparator +cText;
    end;
  end;
  
  Delete(Result,1,Length(aSeparator));
end;

//class procedure TUniEngine.INJSON(AValue: string; AClass: TUniEngineClass;
//  var AObjt: TUniEngine; ACleanList: Boolean);
//begin
//  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.INJSON] AT [UniEngine.pas]');
//end;

//class function TUniEngine.TOJSON(AObjt: TUniEngine;
//  AOperateType: TOperateType): string;
//begin
//  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.TOJSON] AT [UniEngine.pas]');
//end;

//function TUniEngine.TOJSON(AOperateType: TOperateType): string;
//var
//  I,M,N:Integer;
//  Instance:TUniEngine;
//
//  TMPA:string;
//
//  NameA:string;
//  Value:string;
//
//  PropList:PPropList;
//begin
//  Result:='';
//
//  Instance:=Self;
//
//  TMPA:='';
//  M:=GetPropList(Instance,PropList);
//  for N:=Low(PropList^) to M-1 do
//  begin
//    case AOperateType of
//      otUpperCase:NameA:=UpperCase(PropList[N]^.Name);
//      otLowerCase:NameA:=LowerCase(PropList[N]^.Name);
//    else;
//      NameA:=PropList[N]^.Name;
//    end;
//
//    Value:=GetPropValue(Instance,PropList[N]^.Name);
//    Value:=TKzUtils.jsencode(Value);
//
//    TMPA:=TMPA+Format(',"%s":"%s"',[NameA,Value]);
//  end;
//
//  Delete(TMPA,1,1);
//  Result:=Format('{%S}',[TMPA]);
//
//  FreeMem(PropList);
//end;

//procedure TUniEngine.INJSON(AValue: string);
//var
//  I,M,N:Integer; //for avlaue
//  X,Y,Z:Integer; //for rtti
//
//  TMPA:string;
//
//  ListA:TStrings;
//  ListB:TStrings;
//  NameA:string;
//  Value:string;
//
//  PropName:string;
//  PropList:PPropList;
//  Instance:TUniEngine;
//begin
//  if Trim(AValue)='' then Exit;
//
//  try
//    //if nothing to set propvalue
//    Y:=GetPropList(Self.ClassInfo,PropList);
//    if Y=0 then Exit;
//
//    //delete head and tail
//    if AValue[1]='[' then
//    begin
//      Delete(AValue,1,1);
//    end;
//    if AValue[Length(AValue)]=']' then
//    begin
//      Delete(AValue,Length(AValue),1);
//    end;
//
//
//    ListA:=TKzUtils.StrsStrCutted(AValue,'\{*\}');
//    for I:=0 to ListA.Count-1 do
//    begin
//      TMPA:=Trim(ListA.Strings[I]);
//
//      TMPA:=TKzUtils.RegReplaceAll(TMPA,'\:','=');
//      TMPA:=TKzUtils.RegReplaceAll(TMPA,'\{','');
//      TMPA:=TKzUtils.RegReplaceAll(TMPA,'\"','');
//
//      if Trim(TMPA)='' then Continue;
//
//      ListB:=TKzUtils.StrsStrCutted(TMPA,'\,');
//
//      Instance:=Self;
//      for X:=Low(PropList^) to Y-1 do
//      begin
//        PropName:=PropList[X]^.Name;
//
//        for M:=0 to ListB.Count-1 do
//        begin
//          NameA:=UpperCase(ListB.Names[M]);
//
//          if UpperCase(PropName)=NameA then
//          begin
//            Value:=TKzUtils.jsdecode(ListB.ValueFromIndex[M]);
//            SetPropValue(Instance,PropName,Value);
//          end;
//        end;
//      end;
//
//      FreeAndNil(ListB);
//    end;
//  finally
//    FreeAndNil(ListA);
//    FreeMem(PropList);
//  end;
//end;

class function TUniEngine.ExistFieldInOracle(aTable, aField: string;
  aUniConnection: TUniConnection): Boolean;
var
  ListA:TStringList;
  UniDataSet:TUniQuery;
begin
  Result:=False;

  if not ExistTable(aTable,aUniConnection) then
  begin
    raise Exception.CreateFmt('NOT EXIST SUCH TABLE:%S',[aTable]);
  end;

  UniDataSet:=GetDataSet(Format('SELECT * FROM %S WHERE ROWNUM<1',[aTable]),aUniConnection);
  if UniDataSet<>nil then
  begin
    Result:=UniDataSet.FindField(aField)<>nil;
    FreeAndNil(UniDataSet);
  end;
end;

class procedure TUniEngine.GetDataSet(aSQL: string; Fields: array of string; aUniConnection: TUniConnection; var Result: TStringList; aSeparator: string; aFetchAll: Boolean);
var
  I:Integer;
  TMPA:string;
  TMPB:string;
  
  UniQuery:TUniQuery;
begin
  if Result=nil then Exit;

  try
    UniQuery:=GetUniQuery(aSQL,aUniConnection);

    if aFetchAll then
    begin
      UniQuery.Options.QueryRecCount := True;
      //# OR
      //# SpecificOptions.Values['FetchAll'] := 'True';
    end;

    if UniQuery=nil then Exit;
    if UniQuery.RecordCount=0 then Exit;

    UniQuery.First;
    while not UniQuery.Eof do
    begin
      TMPA:='';
      if Length(Fields)<>0 then
      begin
        for I:=0 to Length(Fields)-1 do
        begin
          TMPB:=Trim(UniQuery.FieldByName(Fields[I]).AsString);
          TMPA:=TMPA+aSeparator+TMPB;
        end;
        Delete(TMPA,1,1);
      end;

      Result.Add(TMPA);

      UniQuery.Next;
    end;

  finally
    FreeAndNil(UniQuery);
  end;
end;

constructor TUniEngine.Create;
begin

end;

class procedure TUniEngine.ListDB(aSQL: string;
  aUniConnection: TUniConnection; var Result: TCollection;
  withSorted: Boolean);
var
  UniQuery :TUniQuery;
  UniEngine:TUniEngine;
begin
  if Result=nil then Exit;
  
  //make sure the list.sort = false. otherwise, it will be igonre same strsindex. code as follow.
  {if not Sorted then
    Result := FCount
  else
    if Find(S, Result) then
      case Duplicates of
        dupIgnore: Exit;
        dupError: Error(@SDuplicateString, 0);
      end;
  InsertItem(Result, S, AObject);}
  //#Result.Sorted:=False;
  
  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection :=aUniConnection;

    if aSQL='' then raise Exception.Create('SQL=NIL');

    UniQuery.SQL.Text:=aSQL;
    UniQuery.Open;

    if UniQuery.RecordCount=0 then Exit;

    while not UniQuery.Eof do
    begin
      //#UniEngine:=ReadDS(UniQuery);
      //#Result.AddObject(UniEngine.GetStrsIndex,UniEngine);
      UniEngine:=TUniEngine(Result.Add);
      ReadDS(UniQuery,UniEngine);
      UniQuery.Next;
    end;
  finally
    FreeAndNil(UniQuery);
  end;
end;

class function TUniEngine.STRDIY(Args: array of string; aList: TCollection;
  aSeparator: string; bSeparator:string; withQuoted: Boolean): string;
var
  I,M:Integer;
  Instance:TUniEngine;
  cName:string;
  cText:string;
begin
  Result:='';
  if (aList=nil) or (aList.Count=0) then Exit;

  for I:=0 to aList.Count -1 do
  begin
    Instance:=TUniEngine(aList.Items[I]);
    if Instance=nil then Continue;

    cText:='';
    for M:=0 to Length(Args)-1 do
    begin
      cName:=Args[M];
      
      cText:=cText + bSeparator + VarToStr(GetPropValue(Instance,cName));
    end;
    Delete(cText,1,1);

    if withQuoted then
    begin
      Result:=Result +  aSeparator +QuotedStr(cText);
    end else
    begin
      Result:=Result +  aSeparator +cText;
    end;
  end;
  
  Delete(Result,1,Length(aSeparator));
end;

class procedure TUniEngine.CopyIt(sList: TCollection; var tList: TCollection);
var
  I:Integer;
  cObject:TUniEngine;
  xObject:TUniEngine;
begin
  if tList = nil then Exit;
  if (sList = nil) or (sList.Count = 0) then Exit;

  for I := 0 to sList.Count-1 do
  begin
    cObject := TUniEngine(sList.Items[I]);

    xObject := TUniEngine(tList.Add);
    cObject.CopyIt(cObject,xObject);
  end;
end;

class procedure TUniEngine.CopyIt(sList: TCollection; var tList: TStringList;aClass:TUniEngineClass);
var
  I:Integer;
  cObject:TUniEngine;
  xObject:TUniEngine;
begin
  if tList = nil then Exit;
  if (sList = nil) or (sList.Count = 0) then Exit;

  for I := 0 to sList.Count-1 do
  begin
    cObject := TUniEngine(sList.Items[I]);

    xObject :=  aClass.Create;
    xObject.CopyIt(cObject,xObject);
    tList.AddObject(xObject.GetStrsIndex,xObject);
  end;
end;

class function TUniEngine.CheckField(aSQL, aAsField: string; aUniConnection: TUniConnection; aDefault: Variant): Variant;
var
  aDataSet: TUniQuery;
begin
  Result := aDefault;

  try
    aDataSet := GetDataSet(aSQL, aUniConnection);
    if aDataSet.RecordCount = 0 then Exit;
    Result := aDataSet.FieldByName(AAsField).AsVariant;
    if VarIsNull(Result) then
    begin
      Result := aDefault;
    end;
  finally
    FreeAndNil(aDataSet);
  end;
end;

end.
