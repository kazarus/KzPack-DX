unit Class_EROR;

interface
uses
  System.Classes,System.SysUtils,UniEngine,Helpr_UniEngine,QJSON;

type
  TEROR=class(TUniEngine)
  private
    FERORCODE:string;
    FERORMEMO:string;
    FLASTDATE:Integer;
    FLASTTIME:Integer;
    FLISTDATA:TCollection;
  public
    function  IsTRUE:Boolean;overload;
  public
    class function  ToTRUE(AValue:TCollection):string;
    class function  ToEROR(AMemo:string='NOT FOUND'):string;

    class function  ToData(ACode,AMemo:string;AValue:TCollection):string;overload;
    class function  IsTRUE(AValue:string):Boolean;overload;
    class function  erCode(aValue:string):string;
    class function  erMemo(aValue:string):string;
  public
    class procedure InData(AValue:string;var AList:TCollection);overload;deprecated;
    class procedure InData(AValue:string;var AObjt:TCollectionItem;AField:string='LISTDATA');overload;deprecated;
  public
    constructor Create;
  published
    property ERORCODE :string      read FERORCODE write FERORCODE;
    property ERORMEMO :string      read FERORMEMO write FERORMEMO;
    property LASTDATE :Integer     read FLASTDATE write FLASTDATE;
    property LASTTIME :Integer     read FLASTTIME write FLASTTIME;
    property LISTDATA :TCollection read FListData write FListData;
  end;

const
  CONST_MARK_TRUE='TRUE';
  CONST_MARK_EROR='EROR';

implementation

uses
  Class_KzUtils,Class_AppUtil;


class procedure TEROR.InData(AValue: string; var AList: TCollection);
var
  JSON:TQJSON;
begin
  try
    JSON:=TQJson.Create;
    JSON.Parse(AValue);
    JSON.ItemByName('LISTDATA').ToRtti(AList);
  finally
    FreeAndNil(JSON);
  end;
end;

constructor TEROR.Create;
begin
  LASTDATE:=StrToIntDef(FormatDateTime('YYYYMMDD',Now),0);
  LASTTIME:=StrToIntDef(FormatDateTime('HHMMSS',Now),0);
end;

class function TEROR.erCode(aValue: string): string;
var
  JSON:TQJSON;
begin
  try
    JSON:=TQJson.Create;
    JSON.Parse(AValue);
    if JSON.ItemByName('ERORCODE')<>nil then
    begin
      Result:=JSON.ItemByName('ERORCODE').Value;
    end;
  finally
    FreeAndNil(JSON);
  end;
end;


class function TEROR.erMemo(aValue: string): string;
var
  JSON:TQJSON;
begin
  try
    JSON:=TQJson.Create;
    JSON.Parse(AValue);
    if JSON.ItemByName('ERORMEMO')<>nil then
    begin
      Result:=JSON.ItemByName('ERORMEMO').Value;
    end;
  finally
    FreeAndNil(JSON);
  end;
end;

class procedure TEROR.InData(AValue: string; var AObjt: TCollectionItem; AField:string);
var
  JSON:TQJSON;
begin
  try
    JSON:=TQJson.Create;
    JSON.Parse(AValue);
    JSON.ItemByName(AField).ToRtti(AObjt);
  finally
    FreeAndNil(JSON);
  end;
end;

class function TEROR.IsTRUE(AValue: string): Boolean;
var
  JSON:TQJSON;
begin
  try
    JSON:=TQJson.Create;
    JSON.Parse(AValue);
    if JSON.ItemByName('ERORCODE')<>nil then
    begin
      Result:=JSON.ItemByName('ERORCODE').Value=CONST_MARK_TRUE;
    end;
  finally
    FreeAndNil(JSON);
  end;
end;

function TEROR.IsTRUE: Boolean;
begin
  Result:=ERORCODE=CONST_MARK_TRUE;
end;

class function TEROR.ToData(ACode, AMemo: string; AValue: TCollection): string;
var
  EROR:TEROR;
begin
  try
    EROR:=TEROR.Create;
    EROR.ERORCODE:=ACode;
    EROR.ERORMEMO:=AMemo;
    EROR.ListData:=AValue;

    Result:=EROR.ToJSON;
  finally
    FreeAndNil(EROR);
  end;
end;

class function TEROR.ToEROR(AMemo: string): string;
begin
  Result:=TEROR.ToData(CONST_MARK_EROR,AMemo,nil);
end;

class function TEROR.ToTRUE(AValue: TCollection): string;
begin
  Result:=TEROR.ToData(CONST_MARK_TRUE,CONST_MARK_TRUE,AValue);
end;

end.
