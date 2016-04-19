unit Class_Find;


interface
uses
  Classes,SysUtils,DB,Uni,UniEngine;

type
  TFind=class(TUniEngine)
  private
    FFINDCODE : string;
    FOPERAVAL : string;
    FRIGHTVAL : string;
  protected
    procedure SetParameters;override;
    function  GetStrInsert:string;override;
    function  GetStrUpdate:string;override;
    function  GetStrDelete:string;override;
  public
    function  GetStrsIndex:string;override;
  public
    function  GetNextIndx:Integer;overload;
    function  GetNextIndx(AUniConnection:TUniConnection):Integer;overload;
  public
    function  CheckExist(AUniConnection:TUniConnection):Boolean;override;
  public
    destructor  Destroy; override;
    constructor Create;
  published
    property FINDCODE : string read FFINDCODE  write FFINDCODE;
    property OPERAVAL : string read FOPERAVAL  write FOPERAVAL;
    property RIGHTVAL : string read FRIGHTVAL  write FRIGHTVAL;
  public
    class function  ReadDS(AUniQuery:TUniQuery):TUniEngine;override;
    class procedure ReadDS(AUniQuery:TUniQuery;var Result:TUniEngine);override;
    class function  CopyIt(AFind:TFind):TFind;overload;
    class procedure CopyIt(AFind:TFind;var Result:TFind);overload;
  end;

implementation

{ TFind }
procedure TFind.SetParameters;
begin
  inherited;
  with FUniSQL.Params do
  begin
    case FOptTyp of
      otAddx:
      begin
        ParamByName('FIND_CODE').Value := FINDCODE;
        ParamByName('OPERA_VAL').Value := OPERAVAL;
        ParamByName('RIGHT_VAL').Value := RIGHTVAL;
      end;
      otEdit:
      begin
        ParamByName('FIND_CODE').Value := FINDCODE;
        ParamByName('OPERA_VAL').Value := OPERAVAL;
        ParamByName('RIGHT_VAL').Value := RIGHTVAL;
      end;
      otDelt:
      begin
        ParamByName('FIND_CODE').Value := FINDCODE;

      end;
    end;
  end;
end;

function TFind.CheckExist(AUniConnection: TUniConnection): Boolean;
begin
  Result:=CheckExist('TBL_FIND',['FIND_CODE',FINDCODE],AUniConnection);
end;

function TFind.GetNextIndx: Integer;
begin

end;

function TFind.GetNextIndx(AUniConnection: TUniConnection): Integer;
begin

end;

function TFind.GetStrDelete: string;
begin
  Result:='DELETE FROM TBL_FIND WHERE   FIND_CODE=:FIND_CODE';
end;

function TFind.GetStrInsert: string;
begin
  Result:='INSERT INTO TBL_FIND'
         +'    ( FIND_CODE, OPERA_VAL, RIGHT_VAL)'
         +'    VALUES'
         +'    (:FIND_CODE,:OPERA_VAL,:RIGHT_VAL)';
end;

function TFind.GetStrsIndex: string;
begin
  Result:=Format('%S',[FINDCODE]);
end;

function TFind.GetStrUpdate: string;
begin
  Result:='UPDATE  TBL_FIND SET'
         +'    OPERA_VAL=:OPERA_VAL,'
         +'    RIGHT_VAL=:RIGHT_VAL'
         +'    WHERE FIND_CODE=:FIND_CODE';
end;

constructor TFind.Create;
begin

end;

destructor TFind.Destroy;
begin

  inherited;
end;

class function TFind.ReadDS(AUniQuery: TUniQuery): TUniEngine;
begin
  Result:=TFind.Create;
  TFind.ReadDS(AUniQuery,Result);
end;

class procedure TFind.ReadDS(AUniQuery: TUniQuery; var Result: TUniEngine);
var
  I:Integer;
  Field:TField;
  FieldName:string;
begin
  if Result=nil then Exit;

  with TFind(Result) do
  begin
    for I:=0 to AUniQuery.Fields.Count-1 do
    begin
      Field:=AUniQuery.Fields.Fields[I];
      //if field.fieldname is not all uppercase,please use uppercase().
      FieldName:=Field.FieldName;
      if FieldName='FIND_CODE' then
      begin
        FINDCODE :=Field.AsString;
      end else
      if FieldName='OPERA_VAL' then
      begin
        OPERAVAL :=Field.AsString;
      end else
      if FieldName='RIGHT_VAL' then
      begin
        RIGHTVAL :=Field.AsString;
      end;
    end
  end;
end;

class function  TFind.CopyIt(AFind: TFind): TFind;
begin
  Result:=TFind.Create;
  TFind.CopyIt(AFind,Result)
end;

class procedure TFind.CopyIt(AFind:TFind;var Result:TFind);
begin
  if Result=nil then Exit;
  Result.FINDCODE :=AFind.FINDCODE;
  Result.OPERAVAL :=AFind.OPERAVAL;
  Result.RIGHTVAL :=AFind.RIGHTVAL;
end;

end.

