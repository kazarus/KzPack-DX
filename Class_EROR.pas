unit Class_EROR;

interface
uses
  System.Classes,System.SysUtils,UniEngine,Helpr_UniEngine,QJSON;

type
  TEROR=class(TUniEngine)
  private
    FERORCODE:string;
    FERORMEMO:string;
    FLISTDATA:TCollection;
  public
    function  IsTRUE:Boolean;overload;
  public
    class function  ToTRUE(AValue:TCollection):string;
    class function  ToEROR(AMemo:string='NOT FOUND'):string;

    class function  ToData(ACode,AMemo:string;AValue:TCollection):string;overload;
    class function  IsTRUE(AValue:string):Boolean;overload;
  public
    class procedure InData(AValue:string;var AList:TCollection);overload;deprecated;
    class procedure InData(AValue:string;var AObjt:TCollectionItem;AField:string='LISTDATA');overload;deprecated;
  published
    property ERORCODE :string read FERORCODE write FERORCODE;
    property ERORMEMO :string read FERORMEMO write FERORMEMO;
    property LISTDATA :TCollection read FListData write FListData;
  end;
implementation

uses
  Class_KzUtils,Class_AppUtil;

{ TEROR }


{ TEROR }


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
    Result:=JSON.ItemByName('ERORCODE').Value=CONST_MARK_TRUE;
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
