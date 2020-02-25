unit SVS_SOFT_COMLib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 2012-10-22 12:59:11 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\WINDOWS\system32\svs_soft_com.dll (1)
// LIBID: {E53C2885-0912-404E-8579-6C1EA76DC72E}
// LCID: 0
// Helpfile: 
// HelpString: svs_soft_com 1.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Errors:
//   Error creating palette bitmap of (TSvsVerify) : Server C:\WINDOWS\system32\svs_soft_com.dll contains no icons
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SVS_SOFT_COMLibMajorVersion = 1;
  SVS_SOFT_COMLibMinorVersion = 0;

  LIBID_SVS_SOFT_COMLib: TGUID = '{E53C2885-0912-404E-8579-6C1EA76DC72E}';

  IID_ISvsVerify: TGUID = '{4B6FB33E-F079-447B-B43F-47B12FF3B39E}';
  CLASS_SvsVerify: TGUID = '{1E4F9525-A541-4053-B6D4-178A899B9D6F}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISvsVerify = interface;
  ISvsVerifyDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  SvsVerify = ISvsVerify;


// *********************************************************************//
// Interface: ISvsVerify
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4B6FB33E-F079-447B-B43F-47B12FF3B39E}
// *********************************************************************//
  ISvsVerify = interface(IDispatch)
    ['{4B6FB33E-F079-447B-B43F-47B12FF3B39E}']
    function FinalizeVerify(hContext: Integer): Integer; safecall;
    function VerifyCert(const bstrB64Cert: WideString; nFlagOCSP: Integer; nFlagCRL: Integer; 
                        hContext: Integer): Integer; safecall;
    function VerifySign(nSignType: Integer; nSignStytle: Integer; const bstrOriginData: WideString; 
                        nOriginLength: Integer; const bstrB64Cert: WideString; 
                        const bstrB64SignedData: WideString; hContext: Integer): Integer; safecall;
    function VerifyCertSign(nSignType: Integer; nSignStytle: Integer; 
                            const bstrOriginData: WideString; nOriginLength: Integer; 
                            const bstrB64Cert: WideString; const bstrB64SignedData: WideString; 
                            nFlagCRL: Integer; hContext: Integer): Integer; safecall;
    function VerifyHashSign(const bstrOriginHashData: WideString; const bstrB64Cert: WideString; 
                            const bstrB64SignedData: WideString; iVerifyFlag: Integer; 
                            hContext: Integer): Integer; safecall;
    function GetCertInfo(const bstrB64Cert: WideString; nType: Integer; 
                         const bstrItemName: WideString; hContext: Integer): Integer; safecall;
    function PKCS7DataSign(const bstrOriginData: WideString; nOriginDataLen: Integer; 
                           hContext: Integer): Integer; safecall;
    function PKCS7DataVerify(const bstrPKCS7B64Data: WideString; const bstrOriginData: WideString; 
                             nOriginDataLen: Integer; hContext: Integer): Integer; safecall;
    function PKCS7DetachDataSign(const bstrOriginData: WideString; nOriginDataLen: Integer; 
                                 hContext: Integer): Integer; safecall;
    function PKCS7DetachDataVerify(const bstrPKCS7B64Data: WideString; 
                                   const bstrOriginData: WideString; nOriginDataLen: Integer; 
                                   hContext: Integer): Integer; safecall;
    function PKCS7DataVerifyGetOriData(const bstrPKCS7B64Data: WideString; 
                                       const bstrOriginData: WideString; nOriginDataLen: Integer; 
                                       hContext: Integer): Integer; safecall;
    function SignData(nSignType: Integer; const bstrOriginData: WideString; 
                      nOriginDataLen: Integer; hContext: Integer): Integer; safecall;
    function SignFile(nSignType: Integer; const bstrFile: WideString; nSignAlgo: Integer; 
                      hContext: Integer): Integer; safecall;
    function VerifyFile(nSignType: Integer; nSignAlgo: Integer; const bstrFile: WideString; 
                        const bstrB64Cert: WideString; const bstrB64SignedData: WideString; 
                        nVerifyFlag: Integer; hContext: Integer): Integer; safecall;
    function VerifyLdapCertSign(nSignType: Integer; nSignAlgo: Integer; 
                                const bstrOriginData: WideString; nOriginLength: Integer; 
                                const bstrFilter: WideString; const bstrB64SignedData: WideString; 
                                nVerifyFlag: Integer; hContext: Integer): Integer; safecall;
    function DecodeEnvelopeFile(const bstrSrcFile: WideString; const bstrDstFile: WideString; 
                                hContext: Integer): Integer; safecall;
    function InitialVerify(const bstrIP: WideString; nPort: Integer): Integer; safecall;
    function Get_GetB64Cert: WideString; safecall;
    function Get_GetB64SignedData: WideString; safecall;
    function Get_GetCertItem: WideString; safecall;
    function Get_GetOriginData: WideString; safecall;
    property GetB64Cert: WideString read Get_GetB64Cert;
    property GetB64SignedData: WideString read Get_GetB64SignedData;
    property GetCertItem: WideString read Get_GetCertItem;
    property GetOriginData: WideString read Get_GetOriginData;
  end;

// *********************************************************************//
// DispIntf:  ISvsVerifyDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4B6FB33E-F079-447B-B43F-47B12FF3B39E}
// *********************************************************************//
  ISvsVerifyDisp = dispinterface
    ['{4B6FB33E-F079-447B-B43F-47B12FF3B39E}']
    function FinalizeVerify(hContext: Integer): Integer; dispid 2;
    function VerifyCert(const bstrB64Cert: WideString; nFlagOCSP: Integer; nFlagCRL: Integer; 
                        hContext: Integer): Integer; dispid 3;
    function VerifySign(nSignType: Integer; nSignStytle: Integer; const bstrOriginData: WideString; 
                        nOriginLength: Integer; const bstrB64Cert: WideString; 
                        const bstrB64SignedData: WideString; hContext: Integer): Integer; dispid 4;
    function VerifyCertSign(nSignType: Integer; nSignStytle: Integer; 
                            const bstrOriginData: WideString; nOriginLength: Integer; 
                            const bstrB64Cert: WideString; const bstrB64SignedData: WideString; 
                            nFlagCRL: Integer; hContext: Integer): Integer; dispid 5;
    function VerifyHashSign(const bstrOriginHashData: WideString; const bstrB64Cert: WideString; 
                            const bstrB64SignedData: WideString; iVerifyFlag: Integer; 
                            hContext: Integer): Integer; dispid 6;
    function GetCertInfo(const bstrB64Cert: WideString; nType: Integer; 
                         const bstrItemName: WideString; hContext: Integer): Integer; dispid 7;
    function PKCS7DataSign(const bstrOriginData: WideString; nOriginDataLen: Integer; 
                           hContext: Integer): Integer; dispid 8;
    function PKCS7DataVerify(const bstrPKCS7B64Data: WideString; const bstrOriginData: WideString; 
                             nOriginDataLen: Integer; hContext: Integer): Integer; dispid 9;
    function PKCS7DetachDataSign(const bstrOriginData: WideString; nOriginDataLen: Integer; 
                                 hContext: Integer): Integer; dispid 10;
    function PKCS7DetachDataVerify(const bstrPKCS7B64Data: WideString; 
                                   const bstrOriginData: WideString; nOriginDataLen: Integer; 
                                   hContext: Integer): Integer; dispid 11;
    function PKCS7DataVerifyGetOriData(const bstrPKCS7B64Data: WideString; 
                                       const bstrOriginData: WideString; nOriginDataLen: Integer; 
                                       hContext: Integer): Integer; dispid 12;
    function SignData(nSignType: Integer; const bstrOriginData: WideString; 
                      nOriginDataLen: Integer; hContext: Integer): Integer; dispid 13;
    function SignFile(nSignType: Integer; const bstrFile: WideString; nSignAlgo: Integer; 
                      hContext: Integer): Integer; dispid 14;
    function VerifyFile(nSignType: Integer; nSignAlgo: Integer; const bstrFile: WideString; 
                        const bstrB64Cert: WideString; const bstrB64SignedData: WideString; 
                        nVerifyFlag: Integer; hContext: Integer): Integer; dispid 15;
    function VerifyLdapCertSign(nSignType: Integer; nSignAlgo: Integer; 
                                const bstrOriginData: WideString; nOriginLength: Integer; 
                                const bstrFilter: WideString; const bstrB64SignedData: WideString; 
                                nVerifyFlag: Integer; hContext: Integer): Integer; dispid 16;
    function DecodeEnvelopeFile(const bstrSrcFile: WideString; const bstrDstFile: WideString; 
                                hContext: Integer): Integer; dispid 17;
    function InitialVerify(const bstrIP: WideString; nPort: Integer): Integer; dispid 18;
    property GetB64Cert: WideString readonly dispid 19;
    property GetB64SignedData: WideString readonly dispid 20;
    property GetCertItem: WideString readonly dispid 21;
    property GetOriginData: WideString readonly dispid 22;
  end;

// *********************************************************************//
// The Class CoSvsVerify provides a Create and CreateRemote method to          
// create instances of the default interface ISvsVerify exposed by              
// the CoClass SvsVerify. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSvsVerify = class
    class function Create: ISvsVerify;
    class function CreateRemote(const MachineName: string): ISvsVerify;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSvsVerify
// Help String      : SvsVerify Class
// Default Interface: ISvsVerify
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TSvsVerifyProperties= class;
{$ENDIF}
  TSvsVerify = class(TOleServer)
  private
    FIntf:        ISvsVerify;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TSvsVerifyProperties;
    function      GetServerProperties: TSvsVerifyProperties;
{$ENDIF}
    function      GetDefaultInterface: ISvsVerify;
  protected
    procedure InitServerData; override;
    function Get_GetB64Cert: WideString;
    function Get_GetB64SignedData: WideString;
    function Get_GetCertItem: WideString;
    function Get_GetOriginData: WideString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ISvsVerify);
    procedure Disconnect; override;
    function FinalizeVerify(hContext: Integer): Integer;
    function VerifyCert(const bstrB64Cert: WideString; nFlagOCSP: Integer; nFlagCRL: Integer; 
                        hContext: Integer): Integer;
    function VerifySign(nSignType: Integer; nSignStytle: Integer; const bstrOriginData: WideString; 
                        nOriginLength: Integer; const bstrB64Cert: WideString; 
                        const bstrB64SignedData: WideString; hContext: Integer): Integer;
    function VerifyCertSign(nSignType: Integer; nSignStytle: Integer; 
                            const bstrOriginData: WideString; nOriginLength: Integer; 
                            const bstrB64Cert: WideString; const bstrB64SignedData: WideString; 
                            nFlagCRL: Integer; hContext: Integer): Integer;
    function VerifyHashSign(const bstrOriginHashData: WideString; const bstrB64Cert: WideString; 
                            const bstrB64SignedData: WideString; iVerifyFlag: Integer; 
                            hContext: Integer): Integer;
    function GetCertInfo(const bstrB64Cert: WideString; nType: Integer; 
                         const bstrItemName: WideString; hContext: Integer): Integer;
    function PKCS7DataSign(const bstrOriginData: WideString; nOriginDataLen: Integer; 
                           hContext: Integer): Integer;
    function PKCS7DataVerify(const bstrPKCS7B64Data: WideString; const bstrOriginData: WideString; 
                             nOriginDataLen: Integer; hContext: Integer): Integer;
    function PKCS7DetachDataSign(const bstrOriginData: WideString; nOriginDataLen: Integer; 
                                 hContext: Integer): Integer;
    function PKCS7DetachDataVerify(const bstrPKCS7B64Data: WideString; 
                                   const bstrOriginData: WideString; nOriginDataLen: Integer; 
                                   hContext: Integer): Integer;
    function PKCS7DataVerifyGetOriData(const bstrPKCS7B64Data: WideString; 
                                       const bstrOriginData: WideString; nOriginDataLen: Integer; 
                                       hContext: Integer): Integer;
    function SignData(nSignType: Integer; const bstrOriginData: WideString; 
                      nOriginDataLen: Integer; hContext: Integer): Integer;
    function SignFile(nSignType: Integer; const bstrFile: WideString; nSignAlgo: Integer; 
                      hContext: Integer): Integer;
    function VerifyFile(nSignType: Integer; nSignAlgo: Integer; const bstrFile: WideString; 
                        const bstrB64Cert: WideString; const bstrB64SignedData: WideString; 
                        nVerifyFlag: Integer; hContext: Integer): Integer;
    function VerifyLdapCertSign(nSignType: Integer; nSignAlgo: Integer; 
                                const bstrOriginData: WideString; nOriginLength: Integer; 
                                const bstrFilter: WideString; const bstrB64SignedData: WideString; 
                                nVerifyFlag: Integer; hContext: Integer): Integer;
    function DecodeEnvelopeFile(const bstrSrcFile: WideString; const bstrDstFile: WideString; 
                                hContext: Integer): Integer;
    function InitialVerify(const bstrIP: WideString; nPort: Integer): Integer;
    property DefaultInterface: ISvsVerify read GetDefaultInterface;
    property GetB64Cert: WideString read Get_GetB64Cert;
    property GetB64SignedData: WideString read Get_GetB64SignedData;
    property GetCertItem: WideString read Get_GetCertItem;
    property GetOriginData: WideString read Get_GetOriginData;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TSvsVerifyProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TSvsVerify
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TSvsVerifyProperties = class(TPersistent)
  private
    FServer:    TSvsVerify;
    function    GetDefaultInterface: ISvsVerify;
    constructor Create(AServer: TSvsVerify);
  protected
    function Get_GetB64Cert: WideString;
    function Get_GetB64SignedData: WideString;
    function Get_GetCertItem: WideString;
    function Get_GetOriginData: WideString;
  public
    property DefaultInterface: ISvsVerify read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoSvsVerify.Create: ISvsVerify;
begin
  Result := CreateComObject(CLASS_SvsVerify) as ISvsVerify;
end;

class function CoSvsVerify.CreateRemote(const MachineName: string): ISvsVerify;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SvsVerify) as ISvsVerify;
end;

procedure TSvsVerify.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{1E4F9525-A541-4053-B6D4-178A899B9D6F}';
    IntfIID:   '{4B6FB33E-F079-447B-B43F-47B12FF3B39E}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSvsVerify.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ISvsVerify;
  end;
end;

procedure TSvsVerify.ConnectTo(svrIntf: ISvsVerify);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSvsVerify.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSvsVerify.GetDefaultInterface: ISvsVerify;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TSvsVerify.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TSvsVerifyProperties.Create(Self);
{$ENDIF}
end;

destructor TSvsVerify.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TSvsVerify.GetServerProperties: TSvsVerifyProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TSvsVerify.Get_GetB64Cert: WideString;
begin
    Result := DefaultInterface.GetB64Cert;
end;

function TSvsVerify.Get_GetB64SignedData: WideString;
begin
    Result := DefaultInterface.GetB64SignedData;
end;

function TSvsVerify.Get_GetCertItem: WideString;
begin
    Result := DefaultInterface.GetCertItem;
end;

function TSvsVerify.Get_GetOriginData: WideString;
begin
    Result := DefaultInterface.GetOriginData;
end;

function TSvsVerify.FinalizeVerify(hContext: Integer): Integer;
begin
  Result := DefaultInterface.FinalizeVerify(hContext);
end;

function TSvsVerify.VerifyCert(const bstrB64Cert: WideString; nFlagOCSP: Integer; 
                               nFlagCRL: Integer; hContext: Integer): Integer;
begin
  Result := DefaultInterface.VerifyCert(bstrB64Cert, nFlagOCSP, nFlagCRL, hContext);
end;

function TSvsVerify.VerifySign(nSignType: Integer; nSignStytle: Integer; 
                               const bstrOriginData: WideString; nOriginLength: Integer; 
                               const bstrB64Cert: WideString; const bstrB64SignedData: WideString; 
                               hContext: Integer): Integer;
begin
  Result := DefaultInterface.VerifySign(nSignType, nSignStytle, bstrOriginData, nOriginLength, 
                                        bstrB64Cert, bstrB64SignedData, hContext);
end;

function TSvsVerify.VerifyCertSign(nSignType: Integer; nSignStytle: Integer; 
                                   const bstrOriginData: WideString; nOriginLength: Integer; 
                                   const bstrB64Cert: WideString; 
                                   const bstrB64SignedData: WideString; nFlagCRL: Integer; 
                                   hContext: Integer): Integer;
begin
  Result := DefaultInterface.VerifyCertSign(nSignType, nSignStytle, bstrOriginData, nOriginLength, 
                                            bstrB64Cert, bstrB64SignedData, nFlagCRL, hContext);
end;

function TSvsVerify.VerifyHashSign(const bstrOriginHashData: WideString; 
                                   const bstrB64Cert: WideString; 
                                   const bstrB64SignedData: WideString; iVerifyFlag: Integer; 
                                   hContext: Integer): Integer;
begin
  Result := DefaultInterface.VerifyHashSign(bstrOriginHashData, bstrB64Cert, bstrB64SignedData, 
                                            iVerifyFlag, hContext);
end;

function TSvsVerify.GetCertInfo(const bstrB64Cert: WideString; nType: Integer; 
                                const bstrItemName: WideString; hContext: Integer): Integer;
begin
  Result := DefaultInterface.GetCertInfo(bstrB64Cert, nType, bstrItemName, hContext);
end;

function TSvsVerify.PKCS7DataSign(const bstrOriginData: WideString; nOriginDataLen: Integer; 
                                  hContext: Integer): Integer;
begin
  Result := DefaultInterface.PKCS7DataSign(bstrOriginData, nOriginDataLen, hContext);
end;

function TSvsVerify.PKCS7DataVerify(const bstrPKCS7B64Data: WideString; 
                                    const bstrOriginData: WideString; nOriginDataLen: Integer; 
                                    hContext: Integer): Integer;
begin
  Result := DefaultInterface.PKCS7DataVerify(bstrPKCS7B64Data, bstrOriginData, nOriginDataLen, 
                                             hContext);
end;

function TSvsVerify.PKCS7DetachDataSign(const bstrOriginData: WideString; nOriginDataLen: Integer; 
                                        hContext: Integer): Integer;
begin
  Result := DefaultInterface.PKCS7DetachDataSign(bstrOriginData, nOriginDataLen, hContext);
end;

function TSvsVerify.PKCS7DetachDataVerify(const bstrPKCS7B64Data: WideString; 
                                          const bstrOriginData: WideString; 
                                          nOriginDataLen: Integer; hContext: Integer): Integer;
begin
  Result := DefaultInterface.PKCS7DetachDataVerify(bstrPKCS7B64Data, bstrOriginData, 
                                                   nOriginDataLen, hContext);
end;

function TSvsVerify.PKCS7DataVerifyGetOriData(const bstrPKCS7B64Data: WideString; 
                                              const bstrOriginData: WideString; 
                                              nOriginDataLen: Integer; hContext: Integer): Integer;
begin
  Result := DefaultInterface.PKCS7DataVerifyGetOriData(bstrPKCS7B64Data, bstrOriginData, 
                                                       nOriginDataLen, hContext);
end;

function TSvsVerify.SignData(nSignType: Integer; const bstrOriginData: WideString; 
                             nOriginDataLen: Integer; hContext: Integer): Integer;
begin
  Result := DefaultInterface.SignData(nSignType, bstrOriginData, nOriginDataLen, hContext);
end;

function TSvsVerify.SignFile(nSignType: Integer; const bstrFile: WideString; nSignAlgo: Integer; 
                             hContext: Integer): Integer;
begin
  Result := DefaultInterface.SignFile(nSignType, bstrFile, nSignAlgo, hContext);
end;

function TSvsVerify.VerifyFile(nSignType: Integer; nSignAlgo: Integer; const bstrFile: WideString; 
                               const bstrB64Cert: WideString; const bstrB64SignedData: WideString; 
                               nVerifyFlag: Integer; hContext: Integer): Integer;
begin
  Result := DefaultInterface.VerifyFile(nSignType, nSignAlgo, bstrFile, bstrB64Cert, 
                                        bstrB64SignedData, nVerifyFlag, hContext);
end;

function TSvsVerify.VerifyLdapCertSign(nSignType: Integer; nSignAlgo: Integer; 
                                       const bstrOriginData: WideString; nOriginLength: Integer; 
                                       const bstrFilter: WideString; 
                                       const bstrB64SignedData: WideString; nVerifyFlag: Integer; 
                                       hContext: Integer): Integer;
begin
  Result := DefaultInterface.VerifyLdapCertSign(nSignType, nSignAlgo, bstrOriginData, 
                                                nOriginLength, bstrFilter, bstrB64SignedData, 
                                                nVerifyFlag, hContext);
end;

function TSvsVerify.DecodeEnvelopeFile(const bstrSrcFile: WideString; 
                                       const bstrDstFile: WideString; hContext: Integer): Integer;
begin
  Result := DefaultInterface.DecodeEnvelopeFile(bstrSrcFile, bstrDstFile, hContext);
end;

function TSvsVerify.InitialVerify(const bstrIP: WideString; nPort: Integer): Integer;
begin
  Result := DefaultInterface.InitialVerify(bstrIP, nPort);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TSvsVerifyProperties.Create(AServer: TSvsVerify);
begin
  inherited Create;
  FServer := AServer;
end;

function TSvsVerifyProperties.GetDefaultInterface: ISvsVerify;
begin
  Result := FServer.DefaultInterface;
end;

function TSvsVerifyProperties.Get_GetB64Cert: WideString;
begin
    Result := DefaultInterface.GetB64Cert;
end;

function TSvsVerifyProperties.Get_GetB64SignedData: WideString;
begin
    Result := DefaultInterface.GetB64SignedData;
end;

function TSvsVerifyProperties.Get_GetCertItem: WideString;
begin
    Result := DefaultInterface.GetCertItem;
end;

function TSvsVerifyProperties.Get_GetOriginData: WideString;
begin
    Result := DefaultInterface.GetOriginData;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TSvsVerify]);
end;

end.
