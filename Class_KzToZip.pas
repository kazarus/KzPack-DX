unit Class_KzToZip;

interface
uses
  System.Classes,System.SysUtils,System.NetEncoding,System.ZLib;

type
  THelprString = record helper for string
  public
    function  kzUseZip:string;
    function  ToUseZip:string;
    function  UnUseZip:string;
    function  FileDisk(fileName:string):Boolean;
  public
    function  ToBase64:string;deprecated;
    function  UnBase64:string;
  public
  end;

  TKzUnZip=class(TObject)
  public
    class function ToUseZip(aSource:string):string;
    class function UnUseZip(aBase64:string):string;

    class function  FileToBase64(aFileName:string):string;
    class procedure Base64toFile(aFnBase64:string;var msStream:TMemoryStream);
  end;

implementation

uses
  Class_KzUtils;

{ THelprString }

function THelprString.FileDisk(fileName: string): Boolean;
var
  IntStream:TStringStream;
begin
  try
    IntStream:=TStringStream.Create(Self);
    IntStream.SaveToFile(fileName);
    Self:=IntStream.DataString;
  finally
    FreeAndNil(IntStream);
  end;
end;




function THelprString.kzUseZip: string;
var
  nVAL:Integer;
  nBYT:TBytes;
  mBYT:TBytes;
  intStream:TMemoryStream;
  outStream:TStringStream;
  cCompress:TZCompressionStream;
begin
  try
    nBYT:=TEncoding.ANSI.GetBytes(Self);
    intStream:=TMemoryStream.Create;
    intStream.WriteData(nBYT,Length(nBYT));
    nVAL:=intStream.Size;

    outStream := TStringStream.Create;
    outStream.Write(nVAL, SizeOf(nVAL));

    cCompress := TCompressionStream.Create(clMax, outStream);
    intStream.SaveToStream(cCompress);
    cCompress.Free;

    Result:=outStream.DataString;
    {outStream.Position:=0;
    SetLength(mBYT,outStream.Size);
    outStream.Read(mBYT[0],outStream.Size);
    Result:=TNetEncoding.Base64.EncodeBytesToString(mBYT);}
  finally
    FreeAndNil(intStream);
    FreeAndNil(outStream);
  end;
end;

function THelprString.ToBase64: string;
var
  intStream:TMemoryStream;
  mBYT:TBytes;
  nBYT:TBytes;
begin
  //#raise Exception.Create('ERROR:Helpr_String.pas.THelprString.ToBase64.LINE:246.INFO:some thing promiss me.');
  try
    nBYT:=TEncoding.ANSI.GetBytes(Self);

    intStream:=TMemoryStream.Create;
    intStream.WriteData(nBYT,Length(nBYT));

    intStream.Position:=0;
    SetLength(mBYT,intStream.Size);
    intStream.Read(mBYT[0],intStream.Size);
    Result:=TNetEncoding.Base64.EncodeBytesToString(mBYT);
  finally
    FreeAndNil(intStream);
  end;
end;

function THelprString.ToUseZip: string;
var
  nVAL:Integer;
  nBYT:TBytes;
  mBYT:TBytes;
  intStream:TMemoryStream;
  outStream:TMemoryStream;
  cCompress:TZCompressionStream;
begin
  try
    nBYT:=TEncoding.ANSI.GetBytes(Self);
    intStream:=TMemoryStream.Create;
    intStream.WriteData(nBYT,Length(nBYT));
    nVAL:=intStream.Size;

    outStream := TMemoryStream.Create;
    outStream.Write(nVAL, SizeOf(nVAL));

    cCompress := TCompressionStream.Create(clMax, outStream);
    intStream.SaveToStream(cCompress);
    cCompress.Free;

    outStream.Position:=0;
    SetLength(mBYT,outStream.Size);
    outStream.Read(mBYT[0],outStream.Size);
    Result:=TNetEncoding.Base64.EncodeBytesToString(mBYT);
  finally
    FreeAndNil(intStream);
    FreeAndNil(outStream);
  end;
end;

function THelprString.UnBase64: string;
var
  bytStream:TBytesStream;
  outStream:TStringStream;
begin
  try
    bytStream:=TBytesStream.Create(TNetEncoding.Base64.DecodeStringToBytes(Self));
    bytStream.Position:=0;

    outStream:=TStringStream.Create;
    outStream.CopyFrom(bytStream,bytStream.Size);

    Result:=outStream.DataString;
  finally
    FreeAndNil(bytStream);
    FreeAndNil(outStream);
  end;
end;

function THelprString.UnUseZip: string;
var
  nVAL:Integer;
  bytStream:TBytesStream;
  dCompress:TZDecompressionStream;
  outStream:TStringStream;
begin
  try
    bytStream:=TBytesStream.Create(TNetEncoding.Base64.DecodeStringToBytes(Self));
    //#5
    bytStream.Position := 0;
    bytStream.ReadBuffer(nVAL,SizeOf(nVAL));

    dCompress:=TZDecompressionStream.Create(bytStream);

    outStream:=TStringStream.Create;
    outStream.SetSize(nVAL);

    dCompress.Read(outStream.Memory^, nVAL);

    Result:=outStream.DataString;
  finally
    FreeAndNil(bytStream);
    FreeAndNil(dCompress);
    FreeAndNil(outStream);
  end;
end;

{ TKzUseZip }


class procedure TKzUnZip.Base64toFile(aFnBase64: string;
  var msStream: TMemoryStream);
var
  bytStream:TBytesStream;
begin
  if msStream=nil then Exit;

  try
    bytStream:=TBytesStream.Create(TNetEncoding.Base64.DecodeStringToBytes(aFnBase64));
    //#bytStream.SaveToFile(TKzUtils.ExePath+'2.fr3');
    bytStream.Position:=0;
    msStream.CopyFrom(bytStream,bytStream.Size);
  finally
    FreeAndNil(bytStream);
  end;
end;

class function TKzUnZip.FileToBase64(aFileName: string): string;
var
  mBYT:TBytes;
  intStream:TMemoryStream;
begin
  Result:='';
  if not FileExists(aFileName) then Exit;
  
  try
    intStream:=TMemoryStream.Create;
    intStream.LoadFromFile(aFileName);

    intStream.Position:=0;
    SetLength(mBYT,intStream.Size);
    intStream.Read(mBYT[0],intStream.Size);
    Result:=TNetEncoding.Base64.EncodeBytesToString(mBYT);
  finally
    FreeAndNil(intStream);
  end;
end;

class function TKzUnZip.ToUseZip(aSource: string): string;
var
  nVAL:Integer;
  nBYT:TBytes;
  mBYT:TBytes;
  intStream:TMemoryStream;
  outStream:TMemoryStream;
  cCompress:TZCompressionStream;
begin
  try
    nBYT:=TEncoding.ANSI.GetBytes(aSource);
    intStream:=TMemoryStream.Create;
    intStream.WriteData(nBYT,Length(nBYT));
    nVAL:=intStream.Size;

    outStream := TMemoryStream.Create;
    outStream.Write(nVAL, SizeOf(nVAL));

    cCompress := TCompressionStream.Create(clMax, outStream);
    intStream.SaveToStream(cCompress);
    cCompress.Free;

    outStream.Position:=0;
    SetLength(mBYT,outStream.Size);
    outStream.Read(mBYT[0],outStream.Size);
    Result:=TNetEncoding.Base64.EncodeBytesToString(mBYT);
  finally
    FreeAndNil(intStream);
    FreeAndNil(outStream);
  end;
end;

class function TKzUnZip.UnUseZip(aBase64: string): string;
var
  nVAL:Integer;
  bytStream:TBytesStream;
  dCompress:TZDecompressionStream;
  outStream:TStringStream;
begin
  try
    bytStream:=TBytesStream.Create(TNetEncoding.Base64.DecodeStringToBytes(aBase64));
    //#5
    bytStream.Position := 0;
    bytStream.ReadBuffer(nVAL,SizeOf(nVAL));

    dCompress:=TZDecompressionStream.Create(bytStream);

    outStream:=TStringStream.Create;
    outStream.SetSize(nVAL);

    dCompress.Read(outStream.Memory^, nVAL);

    Result:=outStream.DataString;
  finally
    FreeAndNil(bytStream);
    FreeAndNil(dCompress);
    FreeAndNil(outStream);
  end;
end;

end.
