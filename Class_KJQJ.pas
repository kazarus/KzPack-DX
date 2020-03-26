unit Class_KJQJ;
//YXC_2012_01_03_13_49_51
//会计期间
//等价于Class_XZHZ.TKJQJ

interface
uses
  Classes, SysUtils, DB, Uni, UniEngine, RzCmboBx;

type
  TKJQJ = class(TUniEngine)
  public
    FKJND: Integer;
    FKJQJ: Integer;
  public
    function  GetStrsIndex:string;override;  
  public
    procedure SetInitialize;
    procedure SetItemParams(aValue: Integer); overload;
    procedure SetItemParams(aKJND, aKJQJ: Integer); overload;
  public
    function  GetNextKJND:Integer;   //下一个会计年度
    function  GetNextKJQJ:Integer;   //下一个会计期间

    function  GetPrevKJND:Integer;   //上一个会计年度
    function  GetPrevKJQJ:Integer;   //上一个会计期间

    function  GetKJQJNEXT:Integer;   //#value=201701,result=201702
    function  GetKJQJHEAD:Integer;   //#value=201701,result=201612

    function  GetKJQJTEXT: string; overload;
    function  getKJNDTEXT: string; overload;

    procedure impKJNDKJQJ(aValue:integer);
    function  expKJNDKJQJ():Integer;
    
    function  GetKJNDKJQJ: Integer; overload;                  //取得整型期间
    function  GetKJNDKJQJ(aValue: Integer): Integer; overload; //取得整型期间
  published
    property KJND: Integer read FKJND write FKJND;
    property KJQJ: Integer read FKJQJ write FKJQJ;
    property KJNDKJQJ: Integer read expKJNDKJQJ write impKJNDKJQJ;
  public
    constructor Create;overload;
    constructor Create(aKJND,aKJQJ:Integer);overload;
    constructor Create(aValue:Integer);overload;
    destructor  Destroy; override;
  public
    class function  CopyIt(aKJQJ:TKJQJ):TKJQJ;overload;
    class procedure CopyIt(aKJQJ:TKJQJ;var Result:TKJQJ);overload;

    class function  ReadDS(AUniQuery:TUniQuery):TUniEngine;override;
    class procedure ReadDS(AUniQuery: TUniQuery;var Result:TUniEngine);override;    
    
    class function  ReadDB(ASQL:string;AUniConnection:TUniConnection):TKJQJ;overload;
    class procedure ReadDB(ASQL:string;AUniConnection:TUniConnection;var aKJQJ:TKJQJ);overload;
  public
    class function  GetKJQJTEXT(aValue: Integer): string; overload;
    class function  GetKJNDKJQJ(aKJND, aKJQJ: Integer): Integer; overload;

    class function  ExpListKJQJ(aStartKJQJ, aEndedKJQJ: TKJQJ): TStringList; overload; deprecated;
    class procedure ExpListKJQJ(aStartKJQJ, aEndedKJQJ: TKJQJ; var Result: TStringList); overload;
    class procedure ExpListKJQJ(aKJND, aStartKJQJ, aEndedKJQJ: Integer; var Result: TStringList); overload;
    class procedure ExpListKJQJ(aStartKJQJ: Integer; aEndedKJQJ: Integer; var Result: TStringList); overload;
  public
    class function  getSOURCEND(Sender: TRzComboBox): Integer;
    class function  getSOURCEQJ(Sender: TRzComboBox): Integer;
  end;

implementation

uses
  Class_KzUtils;

constructor TKJQJ.Create;
begin

end;

class function TKJQJ.CopyIt(aKJQJ: TKJQJ): TKJQJ;
begin
  Result:=TKJQJ.Create;
  TKJQJ.CopyIt(aKJQJ,Result);
end;

class procedure TKJQJ.CopyIt(aKJQJ: TKJQJ; var Result: TKJQJ);
begin
  if Result=nil then Exit;

  Result.KJND:=aKJQJ.KJND;
  Result.KJQJ:=aKJQJ.KJQJ;
end;

constructor TKJQJ.Create(aKJND, aKJQJ: Integer);
begin
  KJND:=aKJND;
  KJQJ:=aKJQJ;
end;

destructor TKJQJ.Destroy;
begin

  inherited;
end;

class function TKJQJ.ExpListKJQJ(aStartKJQJ, aEndedKJQJ: TKJQJ): TStringList;
var
  I:Integer;
  Count:Integer;
  KJQJA:TKJQJ;
  KJQJB:TKJQJ;
begin
  Result:=nil;

  Count:=-1;
  Count:=((aEndedKJQJ.KJND-aStartKJQJ.KJND)*12  + (aEndedKJQJ.KJQJ-aStartKJQJ.KJQJ))+1;
  if Count=-1 then Exit;

  Result:=TStringList.Create;

  try
    KJQJA :=TKJQJ.Create;

    for I:=1 to Count do
    begin
      if I=1 then
      begin
        KJQJB := TKJQJ.Create;
        KJQJB.KJND := aStartKJQJ.KJND;
        KJQJB.KJQJ := aStartKJQJ.KJQJ;

        //TempA:=IntToStr(TAppUtil.GetKjndKjqj(KJQJB.KJND,KJQJB.KJQJ));
        Result.AddObject(IntToStr(KJQJB.GetKJNDKJQJ), KJQJB);

        KJQJA.KJND := aStartKJQJ.KJND;
        KJQJA.KJQJ := aStartKJQJ.KJQJ;
      end else
      begin
        KJQJB := TKJQJ.Create;
        KJQJB.KJND := KJQJA.GetNextKJND;
        KJQJB.KJQJ := KJQJA.GetNextKJQJ;

        //TempA:=IntToStr(TAppUtil.GetKjndKjqj(KJQJB.KJND,KJQJB.KJQJ));
        Result.AddObject(IntToStr(KJQJB.GetKJNDKJQJ), KJQJB);

        KJQJA.KJND := KJQJB.KJND;
        KJQJA.KJQJ := KJQJB.KJQJ;
      end;
    end;  
  finally
    FreeAndNil(KJQJA);
  end;
end;

function TKJQJ.GetKJNDKJQJ: Integer;
begin
  Result := KJND * 100 + KJQJ;
  Result := Abs(Result);
end;

class function TKJQJ.GetKJNDKJQJ(aKJND, aKJQJ: Integer): Integer;
begin
  Result :=aKJND * 100 + aKJQJ;
end;

function TKJQJ.getKJNDTEXT: string;
begin
  Result:= Format('%D年',[self.KJND]);
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

class function TKJQJ.getSOURCEND(Sender: TRzComboBox): Integer;
var
  I: Integer;
  xKJQJ: TKJQJ;
begin
  Result := 0;
  if Sender = nil then Exit;
  if Sender.Items.Count = 0 then Exit;
  if Sender.ItemIndex = -1 then Exit;


  with Sender do
  begin
    xKJQJ := TKJQJ(Sender.Items.Objects[Sender.ItemIndex]);
    if xKJQJ = nil then Exit;

    Result := xKJQJ.KJND;
  end;
end;

class function TKJQJ.getSOURCEQJ(Sender: TRzComboBox): Integer;
var
  I: Integer;
  xKJQJ: TKJQJ;
begin
  Result := 0;
  if Sender = nil then Exit;
  if Sender.Items.Count = 0 then Exit;
  if Sender.ItemIndex = -1 then Exit;


  with Sender do
  begin
    xKJQJ := TKJQJ(Sender.Items.Objects[Sender.ItemIndex]);
    if xKJQJ = nil then Exit;

    Result := xKJQJ.KJQJ;
  end;
end;

function TKJQJ.GetStrsIndex: string;
begin
  Result:=Format('%D-%D',[KJND,KJQJ]);
end;

class function TKJQJ.ReadDS(AUniQuery: TUniQuery): TUniEngine;
begin
  Result := TKJQJ.Create;
  ReadDS(AUniQuery,Result);
end;

procedure TKJQJ.SetInitialize;
begin
  KJND:=-1;
  KJQJ:=-1;  
end;

procedure TKJQJ.SetItemParams(aKJND, aKJQJ: Integer);
begin
  KJND:=aKJND;
  KJQJ:=aKJQJ;
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

constructor TKJQJ.Create(aValue: Integer);
begin
  KJND := Trunc(aValue / 100);
  KJQJ := aValue  mod 100;
end;

function TKJQJ.GetKJNDKJQJ(aValue: Integer): Integer;
var
  I,M:Integer;
  NDT:Integer;
  QJT:Integer;
begin
  I  :=Abs(aValue);
  NDT:=KJND;
  QJT:=KJQJ;

  if aValue > 0 then
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
  if aValue < 0 then  
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

class function TKJQJ.GetKJQJTEXT(aValue: Integer): string;
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

function TKJQJ.GetKJQJTEXT: string;
begin
  Result:= Format('%D年%D月',[self.KJND,self.KJQJ]);
end;

class procedure TKJQJ.ExpListKJQJ(aKJND, aStartKJQJ, aEndedKJQJ: Integer;
  var Result: TStringList);
var
  I:Integer;
  cKJQJ:TKJQJ;  
begin
  for I:=aStartKJQJ to aEndedKJQJ do
  begin
    cKJQJ := TKJQJ.Create(aKJND,I);
    Result.AddObject(cKJQJ.GetKJQJTEXT,cKJQJ);
  end;
end;

class procedure TKJQJ.ReadDB(ASQL: string; AUniConnection: TUniConnection;
  var aKJQJ: TKJQJ);
var
  Value:Integer;
  UniDataSet:TUniQuery;
begin
  //the sql format shoule be follow this:select xx as value from xx;
  if aKJQJ = nil then Exit;
  
  try
    UniDataSet:=GetDataSet(ASQL,AUniConnection);
    Value     :=UniDataSet.FieldByName('VALUE').AsInteger;
  finally
    FreeAndNil(UniDataSet);
  end;

  if (Value=0) or (Value=-1) then Exit;

  aKJQJ.KJND:=Trunc(Value / 100);
  aKJQJ.KJQJ:=Value mod 100;
end;

function TKJQJ.GetKJQJHEAD: Integer;
begin
  Result := (GetPrevKJND * 100) + GetPrevKJQJ;
end;

function TKJQJ.GetKJQJNEXT: Integer;
begin
  Result := (GetNextKJND * 100) + GetNextKJQJ;
end;

procedure TKJQJ.SetItemParams(aValue: Integer);
begin
  KJND := Trunc(aValue / 100);
  KJQJ := aValue  mod 100;
end;

class procedure TKJQJ.ExpListKJQJ(aStartKJQJ, aEndedKJQJ: TKJQJ;
  var Result: TStringList);
var
  I:Integer;
  Count:Integer;
  KJQJA:TKJQJ;
  KJQJB:TKJQJ;
begin
  if Result = nil then Exit;

  Count:=-1;
  Count:=((aEndedKJQJ.KJND-aStartKJQJ.KJND)*12  + (aEndedKJQJ.KJQJ-aStartKJQJ.KJQJ))+1;
  if Count=-1 then Exit;

  try
    KJQJA :=TKJQJ.Create;

    for I:=1 to Count do
    begin
      if I=1 then
      begin
        KJQJB := TKJQJ.Create;
        KJQJB.KJND := aStartKJQJ.KJND;
        KJQJB.KJQJ := aStartKJQJ.KJQJ;

        //TempA:=IntToStr(TAppUtil.GetKjndKjqj(KJQJB.KJND,KJQJB.KJQJ));
        Result.AddObject(IntToStr(KJQJB.GetKJNDKJQJ), KJQJB);

        KJQJA.KJND := aStartKJQJ.KJND;
        KJQJA.KJQJ := aStartKJQJ.KJQJ;
      end else
      begin
        KJQJB := TKJQJ.Create;
        KJQJB.KJND := KJQJA.GetNextKJND;
        KJQJB.KJQJ := KJQJA.GetNextKJQJ;

        //TempA:=IntToStr(TAppUtil.GetKjndKjqj(KJQJB.KJND,KJQJB.KJQJ));
        Result.AddObject(IntToStr(KJQJB.GetKJNDKJQJ), KJQJB);

        KJQJA.KJND := KJQJB.KJND;
        KJQJA.KJQJ := KJQJB.KJQJ;
      end;
    end;  
  finally
    FreeAndNil(KJQJA);
  end;
end;

class procedure TKJQJ.ReadDS(AUniQuery: TUniQuery; var Result: TUniEngine);
var
  I:Integer;
  Field:TField;
  Value:Integer;
begin
  if Result = nil then Exit;

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

procedure TKJQJ.impKJNDKJQJ(aValue: integer);
begin

end;

function TKJQJ.expKJNDKJQJ:Integer;
begin
  Result := GetKJNDKJQJ; 
end;

class procedure TKJQJ.ExpListKJQJ(aStartKJQJ, aEndedKJQJ: Integer; var Result: TStringList);
var
  sKJQJ:TKJQJ;
  eKJQJ:TKJQJ;
begin
  try
    sKJQJ := TKJQJ.Create(aStartKJQJ);
    eKJQJ := TKJQJ.Create(aEndedKJQJ);

    ExpListKJQJ(sKJQJ,eKJQJ,Result);

  finally
    FreeAndNil(sKJQJ);
    FreeAndNil(eKJQJ);
  end;
end;

end.

