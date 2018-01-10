unit Class_IpUtils;
//#thanks:http://www.taoyoyo.net/ttt/post/188.html

interface
uses
  Classes,SysUtils,WinSock,Windows;

type
  TIpUtils = class(TObject)
  public
    class function GetLocalName():string;
    class function ComputerIP():string;overload;    
    class function ComputerIP(ComputerName:String):string;overload;
    class function GetLocalIp(InternetIP:boolean):string;
  end;

implementation


class function TIpUtils.ComputerIP(ComputerName: String): string;
var
  phe: pHostEnt;
  w: TWSAData;
  ip_address: longint;
  p: ^longint;
  ipstr: string;
begin
  if WSAStartup(2, w) <> 0 then exit;
  
  phe := gethostbyname(pchar(ComputerName));
  if phe <> nil then
  begin
    p := pointer(phe^.h_addr_list^);
    ip_address := p^;
    ip_address := ntohl(ip_address);
    ipstr := IntToStr(ip_address shr 24) + '.' + IntToStr((ip_address shr 16) and $ff) + '.' + IntToStr((ip_address shr 8) and $ff) + '.' + IntToStr(ip_address and $ff);
    Result := ipstr;
  end;
end;

class function TIpUtils.ComputerIP: string;
begin
  Result := ComputerIP(GetLocalName);
end;

class function TIpUtils.GetLocalIp(InternetIP: boolean): string;
type
  TaPInAddr = array[0..10] of PInAddr;

  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  Buffer: array[0..63] of Char;
  I: Integer;
  GInitData: TWSAData;
  IP: string;
begin
  //#Screen.Cursor := crHourGlass;
  try
    WSAStartup($101, GInitData);
    IP := '0.0.0.0';
    GetHostName(Buffer, SizeOf(Buffer));
    phe := GetHostByName(Buffer);
    if phe = nil then
    begin
      Result := IP;
      Exit;
    end;
    pptr := PaPInAddr(phe^.h_addr_list);
    if InternetIP then
    begin
      I := 0;
      while pptr^[I] <> nil do
      begin
        IP := inet_ntoa(pptr^[I]^);
        Inc(I);
      end;
    end
    else
      IP := inet_ntoa(pptr^[0]^);
    WSACleanup;
    Result := IP;//如果上网则为上网IP,否则网卡IP;
  finally
    //#Screen.Cursor := crDefault;
  end;
end;

class function TIpUtils.GetLocalName: string;
var
  CNameBuffer: PChar;
  CLen: ^DWord;
begin
  GetMem(CNameBuffer, 255);
  New(CLen);
  CLen^ := 255;
  if GetComputerName(CNameBuffer, CLen^) then
    result := CNameBuffer
  else
    result := '';
  FreeMem(CNameBuffer, 255);
  Dispose(CLen);
end;

end.
