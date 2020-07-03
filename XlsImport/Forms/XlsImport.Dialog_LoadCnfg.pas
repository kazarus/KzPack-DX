unit XlsImport.Dialog_LoadCnfg;
//#XlsImport

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dialog_View, StdCtrls, RzLabel, Mask, RzEdit, RzBtnEdt,
  XlsImport.Class_Load_Cnfg,Uni,UniConnct, RzCmboBx, XLSSheetData5,
  XLSReadWriteII5,XlsImport.Class_Load_Page, RzButton, RzRadChk;

type
  TDialogLoadCnfg = class(TDialogView)
    Labl_1: TRzLabel;
    Labl_2: TRzLabel;
    Labl_3: TRzLabel;
    Edit_RowTitle: TRzButtonEdit;
    Edit_RowStart: TRzButtonEdit;
    Edit_FilePath: TRzButtonEdit;
    Btnv_Mrok: TButton;
    Btnv_Quit: TButton;
    Labl_4: TRzLabel;
    Comb_KJQJ: TRzComboBox;
    Labl_5: TRzLabel;
    Comb_RealPage: TRzComboBox;
    XLSReadWriteII51: TXLSReadWriteII5;
    Chkb_FileHead: TRzCheckBox;
    procedure Edit_FilePathButtonClick(Sender: TObject);
    procedure Btnv_QuitClick(Sender: TObject);
    procedure Btnv_MrokClick(Sender: TObject);
  private
    FRealKJND: Integer;
    FFilePath: string;      //
    FPromptTx: string;
    FKeyWords: string;      //&
    FRowTitle: Integer;     //&
    FRowStart: Integer;     //&
  private
    FLoadCnfg: TLoadCnfg;   //&
    FListKJQJ: TStringList; //*
    FIsPrompt: Boolean;     //*
    FListPage: TStringList; //*
  protected
    procedure SetInitialize;override;
    procedure SetCommParams;override;
    procedure SetGridParams;override;
    procedure SetComboItems;override;
    procedure TryFreeAndNil;override;
  public
    function  ReadPage(aFilePath:string;var aList:TStringList):Boolean;
  public
    procedure ViewPath;
    procedure InitCnfg;
    procedure InitPage(aList:TStringList;aName:string);
    procedure ImptCnfg(var aLoadCnfg:TLoadCnfg);
  end;

var
  DialogLoadCnfg: TDialogLoadCnfg;

function ViewLoadCnfg(aRealKJND: Integer; var aLoadCnfg: TLoadCnfg; IsPrompt: Boolean = True; aFilePath: string = ''; aPromptTx: string = ''; aKeyWords: string = ''; aRowTitle: Integer = 0; aRowStart: Integer = 0): Integer;

implementation

uses
  Class_AppUtil,Class_KzUtils,Class_KJQJ,Helpr_UniEngine;

{$R *.dfm}

function ViewLoadCnfg(aRealKJND: Integer; var aLoadCnfg: TLoadCnfg; IsPrompt: Boolean; aFilePath: string; aPromptTx: string; aKeyWords: string; aRowTitle: Integer; aRowStart: Integer): Integer;
begin
  try
    DialogLoadCnfg:=TDialogLoadCnfg.Create(nil);
    DialogLoadCnfg.FLoadCnfg := aLoadCnfg;
    DialogLoadCnfg.FRealKJND := aRealKJND;
    DialogLoadCnfg.FIsPrompt := IsPrompt;
    DialogLoadCnfg.FFilePath := aFilePath;
    DialogLoadCnfg.FPromptTx := aPromptTx;
    DialogLoadCnfg.FKeyWords := aKeyWords;
    DialogLoadCnfg.FRowTitle := aRowTitle;
    DialogLoadCnfg.FRowStart := aRowStart;


    Result:=DialogLoadCnfg.ShowModal;
    if Result=Mrok then
    begin
      DialogLoadCnfg.ImptCnfg(aLoadCnfg);
    end;
  finally
    FreeAndNil(DialogLoadCnfg);
  end;
end;
                  

procedure TDialogLoadCnfg.ImptCnfg(var aLoadCnfg: TLoadCnfg);
var
  cKJQJ:TKJQJ;
  cPage:TLoadPage;
begin
  if Comb_RealPage.ItemIndex = -1 then
  begin
    TKzUtils.ShowMsg('请指定需要导入的标签页.');
    Exit;
  end;

  with Comb_RealPage do
  begin
    cPage := TLoadPage(Comb_RealPage.Items.Objects[Comb_RealPage.ItemIndex]);
    if cPage = nil then Exit;
  end;

  aLoadCnfg.PAGEINDX := cPage.PAGEINDX;
  aLoadCnfg.PAGENAME := cPage.PAGENAME;

  aLoadCnfg.ROWTITLE := StrToIntDef(Edit_RowTitle.Text, 5);
  aLoadCnfg.ROWSTART := StrToIntDef(Edit_RowStart.Text, 5);
  aLoadCnfg.FILEPATH := Edit_FilePath.Text;

  cKJQJ:=TKJQJ(Comb_KJQJ.Items.Objects[Comb_KJQJ.ItemIndex]);
  if cKJQJ<>nil then
  begin
    aLoadCnfg.KJNDKJQJ:=cKJQJ.GetKJNDKJQJ;
  end;

  aLoadCnfg.FILEHEAD := Chkb_FileHead.Checked;

  {#if FFilePath = '' then
  begin
    FFilePath := TKzUtils.ExePath+'loadcnfg.json';
  end;
  
  aLoadCnfg.ToFILE(FFilePath,True);}
end;

procedure TDialogLoadCnfg.InitCnfg;
begin
  if FLoadCnfg=nil then Exit;

  if FLoadCnfg.ROWTITLE = 0 then
  begin
    FLoadCnfg.ROWTITLE := FRowTitle;
  end;
  if FLoadCnfg.ROWSTART = 0 then
  begin
    FLoadCnfg.ROWSTART := FRowStart;
  end;

  Edit_RowTitle.Text := Format('%D', [FLoadCnfg.ROWTITLE]);
  Edit_RowStart.Text := Format('%D', [FLoadCnfg.ROWSTART]);
  Edit_FilePath.Text := FLoadCnfg.FILEPATH;

  if (Trim(FLoadCnfg.FILEPATH) <> '') and (FileExists(FLoadCnfg.FILEPATH)) then
  begin
    if FListPage = nil then
    begin
      FListPage := TStringList.Create;
    end;
    TKzUtils.JustCleanList(FListPage);
    if ReadPage(FLoadCnfg.FILEPATH,FListPAge) then
    begin
      InitPage(FListPage, FLoadCnfg.PAGENAME);
    end;
  end;
end;

procedure TDialogLoadCnfg.InitPage(aList:TStringList;aName:string);
var
  I:Integer;
  cPage:TLoadPage;
begin
  with Comb_RealPage do
  begin
    Items.Clear;

    for I := 0 to aList.Count-1 do
    begin
      cPage := TLoadPage(aList.Objects[I]);
      if cPage = nil then Continue;

      Items.AddObject(cPage.PAGENAME,cPage);
    end;

    Style := csDropDownList;
    ItemIndex := 0;

    if Items.IndexOf(aName) <> -1 then
    begin
      ItemIndex := Items.IndexOf(aName);
    end;
  end;
end;

function TDialogLoadCnfg.ReadPage(aFilePath:string;var aList:TStringList):Boolean;
var
  I: Integer;
  cPage: TLoadPage;
begin
  Result := False;

  if aList = nil then Exit;
  TKzUtils.JustCleanList(aList);

  self.XLSReadWriteII51.Filename := aFilePath;
  self.XLSReadWriteII51.Read;

  for I := 0 to self.XLSReadWriteII51.Count -1 do
  begin
    cPage := TLoadPage.Create;
    cPage.PAGEINDX := I;
    cPage.PAGENAME := self.XLSReadWriteII51.Sheets[I].Name;

    aList.AddObject(cPage.PAGENAME,cPage);
  end;

  Result := True;
end;

procedure TDialogLoadCnfg.SetComboItems;
var
  I:Integer;
  cKJQJ:TKJQJ;
begin
  inherited;

  if FListKJQJ=nil then
  begin
    FListKJQJ:=TStringList.Create;
  end;
  TKzUtils.JustCleanList(FListKJQJ);

  for I:=1 to 12 do
  begin
    cKJQJ:=TKJQJ.Create(FRealKJND,I);

    FListKJQJ.AddObject(Format('%D年%D月',[cKJQJ.KJND,cKJQJ.KJQJ]),cKJQJ);
  end;

  with Comb_KJQJ do
  begin
    Items.Clear;
    for I:=0 to FListKJQJ.Count-1 do
    begin
      cKJQJ:=TKJQJ(FListKJQJ.Objects[I]);
      if cKJQJ=nil then Continue;

      Items.AddObject(FListKJQJ.Strings[I],cKJQJ);
    end;

    Style:=csDropDownList;
    ItemIndex:=0;
  end;
end;

procedure TDialogLoadCnfg.SetCommParams;
begin
  inherited;
  Caption:='导入参数';
  if FPromptTx <> '' then
  begin
    Caption := Format('导入参数:%S',[FPromptTx]);
  end;

  Btnv_Quit.Caption:='取消';
  Btnv_Mrok.Caption:='确定';

  Font.Name := '微软雅黑';
  Font.Size := 9;
  
  Edit_FilePath.ReadOnly:=True;
  Edit_FilePath.HideButtonsOnReadOnly:=False;

  if FRowTitle <> 0 then
  begin
    Edit_RowTitle.Text := Format('%D', [FLoadCnfg.ROWTITLE]);
  end;
  if FRowStart <> 0 then
  begin
    Edit_RowStart.Text := Format('%D', [FLoadCnfg.ROWSTART]);
  end;
end;

procedure TDialogLoadCnfg.SetGridParams;
begin
  inherited;

end;

procedure TDialogLoadCnfg.SetInitialize;
begin
  FListKJQJ := nil;
  FListPage := nil;
  inherited;
  InitCnfg;
end;

procedure TDialogLoadCnfg.TryFreeAndNil;
begin
  inherited;
  if FListPage <> nil then TKzUtils.TryFreeAndNil(FListPage);
  if FListKJQJ <> nil then TKzUtils.TryFreeAndNil(FListKJQJ);
end;

procedure TDialogLoadCnfg.ViewPath;
var
  I: Integer;
  OD: TOpenDialog;
  cList: TStringList;
begin
  try
    OD := TOpenDialog.Create(nil);
    OD.Filter := '全部|*.xls|*.xls|*.xlsx|*.xlsx';

    if (Edit_FilePath.Text <> '') then
    begin
      if Pos('\\',Edit_FilePath.Text) < 0 then
      begin
        OD.InitialDir := ExtractFilePath(Edit_FilePath.Text);
      end;
    end;
    if OD.Execute then
    begin
      //XC-DEV@2017-11-30-15-13-52-<
      if FKeyWords <> '' then
      begin
        try
          cList := TStringList.Create;
          cList.Delimiter := ',';
          cList.DelimitedText := FKeyWords;

          for I := 0 to cList.Count-1 do
          begin
            if Pos(cList.Strings[I],ExtractFileName(OD.FileName)) <= 0 then
            begin
              //@if TKzUtils.ShowFmt('当前文件名称不符合关键词[%S],是否继续?',[cList.Strings[I]]) <> Mrok then Exit;
              TKzUtils.ErorMsg('操作无效:当前文件名称不符合关键词[%S]',[cList.Strings[I]]);
              Exit;
            end;
          end;
        finally
          FreeAndNil(cList);
        end;
      end;
      //XC-DEV@2017-11-30-15-13-52->

      Edit_FilePath.Text:=OD.FileName;

      if FListPage = nil then
      begin
        FListPage := TStringList.Create;
      end;
      TKzUtils.JustCleanList(FListPage);

      if ReadPage(OD.FileName,FListPage) then
      begin
        InitPage(FListPage,'');
      end;
    end;
  finally
    FreeAndNil(OD);
  end;
end;

procedure TDialogLoadCnfg.Edit_FilePathButtonClick(Sender: TObject);
begin
  ViewPath;
end;

procedure TDialogLoadCnfg.Btnv_QuitClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TDialogLoadCnfg.Btnv_MrokClick(Sender: TObject);
var
  cKJQJ:TKJQJ;
begin
  if Trim(Edit_FilePath.Text) = '' then
  begin
    ShowMessageFmt('请指定文件路径.', []);
    Exit;
  end;
  if Trim(Edit_RowTitle.Text) = '' then
  begin
    ShowMessageFmt('请指定标题行.', []);
    Exit;
  end;
  if Trim(Edit_RowStart.Text) = '' then
  begin
    ShowMessageFmt('请指定起始行.', []);
    Exit;
  end;

  if FIsPrompt then
  begin
    cKJQJ := TKJQJ(Comb_KJQJ.Items.Objects[Comb_KJQJ.ItemIndex]);
    if cKJQJ <> nil then
    begin
      if TKzUtils.ShowFmt('是否确定设置导入期间[%S]',[Format('%D年-%D月',[cKJQJ.KJND,cKJQJ.KJQJ])])<>Mrok then Exit;
    end;
  end;

  ModalResult:=mrOk;
end;

end.
