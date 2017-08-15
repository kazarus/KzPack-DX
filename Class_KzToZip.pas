unit Class_KzToZip;
//GZIP

interface
uses
  System.Classes,System.SysUtils,System.NetEncoding,IdZLib;

type
  THelprString = record helper for string
  public
    function  kzUseZip:string;deprecated;
    function  ToUseZip:string;
    function  UnUseZip:string;
    function  FileDisk(fileName:string):Boolean;
  public
    function  ToBase64:string;
    function  UnBase64:string;
  public
  end;

  TKzToZip=class(TObject)
  public
    class function ToUseZip(aSource:string):string;
    class function UnUseZip(aBase64:string):string;

    class function  FileToBase64(aFileName:string):string;overload;
    class function  FileToBase64(intStream:TMemoryStream):string;overload;
    class procedure Base64toFile(aFnBase64:string;var msStream:TMemoryStream);
  end;

implementation

uses
  Class_KzUtils,Vcl.Dialogs;

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
  cCompress:TCompressionStream;
begin
  try
    nBYT:=TEncoding.UTF8.GetBytes(Self);
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
    nBYT:=TEncoding.UTF8.GetBytes(Self);

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
  cCompress:TCompressionStream;
begin
  try
    nBYT:=TEncoding.UTF8.GetBytes(Self);
    intStream:=TMemoryStream.Create;
    intStream.WriteData(nBYT,Length(nBYT));
    nVAL:=intStream.Size;

    outStream := TMemoryStream.Create;
    outStream.Write(nVAL, SizeOf(nVAL));
    outStream.Position:=0;

    cCompress := TCompressionStream.CreateGZ(clDefault, outStream);
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
  nRead:Integer;
  Buffer:array[0..1023] of Char;
  bytStream:TBytesStream;
  dCompress:TDecompressionStream;
  outStream:TStringStream;
begin
  try
    bytStream:=TBytesStream.Create(TNetEncoding.Base64.DecodeStringToBytes(Self));
    bytStream.Position := 0;

    dCompress:=TDecompressionStream.Create(bytStream);
    outStream:=TStringStream.Create;
    repeat
      nRead := dCompress.Read(Buffer,1024);
      outStream.Write(Buffer,nRead);
    until nRead = 0;

    Result:=outStream.DataString;
  finally
    FreeAndNil(bytStream);
    FreeAndNil(dCompress);
    FreeAndNil(outStream);
  end;
end;

{ TKzUseZip }


class procedure TKzToZip.Base64toFile(aFnBase64: string;
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

class function TKzToZip.FileToBase64(aFileName: string): string;
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

class function TKzToZip.FileToBase64(intStream: TMemoryStream): string;
var
  mBYT:TBytes;
begin
  Result:='';
  if intStream = nil then Exit;

  try
    intStream.Position:=0;
    SetLength(mBYT,intStream.Size);
    intStream.Read(mBYT[0],intStream.Size);
    Result:=TNetEncoding.Base64.EncodeBytesToString(mBYT);
  finally
    //@FreeAndNil(intStream);
  end;
end;

class function TKzToZip.ToUseZip(aSource: string): string;
var
  nVAL:Integer;
  nBYT:TBytes;
  mBYT:TBytes;
  intStream:TMemoryStream;
  outStream:TMemoryStream;
  cCompress:TCompressionStream;
begin
  try
    nBYT:=TEncoding.UTF8.GetBytes(aSource);
    intStream:=TMemoryStream.Create;
    intStream.WriteData(nBYT,Length(nBYT));
    nVAL:=intStream.Size;

    outStream := TMemoryStream.Create;
    outStream.Write(nVAL, SizeOf(nVAL));
    outStream.Position:=0;

    cCompress := TCompressionStream.CreateGZ(clDefault, outStream);
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

class function TKzToZip.UnUseZip(aBase64: string): string;
var
  nRead:Integer;
  Buffer:array[0..1023] of Char;
  bytStream:TBytesStream;
  dCompress:TDecompressionStream;
  outStream:TStringStream;
begin
  try
    bytStream:=TBytesStream.Create(TNetEncoding.Base64.DecodeStringToBytes(aBase64));
    bytStream.Position := 0;

    dCompress:=TDecompressionStream.Create(bytStream);
    outStream:=TStringStream.Create;
    repeat
      nRead := dCompress.Read(Buffer,1024);
      outStream.Write(Buffer,nRead);
    until nRead = 0;

    Result:=outStream.DataString;
  finally
    FreeAndNil(bytStream);
    FreeAndNil(dCompress);
    FreeAndNil(outStream);
  end;
end;

end.
