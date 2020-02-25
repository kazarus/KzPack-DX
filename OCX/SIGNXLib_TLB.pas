unit SIGNXLib_TLB;

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
// File generated on 2018-06-12 10:08:28 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Windows\SysWow64\SignX_nbpp.ocx (1)
// LIBID: {E5C74C9F-2FD2-4056-B7BB-73A710FA3961}
// LCID: 0
// Helpfile: C:\Windows\SysWow64\SignX.hlp
// HelpString: SignX ActiveX Control module
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SIGNXLibMajorVersion = 1;
  SIGNXLibMinorVersion = 0;

  LIBID_SIGNXLib: TGUID = '{E5C74C9F-2FD2-4056-B7BB-73A710FA3961}';

  DIID__DSignX: TGUID = '{225FD165-6CA7-4543-AE64-43E8CA41261B}';
  DIID__DSignXEvents: TGUID = '{C7597018-9471-4A7A-8F64-1E9F5C86D93A}';
  CLASS_SignX: TGUID = '{03F5B3D4-98BC-4B92-9719-681772AAD5DD}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _DSignX = dispinterface;
  _DSignXEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  SignX = _DSignX;


// *********************************************************************//
// DispIntf:  _DSignX
// Flags:     (4112) Hidden Dispatchable
// GUID:      {225FD165-6CA7-4543-AE64-43E8CA41261B}
// *********************************************************************//
  _DSignX = dispinterface
    ['{225FD165-6CA7-4543-AE64-43E8CA41261B}']
    property CodeType: Integer dispid 1;
    function GetLastErrorCode: Integer; dispid 2;
    function GetLastErrorString: WideString; dispid 3;
    function GetSignResult: WideString; dispid 4;
    function SetCertByCN(const strCertCN: WideString): Integer; dispid 5;
    function SetCertBySN(const strCertSN: WideString): Integer; dispid 6;
    function SelectCert: Integer; dispid 7;
    function HashData(varData: OleVariant; lHashAlgorithm: Integer): Integer; dispid 8;
    function HashFile(const strFileName: WideString; lHashAlgorithm: Integer): Integer; dispid 9;
    function Sign(varData: OleVariant; lHashAlgorithm: Integer): Integer; dispid 10;
    function GetHashResult: WideString; dispid 11;
    function B64Encode(varData: OleVariant): Integer; dispid 12;
    function GetB64EncodeResult: WideString; dispid 13;
    function SignFile(const strFileName: WideString; lHashAlgorithm: Integer): Integer; dispid 14;
    function GetCurrentUsedCertInfo(lID: Integer): WideString; dispid 15;
    function SignPKCS7(varData: OleVariant; lHashAlgorithm: Integer): Integer; dispid 16;
    function VerifyPKCS7Sign(varData: OleVariant): Integer; dispid 17;
    function GetPKCS7OriginData(varData: OleVariant): WideString; dispid 18;
    function GetB64DecodeResult(lType: Integer): OleVariant; dispid 19;
    function Reset: Integer; dispid 20;
    function ShowDataBeforeSign(lShowData: Integer): Integer; dispid 21;
    function SetSelectCertDialogMode(nMode: Integer): Integer; dispid 22;
    function SealEnvelope(varData: OleVariant; const pszB64Cert: WideString; lCryptAlg: Integer): Integer; dispid 23;
    function OpenEnvelope(const pszB64Data: WideString): Integer; dispid 24;
    function GetSealEnvelopeData: WideString; dispid 25;
    function GetEnvelopeData(lType: Integer): OleVariant; dispid 26;
    function GetCertExtensionInfoByOID(const szOID: WideString; lOIDType: Integer): WideString; dispid 27;
    function GetOIDFriendlyName(const szOID: WideString): WideString; dispid 28;
    function SetSelectCertMode(lCertType: Integer): Integer; dispid 29;
    function GetEnCryptResult: OleVariant; dispid 30;
    function GetDeCryptResult(lType: Integer): OleVariant; dispid 31;
    function GetLastCryptFileName: WideString; dispid 32;
    function GetLastCryptPassword: WideString; dispid 33;
    function SignHash(varData: OleVariant; lHashAlgorithm: Integer): Integer; dispid 34;
    function EnCrypt(varData: OleVariant; const szPasswd: WideString; lCryptAlgorithm: Integer): Integer; dispid 35;
    function DeCrypt(varData: OleVariant; const szPassword: WideString; lCryptAlgorithm: Integer): Integer; dispid 36;
    function StartEnumCert(const strStore: WideString): Integer; dispid 37;
    function GetNextCert: Integer; dispid 38;
    function SetSelectCertIssuerCN(const strCN: WideString): Integer; dispid 39;
    function StopEnumCert: Integer; dispid 40;
    function SetCertPin(const strPasswd: WideString): Integer; dispid 41;
    function SetEnableKeyNotify(lEnable: Integer): Integer; dispid 42;
    function VerifyCurrentCert: Integer; dispid 43;
    function GetPKCS7Cert(varData: OleVariant): WideString; dispid 44;
    function ParsePFXFile(const strFilePath: WideString; const szPassword: WideString): Integer; dispid 45;
    function ParseCertFile(const strFilePath: WideString): Integer; dispid 46;
    function ImportCerFile(const strStore: WideString; const strFilePath: WideString): Integer; dispid 47;
    function ImportPFXFile(const strStore: WideString; const strFilePath: WideString; 
                           const strPassword: WideString): Integer; dispid 48;
    function DelCertBySn(const strSn: WideString): Integer; dispid 49;
    function SetDelStoreName(const strStore: WideString): Integer; dispid 50;
    procedure SleepMircoSecond(lMicroSecond: Integer); dispid 51;
    function GetCertKeyProv: WideString; dispid 52;
    function B64Decode(const strB64Str: WideString): Integer; dispid 53;
    function SelectPFXCert(const strFilePath: WideString; const szPasswd: WideString; 
                           lSaveFlag: Integer): Integer; dispid 54;
    function EnCryptFile(const szlnFileName: WideString; const szOutFileName: WideString; 
                         const szPassword: WideString; lCryptAlgorithm: Integer): Integer; dispid 55;
    function DeCryptFile(const szlnFileName: WideString; const szOutFileName: WideString; 
                         const szPassword: WideString; lCryptAlgorithm: Integer): Integer; dispid 56;
    function SetCertByB64(const strB64Code: WideString): Integer; dispid 57;
    function VerifyCertByB64(const strB64CertContent: WideString; lVerifyCrl: Integer): Integer; dispid 58;
    function VerifyCertByFile(const strFile: WideString; lVerifyCrl: Integer): Integer; dispid 59;
    function VerifySign(varOriginData: OleVariant; varSignData: OleVariant; 
                        const strB64CertContent: WideString; lHashAlgorithm: Integer; 
                        lVerifyCert: Integer): Integer; dispid 60;
  end;

// *********************************************************************//
// DispIntf:  _DSignXEvents
// Flags:     (4096) Dispatchable
// GUID:      {C7597018-9471-4A7A-8F64-1E9F5C86D93A}
// *********************************************************************//
  _DSignXEvents = dispinterface
    ['{C7597018-9471-4A7A-8F64-1E9F5C86D93A}']
    procedure OnEvenKeyStateNotify(lKeyType: Integer; lMsg: Integer); dispid 1;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TSignX
// Help String      : SignX Control
// Default Interface: _DSignX
// Def. Intf. DISP? : Yes
// Event   Interface: _DSignXEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TSignXOnEvenKeyStateNotify = procedure(ASender: TObject; lKeyType: Integer; lMsg: Integer) of object;

  TSignX = class(TOleControl)
  private
    FOnEvenKeyStateNotify: TSignXOnEvenKeyStateNotify;
    FIntf: _DSignX;
    function  GetControlInterface: _DSignX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function GetLastErrorCode: Integer;
    function GetLastErrorString: WideString;
    function GetSignResult: WideString;
    function SetCertByCN(const strCertCN: WideString): Integer;
    function SetCertBySN(const strCertSN: WideString): Integer;
    function SelectCert: Integer;
    function HashData(varData: OleVariant; lHashAlgorithm: Integer): Integer;
    function HashFile(const strFileName: WideString; lHashAlgorithm: Integer): Integer;
    function Sign(varData: OleVariant; lHashAlgorithm: Integer): Integer;
    function GetHashResult: WideString;
    function B64Encode(varData: OleVariant): Integer;
    function GetB64EncodeResult: WideString;
    function SignFile(const strFileName: WideString; lHashAlgorithm: Integer): Integer;
    function GetCurrentUsedCertInfo(lID: Integer): WideString;
    function SignPKCS7(varData: OleVariant; lHashAlgorithm: Integer): Integer;
    function VerifyPKCS7Sign(varData: OleVariant): Integer;
    function GetPKCS7OriginData(varData: OleVariant): WideString;
    function GetB64DecodeResult(lType: Integer): OleVariant;
    function Reset: Integer;
    function ShowDataBeforeSign(lShowData: Integer): Integer;
    function SetSelectCertDialogMode(nMode: Integer): Integer;
    function SealEnvelope(varData: OleVariant; const pszB64Cert: WideString; lCryptAlg: Integer): Integer;
    function OpenEnvelope(const pszB64Data: WideString): Integer;
    function GetSealEnvelopeData: WideString;
    function GetEnvelopeData(lType: Integer): OleVariant;
    function GetCertExtensionInfoByOID(const szOID: WideString; lOIDType: Integer): WideString;
    function GetOIDFriendlyName(const szOID: WideString): WideString;
    function SetSelectCertMode(lCertType: Integer): Integer;
    function GetEnCryptResult: OleVariant;
    function GetDeCryptResult(lType: Integer): OleVariant;
    function GetLastCryptFileName: WideString;
    function GetLastCryptPassword: WideString;
    function SignHash(varData: OleVariant; lHashAlgorithm: Integer): Integer;
    function EnCrypt(varData: OleVariant; const szPasswd: WideString; lCryptAlgorithm: Integer): Integer;
    function DeCrypt(varData: OleVariant; const szPassword: WideString; lCryptAlgorithm: Integer): Integer;
    function StartEnumCert(const strStore: WideString): Integer;
    function GetNextCert: Integer;
    function SetSelectCertIssuerCN(const strCN: WideString): Integer;
    function StopEnumCert: Integer;
    function SetCertPin(const strPasswd: WideString): Integer;
    function SetEnableKeyNotify(lEnable: Integer): Integer;
    function VerifyCurrentCert: Integer;
    function GetPKCS7Cert(varData: OleVariant): WideString;
    function ParsePFXFile(const strFilePath: WideString; const szPassword: WideString): Integer;
    function ParseCertFile(const strFilePath: WideString): Integer;
    function ImportCerFile(const strStore: WideString; const strFilePath: WideString): Integer;
    function ImportPFXFile(const strStore: WideString; const strFilePath: WideString; 
                           const strPassword: WideString): Integer;
    function DelCertBySn(const strSn: WideString): Integer;
    function SetDelStoreName(const strStore: WideString): Integer;
    procedure SleepMircoSecond(lMicroSecond: Integer);
    function GetCertKeyProv: WideString;
    function B64Decode(const strB64Str: WideString): Integer;
    function SelectPFXCert(const strFilePath: WideString; const szPasswd: WideString; 
                           lSaveFlag: Integer): Integer;
    function EnCryptFile(const szlnFileName: WideString; const szOutFileName: WideString; 
                         const szPassword: WideString; lCryptAlgorithm: Integer): Integer;
    function DeCryptFile(const szlnFileName: WideString; const szOutFileName: WideString; 
                         const szPassword: WideString; lCryptAlgorithm: Integer): Integer;
    function SetCertByB64(const strB64Code: WideString): Integer;
    function VerifyCertByB64(const strB64CertContent: WideString; lVerifyCrl: Integer): Integer;
    function VerifyCertByFile(const strFile: WideString; lVerifyCrl: Integer): Integer;
    function VerifySign(varOriginData: OleVariant; varSignData: OleVariant; 
                        const strB64CertContent: WideString; lHashAlgorithm: Integer; 
                        lVerifyCert: Integer): Integer;
    property  ControlInterface: _DSignX read GetControlInterface;
    property  DefaultInterface: _DSignX read GetControlInterface;
  published
    property Anchors;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property CodeType: Integer index 1 read GetIntegerProp write SetIntegerProp stored False;
    property OnEvenKeyStateNotify: TSignXOnEvenKeyStateNotify read FOnEvenKeyStateNotify write FOnEvenKeyStateNotify;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TSignX.InitControlData;
const
  CEventDispIDs: array [0..0] of DWORD = (
    $00000001);
  CControlData: TControlData2 = (
    ClassID: '{03F5B3D4-98BC-4B92-9719-681772AAD5DD}';
    EventIID: '{C7597018-9471-4A7A-8F64-1E9F5C86D93A}';
    EventCount: 1;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnEvenKeyStateNotify) - Cardinal(Self);
end;

procedure TSignX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DSignX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TSignX.GetControlInterface: _DSignX;
begin
  CreateControl;
  Result := FIntf;
end;

function TSignX.GetLastErrorCode: Integer;
begin
  Result := DefaultInterface.GetLastErrorCode;
end;

function TSignX.GetLastErrorString: WideString;
begin
  Result := DefaultInterface.GetLastErrorString;
end;

function TSignX.GetSignResult: WideString;
begin
  Result := DefaultInterface.GetSignResult;
end;

function TSignX.SetCertByCN(const strCertCN: WideString): Integer;
begin
  Result := DefaultInterface.SetCertByCN(strCertCN);
end;

function TSignX.SetCertBySN(const strCertSN: WideString): Integer;
begin
  Result := DefaultInterface.SetCertBySN(strCertSN);
end;

function TSignX.SelectCert: Integer;
begin
  Result := DefaultInterface.SelectCert;
end;

function TSignX.HashData(varData: OleVariant; lHashAlgorithm: Integer): Integer;
begin
  Result := DefaultInterface.HashData(varData, lHashAlgorithm);
end;

function TSignX.HashFile(const strFileName: WideString; lHashAlgorithm: Integer): Integer;
begin
  Result := DefaultInterface.HashFile(strFileName, lHashAlgorithm);
end;

function TSignX.Sign(varData: OleVariant; lHashAlgorithm: Integer): Integer;
begin
  Result := DefaultInterface.Sign(varData, lHashAlgorithm);
end;

function TSignX.GetHashResult: WideString;
begin
  Result := DefaultInterface.GetHashResult;
end;

function TSignX.B64Encode(varData: OleVariant): Integer;
begin
  Result := DefaultInterface.B64Encode(varData);
end;

function TSignX.GetB64EncodeResult: WideString;
begin
  Result := DefaultInterface.GetB64EncodeResult;
end;

function TSignX.SignFile(const strFileName: WideString; lHashAlgorithm: Integer): Integer;
begin
  Result := DefaultInterface.SignFile(strFileName, lHashAlgorithm);
end;

function TSignX.GetCurrentUsedCertInfo(lID: Integer): WideString;
begin
  Result := DefaultInterface.GetCurrentUsedCertInfo(lID);
end;

function TSignX.SignPKCS7(varData: OleVariant; lHashAlgorithm: Integer): Integer;
begin
  Result := DefaultInterface.SignPKCS7(varData, lHashAlgorithm);
end;

function TSignX.VerifyPKCS7Sign(varData: OleVariant): Integer;
begin
  Result := DefaultInterface.VerifyPKCS7Sign(varData);
end;

function TSignX.GetPKCS7OriginData(varData: OleVariant): WideString;
begin
  Result := DefaultInterface.GetPKCS7OriginData(varData);
end;

function TSignX.GetB64DecodeResult(lType: Integer): OleVariant;
begin
  Result := DefaultInterface.GetB64DecodeResult(lType);
end;

function TSignX.Reset: Integer;
begin
  Result := DefaultInterface.Reset;
end;

function TSignX.ShowDataBeforeSign(lShowData: Integer): Integer;
begin
  Result := DefaultInterface.ShowDataBeforeSign(lShowData);
end;

function TSignX.SetSelectCertDialogMode(nMode: Integer): Integer;
begin
  Result := DefaultInterface.SetSelectCertDialogMode(nMode);
end;

function TSignX.SealEnvelope(varData: OleVariant; const pszB64Cert: WideString; lCryptAlg: Integer): Integer;
begin
  Result := DefaultInterface.SealEnvelope(varData, pszB64Cert, lCryptAlg);
end;

function TSignX.OpenEnvelope(const pszB64Data: WideString): Integer;
begin
  Result := DefaultInterface.OpenEnvelope(pszB64Data);
end;

function TSignX.GetSealEnvelopeData: WideString;
begin
  Result := DefaultInterface.GetSealEnvelopeData;
end;

function TSignX.GetEnvelopeData(lType: Integer): OleVariant;
begin
  Result := DefaultInterface.GetEnvelopeData(lType);
end;

function TSignX.GetCertExtensionInfoByOID(const szOID: WideString; lOIDType: Integer): WideString;
begin
  Result := DefaultInterface.GetCertExtensionInfoByOID(szOID, lOIDType);
end;

function TSignX.GetOIDFriendlyName(const szOID: WideString): WideString;
begin
  Result := DefaultInterface.GetOIDFriendlyName(szOID);
end;

function TSignX.SetSelectCertMode(lCertType: Integer): Integer;
begin
  Result := DefaultInterface.SetSelectCertMode(lCertType);
end;

function TSignX.GetEnCryptResult: OleVariant;
begin
  Result := DefaultInterface.GetEnCryptResult;
end;

function TSignX.GetDeCryptResult(lType: Integer): OleVariant;
begin
  Result := DefaultInterface.GetDeCryptResult(lType);
end;

function TSignX.GetLastCryptFileName: WideString;
begin
  Result := DefaultInterface.GetLastCryptFileName;
end;

function TSignX.GetLastCryptPassword: WideString;
begin
  Result := DefaultInterface.GetLastCryptPassword;
end;

function TSignX.SignHash(varData: OleVariant; lHashAlgorithm: Integer): Integer;
begin
  Result := DefaultInterface.SignHash(varData, lHashAlgorithm);
end;

function TSignX.EnCrypt(varData: OleVariant; const szPasswd: WideString; lCryptAlgorithm: Integer): Integer;
begin
  Result := DefaultInterface.EnCrypt(varData, szPasswd, lCryptAlgorithm);
end;

function TSignX.DeCrypt(varData: OleVariant; const szPassword: WideString; lCryptAlgorithm: Integer): Integer;
begin
  Result := DefaultInterface.DeCrypt(varData, szPassword, lCryptAlgorithm);
end;

function TSignX.StartEnumCert(const strStore: WideString): Integer;
begin
  Result := DefaultInterface.StartEnumCert(strStore);
end;

function TSignX.GetNextCert: Integer;
begin
  Result := DefaultInterface.GetNextCert;
end;

function TSignX.SetSelectCertIssuerCN(const strCN: WideString): Integer;
begin
  Result := DefaultInterface.SetSelectCertIssuerCN(strCN);
end;

function TSignX.StopEnumCert: Integer;
begin
  Result := DefaultInterface.StopEnumCert;
end;

function TSignX.SetCertPin(const strPasswd: WideString): Integer;
begin
  Result := DefaultInterface.SetCertPin(strPasswd);
end;

function TSignX.SetEnableKeyNotify(lEnable: Integer): Integer;
begin
  Result := DefaultInterface.SetEnableKeyNotify(lEnable);
end;

function TSignX.VerifyCurrentCert: Integer;
begin
  Result := DefaultInterface.VerifyCurrentCert;
end;

function TSignX.GetPKCS7Cert(varData: OleVariant): WideString;
begin
  Result := DefaultInterface.GetPKCS7Cert(varData);
end;

function TSignX.ParsePFXFile(const strFilePath: WideString; const szPassword: WideString): Integer;
begin
  Result := DefaultInterface.ParsePFXFile(strFilePath, szPassword);
end;

function TSignX.ParseCertFile(const strFilePath: WideString): Integer;
begin
  Result := DefaultInterface.ParseCertFile(strFilePath);
end;

function TSignX.ImportCerFile(const strStore: WideString; const strFilePath: WideString): Integer;
begin
  Result := DefaultInterface.ImportCerFile(strStore, strFilePath);
end;

function TSignX.ImportPFXFile(const strStore: WideString; const strFilePath: WideString; 
                              const strPassword: WideString): Integer;
begin
  Result := DefaultInterface.ImportPFXFile(strStore, strFilePath, strPassword);
end;

function TSignX.DelCertBySn(const strSn: WideString): Integer;
begin
  Result := DefaultInterface.DelCertBySn(strSn);
end;

function TSignX.SetDelStoreName(const strStore: WideString): Integer;
begin
  Result := DefaultInterface.SetDelStoreName(strStore);
end;

procedure TSignX.SleepMircoSecond(lMicroSecond: Integer);
begin
  DefaultInterface.SleepMircoSecond(lMicroSecond);
end;

function TSignX.GetCertKeyProv: WideString;
begin
  Result := DefaultInterface.GetCertKeyProv;
end;

function TSignX.B64Decode(const strB64Str: WideString): Integer;
begin
  Result := DefaultInterface.B64Decode(strB64Str);
end;

function TSignX.SelectPFXCert(const strFilePath: WideString; const szPasswd: WideString; 
                              lSaveFlag: Integer): Integer;
begin
  Result := DefaultInterface.SelectPFXCert(strFilePath, szPasswd, lSaveFlag);
end;

function TSignX.EnCryptFile(const szlnFileName: WideString; const szOutFileName: WideString; 
                            const szPassword: WideString; lCryptAlgorithm: Integer): Integer;
begin
  Result := DefaultInterface.EnCryptFile(szlnFileName, szOutFileName, szPassword, lCryptAlgorithm);
end;

function TSignX.DeCryptFile(const szlnFileName: WideString; const szOutFileName: WideString; 
                            const szPassword: WideString; lCryptAlgorithm: Integer): Integer;
begin
  Result := DefaultInterface.DeCryptFile(szlnFileName, szOutFileName, szPassword, lCryptAlgorithm);
end;

function TSignX.SetCertByB64(const strB64Code: WideString): Integer;
begin
  Result := DefaultInterface.SetCertByB64(strB64Code);
end;

function TSignX.VerifyCertByB64(const strB64CertContent: WideString; lVerifyCrl: Integer): Integer;
begin
  Result := DefaultInterface.VerifyCertByB64(strB64CertContent, lVerifyCrl);
end;

function TSignX.VerifyCertByFile(const strFile: WideString; lVerifyCrl: Integer): Integer;
begin
  Result := DefaultInterface.VerifyCertByFile(strFile, lVerifyCrl);
end;

function TSignX.VerifySign(varOriginData: OleVariant; varSignData: OleVariant; 
                           const strB64CertContent: WideString; lHashAlgorithm: Integer; 
                           lVerifyCert: Integer): Integer;
begin
  Result := DefaultInterface.VerifySign(varOriginData, varSignData, strB64CertContent, 
                                        lHashAlgorithm, lVerifyCert);
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TSignX]);
end;

end.
