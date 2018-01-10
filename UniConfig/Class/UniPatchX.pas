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
  TProcPatch = procedure();

  TOncePatch=class(TObject)
  public
    VersionNow: string;
    ConnctMark: string;
    ProcPatchA: TProcPatch;
  end;

  TListPatch=class(TStringList)
  public
    procedure AddPatch(aVersion, aConnctMark: string; aObject: TProcPatch);
  end;

  TUniPatchX=class(TUniEngine)
  private
    FTargetMark:string;
    FTargetTabl:string;
    FListPatch :TListPatch;
    FListConnct:TStringList;
  protected
    function  GetDataBaseVersion:Integer;
    procedure SetDataBaseVersion(aValue:Integer);

    function  ADD_TBL_DICT:string;
    function  ADD_PK_TBL_DICT:string;
    function  ADD_DICT_VERSION(aDictCode: string = '10001'): string;

    procedure Connect(aTargetMark:string);
    procedure Rollback;
    procedure CommitDB;
  protected
    procedure Execute10001;
  public
    function  Initialize(aTargetMark,aTargetTabl:string):Boolean;
    procedure Execute(aVersion:Integer);
  public
    procedure AddPatch(aVersion,aConnctMark:string;aObject:TProcPatch);
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


procedure TUniPatchX.AddPatch(aVersion, aConnctMark: string;
  aObject: TProcPatch);
begin
  FListPatch.AddPatch(aVersion,aConnctMark,aObject);
end;

function TUniPatchX.ADD_DICT_VERSION(aDictCode:string): string;
begin
  Result:='INSERT INTO %S (DICT_INDX,DICT_MODE,DICT_INFO,DICT_CODE,DICT_NAME,DICT_MEMO) VALUES (%D,%S,%S,%S,%S,%S)';
  Result:=Format(Result,[TargetTabl,1,QuotedStr(CONST_DATA_BASE_DICTMOD),QuotedStr('数据库版本号'),QuotedStr(aDictCode),QuotedStr(''),QuotedStr('')]);
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

procedure TUniPatchX.Connect(aTargetMark: string);
var
  cIndx:Integer;
  UniConnctA:TUniConnection;
begin
  cIndx:=FListConnct.IndexOf(aTargetMark);
  if cIndx=-1 then
  begin
    UniConnctA:=UniConnctEx.GetConnection(aTargetMark);
    UniConnctA.StartTransaction;
    FListConnct.AddObject(aTargetMark,UniConnctA);
    FUniConnct:=UniConnctA;
  end else
  begin
    FUniConnct:=TUniConnection(FListConnct.Objects[cIndx]);
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

procedure TUniPatchX.Execute(aVersion:Integer);
var
  I:Integer;
  SQLA :string;
  cIndx:Integer; //databaseversion=tbl_dict.code
  xIndx:Integer; //
  Patch:TOncePatch;
begin
  cIndx := GetDataBaseVersion;
  if cIndx=-1 then
  begin
    Connect(TargetMark);
    Execute10001;
    cIndx:=10001;
  end;



  //YXC_2012_11_21_10_24_05_不需要升级.
  if cIndx = aVersion then Exit;

  try
    try
      for I:=cIndx+1  to aVersion do
      begin
        xIndx:=-1;
        xIndx:=FListPatch.IndexOf(IntToStr(I));
        if xIndx<>-1 then
        begin
          Patch:=nil;
          Patch:=TOncePatch(FListPatch.Objects[xIndx]);
          if Patch=nil then Continue;

          Connect(Patch.ConnctMark);
          Patch.ProcPatchA();
        end;
      end;
    except
      on E:Exception do
      begin
        Rollback;
        raise Exception.CreateFmt('UPGRADE ERROR:%S:%S,%S',[Patch.VersionNow,Patch.ConnctMark,E.Message]);
      end;
    end;
  finally
    CommitDB;
  end;

  SetDataBaseVersion(aVersion);
end;

procedure TUniPatchX.Execute10001;
begin
  //nothing to do;the helper start at execute10002;
end;


function TUniPatchX.GetDataBaseVersion: Integer;
var
  cSQL :string;
  
  cUniD:TUniQuery;
  cUniC:TUniConnection;
begin
  Result:=-1;
  cUniD:=nil;

  cSQL  :='SELECT DICT_CODE FROM %S WHERE DICT_MODE=%S';
  cSQL  :=Format(cSQL,[TargetTabl,QuotedStr(CONST_DATA_BASE_DICTMOD)]);

  try
    cUniC:=UniConnctEx.GetConnection(TargetMark);
    if not ExistTable(TargetTabl,cUniC) then Exit;
    //->
    cUniD:=GetUniQuery(cSQL,cUniC);
    Result:=StrToIntDef(cUniD.FieldByName('DICT_CODE').AsString,-1);
    //-<
  finally
    FreeAndNil(cUniC);
    if cUniD<>nil then  FreeAndNil(cUniD);
  end;
end;

function  TUniPatchX.Initialize(aTargetMark,aTargetTabl:string):Boolean;
var
  I:Integer;
  cUniC:TUniConnection;
begin
  Result:=False;

  cUniC     :=nil;
  TargetMark:=aTargetMark;
  TargetTabl:=aTargetTabl;
  
  try
    cUniC:=UniConnctEx.GetConnection(TargetMark);
    if cUniC=nil then Exit;
    //->
    if not ExistTable(TargetTabl,cUniC) then
    begin
      ExecuteSQL(ADD_TBL_DICT,cUniC);
      //YXC_2013_02_06_14_39_33_sqllite不支持该语法.
      ExecuteSQL(ADD_PK_TBL_DICT,cUniC);
      ExecuteSQL(ADD_DICT_VERSION,cUniC);
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
    if cUniC<>nil then FreeAndNil(cUniC);
  end;

  Result:=True;         
end;

procedure TUniPatchX.Rollback;
var
  I:Integer;
  cUniC:TUniConnection;
begin
  for I:=0 to FListConnct.Count-1 do
  begin
    cUniC:=TUniConnection(FListConnct.Objects[I]);
    if cUniC<>nil then
    begin
      cUniC.Rollback;
    end;  
  end;  
end;

procedure TUniPatchX.SetDataBaseVersion(aValue: Integer);
var
  cSQL :string;
  cUniC:TUniConnection;
begin
  try
    cUniC:=UniConnctEx.GetConnection(TargetMark);
    if not ExistTable(TargetTabl,cUniC) then Exit;
    //->
    cSQL := 'SELECT COUNT(*) AS VALUE FROM %s WHERE DICT_MODE=%s';
    cSQL := Format(cSQL,[TargetTabl,QuotedStr(CONST_DATA_BASE_DICTMOD)]);

    if UniConnctEx.CheckField(cSQL,'VALUE',cUniC) > 0 then
    begin
      cSQL :='UPDATE %S SET DICT_CODE=%D WHERE DICT_MODE=%S';
      cSQL :=Format(cSQL,[TargetTabl,aValue,QuotedStr(CONST_DATA_BASE_DICTMOD)]);
    end else
    begin
      cSQL := ADD_DICT_VERSION(IntToStr(aValue))
    end;



    ExecuteSQL(cSQL,cUniC);
    //-<
  finally
    FreeAndNil(cUniC);
  end;
end;

procedure TListPatch.AddPatch(aVersion, aConnctMark: string;
  aObject: TProcPatch);
var
  OncePatch:TOncePatch;
begin
  OncePatch := TOncePatch.Create;
  OncePatch.VersionNow := aVersion;
  OncePatch.ConnctMark := aConnctMark;
  OncePatch.ProcPatchA := aObject;

  AddObject(OncePatch.VersionNow,OncePatch);
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
