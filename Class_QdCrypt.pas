unit Class_QdCrypt;


interface
uses
  qaes, qstring, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes;

type
  TQdCrypt = class(TObject)
  public
    class function Encode(const aKey: string; aSource: string; aKeyType: TQAESKeyType = kt256): string;
    class function Decode(const aKey: string; aSource: string; aKeyType: TQAESKeyType = kt256): string;
  end;

implementation

class function TQdCrypt.Decode(const aKey: string; aSource: string; aKeyType: TQAESKeyType): string;
var
  AES: TQAES;
  BYT: TBytes;
begin
  qstring.HexToBin(aSource, BYT);
  AES.AsECB(aKey, aKeyType);
  Result := AES.Decrypt(BYT);
end;

class function TQdCrypt.Encode(const aKey: string; aSource: string; aKeyType: TQAESKeyType): string;
var
  AES: TQAES;
  BYT: TBytes;
begin
  AES.AsECB(aKey, aKeyType);
  AES.Encrypt(aSource, BYT);
  Result := qstring.BinToHex(BYT);
end;

end.
