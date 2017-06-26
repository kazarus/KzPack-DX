unit XlsImport.Dialog_LoadCnfg;
//#XlsImport

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dialog_View, StdCtrls, RzLabel, Mask, RzEdit, RzBtnEdt,
  XlsImport.Class_Load_Cnfg,Uni,UniConnct, RzCmboBx, XLSSheetData5,
  XLSReadWriteII5,XlsImport.Class_Load_Page;

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
    procedure Edit_FilePathButtonClick(Sender: TObject);
    procedure Btnv_QuitClick(Sender: TObject);
    procedure Btnv_MrokClick(Sender: TObject);
  private
    FRealKJND: Integer;
    FFilePath: string;
    FLoadCnfg: TLoadCnfg;  //&
    FListKJQJ: TStringList; //*
    FIsPrompt: Boolean;    //*
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

function ViewLoadCnfg(aRealKJND:Integer;var aLoadCnfg:TLoadCnfg;IsPrompt:Boolean=True;aFilePath:string=''):Integer;

implementation

uses
  Class_AppUtil,Class_KzUtils,Class_KJQJ,Helpr_UniEngine;

{$R *.dfm}

function ViewLoadCnfg(aRealKJND:Integer;var aLoadCnfg:TLoadCnfg;IsPrompt:Boolean;aFilePath:string):Integer;
begin
  try
    DialogLoadCnfg:=TDialogLoadCnfg.Create(nil);
    DialogLoadCnfg.FLoadCnfg := aLoadCnfg;
    DialogLoadCnfg.FRealKJND := aRealKJND;
    DialogLoadCnfg.FIsPrompt := IsPrompt;
    DialogLoadCnfg.FFilePath := aFilePath;


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
begin
  aLoadCnfg.ROWTITLE := StrToIntDef(Edit_RowTitle.Text, 5);
  aLoadCnfg.ROWSTART := StrToIntDef(Edit_RowStart.Text, 5);
  aLoadCnfg.FILEPATH := Edit_FilePath.Text;

  cKJQJ:=TKJQJ(Comb_KJQJ.Items.Objects[Comb_KJQJ.ItemIndex]);
  if cKJQJ<>nil then
  begin
    aLoadCnfg.KJNDKJQJ:=cKJQJ.GetKJNDKJQJ;
  end;

  if FFilePath = '' then
  begin
    FFilePath := TKzUtils.ExePath+'loadcnfg.json';
  end;
  
  aLoadCnfg.ToFILE(FFilePath,True);
end;

procedure TDialogLoadCnfg.InitCnfg;
begin
  if FLoadCnfg=nil then Exit;

  if FLoadCnfg.ROWTITLE = 0 then
  begin
    FLoadCnfg.ROWTITLE := 1;
  end;
  if FLoadCnfg.ROWSTART = 0 then
  begin
    FLoadCnfg.ROWSTART := 2;
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
  I:Integer;
  cPage:TLoadPage;
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

    FListKJQJ.AddObject(Format('%D��%D��',[cKJQJ.KJND,cKJQJ.KJQJ]),cKJQJ);
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
  Caption:='�������';
  Btnv_Quit.Caption:='ȡ��';
  Btnv_Mrok.Caption:='ȷ��';
  
  Edit_FilePath.ReadOnly:=True;
  Edit_FilePath.HideButtonsOnReadOnly:=False;
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
  OD:TOpenDialog;
begin
  try
    OD:=TOpenDialog.Create(nil);
    if Edit_FilePath.Text <> '' then
    begin
      OD.InitialDir := ExtractFilePath(Edit_FilePath.Text);
    end;
    if OD.Execute then
    begin
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
  if Trim(Edit_RowTitle.Text)='' then
  begin
    ShowMessageFmt('��ָ��������.',[]);
    Exit;
  end;
  if Trim(Edit_RowStart.Text)='' then
  begin
    ShowMessageFmt('��ָ����ʼ��.',[]);
    Exit;  
  end;

  if FIsPrompt then
  begin
    cKJQJ := TKJQJ(Comb_KJQJ.Items.Objects[Comb_KJQJ.ItemIndex]);
    if cKJQJ <> nil then
    begin
      if TKzUtils.ShowFmt('�Ƿ�ȷ�����õ����ڼ�[%S]',[Format('%D��-%D��',[cKJQJ.KJND,cKJQJ.KJQJ])])<>Mrok then Exit;
    end;
  end;

  
  ModalResult:=mrOk;
end;

end.
