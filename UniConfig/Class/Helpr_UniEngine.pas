unit Helpr_UniEngine;


interface
uses
  System.Classes,System.SysUtils,UniEngine,QJSON;

type
  THelprUniEngine=class helper for TUniEngine
  public
    function  ToJSON:string;overload;
    procedure InJSON(AValue:string);overload;

    procedure ToFILE(AFileName:string);overload;
    procedure InFILE(AFileName:string);overload;
  public
    class function  ToJSON(AList:TCollection):string;overload;
    class procedure InJSON(AValue:string;var AList:TCollection);overload;

    class procedure ToFILE(AFileName:string;AList:TCollection);overload;
    class procedure InFILE(AFileName:string;var AList:TCollection);overload;
  end;

implementation

{ TUniEngineExRtti }

function THelprUniEngine.ToJson: string;
var
  JSON:TQJson;
begin
  Result:='';
  try
    JSON:=TQJson.Create;
    JSON.FromRtti(Self);
    Result:=JSON.Encode(True,True);
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

procedure THelprUniEngine.ToFILE(AFileName: string);
var
  JSON:TQJson;
begin
  try
    JSON:=TQJson.Create;
    JSON.FromRtti(Self);
    JSON.SaveToFile(AFileName);
  finally
    FreeAndNil(JSON);
  end;
end;

class procedure THelprUniEngine.ToFILE(AFileName: string; AList: TCollection);
var
  JSON:TQJson;
begin
  try
    JSON:=TQJson.Create;
    JSON.FromRtti(AList);
    JSON.SaveToFile(AFileName);
  finally
    FreeAndNil(JSON);
  end;
end;

class function THelprUniEngine.ToJson(AList: TCollection): string;
var
  JSON:TQJson;
begin
  Result:='';
  try
    JSON:=TQJson.Create;
    JSON.FromRtti(AList);
    Result:=JSON.Encode(True,True);
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

end.
