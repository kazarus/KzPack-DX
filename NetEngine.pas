unit NetEngine;


interface
uses
  Classes,SysUtils,IniFiles,System.Rtti,rtcDataCli, rtcInfo, rtcConn, rtcHttpCli,rtcDataSrv,
  UniEngine,Uni,UniConnct;

type
  TNetEngineCallBack=(necbEvent,necbBlock);

  TNetEngineDataRequestTrueEvent=procedure (Sender:TObject;Value:string) of object;
  //procedure OnNetEngineDataRequestTrue(Sender: TObject;Value:string);
  TNetEngineDataRequestFailEvent=procedure (Sender:TObject;Value:string) of object;
  //procedure OnNetEngineDataRequestFail(Sender: TObject;Value:string);

  TNetEngineDataRequestTrueBlock=reference to procedure (Sender:TObject;Value:string);
  TNetEngineDataRequestFailBlock=reference to procedure (Sender:TObject;Value:string);

  TNetEngineClientConnectFail=procedure (Sender:TObject) of object;
  //procedure OnNetEngineClientConnectFail(Sender:TObject);
  TNetEngineClientConnectEror=procedure (Sender:TObject;Error:string) of object;
  //procedure OnNetEngineClientConnectEror(Sender:TObject;Error:string);


  TNetEngineUrlsHandleEvent  =procedure (Params:string;DataSrv:TRtcDataServer) of object;

  TNetEngineUrlsHandle = class(TObject)
  public
    FileName:string;
    ClasName:string;
    InMethod:string;

    //#UrlEvent:TNetEngineUrlsHandleEvent;
    CallBack:TRttiMethod;
  end;

  TNetEngineUrlAttribute = class(TCustomAttribute)
  private
    FFileName:string;
    FNetField:string;
  public
    constructor Create(const AFileName:string);overload;
    constructor Create(const AFileName,ANetField: string);overload;
  published
    property FileName :string  read FFileName write FFileName;
    property NetField :string  read FNetField write FNetField;
  end;

  url = TNetEngineUrlAttribute;


  TNetEngine=class(TObject)
  private
    FRtcHttpClient :TRtcHttpClient;
    FRtcDataRequest:TRtcDataRequest;

  private
    FCallBack      :TNetEngineCallBack;
    FListUrls      :THashedStringList;//*
    FListClas      :THashedStringList;//*
    FListMark      :THashedStringList;//*
  protected
    procedure RtcDataRequestBeginRequest(Sender: TRtcConnection);
    procedure RtcDataRequestDataReceived(Sender: TRtcConnection);

    procedure HttpClientConnectFail(Sender: TRtcConnection);
    procedure HttpClientConnectEror(Sender: TRtcConnection; E: Exception);
  public
    OnNetEngineDataRequestTrueEvent:TNetEngineDataRequestTrueEvent;
    OnNetEngineDataRequestFailEvent:TNetEngineDataRequestFailEvent;

    OnNetEngineDataRequestTrueBlock:TNetEngineDataRequestTrueBlock;
    OnNetEngineDataRequestFailBlock:TNetEngineDataRequestFailBlock;
  public
    function  Initialize(ASrvrAddr,ASrvrPort:string):Boolean;overload;
  protected
    //@procedure PushUrls(AUrls:string;AHandle:TNetEngineUrlsHandleEvent);overload;
    procedure PushUrls(AClas,AUrls,ACall:string;AMethod:TRttiMethod);overload;

    //@function  PullUrls(Value:Integer):TNetEngineUrlsHandle;overload;
    function  PullObjt(Value:string):TObject;
  public
    function  HaveUrls(AUrls:string):Integer;
    procedure PushUrls(AObject:TObject)overload;
    function  CallUrls(FileName:string;Params:string;Origin:string):string;
  public
    function  PullMark(AMark:string):TUniConnection;
  public
    //#procedure Post(AFileName:string);overload;
    //#procedure Post(AFileName:string;trueBlock:TNetEngineDataRequestTrueBlock;failBlock:TNetEngineDataRequestFailBlock);overload;

    procedure Post(AFileName:string;AParams:array of string);overload;
    procedure Post(AFileName:string;AParams:array of string;trueBlock:TNetEngineDataRequestTrueBlock;failBlock:TNetEngineDataRequestFailBlock);overload;
  published
    //@property  CallBack:TNetEngineCallBack read FCallBack write FCallBack;
  public
    constructor Create;
    destructor Destroy; override;
  public
    class procedure InRead(Origin:string;var AList:TStrings);
  end;

var
  NetEngineEx:TNetEngine;

implementation

uses
  Class_KzUtils,Helpr_UniEngine,Class_KzDebug,Class_EROR;


{ TNetEngine }

function TNetEngine.CallUrls(FileName, Params: string;Origin:string): string;
var
  IDXA:Integer;
  SVAL:string;
  IVAL:Integer;

  Instance:TObject;

  Handle:TNetEngineUrlsHandle;

  R:TRttiContext;
  T:TRttiType;
  M:TRttiMethod;
begin
  IDXA:=FListUrls.IndexOfName(FileName);
  if IDXA=-1 then
  begin
    Exit(TEROR.ToEROR(Format('URL:%S NOT FOUND',[FileName])));
  end;
  Handle:=TNetEngineUrlsHandle(FListUrls.Objects[IDXA]);
  if Handle=nil then
  begin
    Exit(TEROR.ToEROR(Format('HDL:%S NOT FOUND',[FileName])));
  end;

  SVAL:=FListUrls.ValueFromIndex[IDXA];
  IVAL:=FListClas.IndexOf(SVAL);
  if IVAL=-1 then
  begin
    Exit(TEROR.ToEROR(Format('CLS:%S NOT FOUND',[FileName])));
  end;
  Instance:=FListClas.Objects[IVAL];

  T:=R.GetType(Instance.ClassInfo);
  M:=T.GetMethod(Handle.InMethod);

  //#KzDebug.FileLog(m.Name);
  KzDebug.FileFmt('%S:%S:%D:%S',[Self.ClassName,m.Name,Length(m.GetParameters),Origin]);
  try
    case Length(m.GetParameters) of
      1:Result:=M.Invoke(Instance.ClassType,[Params]).AsString;
      2:Result:=M.Invoke(Instance.ClassType,[Params,Origin]).AsString;
    end;
  except
    on E:Exception do
    begin
      Result:=TEROR.ToEROR(E.Message);
    end;
  end;
end;

constructor TNetEngine.Create;
begin
  FRtcHttpClient :=TRtcHttpClient.Create(nil);
  FRtcHttpClient.ServerAddr:='192.168.0.51';
  FRtcHttpClient.ServerPort:='8186';

  FRtcHttpClient.OnConnectFail :=HttpClientConnectFail;
  FRtcHttpClient.OnConnectError:=HttpClientConnectEror;


  FRtcDataRequest:=TRtcDataRequest.Create(nil);
  FRtcDataRequest.Client:=FRtcHttpClient;
  FRtcDataRequest.OnBeginRequest:=RtcDataRequestBeginRequest;
  FRtcDataRequest.OnDataReceived:=RtcDataRequestDataReceived;

  FListUrls:=THashedStringList.Create;
  FListClas:=THashedStringList.Create;
  FListMark:=THashedStringList.Create;
end;

destructor TNetEngine.Destroy;
begin
  if FRtcHttpClient<>nil then
  begin
    if FRtcHttpClient.isConnecting then
    begin
      FRtcHttpClient.Disconnect;
    end;
    FreeAndNil(FRtcHttpClient);
  end;
  if FRtcDataRequest<>nil then
  begin
    FreeAndNil(FRtcDataRequest);
  end;

  if FListUrls<>nil then TKzUtils.TryFreeAndNil(FListUrls);
  if FListClas<>nil then TKzUtils.TryFreeAndNil(FListClas);
  if FListMark<>nil then TKzUtils.TryFreeAndNil(FListMark);
  
  inherited;
end;

function TNetEngine.HaveUrls(AUrls: string): Integer;
begin
  Result:=FListUrls.IndexOfName(LowerCase(AUrls));
end;

procedure TNetEngine.HttpClientConnectEror(Sender: TRtcConnection;
  E: Exception);
var
  DataClient:TRtcDataClient absolute Sender;
begin
  if FCallBack=necbEvent then
  begin
    if Assigned(OnNetEngineDataRequestFailEvent) then
    begin
      OnNetEngineDataRequestFailEvent(nil,Format('HttpClientConnectEror:%S',[E.Message]));
    end;
  end else
  if FCallBack=necbBlock then
  begin
    if Assigned(OnNetEngineDataRequestFailBlock) then
    begin
      OnNetEngineDataRequestFailBlock(nil,Format('HttpClientConnectEror:%S',[E.Message]));
      FCallBack:=necbEvent;
    end;
  end;
end;

procedure TNetEngine.HttpClientConnectFail(Sender: TRtcConnection);
var
  DataClient:TRtcDataClient absolute Sender;
begin
  if FCallBack=necbEvent then
  begin
    if Assigned(OnNetEngineDataRequestFailEvent) then
    begin
      OnNetEngineDataRequestFailEvent(nil,'HttpClientConnectFail');
    end;
  end else
  if FCallBack=necbBlock then
  begin
    if Assigned(OnNetEngineDataRequestFailBlock) then
    begin
      OnNetEngineDataRequestFailBlock(nil,'HttpClientConnectFail');
      FCallBack:=necbEvent;
    end;
  end;
end;

function  TNetEngine.Initialize(ASrvrAddr, ASrvrPort:string):Boolean;
begin
  Result:=False;

  FRtcHttpClient.ServerAddr:=ASrvrAddr;
  FRtcHttpClient.ServerPort:=ASrvrPort;

  Result:=True;
end;


class procedure TNetEngine.InRead(Origin: string; var AList: TStrings);
begin
  if AList=nil then Exit;
  AList.Clear;

  TKzUtils.ListStrCutted(Origin,'\&',AList);
  KzDebug.FileFmt('%S:%S',[Self.ClassName,AList.Text]);
end;

{procedure TNetEngine.Post(AFileName: string;
  trueBlock: TNetEngineDataRequestTrueBlock;
  failBlock: TNetEngineDataRequestFailBlock);
begin
  OnNetEngineDataRequestTrueBlock:=trueBlock;
  OnNetEngineDataRequestFailBlock:=failBlock;
  FCallBack:=necbBlock;

  Post(AFileName);
end;}

procedure TNetEngine.Post(AFileName: string; AParams: array of string);
var
  I:Integer;
  Len:Integer;
begin
  if (Length(AParams) mod 2)<>0 then
  begin
    raise Exception.Create('函数调用出错,[Length(AParams) Mod 2 <> 0]');
  end;
  Len:=Length(AParams) div 2;

  FRtcHttpClient.Connect();
  FRtcDataRequest.Request.FileName:=AFileName;

  for I := 1 to Len do
  begin
    FRtcDataRequest.Request.Params[AParams[I*2-2]]:=AParams[I*2-1];
  end;
  FRtcDataRequest.Post();
end;

{procedure TNetEngine.Post(AFileName: string);
begin
  FRtcHttpClient.Connect();

  FRtcDataRequest.Request.FileName:=AFileName;
  FRtcDataRequest.Post();
end;}

procedure TNetEngine.RtcDataRequestBeginRequest(Sender: TRtcConnection);
var
  DataClient:TRtcDataClient absolute Sender;
begin
  if DataClient.Request.Params.ItemCount=0 then
  begin
    DataClient.WriteHeader();
  end else
  begin
    DataClient.Write(DataClient.Request.Params.Text);
  end;
end;

procedure TNetEngine.RtcDataRequestDataReceived(Sender: TRtcConnection);
var
  DataClient:TRtcDataClient absolute Sender;
begin
  if DataClient.Response.Done then
  begin
    if FCallBack=necbEvent then
    begin
      if Assigned(OnNetEngineDataRequestTrueEvent) then
      begin
        OnNetEngineDataRequestTrueEvent(DataClient,DataClient.Read);
      end;
    end else
    if FCallBack=necbBlock then    
    begin
      if Assigned(OnNetEngineDataRequestTrueBlock) then
      begin
        OnNetEngineDataRequestTrueBlock(DataClient,DataClient.Read);
        FCallBack:=necbEvent;
      end;
    end;
  end;
end;

procedure TNetEngine.Post(AFileName: string; AParams: array of string;
  trueBlock: TNetEngineDataRequestTrueBlock;
  failBlock: TNetEngineDataRequestFailBlock);
begin
  OnNetEngineDataRequestTrueBlock:=trueBlock;
  OnNetEngineDataRequestFailBlock:=failBlock;
  FCallBack:=necbBlock;

  Post(AFileName,AParams);
end;

function TNetEngine.PullMark(AMark: string): TUniConnection;
var
  IDXA:Integer;
  UniConnct:TUniConnection;
begin
  IDXA:=FListMark.IndexOf(AMark);
  if IDXA=-1 then
  begin
    UniConnct:=UniConnctEx.GetConnection(AMark);
    IDXA:=FListMark.AddObject(AMark,UniConnct);
  end;

  Result:=TUniConnection(FListMark.Objects[IDXA]);
end;

function TNetEngine.PullObjt(Value: string): TObject;
begin
  if FListClas.IndexOf(Value)<>-1 then
  begin
    Result:=TObject(FListClas.Objects[FListClas.IndexOf(Value)])
  end;
end;

{function TNetEngine.PullUrls(Value: Integer): TNetEngineUrlsHandle;
begin
  Result:=TNetEngineUrlsHandle(FListUrls.Objects[Value]);
end;}

procedure TNetEngine.PushUrls(AClas,AUrls,ACall: string; AMethod: TRttiMethod);
var
  IDXA:Integer;

  UrlHandle:TNetEngineUrlsHandle;
begin
  if HaveUrls(AUrls)<>-1 then Exit;

  UrlHandle:=TNetEngineUrlsHandle.Create;
  UrlHandle.FileName:=AUrls;
  UrlHandle.ClasName:=AClas;
  UrlHandle.InMethod:=ACall;
  UrlHandle.CallBack:=AMethod;
  //#UrlHandle.UrlEvent:=AHandle;

  FListUrls.AddObject(Format('%S=%S',[UrlHandle.FileName,UrlHandle.ClasName]),UrlHandle);
end;

procedure TNetEngine.PushUrls(AObject: TObject);
var
  R: TRttiContext;
  T: TRttiType;
  P: TRttiProperty;
  C: TCustomAttribute;
  F: TRttiField;
  M: TRttiMethod;

  ClasName:string;
  FileName:string;
begin
  T:=R.GetType(AObject.ClassInfo);
  for C in T.GetAttributes do
  begin
    if C is TNetEngineUrlAttribute then
    begin
      ClasName:=TNetEngineUrlAttribute(C).FileName;
      FListClas.AddObject(ClasName,AObject);
    end;
  end;
  if ClasName.IsEmpty then
  begin
    raise Exception.CreateFmt('%s:the root url is not pointed.',[AObject.ClassName]);
  end;

  for M in T.GetMethods do
  begin
    //#KzDebug.FileLog(m.Name);
    for C in M.GetAttributes do
    begin
      if C is TNetEngineUrlAttribute then
      begin
        FileName:=TNetEngineUrlAttribute(C).FileName;
        PushUrls(ClasName,FileName,M.Name,M);
      end;
    end;
  end;

  KzDebug.FileFmt('haveurls:%S',[FListUrls.Text]);
end;

{procedure TNetEngine.PushUrls(AUrls: string;
  AHandle: TNetEngineUrlsHandleEvent);
var
  IDXA:Integer;

  UrlHandle:TNetEngineUrlsHandle;
begin
  if HaveUrls(AUrls)<>-1 then Exit;

  UrlHandle:=TNetEngineUrlsHandle.Create;
  UrlHandle.FileName:=AUrls;
  UrlHandle.UrlEvent:=AHandle;

  FListUrls.AddObject(UrlHandle.FileName,UrlHandle);
end;}

constructor TNetEngineUrlAttribute.Create(const AFileName: string);
begin
  FileName := AFileName;
end;

constructor TNetEngineUrlAttribute.Create(const AFileName, ANetField: string);
begin
  FileName := AFileName;
  NetField := NetField;
end;

initialization
begin
  NetEngineEx:=TNetEngine.Create;
end;
finalization
begin
  FreeAndNil(NetEngineEx);
end;
end.
