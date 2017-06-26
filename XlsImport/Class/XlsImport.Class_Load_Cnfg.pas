unit XlsImport.Class_Load_Cnfg;
//#XlsImport

interface
uses
  Classes,SysUtils,DB,Uni,UniEngine;

type
  TLoadCnfg=class(TUniEngine)
  private
    FMASTCODE : string;
    FPAGEINDX : Integer;
    FPAGENAME : string;
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
    property MASTCODE : string  read FMASTCODE  write FMASTCODE;
    property PAGEINDX : Integer read FPAGEINDX  write FPAGEINDX;
    property PAGENAME : string  read FPAGENAME  write FPAGENAME;
    property ROWTITLE : Integer read FROWTITLE  write FROWTITLE;
    property COLSTART : Integer read FCOLSTART  write FCOLSTART;
    property ROWSTART : Integer read FROWSTART  write FROWSTART;
    property ROWENDED : Integer read FROWENDED  write FROWENDED;
    property KJNDKJQJ : Integer read FKJNDKJQJ  write FKJNDKJQJ;
    property FILEPATH : string  read FFILEPATH  write FFILEPATH;
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
end;

function TLoadCnfg.CheckExist(AUniConnection: TUniConnection): Boolean;
begin
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

  Result := Format('%s\%s_loadcnfg.json',[TKzUtils.ExePath+'导入',LowerCase(aValue)]);
end;

function TLoadCnfg.GetStrDelete: string;
begin
end;

function TLoadCnfg.GetStrInsert: string;
begin
end;

function TLoadCnfg.GetStrsIndex: string;
begin
  Result:=Format('%S',[MASTCODE]);
end;

function TLoadCnfg.GetStrUpdate: string;
begin
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
begin
end;

class function  TLoadCnfg.CopyIt(aLoadCnfg: TLoadCnfg): TLoadCnfg;
begin
  Result:=TLoadCnfg.Create;
  TLoadCnfg.CopyIt(aLoadCnfg,Result)
end;

class procedure TLoadCnfg.CopyIt(aLoadCnfg:TLoadCnfg;var Result:TLoadCnfg);
begin
  if Result=nil then Exit;

  Result.MASTCODE := aLoadCnfg.MASTCODE;
  Result.PAGENAME := aLoadCnfg.PAGENAME;
  Result.ROWTITLE := aLoadCnfg.ROWTITLE;
  Result.COLSTART := aLoadCnfg.COLSTART;
  Result.ROWSTART := aLoadCnfg.ROWSTART;
  Result.ROWENDED := aLoadCnfg.ROWENDED;
  Result.KJNDKJQJ := aLoadCnfg.KJNDKJQJ;
  Result.FILEPATH := aLoadCnfg.FILEPATH;
end;

end.
