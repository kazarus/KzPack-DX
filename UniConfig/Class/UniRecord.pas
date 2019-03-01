unit UniRecord;


interface
uses
  Classes,SysUtils,DB,Uni,UniEngine;

type
  TUniRecord=class(TUniEngine)
  private
    FLineData: TCollection;
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
  public
    procedure Initialize;
  published
    property LINEDATA: TCollection read FLineData write FLineData;
  public
    class function  ReadDS(aUniQuery:TUniQuery):TUniEngine;override;
    class procedure ReadDS(aUniQuery:TUniQuery;var Result:TUniEngine);override;

    class function  CopyIt(aUNIOBJECT:TUniRecord):TUniRecord;overload;
    class procedure CopyIt(aUNIOBJECT:TUniRecord;var Result:TUniRecord);overload;

    class function  CopyIt(aUniEngine:TUniEngine):TUniEngine;overload;override;
    class procedure CopyIt(aUniEngine:TUniEngine;var Result:TUniEngine)overload;override;
  end;

implementation

uses
  UniObject, Class_KzUtils;


procedure TUniRecord.SetParameters;
begin
  inherited;
  with FUniSQL.Params do
  begin
    case FOptTyp of
      otAddx:
      begin
      end;
      otEdit:
      begin
      end;
      otDelt:
      begin
      end;
    end;
  end;
end;

function TUniRecord.CheckExist(aUniConnection: TUniConnection): Boolean;
begin
end;

function TUniRecord.GetStrDelete: string;
begin
  Result:='DELETE FROM UNIOBJECT WHERE   UNIFIELD=:UNIFIELD';
end;

function TUniRecord.GetStrInsert: string;
begin
end;

function TUniRecord.GetStrsIndex: string;
begin
end;

function TUniRecord.GetStrUpdate: string;
begin
end;

procedure TUniRecord.Initialize;
begin
  if FLineData = nil then
  begin
    FLineData := TCollection.Create(TUniObject);
  end;
  TKzUtils.JustCleanList(FLineData);
end;

constructor TUniRecord.Create;
begin

end;

destructor TUniRecord.Destroy;
begin
  if FLineData <> nil then TKzUtils.TryFreeAndNil(FLineData);
  
  inherited;
end;

class function TUniRecord.ReadDS(aUniQuery: TUniQuery): TUniEngine;
begin
  Result := TUniRecord.Create;
  TUniRecord.ReadDS(AUniQuery,Result);
end;

class procedure TUniRecord.ReadDS(aUniQuery: TUniQuery; var Result: TUniEngine);
var
  I:Integer;
  Field:TField;
  FieldName:string;
begin
  if Result = nil then Exit;

  with TUniRecord(Result) do
  begin
    for I:=0 to aUniQuery.Fields.Count-1 do
    begin
      Field := aUniQuery.Fields.Fields[I];
      //if field.fieldname is not all uppercase,please use uppercase().
      FieldName := UpperCase(Field.FieldName);
    end
  end;
end;

class function  TUniRecord.CopyIt(aUNIOBJECT: TUniRecord): TUniRecord;
begin
  Result := TUniRecord.Create;
  TUniRecord.CopyIt(aUNIOBJECT,Result)
end;

class procedure TUniRecord.CopyIt(aUNIOBJECT:TUniRecord;var Result:TUniRecord);
begin
  if Result = nil then Exit;

end;

class function TUniRecord.CopyIt(aUniEngine: TUniEngine): TUniEngine;
begin
  Result := TUniRecord.Create;
  TUniEngine.CopyIt(aUniEngine,Result);
end;

class procedure TUniRecord.CopyIt(aUniEngine: TUniEngine; var Result: TUniEngine);
begin
  if Result = nil then Exit;
  TUniRecord.CopyIt(TUniRecord(aUniEngine),TUniRecord(Result));
end;

end.
