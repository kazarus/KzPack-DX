unit Dialog_ListUniConfig;
//YXC_2012_06_19_12_13_54
//数据库配置列表

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dialog_View, Grids, BaseGrid, AdvGrid, StdCtrls, ExtCtrls, Uni,
  UniConfig, UniConnct, RzButton, RzRadChk, AdvObj, RzStatus, RzPanel, RzCmboBx,
  System.ImageList, Vcl.ImgList;

type
  TDialogListUniConfigEditMode = (dlucemEdit, dlucemView);

  TDialogListUniConfig = class(TDialogView)
    RzStatusBar1: TRzStatusBar;
    Panl_UnixMemo: TRzStatusPane;
    Panl_DataBase: TRzStatusPane;
    Grid_Cnfg: TAdvStringGrid;
    Comb_UnixMark: TRzComboBox;
    Comb_UnixType: TRzComboBox;
    Tool_1: TRzToolbar;
    Btnv_Mrok: TRzToolButton;
    Btnv_Quit: TRzToolButton;
    Btnv_AddvCnfg: TRzToolButton;
    Btnv_DeltCnfg: TRzToolButton;
    Btnv_EditCnfg: TRzToolButton;
    Btnv_CopyCnfg: TRzToolButton;
    Btnv_ActvCnfg: TRzToolButton;
    Btnv_OrdrCnfg: TRzToolButton;
    Btnv_TestCnfg: TRzToolButton;
    il1: TImageList;
    Line_1: TRzSpacer;
    procedure Grid_CnfgGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure Grid_CnfgCanEditCell(Sender: TObject; ARow, ACol: Integer; var CanEdit: Boolean);
    procedure Grid_CnfgDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Grid_CnfgClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure Grid_CnfgRowMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure Btnx_CopyClick(Sender: TObject);
    procedure Grid_CnfgSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure Comb_UnixTypeCloseUp(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Btnv_AddvCnfgClick(Sender: TObject);
    procedure Btnv_EditCnfgClick(Sender: TObject);
    procedure Btnv_QuitClick(Sender: TObject);
    procedure Btnv_MrokClick(Sender: TObject);
    procedure Btnv_CopyCnfgClick(Sender: TObject);
    procedure Btnv_ActvCnfgClick(Sender: TObject);
    procedure Btnv_OrdrCnfgClick(Sender: TObject);
    procedure Btnv_TestCnfgClick(Sender: TObject);
    procedure Grid_CnfgCheckBoxClick(Sender: TObject; ACol, ARow: Integer; State: Boolean);
    procedure Btnv_DeltCnfgClick(Sender: TObject);
  private
    FEditMode: TDialogListUniConfigEditMode;
    FListCnfg: TStringList;  //*list of *tuniconfig;
    FCellIdex: Integer;
    FLoadLast: Boolean;

    //YXC_2014_04_28_10_43_31
    FuDefault: TUniConfig;   //*
    FConnectionMark: string;
  protected
    procedure SetInitialize; override;
    procedure SetCommParams; override;
    procedure SetComboItems; override;
    procedure SetGridParams; override;
  protected
    procedure copyCnfg(uDefault: TUniConfig); overload;
  public
    procedure InitCnfg;
    procedure AddvCnfg;
    procedure EditCnfg;
    procedure DeltCnfg;
    procedure CopyCnfg; overload;
    procedure ActvCnfg(IsFill: Boolean = True);
    procedure OrdrCnfg;
    procedure FillCnfg(AList: TStringList); overload;
    procedure FillCnfg(aIndx: Integer; aCnfg: TUniConfig); overload;
  public
    function ExptCnfg: TUniConfig; overload;
    procedure ExptCnfg(var aCnfg: TUniConfig); overload;
  public
    procedure FreeAndNilList(AList: TStringList);
    procedure ClearGrid(AGrid: TAdvStringGrid; ARowCount: Integer; ADefaultRowCount: Integer = 2);
  end;

var
  DialogListUniConfig: TDialogListUniConfig;

function ViewListUniConfig(aEditMode: TDialogListUniConfigEditMode; aConnectionMark: string = ''; aLoadLast: Boolean = False): Integer; overload;
function ViewListUniConfig(aEditMode: TDialogListUniConfigEditMode; var aCnfg: TUniConfig; IsCreate: Boolean = True; aConnectionMark: string = ''; aLoadLast: Boolean = False): Integer; overload;
function ViewListUniConfigEx(aEditMode: TDialogListUniConfigEditMode; uDefault: TUniConfig = nil; aConnectionMark: string = ''; aLoadLast: Boolean = False): Integer; overload;

implementation

uses
  Dialog_EditUniConfig, StylManager, Class_UiUtils, Class_KzUtils;

{$R *.dfm}

function ViewListUniConfigEx(AEditMode: TDialogListUniConfigEditMode; uDefault: TUniConfig; aConnectionMark: string; aLoadLast: Boolean): Integer;
begin
  try
    DialogListUniConfig := TDialogListUniConfig.Create(nil);
    DialogListUniConfig.FEditMode := AEditMode;
    DialogListUniConfig.FLoadLast := aLoadLast;
    DialogListUniConfig.FConnectionMark := aConnectionMark;
    DialogListUniConfig.BorderStyle := bsSizeable;
    DialogListUniConfig.CopyCnfg(uDefault);
    Result := DialogListUniConfig.ShowModal;
  finally
    FreeAndNil(DialogListUniConfig);
  end;
end;

function ViewListUniConfig(AEditMode: TDialogListUniConfigEditMode; aConnectionMark: string; aLoadLast: Boolean): Integer;
begin
  try
    DialogListUniConfig := TDialogListUniConfig.Create(nil);
    DialogListUniConfig.FEditMode := AEditMode;
    DialogListUniConfig.FLoadLast := aLoadLast;
    DialogListUniConfig.FConnectionMark := aConnectionMark;
    DialogListUniConfig.BorderStyle := bsSizeable;
    Result := DialogListUniConfig.ShowModal;
  finally
    FreeAndNil(DialogListUniConfig);
  end;
end;

function ViewListUniConfig(AEditMode: TDialogListUniConfigEditMode; var aCnfg: TUniConfig; IsCreate: Boolean; aConnectionMark: string; aLoadLast: Boolean): Integer;
begin
  try
    DialogListUniConfig := TDialogListUniConfig.Create(nil);

    DialogListUniConfig.FEditMode := AEditMode;
    DialogListUniConfig.FLoadLast := aLoadLast;
    DialogListUniConfig.FConnectionMark := aConnectionMark;
    DialogListUniConfig.BorderStyle := bsSizeable;
    Result := DialogListUniConfig.ShowModal;
    if Result = Mrok then
    begin
      if IsCreate then
      begin
        aCnfg := DialogListUniConfig.ExptCnfg;
      end
      else
      begin
        DialogListUniConfig.ExptCnfg(aCnfg);
      end;
    end;
  finally
    FreeAndNil(DialogListUniConfig);
  end;
end;

procedure TDialogListUniConfig.SetCommParams;
begin
  inherited;
  Caption := '数据库列表配置';
  Width := 1024;
  Height := Trunc(1024 * 0.618);

  Btnv_Mrok.Caption := '确定';
  Btnv_Quit.Caption := '取消';

  Btnv_AddvCnfg.Caption := '添加';
  Btnv_DeltCnfg.Caption := '删除';
  Btnv_EditCnfg.Caption := '修改';
  Btnv_CopyCnfg.Caption := '复制';
  Btnv_ActvCnfg.Caption := '活动';
  Btnv_OrdrCnfg.Caption := '排序';
  Btnv_TestCnfg.Caption := '测试';
end;

procedure TDialogListUniConfig.SetGridParams;
begin
  inherited;
  with Grid_Cnfg do
  begin
    RowCount := 2;
    ColCount := 20;
    DefaultColWidth := 90;

    ShowHint := True;
    HintShowCells := True;
    HintShowSizing := True;

    Options := Options + [goColSizing];
    Options := Options + [goRowSelect];
    Options := Options + [goRowMoving];

    Font.Size := 10;
    Font.Name := '宋体';

    FixedFont.Size := 10;
    FixedFont.Name := '宋体';

    with ColumnHeaders do
    begin
      Clear;
      Delimiter := ',';
      DelimitedText := '序号,,年度,标志,驱动,用户,密码,服务器,数据库,端口号,直联,状态';
    end;

    ColCount := ColumnHeaders.Count;

    AddCheckBox(1, 0, False, False);
  end;
end;

procedure TDialogListUniConfig.SetInitialize;
begin
  inherited;
  FCellIdex := 1;

  InitCnfg;

  TStylManager.InitColWidth(self.ClassName, self.Grid_Cnfg);
  TStylManager.InitFormSize(self.ClassName, self);

  with Grid_Cnfg do
  begin
    ColWidths[0] := 40;
    ColWidths[1] := 40;
  end;
end;

procedure TDialogListUniConfig.Grid_CnfgGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  inherited;
  if (ARow = 0) or (ACol in [0, 1]) then
  begin
    HAlign := taCenter;
  end;
end;

procedure TDialogListUniConfig.FillCnfg(AList: TStringList);
var
  I: Integer;
  IdexA: Integer;
  UniConfig: TUniConfig;
begin
  with Grid_Cnfg do
  begin
    ClearGrid(Grid_Cnfg, 1);
    if (AList = nil) or (AList.Count = 0) then
      Exit;
    ClearGrid(Grid_Cnfg, AList.Count);

    BeginUpdate;
    for I := 0 to AList.Count - 1 do
    begin
      IdexA := I + 1;

      UniConfig := TUniConfig(AList.Objects[I]);
      if UniConfig = nil then
        Continue;

      Ints[0, IdexA] := IdexA;
      Objects[0, IdexA] := UniConfig;

      AddCheckBox(1, IdexA, False, False);

      Cells[2, IdexA] := IntToStr(UniConfig.UnicYear);
      Cells[3, IdexA] := UniConfig.UnicMark;
      Alignments[2, IdexA] := taCenter;
      Alignments[3, IdexA] := taCenter;
      Cells[4, IdexA] := UniConfig.UnicType;
      Alignments[4, IdexA] := taCenter;
      Cells[5, IdexA] := UniConfig.UnicUser;
      Alignments[5, IdexA] := taCenter;
      Cells[6, IdexA] := '**';
      Alignments[6, IdexA] := taCenter;
      Cells[7, IdexA] := UniConfig.UnicSrvr;
      Cells[8, IdexA] := UniConfig.DataBase;
      Cells[9, IdexA] := UniConfig.UnicPort;
      Alignments[9, IdexA] := taCenter;
      Cells[10, IdexA] := UniConfig.GetIsDirect;
      Cells[11, IdexA] := UniConfig.GetUnicStat;
      if UniConfig.UnicStat = 1 then
      begin
        FontColors[11, IdexA] := clGreen;
      end;
      Alignments[10, IdexA] := taCenter;
      Alignments[11, IdexA] := taCenter;

    end;
    EndUpdate;
  end;
end;

procedure TDialogListUniConfig.InitCnfg;
var
  cSQL: string;
  cUniC: TUniConnection;
begin
  try
    cUniC := UniConnctEx.GetConnection(FConnectionMark);

    if FListCnfg = nil then
    begin
      FListCnfg := TStringList.Create;
    end;
    TKzUtils.JustCleanList(FListCnfg);

    cSQL := 'SELECT * FROM TBL_UNICONFIG WHERE 1=1';
    if Comb_UnixType.ItemIndex <> 0 then
    begin
      cSQL := cSQL + Format('    AND  UNIX_TYPE=%S', [QuotedStr(Comb_UnixType.Text)]);
    end;
    cSQL := cSQL + '    ORDER BY UNIX_TYPE,UNIX_ORDR';

    FListCnfg := TUniConfig.StrsDB(cSQL, cUniC);
  finally
    if cUniC <> nil then
      FreeAndNil(cUniC);
  end;

  FillCnfg(FListCnfg);

  with Grid_Cnfg do
  begin
    FCellIdex := UniConnctEx.ConnctLast;

    if FCellIdex in [1..RowCount - 1] then
    begin
      ScrollInView(1, FCellIdex);
      SelectRows(FCellIdex, 1);
    end;
  end;

  if Assigned(UniConnctEx.OnDialogListUniConfigCustomStyleEvent) then
  begin
    UniConnctEx.OnDialogListUniConfigCustomStyleEvent(Grid_Cnfg);
  end;
end;

procedure TDialogListUniConfig.Grid_CnfgCanEditCell(Sender: TObject; ARow, ACol: Integer; var CanEdit: Boolean);
begin
  inherited;
  CanEdit := ACol = 1;
end;

procedure TDialogListUniConfig.Grid_CnfgCheckBoxClick(Sender: TObject; ACol, ARow: Integer; State: Boolean);
begin
  with Grid_Cnfg do
  begin
    if ARow = 0 then
    begin
      TUiUtils.CellCheck(Grid_Cnfg, State);
    end;
  end;
end;

procedure TDialogListUniConfig.Grid_CnfgDblClick(Sender: TObject);
begin
  inherited;
  if FEditMode = dlucemEdit then
  begin
    EditCnfg;
  end
  else if FEditMode = dlucemView then
  begin
    Btnv_MrokClick(Btnv_Mrok);
  end;
end;

procedure TDialogListUniConfig.AddvCnfg;
var
  uCnfg: TUniConfig;
begin
  try
    uCnfg := TUniConfig.Create;

    if FuDefault <> nil then
    begin
      TUniConfig.CopyIt(FuDefault, uCnfg);
    end;

    if ViewEditCnfg(deuemAddv, uCnfg, FConnectionMark, FLoadLast) <> Mrok then
      Exit;
  finally
    FreeAndNil(uCnfg);
  end;

  InitCnfg;
end;

procedure TDialogListUniConfig.EditCnfg;
var
  UniConfig: TUniConfig;
begin
  inherited;
  with Grid_Cnfg do
  begin
    UniConfig := nil;
    UniConfig := TUniConfig(Objects[0, RealRow]);
    if UniConfig = nil then
      Exit;

    if ViewEditCnfg(deuemEdit, UniConfig, FConnectionMark) = Mrok then
    begin
      InitCnfg;
      UniConfig := nil;
    end;
  end;
end;

function TDialogListUniConfig.ExptCnfg: TUniConfig;
begin
  Result := nil;
  with Grid_Cnfg do
  begin
    if Objects[0, RealRow] = nil then
      Exit;
    Result := TUniConfig.CopyIt(TUniConfig(Objects[0, RealRow]));
  end;
end;

procedure TDialogListUniConfig.FormDestroy(Sender: TObject);
{var
  I:Integer;}
begin
  inherited;
  {if FListCnfg<>nil then
  begin
    for I:=0 to FListCnfg.Count-1 do
    begin
      FListCnfg.Objects[I].Free;
      FListCnfg.Objects[I]:=nil;
    end;
    FListCnfg.Clear;
    FreeAndNil(FListCnfg);
  end;}
  FreeAndNilList(FListCnfg);
end;

procedure TDialogListUniConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TStylManager.SaveColWidth(self.ClassName, self.Grid_Cnfg);
  TStylManager.SaveFormSize(self.ClassName, self);
end;

procedure TDialogListUniConfig.FormCreate(Sender: TObject);
begin
  inherited;
  FListCnfg := nil;
end;

procedure TDialogListUniConfig.FreeAndNilList(AList: TStringList);
var
  I: Integer;
begin
  if (AList = nil) or (AList.Count = 0) then
    Exit;
  for I := 0 to AList.Count - 1 do
  begin
    if AList.Objects[I] <> nil then
    begin
      AList.Objects[I].Free;
      AList.Objects[I] := nil;
    end;
  end;
  AList.Clear;
  FreeAndNil(AList);
end;

procedure TDialogListUniConfig.ExptCnfg(var aCnfg: TUniConfig);
begin
  with Grid_Cnfg do
  begin
    if Objects[0, RealRow] = nil then
      Exit;
    TUniConfig.CopyIt(TUniConfig(Objects[0, RealRow]), aCnfg);
  end;
end;

procedure TDialogListUniConfig.Btnv_MrokClick(Sender: TObject);
var
  UniConfig: TUniConfig;
begin
  inherited;
  with Grid_Cnfg do
  begin
    UniConfig := nil;
    UniConfig := ExptCnfg;

    //YXC_2014_03_21_17_08_30_<
    if Assigned(UniConnctEx.OnUniConfigCustomDecryptEvent) then
    begin
      UniConnctEx.OnUniConfigCustomDecryptEvent(UniConfig, UniConfig);
    end;
    //YXC_2014_03_21_17_08_30_>

    UniConfig.TstConnection(UniConfig);

    if UniConnctEx.ActiveHint then
    begin
      if UniConfig.UnicStat <> 1 then
      begin
        if MessageBox(Handle, '是否将该连接设为活动?', '提示', MB_OKCANCEL + MB_ICONQUESTION) = Mrok then
        begin
          ActvCnfg(False);
        end;
      end;
    end;

    FreeAndNil(UniConfig);
  end;

  UniConnctEx.ConnctLast := FCellIdex;

  ModalResult := mrOk;
end;

procedure TDialogListUniConfig.Btnv_QuitClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TDialogListUniConfig.Btnv_CopyCnfgClick(Sender: TObject);
begin
  CopyCnfg;
end;

procedure TDialogListUniConfig.Btnv_DeltCnfgClick(Sender: TObject);
begin
  DeltCnfg;
end;

procedure TDialogListUniConfig.Btnv_ActvCnfgClick(Sender: TObject);
begin
  ActvCnfg;
end;

procedure TDialogListUniConfig.Btnv_OrdrCnfgClick(Sender: TObject);
begin
  OrdrCnfg;
end;

procedure TDialogListUniConfig.Btnv_TestCnfgClick(Sender: TObject);
var
  UniConfigA: TUniConfig;
begin
  inherited;
  with Grid_Cnfg do
  begin
    UniConfigA := nil;
    UniConfigA := TUniConfig(Objects[0, RealRow]);
    if UniConfigA = nil then
      Exit;

    if Assigned(UniConnctEx.OnUniConfigCustomDecryptEvent) then
    begin
      UniConnctEx.OnUniConfigCustomDecryptEvent(UniConfigA, UniConfigA);
    end;

    if not UniConfigA.TstConnection(UniConfigA) then
      Exit;
    ShowMessage('该数据库连接有效.');
  end;
end;

procedure TDialogListUniConfig.Btnv_AddvCnfgClick(Sender: TObject);
begin
  AddvCnfg;
end;

procedure TDialogListUniConfig.Btnv_EditCnfgClick(Sender: TObject);
begin
  EditCnfg;
end;

procedure TDialogListUniConfig.ActvCnfg(IsFill: Boolean);
var
  cSQL: string;
  StatA: Boolean;
  UniConfig: TUniConfig;
  UniConnct: TUniConnection;
begin
  with Grid_Cnfg do
  begin
    UniConfig := nil;
    UniConfig := TUniConfig(Objects[0, RealRow]);
    if UniConfig = nil then
      Exit;

    StatA := False;
    try
      try
        UniConnct := UniConnctEx.GetConnection(FConnectionMark);
        UniConnct.StartTransaction;

        cSQL := 'UPDATE TBL_UNICONFIG SET UNIX_STAT=0 WHERE UNIX_IDEX<>%D  AND UNIX_MARK=%S';
        cSQL := Format(cSQL, [UniConfig.UnicIndx, QuotedStr(UniConfig.UnicMark)]);
        UniConfig.ExecuteSQL(cSQL, UniConnct);

        cSQL := 'UPDATE TBL_UNICONFIG SET UNIX_STAT=1 WHERE UNIX_IDEX=%D   AND UNIX_MARK=%S';
        cSQL := Format(cSQL, [UniConfig.UnicIndx, QuotedStr(UniConfig.UnicMark)]);
        UniConfig.ExecuteSQL(cSQL, UniConnct);

        UniConnct.Commit;
        StatA := True;
      except
        UniConnct.Rollback;
      end;
    finally
      FreeAndNil(UniConnct);
    end;
  end;

  if (IsFill) and (StatA) then
  begin
    InitCnfg;
  end;
end;

procedure TDialogListUniConfig.Grid_CnfgClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  inherited;
  //
  FCellIdex := Grid_Cnfg.RealRow;
  UniConnctEx.ConnctLast := FCellIdex;
end;

procedure TDialogListUniConfig.OrdrCnfg;
var
  I: Integer;
  StatA: Boolean;
  UniConfig: TUniConfig;
  UniConnct: TUniConnection;
begin
  with Grid_Cnfg do
  begin
    StatA := False;
    try
      try
        UniConnct := UniConnctEx.GetConnection(FConnectionMark);
        UniConnct.StartTransaction;

        for I := 1 to RowCount - 1 do
        begin
          UniConfig := nil;
          UniConfig := TUniConfig(Objects[0, I]);
          if UniConfig = nil then
            Continue;
          UniConfig.UnicOrdr := I;
          UniConfig.UpdateDB(UniConnct);
        end;

        UniConnct.Commit;
        StatA := True;
      except
        UniConnct.Rollback;
      end;
    finally
      FreeAndNil(UniConnct);
    end;
  end;

  if StatA then
  begin
    InitCnfg;
  end;
end;

procedure TDialogListUniConfig.Grid_CnfgRowMoved(Sender: TObject; FromIndex, ToIndex: Integer);
begin
  inherited;
  FCellIdex := ToIndex;
end;

procedure TDialogListUniConfig.ClearGrid(AGrid: TAdvStringGrid; ARowCount, ADefaultRowCount: Integer);
begin
  with AGrid do
  begin
    BeginUpdate;

    SelectRows(1, 1);

    Filter.Clear;
    FilterActive := False;
    ClearRows(1, RowCount - 1);
    RemoveRows(2, RowCount - 2);

    if ARowCount > 1 then
      RowCount := ARowCount + 1
    else
      RowCount := ADefaultRowCount;

    EndUpdate;
  end;
end;

procedure TDialogListUniConfig.FillCnfg(aIndx: Integer; aCnfg: TUniConfig);
begin

end;

procedure TDialogListUniConfig.Btnx_CopyClick(Sender: TObject);
begin
  inherited;
  CopyCnfg;
end;

procedure TDialogListUniConfig.CopyCnfg;
var
  UniConfig: TUniConfig;
  UniConfiH: TUniConfig; //*:copy form *config
  UniConnct: TUniConnection;
begin
  inherited;
  with Grid_Cnfg do
  begin
    UniConfig := nil;
    UniConfig := TUniConfig(Objects[0, RealRow]);
    if UniConfig = nil then
      Exit;

    try
      UniConfiH := TUniConfig.Create;
      TUniConfig.CopyIt(UniConfig, UniConfiH);

      UniConfiH.IsDecrypt := False;
      UniConfiH.IsEncrypt := False;
      if Assigned(UniConnctEx.OnUniConfigCustomDecryptEvent) then
      begin
        UniConnctEx.OnUniConfigCustomDecryptEvent(UniConfiH, UniConfiH);
      end;

      UniConnct := UniConnctEx.GetConnection(FConnectionMark);
      //->
      UniConfiH.UnicIndx := UniConfiH.GetNextIdex(UniConnct);
      UniConfiH.UnicStat := 0;

      if Assigned(UniConnctEx.OnUniConfigCustomEncryptEvent) then
      begin
        UniConnctEx.OnUniConfigCustomEncryptEvent(UniConfiH, UniConfiH);
      end;

      UniConfiH.InsertDB(UniConnct);

      InitCnfg;
      //-<
    finally
      FreeAndNil(UniConnct);
      FreeAndNil(UniConfiH);
    end;
  end;
end;

procedure TDialogListUniConfig.DeltCnfg;
var
  I: Integer;
  StatA: Boolean;
  cCnfg: TUniConfig;
  cUniC: TUniConnection;
begin
  inherited;
  cUniC := nil;
  cUniC := UniConnctEx.GetConnection(FConnectionMark);
  if cUniC = nil then
    Exit;

  if TKzUtils.WarnBox('是否确定删除?') <> Mrok then
    Exit;

  try
    cUniC.StartTransaction;

    try
      with Grid_Cnfg do
      begin
        BeginUpdate;
        for I := RowCount - 1 downto 1 do
        begin
          StatA := False;
          if GetCheckBoxState(1, I, StatA) then
          begin
            if StatA then
            begin
              cCnfg := TUniConfig(Objects[0, I]);
              if cCnfg = nil then
                Continue;

              cCnfg.DeleteDB(cUniC);

              if RowCount = 2 then
              begin
                ClearRows(I, 1);
              end
              else
              begin
                ClearRows(I, 1);
                RemoveRows(I, 1);
              end;
            end;
          end;
        end;
        EndUpdate;
      end;
      cUniC.Commit;
    except
      cUniC.Rollback;
    end;
  finally
    FreeAndNil(cUniC);
  end;
end;

procedure TDialogListUniConfig.Grid_CnfgSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var
  UniConfig: TUniConfig;
begin
  inherited;
  with Grid_Cnfg do
  begin
    UniConfig := nil;
    UniConfig := TUniConfig(Objects[0, ARow]);
    if UniConfig <> nil then
    begin
      Panl_DataBase.Caption := UniConfig.DataBase;
      Panl_UnixMemo.Caption := UniConfig.UnicMemo;
    end;
  end;
end;

procedure TDialogListUniConfig.SetComboItems;
begin
  inherited;
  with Comb_UnixMark do
  begin
    Clear;
    Visible := False;
  end;

  with Comb_UnixType do
  begin
    Clear;
    Add('全部');
    Add(CONST_PROVIDER_ACCESS);
    Add(CONST_PROVIDER_SQLSRV);
    Add(CONST_PROVIDER_ORACLE);
    Add(CONST_PROVIDER_MYSQLX);
    Add(CONST_PROVIDER_POSTGR);
    ItemIndex := 0;
    Style := csDropDownList;

    //YXC_2013_03_26_10_51_37
    ItemIndex := UniConnctEx.ConnctType;
  end;
end;

procedure TDialogListUniConfig.Comb_UnixTypeCloseUp(Sender: TObject);
begin
  inherited;
  InitCnfg;
  UniConnctEx.ConnctType := TRzComboBox(Sender).ItemIndex;
end;

procedure TDialogListUniConfig.copyCnfg(uDefault: TUniConfig);
begin
  if uDefault = nil then
    Exit;

  if FuDefault = nil then
  begin
    FuDefault := TUniConfig.Create;
  end;
  TUniConfig.CopyIt(uDefault, FuDefault);
end;

end.

