unit Helpr_UniEngine;


interface
uses
  System.Classes,System.SysUtils,UniEngine,QJSON,QString;

type
  THelprUniEngine=class helper for TUniEngine
  public
    function  ToJSON(doFormat:Boolean=False):string;overload;
    procedure InJSON(aValue:string);overload;
    procedure InJSON(aValue:string;AField:string;AIndex:Integer=0);overload;

    procedure ToFILE(aFileName:string;doFormat:Boolean=False);overload;
    procedure InFILE(aFileName:string);overload;
  public
    class function  ToJSON(aList:TCollection;doFormat:Boolean=False):string;overload;
    class procedure InJSON(aValue:string;var aList:TCollection);overload;
    class procedure InJSON(aValue:string;AField:string;var aList:TCollection;AIndex:Integer=0);overload;

    class procedure ToFILE(aFileName:string;aList:TCollection;doFormat:Boolean=False);overload;
    class procedure InFILE(aFileName:string;var aList:TCollection);overload;
  end;

implementation


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

procedure THelprUniEngine.InJson(aValue:string);
var
  JSON:TQJson;
begin
  if Trim(aValue) = '' then Exit;
  
  try
    JSON:=TQJson.Create;
    JSON.Parse(aValue);
    JSON.ToRtti(Self);
  finally
    FreeAndNil(JSON);
  end;
end;

procedure THelprUniEngine.ToFILE(aFileName: string;doFormat:Boolean=False);
var
  JSON:TQJson;
begin
  EncodeJsonBinaryAsBase64;
  try
    JSON:=TQJson.Create;
    JSON.FromRtti(Self);
    JSON.SaveToFile(aFileName,teUTF8,False,doFormat);
  finally
    FreeAndNil(JSON);
  end;
end;

class procedure THelprUniEngine.ToFILE(aFileName: string; aList: TCollection;doFormat:Boolean);
var
  JSON:TQJson;
begin
  try
    JSON:=TQJson.Create;
    JSON.FromRtti(aList);
    JSON.SaveToFile(aFileName,teUTF8,False,doFormat);
  finally
    FreeAndNil(JSON);
  end;
end;

class function THelprUniEngine.ToJson(aList: TCollection;doFormat:Boolean): string;
var
  JSON:TQJson;
begin
  Result:='';
  try
    JSON:=TQJson.Create;
    JSON.FromRtti(aList);
    Result:=JSON.Encode(doFormat,True);
  finally
    FreeAndNil(JSON);
  end;
end;


procedure THelprUniEngine.InFILE(aFileName: string);
var
  JSON:TQJson;
begin
  try
    JSON:=TQJson.Create;
    JSON.LoadFromFile(aFileName);
    JSON.ToRtti(Self);
  finally
    FreeAndNil(JSON);
  end;
end;

class procedure THelprUniEngine.InFILE(aFileName: string;
  var aList: TCollection);
var
  JSON:TQJson;
begin
  try
    JSON:=TQJson.Create;
    JSON.LoadFromFile(aFileName);
    JSON.ToRtti(aList);
  finally
    FreeAndNil(JSON);
  end;
end;

class procedure THelprUniEngine.InJson(aValue: string; var aList: TCollection);
var
  JSON:TQJson;
begin
  if Trim(aValue) = '' then Exit;

  try
    JSON:=TQJson.Create;
    JSON.Parse(aValue);
    JSON.ToRtti(aList);
  finally
    FreeAndNil(JSON);
  end;
end;

procedure THelprUniEngine.InJSON(aValue, AField: string;AIndex:Integer);
var
  JSON:TQJson;
begin
  if Trim(aValue) = '' then Exit;

  try
    JSON:=TQJson.Create;
    JSON.Parse(aValue);
    if JSON.ItemByName(AField)<>nil then
    begin
      if JSON.ItemByName(AField).Count>0 then
      begin
        JSON.ItemByName(AField).Items[AIndex].ToRtti(Self);
      end;
    end;
  finally
    FreeAndNil(JSON);
  end;
end;

class procedure THelprUniEngine.InJSON(aValue, AField: string;
  var aList: TCollection; AIndex: Integer);
var
  JSON:TQJson;
begin
  if Trim(aValue) = '' then Exit;

  try
    JSON:=TQJson.Create;
    JSON.Parse(aValue);
    JSON.ItemByName(AField).ToRtti(aList);
  finally
    FreeAndNil(JSON);
  end;
end;
end.
