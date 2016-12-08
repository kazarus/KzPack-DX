unit UniPatchX;
//YXC_2014_03_14_22_06_36_rename:class:tstrspatch->tlistpatch
//YXC_2014_03_14_22_07_32_rename:variable:strsconnct->listconnct
//YXC_2014_03_14_22_09_12_rename:class:tunipatchx->tunipatchx.uppercase(x).
//YXC_2014_03_14_22_30_52_add:commitdb,rollback.
//YXC_2014_03_14_22_42_32_remember:when database is sqllite.it is need connected:=false.
//YXC_2014_06_23_17_00_54_rename:tonexpatch->toncepatch


interface
uses
  Classes,SysUtils,Uni,UniEngine,UniConnct;

type
  TProcPatch=procedure();

  TOncePatch=class(TObject)
  public
    VersionMod:string;
    ConnctMark:string;
    ProcPatchA:TProcPatch;
  end;

  TListPatch=class(TStringList)
  public
    procedure AddPatch(AVersion,AConnctMark:string;AObject:TProcPatch);
  end;

  TUniPatchX=class(TUniEngine)
  private
    FTargetMark:string;
    FTargetTabl:string;
    FListPatch :TListPatch;
    FListConnct:TStringList;
  protected
    function  GetDataBaseVersion:Integer;
    procedure SetDataBaseVersion(AValue:Integer);

    function  ADD_TBL_DICT:string;
    function  ADD_PK_TBL_DICT:string;
    function  ADD_DICT_VERSION:string;

    procedure Connect(ATargetMark:string);
    procedure Rollback;
    procedure CommitDB;
  protected
    procedure Execute10001;
  public
    function  Initialize(ATargetMark,ATargetTabl:string):Boolean;
    procedure Execute(AVersion:Integer);
  public
    procedure AddPatch(AVersion,AConnctMark:string;AObject:TProcPatch);
  public
    destructor Destroy; override;
    constructor Create;
  published
    property TargetMark:string  read FTargetMark write FTargetMark;
    property TargetTabl:string  read FTargetTabl write FTargetTabl;
  end;

const
  CONST_DATA_BASE_DICTMOD:string ='00001';

var
  UniPatchxEx:TUniPatchX;
  FUniConnct :TUniConnection;

implementation

uses
  Class_Dict,Class_SQLX;


procedure TUniPatchX.AddPatch(AVersion, AConnctMark: string;
  AObject: TProcPatch);
begin
  FListPatch.AddPatch(AVersion,AConnctMark,AObject);
end;

function TUniPatchX.ADD_DICT_VERSION: string;
begin
  Result:='INSERT INTO %S (DICT_INDX,DICT_MODE,DICT_INFO,DICT_CODE,DICT_NAME,DICT_MEMO) VALUES (%D,%S,%S,%S,%S,%S)';
  Result:=Format(Result,[TargetTabl,1,QuotedStr(CONST_DATA_BASE_DICTMOD),QuotedStr('数据库版本号'),QuotedStr('10001'),QuotedStr(''),QuotedStr('')]);
end;

function TUniPatchX.ADD_PK_TBL_DICT: string;
begin
  Result:='ALTER TABLE %S ADD CONSTRAINT PK_%S PRIMARY KEY (DICT_INDX)';
  Result:=Format(Result,[TargetTabl,TargetTabl]);
end;

function TUniPatchX.ADD_TBL_DICT: string;
begin
  Result:='CREATE TABLE %S'
         +'('
         +'    DICT_INDX INT NOT NULL,'
         +'    DICT_MODE VARCHAR(10),'
         +'    DICT_INFO VARCHAR(100),'
         +'    DICT_CODE VARCHAR(200),'
         +'    DICT_NAME VARCHAR(200),'
         +'    DICT_MEMO VARCHAR(200)'
         +')';
         
  Result:=Format(Result,[TargetTabl]);       
end;

procedure TUniPatchX.CommitDB;
var
  I:Integer;
  UniConnct:TUniConnection;
begin
  for I:=0 to FListConnct.Count-1 do
  begin
    UniConnct:=TUniConnection(FListConnct.Objects[I]);
    if UniConnct<>nil then
    begin
      UniConnct.Commit;
      UniConnct.Disconnect;
    end;
  end;
end;

procedure TUniPatchX.Connect(ATargetMark: string);
var
  IDXA:Integer;
  UniConnctA:TUniConnection;
begin
  IDXA:=FListConnct.IndexOf(ATargetMark);
  if IDXA=-1 then
  begin
    UniConnctA:=UniConnctEx.GetConnection(ATargetMark);
    UniConnctA.StartTransaction;
    FListConnct.AddObject(ATargetMark,UniConnctA);
    FUniConnct:=UniConnctA;
  end else
  begin
    FUniConnct:=TUniConnection(FListConnct.Objects[IDXA]);
  end;
end;

constructor TUniPatchX.Create;
begin
  FListPatch :=TListPatch.Create;
  FListConnct:=TStringList.Create;
end;

destructor TUniPatchX.Destroy;
var
  I:Integer;
  UniConnctA:TUniConnection;
begin
  for I:=0 to FListPatch.Count-1 do
  begin
    FListPatch.Objects[I].Free;
    FListPatch.Objects[I]:=nil;
  end;
  FreeAndNil(FListPatch);

  for I:=0 to FListConnct.Count-1 do
  begin
    //YXC_2013_02_25_15_18_40_keep a version
    {#UniConnctA:=TUniConnection(ListConnct.Objects[I]);
    if UniConnctA<>nil then
    begin
      if UniConnctA.Connected then UniConnctA.Connected:=False;
    end;}
    FListConnct.Objects[I].Free;
    FListConnct.Objects[I]:=nil;
  end;
  FreeAndNil(FListConnct);
  
  inherited;
end;

procedure TUniPatchX.Execute(AVersion:Integer);
var
  I:Integer;
  SQLA :string;
  IDXA:Integer; //databaseversion=tbl_dict.code
  IDXB:Integer; //
  PatchA:TOncePatch;
begin
  IDXA:=GetDataBaseVersion;
  if IDXA=-1 then
  begin
    Connect(TargetMark);
    Execute10001;
    IDXA:=10001;
  end;



  //YXC_2012_11_21_10_24_05_不需要升级.
  if IDXA = AVersion then Exit;

  try
    try
      for I:=IDXA+1  to AVersion do
      begin
        IDXB:=-1;
        IDXB:=FListPatch.IndexOf(IntToStr(I));
        if IDXB<>-1 then
        begin
          PatchA:=nil;
          PatchA:=TOncePatch(FListPatch.Objects[IDXB]);
          if PatchA=nil then Continue;

          Connect(PatchA.ConnctMark);
          PatchA.ProcPatchA();
        end;
      end;
    except
      on E:Exception do
      begin
        Rollback;
        raise Exception.CreateFmt('UPGRADE ERROR:%S:%S,%S',[PatchA.VersionMod,PatchA.ConnctMark,E.Message]);
      end;
    end;
  finally
    CommitDB;
  end;
  SetDataBaseVersion(AVersion);
end;

procedure TUniPatchX.Execute10001;
begin
  //nothing to do;the helper start at execute10002;
end;


function TUniPatchX.GetDataBaseVersion: Integer;
var
  SQLA :string;
  
  UniQueryA:TUniQuery;
  UniConnct:TUniConnection;
begin
  Result:=-1;
  UniQueryA:=nil;  

  SQLA  :='SELECT DICT_CODE FROM %S WHERE DICT_MODE=%S';
  SQLA  :=Format(SQLA,[TargetTabl,QuotedStr(CONST_DATA_BASE_DICTMOD)]);

  try
    UniConnct:=UniConnctEx.GetConnection(TargetMark);
    if not ExistTable(TargetTabl,UniConnct) then Exit;      
    //->
    UniQueryA:=GetUniQuery(SQLA,UniConnct);
    Result:=StrToIntDef(UniQueryA.FieldByName('DICT_CODE').AsString,-1);
    //-<
  finally
    FreeAndNil(UniConnct);
    if UniQueryA<>nil then  FreeAndNil(UniQueryA);
  end;
end;

function  TUniPatchX.Initialize(ATargetMark,ATargetTabl:string):Boolean;
var
  I:Integer;
  UniConnct:TUniConnection;
begin
  Result:=False;

  UniConnct :=nil;
  TargetMark:=ATargetMark;
  TargetTabl:=ATargetTabl;
  
  try
    UniConnct:=UniConnctEx.GetConnection(TargetMark);
    if UniConnct=nil then Exit;
    //->
    if not ExistTable(TargetTabl,UniConnct) then
    begin
      ExecuteSQL(ADD_TBL_DICT,UniConnct);
      //YXC_2013_02_06_14_39_33_sqllite不支持该语法.
      ExecuteSQL(ADD_PK_TBL_DICT,UniConnct);
      ExecuteSQL(ADD_DICT_VERSION,UniConnct);      
    end;
    //-<

    if FListConnct<>nil then
    begin
      for I:=0 to FListConnct.Count-1 do
      begin
        FListConnct.Objects[I].Free;
        FListConnct.Objects[I]:=nil;
      end;
      FreeAndNil(FListConnct);
    end;
    FListConnct:=TStringList.Create;
  finally
    if UniConnct<>nil then FreeAndNil(UniConnct);
  end;

  Result:=True;         
end;

procedure TUniPatchX.Rollback;
var
  I:Integer;
  UniConnct:TUniConnection;
begin
  for I:=0 to FListConnct.Count-1 do
  begin
    UniConnct:=TUniConnection(FListConnct.Objects[I]);
    if UniConnct<>nil then
    begin
      UniConnct.Rollback;
    end;  
  end;  
end;

procedure TUniPatchX.SetDataBaseVersion(AValue: Integer);
var
  SQLA :string;
  UniConnct:TUniConnection;
begin
  SQLA  :='UPDATE %S SET DICT_CODE=%D WHERE DICT_MODE=%S';
  SQLA  :=Format(SQLA,[TargetTabl,AValue,QuotedStr(CONST_DATA_BASE_DICTMOD)]);

  try
    UniConnct:=UniConnctEx.GetConnection(TargetMark);
    if not ExistTable(TargetTabl,UniConnct) then Exit;      
    //->
    ExecuteSQL(SQLA,UniConnct);
    //-<
  finally
    FreeAndNil(UniConnct);
  end;
end;

{ TListPatch }

procedure TListPatch.AddPatch(AVersion, AConnctMark: string;
  AObject: TProcPatch);
var
  OncePatchA:TOncePatch;
begin
  OncePatchA:=TOncePatch.Create;
  OncePatchA.VersionMod:=AVersion;  
  OncePatchA.ConnctMark:=AConnctMark;
  OncePatchA.ProcPatchA:=AObject;

  AddObject(OncePatchA.VersionMod,OncePatchA);
end;

initialization
begin
  UniPatchxEx:=TUniPatchX.Create;
end;

finalization
begin
  if UniPatchxEx<>nil then FreeAndNil(UniPatchxEx);
end;

end.
