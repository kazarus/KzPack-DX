unit SCANCTRLLib_TLB;

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
// File generated on 2013-06-08 16:18:59 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\WINDOWS\system32\scanctrl.ocx (1)
// LIBID: {7839D2AC-4592-4538-BFD7-EF0A3612FE14}
// LCID: 0
// Helpfile: C:\WINDOWS\system32\ScanCtrl.hlp
// HelpString: ScanCtrl ActiveX Control module
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Errors:
//   Hint: Member 'Property' of '_DScanCtrl' changed to 'Property_'
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
  SCANCTRLLibMajorVersion = 1;
  SCANCTRLLibMinorVersion = 0;

  LIBID_SCANCTRLLib: TGUID = '{7839D2AC-4592-4538-BFD7-EF0A3612FE14}';

  DIID__DScanCtrl: TGUID = '{3FA71A06-4D49-4BD7-8F93-C74B769C2FB5}';
  DIID__DScanCtrlEvents: TGUID = '{27F742CB-5180-4C78-B04D-D617E057347D}';
  CLASS_ScanCtrl: TGUID = '{090457CB-DF21-41EB-84BB-39AAFC9E271A}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _DScanCtrl = dispinterface;
  _DScanCtrlEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  ScanCtrl = _DScanCtrl;


// *********************************************************************//
// DispIntf:  _DScanCtrl
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3FA71A06-4D49-4BD7-8F93-C74B769C2FB5}
// *********************************************************************//
  _DScanCtrl = dispinterface
    ['{3FA71A06-4D49-4BD7-8F93-C74B769C2FB5}']
    procedure StartPreview; dispid 1;
    procedure StopPreview; dispid 2;
    function GetResolutionCount: Smallint; dispid 3;
    function GetResolutionWidth(idx: Smallint): Smallint; dispid 4;
    function GetResolutionHeight(idx: Smallint): Smallint; dispid 5;
    function GetScanSizeCount: Smallint; dispid 6;
    function Scan(const filename: WideString): WordBool; dispid 7;
    function SetResolution(idx: Smallint): WordBool; dispid 8;
    function SetScanSize(idx: Smallint): WordBool; dispid 9;
    function SetVideoRotate(idx: Smallint): WordBool; dispid 10;
    function SetVideoColor(idx: Smallint): WordBool; dispid 11;
    function SetThresVal(idx: Smallint): WordBool; dispid 12;
    procedure Property_; dispid 13;
    function Scan2FTP(const username: WideString; const password: WideString; 
                      const ftppath: WideString; const filename: WideString; ftpport: Smallint): WordBool; dispid 14;
    function SaveToURL(const url: WideString; const filename: WideString): WordBool; dispid 15;
    function GetPhotoBuffer: WideString; dispid 16;
    procedure SetJpegQuality(quality: Single); dispid 17;
    function ScanBase64(const filename: WideString): WideString; dispid 18;
    function ScanFront: Smallint; dispid 19;
    function ScanBack: WideString; dispid 20;
    function QuickScan(const filename: WideString): WordBool; dispid 21;
    function Scan2HttpServer(const url: WideString): WordBool; dispid 22;
    function ResampleImage(width: Smallint; height: Smallint): WordBool; dispid 23;
    function AddText(const filepath: WideString; x: Smallint; y: Smallint; const text: WideString): WordBool; dispid 24;
    function ScanPage: Smallint; dispid 25;
    function SaveTifFile(const filename: WideString): Smallint; dispid 26;
    procedure SetScanSizeCustom(t: Smallint; b: Smallint; l: Smallint; r: Smallint); dispid 27;
    procedure SetMirror(bMirror: WordBool); dispid 28;
    procedure SetFlip(bFlip: WordBool); dispid 29;
    function DeleteMyFile(const filename: WideString): WordBool; dispid 30;
    procedure SetCenter(x: Smallint; y: Smallint); dispid 31;
    procedure SetCenterX(x: Smallint); dispid 32;
    procedure SetCenterY(y: Smallint); dispid 33;
    procedure OpenDevice; dispid 34;
    procedure CloseDevice; dispid 35;
    procedure AboutBox; dispid -552;
  end;

// *********************************************************************//
// DispIntf:  _DScanCtrlEvents
// Flags:     (4096) Dispatchable
// GUID:      {27F742CB-5180-4C78-B04D-D617E057347D}
// *********************************************************************//
  _DScanCtrlEvents = dispinterface
    ['{27F742CB-5180-4C78-B04D-D617E057347D}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TScanCtrl
// Help String      : ScanCtrl Control
// Default Interface: _DScanCtrl
// Def. Intf. DISP? : Yes
// Event   Interface: _DScanCtrlEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TScanCtrl = class(TOleControl)
  private
    FIntf: _DScanCtrl;
    function  GetControlInterface: _DScanCtrl;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure StartPreview;
    procedure StopPreview;
    function GetResolutionCount: Smallint;
    function GetResolutionWidth(idx: Smallint): Smallint;
    function GetResolutionHeight(idx: Smallint): Smallint;
    function GetScanSizeCount: Smallint;
    function Scan(const filename: WideString): WordBool;
    function SetResolution(idx: Smallint): WordBool;
    function SetScanSize(idx: Smallint): WordBool;
    function SetVideoRotate(idx: Smallint): WordBool;
    function SetVideoColor(idx: Smallint): WordBool;
    function SetThresVal(idx: Smallint): WordBool;
    procedure Property_;
    function Scan2FTP(const username: WideString; const password: WideString; 
                      const ftppath: WideString; const filename: WideString; ftpport: Smallint): WordBool;
    function SaveToURL(const url: WideString; const filename: WideString): WordBool;
    function GetPhotoBuffer: WideString;
    procedure SetJpegQuality(quality: Single);
    function ScanBase64(const filename: WideString): WideString;
    function ScanFront: Smallint;
    function ScanBack: WideString;
    function QuickScan(const filename: WideString): WordBool;
    function Scan2HttpServer(const url: WideString): WordBool;
    function ResampleImage(width: Smallint; height: Smallint): WordBool;
    function AddText(const filepath: WideString; x: Smallint; y: Smallint; const text: WideString): WordBool;
    function ScanPage: Smallint;
    function SaveTifFile(const filename: WideString): Smallint;
    procedure SetScanSizeCustom(t: Smallint; b: Smallint; l: Smallint; r: Smallint);
    procedure SetMirror(bMirror: WordBool);
    procedure SetFlip(bFlip: WordBool);
    function DeleteMyFile(const filename: WideString): WordBool;
    procedure SetCenter(x: Smallint; y: Smallint);
    procedure SetCenterX(x: Smallint);
    procedure SetCenterY(y: Smallint);
    procedure OpenDevice;
    procedure CloseDevice;
    procedure AboutBox;
    property  ControlInterface: _DScanCtrl read GetControlInterface;
    property  DefaultInterface: _DScanCtrl read GetControlInterface;
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

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TScanCtrl.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{090457CB-DF21-41EB-84BB-39AAFC9E271A}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TScanCtrl.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DScanCtrl;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TScanCtrl.GetControlInterface: _DScanCtrl;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TScanCtrl.StartPreview;
begin
  DefaultInterface.StartPreview;
end;

procedure TScanCtrl.StopPreview;
begin
  DefaultInterface.StopPreview;
end;

function TScanCtrl.GetResolutionCount: Smallint;
begin
  Result := DefaultInterface.GetResolutionCount;
end;

function TScanCtrl.GetResolutionWidth(idx: Smallint): Smallint;
begin
  Result := DefaultInterface.GetResolutionWidth(idx);
end;

function TScanCtrl.GetResolutionHeight(idx: Smallint): Smallint;
begin
  Result := DefaultInterface.GetResolutionHeight(idx);
end;

function TScanCtrl.GetScanSizeCount: Smallint;
begin
  Result := DefaultInterface.GetScanSizeCount;
end;

function TScanCtrl.Scan(const filename: WideString): WordBool;
begin
  Result := DefaultInterface.Scan(filename);
end;

function TScanCtrl.SetResolution(idx: Smallint): WordBool;
begin
  Result := DefaultInterface.SetResolution(idx);
end;

function TScanCtrl.SetScanSize(idx: Smallint): WordBool;
begin
  Result := DefaultInterface.SetScanSize(idx);
end;

function TScanCtrl.SetVideoRotate(idx: Smallint): WordBool;
begin
  Result := DefaultInterface.SetVideoRotate(idx);
end;

function TScanCtrl.SetVideoColor(idx: Smallint): WordBool;
begin
  Result := DefaultInterface.SetVideoColor(idx);
end;

function TScanCtrl.SetThresVal(idx: Smallint): WordBool;
begin
  Result := DefaultInterface.SetThresVal(idx);
end;

procedure TScanCtrl.Property_;
begin
  DefaultInterface.Property_;
end;

function TScanCtrl.Scan2FTP(const username: WideString; const password: WideString; 
                            const ftppath: WideString; const filename: WideString; ftpport: Smallint): WordBool;
begin
  Result := DefaultInterface.Scan2FTP(username, password, ftppath, filename, ftpport);
end;

function TScanCtrl.SaveToURL(const url: WideString; const filename: WideString): WordBool;
begin
  Result := DefaultInterface.SaveToURL(url, filename);
end;

function TScanCtrl.GetPhotoBuffer: WideString;
begin
  Result := DefaultInterface.GetPhotoBuffer;
end;

procedure TScanCtrl.SetJpegQuality(quality: Single);
begin
  DefaultInterface.SetJpegQuality(quality);
end;

function TScanCtrl.ScanBase64(const filename: WideString): WideString;
begin
  Result := DefaultInterface.ScanBase64(filename);
end;

function TScanCtrl.ScanFront: Smallint;
begin
  Result := DefaultInterface.ScanFront;
end;

function TScanCtrl.ScanBack: WideString;
begin
  Result := DefaultInterface.ScanBack;
end;

function TScanCtrl.QuickScan(const filename: WideString): WordBool;
begin
  Result := DefaultInterface.QuickScan(filename);
end;

function TScanCtrl.Scan2HttpServer(const url: WideString): WordBool;
begin
  Result := DefaultInterface.Scan2HttpServer(url);
end;

function TScanCtrl.ResampleImage(width: Smallint; height: Smallint): WordBool;
begin
  Result := DefaultInterface.ResampleImage(width, height);
end;

function TScanCtrl.AddText(const filepath: WideString; x: Smallint; y: Smallint; 
                           const text: WideString): WordBool;
begin
  Result := DefaultInterface.AddText(filepath, x, y, text);
end;

function TScanCtrl.ScanPage: Smallint;
begin
  Result := DefaultInterface.ScanPage;
end;

function TScanCtrl.SaveTifFile(const filename: WideString): Smallint;
begin
  Result := DefaultInterface.SaveTifFile(filename);
end;

procedure TScanCtrl.SetScanSizeCustom(t: Smallint; b: Smallint; l: Smallint; r: Smallint);
begin
  DefaultInterface.SetScanSizeCustom(t, b, l, r);
end;

procedure TScanCtrl.SetMirror(bMirror: WordBool);
begin
  DefaultInterface.SetMirror(bMirror);
end;

procedure TScanCtrl.SetFlip(bFlip: WordBool);
begin
  DefaultInterface.SetFlip(bFlip);
end;

function TScanCtrl.DeleteMyFile(const filename: WideString): WordBool;
begin
  Result := DefaultInterface.DeleteMyFile(filename);
end;

procedure TScanCtrl.SetCenter(x: Smallint; y: Smallint);
begin
  DefaultInterface.SetCenter(x, y);
end;

procedure TScanCtrl.SetCenterX(x: Smallint);
begin
  DefaultInterface.SetCenterX(x);
end;

procedure TScanCtrl.SetCenterY(y: Smallint);
begin
  DefaultInterface.SetCenterY(y);
end;

procedure TScanCtrl.OpenDevice;
begin
  DefaultInterface.OpenDevice;
end;

procedure TScanCtrl.CloseDevice;
begin
  DefaultInterface.CloseDevice;
end;

procedure TScanCtrl.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TScanCtrl]);
end;

end.
