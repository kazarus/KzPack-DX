unit eloamComLib_TLB;

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

// $Rev: 52393 $
// File generated on 2019-08-24 12:11:57 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files (x86)\eloamCom_2.2\bin\eloamCom.dll (1)
// LIBID: {99CC0897-9C50-4621-AB70-7BAF8DB96AF2}
// LCID: 0
// Helpfile: 
// HelpString: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// Errors:
//   Hint: Parameter 'type' of _IEloamGlobalEvents.DevChange changed to 'type_'
//   Hint: Parameter 'type' of _IEloamGlobalEvents.Reader changed to 'type_'
//   Hint: Parameter 'type' of _IEloamGlobalEvents.MagneticCard changed to 'type_'
//   Hint: Parameter 'type' of IEloamGlobal.GetDevCount changed to 'type_'
//   Hint: Parameter 'type' of IEloamGlobal.GetDisplayName changed to 'type_'
//   Hint: Parameter 'type' of IEloamGlobal.GetFriendlyName changed to 'type_'
//   Hint: Parameter 'type' of IEloamGlobal.GetEloamType changed to 'type_'
//   Hint: Parameter 'type' of IEloamGlobal.CreateDevice changed to 'type_'
//   Hint: Parameter 'type' of IEloamGlobal.MagneticCardGetData changed to 'type_'
//   Hint: Parameter 'type' of IEloamGlobal.ReaderGetQuickPassData changed to 'type_'
//   Hint: Parameter 'record' of IEloamGlobal.CpuGetankCardRecord changed to 'record_'
//   Hint: Parameter 'type' of IEloamGlobal.ReaderGetSocialCardData changed to 'type_'
//   Hint: Parameter 'type' of IEloamTempl.AppendField changed to 'type_'
//   Error creating palette bitmap of (TEloamImage) : Server C:\Program Files (x86)\eloamCom_2.2\bin\eloamCom.dll contains no icons
//   Error creating palette bitmap of (TEloamImageList) : Server C:\Program Files (x86)\eloamCom_2.2\bin\eloamCom.dll contains no icons
//   Error creating palette bitmap of (TEloamMemory) : Server C:\Program Files (x86)\eloamCom_2.2\bin\eloamCom.dll contains no icons
//   Error creating palette bitmap of (TEloamGlobal) : Server C:\Program Files (x86)\eloamCom_2.2\bin\eloamCom.dll contains no icons
//   Error creating palette bitmap of (TEloamDevice) : Server C:\Program Files (x86)\eloamCom_2.2\bin\eloamCom.dll contains no icons
//   Error creating palette bitmap of (TEloamHttp) : Server C:\Program Files (x86)\eloamCom_2.2\bin\eloamCom.dll contains no icons
//   Error creating palette bitmap of (TEloamFtp) : Server C:\Program Files (x86)\eloamCom_2.2\bin\eloamCom.dll contains no icons
//   Error creating palette bitmap of (TEloamVideo) : Server C:\Program Files (x86)\eloamCom_2.2\bin\eloamCom.dll contains no icons
//   Error creating palette bitmap of (TEloamRect) : Server C:\Program Files (x86)\eloamCom_2.2\bin\eloamCom.dll contains no icons
//   Error creating palette bitmap of (TEloamFont) : Server C:\Program Files (x86)\eloamCom_2.2\bin\eloamCom.dll contains no icons
//   Error creating palette bitmap of (TEloamTempl) : Server C:\Program Files (x86)\eloamCom_2.2\bin\eloamCom.dll contains no icons
//   Error creating palette bitmap of (TEloamVideoCap) : Server C:\Program Files (x86)\eloamCom_2.2\bin\eloamCom.dll contains no icons
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleCtrls, Vcl.OleServer, Winapi.ActiveX;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  eloamComLibMajorVersion = 1;
  eloamComLibMinorVersion = 0;

  LIBID_eloamComLib: TGUID = '{99CC0897-9C50-4621-AB70-7BAF8DB96AF2}';

  IID_IEloamImage: TGUID = '{798BE982-270F-4308-9CD3-F6A246A4B605}';
  CLASS_EloamImage: TGUID = '{7F389AE8-9F25-437E-A0FF-027163C32731}';
  IID_IEloamImageList: TGUID = '{EC7F059B-C267-453C-9B53-9C4D25BB41DB}';
  CLASS_EloamImageList: TGUID = '{E51007C6-9DBE-47E7-BD74-F488F31BFE7C}';
  IID_IEloamMemory: TGUID = '{DE530A7B-9659-4902-A6AD-C0E554835496}';
  CLASS_EloamMemory: TGUID = '{8C474F0F-6C27-4339-815E-BAB9DE163224}';
  DIID__IEloamGlobalEvents: TGUID = '{013E7698-EC43-4AD1-930B-2B4AF28339B1}';
  IID_IEloamGlobal: TGUID = '{B93B9CBA-CD08-4E6E-BAED-6457F4E3FC5D}';
  CLASS_EloamGlobal: TGUID = '{52D1E686-D8D7-4DF2-9A74-8B8F4650BF73}';
  IID_IEloamDevice: TGUID = '{25519945-1DE4-484F-98AB-03D923F23B2C}';
  CLASS_EloamDevice: TGUID = '{33097953-5F00-44C6-8080-F0E91F1F8074}';
  IID_IEloamHttp: TGUID = '{145448B4-3E23-4B63-8626-2F476DCB1D66}';
  CLASS_EloamHttp: TGUID = '{FF57BABA-6F55-429F-BDDA-004433545E8B}';
  IID_IEloamFtp: TGUID = '{0C36E18A-6483-43C7-98CC-63B71729C092}';
  CLASS_EloamFtp: TGUID = '{906BE504-A92B-41CF-96A3-3F93FD688CDB}';
  IID_IEloamVideo: TGUID = '{3176B9F7-557E-480E-997C-36B5F44CCA49}';
  CLASS_EloamVideo: TGUID = '{53EA3520-6591-4307-B0F6-C774F071D488}';
  DIID__IEloamViewEvents: TGUID = '{F6F49968-91A3-4CD5-A866-6ED1216DDA22}';
  IID_IEloamView: TGUID = '{86AD2C9D-DF2E-4F66-88DE-9FF72D451902}';
  CLASS_EloamView: TGUID = '{26BA9E7F-78E9-4FB8-A05C-A4185D80D759}';
  DIID__IEloamThumbnailEvents: TGUID = '{1B5A8EFF-4DB5-4669-BE19-9ADCB2B1086E}';
  IID_IEloamThumbnail: TGUID = '{C4FEA87D-519B-41E0-BC9D-18F8F3B7C714}';
  CLASS_EloamThumbnail: TGUID = '{B5535A1B-D25B-4B3C-854F-94B12E284A4E}';
  IID_IEloamRect: TGUID = '{5535094B-659B-4CF7-B137-80D47CC5F09E}';
  CLASS_EloamRect: TGUID = '{CCA81C37-D773-438A-A012-BFCA1ABDF1F4}';
  IID_IEloamFont: TGUID = '{5AE529AC-DC9B-4302-AD18-25345168D61F}';
  CLASS_EloamFont: TGUID = '{E7B4E568-3220-404A-8162-40AD462F8ECC}';
  IID_IEloamTempl: TGUID = '{1B5B6E01-2D99-4D1A-ABE9-0C2109F0AB35}';
  CLASS_EloamTempl: TGUID = '{6DE227A8-CA19-4743-ACEC-979E5A4A09F9}';
  IID_IEloamVideoCap: TGUID = '{7F495A96-C99E-4719-9657-0D1652F4E9D8}';
  CLASS_EloamVideoCap: TGUID = '{5E155920-EF13-4C5B-A225-DB6AD2866A89}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IEloamImage = interface;
  IEloamImageDisp = dispinterface;
  IEloamImageList = interface;
  IEloamImageListDisp = dispinterface;
  IEloamMemory = interface;
  IEloamMemoryDisp = dispinterface;
  _IEloamGlobalEvents = dispinterface;
  IEloamGlobal = interface;
  IEloamGlobalDisp = dispinterface;
  IEloamDevice = interface;
  IEloamDeviceDisp = dispinterface;
  IEloamHttp = interface;
  IEloamHttpDisp = dispinterface;
  IEloamFtp = interface;
  IEloamFtpDisp = dispinterface;
  IEloamVideo = interface;
  IEloamVideoDisp = dispinterface;
  _IEloamViewEvents = dispinterface;
  IEloamView = interface;
  IEloamViewDisp = dispinterface;
  _IEloamThumbnailEvents = dispinterface;
  IEloamThumbnail = interface;
  IEloamThumbnailDisp = dispinterface;
  IEloamRect = interface;
  IEloamRectDisp = dispinterface;
  IEloamFont = interface;
  IEloamFontDisp = dispinterface;
  IEloamTempl = interface;
  IEloamTemplDisp = dispinterface;
  IEloamVideoCap = interface;
  IEloamVideoCapDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  EloamImage = IEloamImage;
  EloamImageList = IEloamImageList;
  EloamMemory = IEloamMemory;
  EloamGlobal = IEloamGlobal;
  EloamDevice = IEloamDevice;
  EloamHttp = IEloamHttp;
  EloamFtp = IEloamFtp;
  EloamVideo = IEloamVideo;
  EloamView = IEloamView;
  EloamThumbnail = IEloamThumbnail;
  EloamRect = IEloamRect;
  EloamFont = IEloamFont;
  EloamTempl = IEloamTempl;
  EloamVideoCap = IEloamVideoCap;


// *********************************************************************//
// Interface: IEloamImage
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {798BE982-270F-4308-9CD3-F6A246A4B605}
// *********************************************************************//
  IEloamImage = interface(IDispatch)
    ['{798BE982-270F-4308-9CD3-F6A246A4B605}']
    function Destroy: WordBool; safecall;
    function CreateMemory(fmt: Integer; flag: Integer): IDispatch; safecall;
    function Copy(const pImage: IDispatch): WordBool; safecall;
    function Save(const fileName: WideString; flag: Integer): WordBool; safecall;
    function SaveToPDF(fmt: Integer; const fileName: WideString; flag: Integer): WordBool; safecall;
    function SetDiscernRect(const pRect: IDispatch): WordBool; safecall;
    function Print(x: Single; y: Single; width: Single; height: Single; const printer: WideString): WordBool; safecall;
    function GetWidth: Integer; safecall;
    function GetHeight: Integer; safecall;
    function GetChannels: Integer; safecall;
    function GetWidthStep: Integer; safecall;
    function GetXDPI: Integer; safecall;
    function SetXDPI(xDPI: Integer): WordBool; safecall;
    function GetYDPI: Integer; safecall;
    function SetYDPI(yDPI: Integer): WordBool; safecall;
    function DrawText(const pFont: IDispatch; x: Integer; y: Integer; const text: WideString; 
                      clr: OLE_COLOR; weight: Integer): WordBool; safecall;
    function Rotate(angle: Single; clr: OLE_COLOR; flag: Integer): WordBool; safecall;
    function Crop(const pRect: IDispatch): WordBool; safecall;
    function Resize(width: Integer; height: Integer; flag: Integer): WordBool; safecall;
    function Blend(const pRectDest: IDispatch; const pImage: IDispatch; const pRectSrc: IDispatch; 
                   weight: Integer; flag: Integer): WordBool; safecall;
    function ToColor: WordBool; safecall;
    function ToGray: WordBool; safecall;
    function Threshold(Threshold: Integer): WordBool; safecall;
    function AdaptiveThreshold(flag: Integer): WordBool; safecall;
    function Reverse: WordBool; safecall;
    function Rectify(flag: Integer): WordBool; safecall;
    function PrintByDPI(x: Single; y: Single; const printer: WideString): WordBool; safecall;
    function GetBase64(fmt: Integer; flag: Integer): WideString; safecall;
    function AdaptivePrint(width: Single; height: Single; const printer: WideString): WordBool; safecall;
    function AdaptivePrintByDPI(const printer: WideString): WordBool; safecall;
    function Smooth(flag: Integer): WordBool; safecall;
    function DrawTextEx(pos: Integer; const text: WideString; clr: OLE_COLOR; weight: Integer): WordBool; safecall;
    function GetMD5(fmt: Integer; flag: Integer): WideString; safecall;
    function Whiten(flag: Integer; Threshold: Integer; autoThresholdRatio: Single; 
                    aroundNum: Integer; lowestBrightness: Integer): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IEloamImageDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {798BE982-270F-4308-9CD3-F6A246A4B605}
// *********************************************************************//
  IEloamImageDisp = dispinterface
    ['{798BE982-270F-4308-9CD3-F6A246A4B605}']
    function Destroy: WordBool; dispid 1;
    function CreateMemory(fmt: Integer; flag: Integer): IDispatch; dispid 2;
    function Copy(const pImage: IDispatch): WordBool; dispid 3;
    function Save(const fileName: WideString; flag: Integer): WordBool; dispid 4;
    function SaveToPDF(fmt: Integer; const fileName: WideString; flag: Integer): WordBool; dispid 5;
    function SetDiscernRect(const pRect: IDispatch): WordBool; dispid 6;
    function Print(x: Single; y: Single; width: Single; height: Single; const printer: WideString): WordBool; dispid 7;
    function GetWidth: Integer; dispid 8;
    function GetHeight: Integer; dispid 9;
    function GetChannels: Integer; dispid 10;
    function GetWidthStep: Integer; dispid 11;
    function GetXDPI: Integer; dispid 12;
    function SetXDPI(xDPI: Integer): WordBool; dispid 13;
    function GetYDPI: Integer; dispid 14;
    function SetYDPI(yDPI: Integer): WordBool; dispid 15;
    function DrawText(const pFont: IDispatch; x: Integer; y: Integer; const text: WideString; 
                      clr: OLE_COLOR; weight: Integer): WordBool; dispid 16;
    function Rotate(angle: Single; clr: OLE_COLOR; flag: Integer): WordBool; dispid 17;
    function Crop(const pRect: IDispatch): WordBool; dispid 18;
    function Resize(width: Integer; height: Integer; flag: Integer): WordBool; dispid 19;
    function Blend(const pRectDest: IDispatch; const pImage: IDispatch; const pRectSrc: IDispatch; 
                   weight: Integer; flag: Integer): WordBool; dispid 20;
    function ToColor: WordBool; dispid 21;
    function ToGray: WordBool; dispid 22;
    function Threshold(Threshold: Integer): WordBool; dispid 23;
    function AdaptiveThreshold(flag: Integer): WordBool; dispid 24;
    function Reverse: WordBool; dispid 25;
    function Rectify(flag: Integer): WordBool; dispid 26;
    function PrintByDPI(x: Single; y: Single; const printer: WideString): WordBool; dispid 27;
    function GetBase64(fmt: Integer; flag: Integer): WideString; dispid 28;
    function AdaptivePrint(width: Single; height: Single; const printer: WideString): WordBool; dispid 29;
    function AdaptivePrintByDPI(const printer: WideString): WordBool; dispid 30;
    function Smooth(flag: Integer): WordBool; dispid 31;
    function DrawTextEx(pos: Integer; const text: WideString; clr: OLE_COLOR; weight: Integer): WordBool; dispid 32;
    function GetMD5(fmt: Integer; flag: Integer): WideString; dispid 33;
    function Whiten(flag: Integer; Threshold: Integer; autoThresholdRatio: Single; 
                    aroundNum: Integer; lowestBrightness: Integer): WordBool; dispid 34;
  end;

// *********************************************************************//
// Interface: IEloamImageList
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EC7F059B-C267-453C-9B53-9C4D25BB41DB}
// *********************************************************************//
  IEloamImageList = interface(IDispatch)
    ['{EC7F059B-C267-453C-9B53-9C4D25BB41DB}']
    function Add(const pImage: IDispatch): WordBool; safecall;
    function Insert(const pImage: IDispatch; pos: Integer): WordBool; safecall;
    function Remove(idx: Integer): WordBool; safecall;
    function Clear: WordBool; safecall;
    function GetCount: Integer; safecall;
    function GetImage(idx: Integer): IDispatch; safecall;
    function Save(const fileName: WideString; flag: Integer): WordBool; safecall;
    function SaveToPDF(fmt: Integer; const fileName: WideString; flag: Integer): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IEloamImageListDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EC7F059B-C267-453C-9B53-9C4D25BB41DB}
// *********************************************************************//
  IEloamImageListDisp = dispinterface
    ['{EC7F059B-C267-453C-9B53-9C4D25BB41DB}']
    function Add(const pImage: IDispatch): WordBool; dispid 1;
    function Insert(const pImage: IDispatch; pos: Integer): WordBool; dispid 2;
    function Remove(idx: Integer): WordBool; dispid 3;
    function Clear: WordBool; dispid 4;
    function GetCount: Integer; dispid 5;
    function GetImage(idx: Integer): IDispatch; dispid 6;
    function Save(const fileName: WideString; flag: Integer): WordBool; dispid 7;
    function SaveToPDF(fmt: Integer; const fileName: WideString; flag: Integer): WordBool; dispid 8;
  end;

// *********************************************************************//
// Interface: IEloamMemory
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {DE530A7B-9659-4902-A6AD-C0E554835496}
// *********************************************************************//
  IEloamMemory = interface(IDispatch)
    ['{DE530A7B-9659-4902-A6AD-C0E554835496}']
    function Destroy: WordBool; safecall;
    function GetBase64: WideString; safecall;
    function CreateImage(flag: Integer): IDispatch; safecall;
    function Save(const fileName: WideString): WordBool; safecall;
    function GetMD5: WideString; safecall;
    function GetString: WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  IEloamMemoryDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {DE530A7B-9659-4902-A6AD-C0E554835496}
// *********************************************************************//
  IEloamMemoryDisp = dispinterface
    ['{DE530A7B-9659-4902-A6AD-C0E554835496}']
    function Destroy: WordBool; dispid 1;
    function GetBase64: WideString; dispid 2;
    function CreateImage(flag: Integer): IDispatch; dispid 3;
    function Save(const fileName: WideString): WordBool; dispid 4;
    function GetMD5: WideString; dispid 5;
    function GetString: WideString; dispid 6;
  end;

// *********************************************************************//
// DispIntf:  _IEloamGlobalEvents
// Flags:     (4096) Dispatchable
// GUID:      {013E7698-EC43-4AD1-930B-2B4AF28339B1}
// *********************************************************************//
  _IEloamGlobalEvents = dispinterface
    ['{013E7698-EC43-4AD1-930B-2B4AF28339B1}']
    function DevChange(type_: Integer; idx: Integer; dbt: Integer): HResult; dispid 1;
    function IdCard(ret: Integer): HResult; dispid 2;
    function Ocr(flag: Integer; ret: Integer): HResult; dispid 3;
    function Arrival(const pVideo: IDispatch; id: Integer): HResult; dispid 4;
    function Touch(const pVideo: IDispatch): HResult; dispid 5;
    function MoveDetec(const pVideo: IDispatch; id: Integer): HResult; dispid 6;
    function Biokey(ret: Integer): HResult; dispid 7;
    function TemplOcr(ret: Integer): HResult; dispid 8;
    function Reader(type_: Integer; subtype: Integer): HResult; dispid 9;
    function MagneticCard(type_: Integer): HResult; dispid 10;
    function ShenZhenTong(ret: Integer): HResult; dispid 11;
  end;

// *********************************************************************//
// Interface: IEloamGlobal
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {B93B9CBA-CD08-4E6E-BAED-6457F4E3FC5D}
// *********************************************************************//
  IEloamGlobal = interface(IDispatch)
    ['{B93B9CBA-CD08-4E6E-BAED-6457F4E3FC5D}']
    function CreateImage(width: Integer; height: Integer; channels: Integer): IDispatch; safecall;
    function CreateImageFromFile(const fileName: WideString; flag: Integer): IDispatch; safecall;
    function CreateImageList: IDispatch; safecall;
    function CreateImageListFromFile(const fileName: WideString; flag: Integer): IDispatch; safecall;
    function CreateFtp(const ftpPath: WideString): IDispatch; safecall;
    function CreateHttp(const httpPath: WideString): IDispatch; safecall;
    function CreateRect(x: Integer; y: Integer; xwidth: Integer; height: Integer): IDispatch; safecall;
    function CreateTypeface(height: Integer; width: Integer; escap: Integer; orien: Integer; 
                            thickness: Integer; italic: Integer; underline: Integer; 
                            strike: Integer; const font: WideString): IDispatch; safecall;
    function CreateMemory: IDispatch; safecall;
    function CreateMemoryFromFile(const fileName: WideString): IDispatch; safecall;
    function CreateTempl(const templName: WideString): IDispatch; safecall;
    function CreateTemplFromFile(const fileName: WideString; flag: Integer): IDispatch; safecall;
    function CreateTemplFromData(const data: WideString; flag: Integer): IDispatch; safecall;
    function PlayCaptureVoice: WordBool; safecall;
    function DelFile(const fileName: WideString): WordBool; safecall;
    function GetTempName(const ext: WideString): WideString; safecall;
    function QuickOcr(const filePath: WideString; const resultPath: WideString; flag: Integer): WordBool; safecall;
    function InitDevs: WordBool; safecall;
    function DeinitDevs: WordBool; safecall;
    function GetDevCount(type_: Integer): Integer; safecall;
    function GetDisplayName(type_: Integer; idx: Integer): WideString; safecall;
    function GetFriendlyName(type_: Integer; idx: Integer): WideString; safecall;
    function GetEloamType(type_: Integer; idx: Integer): Integer; safecall;
    function CreateDevice(type_: Integer; idx: Integer): IDispatch; safecall;
    function InitIdCard: WordBool; safecall;
    function DeinitIdCard: WordBool; safecall;
    function DiscernIdCard: WordBool; safecall;
    function GetIdCardImage(flag: Integer): IDispatch; safecall;
    function GetIdCardData(flag: Integer): WideString; safecall;
    function StopIdCardDiscern: WordBool; safecall;
    function InitBarcode: WordBool; safecall;
    function DeinitBarcode: WordBool; safecall;
    function DiscernBarcode(const pImage: IDispatch): WordBool; safecall;
    function GetBarcodeCount: Integer; safecall;
    function GetBarcodeType(idx: Integer): Integer; safecall;
    function GetBarcodeData(idx: Integer): WideString; safecall;
    function InitOcr: WordBool; safecall;
    function DeinitOcr: WordBool; safecall;
    function DiscernOcr(flag: Integer; const pImage: IDispatch): WordBool; safecall;
    function DiscernOcrList(flag: Integer; const pImageList: IDispatch): WordBool; safecall;
    function GetOcrPageCount: Integer; safecall;
    function GetOcrBlockCount(page: Integer): Integer; safecall;
    function GetOcrBarcodeType(page: Integer; blk: Integer): Integer; safecall;
    function GetOcrPlainText(page: Integer): WideString; safecall;
    function GetOcrData(page: Integer; blk: Integer): WideString; safecall;
    function SaveOcr(const fileName: WideString; flag: Integer): WordBool; safecall;
    function StopOcrDiscern: WordBool; safecall;
    function WaitOcrDiscern: WordBool; safecall;
    function InitBiokey: WordBool; safecall;
    function DeinitBiokey: WordBool; safecall;
    function GetBiokeyTemplate: WordBool; safecall;
    function GetBiokeyTemplateData: IDispatch; safecall;
    function StopGetBiokeyTemplate: WordBool; safecall;
    function GetBiokeyFeature: WordBool; safecall;
    function GetBiokeyFeatureData: IDispatch; safecall;
    function StopGetBiokeyFeature: WordBool; safecall;
    function BiokeyVerify(const pMemory1: IDispatch; const pMemory2: IDispatch): Integer; safecall;
    function InitTemplOcr: WordBool; safecall;
    function DeinitTemplOcr: WordBool; safecall;
    function DiscernTempl(const pImage: IDispatch; const pTempl: IDispatch): WordBool; safecall;
    function GetTemplResult: IDispatch; safecall;
    function StopTemplDiscern: WordBool; safecall;
    function WaitTemplDiscern: WordBool; safecall;
    function InitReader: WordBool; safecall;
    function DeinitReader: WordBool; safecall;
    function ReaderStart: WordBool; safecall;
    function ReaderGetCpuId: WideString; safecall;
    function ReaderStop: WordBool; safecall;
    function ReaderGetCpuCreditCardNumber: WideString; safecall;
    function ReaderGetMemoryId: WideString; safecall;
    function ReaderGetM1Id: WideString; safecall;
    function CreateDir(const dirPath: WideString): WordBool; safecall;
    function RemoveDir(const dirPath: WideString): WordBool; safecall;
    function SetOcrLanguage(lang: Integer): WordBool; safecall;
    function SetTemplOcrLanguage(lang: Integer): WordBool; safecall;
    function ReadIdCard: WordBool; safecall;
    function CreateImageFromBase64(const base64: WideString; flag: Integer): IDispatch; safecall;
    function MagneticCardInit: WordBool; safecall;
    function MagneticCardDeinit: WordBool; safecall;
    function MagneticCardReaderStart: WordBool; safecall;
    function MagneticCardReaderStop: WordBool; safecall;
    function MagneticCardGetData(type_: Integer): WideString; safecall;
    function MagneticCardGetNumber: WideString; safecall;
    function InitFaceDetect: WordBool; safecall;
    function DeinitFaceDetect: WordBool; safecall;
    function DiscernFaceDetect(const pImage1: IDispatch; const pImage2: IDispatch): Integer; safecall;
    function GetBiokeyImg: IDispatch; safecall;
    function GetFaceRect(const image: IDispatch): IDispatch; safecall;
    function VideoCapInit: WordBool; safecall;
    function CreatVideoCap: IDispatch; safecall;
    function VideoCapGetAudioDevNum: Integer; safecall;
    function VideoCapGetAudioDevName(devIndex: Integer): WideString; safecall;
    function GetPrinterCount: Integer; safecall;
    function GetPrinterName(idx: Integer): WideString; safecall;
    function ReaderGetQuickPassData(type_: Integer): WideString; safecall;
    function GetIdCardFingerprint: IDispatch; safecall;
    function EnableFaceRectCrop(const pVideo: IDispatch; flag: Integer): WordBool; safecall;
    function DisableFaceRectCrop(const pVideo: IDispatch): WordBool; safecall;
    function CpuGetBankCardTrack: WideString; safecall;
    function CpuGetRecordNumber: Integer; safecall;
    function CpuGetankCardRecord(index: Integer): WideString; safecall;
    function ReaderGetSocialCardData(type_: Integer): WideString; safecall;
    function InitShenZhenTong: WordBool; safecall;
    function DeinitShenZhenTong: WordBool; safecall;
    function StartShenZhenTongCard: WordBool; safecall;
    function StopShenZhenTongCard: WordBool; safecall;
    function GetShenZhenTongNumber: WideString; safecall;
    function GetShenZhenTongAmount: WideString; safecall;
    function GetShenZhenTongCardRecordNumber: Integer; safecall;
    function GetShenZhenTongCardRecord(index: Integer): WideString; safecall;
    function BiokeyVerifyFromString(const str1: WideString; const str2: WideString): Integer; safecall;
    function SetSoftDog(open: WordBool): WordBool; safecall;
    function GetKeyFromSoftDog(len: Integer): WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  IEloamGlobalDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {B93B9CBA-CD08-4E6E-BAED-6457F4E3FC5D}
// *********************************************************************//
  IEloamGlobalDisp = dispinterface
    ['{B93B9CBA-CD08-4E6E-BAED-6457F4E3FC5D}']
    function CreateImage(width: Integer; height: Integer; channels: Integer): IDispatch; dispid 1;
    function CreateImageFromFile(const fileName: WideString; flag: Integer): IDispatch; dispid 2;
    function CreateImageList: IDispatch; dispid 3;
    function CreateImageListFromFile(const fileName: WideString; flag: Integer): IDispatch; dispid 4;
    function CreateFtp(const ftpPath: WideString): IDispatch; dispid 5;
    function CreateHttp(const httpPath: WideString): IDispatch; dispid 6;
    function CreateRect(x: Integer; y: Integer; xwidth: Integer; height: Integer): IDispatch; dispid 7;
    function CreateTypeface(height: Integer; width: Integer; escap: Integer; orien: Integer; 
                            thickness: Integer; italic: Integer; underline: Integer; 
                            strike: Integer; const font: WideString): IDispatch; dispid 8;
    function CreateMemory: IDispatch; dispid 9;
    function CreateMemoryFromFile(const fileName: WideString): IDispatch; dispid 10;
    function CreateTempl(const templName: WideString): IDispatch; dispid 11;
    function CreateTemplFromFile(const fileName: WideString; flag: Integer): IDispatch; dispid 12;
    function CreateTemplFromData(const data: WideString; flag: Integer): IDispatch; dispid 13;
    function PlayCaptureVoice: WordBool; dispid 14;
    function DelFile(const fileName: WideString): WordBool; dispid 15;
    function GetTempName(const ext: WideString): WideString; dispid 16;
    function QuickOcr(const filePath: WideString; const resultPath: WideString; flag: Integer): WordBool; dispid 17;
    function InitDevs: WordBool; dispid 18;
    function DeinitDevs: WordBool; dispid 19;
    function GetDevCount(type_: Integer): Integer; dispid 20;
    function GetDisplayName(type_: Integer; idx: Integer): WideString; dispid 21;
    function GetFriendlyName(type_: Integer; idx: Integer): WideString; dispid 22;
    function GetEloamType(type_: Integer; idx: Integer): Integer; dispid 23;
    function CreateDevice(type_: Integer; idx: Integer): IDispatch; dispid 24;
    function InitIdCard: WordBool; dispid 25;
    function DeinitIdCard: WordBool; dispid 26;
    function DiscernIdCard: WordBool; dispid 27;
    function GetIdCardImage(flag: Integer): IDispatch; dispid 28;
    function GetIdCardData(flag: Integer): WideString; dispid 29;
    function StopIdCardDiscern: WordBool; dispid 30;
    function InitBarcode: WordBool; dispid 31;
    function DeinitBarcode: WordBool; dispid 32;
    function DiscernBarcode(const pImage: IDispatch): WordBool; dispid 33;
    function GetBarcodeCount: Integer; dispid 34;
    function GetBarcodeType(idx: Integer): Integer; dispid 35;
    function GetBarcodeData(idx: Integer): WideString; dispid 36;
    function InitOcr: WordBool; dispid 37;
    function DeinitOcr: WordBool; dispid 38;
    function DiscernOcr(flag: Integer; const pImage: IDispatch): WordBool; dispid 39;
    function DiscernOcrList(flag: Integer; const pImageList: IDispatch): WordBool; dispid 40;
    function GetOcrPageCount: Integer; dispid 41;
    function GetOcrBlockCount(page: Integer): Integer; dispid 42;
    function GetOcrBarcodeType(page: Integer; blk: Integer): Integer; dispid 43;
    function GetOcrPlainText(page: Integer): WideString; dispid 44;
    function GetOcrData(page: Integer; blk: Integer): WideString; dispid 45;
    function SaveOcr(const fileName: WideString; flag: Integer): WordBool; dispid 46;
    function StopOcrDiscern: WordBool; dispid 47;
    function WaitOcrDiscern: WordBool; dispid 48;
    function InitBiokey: WordBool; dispid 49;
    function DeinitBiokey: WordBool; dispid 50;
    function GetBiokeyTemplate: WordBool; dispid 51;
    function GetBiokeyTemplateData: IDispatch; dispid 52;
    function StopGetBiokeyTemplate: WordBool; dispid 53;
    function GetBiokeyFeature: WordBool; dispid 54;
    function GetBiokeyFeatureData: IDispatch; dispid 55;
    function StopGetBiokeyFeature: WordBool; dispid 56;
    function BiokeyVerify(const pMemory1: IDispatch; const pMemory2: IDispatch): Integer; dispid 57;
    function InitTemplOcr: WordBool; dispid 58;
    function DeinitTemplOcr: WordBool; dispid 59;
    function DiscernTempl(const pImage: IDispatch; const pTempl: IDispatch): WordBool; dispid 60;
    function GetTemplResult: IDispatch; dispid 61;
    function StopTemplDiscern: WordBool; dispid 62;
    function WaitTemplDiscern: WordBool; dispid 63;
    function InitReader: WordBool; dispid 64;
    function DeinitReader: WordBool; dispid 65;
    function ReaderStart: WordBool; dispid 66;
    function ReaderGetCpuId: WideString; dispid 67;
    function ReaderStop: WordBool; dispid 68;
    function ReaderGetCpuCreditCardNumber: WideString; dispid 69;
    function ReaderGetMemoryId: WideString; dispid 70;
    function ReaderGetM1Id: WideString; dispid 71;
    function CreateDir(const dirPath: WideString): WordBool; dispid 72;
    function RemoveDir(const dirPath: WideString): WordBool; dispid 73;
    function SetOcrLanguage(lang: Integer): WordBool; dispid 74;
    function SetTemplOcrLanguage(lang: Integer): WordBool; dispid 75;
    function ReadIdCard: WordBool; dispid 76;
    function CreateImageFromBase64(const base64: WideString; flag: Integer): IDispatch; dispid 78;
    function MagneticCardInit: WordBool; dispid 79;
    function MagneticCardDeinit: WordBool; dispid 80;
    function MagneticCardReaderStart: WordBool; dispid 81;
    function MagneticCardReaderStop: WordBool; dispid 82;
    function MagneticCardGetData(type_: Integer): WideString; dispid 83;
    function MagneticCardGetNumber: WideString; dispid 84;
    function InitFaceDetect: WordBool; dispid 85;
    function DeinitFaceDetect: WordBool; dispid 86;
    function DiscernFaceDetect(const pImage1: IDispatch; const pImage2: IDispatch): Integer; dispid 87;
    function GetBiokeyImg: IDispatch; dispid 88;
    function GetFaceRect(const image: IDispatch): IDispatch; dispid 89;
    function VideoCapInit: WordBool; dispid 90;
    function CreatVideoCap: IDispatch; dispid 91;
    function VideoCapGetAudioDevNum: Integer; dispid 92;
    function VideoCapGetAudioDevName(devIndex: Integer): WideString; dispid 93;
    function GetPrinterCount: Integer; dispid 94;
    function GetPrinterName(idx: Integer): WideString; dispid 95;
    function ReaderGetQuickPassData(type_: Integer): WideString; dispid 96;
    function GetIdCardFingerprint: IDispatch; dispid 97;
    function EnableFaceRectCrop(const pVideo: IDispatch; flag: Integer): WordBool; dispid 98;
    function DisableFaceRectCrop(const pVideo: IDispatch): WordBool; dispid 99;
    function CpuGetBankCardTrack: WideString; dispid 100;
    function CpuGetRecordNumber: Integer; dispid 101;
    function CpuGetankCardRecord(index: Integer): WideString; dispid 102;
    function ReaderGetSocialCardData(type_: Integer): WideString; dispid 103;
    function InitShenZhenTong: WordBool; dispid 104;
    function DeinitShenZhenTong: WordBool; dispid 105;
    function StartShenZhenTongCard: WordBool; dispid 106;
    function StopShenZhenTongCard: WordBool; dispid 107;
    function GetShenZhenTongNumber: WideString; dispid 108;
    function GetShenZhenTongAmount: WideString; dispid 109;
    function GetShenZhenTongCardRecordNumber: Integer; dispid 110;
    function GetShenZhenTongCardRecord(index: Integer): WideString; dispid 111;
    function BiokeyVerifyFromString(const str1: WideString; const str2: WideString): Integer; dispid 112;
    function SetSoftDog(open: WordBool): WordBool; dispid 113;
    function GetKeyFromSoftDog(len: Integer): WideString; dispid 114;
  end;

// *********************************************************************//
// Interface: IEloamDevice
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {25519945-1DE4-484F-98AB-03D923F23B2C}
// *********************************************************************//
  IEloamDevice = interface(IDispatch)
    ['{25519945-1DE4-484F-98AB-03D923F23B2C}']
    function Destroy: WordBool; safecall;
    function GetType: Integer; safecall;
    function GetIndex: Integer; safecall;
    function GetState: Integer; safecall;
    function GetFriendlyName: WideString; safecall;
    function GetDisplayName: WideString; safecall;
    function GetSubtype: Integer; safecall;
    function GetResolutionCount: Integer; safecall;
    function GetResolutionWidth(idx: Integer): Integer; safecall;
    function GetResolutionHeight(idx: Integer): Integer; safecall;
    function PausePreview: WordBool; safecall;
    function ResumePreivew: WordBool; safecall;
    function GetVideoProcAmp(prop: Integer; value: Integer): Integer; safecall;
    function SetVideoProcAmp(prop: Integer; value: Integer; isAuto: WordBool): WordBool; safecall;
    function GetCameraControl(prop: Integer; value: Integer): Integer; safecall;
    function SetCameraControl(prop: Integer; value: Integer; isAuto: WordBool): WordBool; safecall;
    function ShowProperty(const pView: IDispatch): WordBool; safecall;
    function CreateVideo(resolution: Integer; subtype: Integer): IDispatch; safecall;
    function GetSonixSerialNumber: WideString; safecall;
    function GetEloamType: Integer; safecall;
    function GetScanSize: Integer; safecall;
    function GetResolutionCountEx(subtype: Integer): Integer; safecall;
    function GetResolutionWidthEx(subtype: Integer; idx: Integer): Integer; safecall;
    function GetResolutionHeightEx(subtype: Integer; idx: Integer): Integer; safecall;
  end;

// *********************************************************************//
// DispIntf:  IEloamDeviceDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {25519945-1DE4-484F-98AB-03D923F23B2C}
// *********************************************************************//
  IEloamDeviceDisp = dispinterface
    ['{25519945-1DE4-484F-98AB-03D923F23B2C}']
    function Destroy: WordBool; dispid 1;
    function GetType: Integer; dispid 2;
    function GetIndex: Integer; dispid 3;
    function GetState: Integer; dispid 4;
    function GetFriendlyName: WideString; dispid 5;
    function GetDisplayName: WideString; dispid 6;
    function GetSubtype: Integer; dispid 7;
    function GetResolutionCount: Integer; dispid 8;
    function GetResolutionWidth(idx: Integer): Integer; dispid 9;
    function GetResolutionHeight(idx: Integer): Integer; dispid 10;
    function PausePreview: WordBool; dispid 11;
    function ResumePreivew: WordBool; dispid 12;
    function GetVideoProcAmp(prop: Integer; value: Integer): Integer; dispid 13;
    function SetVideoProcAmp(prop: Integer; value: Integer; isAuto: WordBool): WordBool; dispid 14;
    function GetCameraControl(prop: Integer; value: Integer): Integer; dispid 15;
    function SetCameraControl(prop: Integer; value: Integer; isAuto: WordBool): WordBool; dispid 16;
    function ShowProperty(const pView: IDispatch): WordBool; dispid 17;
    function CreateVideo(resolution: Integer; subtype: Integer): IDispatch; dispid 18;
    function GetSonixSerialNumber: WideString; dispid 19;
    function GetEloamType: Integer; dispid 20;
    function GetScanSize: Integer; dispid 21;
    function GetResolutionCountEx(subtype: Integer): Integer; dispid 22;
    function GetResolutionWidthEx(subtype: Integer; idx: Integer): Integer; dispid 23;
    function GetResolutionHeightEx(subtype: Integer; idx: Integer): Integer; dispid 24;
  end;

// *********************************************************************//
// Interface: IEloamHttp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {145448B4-3E23-4B63-8626-2F476DCB1D66}
// *********************************************************************//
  IEloamHttp = interface(IDispatch)
    ['{145448B4-3E23-4B63-8626-2F476DCB1D66}']
    function Destroy: WordBool; safecall;
    function Upload(flag: Integer; const localPath: WideString; const headers: WideString; 
                    const predata: WideString; const taildata: WideString): WordBool; safecall;
    function UploadMemory(flag: Integer; const pMemory: IDispatch; const headers: WideString; 
                          const predata: WideString; const taildata: WideString): WordBool; safecall;
    function StopUpload: WordBool; safecall;
    function WaitUpload: WordBool; safecall;
    function UploadImageFile(const fileName: WideString; const remoteName: WideString): WordBool; safecall;
    function UploadImageMemory(const pMemory: IDispatch; const remoteName: WideString): WordBool; safecall;
    function UploadImage(const pImage: IDispatch; fmt: Integer; flag: Integer; 
                         const remoteName: WideString): WordBool; safecall;
    function GetServerInfo: WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  IEloamHttpDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {145448B4-3E23-4B63-8626-2F476DCB1D66}
// *********************************************************************//
  IEloamHttpDisp = dispinterface
    ['{145448B4-3E23-4B63-8626-2F476DCB1D66}']
    function Destroy: WordBool; dispid 1;
    function Upload(flag: Integer; const localPath: WideString; const headers: WideString; 
                    const predata: WideString; const taildata: WideString): WordBool; dispid 2;
    function UploadMemory(flag: Integer; const pMemory: IDispatch; const headers: WideString; 
                          const predata: WideString; const taildata: WideString): WordBool; dispid 3;
    function StopUpload: WordBool; dispid 4;
    function WaitUpload: WordBool; dispid 5;
    function UploadImageFile(const fileName: WideString; const remoteName: WideString): WordBool; dispid 6;
    function UploadImageMemory(const pMemory: IDispatch; const remoteName: WideString): WordBool; dispid 7;
    function UploadImage(const pImage: IDispatch; fmt: Integer; flag: Integer; 
                         const remoteName: WideString): WordBool; dispid 8;
    function GetServerInfo: WideString; dispid 9;
  end;

// *********************************************************************//
// Interface: IEloamFtp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0C36E18A-6483-43C7-98CC-63B71729C092}
// *********************************************************************//
  IEloamFtp = interface(IDispatch)
    ['{0C36E18A-6483-43C7-98CC-63B71729C092}']
    function Destroy: WordBool; safecall;
    function Upload(flag: Integer; const localPath: WideString; const remotePath: WideString): WordBool; safecall;
    function StopUpload: WordBool; safecall;
    function WaitUpload: WordBool; safecall;
    function CreateDir(const dirPath: WideString): WordBool; safecall;
    function RemoveDir(const dirPath: WideString): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IEloamFtpDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0C36E18A-6483-43C7-98CC-63B71729C092}
// *********************************************************************//
  IEloamFtpDisp = dispinterface
    ['{0C36E18A-6483-43C7-98CC-63B71729C092}']
    function Destroy: WordBool; dispid 1;
    function Upload(flag: Integer; const localPath: WideString; const remotePath: WideString): WordBool; dispid 2;
    function StopUpload: WordBool; dispid 3;
    function WaitUpload: WordBool; dispid 4;
    function CreateDir(const dirPath: WideString): WordBool; dispid 5;
    function RemoveDir(const dirPath: WideString): WordBool; dispid 6;
  end;

// *********************************************************************//
// Interface: IEloamVideo
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3176B9F7-557E-480E-997C-36B5F44CCA49}
// *********************************************************************//
  IEloamVideo = interface(IDispatch)
    ['{3176B9F7-557E-480E-997C-36B5F44CCA49}']
    function Destroy: WordBool; safecall;
    function GetDevice: IDispatch; safecall;
    function GetResolution: Integer; safecall;
    function GetSubtype: Integer; safecall;
    function CreateImage(scanSize: Integer; const pView: IDispatch): IDispatch; safecall;
    function CreateImageList(scanSize: Integer; const pView: IDispatch): IDispatch; safecall;
    function RotateLeft: WordBool; safecall;
    function RotateRight: WordBool; safecall;
    function Rotate180: WordBool; safecall;
    function Flip: WordBool; safecall;
    function Mirror: WordBool; safecall;
    function FlipAndMirror: WordBool; safecall;
    function EnableGray: WordBool; safecall;
    function DisableGray: WordBool; safecall;
    function EnableThreshold(Threshold: Integer): WordBool; safecall;
    function DisableThreshold: WordBool; safecall;
    function EnableDelBkColor(flag: Integer): WordBool; safecall;
    function DisableDelBkColor: WordBool; safecall;
    function EnableAddText(const pFont: IDispatch; x: Integer; y: Integer; const text: WideString; 
                           clr: OLE_COLOR; weight: Integer): WordBool; safecall;
    function DisableAddText: WordBool; safecall;
    function EnableDeskew(flag: Integer): WordBool; safecall;
    function DisableDeskew: WordBool; safecall;
    function EnableReverse: WordBool; safecall;
    function DisableReverse: WordBool; safecall;
    function EnableMoveDetec(flag: Integer): WordBool; safecall;
    function DisableMoveDetec: WordBool; safecall;
    function EnableDate(const pFont: IDispatch; x: Integer; y: Integer; clr: OLE_COLOR; 
                        weight: Integer): WordBool; safecall;
    function DisableDate: WordBool; safecall;
    function EnableAdaptiveThreshold(flag: Integer): WordBool; safecall;
    function DisableAdaptiveThreshold: WordBool; safecall;
    function EnableSmooth(flag: Integer): WordBool; safecall;
    function DisableSmooth: WordBool; safecall;
    function GetWidth: Integer; safecall;
    function GetHeight: Integer; safecall;
    function EnableAddTextEx(pos: Integer; const text: WideString; clr: OLE_COLOR; weight: Integer): WordBool; safecall;
    function EnableDeskewEx(flag: Integer): WordBool; safecall;
    function EnableDateEx(pos: Integer; clr: OLE_COLOR; weight: Integer): WordBool; safecall;
    function StartRecord(const filePath: WideString; flag: Integer): WordBool; safecall;
    function StopRecord: WordBool; safecall;
    function CaputreImage: IDispatch; safecall;
    function SetCropState(state: Integer): WordBool; safecall;
    function SetDisplayRect(const pRect: IDispatch; enable: WordBool): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IEloamVideoDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3176B9F7-557E-480E-997C-36B5F44CCA49}
// *********************************************************************//
  IEloamVideoDisp = dispinterface
    ['{3176B9F7-557E-480E-997C-36B5F44CCA49}']
    function Destroy: WordBool; dispid 1;
    function GetDevice: IDispatch; dispid 2;
    function GetResolution: Integer; dispid 3;
    function GetSubtype: Integer; dispid 4;
    function CreateImage(scanSize: Integer; const pView: IDispatch): IDispatch; dispid 5;
    function CreateImageList(scanSize: Integer; const pView: IDispatch): IDispatch; dispid 6;
    function RotateLeft: WordBool; dispid 7;
    function RotateRight: WordBool; dispid 8;
    function Rotate180: WordBool; dispid 9;
    function Flip: WordBool; dispid 10;
    function Mirror: WordBool; dispid 11;
    function FlipAndMirror: WordBool; dispid 12;
    function EnableGray: WordBool; dispid 13;
    function DisableGray: WordBool; dispid 14;
    function EnableThreshold(Threshold: Integer): WordBool; dispid 15;
    function DisableThreshold: WordBool; dispid 16;
    function EnableDelBkColor(flag: Integer): WordBool; dispid 17;
    function DisableDelBkColor: WordBool; dispid 18;
    function EnableAddText(const pFont: IDispatch; x: Integer; y: Integer; const text: WideString; 
                           clr: OLE_COLOR; weight: Integer): WordBool; dispid 19;
    function DisableAddText: WordBool; dispid 20;
    function EnableDeskew(flag: Integer): WordBool; dispid 21;
    function DisableDeskew: WordBool; dispid 22;
    function EnableReverse: WordBool; dispid 23;
    function DisableReverse: WordBool; dispid 24;
    function EnableMoveDetec(flag: Integer): WordBool; dispid 25;
    function DisableMoveDetec: WordBool; dispid 26;
    function EnableDate(const pFont: IDispatch; x: Integer; y: Integer; clr: OLE_COLOR; 
                        weight: Integer): WordBool; dispid 27;
    function DisableDate: WordBool; dispid 28;
    function EnableAdaptiveThreshold(flag: Integer): WordBool; dispid 29;
    function DisableAdaptiveThreshold: WordBool; dispid 30;
    function EnableSmooth(flag: Integer): WordBool; dispid 31;
    function DisableSmooth: WordBool; dispid 32;
    function GetWidth: Integer; dispid 33;
    function GetHeight: Integer; dispid 34;
    function EnableAddTextEx(pos: Integer; const text: WideString; clr: OLE_COLOR; weight: Integer): WordBool; dispid 35;
    function EnableDeskewEx(flag: Integer): WordBool; dispid 36;
    function EnableDateEx(pos: Integer; clr: OLE_COLOR; weight: Integer): WordBool; dispid 37;
    function StartRecord(const filePath: WideString; flag: Integer): WordBool; dispid 38;
    function StopRecord: WordBool; dispid 39;
    function CaputreImage: IDispatch; dispid 40;
    function SetCropState(state: Integer): WordBool; dispid 41;
    function SetDisplayRect(const pRect: IDispatch; enable: WordBool): WordBool; dispid 42;
  end;

// *********************************************************************//
// DispIntf:  _IEloamViewEvents
// Flags:     (4096) Dispatchable
// GUID:      {F6F49968-91A3-4CD5-A866-6ED1216DDA22}
// *********************************************************************//
  _IEloamViewEvents = dispinterface
    ['{F6F49968-91A3-4CD5-A866-6ED1216DDA22}']
    function VideoAttach(const pVideo: IDispatch; videoId: Integer; const pView: IDispatch; 
                         viewId: Integer): HResult; dispid 1;
    function View(const pView: IDispatch; flag: Integer; value: Integer): HResult; dispid 2;
  end;

// *********************************************************************//
// Interface: IEloamView
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {86AD2C9D-DF2E-4F66-88DE-9FF72D451902}
// *********************************************************************//
  IEloamView = interface(IDispatch)
    ['{86AD2C9D-DF2E-4F66-88DE-9FF72D451902}']
    function GetView: IDispatch; safecall;
    function SelectImage(const pImage: IDispatch): WordBool; safecall;
    function SelectVideo(const pVideo: IDispatch): WordBool; safecall;
    function SelectNull: WordBool; safecall;
    function SetZoomIn: WordBool; safecall;
    function SetZoomOut: WordBool; safecall;
    function SetOriginal: WordBool; safecall;
    function SetAdapt: WordBool; safecall;
    function SetFullScreen(bFull: WordBool): WordBool; safecall;
    function GetState: Integer; safecall;
    function SetState(state: Integer): WordBool; safecall;
    function SetBkColor(clr: OLE_COLOR): WordBool; safecall;
    function SetText(const text: WideString; clr: OLE_COLOR): WordBool; safecall;
    function GetSelectRect: IDispatch; safecall;
    function SetSelectRect(const pRect: IDispatch): WordBool; safecall;
    function PlayCaptureEffect: WordBool; safecall;
    function SetScale(scale: Integer): WordBool; safecall;
    function SetRatio(ratio: Integer): WordBool; safecall;
    function SetRectangleFormat(lineStyle: Integer; lineSize: Integer; lineColor: OLE_COLOR; 
                                pointStyle: Integer; pointSize: Integer; pointColor: OLE_COLOR): WordBool; safecall;
    function SetCarpete: WordBool; safecall;
    function DrawCustomRect(flag: Integer; const pRect: IDispatch; cWidth: Integer; 
                            boxColor: OLE_COLOR): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IEloamViewDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {86AD2C9D-DF2E-4F66-88DE-9FF72D451902}
// *********************************************************************//
  IEloamViewDisp = dispinterface
    ['{86AD2C9D-DF2E-4F66-88DE-9FF72D451902}']
    function GetView: IDispatch; dispid 1;
    function SelectImage(const pImage: IDispatch): WordBool; dispid 2;
    function SelectVideo(const pVideo: IDispatch): WordBool; dispid 3;
    function SelectNull: WordBool; dispid 4;
    function SetZoomIn: WordBool; dispid 5;
    function SetZoomOut: WordBool; dispid 6;
    function SetOriginal: WordBool; dispid 7;
    function SetAdapt: WordBool; dispid 8;
    function SetFullScreen(bFull: WordBool): WordBool; dispid 9;
    function GetState: Integer; dispid 10;
    function SetState(state: Integer): WordBool; dispid 11;
    function SetBkColor(clr: OLE_COLOR): WordBool; dispid 12;
    function SetText(const text: WideString; clr: OLE_COLOR): WordBool; dispid 13;
    function GetSelectRect: IDispatch; dispid 14;
    function SetSelectRect(const pRect: IDispatch): WordBool; dispid 15;
    function PlayCaptureEffect: WordBool; dispid 16;
    function SetScale(scale: Integer): WordBool; dispid 17;
    function SetRatio(ratio: Integer): WordBool; dispid 18;
    function SetRectangleFormat(lineStyle: Integer; lineSize: Integer; lineColor: OLE_COLOR; 
                                pointStyle: Integer; pointSize: Integer; pointColor: OLE_COLOR): WordBool; dispid 19;
    function SetCarpete: WordBool; dispid 20;
    function DrawCustomRect(flag: Integer; const pRect: IDispatch; cWidth: Integer; 
                            boxColor: OLE_COLOR): WordBool; dispid 21;
  end;

// *********************************************************************//
// DispIntf:  _IEloamThumbnailEvents
// Flags:     (4096) Dispatchable
// GUID:      {1B5A8EFF-4DB5-4669-BE19-9ADCB2B1086E}
// *********************************************************************//
  _IEloamThumbnailEvents = dispinterface
    ['{1B5A8EFF-4DB5-4669-BE19-9ADCB2B1086E}']
  end;

// *********************************************************************//
// Interface: IEloamThumbnail
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C4FEA87D-519B-41E0-BC9D-18F8F3B7C714}
// *********************************************************************//
  IEloamThumbnail = interface(IDispatch)
    ['{C4FEA87D-519B-41E0-BC9D-18F8F3B7C714}']
    function GetThumbnail: IDispatch; safecall;
    function Add(const fileName: WideString): WordBool; safecall;
    function Insert(const fileName: WideString; pos: Integer): WordBool; safecall;
    function Remove(idx: Integer; bDel: WordBool): WordBool; safecall;
    function Clear(bDel: WordBool): WordBool; safecall;
    function GetCount: Integer; safecall;
    function GetFileName(idx: Integer): WideString; safecall;
    function GetSelected: Integer; safecall;
    function SetLanguage(langId: Integer): WordBool; safecall;
    function SetMenuItem(menuId: Integer; flag: Integer): WordBool; safecall;
    function GetCheck(idx: Integer): WordBool; safecall;
    function SetCheck(idx: Integer; bCheck: WordBool): WordBool; safecall;
    function HttpUploadCheckImage(const serverAddress: WideString; flag: Integer): WordBool; safecall;
    function GetHttpServerInfo: WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  IEloamThumbnailDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C4FEA87D-519B-41E0-BC9D-18F8F3B7C714}
// *********************************************************************//
  IEloamThumbnailDisp = dispinterface
    ['{C4FEA87D-519B-41E0-BC9D-18F8F3B7C714}']
    function GetThumbnail: IDispatch; dispid 1;
    function Add(const fileName: WideString): WordBool; dispid 2;
    function Insert(const fileName: WideString; pos: Integer): WordBool; dispid 3;
    function Remove(idx: Integer; bDel: WordBool): WordBool; dispid 4;
    function Clear(bDel: WordBool): WordBool; dispid 5;
    function GetCount: Integer; dispid 6;
    function GetFileName(idx: Integer): WideString; dispid 7;
    function GetSelected: Integer; dispid 8;
    function SetLanguage(langId: Integer): WordBool; dispid 9;
    function SetMenuItem(menuId: Integer; flag: Integer): WordBool; dispid 10;
    function GetCheck(idx: Integer): WordBool; dispid 11;
    function SetCheck(idx: Integer; bCheck: WordBool): WordBool; dispid 12;
    function HttpUploadCheckImage(const serverAddress: WideString; flag: Integer): WordBool; dispid 13;
    function GetHttpServerInfo: WideString; dispid 14;
  end;

// *********************************************************************//
// Interface: IEloamRect
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {5535094B-659B-4CF7-B137-80D47CC5F09E}
// *********************************************************************//
  IEloamRect = interface(IDispatch)
    ['{5535094B-659B-4CF7-B137-80D47CC5F09E}']
    function Destroy: WordBool; safecall;
    function GetLeft: Integer; safecall;
    function SetLeft(left: Integer): WordBool; safecall;
    function GetTop: Integer; safecall;
    function SetTop(top: Integer): WordBool; safecall;
    function GetWidth: Integer; safecall;
    function SetWidth(width: Integer): WordBool; safecall;
    function GetHeight: Integer; safecall;
    function SetHeight(height: Integer): WordBool; safecall;
    function Copy(const pRect: IDispatch): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IEloamRectDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {5535094B-659B-4CF7-B137-80D47CC5F09E}
// *********************************************************************//
  IEloamRectDisp = dispinterface
    ['{5535094B-659B-4CF7-B137-80D47CC5F09E}']
    function Destroy: WordBool; dispid 1;
    function GetLeft: Integer; dispid 2;
    function SetLeft(left: Integer): WordBool; dispid 3;
    function GetTop: Integer; dispid 4;
    function SetTop(top: Integer): WordBool; dispid 5;
    function GetWidth: Integer; dispid 6;
    function SetWidth(width: Integer): WordBool; dispid 7;
    function GetHeight: Integer; dispid 8;
    function SetHeight(height: Integer): WordBool; dispid 9;
    function Copy(const pRect: IDispatch): WordBool; dispid 10;
  end;

// *********************************************************************//
// Interface: IEloamFont
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {5AE529AC-DC9B-4302-AD18-25345168D61F}
// *********************************************************************//
  IEloamFont = interface(IDispatch)
    ['{5AE529AC-DC9B-4302-AD18-25345168D61F}']
    function Destroy: WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IEloamFontDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {5AE529AC-DC9B-4302-AD18-25345168D61F}
// *********************************************************************//
  IEloamFontDisp = dispinterface
    ['{5AE529AC-DC9B-4302-AD18-25345168D61F}']
    function Destroy: WordBool; dispid 1;
  end;

// *********************************************************************//
// Interface: IEloamTempl
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1B5B6E01-2D99-4D1A-ABE9-0C2109F0AB35}
// *********************************************************************//
  IEloamTempl = interface(IDispatch)
    ['{1B5B6E01-2D99-4D1A-ABE9-0C2109F0AB35}']
    function Destroy: WordBool; safecall;
    function GetName: WideString; safecall;
    function GetId: WideString; safecall;
    function AppendField(const fieldName: WideString; type_: Integer; left: Single; top: Single; 
                         right: Single; bottom: Single): WordBool; safecall;
    function GetFieldCount: Integer; safecall;
    function ClearField: WordBool; safecall;
    function GetFieldName(idx: Integer): WideString; safecall;
    function GetFieldRectLeft(idx: Integer): Single; safecall;
    function GetFieldRectTop(idx: Integer): Single; safecall;
    function GetFieldRectRight(idx: Integer): Single; safecall;
    function GetFieldRectBottom(idx: Integer): Single; safecall;
    function GetFieldResult(idx: Integer): WideString; safecall;
    function SetFieldResult(idx: Integer; const res: WideString): WordBool; safecall;
    function GetData(flag: Integer): WideString; safecall;
    function Save(const fileName: WideString; flag: Integer): WordBool; safecall;
    function GetFieldType(idx: Integer): Integer; safecall;
  end;

// *********************************************************************//
// DispIntf:  IEloamTemplDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1B5B6E01-2D99-4D1A-ABE9-0C2109F0AB35}
// *********************************************************************//
  IEloamTemplDisp = dispinterface
    ['{1B5B6E01-2D99-4D1A-ABE9-0C2109F0AB35}']
    function Destroy: WordBool; dispid 1;
    function GetName: WideString; dispid 2;
    function GetId: WideString; dispid 3;
    function AppendField(const fieldName: WideString; type_: Integer; left: Single; top: Single; 
                         right: Single; bottom: Single): WordBool; dispid 4;
    function GetFieldCount: Integer; dispid 5;
    function ClearField: WordBool; dispid 6;
    function GetFieldName(idx: Integer): WideString; dispid 7;
    function GetFieldRectLeft(idx: Integer): Single; dispid 8;
    function GetFieldRectTop(idx: Integer): Single; dispid 9;
    function GetFieldRectRight(idx: Integer): Single; dispid 10;
    function GetFieldRectBottom(idx: Integer): Single; dispid 11;
    function GetFieldResult(idx: Integer): WideString; dispid 12;
    function SetFieldResult(idx: Integer; const res: WideString): WordBool; dispid 13;
    function GetData(flag: Integer): WideString; dispid 14;
    function Save(const fileName: WideString; flag: Integer): WordBool; dispid 15;
    function GetFieldType(idx: Integer): Integer; dispid 16;
  end;

// *********************************************************************//
// Interface: IEloamVideoCap
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7F495A96-C99E-4719-9657-0D1652F4E9D8}
// *********************************************************************//
  IEloamVideoCap = interface(IDispatch)
    ['{7F495A96-C99E-4719-9657-0D1652F4E9D8}']
    function Destroy: WordBool; safecall;
    function VideoCapPreCap(const fileName: WideString; micIndex: Integer; frameRate: Integer; 
                            compressMode: Integer; width: Integer; heigth: Integer): WordBool; safecall;
    function VideoCapStart: WordBool; safecall;
    function VideoCapStop: WordBool; safecall;
    function VideoCapPause: WordBool; safecall;
    function VideoCapSetWatermark(Watermark: Integer; AddTime: Integer; mode: Integer; 
                                  pos: Integer; alpha: Integer; const imgPath: WideString; 
                                  const pStrText: WideString; color: Integer; 
                                  const faceName: WideString; weight: Integer; height: Integer; 
                                  italic: Integer): WordBool; safecall;
    function VideoCapAddVideoSrc(const video: IDispatch): WordBool; safecall;
    function VideoCapAddVideoSrcEx(const video: IDispatch; x: Integer; y: Integer; width: Integer; 
                                   heigth: Integer): WordBool; safecall;
    function VideoCapRemoveAllVideoSrc: WordBool; safecall;
    function VideoCapGetState: Integer; safecall;
  end;

// *********************************************************************//
// DispIntf:  IEloamVideoCapDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7F495A96-C99E-4719-9657-0D1652F4E9D8}
// *********************************************************************//
  IEloamVideoCapDisp = dispinterface
    ['{7F495A96-C99E-4719-9657-0D1652F4E9D8}']
    function Destroy: WordBool; dispid 1;
    function VideoCapPreCap(const fileName: WideString; micIndex: Integer; frameRate: Integer; 
                            compressMode: Integer; width: Integer; heigth: Integer): WordBool; dispid 2;
    function VideoCapStart: WordBool; dispid 3;
    function VideoCapStop: WordBool; dispid 4;
    function VideoCapPause: WordBool; dispid 5;
    function VideoCapSetWatermark(Watermark: Integer; AddTime: Integer; mode: Integer; 
                                  pos: Integer; alpha: Integer; const imgPath: WideString; 
                                  const pStrText: WideString; color: Integer; 
                                  const faceName: WideString; weight: Integer; height: Integer; 
                                  italic: Integer): WordBool; dispid 6;
    function VideoCapAddVideoSrc(const video: IDispatch): WordBool; dispid 7;
    function VideoCapAddVideoSrcEx(const video: IDispatch; x: Integer; y: Integer; width: Integer; 
                                   heigth: Integer): WordBool; dispid 8;
    function VideoCapRemoveAllVideoSrc: WordBool; dispid 9;
    function VideoCapGetState: Integer; dispid 10;
  end;

// *********************************************************************//
// The Class CoEloamImage provides a Create and CreateRemote method to          
// create instances of the default interface IEloamImage exposed by              
// the CoClass EloamImage. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoEloamImage = class
    class function Create: IEloamImage;
    class function CreateRemote(const MachineName: string): IEloamImage;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TEloamImage
// Help String      : 
// Default Interface: IEloamImage
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TEloamImage = class(TOleServer)
  private
    FIntf: IEloamImage;
    function GetDefaultInterface: IEloamImage;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IEloamImage);
    procedure Disconnect; override;
    function Destroy1: WordBool;
    function CreateMemory(fmt: Integer; flag: Integer): IDispatch;
    function Copy(const pImage: IDispatch): WordBool;
    function Save(const fileName: WideString; flag: Integer): WordBool;
    function SaveToPDF(fmt: Integer; const fileName: WideString; flag: Integer): WordBool;
    function SetDiscernRect(const pRect: IDispatch): WordBool;
    function Print(x: Single; y: Single; width: Single; height: Single; const printer: WideString): WordBool;
    function GetWidth: Integer;
    function GetHeight: Integer;
    function GetChannels: Integer;
    function GetWidthStep: Integer;
    function GetXDPI: Integer;
    function SetXDPI(xDPI: Integer): WordBool;
    function GetYDPI: Integer;
    function SetYDPI(yDPI: Integer): WordBool;
    function DrawText(const pFont: IDispatch; x: Integer; y: Integer; const text: WideString; 
                      clr: OLE_COLOR; weight: Integer): WordBool;
    function Rotate(angle: Single; clr: OLE_COLOR; flag: Integer): WordBool;
    function Crop(const pRect: IDispatch): WordBool;
    function Resize(width: Integer; height: Integer; flag: Integer): WordBool;
    function Blend(const pRectDest: IDispatch; const pImage: IDispatch; const pRectSrc: IDispatch; 
                   weight: Integer; flag: Integer): WordBool;
    function ToColor: WordBool;
    function ToGray: WordBool;
    function Threshold(Threshold: Integer): WordBool;
    function AdaptiveThreshold(flag: Integer): WordBool;
    function Reverse: WordBool;
    function Rectify(flag: Integer): WordBool;
    function PrintByDPI(x: Single; y: Single; const printer: WideString): WordBool;
    function GetBase64(fmt: Integer; flag: Integer): WideString;
    function AdaptivePrint(width: Single; height: Single; const printer: WideString): WordBool;
    function AdaptivePrintByDPI(const printer: WideString): WordBool;
    function Smooth(flag: Integer): WordBool;
    function DrawTextEx(pos: Integer; const text: WideString; clr: OLE_COLOR; weight: Integer): WordBool;
    function GetMD5(fmt: Integer; flag: Integer): WideString;
    function Whiten(flag: Integer; Threshold: Integer; autoThresholdRatio: Single; 
                    aroundNum: Integer; lowestBrightness: Integer): WordBool;
    property DefaultInterface: IEloamImage read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoEloamImageList provides a Create and CreateRemote method to          
// create instances of the default interface IEloamImageList exposed by              
// the CoClass EloamImageList. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoEloamImageList = class
    class function Create: IEloamImageList;
    class function CreateRemote(const MachineName: string): IEloamImageList;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TEloamImageList
// Help String      : 
// Default Interface: IEloamImageList
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TEloamImageList = class(TOleServer)
  private
    FIntf: IEloamImageList;
    function GetDefaultInterface: IEloamImageList;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IEloamImageList);
    procedure Disconnect; override;
    function Add(const pImage: IDispatch): WordBool;
    function Insert(const pImage: IDispatch; pos: Integer): WordBool;
    function Remove(idx: Integer): WordBool;
    function Clear: WordBool;
    function GetCount: Integer;
    function GetImage(idx: Integer): IDispatch;
    function Save(const fileName: WideString; flag: Integer): WordBool;
    function SaveToPDF(fmt: Integer; const fileName: WideString; flag: Integer): WordBool;
    property DefaultInterface: IEloamImageList read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoEloamMemory provides a Create and CreateRemote method to          
// create instances of the default interface IEloamMemory exposed by              
// the CoClass EloamMemory. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoEloamMemory = class
    class function Create: IEloamMemory;
    class function CreateRemote(const MachineName: string): IEloamMemory;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TEloamMemory
// Help String      : 
// Default Interface: IEloamMemory
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TEloamMemory = class(TOleServer)
  private
    FIntf: IEloamMemory;
    function GetDefaultInterface: IEloamMemory;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IEloamMemory);
    procedure Disconnect; override;
    function Destroy1: WordBool;
    function GetBase64: WideString;
    function CreateImage(flag: Integer): IDispatch;
    function Save(const fileName: WideString): WordBool;
    function GetMD5: WideString;
    function GetString: WideString;
    property DefaultInterface: IEloamMemory read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoEloamGlobal provides a Create and CreateRemote method to          
// create instances of the default interface IEloamGlobal exposed by              
// the CoClass EloamGlobal. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoEloamGlobal = class
    class function Create: IEloamGlobal;
    class function CreateRemote(const MachineName: string): IEloamGlobal;
  end;

  TEloamGlobalDevChange = procedure(ASender: TObject; type_: Integer; idx: Integer; dbt: Integer) of object;
  TEloamGlobalIdCard = procedure(ASender: TObject; ret: Integer) of object;
  TEloamGlobalOcr = procedure(ASender: TObject; flag: Integer; ret: Integer) of object;
  TEloamGlobalArrival = procedure(ASender: TObject; const pVideo: IDispatch; id: Integer) of object;
  TEloamGlobalTouch = procedure(ASender: TObject; const pVideo: IDispatch) of object;
  TEloamGlobalMoveDetec = procedure(ASender: TObject; const pVideo: IDispatch; id: Integer) of object;
  TEloamGlobalBiokey = procedure(ASender: TObject; ret: Integer) of object;
  TEloamGlobalTemplOcr = procedure(ASender: TObject; ret: Integer) of object;
  TEloamGlobalReader = procedure(ASender: TObject; type_: Integer; subtype: Integer) of object;
  TEloamGlobalMagneticCard = procedure(ASender: TObject; type_: Integer) of object;
  TEloamGlobalShenZhenTong = procedure(ASender: TObject; ret: Integer) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TEloamGlobal
// Help String      : 
// Default Interface: IEloamGlobal
// Def. Intf. DISP? : No
// Event   Interface: _IEloamGlobalEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TEloamGlobal = class(TOleServer)
  private
    FOnDevChange: TEloamGlobalDevChange;
    FOnIdCard: TEloamGlobalIdCard;
    FOnOcr: TEloamGlobalOcr;
    FOnArrival: TEloamGlobalArrival;
    FOnTouch: TEloamGlobalTouch;
    FOnMoveDetec: TEloamGlobalMoveDetec;
    FOnBiokey: TEloamGlobalBiokey;
    FOnTemplOcr: TEloamGlobalTemplOcr;
    FOnReader: TEloamGlobalReader;
    FOnMagneticCard: TEloamGlobalMagneticCard;
    FOnShenZhenTong: TEloamGlobalShenZhenTong;
    FIntf: IEloamGlobal;
    function GetDefaultInterface: IEloamGlobal;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IEloamGlobal);
    procedure Disconnect; override;
    function CreateImage(width: Integer; height: Integer; channels: Integer): IDispatch;
    function CreateImageFromFile(const fileName: WideString; flag: Integer): IDispatch;
    function CreateImageList: IDispatch;
    function CreateImageListFromFile(const fileName: WideString; flag: Integer): IDispatch;
    function CreateFtp(const ftpPath: WideString): IDispatch;
    function CreateHttp(const httpPath: WideString): IDispatch;
    function CreateRect(x: Integer; y: Integer; xwidth: Integer; height: Integer): IDispatch;
    function CreateTypeface(height: Integer; width: Integer; escap: Integer; orien: Integer; 
                            thickness: Integer; italic: Integer; underline: Integer; 
                            strike: Integer; const font: WideString): IDispatch;
    function CreateMemory: IDispatch;
    function CreateMemoryFromFile(const fileName: WideString): IDispatch;
    function CreateTempl(const templName: WideString): IDispatch;
    function CreateTemplFromFile(const fileName: WideString; flag: Integer): IDispatch;
    function CreateTemplFromData(const data: WideString; flag: Integer): IDispatch;
    function PlayCaptureVoice: WordBool;
    function DelFile(const fileName: WideString): WordBool;
    function GetTempName(const ext: WideString): WideString;
    function QuickOcr(const filePath: WideString; const resultPath: WideString; flag: Integer): WordBool;
    function InitDevs: WordBool;
    function DeinitDevs: WordBool;
    function GetDevCount(type_: Integer): Integer;
    function GetDisplayName(type_: Integer; idx: Integer): WideString;
    function GetFriendlyName(type_: Integer; idx: Integer): WideString;
    function GetEloamType(type_: Integer; idx: Integer): Integer;
    function CreateDevice(type_: Integer; idx: Integer): IDispatch;
    function InitIdCard: WordBool;
    function DeinitIdCard: WordBool;
    function DiscernIdCard: WordBool;
    function GetIdCardImage(flag: Integer): IDispatch;
    function GetIdCardData(flag: Integer): WideString;
    function StopIdCardDiscern: WordBool;
    function InitBarcode: WordBool;
    function DeinitBarcode: WordBool;
    function DiscernBarcode(const pImage: IDispatch): WordBool;
    function GetBarcodeCount: Integer;
    function GetBarcodeType(idx: Integer): Integer;
    function GetBarcodeData(idx: Integer): WideString;
    function InitOcr: WordBool;
    function DeinitOcr: WordBool;
    function DiscernOcr(flag: Integer; const pImage: IDispatch): WordBool;
    function DiscernOcrList(flag: Integer; const pImageList: IDispatch): WordBool;
    function GetOcrPageCount: Integer;
    function GetOcrBlockCount(page: Integer): Integer;
    function GetOcrBarcodeType(page: Integer; blk: Integer): Integer;
    function GetOcrPlainText(page: Integer): WideString;
    function GetOcrData(page: Integer; blk: Integer): WideString;
    function SaveOcr(const fileName: WideString; flag: Integer): WordBool;
    function StopOcrDiscern: WordBool;
    function WaitOcrDiscern: WordBool;
    function InitBiokey: WordBool;
    function DeinitBiokey: WordBool;
    function GetBiokeyTemplate: WordBool;
    function GetBiokeyTemplateData: IDispatch;
    function StopGetBiokeyTemplate: WordBool;
    function GetBiokeyFeature: WordBool;
    function GetBiokeyFeatureData: IDispatch;
    function StopGetBiokeyFeature: WordBool;
    function BiokeyVerify(const pMemory1: IDispatch; const pMemory2: IDispatch): Integer;
    function InitTemplOcr: WordBool;
    function DeinitTemplOcr: WordBool;
    function DiscernTempl(const pImage: IDispatch; const pTempl: IDispatch): WordBool;
    function GetTemplResult: IDispatch;
    function StopTemplDiscern: WordBool;
    function WaitTemplDiscern: WordBool;
    function InitReader: WordBool;
    function DeinitReader: WordBool;
    function ReaderStart: WordBool;
    function ReaderGetCpuId: WideString;
    function ReaderStop: WordBool;
    function ReaderGetCpuCreditCardNumber: WideString;
    function ReaderGetMemoryId: WideString;
    function ReaderGetM1Id: WideString;
    function CreateDir(const dirPath: WideString): WordBool;
    function RemoveDir(const dirPath: WideString): WordBool;
    function SetOcrLanguage(lang: Integer): WordBool;
    function SetTemplOcrLanguage(lang: Integer): WordBool;
    function ReadIdCard: WordBool;
    function CreateImageFromBase64(const base64: WideString; flag: Integer): IDispatch;
    function MagneticCardInit: WordBool;
    function MagneticCardDeinit: WordBool;
    function MagneticCardReaderStart: WordBool;
    function MagneticCardReaderStop: WordBool;
    function MagneticCardGetData(type_: Integer): WideString;
    function MagneticCardGetNumber: WideString;
    function InitFaceDetect: WordBool;
    function DeinitFaceDetect: WordBool;
    function DiscernFaceDetect(const pImage1: IDispatch; const pImage2: IDispatch): Integer;
    function GetBiokeyImg: IDispatch;
    function GetFaceRect(const image: IDispatch): IDispatch;
    function VideoCapInit: WordBool;
    function CreatVideoCap: IDispatch;
    function VideoCapGetAudioDevNum: Integer;
    function VideoCapGetAudioDevName(devIndex: Integer): WideString;
    function GetPrinterCount: Integer;
    function GetPrinterName(idx: Integer): WideString;
    function ReaderGetQuickPassData(type_: Integer): WideString;
    function GetIdCardFingerprint: IDispatch;
    function EnableFaceRectCrop(const pVideo: IDispatch; flag: Integer): WordBool;
    function DisableFaceRectCrop(const pVideo: IDispatch): WordBool;
    function CpuGetBankCardTrack: WideString;
    function CpuGetRecordNumber: Integer;
    function CpuGetankCardRecord(index: Integer): WideString;
    function ReaderGetSocialCardData(type_: Integer): WideString;
    function InitShenZhenTong: WordBool;
    function DeinitShenZhenTong: WordBool;
    function StartShenZhenTongCard: WordBool;
    function StopShenZhenTongCard: WordBool;
    function GetShenZhenTongNumber: WideString;
    function GetShenZhenTongAmount: WideString;
    function GetShenZhenTongCardRecordNumber: Integer;
    function GetShenZhenTongCardRecord(index: Integer): WideString;
    function BiokeyVerifyFromString(const str1: WideString; const str2: WideString): Integer;
    function SetSoftDog(open: WordBool): WordBool;
    function GetKeyFromSoftDog(len: Integer): WideString;
    property DefaultInterface: IEloamGlobal read GetDefaultInterface;
  published
    property OnDevChange: TEloamGlobalDevChange read FOnDevChange write FOnDevChange;
    property OnIdCard: TEloamGlobalIdCard read FOnIdCard write FOnIdCard;
    property OnOcr: TEloamGlobalOcr read FOnOcr write FOnOcr;
    property OnArrival: TEloamGlobalArrival read FOnArrival write FOnArrival;
    property OnTouch: TEloamGlobalTouch read FOnTouch write FOnTouch;
    property OnMoveDetec: TEloamGlobalMoveDetec read FOnMoveDetec write FOnMoveDetec;
    property OnBiokey: TEloamGlobalBiokey read FOnBiokey write FOnBiokey;
    property OnTemplOcr: TEloamGlobalTemplOcr read FOnTemplOcr write FOnTemplOcr;
    property OnReader: TEloamGlobalReader read FOnReader write FOnReader;
    property OnMagneticCard: TEloamGlobalMagneticCard read FOnMagneticCard write FOnMagneticCard;
    property OnShenZhenTong: TEloamGlobalShenZhenTong read FOnShenZhenTong write FOnShenZhenTong;
  end;

// *********************************************************************//
// The Class CoEloamDevice provides a Create and CreateRemote method to          
// create instances of the default interface IEloamDevice exposed by              
// the CoClass EloamDevice. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoEloamDevice = class
    class function Create: IEloamDevice;
    class function CreateRemote(const MachineName: string): IEloamDevice;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TEloamDevice
// Help String      : 
// Default Interface: IEloamDevice
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TEloamDevice = class(TOleServer)
  private
    FIntf: IEloamDevice;
    function GetDefaultInterface: IEloamDevice;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IEloamDevice);
    procedure Disconnect; override;
    function Destroy1: WordBool;
    function GetType: Integer;
    function GetIndex: Integer;
    function GetState: Integer;
    function GetFriendlyName: WideString;
    function GetDisplayName: WideString;
    function GetSubtype: Integer;
    function GetResolutionCount: Integer;
    function GetResolutionWidth(idx: Integer): Integer;
    function GetResolutionHeight(idx: Integer): Integer;
    function PausePreview: WordBool;
    function ResumePreivew: WordBool;
    function GetVideoProcAmp(prop: Integer; value: Integer): Integer;
    function SetVideoProcAmp(prop: Integer; value: Integer; isAuto: WordBool): WordBool;
    function GetCameraControl(prop: Integer; value: Integer): Integer;
    function SetCameraControl(prop: Integer; value: Integer; isAuto: WordBool): WordBool;
    function ShowProperty(const pView: IDispatch): WordBool;
    function CreateVideo(resolution: Integer; subtype: Integer): IDispatch;
    function GetSonixSerialNumber: WideString;
    function GetEloamType: Integer;
    function GetScanSize: Integer;
    function GetResolutionCountEx(subtype: Integer): Integer;
    function GetResolutionWidthEx(subtype: Integer; idx: Integer): Integer;
    function GetResolutionHeightEx(subtype: Integer; idx: Integer): Integer;
    property DefaultInterface: IEloamDevice read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoEloamHttp provides a Create and CreateRemote method to          
// create instances of the default interface IEloamHttp exposed by              
// the CoClass EloamHttp. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoEloamHttp = class
    class function Create: IEloamHttp;
    class function CreateRemote(const MachineName: string): IEloamHttp;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TEloamHttp
// Help String      : 
// Default Interface: IEloamHttp
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TEloamHttp = class(TOleServer)
  private
    FIntf: IEloamHttp;
    function GetDefaultInterface: IEloamHttp;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IEloamHttp);
    procedure Disconnect; override;
    function Destroy1: WordBool;
    function Upload(flag: Integer; const localPath: WideString; const headers: WideString; 
                    const predata: WideString; const taildata: WideString): WordBool;
    function UploadMemory(flag: Integer; const pMemory: IDispatch; const headers: WideString; 
                          const predata: WideString; const taildata: WideString): WordBool;
    function StopUpload: WordBool;
    function WaitUpload: WordBool;
    function UploadImageFile(const fileName: WideString; const remoteName: WideString): WordBool;
    function UploadImageMemory(const pMemory: IDispatch; const remoteName: WideString): WordBool;
    function UploadImage(const pImage: IDispatch; fmt: Integer; flag: Integer; 
                         const remoteName: WideString): WordBool;
    function GetServerInfo: WideString;
    property DefaultInterface: IEloamHttp read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoEloamFtp provides a Create and CreateRemote method to          
// create instances of the default interface IEloamFtp exposed by              
// the CoClass EloamFtp. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoEloamFtp = class
    class function Create: IEloamFtp;
    class function CreateRemote(const MachineName: string): IEloamFtp;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TEloamFtp
// Help String      : 
// Default Interface: IEloamFtp
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TEloamFtp = class(TOleServer)
  private
    FIntf: IEloamFtp;
    function GetDefaultInterface: IEloamFtp;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IEloamFtp);
    procedure Disconnect; override;
    function Destroy1: WordBool;
    function Upload(flag: Integer; const localPath: WideString; const remotePath: WideString): WordBool;
    function StopUpload: WordBool;
    function WaitUpload: WordBool;
    function CreateDir(const dirPath: WideString): WordBool;
    function RemoveDir(const dirPath: WideString): WordBool;
    property DefaultInterface: IEloamFtp read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoEloamVideo provides a Create and CreateRemote method to          
// create instances of the default interface IEloamVideo exposed by              
// the CoClass EloamVideo. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoEloamVideo = class
    class function Create: IEloamVideo;
    class function CreateRemote(const MachineName: string): IEloamVideo;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TEloamVideo
// Help String      : 
// Default Interface: IEloamVideo
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TEloamVideo = class(TOleServer)
  private
    FIntf: IEloamVideo;
    function GetDefaultInterface: IEloamVideo;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IEloamVideo);
    procedure Disconnect; override;
    function Destroy1: WordBool;
    function GetDevice: IDispatch;
    function GetResolution: Integer;
    function GetSubtype: Integer;
    function CreateImage(scanSize: Integer; const pView: IDispatch): IDispatch;
    function CreateImageList(scanSize: Integer; const pView: IDispatch): IDispatch;
    function RotateLeft: WordBool;
    function RotateRight: WordBool;
    function Rotate180: WordBool;
    function Flip: WordBool;
    function Mirror: WordBool;
    function FlipAndMirror: WordBool;
    function EnableGray: WordBool;
    function DisableGray: WordBool;
    function EnableThreshold(Threshold: Integer): WordBool;
    function DisableThreshold: WordBool;
    function EnableDelBkColor(flag: Integer): WordBool;
    function DisableDelBkColor: WordBool;
    function EnableAddText(const pFont: IDispatch; x: Integer; y: Integer; const text: WideString; 
                           clr: OLE_COLOR; weight: Integer): WordBool;
    function DisableAddText: WordBool;
    function EnableDeskew(flag: Integer): WordBool;
    function DisableDeskew: WordBool;
    function EnableReverse: WordBool;
    function DisableReverse: WordBool;
    function EnableMoveDetec(flag: Integer): WordBool;
    function DisableMoveDetec: WordBool;
    function EnableDate(const pFont: IDispatch; x: Integer; y: Integer; clr: OLE_COLOR; 
                        weight: Integer): WordBool;
    function DisableDate: WordBool;
    function EnableAdaptiveThreshold(flag: Integer): WordBool;
    function DisableAdaptiveThreshold: WordBool;
    function EnableSmooth(flag: Integer): WordBool;
    function DisableSmooth: WordBool;
    function GetWidth: Integer;
    function GetHeight: Integer;
    function EnableAddTextEx(pos: Integer; const text: WideString; clr: OLE_COLOR; weight: Integer): WordBool;
    function EnableDeskewEx(flag: Integer): WordBool;
    function EnableDateEx(pos: Integer; clr: OLE_COLOR; weight: Integer): WordBool;
    function StartRecord(const filePath: WideString; flag: Integer): WordBool;
    function StopRecord: WordBool;
    function CaputreImage: IDispatch;
    function SetCropState(state: Integer): WordBool;
    function SetDisplayRect(const pRect: IDispatch; enable: WordBool): WordBool;
    property DefaultInterface: IEloamVideo read GetDefaultInterface;
  published
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TEloamView
// Help String      : 
// Default Interface: IEloamView
// Def. Intf. DISP? : No
// Event   Interface: _IEloamViewEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TEloamViewVideoAttach = procedure(ASender: TObject; const pVideo: IDispatch; videoId: Integer; 
                                                      const pView: IDispatch; viewId: Integer) of object;
  TEloamViewView = procedure(ASender: TObject; const pView: IDispatch; flag: Integer; value: Integer) of object;

  TEloamView = class(TOleControl)
  private
    FOnVideoAttach: TEloamViewVideoAttach;
    FOnView: TEloamViewView;
    FIntf: IEloamView;
    function  GetControlInterface: IEloamView;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function GetView: IDispatch;
    function SelectImage(const pImage: IDispatch): WordBool;
    function SelectVideo(const pVideo: IDispatch): WordBool;
    function SelectNull: WordBool;
    function SetZoomIn: WordBool;
    function SetZoomOut: WordBool;
    function SetOriginal: WordBool;
    function SetAdapt: WordBool;
    function SetFullScreen(bFull: WordBool): WordBool;
    function GetState: Integer;
    function SetState(state: Integer): WordBool;
    function SetBkColor(clr: OLE_COLOR): WordBool;
    function SetText(const text: WideString; clr: OLE_COLOR): WordBool;
    function GetSelectRect: IDispatch;
    function SetSelectRect(const pRect: IDispatch): WordBool;
    function PlayCaptureEffect: WordBool;
    function SetScale(scale: Integer): WordBool;
    function SetRatio(ratio: Integer): WordBool;
    function SetRectangleFormat(lineStyle: Integer; lineSize: Integer; lineColor: OLE_COLOR; 
                                pointStyle: Integer; pointSize: Integer; pointColor: OLE_COLOR): WordBool;
    function SetCarpete: WordBool;
    function DrawCustomRect(flag: Integer; const pRect: IDispatch; cWidth: Integer; 
                            boxColor: OLE_COLOR): WordBool;
    property  ControlInterface: IEloamView read GetControlInterface;
    property  DefaultInterface: IEloamView read GetControlInterface;
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
    property OnVideoAttach: TEloamViewVideoAttach read FOnVideoAttach write FOnVideoAttach;
    property OnView: TEloamViewView read FOnView write FOnView;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TEloamThumbnail
// Help String      : 
// Default Interface: IEloamThumbnail
// Def. Intf. DISP? : No
// Event   Interface: _IEloamThumbnailEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TEloamThumbnail = class(TOleControl)
  private
    FIntf: IEloamThumbnail;
    function  GetControlInterface: IEloamThumbnail;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function GetThumbnail: IDispatch;
    function Add(const fileName: WideString): WordBool;
    function Insert(const fileName: WideString; pos: Integer): WordBool;
    function Remove(idx: Integer; bDel: WordBool): WordBool;
    function Clear(bDel: WordBool): WordBool;
    function GetCount: Integer;
    function GetFileName(idx: Integer): WideString;
    function GetSelected: Integer;
    function SetLanguage(langId: Integer): WordBool;
    function SetMenuItem(menuId: Integer; flag: Integer): WordBool;
    function GetCheck(idx: Integer): WordBool;
    function SetCheck(idx: Integer; bCheck: WordBool): WordBool;
    function HttpUploadCheckImage(const serverAddress: WideString; flag: Integer): WordBool;
    function GetHttpServerInfo: WideString;
    property  ControlInterface: IEloamThumbnail read GetControlInterface;
    property  DefaultInterface: IEloamThumbnail read GetControlInterface;
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
  end;

// *********************************************************************//
// The Class CoEloamRect provides a Create and CreateRemote method to          
// create instances of the default interface IEloamRect exposed by              
// the CoClass EloamRect. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoEloamRect = class
    class function Create: IEloamRect;
    class function CreateRemote(const MachineName: string): IEloamRect;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TEloamRect
// Help String      : 
// Default Interface: IEloamRect
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TEloamRect = class(TOleServer)
  private
    FIntf: IEloamRect;
    function GetDefaultInterface: IEloamRect;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IEloamRect);
    procedure Disconnect; override;
    function Destroy1: WordBool;
    function GetLeft: Integer;
    function SetLeft(left: Integer): WordBool;
    function GetTop: Integer;
    function SetTop(top: Integer): WordBool;
    function GetWidth: Integer;
    function SetWidth(width: Integer): WordBool;
    function GetHeight: Integer;
    function SetHeight(height: Integer): WordBool;
    function Copy(const pRect: IDispatch): WordBool;
    property DefaultInterface: IEloamRect read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoEloamFont provides a Create and CreateRemote method to          
// create instances of the default interface IEloamFont exposed by              
// the CoClass EloamFont. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoEloamFont = class
    class function Create: IEloamFont;
    class function CreateRemote(const MachineName: string): IEloamFont;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TEloamFont
// Help String      : 
// Default Interface: IEloamFont
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TEloamFont = class(TOleServer)
  private
    FIntf: IEloamFont;
    function GetDefaultInterface: IEloamFont;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IEloamFont);
    procedure Disconnect; override;
    function Destroy1: WordBool;
    property DefaultInterface: IEloamFont read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoEloamTempl provides a Create and CreateRemote method to          
// create instances of the default interface IEloamTempl exposed by              
// the CoClass EloamTempl. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoEloamTempl = class
    class function Create: IEloamTempl;
    class function CreateRemote(const MachineName: string): IEloamTempl;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TEloamTempl
// Help String      : 
// Default Interface: IEloamTempl
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TEloamTempl = class(TOleServer)
  private
    FIntf: IEloamTempl;
    function GetDefaultInterface: IEloamTempl;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IEloamTempl);
    procedure Disconnect; override;
    function Destroy1: WordBool;
    function GetName: WideString;
    function GetId: WideString;
    function AppendField(const fieldName: WideString; type_: Integer; left: Single; top: Single; 
                         right: Single; bottom: Single): WordBool;
    function GetFieldCount: Integer;
    function ClearField: WordBool;
    function GetFieldName(idx: Integer): WideString;
    function GetFieldRectLeft(idx: Integer): Single;
    function GetFieldRectTop(idx: Integer): Single;
    function GetFieldRectRight(idx: Integer): Single;
    function GetFieldRectBottom(idx: Integer): Single;
    function GetFieldResult(idx: Integer): WideString;
    function SetFieldResult(idx: Integer; const res: WideString): WordBool;
    function GetData(flag: Integer): WideString;
    function Save(const fileName: WideString; flag: Integer): WordBool;
    function GetFieldType(idx: Integer): Integer;
    property DefaultInterface: IEloamTempl read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoEloamVideoCap provides a Create and CreateRemote method to          
// create instances of the default interface IEloamVideoCap exposed by              
// the CoClass EloamVideoCap. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoEloamVideoCap = class
    class function Create: IEloamVideoCap;
    class function CreateRemote(const MachineName: string): IEloamVideoCap;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TEloamVideoCap
// Help String      : 
// Default Interface: IEloamVideoCap
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TEloamVideoCap = class(TOleServer)
  private
    FIntf: IEloamVideoCap;
    function GetDefaultInterface: IEloamVideoCap;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IEloamVideoCap);
    procedure Disconnect; override;
    function Destroy1: WordBool;
    function VideoCapPreCap(const fileName: WideString; micIndex: Integer; frameRate: Integer; 
                            compressMode: Integer; width: Integer; heigth: Integer): WordBool;
    function VideoCapStart: WordBool;
    function VideoCapStop: WordBool;
    function VideoCapPause: WordBool;
    function VideoCapSetWatermark(Watermark: Integer; AddTime: Integer; mode: Integer; 
                                  pos: Integer; alpha: Integer; const imgPath: WideString; 
                                  const pStrText: WideString; color: Integer; 
                                  const faceName: WideString; weight: Integer; height: Integer; 
                                  italic: Integer): WordBool;
    function VideoCapAddVideoSrc(const video: IDispatch): WordBool;
    function VideoCapAddVideoSrcEx(const video: IDispatch; x: Integer; y: Integer; width: Integer; 
                                   heigth: Integer): WordBool;
    function VideoCapRemoveAllVideoSrc: WordBool;
    function VideoCapGetState: Integer;
    property DefaultInterface: IEloamVideoCap read GetDefaultInterface;
  published
  end;

procedure Register;

resourcestring
  dtlServerPage = 'Eloam';

  dtlOcxPage = 'Eloam';

implementation

uses System.Win.ComObj;

class function CoEloamImage.Create: IEloamImage;
begin
  Result := CreateComObject(CLASS_EloamImage) as IEloamImage;
end;

class function CoEloamImage.CreateRemote(const MachineName: string): IEloamImage;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_EloamImage) as IEloamImage;
end;

procedure TEloamImage.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{7F389AE8-9F25-437E-A0FF-027163C32731}';
    IntfIID:   '{798BE982-270F-4308-9CD3-F6A246A4B605}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TEloamImage.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IEloamImage;
  end;
end;

procedure TEloamImage.ConnectTo(svrIntf: IEloamImage);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TEloamImage.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TEloamImage.GetDefaultInterface: IEloamImage;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TEloamImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TEloamImage.Destroy;
begin
  inherited Destroy;
end;

function TEloamImage.Destroy1: WordBool;
begin
  Result := DefaultInterface.Destroy;
end;

function TEloamImage.CreateMemory(fmt: Integer; flag: Integer): IDispatch;
begin
  Result := DefaultInterface.CreateMemory(fmt, flag);
end;

function TEloamImage.Copy(const pImage: IDispatch): WordBool;
begin
  Result := DefaultInterface.Copy(pImage);
end;

function TEloamImage.Save(const fileName: WideString; flag: Integer): WordBool;
begin
  Result := DefaultInterface.Save(fileName, flag);
end;

function TEloamImage.SaveToPDF(fmt: Integer; const fileName: WideString; flag: Integer): WordBool;
begin
  Result := DefaultInterface.SaveToPDF(fmt, fileName, flag);
end;

function TEloamImage.SetDiscernRect(const pRect: IDispatch): WordBool;
begin
  Result := DefaultInterface.SetDiscernRect(pRect);
end;

function TEloamImage.Print(x: Single; y: Single; width: Single; height: Single; 
                           const printer: WideString): WordBool;
begin
  Result := DefaultInterface.Print(x, y, width, height, printer);
end;

function TEloamImage.GetWidth: Integer;
begin
  Result := DefaultInterface.GetWidth;
end;

function TEloamImage.GetHeight: Integer;
begin
  Result := DefaultInterface.GetHeight;
end;

function TEloamImage.GetChannels: Integer;
begin
  Result := DefaultInterface.GetChannels;
end;

function TEloamImage.GetWidthStep: Integer;
begin
  Result := DefaultInterface.GetWidthStep;
end;

function TEloamImage.GetXDPI: Integer;
begin
  Result := DefaultInterface.GetXDPI;
end;

function TEloamImage.SetXDPI(xDPI: Integer): WordBool;
begin
  Result := DefaultInterface.SetXDPI(xDPI);
end;

function TEloamImage.GetYDPI: Integer;
begin
  Result := DefaultInterface.GetYDPI;
end;

function TEloamImage.SetYDPI(yDPI: Integer): WordBool;
begin
  Result := DefaultInterface.SetYDPI(yDPI);
end;

function TEloamImage.DrawText(const pFont: IDispatch; x: Integer; y: Integer; 
                              const text: WideString; clr: OLE_COLOR; weight: Integer): WordBool;
begin
  Result := DefaultInterface.DrawText(pFont, x, y, text, clr, weight);
end;

function TEloamImage.Rotate(angle: Single; clr: OLE_COLOR; flag: Integer): WordBool;
begin
  Result := DefaultInterface.Rotate(angle, clr, flag);
end;

function TEloamImage.Crop(const pRect: IDispatch): WordBool;
begin
  Result := DefaultInterface.Crop(pRect);
end;

function TEloamImage.Resize(width: Integer; height: Integer; flag: Integer): WordBool;
begin
  Result := DefaultInterface.Resize(width, height, flag);
end;

function TEloamImage.Blend(const pRectDest: IDispatch; const pImage: IDispatch; 
                           const pRectSrc: IDispatch; weight: Integer; flag: Integer): WordBool;
begin
  Result := DefaultInterface.Blend(pRectDest, pImage, pRectSrc, weight, flag);
end;

function TEloamImage.ToColor: WordBool;
begin
  Result := DefaultInterface.ToColor;
end;

function TEloamImage.ToGray: WordBool;
begin
  Result := DefaultInterface.ToGray;
end;

function TEloamImage.Threshold(Threshold: Integer): WordBool;
begin
  Result := DefaultInterface.Threshold(Threshold);
end;

function TEloamImage.AdaptiveThreshold(flag: Integer): WordBool;
begin
  Result := DefaultInterface.AdaptiveThreshold(flag);
end;

function TEloamImage.Reverse: WordBool;
begin
  Result := DefaultInterface.Reverse;
end;

function TEloamImage.Rectify(flag: Integer): WordBool;
begin
  Result := DefaultInterface.Rectify(flag);
end;

function TEloamImage.PrintByDPI(x: Single; y: Single; const printer: WideString): WordBool;
begin
  Result := DefaultInterface.PrintByDPI(x, y, printer);
end;

function TEloamImage.GetBase64(fmt: Integer; flag: Integer): WideString;
begin
  Result := DefaultInterface.GetBase64(fmt, flag);
end;

function TEloamImage.AdaptivePrint(width: Single; height: Single; const printer: WideString): WordBool;
begin
  Result := DefaultInterface.AdaptivePrint(width, height, printer);
end;

function TEloamImage.AdaptivePrintByDPI(const printer: WideString): WordBool;
begin
  Result := DefaultInterface.AdaptivePrintByDPI(printer);
end;

function TEloamImage.Smooth(flag: Integer): WordBool;
begin
  Result := DefaultInterface.Smooth(flag);
end;

function TEloamImage.DrawTextEx(pos: Integer; const text: WideString; clr: OLE_COLOR; 
                                weight: Integer): WordBool;
begin
  Result := DefaultInterface.DrawTextEx(pos, text, clr, weight);
end;

function TEloamImage.GetMD5(fmt: Integer; flag: Integer): WideString;
begin
  Result := DefaultInterface.GetMD5(fmt, flag);
end;

function TEloamImage.Whiten(flag: Integer; Threshold: Integer; autoThresholdRatio: Single; 
                            aroundNum: Integer; lowestBrightness: Integer): WordBool;
begin
  Result := DefaultInterface.Whiten(flag, Threshold, autoThresholdRatio, aroundNum, lowestBrightness);
end;

class function CoEloamImageList.Create: IEloamImageList;
begin
  Result := CreateComObject(CLASS_EloamImageList) as IEloamImageList;
end;

class function CoEloamImageList.CreateRemote(const MachineName: string): IEloamImageList;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_EloamImageList) as IEloamImageList;
end;

procedure TEloamImageList.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{E51007C6-9DBE-47E7-BD74-F488F31BFE7C}';
    IntfIID:   '{EC7F059B-C267-453C-9B53-9C4D25BB41DB}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TEloamImageList.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IEloamImageList;
  end;
end;

procedure TEloamImageList.ConnectTo(svrIntf: IEloamImageList);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TEloamImageList.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TEloamImageList.GetDefaultInterface: IEloamImageList;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TEloamImageList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TEloamImageList.Destroy;
begin
  inherited Destroy;
end;

function TEloamImageList.Add(const pImage: IDispatch): WordBool;
begin
  Result := DefaultInterface.Add(pImage);
end;

function TEloamImageList.Insert(const pImage: IDispatch; pos: Integer): WordBool;
begin
  Result := DefaultInterface.Insert(pImage, pos);
end;

function TEloamImageList.Remove(idx: Integer): WordBool;
begin
  Result := DefaultInterface.Remove(idx);
end;

function TEloamImageList.Clear: WordBool;
begin
  Result := DefaultInterface.Clear;
end;

function TEloamImageList.GetCount: Integer;
begin
  Result := DefaultInterface.GetCount;
end;

function TEloamImageList.GetImage(idx: Integer): IDispatch;
begin
  Result := DefaultInterface.GetImage(idx);
end;

function TEloamImageList.Save(const fileName: WideString; flag: Integer): WordBool;
begin
  Result := DefaultInterface.Save(fileName, flag);
end;

function TEloamImageList.SaveToPDF(fmt: Integer; const fileName: WideString; flag: Integer): WordBool;
begin
  Result := DefaultInterface.SaveToPDF(fmt, fileName, flag);
end;

class function CoEloamMemory.Create: IEloamMemory;
begin
  Result := CreateComObject(CLASS_EloamMemory) as IEloamMemory;
end;

class function CoEloamMemory.CreateRemote(const MachineName: string): IEloamMemory;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_EloamMemory) as IEloamMemory;
end;

procedure TEloamMemory.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{8C474F0F-6C27-4339-815E-BAB9DE163224}';
    IntfIID:   '{DE530A7B-9659-4902-A6AD-C0E554835496}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TEloamMemory.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IEloamMemory;
  end;
end;

procedure TEloamMemory.ConnectTo(svrIntf: IEloamMemory);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TEloamMemory.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TEloamMemory.GetDefaultInterface: IEloamMemory;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TEloamMemory.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TEloamMemory.Destroy;
begin
  inherited Destroy;
end;

function TEloamMemory.Destroy1: WordBool;
begin
  Result := DefaultInterface.Destroy;
end;

function TEloamMemory.GetBase64: WideString;
begin
  Result := DefaultInterface.GetBase64;
end;

function TEloamMemory.CreateImage(flag: Integer): IDispatch;
begin
  Result := DefaultInterface.CreateImage(flag);
end;

function TEloamMemory.Save(const fileName: WideString): WordBool;
begin
  Result := DefaultInterface.Save(fileName);
end;

function TEloamMemory.GetMD5: WideString;
begin
  Result := DefaultInterface.GetMD5;
end;

function TEloamMemory.GetString: WideString;
begin
  Result := DefaultInterface.GetString;
end;

class function CoEloamGlobal.Create: IEloamGlobal;
begin
  Result := CreateComObject(CLASS_EloamGlobal) as IEloamGlobal;
end;

class function CoEloamGlobal.CreateRemote(const MachineName: string): IEloamGlobal;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_EloamGlobal) as IEloamGlobal;
end;

procedure TEloamGlobal.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{52D1E686-D8D7-4DF2-9A74-8B8F4650BF73}';
    IntfIID:   '{B93B9CBA-CD08-4E6E-BAED-6457F4E3FC5D}';
    EventIID:  '{013E7698-EC43-4AD1-930B-2B4AF28339B1}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TEloamGlobal.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IEloamGlobal;
  end;
end;

procedure TEloamGlobal.ConnectTo(svrIntf: IEloamGlobal);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TEloamGlobal.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TEloamGlobal.GetDefaultInterface: IEloamGlobal;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TEloamGlobal.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TEloamGlobal.Destroy;
begin
  inherited Destroy;
end;

procedure TEloamGlobal.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    1: if Assigned(FOnDevChange) then
         FOnDevChange(Self,
                      Params[0] {Integer},
                      Params[1] {Integer},
                      Params[2] {Integer});
    2: if Assigned(FOnIdCard) then
         FOnIdCard(Self, Params[0] {Integer});
    3: if Assigned(FOnOcr) then
         FOnOcr(Self,
                Params[0] {Integer},
                Params[1] {Integer});
    4: if Assigned(FOnArrival) then
         FOnArrival(Self,
                    Params[0] {const IDispatch},
                    Params[1] {Integer});
    5: if Assigned(FOnTouch) then
         FOnTouch(Self, Params[0] {const IDispatch});
    6: if Assigned(FOnMoveDetec) then
         FOnMoveDetec(Self,
                      Params[0] {const IDispatch},
                      Params[1] {Integer});
    7: if Assigned(FOnBiokey) then
         FOnBiokey(Self, Params[0] {Integer});
    8: if Assigned(FOnTemplOcr) then
         FOnTemplOcr(Self, Params[0] {Integer});
    9: if Assigned(FOnReader) then
         FOnReader(Self,
                   Params[0] {Integer},
                   Params[1] {Integer});
    10: if Assigned(FOnMagneticCard) then
         FOnMagneticCard(Self, Params[0] {Integer});
    11: if Assigned(FOnShenZhenTong) then
         FOnShenZhenTong(Self, Params[0] {Integer});
  end; {case DispID}
end;

function TEloamGlobal.CreateImage(width: Integer; height: Integer; channels: Integer): IDispatch;
begin
  Result := DefaultInterface.CreateImage(width, height, channels);
end;

function TEloamGlobal.CreateImageFromFile(const fileName: WideString; flag: Integer): IDispatch;
begin
  Result := DefaultInterface.CreateImageFromFile(fileName, flag);
end;

function TEloamGlobal.CreateImageList: IDispatch;
begin
  Result := DefaultInterface.CreateImageList;
end;

function TEloamGlobal.CreateImageListFromFile(const fileName: WideString; flag: Integer): IDispatch;
begin
  Result := DefaultInterface.CreateImageListFromFile(fileName, flag);
end;

function TEloamGlobal.CreateFtp(const ftpPath: WideString): IDispatch;
begin
  Result := DefaultInterface.CreateFtp(ftpPath);
end;

function TEloamGlobal.CreateHttp(const httpPath: WideString): IDispatch;
begin
  Result := DefaultInterface.CreateHttp(httpPath);
end;

function TEloamGlobal.CreateRect(x: Integer; y: Integer; xwidth: Integer; height: Integer): IDispatch;
begin
  Result := DefaultInterface.CreateRect(x, y, xwidth, height);
end;

function TEloamGlobal.CreateTypeface(height: Integer; width: Integer; escap: Integer; 
                                     orien: Integer; thickness: Integer; italic: Integer; 
                                     underline: Integer; strike: Integer; const font: WideString): IDispatch;
begin
  Result := DefaultInterface.CreateTypeface(height, width, escap, orien, thickness, italic, 
                                            underline, strike, font);
end;

function TEloamGlobal.CreateMemory: IDispatch;
begin
  Result := DefaultInterface.CreateMemory;
end;

function TEloamGlobal.CreateMemoryFromFile(const fileName: WideString): IDispatch;
begin
  Result := DefaultInterface.CreateMemoryFromFile(fileName);
end;

function TEloamGlobal.CreateTempl(const templName: WideString): IDispatch;
begin
  Result := DefaultInterface.CreateTempl(templName);
end;

function TEloamGlobal.CreateTemplFromFile(const fileName: WideString; flag: Integer): IDispatch;
begin
  Result := DefaultInterface.CreateTemplFromFile(fileName, flag);
end;

function TEloamGlobal.CreateTemplFromData(const data: WideString; flag: Integer): IDispatch;
begin
  Result := DefaultInterface.CreateTemplFromData(data, flag);
end;

function TEloamGlobal.PlayCaptureVoice: WordBool;
begin
  Result := DefaultInterface.PlayCaptureVoice;
end;

function TEloamGlobal.DelFile(const fileName: WideString): WordBool;
begin
  Result := DefaultInterface.DelFile(fileName);
end;

function TEloamGlobal.GetTempName(const ext: WideString): WideString;
begin
  Result := DefaultInterface.GetTempName(ext);
end;

function TEloamGlobal.QuickOcr(const filePath: WideString; const resultPath: WideString; 
                               flag: Integer): WordBool;
begin
  Result := DefaultInterface.QuickOcr(filePath, resultPath, flag);
end;

function TEloamGlobal.InitDevs: WordBool;
begin
  Result := DefaultInterface.InitDevs;
end;

function TEloamGlobal.DeinitDevs: WordBool;
begin
  Result := DefaultInterface.DeinitDevs;
end;

function TEloamGlobal.GetDevCount(type_: Integer): Integer;
begin
  Result := DefaultInterface.GetDevCount(type_);
end;

function TEloamGlobal.GetDisplayName(type_: Integer; idx: Integer): WideString;
begin
  Result := DefaultInterface.GetDisplayName(type_, idx);
end;

function TEloamGlobal.GetFriendlyName(type_: Integer; idx: Integer): WideString;
begin
  Result := DefaultInterface.GetFriendlyName(type_, idx);
end;

function TEloamGlobal.GetEloamType(type_: Integer; idx: Integer): Integer;
begin
  Result := DefaultInterface.GetEloamType(type_, idx);
end;

function TEloamGlobal.CreateDevice(type_: Integer; idx: Integer): IDispatch;
begin
  Result := DefaultInterface.CreateDevice(type_, idx);
end;

function TEloamGlobal.InitIdCard: WordBool;
begin
  Result := DefaultInterface.InitIdCard;
end;

function TEloamGlobal.DeinitIdCard: WordBool;
begin
  Result := DefaultInterface.DeinitIdCard;
end;

function TEloamGlobal.DiscernIdCard: WordBool;
begin
  Result := DefaultInterface.DiscernIdCard;
end;

function TEloamGlobal.GetIdCardImage(flag: Integer): IDispatch;
begin
  Result := DefaultInterface.GetIdCardImage(flag);
end;

function TEloamGlobal.GetIdCardData(flag: Integer): WideString;
begin
  Result := DefaultInterface.GetIdCardData(flag);
end;

function TEloamGlobal.StopIdCardDiscern: WordBool;
begin
  Result := DefaultInterface.StopIdCardDiscern;
end;

function TEloamGlobal.InitBarcode: WordBool;
begin
  Result := DefaultInterface.InitBarcode;
end;

function TEloamGlobal.DeinitBarcode: WordBool;
begin
  Result := DefaultInterface.DeinitBarcode;
end;

function TEloamGlobal.DiscernBarcode(const pImage: IDispatch): WordBool;
begin
  Result := DefaultInterface.DiscernBarcode(pImage);
end;

function TEloamGlobal.GetBarcodeCount: Integer;
begin
  Result := DefaultInterface.GetBarcodeCount;
end;

function TEloamGlobal.GetBarcodeType(idx: Integer): Integer;
begin
  Result := DefaultInterface.GetBarcodeType(idx);
end;

function TEloamGlobal.GetBarcodeData(idx: Integer): WideString;
begin
  Result := DefaultInterface.GetBarcodeData(idx);
end;

function TEloamGlobal.InitOcr: WordBool;
begin
  Result := DefaultInterface.InitOcr;
end;

function TEloamGlobal.DeinitOcr: WordBool;
begin
  Result := DefaultInterface.DeinitOcr;
end;

function TEloamGlobal.DiscernOcr(flag: Integer; const pImage: IDispatch): WordBool;
begin
  Result := DefaultInterface.DiscernOcr(flag, pImage);
end;

function TEloamGlobal.DiscernOcrList(flag: Integer; const pImageList: IDispatch): WordBool;
begin
  Result := DefaultInterface.DiscernOcrList(flag, pImageList);
end;

function TEloamGlobal.GetOcrPageCount: Integer;
begin
  Result := DefaultInterface.GetOcrPageCount;
end;

function TEloamGlobal.GetOcrBlockCount(page: Integer): Integer;
begin
  Result := DefaultInterface.GetOcrBlockCount(page);
end;

function TEloamGlobal.GetOcrBarcodeType(page: Integer; blk: Integer): Integer;
begin
  Result := DefaultInterface.GetOcrBarcodeType(page, blk);
end;

function TEloamGlobal.GetOcrPlainText(page: Integer): WideString;
begin
  Result := DefaultInterface.GetOcrPlainText(page);
end;

function TEloamGlobal.GetOcrData(page: Integer; blk: Integer): WideString;
begin
  Result := DefaultInterface.GetOcrData(page, blk);
end;

function TEloamGlobal.SaveOcr(const fileName: WideString; flag: Integer): WordBool;
begin
  Result := DefaultInterface.SaveOcr(fileName, flag);
end;

function TEloamGlobal.StopOcrDiscern: WordBool;
begin
  Result := DefaultInterface.StopOcrDiscern;
end;

function TEloamGlobal.WaitOcrDiscern: WordBool;
begin
  Result := DefaultInterface.WaitOcrDiscern;
end;

function TEloamGlobal.InitBiokey: WordBool;
begin
  Result := DefaultInterface.InitBiokey;
end;

function TEloamGlobal.DeinitBiokey: WordBool;
begin
  Result := DefaultInterface.DeinitBiokey;
end;

function TEloamGlobal.GetBiokeyTemplate: WordBool;
begin
  Result := DefaultInterface.GetBiokeyTemplate;
end;

function TEloamGlobal.GetBiokeyTemplateData: IDispatch;
begin
  Result := DefaultInterface.GetBiokeyTemplateData;
end;

function TEloamGlobal.StopGetBiokeyTemplate: WordBool;
begin
  Result := DefaultInterface.StopGetBiokeyTemplate;
end;

function TEloamGlobal.GetBiokeyFeature: WordBool;
begin
  Result := DefaultInterface.GetBiokeyFeature;
end;

function TEloamGlobal.GetBiokeyFeatureData: IDispatch;
begin
  Result := DefaultInterface.GetBiokeyFeatureData;
end;

function TEloamGlobal.StopGetBiokeyFeature: WordBool;
begin
  Result := DefaultInterface.StopGetBiokeyFeature;
end;

function TEloamGlobal.BiokeyVerify(const pMemory1: IDispatch; const pMemory2: IDispatch): Integer;
begin
  Result := DefaultInterface.BiokeyVerify(pMemory1, pMemory2);
end;

function TEloamGlobal.InitTemplOcr: WordBool;
begin
  Result := DefaultInterface.InitTemplOcr;
end;

function TEloamGlobal.DeinitTemplOcr: WordBool;
begin
  Result := DefaultInterface.DeinitTemplOcr;
end;

function TEloamGlobal.DiscernTempl(const pImage: IDispatch; const pTempl: IDispatch): WordBool;
begin
  Result := DefaultInterface.DiscernTempl(pImage, pTempl);
end;

function TEloamGlobal.GetTemplResult: IDispatch;
begin
  Result := DefaultInterface.GetTemplResult;
end;

function TEloamGlobal.StopTemplDiscern: WordBool;
begin
  Result := DefaultInterface.StopTemplDiscern;
end;

function TEloamGlobal.WaitTemplDiscern: WordBool;
begin
  Result := DefaultInterface.WaitTemplDiscern;
end;

function TEloamGlobal.InitReader: WordBool;
begin
  Result := DefaultInterface.InitReader;
end;

function TEloamGlobal.DeinitReader: WordBool;
begin
  Result := DefaultInterface.DeinitReader;
end;

function TEloamGlobal.ReaderStart: WordBool;
begin
  Result := DefaultInterface.ReaderStart;
end;

function TEloamGlobal.ReaderGetCpuId: WideString;
begin
  Result := DefaultInterface.ReaderGetCpuId;
end;

function TEloamGlobal.ReaderStop: WordBool;
begin
  Result := DefaultInterface.ReaderStop;
end;

function TEloamGlobal.ReaderGetCpuCreditCardNumber: WideString;
begin
  Result := DefaultInterface.ReaderGetCpuCreditCardNumber;
end;

function TEloamGlobal.ReaderGetMemoryId: WideString;
begin
  Result := DefaultInterface.ReaderGetMemoryId;
end;

function TEloamGlobal.ReaderGetM1Id: WideString;
begin
  Result := DefaultInterface.ReaderGetM1Id;
end;

function TEloamGlobal.CreateDir(const dirPath: WideString): WordBool;
begin
  Result := DefaultInterface.CreateDir(dirPath);
end;

function TEloamGlobal.RemoveDir(const dirPath: WideString): WordBool;
begin
  Result := DefaultInterface.RemoveDir(dirPath);
end;

function TEloamGlobal.SetOcrLanguage(lang: Integer): WordBool;
begin
  Result := DefaultInterface.SetOcrLanguage(lang);
end;

function TEloamGlobal.SetTemplOcrLanguage(lang: Integer): WordBool;
begin
  Result := DefaultInterface.SetTemplOcrLanguage(lang);
end;

function TEloamGlobal.ReadIdCard: WordBool;
begin
  Result := DefaultInterface.ReadIdCard;
end;

function TEloamGlobal.CreateImageFromBase64(const base64: WideString; flag: Integer): IDispatch;
begin
  Result := DefaultInterface.CreateImageFromBase64(base64, flag);
end;

function TEloamGlobal.MagneticCardInit: WordBool;
begin
  Result := DefaultInterface.MagneticCardInit;
end;

function TEloamGlobal.MagneticCardDeinit: WordBool;
begin
  Result := DefaultInterface.MagneticCardDeinit;
end;

function TEloamGlobal.MagneticCardReaderStart: WordBool;
begin
  Result := DefaultInterface.MagneticCardReaderStart;
end;

function TEloamGlobal.MagneticCardReaderStop: WordBool;
begin
  Result := DefaultInterface.MagneticCardReaderStop;
end;

function TEloamGlobal.MagneticCardGetData(type_: Integer): WideString;
begin
  Result := DefaultInterface.MagneticCardGetData(type_);
end;

function TEloamGlobal.MagneticCardGetNumber: WideString;
begin
  Result := DefaultInterface.MagneticCardGetNumber;
end;

function TEloamGlobal.InitFaceDetect: WordBool;
begin
  Result := DefaultInterface.InitFaceDetect;
end;

function TEloamGlobal.DeinitFaceDetect: WordBool;
begin
  Result := DefaultInterface.DeinitFaceDetect;
end;

function TEloamGlobal.DiscernFaceDetect(const pImage1: IDispatch; const pImage2: IDispatch): Integer;
begin
  Result := DefaultInterface.DiscernFaceDetect(pImage1, pImage2);
end;

function TEloamGlobal.GetBiokeyImg: IDispatch;
begin
  Result := DefaultInterface.GetBiokeyImg;
end;

function TEloamGlobal.GetFaceRect(const image: IDispatch): IDispatch;
begin
  Result := DefaultInterface.GetFaceRect(image);
end;

function TEloamGlobal.VideoCapInit: WordBool;
begin
  Result := DefaultInterface.VideoCapInit;
end;

function TEloamGlobal.CreatVideoCap: IDispatch;
begin
  Result := DefaultInterface.CreatVideoCap;
end;

function TEloamGlobal.VideoCapGetAudioDevNum: Integer;
begin
  Result := DefaultInterface.VideoCapGetAudioDevNum;
end;

function TEloamGlobal.VideoCapGetAudioDevName(devIndex: Integer): WideString;
begin
  Result := DefaultInterface.VideoCapGetAudioDevName(devIndex);
end;

function TEloamGlobal.GetPrinterCount: Integer;
begin
  Result := DefaultInterface.GetPrinterCount;
end;

function TEloamGlobal.GetPrinterName(idx: Integer): WideString;
begin
  Result := DefaultInterface.GetPrinterName(idx);
end;

function TEloamGlobal.ReaderGetQuickPassData(type_: Integer): WideString;
begin
  Result := DefaultInterface.ReaderGetQuickPassData(type_);
end;

function TEloamGlobal.GetIdCardFingerprint: IDispatch;
begin
  Result := DefaultInterface.GetIdCardFingerprint;
end;

function TEloamGlobal.EnableFaceRectCrop(const pVideo: IDispatch; flag: Integer): WordBool;
begin
  Result := DefaultInterface.EnableFaceRectCrop(pVideo, flag);
end;

function TEloamGlobal.DisableFaceRectCrop(const pVideo: IDispatch): WordBool;
begin
  Result := DefaultInterface.DisableFaceRectCrop(pVideo);
end;

function TEloamGlobal.CpuGetBankCardTrack: WideString;
begin
  Result := DefaultInterface.CpuGetBankCardTrack;
end;

function TEloamGlobal.CpuGetRecordNumber: Integer;
begin
  Result := DefaultInterface.CpuGetRecordNumber;
end;

function TEloamGlobal.CpuGetankCardRecord(index: Integer): WideString;
begin
  Result := DefaultInterface.CpuGetankCardRecord(index);
end;

function TEloamGlobal.ReaderGetSocialCardData(type_: Integer): WideString;
begin
  Result := DefaultInterface.ReaderGetSocialCardData(type_);
end;

function TEloamGlobal.InitShenZhenTong: WordBool;
begin
  Result := DefaultInterface.InitShenZhenTong;
end;

function TEloamGlobal.DeinitShenZhenTong: WordBool;
begin
  Result := DefaultInterface.DeinitShenZhenTong;
end;

function TEloamGlobal.StartShenZhenTongCard: WordBool;
begin
  Result := DefaultInterface.StartShenZhenTongCard;
end;

function TEloamGlobal.StopShenZhenTongCard: WordBool;
begin
  Result := DefaultInterface.StopShenZhenTongCard;
end;

function TEloamGlobal.GetShenZhenTongNumber: WideString;
begin
  Result := DefaultInterface.GetShenZhenTongNumber;
end;

function TEloamGlobal.GetShenZhenTongAmount: WideString;
begin
  Result := DefaultInterface.GetShenZhenTongAmount;
end;

function TEloamGlobal.GetShenZhenTongCardRecordNumber: Integer;
begin
  Result := DefaultInterface.GetShenZhenTongCardRecordNumber;
end;

function TEloamGlobal.GetShenZhenTongCardRecord(index: Integer): WideString;
begin
  Result := DefaultInterface.GetShenZhenTongCardRecord(index);
end;

function TEloamGlobal.BiokeyVerifyFromString(const str1: WideString; const str2: WideString): Integer;
begin
  Result := DefaultInterface.BiokeyVerifyFromString(str1, str2);
end;

function TEloamGlobal.SetSoftDog(open: WordBool): WordBool;
begin
  Result := DefaultInterface.SetSoftDog(open);
end;

function TEloamGlobal.GetKeyFromSoftDog(len: Integer): WideString;
begin
  Result := DefaultInterface.GetKeyFromSoftDog(len);
end;

class function CoEloamDevice.Create: IEloamDevice;
begin
  Result := CreateComObject(CLASS_EloamDevice) as IEloamDevice;
end;

class function CoEloamDevice.CreateRemote(const MachineName: string): IEloamDevice;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_EloamDevice) as IEloamDevice;
end;

procedure TEloamDevice.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{33097953-5F00-44C6-8080-F0E91F1F8074}';
    IntfIID:   '{25519945-1DE4-484F-98AB-03D923F23B2C}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TEloamDevice.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IEloamDevice;
  end;
end;

procedure TEloamDevice.ConnectTo(svrIntf: IEloamDevice);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TEloamDevice.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TEloamDevice.GetDefaultInterface: IEloamDevice;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TEloamDevice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TEloamDevice.Destroy;
begin
  inherited Destroy;
end;

function TEloamDevice.Destroy1: WordBool;
begin
  Result := DefaultInterface.Destroy;
end;

function TEloamDevice.GetType: Integer;
begin
  Result := DefaultInterface.GetType;
end;

function TEloamDevice.GetIndex: Integer;
begin
  Result := DefaultInterface.GetIndex;
end;

function TEloamDevice.GetState: Integer;
begin
  Result := DefaultInterface.GetState;
end;

function TEloamDevice.GetFriendlyName: WideString;
begin
  Result := DefaultInterface.GetFriendlyName;
end;

function TEloamDevice.GetDisplayName: WideString;
begin
  Result := DefaultInterface.GetDisplayName;
end;

function TEloamDevice.GetSubtype: Integer;
begin
  Result := DefaultInterface.GetSubtype;
end;

function TEloamDevice.GetResolutionCount: Integer;
begin
  Result := DefaultInterface.GetResolutionCount;
end;

function TEloamDevice.GetResolutionWidth(idx: Integer): Integer;
begin
  Result := DefaultInterface.GetResolutionWidth(idx);
end;

function TEloamDevice.GetResolutionHeight(idx: Integer): Integer;
begin
  Result := DefaultInterface.GetResolutionHeight(idx);
end;

function TEloamDevice.PausePreview: WordBool;
begin
  Result := DefaultInterface.PausePreview;
end;

function TEloamDevice.ResumePreivew: WordBool;
begin
  Result := DefaultInterface.ResumePreivew;
end;

function TEloamDevice.GetVideoProcAmp(prop: Integer; value: Integer): Integer;
begin
  Result := DefaultInterface.GetVideoProcAmp(prop, value);
end;

function TEloamDevice.SetVideoProcAmp(prop: Integer; value: Integer; isAuto: WordBool): WordBool;
begin
  Result := DefaultInterface.SetVideoProcAmp(prop, value, isAuto);
end;

function TEloamDevice.GetCameraControl(prop: Integer; value: Integer): Integer;
begin
  Result := DefaultInterface.GetCameraControl(prop, value);
end;

function TEloamDevice.SetCameraControl(prop: Integer; value: Integer; isAuto: WordBool): WordBool;
begin
  Result := DefaultInterface.SetCameraControl(prop, value, isAuto);
end;

function TEloamDevice.ShowProperty(const pView: IDispatch): WordBool;
begin
  Result := DefaultInterface.ShowProperty(pView);
end;

function TEloamDevice.CreateVideo(resolution: Integer; subtype: Integer): IDispatch;
begin
  Result := DefaultInterface.CreateVideo(resolution, subtype);
end;

function TEloamDevice.GetSonixSerialNumber: WideString;
begin
  Result := DefaultInterface.GetSonixSerialNumber;
end;

function TEloamDevice.GetEloamType: Integer;
begin
  Result := DefaultInterface.GetEloamType;
end;

function TEloamDevice.GetScanSize: Integer;
begin
  Result := DefaultInterface.GetScanSize;
end;

function TEloamDevice.GetResolutionCountEx(subtype: Integer): Integer;
begin
  Result := DefaultInterface.GetResolutionCountEx(subtype);
end;

function TEloamDevice.GetResolutionWidthEx(subtype: Integer; idx: Integer): Integer;
begin
  Result := DefaultInterface.GetResolutionWidthEx(subtype, idx);
end;

function TEloamDevice.GetResolutionHeightEx(subtype: Integer; idx: Integer): Integer;
begin
  Result := DefaultInterface.GetResolutionHeightEx(subtype, idx);
end;

class function CoEloamHttp.Create: IEloamHttp;
begin
  Result := CreateComObject(CLASS_EloamHttp) as IEloamHttp;
end;

class function CoEloamHttp.CreateRemote(const MachineName: string): IEloamHttp;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_EloamHttp) as IEloamHttp;
end;

procedure TEloamHttp.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{FF57BABA-6F55-429F-BDDA-004433545E8B}';
    IntfIID:   '{145448B4-3E23-4B63-8626-2F476DCB1D66}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TEloamHttp.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IEloamHttp;
  end;
end;

procedure TEloamHttp.ConnectTo(svrIntf: IEloamHttp);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TEloamHttp.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TEloamHttp.GetDefaultInterface: IEloamHttp;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TEloamHttp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TEloamHttp.Destroy;
begin
  inherited Destroy;
end;

function TEloamHttp.Destroy1: WordBool;
begin
  Result := DefaultInterface.Destroy;
end;

function TEloamHttp.Upload(flag: Integer; const localPath: WideString; const headers: WideString; 
                           const predata: WideString; const taildata: WideString): WordBool;
begin
  Result := DefaultInterface.Upload(flag, localPath, headers, predata, taildata);
end;

function TEloamHttp.UploadMemory(flag: Integer; const pMemory: IDispatch; 
                                 const headers: WideString; const predata: WideString; 
                                 const taildata: WideString): WordBool;
begin
  Result := DefaultInterface.UploadMemory(flag, pMemory, headers, predata, taildata);
end;

function TEloamHttp.StopUpload: WordBool;
begin
  Result := DefaultInterface.StopUpload;
end;

function TEloamHttp.WaitUpload: WordBool;
begin
  Result := DefaultInterface.WaitUpload;
end;

function TEloamHttp.UploadImageFile(const fileName: WideString; const remoteName: WideString): WordBool;
begin
  Result := DefaultInterface.UploadImageFile(fileName, remoteName);
end;

function TEloamHttp.UploadImageMemory(const pMemory: IDispatch; const remoteName: WideString): WordBool;
begin
  Result := DefaultInterface.UploadImageMemory(pMemory, remoteName);
end;

function TEloamHttp.UploadImage(const pImage: IDispatch; fmt: Integer; flag: Integer; 
                                const remoteName: WideString): WordBool;
begin
  Result := DefaultInterface.UploadImage(pImage, fmt, flag, remoteName);
end;

function TEloamHttp.GetServerInfo: WideString;
begin
  Result := DefaultInterface.GetServerInfo;
end;

class function CoEloamFtp.Create: IEloamFtp;
begin
  Result := CreateComObject(CLASS_EloamFtp) as IEloamFtp;
end;

class function CoEloamFtp.CreateRemote(const MachineName: string): IEloamFtp;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_EloamFtp) as IEloamFtp;
end;

procedure TEloamFtp.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{906BE504-A92B-41CF-96A3-3F93FD688CDB}';
    IntfIID:   '{0C36E18A-6483-43C7-98CC-63B71729C092}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TEloamFtp.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IEloamFtp;
  end;
end;

procedure TEloamFtp.ConnectTo(svrIntf: IEloamFtp);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TEloamFtp.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TEloamFtp.GetDefaultInterface: IEloamFtp;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TEloamFtp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TEloamFtp.Destroy;
begin
  inherited Destroy;
end;

function TEloamFtp.Destroy1: WordBool;
begin
  Result := DefaultInterface.Destroy;
end;

function TEloamFtp.Upload(flag: Integer; const localPath: WideString; const remotePath: WideString): WordBool;
begin
  Result := DefaultInterface.Upload(flag, localPath, remotePath);
end;

function TEloamFtp.StopUpload: WordBool;
begin
  Result := DefaultInterface.StopUpload;
end;

function TEloamFtp.WaitUpload: WordBool;
begin
  Result := DefaultInterface.WaitUpload;
end;

function TEloamFtp.CreateDir(const dirPath: WideString): WordBool;
begin
  Result := DefaultInterface.CreateDir(dirPath);
end;

function TEloamFtp.RemoveDir(const dirPath: WideString): WordBool;
begin
  Result := DefaultInterface.RemoveDir(dirPath);
end;

class function CoEloamVideo.Create: IEloamVideo;
begin
  Result := CreateComObject(CLASS_EloamVideo) as IEloamVideo;
end;

class function CoEloamVideo.CreateRemote(const MachineName: string): IEloamVideo;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_EloamVideo) as IEloamVideo;
end;

procedure TEloamVideo.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{53EA3520-6591-4307-B0F6-C774F071D488}';
    IntfIID:   '{3176B9F7-557E-480E-997C-36B5F44CCA49}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TEloamVideo.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IEloamVideo;
  end;
end;

procedure TEloamVideo.ConnectTo(svrIntf: IEloamVideo);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TEloamVideo.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TEloamVideo.GetDefaultInterface: IEloamVideo;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TEloamVideo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TEloamVideo.Destroy;
begin
  inherited Destroy;
end;

function TEloamVideo.Destroy1: WordBool;
begin
  Result := DefaultInterface.Destroy;
end;

function TEloamVideo.GetDevice: IDispatch;
begin
  Result := DefaultInterface.GetDevice;
end;

function TEloamVideo.GetResolution: Integer;
begin
  Result := DefaultInterface.GetResolution;
end;

function TEloamVideo.GetSubtype: Integer;
begin
  Result := DefaultInterface.GetSubtype;
end;

function TEloamVideo.CreateImage(scanSize: Integer; const pView: IDispatch): IDispatch;
begin
  Result := DefaultInterface.CreateImage(scanSize, pView);
end;

function TEloamVideo.CreateImageList(scanSize: Integer; const pView: IDispatch): IDispatch;
begin
  Result := DefaultInterface.CreateImageList(scanSize, pView);
end;

function TEloamVideo.RotateLeft: WordBool;
begin
  Result := DefaultInterface.RotateLeft;
end;

function TEloamVideo.RotateRight: WordBool;
begin
  Result := DefaultInterface.RotateRight;
end;

function TEloamVideo.Rotate180: WordBool;
begin
  Result := DefaultInterface.Rotate180;
end;

function TEloamVideo.Flip: WordBool;
begin
  Result := DefaultInterface.Flip;
end;

function TEloamVideo.Mirror: WordBool;
begin
  Result := DefaultInterface.Mirror;
end;

function TEloamVideo.FlipAndMirror: WordBool;
begin
  Result := DefaultInterface.FlipAndMirror;
end;

function TEloamVideo.EnableGray: WordBool;
begin
  Result := DefaultInterface.EnableGray;
end;

function TEloamVideo.DisableGray: WordBool;
begin
  Result := DefaultInterface.DisableGray;
end;

function TEloamVideo.EnableThreshold(Threshold: Integer): WordBool;
begin
  Result := DefaultInterface.EnableThreshold(Threshold);
end;

function TEloamVideo.DisableThreshold: WordBool;
begin
  Result := DefaultInterface.DisableThreshold;
end;

function TEloamVideo.EnableDelBkColor(flag: Integer): WordBool;
begin
  Result := DefaultInterface.EnableDelBkColor(flag);
end;

function TEloamVideo.DisableDelBkColor: WordBool;
begin
  Result := DefaultInterface.DisableDelBkColor;
end;

function TEloamVideo.EnableAddText(const pFont: IDispatch; x: Integer; y: Integer; 
                                   const text: WideString; clr: OLE_COLOR; weight: Integer): WordBool;
begin
  Result := DefaultInterface.EnableAddText(pFont, x, y, text, clr, weight);
end;

function TEloamVideo.DisableAddText: WordBool;
begin
  Result := DefaultInterface.DisableAddText;
end;

function TEloamVideo.EnableDeskew(flag: Integer): WordBool;
begin
  Result := DefaultInterface.EnableDeskew(flag);
end;

function TEloamVideo.DisableDeskew: WordBool;
begin
  Result := DefaultInterface.DisableDeskew;
end;

function TEloamVideo.EnableReverse: WordBool;
begin
  Result := DefaultInterface.EnableReverse;
end;

function TEloamVideo.DisableReverse: WordBool;
begin
  Result := DefaultInterface.DisableReverse;
end;

function TEloamVideo.EnableMoveDetec(flag: Integer): WordBool;
begin
  Result := DefaultInterface.EnableMoveDetec(flag);
end;

function TEloamVideo.DisableMoveDetec: WordBool;
begin
  Result := DefaultInterface.DisableMoveDetec;
end;

function TEloamVideo.EnableDate(const pFont: IDispatch; x: Integer; y: Integer; clr: OLE_COLOR; 
                                weight: Integer): WordBool;
begin
  Result := DefaultInterface.EnableDate(pFont, x, y, clr, weight);
end;

function TEloamVideo.DisableDate: WordBool;
begin
  Result := DefaultInterface.DisableDate;
end;

function TEloamVideo.EnableAdaptiveThreshold(flag: Integer): WordBool;
begin
  Result := DefaultInterface.EnableAdaptiveThreshold(flag);
end;

function TEloamVideo.DisableAdaptiveThreshold: WordBool;
begin
  Result := DefaultInterface.DisableAdaptiveThreshold;
end;

function TEloamVideo.EnableSmooth(flag: Integer): WordBool;
begin
  Result := DefaultInterface.EnableSmooth(flag);
end;

function TEloamVideo.DisableSmooth: WordBool;
begin
  Result := DefaultInterface.DisableSmooth;
end;

function TEloamVideo.GetWidth: Integer;
begin
  Result := DefaultInterface.GetWidth;
end;

function TEloamVideo.GetHeight: Integer;
begin
  Result := DefaultInterface.GetHeight;
end;

function TEloamVideo.EnableAddTextEx(pos: Integer; const text: WideString; clr: OLE_COLOR; 
                                     weight: Integer): WordBool;
begin
  Result := DefaultInterface.EnableAddTextEx(pos, text, clr, weight);
end;

function TEloamVideo.EnableDeskewEx(flag: Integer): WordBool;
begin
  Result := DefaultInterface.EnableDeskewEx(flag);
end;

function TEloamVideo.EnableDateEx(pos: Integer; clr: OLE_COLOR; weight: Integer): WordBool;
begin
  Result := DefaultInterface.EnableDateEx(pos, clr, weight);
end;

function TEloamVideo.StartRecord(const filePath: WideString; flag: Integer): WordBool;
begin
  Result := DefaultInterface.StartRecord(filePath, flag);
end;

function TEloamVideo.StopRecord: WordBool;
begin
  Result := DefaultInterface.StopRecord;
end;

function TEloamVideo.CaputreImage: IDispatch;
begin
  Result := DefaultInterface.CaputreImage;
end;

function TEloamVideo.SetCropState(state: Integer): WordBool;
begin
  Result := DefaultInterface.SetCropState(state);
end;

function TEloamVideo.SetDisplayRect(const pRect: IDispatch; enable: WordBool): WordBool;
begin
  Result := DefaultInterface.SetDisplayRect(pRect, enable);
end;

procedure TEloamView.InitControlData;
const
  CEventDispIDs: array [0..1] of DWORD = (
    $00000001, $00000002);
  CControlData: TControlData2 = (
    ClassID:      '{26BA9E7F-78E9-4FB8-A05C-A4185D80D759}';
    EventIID:     '{F6F49968-91A3-4CD5-A866-6ED1216DDA22}';
    EventCount:   2;
    EventDispIDs: @CEventDispIDs;
    LicenseKey:   nil (*HR:$80004002*);
    Flags:        $00000000;
    Version:      500);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := UIntPtr(@@FOnVideoAttach) - UIntPtr(Self);
end;

procedure TEloamView.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IEloamView;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TEloamView.GetControlInterface: IEloamView;
begin
  CreateControl;
  Result := FIntf;
end;

function TEloamView.GetView: IDispatch;
begin
  Result := DefaultInterface.GetView;
end;

function TEloamView.SelectImage(const pImage: IDispatch): WordBool;
begin
  Result := DefaultInterface.SelectImage(pImage);
end;

function TEloamView.SelectVideo(const pVideo: IDispatch): WordBool;
begin
  Result := DefaultInterface.SelectVideo(pVideo);
end;

function TEloamView.SelectNull: WordBool;
begin
  Result := DefaultInterface.SelectNull;
end;

function TEloamView.SetZoomIn: WordBool;
begin
  Result := DefaultInterface.SetZoomIn;
end;

function TEloamView.SetZoomOut: WordBool;
begin
  Result := DefaultInterface.SetZoomOut;
end;

function TEloamView.SetOriginal: WordBool;
begin
  Result := DefaultInterface.SetOriginal;
end;

function TEloamView.SetAdapt: WordBool;
begin
  Result := DefaultInterface.SetAdapt;
end;

function TEloamView.SetFullScreen(bFull: WordBool): WordBool;
begin
  Result := DefaultInterface.SetFullScreen(bFull);
end;

function TEloamView.GetState: Integer;
begin
  Result := DefaultInterface.GetState;
end;

function TEloamView.SetState(state: Integer): WordBool;
begin
  Result := DefaultInterface.SetState(state);
end;

function TEloamView.SetBkColor(clr: OLE_COLOR): WordBool;
begin
  Result := DefaultInterface.SetBkColor(clr);
end;

function TEloamView.SetText(const text: WideString; clr: OLE_COLOR): WordBool;
begin
  Result := DefaultInterface.SetText(text, clr);
end;

function TEloamView.GetSelectRect: IDispatch;
begin
  Result := DefaultInterface.GetSelectRect;
end;

function TEloamView.SetSelectRect(const pRect: IDispatch): WordBool;
begin
  Result := DefaultInterface.SetSelectRect(pRect);
end;

function TEloamView.PlayCaptureEffect: WordBool;
begin
  Result := DefaultInterface.PlayCaptureEffect;
end;

function TEloamView.SetScale(scale: Integer): WordBool;
begin
  Result := DefaultInterface.SetScale(scale);
end;

function TEloamView.SetRatio(ratio: Integer): WordBool;
begin
  Result := DefaultInterface.SetRatio(ratio);
end;

function TEloamView.SetRectangleFormat(lineStyle: Integer; lineSize: Integer; lineColor: OLE_COLOR; 
                                       pointStyle: Integer; pointSize: Integer; 
                                       pointColor: OLE_COLOR): WordBool;
begin
  Result := DefaultInterface.SetRectangleFormat(lineStyle, lineSize, lineColor, pointStyle, 
                                                pointSize, pointColor);
end;

function TEloamView.SetCarpete: WordBool;
begin
  Result := DefaultInterface.SetCarpete;
end;

function TEloamView.DrawCustomRect(flag: Integer; const pRect: IDispatch; cWidth: Integer; 
                                   boxColor: OLE_COLOR): WordBool;
begin
  Result := DefaultInterface.DrawCustomRect(flag, pRect, cWidth, boxColor);
end;

procedure TEloamThumbnail.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID:      '{B5535A1B-D25B-4B3C-854F-94B12E284A4E}';
    EventIID:     '';
    EventCount:   0;
    EventDispIDs: nil;
    LicenseKey:   nil (*HR:$80004002*);
    Flags:        $00000000;
    Version:      500);
begin
  ControlData := @CControlData;
end;

procedure TEloamThumbnail.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IEloamThumbnail;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TEloamThumbnail.GetControlInterface: IEloamThumbnail;
begin
  CreateControl;
  Result := FIntf;
end;

function TEloamThumbnail.GetThumbnail: IDispatch;
begin
  Result := DefaultInterface.GetThumbnail;
end;

function TEloamThumbnail.Add(const fileName: WideString): WordBool;
begin
  Result := DefaultInterface.Add(fileName);
end;

function TEloamThumbnail.Insert(const fileName: WideString; pos: Integer): WordBool;
begin
  Result := DefaultInterface.Insert(fileName, pos);
end;

function TEloamThumbnail.Remove(idx: Integer; bDel: WordBool): WordBool;
begin
  Result := DefaultInterface.Remove(idx, bDel);
end;

function TEloamThumbnail.Clear(bDel: WordBool): WordBool;
begin
  Result := DefaultInterface.Clear(bDel);
end;

function TEloamThumbnail.GetCount: Integer;
begin
  Result := DefaultInterface.GetCount;
end;

function TEloamThumbnail.GetFileName(idx: Integer): WideString;
begin
  Result := DefaultInterface.GetFileName(idx);
end;

function TEloamThumbnail.GetSelected: Integer;
begin
  Result := DefaultInterface.GetSelected;
end;

function TEloamThumbnail.SetLanguage(langId: Integer): WordBool;
begin
  Result := DefaultInterface.SetLanguage(langId);
end;

function TEloamThumbnail.SetMenuItem(menuId: Integer; flag: Integer): WordBool;
begin
  Result := DefaultInterface.SetMenuItem(menuId, flag);
end;

function TEloamThumbnail.GetCheck(idx: Integer): WordBool;
begin
  Result := DefaultInterface.GetCheck(idx);
end;

function TEloamThumbnail.SetCheck(idx: Integer; bCheck: WordBool): WordBool;
begin
  Result := DefaultInterface.SetCheck(idx, bCheck);
end;

function TEloamThumbnail.HttpUploadCheckImage(const serverAddress: WideString; flag: Integer): WordBool;
begin
  Result := DefaultInterface.HttpUploadCheckImage(serverAddress, flag);
end;

function TEloamThumbnail.GetHttpServerInfo: WideString;
begin
  Result := DefaultInterface.GetHttpServerInfo;
end;

class function CoEloamRect.Create: IEloamRect;
begin
  Result := CreateComObject(CLASS_EloamRect) as IEloamRect;
end;

class function CoEloamRect.CreateRemote(const MachineName: string): IEloamRect;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_EloamRect) as IEloamRect;
end;

procedure TEloamRect.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{CCA81C37-D773-438A-A012-BFCA1ABDF1F4}';
    IntfIID:   '{5535094B-659B-4CF7-B137-80D47CC5F09E}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TEloamRect.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IEloamRect;
  end;
end;

procedure TEloamRect.ConnectTo(svrIntf: IEloamRect);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TEloamRect.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TEloamRect.GetDefaultInterface: IEloamRect;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TEloamRect.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TEloamRect.Destroy;
begin
  inherited Destroy;
end;

function TEloamRect.Destroy1: WordBool;
begin
  Result := DefaultInterface.Destroy;
end;

function TEloamRect.GetLeft: Integer;
begin
  Result := DefaultInterface.GetLeft;
end;

function TEloamRect.SetLeft(left: Integer): WordBool;
begin
  Result := DefaultInterface.SetLeft(left);
end;

function TEloamRect.GetTop: Integer;
begin
  Result := DefaultInterface.GetTop;
end;

function TEloamRect.SetTop(top: Integer): WordBool;
begin
  Result := DefaultInterface.SetTop(top);
end;

function TEloamRect.GetWidth: Integer;
begin
  Result := DefaultInterface.GetWidth;
end;

function TEloamRect.SetWidth(width: Integer): WordBool;
begin
  Result := DefaultInterface.SetWidth(width);
end;

function TEloamRect.GetHeight: Integer;
begin
  Result := DefaultInterface.GetHeight;
end;

function TEloamRect.SetHeight(height: Integer): WordBool;
begin
  Result := DefaultInterface.SetHeight(height);
end;

function TEloamRect.Copy(const pRect: IDispatch): WordBool;
begin
  Result := DefaultInterface.Copy(pRect);
end;

class function CoEloamFont.Create: IEloamFont;
begin
  Result := CreateComObject(CLASS_EloamFont) as IEloamFont;
end;

class function CoEloamFont.CreateRemote(const MachineName: string): IEloamFont;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_EloamFont) as IEloamFont;
end;

procedure TEloamFont.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{E7B4E568-3220-404A-8162-40AD462F8ECC}';
    IntfIID:   '{5AE529AC-DC9B-4302-AD18-25345168D61F}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TEloamFont.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IEloamFont;
  end;
end;

procedure TEloamFont.ConnectTo(svrIntf: IEloamFont);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TEloamFont.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TEloamFont.GetDefaultInterface: IEloamFont;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TEloamFont.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TEloamFont.Destroy;
begin
  inherited Destroy;
end;

function TEloamFont.Destroy1: WordBool;
begin
  Result := DefaultInterface.Destroy;
end;

class function CoEloamTempl.Create: IEloamTempl;
begin
  Result := CreateComObject(CLASS_EloamTempl) as IEloamTempl;
end;

class function CoEloamTempl.CreateRemote(const MachineName: string): IEloamTempl;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_EloamTempl) as IEloamTempl;
end;

procedure TEloamTempl.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{6DE227A8-CA19-4743-ACEC-979E5A4A09F9}';
    IntfIID:   '{1B5B6E01-2D99-4D1A-ABE9-0C2109F0AB35}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TEloamTempl.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IEloamTempl;
  end;
end;

procedure TEloamTempl.ConnectTo(svrIntf: IEloamTempl);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TEloamTempl.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TEloamTempl.GetDefaultInterface: IEloamTempl;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TEloamTempl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TEloamTempl.Destroy;
begin
  inherited Destroy;
end;

function TEloamTempl.Destroy1: WordBool;
begin
  Result := DefaultInterface.Destroy;
end;

function TEloamTempl.GetName: WideString;
begin
  Result := DefaultInterface.GetName;
end;

function TEloamTempl.GetId: WideString;
begin
  Result := DefaultInterface.GetId;
end;

function TEloamTempl.AppendField(const fieldName: WideString; type_: Integer; left: Single; 
                                 top: Single; right: Single; bottom: Single): WordBool;
begin
  Result := DefaultInterface.AppendField(fieldName, type_, left, top, right, bottom);
end;

function TEloamTempl.GetFieldCount: Integer;
begin
  Result := DefaultInterface.GetFieldCount;
end;

function TEloamTempl.ClearField: WordBool;
begin
  Result := DefaultInterface.ClearField;
end;

function TEloamTempl.GetFieldName(idx: Integer): WideString;
begin
  Result := DefaultInterface.GetFieldName(idx);
end;

function TEloamTempl.GetFieldRectLeft(idx: Integer): Single;
begin
  Result := DefaultInterface.GetFieldRectLeft(idx);
end;

function TEloamTempl.GetFieldRectTop(idx: Integer): Single;
begin
  Result := DefaultInterface.GetFieldRectTop(idx);
end;

function TEloamTempl.GetFieldRectRight(idx: Integer): Single;
begin
  Result := DefaultInterface.GetFieldRectRight(idx);
end;

function TEloamTempl.GetFieldRectBottom(idx: Integer): Single;
begin
  Result := DefaultInterface.GetFieldRectBottom(idx);
end;

function TEloamTempl.GetFieldResult(idx: Integer): WideString;
begin
  Result := DefaultInterface.GetFieldResult(idx);
end;

function TEloamTempl.SetFieldResult(idx: Integer; const res: WideString): WordBool;
begin
  Result := DefaultInterface.SetFieldResult(idx, res);
end;

function TEloamTempl.GetData(flag: Integer): WideString;
begin
  Result := DefaultInterface.GetData(flag);
end;

function TEloamTempl.Save(const fileName: WideString; flag: Integer): WordBool;
begin
  Result := DefaultInterface.Save(fileName, flag);
end;

function TEloamTempl.GetFieldType(idx: Integer): Integer;
begin
  Result := DefaultInterface.GetFieldType(idx);
end;

class function CoEloamVideoCap.Create: IEloamVideoCap;
begin
  Result := CreateComObject(CLASS_EloamVideoCap) as IEloamVideoCap;
end;

class function CoEloamVideoCap.CreateRemote(const MachineName: string): IEloamVideoCap;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_EloamVideoCap) as IEloamVideoCap;
end;

procedure TEloamVideoCap.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{5E155920-EF13-4C5B-A225-DB6AD2866A89}';
    IntfIID:   '{7F495A96-C99E-4719-9657-0D1652F4E9D8}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TEloamVideoCap.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IEloamVideoCap;
  end;
end;

procedure TEloamVideoCap.ConnectTo(svrIntf: IEloamVideoCap);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TEloamVideoCap.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TEloamVideoCap.GetDefaultInterface: IEloamVideoCap;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TEloamVideoCap.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TEloamVideoCap.Destroy;
begin
  inherited Destroy;
end;

function TEloamVideoCap.Destroy1: WordBool;
begin
  Result := DefaultInterface.Destroy;
end;

function TEloamVideoCap.VideoCapPreCap(const fileName: WideString; micIndex: Integer; 
                                       frameRate: Integer; compressMode: Integer; width: Integer; 
                                       heigth: Integer): WordBool;
begin
  Result := DefaultInterface.VideoCapPreCap(fileName, micIndex, frameRate, compressMode, width, 
                                            heigth);
end;

function TEloamVideoCap.VideoCapStart: WordBool;
begin
  Result := DefaultInterface.VideoCapStart;
end;

function TEloamVideoCap.VideoCapStop: WordBool;
begin
  Result := DefaultInterface.VideoCapStop;
end;

function TEloamVideoCap.VideoCapPause: WordBool;
begin
  Result := DefaultInterface.VideoCapPause;
end;

function TEloamVideoCap.VideoCapSetWatermark(Watermark: Integer; AddTime: Integer; mode: Integer; 
                                             pos: Integer; alpha: Integer; 
                                             const imgPath: WideString; const pStrText: WideString; 
                                             color: Integer; const faceName: WideString; 
                                             weight: Integer; height: Integer; italic: Integer): WordBool;
begin
  Result := DefaultInterface.VideoCapSetWatermark(Watermark, AddTime, mode, pos, alpha, imgPath, 
                                                  pStrText, color, faceName, weight, height, italic);
end;

function TEloamVideoCap.VideoCapAddVideoSrc(const video: IDispatch): WordBool;
begin
  Result := DefaultInterface.VideoCapAddVideoSrc(video);
end;

function TEloamVideoCap.VideoCapAddVideoSrcEx(const video: IDispatch; x: Integer; y: Integer; 
                                              width: Integer; heigth: Integer): WordBool;
begin
  Result := DefaultInterface.VideoCapAddVideoSrcEx(video, x, y, width, heigth);
end;

function TEloamVideoCap.VideoCapRemoveAllVideoSrc: WordBool;
begin
  Result := DefaultInterface.VideoCapRemoveAllVideoSrc;
end;

function TEloamVideoCap.VideoCapGetState: Integer;
begin
  Result := DefaultInterface.VideoCapGetState;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TEloamView, TEloamThumbnail]);
  RegisterComponents(dtlServerPage, [TEloamImage, TEloamImageList, TEloamMemory, TEloamGlobal, 
    TEloamDevice, TEloamHttp, TEloamFtp, TEloamVideo, TEloamRect, 
    TEloamFont, TEloamTempl, TEloamVideoCap]);
end;

end.
