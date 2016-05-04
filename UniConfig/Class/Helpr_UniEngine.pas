unit Helpr_UniEngine;


interface
uses
  System.Classes,System.SysUtils,UniEngine,QJSON,QString;

type
  THelprUniEngine=class helper for TUniEngine
  public
    function  ToJSON(doFormat:Boolean=False):string;overload;
    procedure InJSON(AValue:string);overload;
    procedure InJSON(AValue:string;AField:string;AIndex:Integer=0);overload;

    procedure ToFILE(AFileName:string;doFormat:Boolean=False);overload;
    procedure InFILE(AFileName:string);overload;
  public
    class function  ToJSON(AList:TCollection;doFormat:Boolean=False):string;overload;
    class procedure InJSON(AValue:string;var AList:TCollection);overload;
    class procedure InJSON(AValue:string;AField:string;var AList:TCollection;AIndex:Integer=0);overload;

    class procedure ToFILE(AFileName:string;AList:TCollection;doFormat:Boolean=False);overload;
    class procedure InFILE(AFileName:string;var AList:TCollection);overload;
  end;

implementation

{ TUniEngineExRtti }

function THelprUniEngine.ToJson(doFormat:Boolean): string;
var
  JSON:TQJson;
begin
  Result:='';
  try
    JSON:=TQJson.Create;
    JSON.FromRtti(Self);
    Result:=JSON.Encode(doFormat,True);
  finally
    FreeAndNil(JSON);
  end;
end;

procedure THelprUniEngine.InJson(AValue:string);
var
  JSON:TQJson;
begin
  try
    JSON:=TQJson.Create;
    JSON.Parse(AValue);
    JSON.ToRtti(Self);
  finally
    FreeAndNil(JSON);
  end;
end;

procedure THelprUniEngine.ToFILE(AFileName: string;doFormat:Boolean=False);
var
  JSON:TQJson;
begin
  try
    JSON:=TQJson.Create;
    JSON.FromRtti(Self);
    JSON.SaveToFile(AFileName,teUTF8,True,False);
  finally
    FreeAndNil(JSON);
  end;
end;

class procedure THelprUniEngine.ToFILE(AFileName: string; AList: TCollection;doFormat:Boolean);
var
  JSON:TQJson;
begin
  try
    JSON:=TQJson.Create;
    JSON.FromRtti(AList);
    JSON.SaveToFile(AFileName,teUTF8,True,False);
  finally
    FreeAndNil(JSON);
  end;
end;

class function THelprUniEngine.ToJson(AList: TCollection;doFormat:Boolean): string;
var
  JSON:TQJson;
begin
  Result:='';
  try
    JSON:=TQJson.Create;
    JSON.FromRtti(AList);
    Result:=JSON.Encode(doFormat,True);
  finally
    FreeAndNil(JSON);
  end;
end;


procedure THelprUniEngine.InFILE(AFileName: string);
var
  JSON:TQJson;
begin
  try
    JSON:=TQJson.Create;
    JSON.LoadFromFile(AFileName);
    JSON.ToRtti(Self);
  finally
    FreeAndNil(JSON);
  end;
end;

class procedure THelprUniEngine.InFILE(AFileName: string;
  var AList: TCollection);
var
  JSON:TQJson;
begin
  try
    JSON:=TQJson.Create;
    JSON.LoadFromFile(AFileName);
    JSON.ToRtti(AList);
  finally
    FreeAndNil(JSON);
  end;
end;

class procedure THelprUniEngine.InJson(AValue: string; var AList: TCollection);
var
  JSON:TQJson;
begin
  try
    JSON:=TQJson.Create;
    JSON.Parse(AValue);
    JSON.ToRtti(AList);
  finally
    FreeAndNil(JSON);
  end;
end;

procedure THelprUniEngine.InJSON(AValue, AField: string;AIndex:Integer);
var
  JSON:TQJson;
begin
  try
    JSON:=TQJson.Create;
    JSON.Parse(AValue);
    JSON.ItemByName(AField).Items[AIndex].ToRtti(Self);
  finally
    FreeAndNil(JSON);
  end;
end;

class procedure THelprUniEngine.InJSON(AValue, AField: string;
  var AList: TCollection; AIndex: Integer);
var
  JSON:TQJson;
begin
  try
    JSON:=TQJson.Create;
    JSON.Parse(AValue);
    JSON.ItemByName(AField).ToRtti(AList);
  finally
    FreeAndNil(JSON);
  end;
end;
end.
