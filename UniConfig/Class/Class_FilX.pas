unit Class_FilX;
//YXC_2012_08_23_14_24_39
//

interface
uses
  Classes,SysUtils;

type
  TBuildFil=class(TObject)
  public
    class procedure BuildLit;//sqlite
  end;

  TBuildMdb=class(TObject)
  public
    class procedure BuildMdb(AFilePath:string);
  end;

implementation

uses
  Class_KzUtils;

{ TBuildFil }

class procedure TBuildFil.BuildLit;
var
  FilePath :string;
  rsStream :TResourceStream;
begin
  try
    rsStream:=TResourceStream.Create(HInstance,'lit001','dll');
    rsStream.SaveToFile(TKzUtils.ExePath+'sqlite3.dll');
  finally
    FreeAndNil(rsStream);
  end;
  {#FilePath:='C:\WINDOWS\system32\sqlite3.dll';
  if not FileExists(FilePath) then
  begin
    try
      ResStream:=TResourceStream.Create(HInstance,'lit001','dll');
      ResStream.SaveToFile(FilePath);
      FreeAndNil(ResStream);
    except
      ResStream:=TResourceStream.Create(HInstance,'lit001','dll');
      ResStream.SaveToFile(TKzUtils.ExePath+'sqlite3.dll');
      FreeAndNil(ResStream);
    end;
  end;}
end;

{ TBuildMdb }

class procedure TBuildMdb.BuildMdb(AFilePath: string);
var
  ResStream:TResourceStream;
begin
  if not FileExists(AFilePath) then
  begin
    ResStream:=TResourceStream.Create(HInstance,'mdb001','mdb');
    ResStream.SaveToFile(AFilePath);
    FreeAndNil(ResStream);
  end;
end;

end.
