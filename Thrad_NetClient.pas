unit Thrad_NetClient;

interface

uses
  Classes,SysUtils,Class_KzThrad,rtcHttpCli,rtcInfo,rtcDataCli,rtcConn,
  rtcDataSrv,SyncObjs,EncdDecd;

type
  TThradNetClient = class(TKzThrad)
  private
    FListPara:TStringList;

    FNetStatusEnded:Boolean;
    FRtcHttpClient :TRtcHttpClient;
    FRtcDataRequest:TRtcDataRequest;
  public
    FSRVRADDR:string;
    FSRVRPORT:string;
    FFileName:string;
    FUNIQUEID:string;
    FPromptTxt:string;
    FCSInHTTP:TCriticalSection;
  public
    procedure AppendPara(aList:TStringList);overload;
    procedure AppendPara(aPara:string;Value:string);overload;
    function  ObtainPara(aPara:string):string;
  protected
    procedure OnRtcDataRequestDataReceived(Sender: TRtcConnection);
    procedure OnRtcDataRequestBeginRequest(Sender: TRtcConnection);
    
    procedure OnRtcHttpClientConnectFail(Sender: TRtcConnection);
    procedure OnRtcHttpClientConnectError(Sender: TRtcConnection;E: Exception);
  protected
    procedure Execute; override;
  public
    destructor Destroy; override;
  end;

implementation


procedure TThradNetClient.AppendPara(aList: TStringList);
begin
  if FListPara=nil then
  begin
    FListPara:=TStringList.Create;
  end;
  FListPara.Clear;

  FListPara.AddStrings(aList);
end;

procedure TThradNetClient.AppendPara(aPara, Value: string);
begin
  if FListPara=nil then
  begin
    FListPara:=TStringList.Create;
  end;

  FListPara.Add(Format('%S=%S',[aPara,Value]));
end;

destructor TThradNetClient.Destroy;
begin
  if FListPara      <>nil then FreeAndNil(FListPara);
  if FRtcHttpClient <>nil then FreeAndNil(FRtcHttpClient);
  if FRtcDataRequest<>nil then FreeAndNil(FRtcDataRequest);
  inherited;
end;

procedure TThradNetClient.Execute;
var
  I:Integer;
begin
  try
    if FCSInHTTP<>nil then FCSInHTTP.Enter;

    FNetStatusEnded:=False;

    FRtcHttpClient:=TRtcHttpClient.Create(nil);
    FRtcHttpClient.ServerAddr:=FSRVRADDR;
    FRtcHttpClient.ServerPort:=FSRVRPORT;
    FRtcHttpClient.OnConnectFail :=OnRtcHttpClientConnectFail;
    FRtcHttpClient.OnConnectError:=OnRtcHttpClientConnectError;
    if FRtcHttpClient.isConnecting then
    begin
      FRtcHttpClient.Disconnect;
    end;
    FRtcHttpClient.Connect();

    FRtcDataRequest:=TRtcDataRequest.Create(nil);
    FRtcDataRequest.Client:=FRtcHttpClient;
    FRtcDataRequest.OnBeginRequest:=OnRtcDataRequestBeginRequest;
    FRtcDataRequest.OnDataReceived:=OnRtcDataRequestDataReceived;
    FRtcDataRequest.Request.Method  :='POST';
    FRtcDataRequest.Request.FileName:=FFileName;
    if (FListPara<>nil) and (FListPara.Count>0) then
    begin
      for I:=0 to FListPara.Count-1 do
      begin
        FRtcDataRequest.Request.Params[FListPara.Names[I]]:=FListPara.ValueFromIndex[I];
      end;
    end;    
    FRtcDataRequest.Post();
    GetTxtProgress(FPromptTxt);

    while not FNetStatusEnded do
    begin
    end;

    GetEndProgrees;    
    GetMsgProgress(Class_KzThrad.CONST_THRAD_STAT_TRUE,[]);
  finally
    if FCSInHTTP<>nil then FCSInHTTP.Leave;
  end;
end;

function TThradNetClient.ObtainPara(aPara: string): string;
begin
  Result := '';
  if (FListPara = nil) or (FListPara.Count=0) then Exit;
  Result := FListPara.Values[aPara];
end;

procedure TThradNetClient.OnRtcDataRequestBeginRequest(
  Sender: TRtcConnection);
var
  DataClient:TRtcDataClient absolute  Sender;
begin
  inherited;
  with DataClient do
  begin
    Write(Request.Params.Text);
  end;
end;

procedure TThradNetClient.OnRtcDataRequestDataReceived(
  Sender: TRtcConnection);
var
  DataRead:string;
  DataClient:TRtcDataClient absolute  Sender;
begin
  inherited;
  with DataClient do
  begin
    if Response.Done then
    begin
      //#if Request.FileName=Class_AppUtil_IN_GKZF.CONST_REQUEST_FILE_NAME_TAPPCNFG_SELECTDB then
      begin
        DataRead:=DecodeString(Trim(Read));
        GetMsgProgress(Class_KzThrad.CONST_THRAD_STAT_DATA,[FUNIQUEID,DataRead]);
        FNetStatusEnded:=True;
      end;
    end;
  end;
end;

procedure TThradNetClient.OnRtcHttpClientConnectError(
  Sender: TRtcConnection; E: Exception);
begin
  FNetStatusEnded:=True;
end;

procedure TThradNetClient.OnRtcHttpClientConnectFail(
  Sender: TRtcConnection);
begin
  FNetStatusEnded:=True;
end;

end.
