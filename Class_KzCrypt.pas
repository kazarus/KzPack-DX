unit Class_KzCrypt;
//YXC_2014_03_14_09_51_18
//Thanks:http://www.cityinthesky.co.uk/opensource/dcpcrypt/

interface
uses
  Classes,SysUtils,DCPrc4,DCPhaval,DCPmd4,DCPmd5,DCPsha1,DCPsha256,DCPsha512;


type
  TKzCryptType=(kctHaval,kctMd4,kctMd5,kctSha1,kctSha256,kctSha384,kctSha512);

  TKzCrypt=class(TObject)
  public
    class function Encode(const AKey:string;ASource:string;AKzCryptType:TKzCryptType=kctSha1):string;
    class function Decode(const AKey:string;ASource:string;AKzCryptType:TKzCryptType=kctSha1):string;
  end;


implementation

{ TKzCrypt }

class function TKzCrypt.Decode(const AKey: string;ASource: string; AKzCryptType:TKzCryptType): string;
var
  Cipher:TDCP_rc4;
begin
  try
    Cipher:=TDCP_rc4.Create(nil);
    case AKzCryptType of
      kctHaval :Cipher.InitStr(AKey,TDCP_haval);
      kctMd4   :Cipher.InitStr(AKey,TDCP_md4);
      kctMd5   :Cipher.InitStr(AKey,TDCP_md5);
      kctSha1  :Cipher.InitStr(AKey,TDCP_sha1);
      kctSha256:Cipher.InitStr(AKey,TDCP_sha256);
      kctSha384:Cipher.InitStr(AKey,TDCP_sha384);
      kctSha512:Cipher.InitStr(AKey,TDCP_sha512);
    end;
    Result:=Cipher.DecryptString(ASource);
    Cipher.Burn;
  finally
    FreeAndNil(Cipher);
  end;
end;


class function TKzCrypt.Encode(const AKey: string;ASource: string; AKzCryptType:TKzCryptType): string;
var
  Cipher:TDCP_rc4;
begin
  try
    Cipher:=TDCP_rc4.Create(nil);
    case AKzCryptType of
      kctHaval :Cipher.InitStr(AKey,TDCP_haval);
      kctMd4   :Cipher.InitStr(AKey,TDCP_md4);
      kctMd5   :Cipher.InitStr(AKey,TDCP_md5);
      kctSha1  :Cipher.InitStr(AKey,TDCP_sha1);
      kctSha256:Cipher.InitStr(AKey,TDCP_sha256);
      kctSha384:Cipher.InitStr(AKey,TDCP_sha384);
      kctSha512:Cipher.InitStr(AKey,TDCP_sha512);
    end;
    Result:=Cipher.EncryptString(ASource);
    Cipher.Burn;
  finally
    FreeAndNil(Cipher);
  end;
end;

end.
