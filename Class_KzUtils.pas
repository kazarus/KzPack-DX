unit Class_KzUtils;
//YXC_2012_02_18_16_29_17_add_method_tryfreeandnil
//YXC_2012_07_28_17_39_22_add_line_135
//YXC_2012_07_30_17_39_19_add_floattotext&texttofloat
//YXC_2012_08_01_15_42_20_add_justcleanlist();
//YXC_2012_08_10_12_49_52_add_tryformatcode&formatcode
//YXC_2012_08_10_12_50_18_add_strxcutzero&strxcutmark
//YXC_2012_10_31_15_10_29_add_exepath;
//YXC_2012_10_31_15_25_47_add_inputqueryex
//YXC_2012_11_28_15_45_59_add_comparetextlike
//YXC_2012_12_03_20_34_31_add_endtask
//YXC_2012_12_28_10_57_20_modify_tryformatcode.aboolprev->tryformatcode.ABoolBack
//YXC_2013_01_05_18_05_42_modify_double->extended
//YXC_2013_08_14_11_10_31_add_numbinrect
//YXC_2013_09_06_14_00_26_modify_floattotext_add_aformat:paramter
//YXC_2014_03_27_11_20_54_add_inttodatex
//YXC_2014_05_09_22_56_08_add_jsencode%jsdecode.must be thanks:wr960204:http://www.raysoftware.cn
//YXC_2014_05_29_14_06_22_add_getguid
//YXC_2015_11_30_10_00_41_add_stringtocolordef

interface
uses
  Classes,SysUtils,Variants,StrUtils,System.DateUtils,
  {$IFDEF MSWINDOWS} Windows,Vcl.Forms,TLHelp32,Vcl.Graphics,{$ENDIF}
  {$IFDEF ENABLE_REGEX}
       PerlRegEx, pcre
  {$ELSE}
       RegularExpressionsCore
  {$IFEND};

type
  TKzUtils=class(TObject)
  public
    //TLHelp32
    {$IFDEF MSWINDOWS}
    class function  EndTask(AExeName:string):Integer;
    {$ENDIF}
    //System
    class function  GetOrd(AChar:Char):Integer;
    class function  GetChr(AIdex:Integer):string;
    class function  IfThen(ABool:Boolean;ATrue,AFail:Variant):Variant;
    class function  GetGUID:string;
       
    //Forms
    class function  ExePath:string;
    class function  Explore:string;

    class procedure ShowMsg(aValue:string);overload;
    class procedure ShowMsg(const Msg: string; Params: array of const);overload;

    class function  ShowBox(aValue:string):Integer;
    class function  ShowFmt(const Msg: string; Params: array of const):Integer;

    class procedure WarnMsg(aValue:string);overload;
    class procedure WarnMsg(const Msg: string; Params: array of const);overload;

    class function  WarnBox(aValue:string):Integer;
    class function  WarnFmt(const Msg: string; Params: array of const):Integer;

    class procedure ErorMsg(aValue:string);overload;
    class procedure ErorMsg(const Msg: string; Params: array of const);overload;

    class function  ErorBox(aValue:string):Integer;
    class function  ErorFmt(const Msg: string; Params: array of const):Integer;

    class procedure WritLog(aValue:Variant);
    class procedure WritFmt(const Msg: string; Params: array of const);


    class function  jsencode(const aValue: Widestring): Widestring;
    class function  jsdecode(const aValue: Widestring): Widestring;
    class function  HashCode(const aValue: string):Integer;

    class procedure TryFreeAndNil(var AObject);
    class procedure JustCleanList(var AObject);

    class function  DateToInt(aValue:TDateTime):Integer;
    class function  DateToFloat(aValue:TDateTime):Extended;
    class function  StrToDateX(aValue:string):Integer;
    class function  IntToDateX(aValue:Integer):TDateTime;
    class function  FloatToDate(aValue:Extended):TDateTime;
    class function  FloatToTime(aValue:Extended):TDateTime;

    class function  DateIsNull(ADate:TDateTime):Boolean;

    class function  NumbInRect(aValue:Integer;aHead,ANext:Integer):Boolean;overload;
    class function  NumbInRect(aValue:Integer;aArrayOfInteger:array of Integer):Boolean;overload;
    class function  NumbInRect(aValue:Extended;aHead,ANext:Extended):Boolean;overload;
    class function  NumbInRect(aValue:Integer;aArrayOfChar:array of Char):Boolean;overload;
    class function  NumbInRect(aValue:Integer;aBunchOfInteger:string):Boolean;overload;
    {$IFDEF MSWINDOWS}
    class function  InputQueryEx(const ACaption, APrompt: string;var Value: string;IsPassWord:Boolean=True): Boolean;
    {$ENDIF}
    class function  CompareTextLike(APart,ALong:string):Boolean;
    {$IFDEF MSWINDOWS}
    class function  StringToColorDef(const aValue:string;const ADef:string='clWhite'):TColor;
    {$ENDIF}
  public
    class function  FloatToText(aValue: Extended; Zero:Boolean=False; Digits: Integer=2;AFormat: TFloatFormat=ffNumber):string;
    class function  TextToFloat(aValue:string):Extended;

    class function  StrxCutZero(Source:string):string;
    class function  StrxCutMark(Source:string):string;

    class function  TryFormatCode(aValue,ALength:Integer;const AText:string):string;overload;
    class function  FormatCode(aValue,ALength:Integer):string;overload;

    class function  TryFormatCode(ALength,ABoolBack:Integer;const AStrSub,ASource:string):string;overload;
    class function  FormatCode(aValue:string;ALength:Integer;AStrSub:string):string;overload;
  public
    //PerlRegEx
    class function  StrsStrCutted(const Source:string;ATag:string):TStrings;
    class procedure ListStrCutted(const Source:string;ATag:string;var Result:TStrings);
    class procedure ListMatchText(const Source:string;ATag:string;var Result:TStrings);
    class function  StrsStrMatchx(const Source:string;ATag:string):TStrings;
    class function  BoolStrMatchx(const Source:string;ATag:string;var aValue:string):Boolean;
    class function  RegReplaceAll(const Source:string;ATag:string;AReplacement:string):string;
  end;


implementation

{$IFDEF MSWINDOWS}
uses
  Vcl.Dialogs,Vcl.StdCtrls,Vcl.Consts,Vcl.Controls,Winapi.ShellAPI;
{$ENDIF}

{ TKzUtils }

class function TKzUtils.BoolStrMatchx(const Source: string;
  ATag: string;var aValue:string): Boolean;
var
  PerlA:TPerlRegEx;  
begin
  Result:=False;
  aValue:='';
  try
    //PerlA:=TPerlRegEx.Create;
    PerlA:=TPerlRegEx.Create;
    PerlA.Subject:=Source;
    PerlA.RegEx  :=ATag;
    Result:=PerlA.Match;
    if Result then
    begin
      aValue:=PerlA.MatchedText;
      //aValue:=PerlA.MatchedText;
    end;
  finally
    FreeAndNil(PerlA);
  end;
end;

class function TKzUtils.ErorBox(aValue: string): Integer;
begin
  {$IFDEF MSWINDOWS}
  Result:=Application.MessageBox(Pchar(aValue),'警告',MB_OKCANCEL+MB_ICONERROR);
  {$ENDIF}
end;

class function TKzUtils.FloatToDate(aValue: Extended): TDateTime;
var
  TMPA:string;
  TMPB:string;
begin
  Result:=Unassigned;
  if aValue=0 then Exit;
  TMPA:=FloatToStr(aValue);
  TMPB:=Format('%s-%s-%s',[Copy(TMPA,1,4),Copy(TMPA,5,2),Copy(TMPA,7,2)]);


  try
    //#DateSeparator:='-';
    FormatSettings.DateSeparator:='-';
    Result:=StrToDate(TMPB);
  except
    on E:Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

class function TKzUtils.FloatToText(aValue: Extended; Zero: Boolean;
  Digits: Integer;AFormat:TFloatFormat): string;
begin
  if (aValue <>0) or Zero then
    Result:= FloatToStrF(aValue, AFormat, 18, Digits)
  else
    Result:= '';
end;

class function TKzUtils.FloatToTime(aValue: Extended): TDateTime;
var
  cTMP:string;
  dTMP:string;
begin
  Result:=Unassigned;
  if aValue=0 then Exit;
  cTMP:=FloatToStr(aValue);
  //20170303213256->2017-03-07 21:32:56
  dTMP:=Format('%s-%s-%s %s:%s:%s',[Copy(cTMP,1,4),Copy(cTMP,5,2),Copy(cTMP,7,2),Copy(cTMP,9,2),Copy(cTMP,11,2),Copy(cTMP,13,2)]);


  try
    //#DateSeparator:='-';
    FormatSettings.DateSeparator:='-';
    FormatSettings.TimeSeparator:=':';
    FormatSettings.LongDateFormat:='yyyy-MM-dd';
    FormatSettings.LongTimeFormat:='hh:mm:ss';
    Result:=StrToDateTime(dTMP);
  except
    on E:Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

class function TKzUtils.FormatCode(aValue: string; ALength: Integer;
  AStrSub: string): string;
begin
  Result:=TryFormatCode(ALength,1,AStrSub,aValue);
end;

class function TKzUtils.FormatCode(aValue, ALength: Integer): string;
begin
  Result:=TryFormatCode(aValue,ALength,'0');
end;

{$IFDEF MSWINDOWS}
class function TKzUtils.InputQueryEx(const ACaption, APrompt: string;
  var Value: string;IsPassWord:Boolean): Boolean;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;

  function GetAveCharSize(Canvas: TCanvas): TPoint;
  var
    I: Integer;
    Buffer: array[0..51] of Char;
  begin
    for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
    for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
    GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
    Result.X := Result.X div 52;
  end;
begin
  Result := False;
  Form := TForm.Create(Application);
  with Form do
  try
    Canvas.Font := Font;
    DialogUnits := GetAveCharSize(Canvas);
    BorderStyle := bsDialog;
    Caption := ACaption;
    ClientWidth := MulDiv(180, DialogUnits.X, 4);
    Position := poScreenCenter;
    Prompt := TLabel.Create(Form);
    with Prompt do
    begin
      Parent := Form;
      Caption := APrompt;
      Left := MulDiv(8, DialogUnits.X, 4);
      Top := MulDiv(8, DialogUnits.Y, 8);
      AutoSize:=False;
      Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
      WordWrap := True;
    end;
    Edit := TEdit.Create(Form);
    with Edit do
    begin
      Parent := Form;
      Left := Prompt.Left;
      Top := Prompt.Top + Prompt.Height + 5;
      Width := MulDiv(166, DialogUnits.X, 4);
      MaxLength := 255;
      Text := Value;
      
      if IsPassWord then
      begin
        PasswordChar:='*';
      end;

      SelectAll;
    end;
    ButtonTop := Edit.Top + Edit.Height + 15;
    ButtonWidth := MulDiv(50, DialogUnits.X, 4);
    ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
    with TButton.Create(Form) do
    begin
      Parent := Form;
      Caption := '确定';
      ModalResult := mrOk;
      Default := True;
      SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
        ButtonHeight);
    end;
    with TButton.Create(Form) do
    begin
      Parent := Form;
      Caption := '取消';
      ModalResult := mrCancel;
      Cancel := True;
      SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15,
        ButtonWidth, ButtonHeight);
      Form.ClientHeight := Top + Height + 13;
    end;
    if ShowModal = mrOk then
    begin
      Value := Edit.Text;
      Result := True;
    end;
  finally
    Form.Free;
  end;
end;
{$ENDIF}

class function  TKzUtils.CompareTextLike(APart,ALong:string):Boolean;
var
  NumbA:Integer;
  TMPA:string;
begin
  Result:=False;
  Result:=Pos(APart,ALong)=1;
  {Result:=False;
  NumbA:=Length(APart);
  TMPA:=Copy(ALong,1,NumbA);
  if TMPA=APart then
  begin
    Result:=True;
  end;}
end;


class procedure TKzUtils.JustCleanList(var AObject);
var
  I:Integer;
begin
  if TObject(AObject)=nil then Exit;

  if (TObject(AObject).ClassType = TStringList) or (TObject(AObject).InheritsFrom(TStringList)) then
  begin
    for I:=0 to TStringList(AObject).Count -1 do
    begin
      if TStringList(AObject).Objects[I]<>nil then
      begin
        TStringList(AObject).Objects[I].Free;
        TStringList(AObject).Objects[I]:=nil;
      end;
    end;
    TStringList(AObject).Clear;
    TStringList(AObject).Sorted:=False;
  end else
  if (TObject(AObject).ClassType = TList) or (TObject(AObject).InheritsFrom(TList)) then
  begin
    for I:=0 to TList(AObject).Count-1 do
    begin
      if TList(AObject).Items[I]<>nil then
      begin
        TObject(TList(AObject).Items[I]).Free;
        TList(AObject).Items[I]:=nil;        
      end;  
    end;
    TList(AObject).Clear;
  end else
  if (TObject(AObject).ClassType = TCollection) then 
  begin
    TCollection(AObject).Clear;
  end;
end;

class function TKzUtils.NumbInRect(aValue, aHead, ANext: Integer): Boolean;
begin
  Result:=False;
  if (aValue>=aHead) and (aValue<=ANext) then
  begin
    Result:=True;
  end;
end;

class function TKzUtils.ExePath: string;
begin
  Result:=ExtractFilePath(ParamStr(0));
end;

class function TKzUtils.Explore: string;
begin
  {$IFDEF MSWINDOWS}
  ShellExecute(Application.Handle,'open','explorer.exe',PChar(TKzUtils.ExePath),'',SW_MAXIMIZE);
  {$ENDIF}
end;

class function TKzUtils.ShowBox(aValue: string): Integer;
begin
  {$IFDEF MSWINDOWS}
  Result:=Application.MessageBox(Pchar(aValue),'提示',MB_OKCANCEL +MB_ICONQUESTION);
  {$ENDIF}
end;

class procedure TKzUtils.ShowMsg(aValue: string);
begin
  {$IFDEF MSWINDOWS}
  Application.MessageBox(Pchar(aValue),'提示',MB_OK+MB_ICONINFORMATION);
  {$ENDIF}
end;

class function TKzUtils.StrsStrCutted(const Source: string;
  ATag: string): TStrings;
var
  PerlA:TPerlRegEx;
begin
  try
    Result:=TStringList.Create;
    PerlA:=TPerlRegEx.Create;
    //PerlA:=TPerlRegEx.Create;
    PerlA.Subject:=Source;
    PerlA.RegEx  :=ATag;
    PerlA.Split(Result,MaxInt);
  finally
    FreeAndNil(PerlA);
  end;
end;


class function TKzUtils.StrsStrMatchx(const Source: string;
  ATag: string): TStrings;
var
  PerlA:TPerlRegEx;
begin
  Result:=TStringList.Create;
  try
    PerlA:=TPerlRegEx.Create;
    //PerlA:=TPerlRegEx.Create;
    PerlA.Subject:=Source;
    PerlA.RegEx  :=ATag;
    while PerlA.MatchAgain do
    begin
      Result.Add(PerlA.MatchedText);
      //Result.Add(PerlA.MatchedText);
    end;  
  finally
    FreeAndNil(PerlA);
  end;
end;

class function TKzUtils.StrxCutMark(Source: string): string;
var
  I:Integer;
begin
  if Pos(',',Source)=0 then
  begin
    Result:=Source;
    Exit;
  end;

  for I:=Length(Source) downto 1 do
  begin
    if Source[I]=',' then
    begin
      Delete(Source,I,1);
    end;
  end;

  Result:=Source;
end;


class function TKzUtils.StrxCutZero(Source: string): string;
var
  I:Integer;
begin
  if Pos('.',Source)=0 then
  begin
    Result:=Source;
    Exit;
  end;

  for I:=Length(Source) downto 1 do
  begin
    if Source[I]<>'0' then Break;
    Delete(Source,I,1);
  end;

  if Pos('.',Source)=Length(Source) then
  begin
    Source:=Copy(Source,1,Length(Source)-1);
  end;

  Result:=Source;
end;

class function TKzUtils.TextToFloat(aValue: string): Extended;
var
  I:Integer;
begin
  Result:=0;
  if Trim(aValue)='' then Exit;

  for I := Length(aValue) downto 1 do
  begin
    if aValue[I]=',' then
    begin
      Delete(aValue,I,1);
    end;
  end;


  try
    Result:=StrToFloatDef(aValue,0);
  except
    raise Exception.CreateFmt('%s:is not valid float string.',[aValue]);
  end;
end;    

class function TKzUtils.TryFormatCode(ALength, ABoolBack: Integer;
  const AStrSub, ASource: string): string;
var
  ACount:Integer;
begin
  if ALength < Length(ASource) then
  begin
    Result:=ASource;
    Exit;
  end;

  ACount:=ALength - Length(ASource);

  if ABoolBack=0 then
  begin
    Result:=DupeString(AStrSub,ACount)+ASource;
  end else
  if ABoolBack=1 then
  begin
    Result:=ASource+DupeString(AStrSub,ACount);
  end;
end;


class function TKzUtils.TryFormatCode(aValue, ALength: Integer;
  const AText: string): string;
begin
  Result:=DupeString(AText,ALength-(Length(IntToStr(aValue))))+IntToStr(aValue);
end;

class procedure TKzUtils.TryFreeAndNil(var AObject);
var
  I:Integer;
begin
  if TObject(AObject)=nil then Exit;

  if (TObject(AObject).ClassType = TStringList) or (TObject(AObject).InheritsFrom(TStringList)) then
  begin
    for I:=0 to TStringList(AObject).Count -1 do
    begin
      if TStringList(AObject).Objects[I]<>nil then
      begin
        TStringList(AObject).Objects[I].Free;
        TStringList(AObject).Objects[I]:=nil;
      end;
    end;
    TStringList(AObject).Clear;
    FreeAndNil(AObject);
  end else
  if (TObject(AObject).ClassType = TList) or (TObject(AObject).InheritsFrom(TList)) then
  begin
    for I:=0 to TList(AObject).Count-1 do
    begin
      if TList(AObject).Items[I]<>nil then
      begin
        TObject(TList(AObject).Items[I]).Free;
        TList(AObject).Items[I]:=nil;        
      end;  
    end;
    TList(AObject).Clear;
    FreeAndNil(AObject);
  end else  
  begin
    FreeAndNil(AObject);
  end;  
end;

class function TKzUtils.WarnBox(aValue: string): Integer;
begin
  {$IFDEF MSWINDOWS}
  Result:=Application.MessageBox(Pchar(aValue),'警告',MB_OKCANCEL+MB_ICONWARNING);
  {$ENDIF}
end;

class procedure TKzUtils.WritFmt(const Msg: string;
  Params: array of const);
begin
  Writeln(Format(Msg,Params));
end;

class procedure TKzUtils.WritLog(aValue: Variant);
begin
  Writeln(VarToStr(aValue));
end;

{$IFDEF MSWINDOWS}
class function TKzUtils.EndTask(AExeName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: boolean;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(AExeName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(AExeName))) then
    Result := Integer(TerminateProcess(
    OpenProcess(PROCESS_TERMINATE,
    BOOL(0),
    FProcessEntry32.th32ProcessID),
    0));
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;
{$ENDIF}

class function TKzUtils.NumbInRect(aValue: Integer;
  aArrayOfChar: array of Char): Boolean;
var
  I:Integer;
  CharA:Char;
begin
  Result:=False;
  for I:= Low(aArrayOfChar) to High(aArrayOfChar) do
  begin
    CharA:=aArrayOfChar[I];
    if aValue = GetOrd(CharA) then
    begin
      Result:=True;
      Break;
    end;  
  end;  
end;

class function TKzUtils.GetOrd(AChar: Char): Integer;
begin
  Result:=Ord(UpCase(AChar))-64;
end;

class function TKzUtils.HashCode(const aValue: string): Integer;
var
  I:Integer;
begin
//  public String()
//  {
//    this.offset = 0;
//    this.count = 0;
//    this.value = new char[0];
//  }

//  public int hashCode()
//  {
//    int i = this.hash;
//    if (i == 0)
//    {
//      int j = this.offset;
//      char[] arrayOfChar = this.value;
//      int k = this.count;
//      for (int m = 0; m < k; m++)
//        i = 31 * i + arrayOfChar[(j++)];
//      this.hash = i;
//    }
//    return i;
//  }

  Result:=0;
  for I:=1 to Length(aValue) do
  begin
    Result:=Result * 31 + Ord(aValue[I]);
  end;
end;

class function TKzUtils.IfThen(ABool: Boolean; ATrue,
  AFail: Variant): Variant;
begin
  Result:=AFail;
  if ABool then
  begin
    Result:=ATrue;
  end;
end;

class function TKzUtils.DateToFloat(aValue: TDateTime): Extended;
begin
  Result:=StrToFloatDef(FormatDateTime('YYYYMMDDHHMMSS',aValue),0);
end;

class function TKzUtils.DateIsNull(ADate: TDateTime): Boolean;
begin
  Result:=False;
  if FormatDateTime('YYYYMMDD',ADate)='18991230' then
  begin
    Result:=True;
  end;  
end;

class function TKzUtils.IntToDateX(aValue:Integer):TDateTime;
var
  TMPA:string;
  TMPB:string;
begin
  Result:=Unassigned;
  if aValue=0 then Exit;
  TMPA:=IntToStr(aValue);
  if Length(TMPA)<>8 then Exit;
  TMPB:=Format('%s-%s-%s',[Copy(TMPA,1,4),Copy(TMPA,5,2),Copy(TMPA,7,2)]);


  try
    //#DateSeparator:='-';
    FormatSettings.DateSeparator:='-';

    Result:=StrToDate(TMPB);
  except
    on E:Exception do
    begin
      raise Exception.Create(E.Message);
    end;  
  end;
end;

class function TKzUtils.NumbInRect(aValue: Integer;
  aBunchOfInteger: string): Boolean;
var
  ListA:TStringList;
begin
  Result:=False;
  if Trim(aBunchOfInteger)='' then Exit;

  try
    ListA:=TStringList.Create;
    ListA.CommaText:=aBunchOfInteger;

    Result:=ListA.IndexOf(IntToStr(aValue))<>-1;
  finally
    FreeAndNil(ListA);
  end;
end;

class function TKzUtils.NumbInRect(aValue: Integer;
  aArrayOfInteger: array of Integer): Boolean;
var
  I:Integer;
  cValue:Integer;
begin
  Result := False;

  for I:= Low(aArrayOfInteger) to High(aArrayOfInteger) do
  begin
    cValue:=aArrayOfInteger[I];

    if aValue = cValue then
    begin
      Result := True;
      Break;
    end;
  end;
end;

class function TKzUtils.NumbInRect(aValue, aHead, ANext: Extended): Boolean;
begin
  Result:=False;
  if (aValue>=aHead) and (aValue<=ANext) then
  begin
    Result:=True;
  end;
end;

class function TKzUtils.ErorFmt(const Msg: string;
  Params: array of const): Integer;
begin
  {$IFDEF MSWINDOWS}
  Result:=Application.MessageBox(Pchar(Format(Msg,Params)),'警告',MB_OKCANCEL+MB_ICONERROR);
  {$ENDIF}
end;

class procedure TKzUtils.ErorMsg(aValue: string);
begin
  {$IFDEF MSWINDOWS}
  Application.MessageBox(Pchar(aValue),'错误',MB_OK+MB_ICONERROR);
  {$ENDIF}
end;

class procedure TKzUtils.ErorMsg(const Msg: string;
  Params: array of const);
begin
  {$IFDEF MSWINDOWS}
  Application.MessageBox(Pchar(Format(Msg,Params)),'错误',MB_OK+MB_ICONERROR);
  {$ENDIF}
end;

class function TKzUtils.ShowFmt(const Msg: string;
  Params: array of const): Integer;
begin
  {$IFDEF MSWINDOWS}
  Result:=Application.MessageBox(PChar(Format(Msg,Params)),'提示',MB_OKCANCEL +MB_ICONQUESTION);
  {$ENDIF}
end;

class procedure TKzUtils.ShowMsg(const Msg: string; Params: array of const);
begin
  {$IFDEF MSWINDOWS}
  Application.MessageBox(Pchar(Format(Msg,Params)),'提示',MB_OK+MB_ICONINFORMATION);
  {$ENDIF}
end;

class function TKzUtils.WarnFmt(const Msg: string;
  Params: array of const): Integer;
begin
  {$IFDEF MSWINDOWS}
  Result:=Application.MessageBox(Pchar(Format(Msg,Params)),'警告',MB_OKCANCEL+MB_ICONWARNING);
  {$ENDIF}
end;

class procedure TKzUtils.WarnMsg(aValue: string);
begin
  {$IFDEF MSWINDOWS}
  Application.MessageBox(Pchar(aValue),'提示',MB_OK+MB_ICONWARNING);
  {$ENDIF}
end;

class procedure TKzUtils.WarnMsg(const Msg: string;
  Params: array of const);
begin
  {$IFDEF MSWINDOWS}
  Application.MessageBox(Pchar(Format(Msg,Params)),'提示',MB_OK+MB_ICONWARNING);
  {$ENDIF}
end;

class function TKzUtils.jsdecode(const aValue: Widestring): Widestring;
var
  P: PWideChar;
  v: WideChar;
  tmp: Widestring;
begin
  Result := '';
  P := PWideChar(aValue);
  while P^ <> #0 do
  begin
    v := #0;
    case P^ of
      '\':
        begin
          inc(P);
          case P^ of
            '"', '\', '/':
              v := P^;
            'b':
              v := #$08;
            'f':
              v := #$0C;
            'n':
              v := #$0A;
            'r':
              v := #$0D;
            't':
              v := #$09;
            'u':
              begin
                tmp := Copy(P, 2, 4);
                v := WideChar(StrToInt('$' + tmp));
                inc(P, 4);
              end;
          end;
        end;
    else
      v := P^;
    end;
    Result := Result + v;
    inc(P);
  end;
end;

class function TKzUtils.jsencode(const aValue: Widestring): Widestring;
var
  P: PWideChar;
begin
  Result := '';
  P := PWideChar(aValue);
  while P^ <> #0 do
  begin
    case P^ of
      '"', '\', '/':
        Result := Result + '\' + P^;
      #$08:
        Result := Result + '\b';
      #$0C:
        Result := Result + '\f';
      #$0A:
        Result := Result + '\n';
      #$0D:
        Result := Result + '\r';
      #$09:
        Result := Result + '\t';
    else
      if WORD(P^) > $FF then
        Result := Result + LowerCase(Format('\u%x', [WORD(P^)]))
      else
        Result := Result + P^;
    end;
    inc(P);
  end;
end;

class function TKzUtils.RegReplaceAll(const Source: string; ATag,
  AReplacement: string): string;
var
  PerlA:TPerlRegEx;
begin
  Result:='';
  try
    PerlA:=TPerlRegEx.Create;
    PerlA.Subject:=Source;
    PerlA.RegEx  :=ATag;
    PerlA.Replacement:=AReplacement;
    if PerlA.ReplaceAll then
    begin
      Result:=PerlA.Subject;
    end;
  finally
    FreeAndNil(PerlA);
  end;
end;

class procedure TKzUtils.ListMatchText(const Source: string; ATag: string;
  var Result: TStrings);
var
  PerlA:TPerlRegEx;
begin
  if Result = nil then Exit;

  try
    PerlA:=TPerlRegEx.Create;
    //PerlA:=TPerlRegEx.Create;
    PerlA.Subject:=Source;
    PerlA.RegEx  :=ATag;
    while PerlA.MatchAgain do
    begin
      Result.Add(PerlA.MatchedText);
      //Result.Add(PerlA.MatchedText);
    end;
  finally
    FreeAndNil(PerlA);
  end;
end;

class procedure TKzUtils.ListStrCutted(const Source: string; ATag: string;
  var Result: TStrings);
var
  PerlA:TPerlRegEx;
begin
  if Result=nil then Exit;
  Result.Clear;
  
  try
    PerlA:=TPerlRegEx.Create;
    PerlA.Subject:=Source;
    PerlA.RegEx  :=ATag;
    PerlA.Split(Result,MaxInt);
  finally
    FreeAndNil(PerlA);
  end;
end;

class function TKzUtils.GetChr(AIdex: Integer): string;
var
  I,X,Y:Integer;
  R,S  :string;
begin
  I:=AIdex;
  X:=I div 26;
  Y:=I mod 26;

  if I<=26 then
  begin
    Result:=Format('%S',[Chr(I+64)]);
  end else
  begin
    R:=Chr(X+64);
    if Y=0 then
    begin
      R:=Chr(X-1+64);
      S:=Chr(26+64);
    end else
    begin
      S:=Chr(Y+64);
    end;
    Result:=Format('%S%S',[R,S]);
  end;
end;

class function TKzUtils.StrToDateX(aValue: string): Integer;
var
  Format:TFormatSettings;
begin
  Result:=18991230;
  if Trim(aValue)='' then Exit;

  if Pos('/',aValue)>0 then
  begin
    aValue:=StringReplace(aValue,'/','-',[rfReplaceAll]);
  end;
  if Pos('.',aValue)>0 then
  begin
    aValue:=StringReplace(aValue,'.','-',[rfReplaceAll]);
  end;

  try
    try
      Format.LongDateFormat :='yyyy-mm-dd';
      Format.ShortDateFormat:='yy-mm-dd';
      Format.LongTimeFormat :='hh:mm:ss.zzz';
      Format.DateSeparator  :='-';
      Format.TimeSeparator  :=':';
      Result:=StrToIntDef(FormatDateTime('YYYYMMDD',StrToDateTime(aValue)),18991230);
    except
      Format.LongDateFormat :='yyyy.mm.dd';
      Format.ShortDateFormat:='yy.mm.dd';
      Format.LongTimeFormat :='hh:mm:ss.zzz';
      Format.DateSeparator  :='.';
      Format.TimeSeparator  :=':';
      Result:=StrToIntDef(FormatDateTime('YYYYMMDD',StrToDateTime(aValue)),18991230);
    end;
  finally
  end;

  {#try
    DateSeparator:='-';
    Format.LongDateFormat :='yyyy-mm-dd';
    Format.ShortDateFormat:='yy-mm-dd';
    Format.LongTimeFormat :='hh:mm:ss.zzz';
    Format.DateSeparator  :='-';
    Format.TimeSeparator  :=':';
    Result:=StrToIntDef(FormatDateTime('YYYYMMDD',StrToDateTime(aValue)),18991230);
  except
    on E:Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;}

  {#try
    Format.LongDateFormat :='yyyy-mm-dd';
    Format.ShortDateFormat:='yy-mm-dd';
    Format.LongTimeFormat :='hh:mm:ss.zzz';
    Format.DateSeparator  :='-';
    Format.TimeSeparator  :=':';
    Result:=StrToIntDef(FormatDateTime('YYYYMMDD',StrToDateTime(aValue)),18991230);
  except
  end;}
end;

class function TKzUtils.GetGUID: string;
var
  GUID:TGUID;
begin
  SysUtils.CreateGUID(GUID);
  Result:=GUIDToString(GUID);
end;

class function TKzUtils.DateToInt(aValue: TDateTime): Integer;
begin
  Result:=StrToIntDef(FormatDateTime('YYYYMMDD',aValue),18991230);
end;


{$IFDEF MSWINDOWS}
class function TKzUtils.StringToColorDef(const aValue,
  ADef: string): TColor;
begin
  Result:=clWhite;
  if Trim(aValue)='' then
  begin
    Result:=StringToColor(ADef);
  end else
  begin
    Result:=StringToColor(Trim(aValue));
  end;
end;
{$ENDIF}

end.
