unit Class_KJQJ;
//YXC_2012_01_03_13_49_51
//会计期间
//等价于Class_XZHZ.TKJQJ

interface
uses
  Classes,SysUtils,DB,Uni,UniEngine;

type
  TKJQJ=class(TUniEngine)
  public
    KJND:Integer;
    KJQJ:Integer;
  public
    function GetStrsIndex:string;override;  
  public
    procedure SetInitialize;
    procedure SetItemParams(AKJND,AKJQJ:Integer);

    function  GetNextKJND:Integer;   //下一个会计年度
    function  GetNextKJQJ:Integer;   //下一个会计期间

    function  GetPrevKJND:Integer;   //上一个会计年度
    function  GetPrevKJQJ:Integer;   //上一个会计期间

    function  GetKJNDKJQJ:Integer;overload;                 //取得整型期间
    function  GetKJNDKJQJ(AValue:Integer):Integer;overload; //取得整型期间
    function  GetNameKJQJ:string;overload;
  public
    constructor Create;overload;
    constructor Create(AKJND,AKJQJ:Integer);overload;
    constructor Create(AValue:Integer);overload;
    destructor  Destroy; override;
  public
    class function  CopyIt(AKJQJ:TKJQJ):TKJQJ;overload;
    class procedure CopyIt(AKJQJ:TKJQJ;var Result:TKJQJ);overload;

    class function  ReadDS(AUniQuery:TUniQuery):TUniEngine;override;
    class function  ReadDB(ASQL:string;AUniConnection:TUniConnection):TKJQJ;   
  public
    class function  ExpListKJQJ(AStaKJQJ,AEndKJQJ:TKJQJ):TStringList;
    class function  GetKJNDKJQJ(AKJND,AKJQJ:Integer):Integer;overload;

    class function  GetNameKJQJ(aValue:Integer):string;overload;
  end;

implementation

uses
  Class_KzUtils;

{ TKJQJ }

constructor TKJQJ.Create;
begin

end;

class function TKJQJ.CopyIt(AKJQJ: TKJQJ): TKJQJ;
begin
  Result:=TKJQJ.Create;
  TKJQJ.CopyIt(AKJQJ,Result);
end;

class procedure TKJQJ.CopyIt(AKJQJ: TKJQJ; var Result: TKJQJ);
begin
  if Result=nil then Exit;

  Result.KJND:=AKJQJ.KJND;
  Result.KJQJ:=AKJQJ.KJQJ;
end;

constructor TKJQJ.Create(AKJND, AKJQJ: Integer);
begin
  KJND:=AKJND;
  KJQJ:=AKJQJ;
end;

destructor TKJQJ.Destroy;
begin

  inherited;
end;

class function TKJQJ.ExpListKJQJ(AStaKJQJ, AEndKJQJ: TKJQJ): TStringList;
var
  I:Integer;
  NumbA:Integer;
  KJQJA:TKJQJ;
  KJQJB:TKJQJ;
begin
  Result:=nil;

  NumbA:=-1;
  NumbA:=((AEndKJQJ.KJND-AStaKJQJ.KJND)*12  + (AEndKJQJ.KJQJ-AStaKJQJ.KJQJ))+1;
  if NumbA=-1 then Exit;

  Result:=TStringList.Create;
  KJQJA :=TKJQJ.Create;
  
  for I:=1 to NumbA do
  begin
    if I=1 then
    begin
      KJQJB:=TKJQJ.Create;
      KJQJB.KJND:=AStaKJQJ.KJND;
      KJQJB.KJQJ:=AStaKJQJ.KJQJ;

      //TempA:=IntToStr(TAppUtil.GetKjndKjqj(KJQJB.KJND,KJQJB.KJQJ));
      Result.AddObject(IntToStr(KJQJB.GetKJNDKJQJ),KJQJB);

      KJQJA.KJND:=AStaKJQJ.KJND;
      KJQJA.KJQJ:=AStaKJQJ.KJQJ;
    end else
    begin
      KJQJB:=TKJQJ.Create;
      KJQJB.KJND:=KJQJA.GetNextKJND;
      KJQJB.KJQJ:=KJQJA.GetNextKJQJ;

      //TempA:=IntToStr(TAppUtil.GetKjndKjqj(KJQJB.KJND,KJQJB.KJQJ));
      Result.AddObject(IntToStr(KJQJB.GetKJNDKJQJ),KJQJB);

      KJQJA.KJND:=KJQJB.KJND;
      KJQJA.KJQJ:=KJQJB.KJQJ;
    end;
  end;

  FreeAndNil(KJQJA);
end;

function TKJQJ.GetKJNDKJQJ: Integer;
begin
  Result := KJND * 100 + KJQJ;
  Result := Abs(Result);
end;

class function TKJQJ.GetKJNDKJQJ(AKJND, AKJQJ: Integer): Integer;
var
  TempA:string;
begin
  TempA :='';
  TempA :=Format('%D%S',[AKJND,TKzUtils.FormatCode(AKJQJ,2)]);
  Result:=StrToInt(TempA);
end;

function TKJQJ.GetNextKJND: Integer;
begin
  Result:=KJND;

  if KJQJ=12 then
  begin
    Result:=KJND + 1;
  end;
end;

function TKJQJ.GetNextKJQJ: Integer;
begin
  Result:=KJQJ + 1;
  if Result=13 then
  begin
    Result:=1;
  end;
end;

function TKJQJ.GetPrevKJND: Integer;
begin
  Result:=KJND;

  if KJQJ = 1 then
  begin
    Result:=Result -1 ;
  end;
end;

function TKJQJ.GetPrevKJQJ: Integer;
begin
  Result:=KJQJ - 1 ;

  if Result =0 then
  begin
    Result:=12;
  end;
end;

function TKJQJ.GetStrsIndex: string;
begin
  Result:=Format('%D-%D',[KJND,KJQJ]);
end;

class function TKJQJ.ReadDS(AUniQuery: TUniQuery): TUniEngine;
var
  I:Integer;
  Field:TField;
  Value:Integer;
begin
  Result:=TKJQJ.Create;
  with TKJQJ(Result) do
  begin
    for I:=0 to AUniQuery.Fields.Count-1 do
    begin
      Field:=AUniQuery.Fields.Fields[I];
      if Field.FieldName = 'KJND' then
      begin
        KJND := Field.AsInteger;
      end else
      if Field.FieldName = 'KJQJ' then 
      begin
        KJQJ := Field.AsInteger;
      end else
      if Field.FieldName = 'KJND_KJQJ' then 
      begin
        Value := Field.AsInteger;
        KJND  := Trunc(Value / 100);
        KJQJ  := Value  mod 100;
      end;
    end;
  end;
end;

procedure TKJQJ.SetInitialize;
begin
  KJND:=-1;
  KJQJ:=-1;  
end;

procedure TKJQJ.SetItemParams(AKJND, AKJQJ: Integer);
begin
  KJND:=AKJND;
  KJQJ:=AKJQJ;
end;

class function TKJQJ.ReadDB(ASQL: string;
  AUniConnection: TUniConnection): TKJQJ;
var
  Value:Integer;
  UniDataSet:TUniQuery;
begin
  //the sql format shoule be follow this:select xx as value from xx;
  Result:=nil;
  try
    UniDataSet:=GetDataSet(ASQL,AUniConnection);
    Value     :=UniDataSet.FieldByName('VALUE').AsInteger;
  finally
    FreeAndNil(UniDataSet);
  end;

  if (Value=0) or (Value=-1) then Exit;

  Result:=TKJQJ.Create;
  Result.KJND:=Trunc(Value / 100);
  Result.KJQJ:=Value mod 100;
end;

constructor TKJQJ.Create(AValue: Integer);
begin
  KJND := Trunc(AValue / 100);
  KJQJ := AValue  mod 100;
end;

function TKJQJ.GetKJNDKJQJ(AValue: Integer): Integer;
var
  I,M:Integer;
  NDT:Integer;
  QJT:Integer;
begin
  I  :=Abs(AValue);
  NDT:=KJND;
  QJT:=KJQJ;

  if AValue > 0 then
  begin
    while I > 0 do
    begin
      QJT:=QJT + 1;
      if QJT=13 then
      begin
        QJT :=1;
        Inc(NDT);
      end;
      Dec(I);
    end;
  end else
  if AValue < 0 then  
  begin
    while I > 0 do
    begin
      QJT:=QJT  - 1;
      if QJT =0 then
      begin
        QJT:=12;
        Dec(NDT);
      end;
      Dec(I);
    end;
  end;

  Result:=NDT * 100 + QJT;
end;

class function TKJQJ.GetNameKJQJ(aValue: Integer): string;
var
  cKJQJ:TKJQJ;
begin
  Result := '';
  try
    cKJQJ := TKJQJ.Create(aValue);

    Result:= Format('%D年%D月',[cKJQJ.KJND,cKJQJ.KJQJ]);
  finally
    FreeAndNil(cKJQJ);
  end;
end;

function TKJQJ.GetNameKJQJ: string;
begin
  Result:= Format('%D年%D月',[self.KJND,self.KJQJ]);
end;

end.
