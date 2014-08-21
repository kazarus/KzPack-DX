unit Class_SQLX;

interface
uses
  Classes,SysUtils,Uni,UniEngine;

type
  TSQLX=class(TUniEngine)
  public
    SQLXIDEX: Integer;
    SQLXDATE: TDateTime;
    SQLXTEXT: string;
  protected
    procedure SetParameters;override;
    function  GetStrInsert:string;override;
    function  GetStrUpdate:string;override;
    function  GetStrDelete:string;override;
  public
    function  GetStrsIndex:string;override;
  public
    function  GetNextIdex:Integer;overload;
    function  GetNextIdex(AUniConnection:TUniConnection):Integer;overload;
  public
    function  CheckExist(AUniConnection:TUniConnection):Boolean;override;
  public
    class function  ReadDS(AUniQuery:TUniQuery):TUniEngine;override;
    class function  CopyIt(ASQLX:TSQLX):TSQLX;overload;        
    class procedure CopyIt(ASQLX:TSQLX;var Result:TSQLX);overload;

  public
    class function  ADD_TBL_UNISQLX:string;      
  end;

implementation

{ TSQLX }
procedure TSQLX.SetParameters;
begin
  inherited;
  with FUniSQL.Params do
  begin
    case FOptTyp of
      otAddx:
      begin
        ParamByName('SQLX_IDEX').Value := SQLXIDEX;
        ParamByName('SQLX_DATE').Value := SQLXDATE;
        ParamByName('SQLX_TEXT').Value := SQLXTEXT; 
      end;
      otEdit:
      begin
        ParamByName('SQLX_IDEX').Value := SQLXIDEX;
        ParamByName('SQLX_DATE').Value := SQLXDATE;
        ParamByName('SQLX_TEXT').Value := SQLXTEXT; 
      end;  
      otDelt:
      begin
        ParamByName('SQLX_IDEX').Value := SQLXIDEX;
 
      end;  
    end;
  end;
end;

function TSQLX.CheckExist(AUniConnection: TUniConnection): Boolean;
begin
  Result:=CheckExist('TBL_UNISQLX',['SQLX_TEXT',SQLXTEXT],AUniConnection);
end;

function TSQLX.GetNextIdex: Integer;
begin

end;

function TSQLX.GetNextIdex(AUniConnection: TUniConnection): Integer;
begin
  Result:=CheckField('SQLX_IDEX','TBL_UNISQLX',[],AUniConnection);
end;

function TSQLX.GetStrDelete: string;
begin
  Result:='DELETE FROM TBL_UNISQLX WHERE   SQLX_IDEX=:SQLX_IDEX';
end;

function TSQLX.GetStrInsert: string;
begin
  Result:='INSERT INTO TBL_UNISQLX (SQLX_IDEX,SQLX_DATE,SQLX_TEXT) VALUES (:SQLX_IDEX,:SQLX_DATE,:SQLX_TEXT)';
end;

function TSQLX.GetStrsIndex: string;
begin
  Result:=Format('%D',[SqlxIdex]);
end;

function TSQLX.GetStrUpdate: string;
begin
  Result:='UPDATE  TBL_UNISQLX SET'
         +'    SQLX_DATE=:SQLX_DATE,'
         +'    SQLX_TEXT=:SQLX_TEXT'
         +'    WHERE SQLX_IDEX=:SQLX_IDEX';
end;

class function TSQLX.ReadDS(AUniQuery: TUniQuery): TUniEngine;
begin
  Result:=TSQLX.Create;
  with TSQLX(Result) do
  begin
    SQLXIDEX:=AUniQuery.FieldByName('SQLX_IDEX').AsInteger;
    SQLXDATE:=AUniQuery.FieldByName('SQLX_DATE').AsDateTime;
    SQLXTEXT:=AUniQuery.FieldByName('SQLX_TEXT').AsString;
  end;  
end;

class function  TSQLX.CopyIt(ASQLX: TSQLX): TSQLX;
begin
  Result:=TSQLX.Create;
  Result.SQLXIDEX:=ASQLX.SQLXIDEX;
  Result.SQLXDATE:=ASQLX.SQLXDATE;
  Result.SQLXTEXT:=ASQLX.SQLXTEXT;
end;

class procedure TSQLX.CopyIt(ASQLX:TSQLX;var Result:TSQLX);
begin
  if Result=nil then Exit;
  Result.SQLXIDEX:=ASQLX.SQLXIDEX;
  Result.SQLXDATE:=ASQLX.SQLXDATE;
  Result.SQLXTEXT:=ASQLX.SQLXTEXT;
end;

class function TSQLX.ADD_TBL_UNISQLX: string;
begin
  Result:='CREATE TABLE TBL_UNISQLX ('
         +'    SQLX_IDEX INT      PRIMARY KEY'
         +'    NOT NULL,'
         +'    SQLX_DATE DATETIME,'
         +'    SQLX_TEXT TEXT'
         +');';
end;

end.

