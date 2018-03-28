unit UniTableX;


interface
uses
  Classes,SysUtils,DB,Uni,UniEngine;

type
  TUniTableX=class(TUniEngine)
  private
    FTABLNAME : string;
    FPRIORITY : Integer;
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
    property TABLNAME : string read FTABLNAME  write FTABLNAME;
    property PRIORITY : Integer read FPRIORITY  write FPRIORITY;
  public
    class function  ReadDS(aUniQuery:TUniQuery):TUniEngine;override;
    class procedure ReadDS(aUniQuery:TUniQuery;var Result:TUniEngine);override;

    class function  CopyIt(aUNITABLEX:TUniTableX):TUniTableX;overload;
    class procedure CopyIt(aUNITABLEX:TUniTableX;var Result:TUniTableX);overload;

    class function  CopyIt(aUniEngine:TUniEngine):TUniEngine;overload;override;
    class procedure CopyIt(aUniEngine:TUniEngine;var Result:TUniEngine)overload;override;
  public
    class function  ExpSQL_SQLSRV:string;
  end;

implementation


procedure TUniTableX.SetParameters;
begin
  inherited;
  with FUniSQL.Params do
  begin
    case FOptTyp of
      otAddx:
      begin
        ParamByName('TABLNAME').Value := TABLNAME;
        ParamByName('PRIORITY').Value := PRIORITY;
      end;
      otEdit:
      begin
        ParamByName('TABLNAME').Value := TABLNAME;
        ParamByName('PRIORITY').Value := PRIORITY;
      end;
      otDelt:
      begin
        ParamByName('TABLNAME').Value := TABLNAME;

      end;
    end;
  end;
end;

function TUniTableX.CheckExist(aUniConnection: TUniConnection): Boolean;
begin
  Result := CheckExist('TBL_UNITABLEX',['TABLNAME',TABLNAME],AUniConnection);
end;

function TUniTableX.GetStrDelete: string;
begin
  Result:='DELETE FROM TBL_UNITABLEX WHERE   TABLNAME=:TABLNAME';
end;

function TUniTableX.GetStrInsert: string;
begin
  Result:='INSERT INTO TBL_UNITABLEX'
         +'    ( TABLNAME, PRIORITY)'
         +'    VALUES'
         +'    (:TABLNAME,:PRIORITY)';
end;

function TUniTableX.GetStrsIndex: string;
begin
  Result:=Format('%S',[TABLNAME]);
end;

function TUniTableX.GetStrUpdate: string;
begin
  Result:='UPDATE  TBL_UNITABLEX SET'
         +'    PRIORITY=:PRIORITY'
         +'    WHERE TABLNAME=:TABLNAME';
end;

constructor TUniTableX.Create;
begin

end;

destructor TUniTableX.Destroy;
begin

  inherited;
end;

class function TUniTableX.ExpSQL_SQLSRV: string;
begin
  Result:='SELECT OBJECT_NAME(D.RKEYID) AS TABLNAME ,COUNT(*) AS PRIORITY FROM'
         +'    (SELECT CONSTID,FKEYID,RKEYID FROM SYSFOREIGNKEYS'
         +'    GROUP BY CONSTID,FKEYID,RKEYID) AS D'
         +'    GROUP BY D.RKEYID';
end;

class function TUniTableX.ReadDS(aUniQuery: TUniQuery): TUniEngine;
begin
  Result := TUniTableX.Create;
  TUniTableX.ReadDS(AUniQuery,Result);
end;

class procedure TUniTableX.ReadDS(aUniQuery: TUniQuery; var Result: TUniEngine);
var
  I:Integer;
  Field:TField;
  FieldName:string;
begin
  if Result = nil then Exit;

  with TUniTableX(Result) do
  begin
    for I:=0 to aUniQuery.Fields.Count-1 do
    begin
      Field := aUniQuery.Fields.Fields[I];
      //if field.fieldname is not all uppercase,please use uppercase().
      FieldName := UpperCase(Field.FieldName);
      if FieldName = 'TABLNAME' then
      begin
        TABLNAME  := Field.AsString;
      end else
      if FieldName = 'PRIORITY' then
      begin
        PRIORITY  := Field.AsInteger;
      end;
    end
  end;
end;

class function  TUniTableX.CopyIt(aUNITABLEX: TUniTableX): TUniTableX;
begin
  Result := TUniTableX.Create;
  TUniTableX.CopyIt(aUNITABLEX,Result)
end;

class procedure TUniTableX.CopyIt(aUNITABLEX:TUniTableX;var Result:TUniTableX);
begin
  if Result = nil then Exit;
  Result.TABLNAME := aUNITABLEX.TABLNAME;
  Result.PRIORITY := aUNITABLEX.PRIORITY;
end;

class function TUniTableX.CopyIt(aUniEngine: TUniEngine): TUniEngine;
begin
  Result := TUniTableX.Create;
  TUniEngine.CopyIt(aUniEngine,Result);
end;

class procedure TUniTableX.CopyIt(aUniEngine: TUniEngine; var Result: TUniEngine);
begin
  if Result = nil then Exit;
  TUniTableX.CopyIt(TUniTableX(aUniEngine),TUniTableX(Result));
end;

end.
