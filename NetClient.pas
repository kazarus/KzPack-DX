unit NetClient;


interface
uses
  System.Classes, System.SysUtils, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.Net.URLClient, Class_EROR,
  System.NetEncoding, System.Net.Mime;

type
  TNetClientResult = (ncrErrorEd, ncrFailure, ncrSuccess);

  TNetClientDataRequestTrueBlock = reference to procedure(Sender: TObject; Value: string);
  TNetClientDataRequestFailBlock = reference to procedure(Sender: TObject; Value: string);

  TNetClient=class(TObject)
  private
    FNhClient: TNetHTTPClient;
  private
    FSrvrAddr: string;
    FSrvrPort: string;

    FInUseTLS: Boolean;
    FInUseZIP: Boolean;
  private
    FValue: string;
    FError: string;
  private
    OnNetClientDataRequestTrueBlock:TNetClientDataRequestTrueBlock;
    OnNetClientDataRequestFailBlock:TNetClientDataRequestFailBlock;
    procedure OnRequestError(const Sender: TObject; const AError: string);
    procedure OnValidateServerCertificate(const Sender: TObject; const ARequest: TURLRequest; const Certificate: TCertificate; var Accepted: Boolean);
  protected
    procedure SetValue(aValue:string);
    procedure SetError(aValue:string);
  public
    function  Initialize(aSrvrAddr, aSrvrPort: string; InUseZIP: Boolean = False; InUseTLS: Boolean = False): Boolean;
    procedure setTimeOut(aConnTimeOut: Integer = 60000; aRespTimeOut: Integer = 60000);
  public
    function  Post(aFileName: string; aUrlParam: array of string): TNetClientResult; overload;
    function  Post(aFileName: string; aUrlParam: array of string; trueBlock: TNetClientDataRequestTrueBlock; failBlock: TNetClientDataRequestFailBlock): TNetClientResult; overload;

    function  PostFmt(aFileName: string; Params: array of const; aUrlParam: array of string): TNetClientResult; overload;
  public
    function  Post(aFileName: string; aMultipartFormData: TMultipartFormData): TNetClientResult; overload;
    function  Post(aFileName: string; aMultipartFormData: TMultipartFormData; trueBlock: TNetClientDataRequestTrueBlock; failBlock: TNetClientDataRequestFailBlock): TNetClientResult; overload;
  published
    property  Value:string  read FValue write SetValue;
    property  Error:string  read FError write SetError;
  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  NetClientEx:TNetClient;

implementation

uses
  Class_KzUtils;


constructor TNetClient.Create;
begin
  FNhClient:=TNetHTTPClient.Create(nil);
  FNhClient.ConnectionTimeout := 1000;
  FNhClient.ResponseTimeout   := 60 * 1000 * 60;

  FNhClient.OnRequestError             :=self.OnRequestError;
  FNhClient.OnValidateServerCertificate:=self.OnValidateServerCertificate;
end;

destructor TNetClient.Destroy;
begin
  if FNhClient <> nil then FreeAndNil(FNhClient);

  inherited;
end;

function TNetClient.Initialize(aSrvrAddr, aSrvrPort: string; InUseZIP, InUseTLS: Boolean): Boolean;
begin
  Result := False;

  self.FSrvrAddr := aSrvrAddr;
  self.FSrvrPort := aSrvrPort;
  self.FInUseTLS := InUseTLS;
  self.FInUseZIP := InUseZIP;

  Result := True;
end;

function TNetClient.Post(aFileName: string; aUrlParam: array of string; trueBlock: TNetClientDataRequestTrueBlock; failBlock: TNetClientDataRequestFailBlock): TNetClientResult;
var
  I: Integer;

  cCount: Integer;
  ToUrls: string;
  Params: TStringList;

  Return: IHTTPResponse;
begin
  Result := ncrErrorEd;

  self.OnNetClientDataRequestTrueBlock := trueBlock;
  self.OnNetClientDataRequestFailBlock := failBlock;


  if (Length(aUrlParam) mod 2)<>0 then
  begin
    raise Exception.Create('函数调用出错,[Length(aUrlParam) Mod 2 <> 0]');
  end;

  if FInUseTLS then
  begin
    ToUrls := Format('https://%S:%S%S', [FSrvrAddr, FSrvrPort, aFileName]);
  end else
  begin
    ToUrls := Format('http://%S:%S%S', [FSrvrAddr, FSrvrPort, aFileName]);
  end;

  try
    Params := TStringList.Create;

    cCount:=Length(aUrlParam) div 2;
    for I := 1 to cCount do
    begin
      //#Params.Add(Format('%S=%S',[aUrlParam[I*2-2],aUrlParam[I*2-1]]));
      Params.Add(Format('%S=%S',[aUrlParam[I*2-2],System.NetEncoding.TNetEncoding.URL.Encode(aUrlParam[I*2-1])]));
    end;

    //#KzDebug.FileFmt('%S:%S',[self.ClassName,params.Text]);
    FError := '';
    Result := ncrErrorEd;

    try
      Return := self.FNhClient.Post(ToUrls, Params);
    except
      on E:Exception do
      begin
        FError := E.Message;
      end;
    end;

    if Return <> nil then
    begin
      FValue := Return.ContentAsString;
      if TEROR.IsTRUE(FValue) then
      begin
        Result := ncrSuccess;
      end else
      begin
        FError := TEROR.erMemo(FValue);
        Result := ncrFailure;
      end;
    end;
  finally
    FreeAndNil(Params);
  end;
end;

function TNetClient.Post(aFileName: string; aMultipartFormData: TMultipartFormData; trueBlock: TNetClientDataRequestTrueBlock; failBlock: TNetClientDataRequestFailBlock): TNetClientResult;
var
  //#I: Integer;
  //#cCount: Integer;
  ToUrls: string;
  //#Params: TStringList;

  Return: IHTTPResponse;
begin
  Result := ncrErrorEd;

  self.OnNetClientDataRequestTrueBlock := trueBlock;
  self.OnNetClientDataRequestFailBlock := failBlock;


  {if (Length(aUrlParam) mod 2)<>0 then
  begin
    raise Exception.Create('函数调用出错,[Length(aUrlParam) Mod 2 <> 0]');
  end;}

  if FInUseTLS then
  begin
    ToUrls := Format('https://%S:%S%S', [FSrvrAddr, FSrvrPort, aFileName]);
  end else
  begin
    ToUrls := Format('http://%S:%S%S', [FSrvrAddr, FSrvrPort, aFileName]);
  end;

  try
    {Params := TStringList.Create;

    cCount:=Length(aUrlParam) div 2;
    for I := 1 to cCount do
    begin
      //#Params.Add(Format('%S=%S',[aUrlParam[I*2-2],aUrlParam[I*2-1]]));
      Params.Add(Format('%S=%S',[aUrlParam[I*2-2],System.NetEncoding.TNetEncoding.URL.Encode(aUrlParam[I*2-1])]));
    end;
    KzDebug.FileFmt('%S:%S',[self.ClassName,params.Text]);}

    FError := '';
    Result := ncrErrorEd;

    try
      Return := self.FNhClient.Post(ToUrls, aMultipartFormData);
    except
      on E:Exception do
      begin
        Error := E.Message;
      end;
    end;

    if Return <> nil then
    begin
      FValue := Return.ContentAsString;
      if TEROR.IsTRUE(FValue) then
      begin
        Result := ncrSuccess;
      end else
      begin
        FError := TEROR.erMemo(FValue);
        Result := ncrFailure;
      end;
    end;
  finally
    //#FreeAndNil(Params);
  end;
end;

function TNetClient.Post(aFileName: string; aMultipartFormData: TMultipartFormData): TNetClientResult;
begin
  Result := Post(aFileName, aMultipartFormData, nil, nil);
end;

function TNetClient.PostFmt(aFileName: string; Params: array of const; aUrlParam: array of string): TNetClientResult;
begin
  Result := Post(Format(aFileName,Params), aUrlParam, nil, nil);
end;

procedure TNetClient.OnRequestError(const Sender: TObject; const AError: string);
begin
  FError := Format('OnRequestError:%s', [AError]);
end;

procedure TNetClient.OnValidateServerCertificate(const Sender: TObject; const ARequest: TURLRequest; const Certificate: TCertificate; var Accepted: Boolean);
begin
  Accepted := True;
end;

procedure TNetClient.SetError(aValue: string);
begin
  raise Exception.Create('ERROR:NetClient.pas.TNetClient.SetValue.LINE:143.INFO:PROPERTY READ ONLY');
end;

procedure TNetClient.SetValue(aValue: string);
begin
  raise Exception.Create('ERROR:NetClient.pas.TNetClient.SetValue.LINE:143.INFO:PROPERTY READ ONLY');
end;

procedure TNetClient.setTimeOut(aConnTimeOut, aRespTimeOut: Integer);
begin
  //#FNhClient.ConnectionTimeout:=aConnTimeOut;
  //#FNhClient.ResponseTimeout  :=aRespTimeOut;
end;

function TNetClient.Post(aFileName: string; aUrlParam: array of string): TNetClientResult;
begin
  Result := Post(aFileName, aUrlParam, nil, nil);
end;

initialization
begin
  NetClientEx := TNetClient.Create;
end;

finalization
begin
  if NetClientEx <> nil then FreeAndNil(NetClientEx);
end;

end.
