unit Class_Load_Cnfg;
//#XlsImport

interface
uses
  Classes,SysUtils,DB,Uni,UniEngine;

type
  TLoadCnfg=class(TUniEngine)
  private
    FMASTCODE : string;
    FROWTITLE : Integer;
    FCOLSTART : Integer;
    FROWSTART : Integer;
    FROWENDED : Integer;
    FKJNDKJQJ : Integer;
    FFILEPATH : string;
  protected
    procedure SetParameters;override;
    function  GetStrInsert:string;override;
    function  GetStrUpdate:string;override;
    function  GetStrDelete:string;override;
  public                                                     
    function  GetStrsIndex:string;override;
  public
    function  GetFilePath(aValue:string):string;
  public
    //#function  GetNextIndx:Integer;overload;
    //#function  GetNextIndx(AUniConnection:TUniConnection):Integer;overload;
  public
    function  CheckExist(AUniConnection:TUniConnection):Boolean;override;
  public
    destructor  Destroy; override;
    constructor Create;  
  published
    property MASTCODE : string read FMASTCODE  write FMASTCODE;
    property ROWTITLE : Integer read FROWTITLE  write FROWTITLE;
    property COLSTART : Integer read FCOLSTART  write FCOLSTART;
    property ROWSTART : Integer read FROWSTART  write FROWSTART;
    property ROWENDED : Integer read FROWENDED  write FROWENDED;
    property KJNDKJQJ : Integer read FKJNDKJQJ  write FKJNDKJQJ;
    property FILEPATH : string read FFILEPATH  write FFILEPATH;    
  public
    class function  ReadDS(AUniQuery:TUniQuery):TUniEngine;override;
    class procedure ReadDS(AUniQuery:TUniQuery;var Result:TUniEngine);override;
    class function  CopyIt(aLoadCnfg:TLoadCnfg):TLoadCnfg;overload;        
    class procedure CopyIt(aLoadCnfg:TLoadCnfg;var Result:TLoadCnfg);overload;       
  end;

implementation

uses
  Class_KzUtils,System.StrUtils;


procedure TLoadCnfg.SetParameters;
begin
  inherited;
  with FUniSQL.Params do
  begin
    case FOptTyp of
      otAddx:
      begin
        ParamByName('MAST_CODE').Value := MASTCODE;
        ParamByName('ROW_TITLE').Value := ROWTITLE;
        ParamByName('COL_START').Value := COLSTART;
        ParamByName('ROW_START').Value := ROWSTART;
        ParamByName('ROW_ENDED').Value := ROWENDED;
        ParamByName('KJND_KJQJ').Value := KJNDKJQJ;
        ParamByName('FILE_PATH').Value := FILEPATH; 
      end;
      otEdit:
      begin
        ParamByName('MAST_CODE').Value := MASTCODE;
        ParamByName('ROW_TITLE').Value := ROWTITLE;
        ParamByName('COL_START').Value := COLSTART;
        ParamByName('ROW_START').Value := ROWSTART;
        ParamByName('ROW_ENDED').Value := ROWENDED;
        ParamByName('KJND_KJQJ').Value := KJNDKJQJ;
        ParamByName('FILE_PATH').Value := FILEPATH; 
      end;  
      otDelt:
      begin
        ParamByName('MAST_CODE').Value := MASTCODE;
 
      end;  
    end;
  end;
end;

function TLoadCnfg.CheckExist(AUniConnection: TUniConnection): Boolean;
begin
  Result:=CheckExist('DZD_LOAD_CNFG',['MAST_CODE',MASTCODE],AUniConnection);
end;

{#function TLoadCnfg.GetNextIndx: Integer;
begin

end;}

{#function TLoadCnfg.GetNextIndx(AUniConnection: TUniConnection): Integer;
begin

end;}

function TLoadCnfg.GetFilePath(aValue:string): string;
begin

  Result := TKzUtils.ExePath;
  if not DirectoryExists(TKzUtils.ExePath+'导入') then
  begin
    CreateDir(TKzUtils.ExePath+'导入')
  end;

  Result := Format('%S\%S_loadcnfg.json',[TKzUtils.ExePath+'导入',LowerCase(aValue)]);
end;

function TLoadCnfg.GetStrDelete: string;
begin
  Result:='DELETE FROM DZD_LOAD_CNFG WHERE   MAST_CODE=:MAST_CODE';
end;

function TLoadCnfg.GetStrInsert: string;
begin
  Result:='INSERT INTO DZD_LOAD_CNFG'
         +'    ( MAST_CODE, ROW_TITLE, COL_START, ROW_START, ROW_ENDED'
         +'    , KJND_KJQJ, FILE_PATH)'
         +'    VALUES'
         +'    (:MAST_CODE,:ROW_TITLE,:COL_START,:ROW_START,:ROW_ENDED'
         +'    ,:KJND_KJQJ,:FILE_PATH)';
end;

function TLoadCnfg.GetStrsIndex: string;
begin
  Result:=Format('%S',[MASTCODE]);
end;

function TLoadCnfg.GetStrUpdate: string;
begin
  Result:='UPDATE  DZD_LOAD_CNFG SET'
         +'    ROW_TITLE=:ROW_TITLE,'
         +'    COL_START=:COL_START,'
         +'    ROW_START=:ROW_START,'
         +'    ROW_ENDED=:ROW_ENDED,'
         +'    KJND_KJQJ=:KJND_KJQJ,'
         +'    FILE_PATH=:FILE_PATH'
         +'    WHERE MAST_CODE=:MAST_CODE';
end;

constructor TLoadCnfg.Create;
begin

end;

destructor TLoadCnfg.Destroy;
begin

  inherited;
end;

class function TLoadCnfg.ReadDS(AUniQuery: TUniQuery): TUniEngine;
begin
  Result:=TLoadCnfg.Create;
  TLoadCnfg.ReadDS(AUniQuery,Result);
end;

class procedure TLoadCnfg.ReadDS(AUniQuery: TUniQuery; var Result: TUniEngine);
var
  I:Integer;
  Field:TField;
  FieldName:string;
begin
  if Result=nil then Exit;

  with TLoadCnfg(Result) do
  begin
    for I:=0 to AUniQuery.Fields.Count-1 do
    begin
      Field:=AUniQuery.Fields.Fields[I];
      //if field.fieldname is not all uppercase,please use uppercase().
      FieldName:=UpperCase(Field.FieldName);
      if FieldName='MAST_CODE' then
      begin
        MASTCODE :=Field.AsString;
      end else
      if FieldName='ROW_TITLE' then
      begin
        ROWTITLE :=Field.AsInteger;
      end else
      if FieldName='COL_START' then
      begin
        COLSTART :=Field.AsInteger;
      end else
      if FieldName='ROW_START' then
      begin
        ROWSTART :=Field.AsInteger;
      end else
      if FieldName='ROW_ENDED' then
      begin
        ROWENDED :=Field.AsInteger;
      end else
      if FieldName='KJND_KJQJ' then
      begin
        KJNDKJQJ :=Field.AsInteger;
      end else
      if FieldName='FILE_PATH' then
      begin
        FILEPATH :=Field.AsString;
      end;
    end
  end;  
end;

class function  TLoadCnfg.CopyIt(aLoadCnfg: TLoadCnfg): TLoadCnfg;
begin
  Result:=TLoadCnfg.Create;
  TLoadCnfg.CopyIt(aLoadCnfg,Result)
end;

class procedure TLoadCnfg.CopyIt(aLoadCnfg:TLoadCnfg;var Result:TLoadCnfg);
begin
  if Result=nil then Exit;
  Result.MASTCODE :=aLoadCnfg.MASTCODE;
  Result.ROWTITLE :=aLoadCnfg.ROWTITLE;
  Result.COLSTART :=aLoadCnfg.COLSTART;
  Result.ROWSTART :=aLoadCnfg.ROWSTART;
  Result.ROWENDED :=aLoadCnfg.ROWENDED;
  Result.KJNDKJQJ :=aLoadCnfg.KJNDKJQJ;
  Result.FILEPATH :=aLoadCnfg.FILEPATH;
end;

end.
