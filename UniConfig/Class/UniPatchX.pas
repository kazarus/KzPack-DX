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
    TargetMark:string;
    TargetTabl:string;    
    ListPatch :TListPatch;
    ListConnct:TStringList;
  protected
    function  GetDataBaseVersion:Integer;
    procedure SetDataBaseVersion(AValue:Integer);

    function  ADD_TBL_DICT:string;
    function  ADD_PK_TBL_DICT:string;
    function  ADD_DICT_VERSION:string;

    procedure Connect(ATargetMark:string);
    procedure Rollback;
    procedure CommitDB;    
  public
    function  Initialize(ATargetMark,ATargetTabl:string):Boolean;
    procedure Execute;
  public
    procedure Execute10001();
    procedure Execute10002();
    procedure Execute10003();
    procedure Execute10004();
    procedure Execute10005();
    procedure Execute10006();
    procedure Execute10007();
    procedure Execute10008();
    procedure Execute10009();
    procedure Execute10010();
    procedure Execute10011();
  public
    destructor Destroy; override;
    constructor Create;
  end;

//当前程序使用到的数据版本号,每次数据升级需要手工更改这个常量.
//并且需要将方法手工添加进[ListPatch].
const
  CONST_DATA_BASE_DICTMOD:string ='00001';
  CONST_DATA_BASE_VERSION:Integer= 10001;  

var
  UniPatchxEx:TUniPatchX;
  FUniConnct :TUniConnection;   

implementation

uses
  Class_KzUtils,Class_Dict,Class_SQLX;


{ TUniPatchX }

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
  for I:=0 to ListConnct.Count-1 do
  begin
    UniConnct:=TUniConnection(ListConnct.Objects[I]);
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
  IDXA:=ListConnct.IndexOf(ATargetMark);
  if IDXA=-1 then
  begin
    UniConnctA:=UniConnctEx.GetConnection(ATargetMark);
    UniConnctA.StartTransaction;
    ListConnct.AddObject(ATargetMark,UniConnctA);
    FUniConnct:=UniConnctA;
  end else
  begin
    FUniConnct:=TUniConnection(ListConnct.Objects[IDXA]);
  end;
end;

constructor TUniPatchX.Create;
begin
  ListPatch :=TListPatch.Create;
  ListConnct:=TStringList.Create;
end;

destructor TUniPatchX.Destroy;
var
  I:Integer;
  UniConnctA:TUniConnection;
begin
  for I:=0 to ListPatch.Count-1 do
  begin
    ListPatch.Objects[I].Free;
    ListPatch.Objects[I]:=nil;
  end;
  FreeAndNil(ListPatch);

  for I:=0 to ListConnct.Count-1 do
  begin
    //YXC_2013_02_25_15_18_40_keep a version
    {UniConnctA:=TUniConnection(ListConnct.Objects[I]);
    if UniConnctA<>nil then
    begin
      if UniConnctA.Connected then UniConnctA.Connected:=False;
    end;}
    ListConnct.Objects[I].Free;
    ListConnct.Objects[I]:=nil;
  end;
  FreeAndNil(ListConnct);
  
  inherited;
end;

procedure TUniPatchX.Execute;
var
  I:Integer;
  SQLA :string;
  IDXA:Integer; //数据库里的数据库版本
  IDXB:Integer; //
  PatchA:TOncePatch;
begin
  IDXA:=GetDataBaseVersion;
  if IDXA=-1 then
  begin
    //改版前操作
    Connect(TargetMark);
    Execute10001;
    IDXA:=10001;
  end;

  //YXC_2012_11_21_10_24_05_不需要升级.
  if IDXA = CONST_DATA_BASE_VERSION then Exit;

  try
    try
      for I:=IDXA+1  to CONST_DATA_BASE_VERSION do
      begin
        IDXB:=-1;
        IDXB:=ListPatch.IndexOf(IntToStr(I));
        if IDXB<>-1 then
        begin
          PatchA:=nil;
          PatchA:=TOncePatch(ListPatch.Objects[IDXB]);
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
  {if IDXA < CONST_DATA_BASE_VERSION then
  begin
    for I:=IDXA+1  to CONST_DATA_BASE_VERSION do
    begin
      IDXB:=-1;
      IDXB:=ListPatch.IndexOf(IntToStr(I));
      if IDXB<>-1 then
      begin
        PatchA:=nil;
        PatchA:=TOncePatch(ListPatch.Objects[IDXB]);
        if PatchA=nil then Continue;

        try
          Connect(PatchA.ConnctMark);
          PatchA.ProcPatchA();
          if FUniConnct.Connected then
          begin
            FUniConnct.Connected:=False;
          end;          
        except
          raise Exception.CreateFmt('UPGRADE ERROR:%S:%S',[PatchA.VersionMod,PatchA.ConnctMark]);
        end;
      end;
    end;}
    //更新数据库版本号
    SetDataBaseVersion(CONST_DATA_BASE_VERSION);
    {if FUniConnct.Connected then
    begin
      FUniConnct.Connected:=False;
    end;}
  //end;
end;

procedure TUniPatchX.Execute10001;
begin

end;

procedure TUniPatchX.Execute10002;
begin
end;

procedure TUniPatchX.Execute10003;
begin
end;

procedure TUniPatchX.Execute10004;
begin
end;

procedure TUniPatchX.Execute10005;
begin
end;

procedure TUniPatchX.Execute10006;
begin
end;

procedure TUniPatchX.Execute10007;
begin
end;

procedure TUniPatchX.Execute10008;
begin
end;

procedure TUniPatchX.Execute10009;
begin
end;

procedure TUniPatchX.Execute10010;
begin
end;

procedure TUniPatchX.Execute10011;
begin
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
    if UniQueryA<>nil then
    begin
      FreeAndNil(UniQueryA);
    end;  
  end;
end;

function  TUniPatchX.Initialize(ATargetMark,ATargetTabl:string):Boolean;
var
  I:Integer;
  UniConnct:TUniConnection;
begin
  Result:=False;
  
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

    if ListConnct<>nil then
    begin
      for I:=0 to ListConnct.Count-1 do
      begin
        ListConnct.Objects[I].Free;
        ListConnct.Objects[I]:=nil;
      end;
      FreeAndNil(ListConnct);
    end;
    ListConnct:=TStringList.Create;
  finally
    FreeAndNil(UniConnct);
  end;

  Result:=True;         
end;

procedure TUniPatchX.Rollback;
var
  I:Integer;
  UniConnct:TUniConnection;
begin
  for I:=0 to ListConnct.Count-1 do
  begin
    UniConnct:=TUniConnection(ListConnct.Objects[I]);
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

{ TOncePatch }

initialization
begin
  UniPatchxEx:=TUniPatchX.Create;
  UniPatchxEx.ListPatch.AddPatch('10001','-1',@TUniPatchX.Execute10001);
  UniPatchxEx.ListPatch.AddPatch('10002','-1',@TUniPatchX.Execute10002);
  UniPatchxEx.ListPatch.AddPatch('10003','-1',@TUniPatchX.Execute10003);
  UniPatchxEx.ListPatch.AddPatch('10004','-1',@TUniPatchX.Execute10004);
  UniPatchxEx.ListPatch.AddPatch('10005','-1',@TUniPatchX.Execute10005);
  UniPatchxEx.ListPatch.AddPatch('10006','-1',@TUniPatchX.Execute10006);
  UniPatchxEx.ListPatch.AddPatch('10007','-1',@TUniPatchX.Execute10007);
  UniPatchxEx.ListPatch.AddPatch('10008','-1',@TUniPatchX.Execute10008);
  UniPatchxEx.ListPatch.AddPatch('10009','-1',@TUniPatchX.Execute10009);
  UniPatchxEx.ListPatch.AddPatch('10010','-1',@TUniPatchX.Execute10010);
  UniPatchxEx.ListPatch.AddPatch('10011','-1',@TUniPatchX.Execute10011);
end;

finalization
begin
  if UniPatchxEx<>nil then FreeAndNil(UniPatchxEx);
end;

end.
