unit UniObject;


interface
uses
  Classes,SysUtils,DB,Uni,UniEngine;

type
  TUniObject = class(TUniEngine)
  private
    FUNIFIELD : string;
    FUNIVALUE : string;
  protected
    procedure SetParameters;override;
    function  GetStrInsert:string;override;
    function  GetStrUpdate:string;override;
    function  GetStrDelete:string;override;
  public
    function  GetStrsIndex:string;override;
  public
    //#function  GetNextIndx:Integer;overload;
    //#function  GetNextIndx(aUniConnection:TUniConnection):Integer;overload;
  public
    function  CheckExist(aUniConnection:TUniConnection):Boolean;override;
  public
    destructor  Destroy; override;
    constructor Create;
  published
    property UNIFIELD : string read FUNIFIELD  write FUNIFIELD;
    property UNIVALUE : string read FUNIVALUE  write FUNIVALUE;
  public
    class function  ReadDS(aUniQuery:TUniQuery):TUniEngine;override;
    class procedure ReadDS(aUniQuery:TUniQuery;var Result:TUniEngine);override;

    class function  CopyIt(aUNIOBJECT:TUniObject):TUniObject;overload;
    class procedure CopyIt(aUNIOBJECT:TUniObject;var Result:TUniObject);overload;

    class function  CopyIt(aUniEngine:TUniEngine):TUniEngine;overload;override;
    class procedure CopyIt(aUniEngine:TUniEngine;var Result:TUniEngine)overload;override;
  end;

implementation


procedure TUniObject.SetParameters;
begin
  inherited;
  with FUniSQL.Params do
  begin
    case FOptTyp of
      otAddx:
      begin
        ParamByName('UNIFIELD').Value := UNIFIELD;
        ParamByName('UNIVALUE').Value := UNIVALUE;
      end;
      otEdit:
      begin
        ParamByName('UNIFIELD').Value := UNIFIELD;
        ParamByName('UNIVALUE').Value := UNIVALUE;
      end;
      otDelt:
      begin
        ParamByName('UNIFIELD').Value := UNIFIELD;

      end;
    end;
  end;
end;

function TUniObject.CheckExist(aUniConnection: TUniConnection): Boolean;
begin
  Result := CheckExist('UNIOBJECT',['UNIFIELD',UNIFIELD],AUniConnection);
end;

function TUniObject.GetStrDelete: string;
begin
  Result:='DELETE FROM UNIOBJECT WHERE   UNIFIELD=:UNIFIELD';
end;

function TUniObject.GetStrInsert: string;
begin
  Result:='INSERT INTO UNIOBJECT'
         +'    ( UNIFIELD, UNIVALUE)'
         +'    VALUES'
         +'    (:UNIFIELD,:UNIVALUE)';
end;

function TUniObject.GetStrsIndex: string;
begin
  Result:=Format('%S',[UNIFIELD]);
end;

function TUniObject.GetStrUpdate: string;
begin
  Result:='UPDATE  UNIOBJECT SET'
         +'    UNIVALUE=:UNIVALUE'
         +'    WHERE UNIFIELD=:UNIFIELD';
end;

constructor TUniObject.Create;
begin

end;

destructor TUniObject.Destroy;
begin

  inherited;
end;

class function TUniObject.ReadDS(aUniQuery: TUniQuery): TUniEngine;
begin
  Result := TUniObject.Create;
  TUniObject.ReadDS(AUniQuery,Result);
end;

class procedure TUniObject.ReadDS(aUniQuery: TUniQuery; var Result: TUniEngine);
var
  I:Integer;
  Field:TField;
  FieldName:string;
begin
  if Result = nil then Exit;

  with TUniObject(Result) do
  begin
    for I:=0 to aUniQuery.Fields.Count-1 do
    begin
      Field := aUniQuery.Fields.Fields[I];
      //if field.fieldname is not all uppercase,please use uppercase().
      FieldName := UpperCase(Field.FieldName);
      if FieldName = 'UNIFIELD' then
      begin
        UNIFIELD  := Field.AsString;
      end else
      if FieldName = 'UNIVALUE' then
      begin
        UNIVALUE  := Field.AsString;
      end;
    end
  end;
end;

class function  TUniObject.CopyIt(aUNIOBJECT: TUniObject): TUniObject;
begin
  Result := TUniObject.Create;
  TUniObject.CopyIt(aUNIOBJECT,Result)
end;

class procedure TUniObject.CopyIt(aUNIOBJECT:TUniObject;var Result:TUniObject);
begin
  if Result = nil then Exit;
  Result.UNIFIELD := aUNIOBJECT.UNIFIELD;
  Result.UNIVALUE := aUNIOBJECT.UNIVALUE;
end;

class function TUniObject.CopyIt(aUniEngine: TUniEngine): TUniEngine;
begin
  Result := TUniObject.Create;
  TUniEngine.CopyIt(aUniEngine,Result);
end;

class procedure TUniObject.CopyIt(aUniEngine: TUniEngine; var Result: TUniEngine);
begin
  if Result = nil then Exit;
  TUniObject.CopyIt(TUniObject(aUniEngine),TUniObject(Result));
end;

end.
