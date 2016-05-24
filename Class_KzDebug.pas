unit Class_KzDebug;

interface
uses
  Classes,SysUtils,Variants,rtcTcpCli,rtcLog,Windows,StrUtils;

type
  TKzDebug=class(TObject)
  private
    ThisTick :Integer;
    LastTick :Integer;
    TotlTick :Integer;
    
    TcpClient:TRtcTcpClient;
  protected
    function  GetFileName:string;  
  public
    ServAddr:string;
    ServPort:string;
  public
    procedure WritLog(AValue:Variant;IsEnter:Boolean=True);overload;
    procedure WritFmt(const Msg: string; Params: array of const;IsEnter:Boolean=True);overload;

    procedure FileLog(AValue:Variant);overload;
    procedure FileFmt(const Msg: string; Params: array of const);overload;
    procedure FileFmt(Params: array of const);overload;

    procedure Started;
    procedure TickLog(AValue:Variant);overload;
    procedure TickFmt(const Msg: string; Params: array of const);
  public
    destructor Destroy; override;
    constructor Create;
  end;

var
  KzDebug:TKzDebug;
    
implementation

uses
  Forms;

{ TKzDebug }

constructor TKzDebug.Create;
begin
  LastTick :=0;
  ThisTick :=0;
  TcpClient:=TRtcTcpClient.Create(nil);
end;

destructor TKzDebug.Destroy;
begin
  if TcpClient<>nil then
  begin
    FreeAndNil(TcpClient);
  end;  
  inherited;
end;

procedure TKzDebug.FileFmt(const Msg: string; Params: array of const);
begin
  Log(Format(Msg,Params),GetFileName);
end;

procedure TKzDebug.FileFmt(Params: array of const);
var
  I: Integer;
  Msg:string;
begin
  Msg:='';
  for I := 1 to Length(Params) do
  begin
    Msg:=Msg+':%S';
  end;
  Delete(Msg,1,1);

  Log(Format(Msg,Params),GetFileName);
end;

procedure TKzDebug.FileLog(AValue: Variant);
begin
  Log(VarToStr(AValue),GetFileName);
end;

function TKzDebug.GetFileName: string;
begin
  Result:=LowerCase(Format('%s',[ExtractFileName(Application.ExeName)]));
end;

procedure TKzDebug.Started;
begin
  ThisTick :=0;
  LastTick :=0;
  TotlTick :=0;
end;

procedure TKzDebug.TickFmt(const Msg: string; Params: array of const);
var
  AValue:string;
  
  function FormatCode(ATick:Integer):string;
  begin
    Result:=DupeString(' ',7-Length(IntToStr(ATick)))+IntToStr(ATick);
  end;
begin
  if DebugHook=0 then Exit;
  
  AValue:=Format(Msg,Params);
  
  if LastTick=0 then
  begin
    ThisTick:=GetTickCount;
    LastTick:=GetTickCount;
    TotlTick:=GetTickCount;
    Log(Format('%D|       |       |%S',[ThisTick,VarToStr(AValue)]),'TICKLOG');
  end else
  begin
    ThisTick:=GetTickCount;
    Log(Format('%D|%S|%S|%S',[ThisTick,FormatCode(ThisTick - LastTick),FormatCode(ThisTick - TotlTick),VarToStr(AValue)]),'TICKLOG');
    LastTick:=GetTickCount;
  end;
end;

procedure TKzDebug.TickLog(AValue: Variant);
  function FormatCode(ATick:Integer):string;
  begin
    Result:=DupeString(' ',7-Length(IntToStr(ATick)))+IntToStr(ATick);
  end;
begin
  if DebugHook=0 then Exit;
  
  if LastTick=0 then
  begin
    ThisTick:=GetTickCount;
    LastTick:=GetTickCount;
    TotlTick:=GetTickCount;
    Log(Format('%D|       |       |%S',[ThisTick,VarToStr(AValue)]),'TICKLOG');
  end else
  begin
    ThisTick:=GetTickCount;
    Log(Format('%D|%S|%S|%S',[ThisTick,FormatCode(ThisTick - LastTick),FormatCode(ThisTick - TotlTick),VarToStr(AValue)]),'TICKLOG');
    LastTick:=GetTickCount;
  end;
end;

procedure TKzDebug.WritFmt(const Msg: string; Params: array of const;IsEnter:Boolean);
begin
  if DebugHook=0 then Exit;
  TcpClient.ServerAddr:=ServAddr;
  TcpClient.ServerPort:=ServPort;
  TcpClient.Connect();

  if IsEnter then
  begin
    TcpClient.Write(Format(Msg,Params)+#13);
  end else
  begin
    TcpClient.Write(Format(Msg,Params));
  end;  
end;

procedure TKzDebug.WritLog(AValue: Variant; IsEnter: Boolean);
begin
  if DebugHook=0 then Exit;
  TcpClient.ServerAddr:=ServAddr;
  TcpClient.ServerPort:=ServPort;
  TcpClient.Connect();

  if IsEnter then
  begin
    TcpClient.Write(VarToStr(AValue)+#13);
  end else
  begin
    TcpClient.Write(VarToStr(AValue));
  end;
end;

initialization
begin
  KzDebug:=TKzDebug.Create;
  KzDebug.ServAddr:='127.0.0.1';
  KzDebug.ServPort:='1861';

  StartLog;
end;

finalization
begin
  if KzDebug<>nil then
  begin
    FreeAndNil(KzDebug);
  end;  
end;  

end.
