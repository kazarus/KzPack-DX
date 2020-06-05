unit Class_EROR;


interface
uses
  System.Classes, System.SysUtils, UniEngine, Helpr_UniEngine, QJSON;

type
  TErrorType = (etSuccess, etFailure, etErrorEd);

  TEROR = class(TUniEngine)
  private
    FERORCODE: string;
    FERORMEMO: string;
    FONSTATUS: Boolean;
    FLASTDATE: Integer;
    FLASTTIME: Integer;
    FLISTDATA: TCollection;
  public
    function  IsTRUE:Boolean;overload;
  public
    class function  ToTRUE(aValue:TCollection):string;
    class function  ToEROR(aValue: TCollection): string; overload;
    class function  ToEROR(aMemo: string = 'NOT FOUND'): string; overload;
    class function  ToEROR(aCode: string; aMemo: string): string; overload;
    class function  ToEFMT(aMemo: string; Params: array of const): string; overload;
  public
    class function  ToData(aCode, aMemo: string; onStatus: Boolean; aValue: TCollection): string; overload;
    class function  IsTRUE(aValue:string):Boolean;overload;
    class function  erCode(aValue:string):string;
    class function  erMemo(aValue:string):string;
  public
    class procedure InData(aValue:string;var AList:TCollection);overload;deprecated;
    class procedure InData(aValue:string;var AObjt:TCollectionItem;AField:string='LISTDATA');overload;deprecated;
  public
    constructor Create;
  published
    property ERORCODE: string  read FERORCODE write FERORCODE;
    property ERORMEMO: string  read FERORMEMO write FERORMEMO;
    property ONSTATUS: Boolean read FONSTATUS write FONSTATUS;
    property LASTDATE: Integer read FLASTDATE write FLASTDATE;
    property LASTTIME: Integer read FLASTTIME write FLASTTIME;
    property LISTDATA: TCollection read FListData write FListData;
  end;

const
  CONST_MARK_TRUE='TRUE';
  CONST_MARK_EROR='EROR';

implementation

uses
  Class_KzUtils,Class_AppUtil;


class procedure TEROR.InData(aValue: string; var AList: TCollection);
var
  JSON:TQJSON;
begin
  try
    JSON:=TQJson.Create;
    JSON.Parse(aValue);
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
    JSON.Parse(aValue);
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
    JSON.Parse(aValue);
    if JSON.ItemByName('ERORMEMO')<>nil then
    begin
      Result:=JSON.ItemByName('ERORMEMO').Value;
    end;
  finally
    FreeAndNil(JSON);
  end;
end;

class procedure TEROR.InData(aValue: string; var AObjt: TCollectionItem; AField:string);
var
  JSON:TQJSON;
begin
  try
    JSON:=TQJson.Create;
    JSON.Parse(aValue);
    JSON.ItemByName(AField).ToRtti(AObjt);
  finally
    FreeAndNil(JSON);
  end;
end;

class function TEROR.IsTRUE(aValue: string): Boolean;
var
  JSON:TQJSON;
begin
  try
    JSON:=TQJson.Create;
    JSON.Parse(aValue);
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
  Result := ERORCODE = CONST_MARK_TRUE;
end;

class function TEROR.ToData(aCode, aMemo: string; onStatus: Boolean; aValue: TCollection): string;
var
  EROR:TEROR;
begin
  try
    EROR := TEROR.Create;
    EROR.ONSTATUS := onStatus;
    EROR.ERORCODE := aCode;
    EROR.ERORMEMO := aMemo;
    EROR.ListData := aValue;

    Result := EROR.ToJSON;
  finally
    FreeAndNil(EROR);
  end;
end;

class function TEROR.ToEFMT(aMemo: string; Params: array of const): string;
var
  Value: TCollection;
begin
  try
    Value := TCollection.Create(TEROR);
    Result := TEROR.ToData(CONST_MARK_EROR, Format(aMemo,Params), False, Value);
  finally
    FreeAndNil(Value);
  end;
end;

class function TEROR.ToEROR(aCode, aMemo: string): string;
var
  Value: TCollection;
begin
  try
    Value := TCollection.Create(TEROR);
    Result := TEROR.ToData(aCode, aMemo, False, Value);
  finally
    FreeAndNil(Value);
  end;
end;

class function TEROR.ToEROR(aValue: TCollection): string;
begin
  Result := TEROR.ToData(CONST_MARK_EROR, CONST_MARK_EROR, False, aValue);
end;

class function TEROR.ToEROR(aMemo: string): string;
var
  Value: TCollection;
begin
  try
    Value := TCollection.Create(TEROR);
    Result := TEROR.ToData(CONST_MARK_EROR, aMemo, False, Value);
  finally
    FreeAndNil(Value);
  end;
end;

class function TEROR.ToTRUE(aValue: TCollection): string;
begin
  Result := TEROR.ToData(CONST_MARK_TRUE, CONST_MARK_TRUE, True, aValue);
end;

end.
