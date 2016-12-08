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
    function  GetNextIdex(AUniConnection:TUniConnection):Integer;overload;
  public
    function  CheckExist(AUniConnection:TUniConnection):Boolean;override;       
  public
    class function ReadDS(AUniQuery:TUniQuery):TUniEngine;override;
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
    procedure InsertDB(AUniConnection:TUniConnection);overload;virtual;
    procedure UpdateDB(AUniConnection:TUniConnection);overload;virtual;
    procedure DeleteDB(AUniConnection:TUniConnection);overload;virtual;
    procedure DeleteFL(AUniConnection:TUniConnection);overload;virtual;
    procedure SaveItDB(AUniConnection:TUniConnection);overload;virtual;
    procedure SaveItWhenNotExist(AUniConnection:TUniConnection);overload;virtual;

    procedure InsertDB;overload;virtual;
    procedure UpdateDB;overload;virtual;
    procedure DeleteDB;overload;virtual;
    procedure DeleteFL;overload;virtual;
    procedure SaveItDB;overload;virtual;

    function  CheckExist(AUniConnection:TUniConnection):Boolean;overload;virtual;

    //#function  TOJSON(AOperateType:TOperateType=otNormal):string;overload;
    //#procedure INJSON(AValue:string);overload;
    procedure TONODE(aNode:IXMLNode);overload;
  public
    constructor Create; virtual;  
  public
    property UniSQL:TUniSQL read GetUniSQL;
  public
    class function  ReadDS(AUniQuery: TUniQuery): TUniEngine;overload;virtual;abstract;
    class procedure ReadDS(AUniQuery: TUniQuery;var Result:TUniEngine);overload;virtual;abstract;

    class function  ReadDB(ASQL:string;AUniConnection:TUniConnection):TUniEngine;overload;virtual;
    class function  ReadDB(ASQL:string):TUniEngine;overload;virtual;
    class procedure ReadDB(ASQL:string;AUniConnection:TUniConnection;var Result:TUniEngine);overload;virtual;

    class function  StrsDB(ASQL:string;AUniConnection:TUniConnection;withSorted:Boolean=False):TStringList;overload;virtual;
    class function  StrsDB(ASQL:string;withSorted:Boolean=False):TStringList;overload;virtual;

    class function  StrsDB(ASQL:string;Fields:array of string;AUniConnection:TUniConnection;withSorted:Boolean=False):TStringList;overload;virtual;
    class function  StrsDB(ASQL:string;Fields:array of string;withSorted:Boolean=False):TStringList;overload;virtual;

    class function  ListDB(ASQL:string;AUniConnection:TUniConnection;withSorted:Boolean=False):TStringList;overload;virtual;
    class function  ListDB(ASQL:string;withSorted:Boolean=True):TStringList;overload;virtual;

    class function  ListDB(ASQL:string;Fields:array of string;AUniConnection:TUniConnection;withSorted:Boolean=False):TStringList;overload;virtual;
    class function  ListDB(ASQL:string;Fields:array of string;withSorted:Boolean=False):TStringList;overload;virtual;

    class procedure ListDB(ASQL:string;AUniConnection:TUniConnection;var Result:TStringList;withSorted:Boolean=False);overload;virtual;
    class procedure ListDB(ASQL:string;AUniConnection:TUniConnection;var Result:TCollection;withSorted:Boolean=False);overload;virtual;
    class procedure ListDB(ASQL:string;Fields:array of string;AUniConnection:TUniConnection;var Result:TStringList;withSorted:Boolean=False);overload;virtual;

    //#class function  TOJSON(AList:TStringList;AOperateType:TOperateType=otNormal):string;overload;
    //#class function  TOJSON(AObjt:TUniEngine;AOperateType:TOperateType=otNormal):string;overload;
    //#class procedure INJSON(AValue:string;AClass:TUniEngineClass;var AList:TStringList;ACleanList:Boolean=True);overload;
    //#class procedure INJSON(AValue:string;AClass:TUniEngineClass;var AObjt:TUniEngine;ACleanList:Boolean=True);overload;

    class procedure STRIDX(Args:array of string;AList:TStringList;ASeparator:string;withQuoted:Boolean=False);overload;
    class function  STRDIY(Args:array of string;AList:TStringList;ASeparator:string=',';withQuoted:Boolean=False):string;overload;
    class function  STRDIY(Args:array of string;AList:TCollection;ASeparator:string=',';BSeparator:string='-';withQuoted:Boolean=False):string;overload;

    class function  GetUniQuery(ASQL:string;AUniConnection:TUniConnection):TUniQuery;overload;
    class function  GetUniQuery(ASQL:string):TUniQuery;overload;

    class function  GetDataSet(ASQL:string;AUniConnection:TUniConnection):TUniQuery;overload;
    class function  GetDataSet(ASQL:string):TUniQuery;overload;
    class procedure GetDataSet(ASQL:string;Fields:array of string;AUniConnection:TUniConnection;var Result:TStringList;ASeparator:string=',');overload;    

    class function  GetServDat(AUniConnection:TUniConnection):TDateTime;

    class function  CheckExist(ATable:string;Args:array of Variant):Boolean;overload;
    class function  CheckField(AField,ATable:string;Args:array of Variant):Integer;overload;

    class function  CheckExist(ATable:string;Args:array of Variant;AUniConnection:TUniConnection;ASQLAddition:string=''):Boolean;overload;
    class function  CheckField(AField,ATable:string;Args:array of Variant;AUniConnection:TUniConnection;ASQLAddition:string=''):Integer;overload;
    class function  CheckCount(AField,ATable:string;Args:array of Variant;AUniConnection:TUniConnection;ASQLAddition:string=''):Integer;overload;
    class function  CheckField(ASQL:string;AAsField:string;AUniConnection:TUniConnection):Variant;overload;

    class function  ExistTable(ATable:string;AUniConnection:TUniConnection):Boolean;
    class function  ExistField(ATable,AField:string;AUniConnection:TUniConnection):Boolean;
    class function  ExistFieldInOracle(ATable,AField:string;AUniConnection:TUniConnection):Boolean;
    class function  ExistConst(AConstraintType,AConstraintName:string;AUniConnection:TUniConnection):Boolean;
    class function  ExistInKey(AConstraintType,AField,ATable:string;AUniConnection:TUniConnection):Boolean;

    class procedure ExecuteSQL(ASQL:string;AUniConnection:TUniConnection);overload;
    class procedure ExecuteSQL(ASQL:string);overload;
  end;

implementation

uses
  UniConfig;


{ TUniEngine }

class function TUniEngine.CheckExist(ATable: string;
  Args: array of Variant): Boolean;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.CheckExist] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

function TUniEngine.CheckExist(AUniConnection: TUniConnection): Boolean;
begin
  
end;

class function TUniEngine.CheckField(AField, ATable: string;
  Args: array of Variant): Integer;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.CheckField] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

procedure TUniEngine.DeleteDB(AUniConnection: TUniConnection);
begin
  try
    FStrSQL:=GetStrDelete;
    if FStrSQL='' then raise Exception.Create('you must be override getstrdelete method');

    FOptTyp:=otDelt;

    UniSQL.Connection:=AUniConnection;
    
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

procedure TUniEngine.DeleteFL;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.DeleteFL] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

procedure TUniEngine.DeleteFL(AUniConnection: TUniConnection);
begin
  try
    FStrSQL:=GetStrDeltFL;
    if FStrSQL='' then raise Exception.Create('you must be override getstrdeltfl method');
    FOptTyp:=otDelt;
    
    UniSQL.Connection:=AUniConnection;
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

procedure TUniEngine.SaveItDB(AUniConnection: TUniConnection);
begin
  if CheckExist(AUniConnection) then
  begin
    UpdateDB(AUniConnection);
  end else
  begin
    InsertDB(AUniConnection);
  end;
end;

class procedure TUniEngine.ExecuteSQL(ASQL: string);
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.ExecuteSQL] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

class procedure TUniEngine.ExecuteSQL(ASQL: string;
  AUniConnection: TUniConnection);
var
  UniSQL:TUniSQL;
begin
  if Trim(ASQL)='' then Exit;
  try
    UniSQL:=TUniSQL.Create(nil);
    UniSQL.Connection:=AUniConnection;
    UniSQL.SQL.Text  :=ASQL;
    UniSQL.Execute;
  finally
    FreeAndNil(UniSQL);
  end;
end;

function TUniEngine.GetUniSQL: TUniSQL;
begin
  if FUniSQL=nil then
  begin
    FUniSQL:=TUniSQL.Create(nil);
  end;
  Result:=FUniSQL;
end;

class function TUniEngine.GetUniQuery(ASQL: string): TUniQuery;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.GetUniQuery] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

class function TUniEngine.GetUniQuery(ASQL: string;
  AUniConnection: TUniConnection): TUniQuery;
begin
  Result:=nil;
  if Trim(ASQL)='' then Exit;

  Result:=TUniQuery.Create(nil);
  Result.Connection:=AUniConnection;
  Result.SQL.Text  :=ASQL;
  Result.Open;
end;

procedure TUniEngine.InsertDB;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.InsertDB] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');  
end;

procedure TUniEngine.InsertDB(AUniConnection: TUniConnection);
begin
  try
    FStrSQL:=GetStrInsert;
    if FStrSQL='' then raise Exception.Create('you must be override getstrinsert method');
    
    FOptTyp:=otAddx;
    
    UniSQL.Connection:=AUniConnection;
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

class function TUniEngine.ReadDB(ASQL: string): TUniEngine;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.ExecuteSQL] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

class function TUniEngine.ReadDB(ASQL: string;
  AUniConnection: TUniConnection): TUniEngine;
var
  UniQuery:TUniQuery;
begin
  Result:=nil;
  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection :=AUniConnection;
    //UniQuery.Prepared   :=True;

    if ASQL='' then raise Exception.Create('SQL=NIL');

    UniQuery.SQL.Text:=ASQL;
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


class function TUniEngine.StrsDB(ASQL: string; Fields: array of string;
  AUniConnection: TUniConnection;withSorted:Boolean): TStringList;
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
    UniQuery.Connection :=AUniConnection;

    if ASQL='' then raise Exception.Create('SQL=NIL');

    UniQuery.SQL.Text:=ASQL;
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

class function TUniEngine.StrsDB(ASQL: string;
  Fields: array of string;withSorted:Boolean): TStringList;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.StrsDB] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
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
          tkFloat:aNode.AddChild(PropInfo.Name).Text             :=FloatToStr(GetFloatProp(self,PropInfo));
          tkString, tkLString:aNode.AddChild(PropInfo.Name).Text :=GetStrProp(self, PropInfo);
        else ;
          raise Exception.CreateFmt('NO MATCH PROPTYPE',[]);
        end;
      end;
    finally
      FreeMem(PropList, Count * SizeOf(Pointer));
    end;
  end;
end;

class function TUniEngine.StrsDB(ASQL: string;
  AUniConnection: TUniConnection; withSorted:Boolean): TStringList;
var
  UniQuery:TUniQuery;
  UniEngine:TUniEngine;
begin
  Result:=nil;
  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection :=AUniConnection;

    if ASQL='' then raise Exception.Create('SQL=NIL');

    UniQuery.SQL.Text:=ASQL;
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

class function TUniEngine.StrsDB(ASQL: string;withSorted:Boolean): TStringList;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.StrsDB] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

procedure TUniEngine.UpdateDB(AUniConnection: TUniConnection);
begin
  try
    FStrSQL:=GetStrUpdate;
    if FStrSQL='' then raise Exception.Create('you must be override getstrupdate method');

    FOptTyp:=otEdit;

    UniSQL.Connection:=AUniConnection;
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

class function TUniEngine.ExistField(ATable, AField: string;
  AUniConnection: TUniConnection): Boolean;
var
  IdexA:Integer;
  ListA:TStringList;
  UniTable:TUniTable;  
begin
  Result:=False;

  if not ExistTable(ATable,AUniConnection) then
  begin
    raise Exception.CreateFmt('NOT EXIST SUCH TABLE:%S',[ATable]);
  end;
  
  UniTable:=TUniTable.Create(nil);
  UniTable.Connection:=AUniConnection;
  UniTable.TableName:=ATable;
  ListA:=TStringList.Create;
  UniTable.GetFieldNames(ListA);
  
  ListA.Sorted:=True;
  Result:=ListA.IndexOf(AField)<>-1;
  {IdexA:=-1;
  if ListA.Find(AField,IdexA) then
  begin
    Result:=IdexA<>-1;
  end;}

  FreeAndNil(UniTable);
  FreeAndNil(ListA);  
end;

class function TUniEngine.ExistTable(ATable: string;
  AUniConnection: TUniConnection): Boolean;
var
  IdexA:Integer;
  ListA:TStringList;
begin
  Result:=False;
  if AUniConnection=nil then Exit;

  try
    ListA:=TStringList.Create;
    AUniConnection.GetTableNames(ListA);
    if (ListA<>nil) and (ListA.Count>0) then
    begin
      ListA.Sorted:=True;
      Result:=ListA.IndexOf(ATable)<>-1;
      {IdexA:=-1;
      if ListA.Find(ATable,IdexA) then
      begin
        Result:=IdexA<>-1;
      end;}
    end;
  finally
    FreeAndNil(ListA);
  end;
end;

class function TUniEngine.CheckExist(ATable: string;
  Args: array of Variant; AUniConnection: TUniConnection;ASQLAddition:string): Boolean;
var
  UniQuery:TUniQuery;
  ASQL :string;
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

  ASQL:=Format('SELECT 1 FROM  %S  WHERE 1=1',[ATable]);

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
      ASQL:=ASQL+Format('   AND  %s=%s',[VarToStr(Args[I*2-2]),Temp]);
    end;
  end;

  if Trim(ASQLAddition)<>'' then
  begin
    ASQL:=ASQL + '    ' + ASQLAddition;
  end;
    
  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection :=AUniConnection;
    UniQuery.SQL.Text   :=ASQL;
    UniQuery.Open;
    UniQuery.First;
    if UniQuery.RecordCount=0 then Exit;
    if UniQuery.RecordCount>0 then Result:=True;
  finally
    FreeAndNil(UniQuery);
  end;
end;


class function TUniEngine.CheckField(AField, ATable: string;
  Args: array of Variant; AUniConnection: TUniConnection;ASQLAddition:string): Integer;
var
  UniQuery:TUniQuery;
  ASQL :string;
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

  ASQL:=Format('SELECT MAX( %S )+1 AS MAXX FROM  %S  WHERE 1=1',[AField,ATable]);

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
      ASQL:=ASQL+Format('   AND  %s=%s',[VarToStr(Args[I*2-2]),Temp]);
    end;
  end;

  if Trim(ASQLAddition)<>'' then
  begin
    ASQL:=ASQL + '    ' + ASQLAddition;
  end;

  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection:=AUniConnection;
    UniQuery.SQL.Text  :=ASQL;
    UniQuery.Open;

    if UniQuery.RecordCount=0 then Exit;
    Result:=StrToIntDef(UniQuery.FieldByName('MAXX').AsString,1);
    if Result=0 then Result:=1;
  finally
    FreeAndNil(UniQuery);
  end;
end;


class function TUniEngine.CheckCount(AField, ATable: string;
  Args: array of Variant; AUniConnection: TUniConnection;ASQLAddition:string): Integer;
var
  UniQuery:TUniQuery;
  ASQL :string;
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

  ASQL:=Format('SELECT COUNT( %S ) AS NUMB FROM  %S  WHERE 1=1',[AField,ATable]);

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
      ASQL:=ASQL+Format('   AND  %s=%s',[VarToStr(Args[I*2-2]),Temp]);
    end;
  end;
  
  if Trim(ASQLAddition)<>'' then
  begin
    ASQL:=ASQL + '    ' + ASQLAddition;
  end;
  
  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection:=AUniConnection;
    UniQuery.SQL.Text  :=ASQL;
    UniQuery.Open;

    if UniQuery.RecordCount=0 then Exit;
    Result:=UniQuery.FieldByName('NUMB').AsInteger;
  finally
    FreeAndNil(UniQuery);
  end;
end;

procedure TUniEngine.SaveItWhenNotExist(AUniConnection: TUniConnection);
begin
  if not CheckExist(AUniConnection) then
  begin
    InsertDB(AUniConnection);
  end;
end;

class function TUniEngine.GetDataSet(ASQL: string;
  AUniConnection: TUniConnection): TUniQuery;
begin
  Result:=nil;
  if Trim(ASQL)='' then Exit;

  Result:=TUniQuery.Create(nil);
  Result.Connection:=AUniConnection;
  Result.SQL.Text  :=ASQL;
  Result.Open;
end;

class function TUniEngine.GetDataSet(ASQL: string): TUniQuery;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.GetDataSet] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

class function TUniEngine.CheckField(ASQL, AAsField: string;
  AUniConnection: TUniConnection):Variant;
var
  ADataSet:TUniQuery;  
begin
  Result:=0;
  try
    ADataSet:=GetDataSet(ASQL,AUniConnection);
    if ADataSet.RecordCount=0 then Exit;
    Result:=ADataSet.FieldByName(AAsField).AsVariant;
    if VarIsNull(Result) then
    begin
      Result:=0;
    end;  
  finally
    FreeAndNil(ADataSet);
  end;
end;

class function TUniEngine.ExistConst(AConstraintType,
  AConstraintName: string; AUniConnection: TUniConnection): Boolean;
begin
  Result := False;
  if AUniConnection.ProviderName = CONST_PROVIDER_SQLSRV then
  begin
    if Trim(AConstraintType)='FK' then
    begin
      AConstraintType:='F';
    end;

    //because constraint include.PK,FK,TR,V,
    {if (Trim(AConstraintType)<>'PK') and (Trim(AConstraintType)<>'F') then
    begin
      raise Exception.Create('ERROR:UniEngine.pas.TUniEngine.ExistConst.LINE:725.INFO:OUT OF RANGE'+#13+'TRY PASS IT WITH "PK" OR "FK"');
    end;}

    Result := CheckExist('SYSOBJECTS',['XTYPE',AConstraintType,'NAME',AConstraintName],AUniConnection);
  end else
  if AUniConnection.ProviderName = CONST_PROVIDER_ACCESS then
  begin
    raise Exception.Create('ERROR:UniEngine.pas.TUniEngine.ExistConst.LINE:693.INFO:Not Support Access');
  end else
  if AUniConnection.ProviderName = CONST_PROVIDER_ORACLE then
  begin
    raise Exception.Create('ERROR:UniEngine.pas.TUniEngine.ExistConst.LINE:693.INFO:Not Support Oracle');
  end;
end;

class function TUniEngine.GetServDat(
  AUniConnection: TUniConnection): TDateTime;
var
  SQLA:string;
  UniDataSet:TUniQuery;
  UniConnct :TUniConnection;
begin
  Result:=Now;

  SQLA:='';
  if AUniConnection.ProviderName = CONST_PROVIDER_SQLSRV then
  begin
    SQLA:='SELECT GETDATE() AS SYSDATE';
  end else
  if AUniConnection.ProviderName = CONST_PROVIDER_ACCESS then
  begin
    SQLA:='SELECT DATE() AS SYSDATE'
  end else
  if AUniConnection.ProviderName = CONST_PROVIDER_ORACLE then
  begin
    SQLA:='SELECT SYSDATE FROM DUAL'
  end;

  if SQLA='' then Exit;
  try
    UniDataSet:=nil;
    UniDataSet:=GetDataSet(SQLA,AUniConnection);
    if (UniDataSet<>nil) and (UniDataSet.RecordCount=1) then
    begin
      Result:=UniDataSet.FieldByName('SYSDATE').AsDateTime;
    end;   
  finally
    FreeAndNil(UniDataSet);
  end;
end;

class function TUniEngine.ListDB(ASQL: string;withSorted:Boolean): TStringList;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.ListDB] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

class function TUniEngine.ListDB(ASQL: string;
  AUniConnection: TUniConnection;withSorted:Boolean): TStringList;
begin
  Result:=StrsDB(ASQL,AUniConnection,withSorted);
end;

class function TUniEngine.ListDB(ASQL: string;
  Fields: array of string;withSorted:Boolean): TStringList;
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TUniEngine.ListDB] AT [UniEngine.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
end;

class function TUniEngine.ListDB(ASQL: string; Fields: array of string;
  AUniConnection: TUniConnection;withSorted:Boolean): TStringList;
begin
  Result:=StrsDB(ASQL,Fields,AUniConnection,withSorted);
end;

class procedure TUniEngine.ListDB(ASQL: string;
  AUniConnection: TUniConnection; var Result: TStringList;withSorted:Boolean);
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
    UniQuery.Connection :=AUniConnection;

    if ASQL='' then raise Exception.Create('SQL=NIL');

    UniQuery.SQL.Text:=ASQL;
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


class procedure TUniEngine.ListDB(ASQL: string; Fields: array of string;
  AUniConnection: TUniConnection; var Result: TStringList;withSorted:Boolean);
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
    UniQuery.Connection :=AUniConnection;    

    if ASQL='' then raise Exception.Create('SQL=NIL');
    
    UniQuery.SQL.Text:=ASQL;
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

class procedure TUniEngine.ReadDB(ASQL: string;
  AUniConnection: TUniConnection; var Result: TUniEngine);
var
  UniQuery:TUniQuery;
begin
  if Result=nil then Exit;
  
  try
    UniQuery:=TUniQuery.Create(nil);
    UniQuery.Connection :=AUniConnection;
    //UniQuery.Prepared   :=True;

    if ASQL='' then raise Exception.Create('SQL=NIL');

    UniQuery.SQL.Text:=ASQL;
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


class function TUniEngine.ExistInKey(AConstraintType, AField,
  ATable: string; AUniConnection: TUniConnection): Boolean;
begin

end;

//class function TUniEngine.TOJSON(AList: TStringList;AOperateType:TOperateType): string;
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
//  if (AList=nil) or (AList.Count=0) then Exit;
//
//  for I:=0 to AList.Count -1 do
//  begin
//    Instance:=TUniEngine(AList.Objects[I]);
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

//class procedure TUniEngine.INJSON(AValue:string;AClass:TUniEngineClass;var AList: TStringList;ACleanList:Boolean);
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
//    if (AList=nil) then Exit;
//    if ACleanList  then
//    begin
//      TKzUtils.JustCleanList(AList);
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
//    AList.Sorted:=False;
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
//      AList.AddObject(Instance.GetStrsIndex,Instance);
//      FreeAndNil(ListB);
//    end;
//  finally
//    FreeAndNil(ListA);
//    FreeMem(PropList);
//  end;
//end;

class procedure TUniEngine.STRIDX(Args: array of string;
  AList: TStringList; ASeparator: string; withQuoted:Boolean);
var
  I,M  :Integer;
  NameA:string;
  TMPA:string;
  Instance:TUniEngine;
begin
  if (AList=nil) or (AList.Count=0) then Exit;
  AList.Sorted:=False;

  for I:=0 to AList.Count-1 do
  begin
    Instance:=TUniEngine(AList.Objects[I]);
    if Instance=nil then Continue;

    TMPA:='';
    for M:=0 to Length(Args)-1 do
    begin
      NameA:=Args[M];

      TMPA:=TMPA + ASeparator + VarToStr(GetPropValue(Instance,NameA));
      {if withQuoted then
      begin
        TMPA:=TMPA + ASeparator +QuotedStr(VarToStr(GetPropValue(Instance,NameA)));
      end else
      begin
        TMPA:=TMPA + ASeparator +VarToStr(GetPropValue(Instance,NameA));
      end;}
    end;
    Delete(TMPA,1,Length(ASeparator));

    if withQuoted then
    begin
      AList.Strings[I]:=QuotedStr(TMPA);
    end else
    begin
      AList.Strings[I]:=TMPA;
    end;
  end;
end;

class function TUniEngine.STRDIY(Args: array of string;
  AList: TStringList;ASeparator: string;withQuoted:Boolean): string;
var
  I,M:Integer;
  Instance:TUniEngine;
  NameA:string;
  TMPA:string;
begin
  Result:='';
  if (AList=nil) or (AList.Count=0) then Exit;

  for I:=0 to AList.Count -1 do
  begin
    Instance:=TUniEngine(AList.Objects[I]);
    if Instance=nil then Continue;

    TMPA:='';
    for M:=0 to Length(Args)-1 do
    begin
      NameA:=Args[M];
      
      TMPA:=TMPA + '-' + VarToStr(GetPropValue(Instance,NameA));
    end;
    Delete(TMPA,1,1);

    if withQuoted then
    begin
      Result:=Result +  ASeparator +QuotedStr(TMPA);
    end else
    begin
      Result:=Result +  ASeparator +TMPA;
    end;
  end;
  
  Delete(Result,1,Length(ASeparator));
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

class function TUniEngine.ExistFieldInOracle(ATable, AField: string;
  AUniConnection: TUniConnection): Boolean;
var
  IdexA:Integer;
  ListA:TStringList;
  UniDataSet:TUniQuery;
begin
  Result:=False;

  if not ExistTable(ATable,AUniConnection) then
  begin
    raise Exception.CreateFmt('NOT EXIST SUCH TABLE:%S',[ATable]);
  end;

  UniDataSet:=GetDataSet(Format('SELECT * FROM %S WHERE ROWNUM<1',[ATable]),AUniConnection);
  if UniDataSet<>nil then
  begin
    Result:=UniDataSet.FindField(AField)<>nil;
    FreeAndNil(UniDataSet);
  end;
end;

class procedure TUniEngine.GetDataSet(ASQL:string;Fields:array of string;
  AUniConnection: TUniConnection; var Result: TStringList;ASeparator:string=',');
var
  I:Integer;
  TMPA:string;
  TMPB:string;
  
  UniQuery:TUniQuery;
begin
  if Result=nil then Exit;

  try
    UniQuery:=GetUniQuery(ASQL,AUniConnection);
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
          TMPA:=TMPA+ASeparator+TMPB;
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

class procedure TUniEngine.ListDB(ASQL: string;
  AUniConnection: TUniConnection; var Result: TCollection;
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
    UniQuery.Connection :=AUniConnection;

    if ASQL='' then raise Exception.Create('SQL=NIL');

    UniQuery.SQL.Text:=ASQL;
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

class function TUniEngine.STRDIY(Args: array of string; AList: TCollection;
  ASeparator: string; BSeparator:string; withQuoted: Boolean): string;
var
  I,M:Integer;
  Instance:TUniEngine;
  NameA:string;
  TMPA:string;
begin
  Result:='';
  if (AList=nil) or (AList.Count=0) then Exit;

  for I:=0 to AList.Count -1 do
  begin
    Instance:=TUniEngine(AList.Items[I]);
    if Instance=nil then Continue;

    TMPA:='';
    for M:=0 to Length(Args)-1 do
    begin
      NameA:=Args[M];
      
      TMPA:=TMPA + BSeparator + VarToStr(GetPropValue(Instance,NameA));
    end;
    Delete(TMPA,1,1);

    if withQuoted then
    begin
      Result:=Result +  ASeparator +QuotedStr(TMPA);
    end else
    begin
      Result:=Result +  ASeparator +TMPA;
    end;
  end;
  
  Delete(Result,1,Length(ASeparator));
end;

end.
