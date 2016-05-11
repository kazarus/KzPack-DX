unit Helpr_String;

interface
uses
  System.Classes,System.SysUtils,System.NetEncoding,System.ZLib;

type
  THelprString = record helper for String
  public
    function  ToUseZip:string;
    function  UnUseZip:string;
  public
    function  ToBase64:string;
    function  UnBase64:string;
  end;

implementation

uses
  Class_KzUtils;

{ THelprString }

function THelprString.ToBase64: string;
var
  SS:TStringStream;
  BT:TBytes;
begin
  try
    SS:=TStringStream.Create;
    SS.WriteString(Self);

    SS.Position:=0;
    SetLength(BT,SS.Size);
    SS.Read(BT[0],SS.Size);
    Result:=TNetEncoding.Base64.EncodeBytesToString(BT);
    //#KzDebug.FileFmt('%S',[TNetEncoding.Base64.EncodeBytesToString(Bytes)]);
  finally
    FreeAndNil(SS);
  end;
end;

function THelprString.ToUseZip: string;
var
  CT:Integer;
  CS:TCompressionStream;
  SS:TStringStream;//source stream
  TS:TStringStream;//target stream
begin
  try
    SS:=TStringStream.Create;
    SS.WriteString(Self);

    CT:=SS.Size;

    TS := TStringStream.Create;
    TS.Write(CT, SizeOf(CT));

    CS := TCompressionStream.Create(clMax, TS);
    SS.SaveToStream(CS);
    CS.Free;

    Result:=TS.DataString;
  finally
    //#FreeAndNil(CS);
    FreeAndNil(SS);
    FreeAndNil(TS);
  end;
end;

function THelprString.UnBase64: string;
var
  BT:TBytes;
  TS:TStringStream;//target stream
begin
  BT:=TNetEncoding.Base64.DecodeStringToBytes(Self);
  try
    TS:=TStringStream.Create;
    TS.Position:=0;
    TS.SetSize(Length(BT));
    TS.Write(BT[0],Length(BT));
    Result:=TS.DataString;
  finally
    FreeAndNil(TS);
  end;
end;

function THelprString.UnUseZip: string;
begin

end;

end.
