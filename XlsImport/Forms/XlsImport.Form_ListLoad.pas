﻿unit XlsImport.Form_ListLoad;
//#XlsImport

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzPanel, RzStatus, Vcl.ExtCtrls,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, System.ImageList, Vcl.ImgList, RzButton,
  FormEx_View, XlsImport.Class_Load_Cnfg, System.DateUtils, XLSSheetData5,
  XLSReadWriteII5, Xc12Utils5, System.IniFiles, XlsImport.Class_Cell_Rows,
  Class_KzThrad, XlsImport.Thrad_InitBody, XlsImport.Class_Cell_Head, qjson;

type
  TFormListLoad = class(TFormExView)
    Grid_Data: TAdvStringGrid;
    Panl_1: TRzStatusBar;
    Panl_Text: TRzStatusPane;
    Prog_View: TRzProgressStatus;
    Tool_1: TRzToolbar;
    Btnv_Cnfg: TRzToolButton;
    il1: TImageList;
    Btnv_Mrok: TRzToolButton;
    Btnv_Quit: TRzToolButton;
    XLSReadWriteII51: TXLSReadWriteII5;
    procedure Btnv_QuitClick(Sender: TObject);
    procedure Btnv_MrokClick(Sender: TObject);
    procedure Btnv_CnfgClick(Sender: TObject);
    procedure Grid_DataGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure Grid_DataCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure Grid_DataDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormActivate(Sender: TObject);
  private
    FClasName:string;
    FLoadCnfg:TLoadCnfg;//*

    FListHead:TStringList;//*list of string
    FListBody:TStringList;//*list of string

    FCellHead:TStringList;//*list of *tcellhead
    FListGrab:TStringList;//*list of *tobject

    FHashHead:THashedStringList;//*list of string(%s=%d)
  protected
    procedure SetInitialize;override;
    procedure SetCommParams;override;
    procedure SetGridParams;override;
    procedure SetComboItems;override;
    procedure TryFreeAndNil;override;
  protected
    procedure CopyHead(aCellHead:TStringList);
    procedure PushGrab(aObject:TObject);
  public
    function  ReadHead(var aList:TStringList):Boolean;
    procedure ReadBody(var aList:TStringList);
    procedure InitHead(aList:TStringList);

    procedure ImptData(var Value:string);
  public
    procedure CallThradInitBody;
  public
    //for tkzthrad
    procedure OnKzThradGetMaxProgress(Sender: TObject;AMaxProgress:Integer);
    procedure OnKzThradGetOneProgress(Sender: TObject;AOneProgress:Integer);
    procedure OnKzThradGetTxtProgress(Sender: TObject;ATxtProgress:string);
    procedure OnKzThradGetMsgProgress(Sender: TObject;AMsgProgress:string;AVarProgress:array of Variant);
    procedure OnTerminate(Sender:TObject);
  end;

var
  FormListLoad: TFormListLoad;

function ViewListLoad(aClasName:string;aCellHead:TStringList;var Value:string):Integer;

implementation

uses
  Class_KzUtils,Class_UiUtils,Helpr_UniEngine,XlsImport.Dialog_LoadCnfg,XlsImport.Dialog_CellHead;

{$R *.dfm}

function ViewListLoad(aClasName:string;aCellHead:TStringList;var Value:string):Integer;
begin
  try
    FormListLoad:=TFormListLoad.Create(nil);
    FormListLoad.FClasName := aClasName;
    FormListLoad.CopyHead(aCellHead);
    Result:=FormListLoad.ShowModal;
    if Result=Mrok then
    begin
      FormListLoad.ImptData(Value);
    end;
  finally
    FreeAndNil(FormListLoad);
  end;
end;

procedure TFormListLoad.Btnv_CnfgClick(Sender: TObject);
var
  cPath:string;
begin
  if FLoadCnfg=nil then
  begin
    FLoadCnfg:=TLoadCnfg.Create;
  end;
  cPath:=FLoadCnfg.GetFilePath(FClasName);
  if FileExists(cPath) then
  begin
    FLoadCnfg.InFILE(cPath);
  end;

  if ViewLoadCnfg(YearOf(Now),FLoadCnfg,False,cPath)<>Mrok then Exit;

  Panl_Text.Caption:=Format('导入期间:%D',[FLoadCnfg.KJNDKJQJ]);

  if FileExists(FLoadCnfg.FILEPATH) then
  begin
    self.XLSReadWriteII51.Filename:=FLoadCnfg.FILEPATH;
    self.XLSReadWriteII51.Read;

    if FListHead=nil then
    begin
      FListHead:=TStringList.Create;
    end;
    TKzUtils.JustCleanList(FListHead);

    if not ReadHead(FListHead) then Exit;

    InitHead(FListHead);
    ReadBody(FListBody);

    CallThradInitBody;
  end;
end;

procedure TFormListLoad.Btnv_MrokClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TFormListLoad.Btnv_QuitClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TFormListLoad.CallThradInitBody;
var
  cThrad:TThradInitBody;
begin
  cThrad:=TThradInitBody.Create(True);
  cThrad.FRealGrid:=self.Grid_Data;
  cThrad.FListBody:=self.FListBody;
  cThrad.FHashHead:=self.FHashHead;

  cThrad.OnKzThradGetMaxProgress:=OnKzThradGetMaxProgress;
  cThrad.OnKzThradGetOneProgress:=OnKzThradGetOneProgress;
  cThrad.OnKzThradGetTxtProgress:=OnKzThradGetTxtProgress;

  cThrad.OnKzThradGetMsgProgress:=OnKzThradGetMsgProgress;
  cThrad.OnTerminate            :=OnTerminate;
  cThrad.FreeOnTerminate        :=True;

  cThrad.Resume;
end;

procedure TFormListLoad.CopyHead(aCellHead: TStringList);
var
  I: Integer;
  cHead:TCellHead;
  xHead:TCellHead;
begin
  if FCellHead=nil then
  begin
    FCellHead:=TStringList.Create;
  end;
  TKzUtils.JustCleanList(FCellHead);

  for I := 0 to aCellHead.Count-1 do
  begin
    cHead:=TCellHead(aCellHead.Objects[I]);
    if cHead=nil then Continue;

    xHead:=TCellHead.CopyIt(cHead);

    FCellHead.AddObject(xHead.HeadName,xHead);
  end;
end;

procedure TFormListLoad.FormActivate(Sender: TObject);
begin
  Btnv_CnfgClick(Btnv_Cnfg);
end;

procedure TFormListLoad.Grid_DataCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := ACol =1;
end;

procedure TFormListLoad.Grid_DataDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
var
  cHead:TCellHead;
begin
  with Grid_Data do
  begin
    if ARow=1 then
    begin
      cHead:=TCellHead.Create;
      PushGrab(cHead);
      if ViewCellHead(FCellHead,cHead)=Mrok then
      begin
        Objects[ACol,1] := cHead;
        Cells  [ACol,1] := cHead.HeadName;
        Alignments[ACol,1] := taCenter;
      end;
    end;
  end;
end;

procedure TFormListLoad.Grid_DataGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ARow=0) or (ACol in [0,1]) then
  begin
    HAlign:=taCenter;
  end;
end;

procedure TFormListLoad.ImptData(var Value: string);
var
  I,M :Integer;
  cHead:TCellHead;
  JSON1,JSON2,JSON3:TQJson;
begin
  JSON1 := TQJson.Create;
  //JSON1.Add('INT_COUNT').AsInteger:=5;
  JSON2:=JSON1.Add('LISTDATA', jdtArray);

  with Grid_Data do
  begin
    for I := 2 to RowCount-1 do
    begin
      JSON3:=JSON2.Add();
      for M:=0 to ColCount-1 do
      begin
        cHead:=TCellHead(Objects[M,1]);
        if cHead=nil then Continue;

        case cHead.DataType of
          chdtString:
          begin
            JSON3.Add(cHead.HeadCode).AsString := Trim(Cells[M,I]);
          end;
          chdtInteger:
          begin
            JSON3.Add(cHead.HeadCode).AsInteger:= StrToIntDef(Trim(Cells[M,I]),0);
          end;
          chdtFloat:
          begin
            JSON3.Add(cHead.HeadCode).AsFloat  := TKzUtils.TextToFloat(Trim(Cells[M,I]));
          end;
        end;
      end;
    end;
  end;

  Value:=JSON1.Encode(True,True);

  FreeAndNil(JSON1);
end;

procedure TFormListLoad.InitHead(aList: TStringList);
var
  I:Integer;
  cIndx: Integer;

  dIndx: Integer;
  cHead: TCellHead;
  xHead: TCellHead;
begin
  if FHashHead=nil then
  begin
    FHashHead:=THashedStringList.Create;
  end;
  FHashHead.Clear;

  with Grid_Data do
  begin
    BeginUpdate;
    for I:=0 to aList.Count-1 do
    begin
      cIndx:=I+2;
      if Grid_Data.ColCount-1<cIndx then
      begin
        AddColumn;
      end;
      Cells[cIndx,0]:=Trim(aList.Strings[I]);
      FHashHead.Add(Format('%S=%D',[Trim(aList.Strings[I]),cIndx]));

      //YXC_2017_04_14_15_22_29_<
      if (FCellHead <> nil) and (FCellHead.Count > 0) then
      begin
        dIndx := FCellHead.IndexOf(Trim(aList.Strings[I]));
        if dIndx <> -1 then
        begin
          cHead := TCellHead(FCellHead.Objects[dIndx]);
          if cHead <> nil then
          begin
            xHead := TCellHead.Create;
            TCellHead.CopyIt(cHead,xHead);

            if FListGrab = nil then
            begin
              FListGrab := TStringList.Create;
            end;
            FListGrab.AddObject('',xHead);

            Objects[cIndx,1] := xHead;
            Cells [cIndx, 1] := xHead.HeadName;
            Alignments[cIndx, 1] := taCenter;
          end;
        end;
      end;
      //YXC_2017_04_14_15_22_29_>
    end;
    EndUpdate;
  end;
end;

procedure TFormListLoad.OnKzThradGetMaxProgress(Sender: TObject;
  AMaxProgress: Integer);
begin
  Prog_View.TotalParts:=AMaxProgress;
end;

procedure TFormListLoad.OnKzThradGetMsgProgress(Sender: TObject;
  AMsgProgress: string; AVarProgress: array of Variant);
begin
  if Sender is TThradInitBody then
  begin
    if AMsgProgress=Class_KzThrad.CONST_THRAD_STAT_TRUE then
    begin
      TUiUtils.CellIndex(Grid_Data,0,2);
      //#InitLDGL;
    end;
  end;
end;

procedure TFormListLoad.OnKzThradGetOneProgress(Sender: TObject;
  AOneProgress: Integer);
begin
  Prog_View.PartsComplete:=AOneProgress;
end;

procedure TFormListLoad.OnKzThradGetTxtProgress(Sender: TObject;
  ATxtProgress: string);
begin

end;

procedure TFormListLoad.OnTerminate(Sender: TObject);
begin

end;

procedure TFormListLoad.PushGrab(aObject: TObject);
begin
  if FListGrab=nil then
  begin
    FListGrab:=TStringList.Create;
  end;
  FListGrab.AddObject('',aObject);
end;

procedure TFormListLoad.ReadBody(var aList: TStringList);
var
  I,C,R:Integer;

  CellType: TXLSCellType;

  CellRows: TCellRows;
  CellData: TCellData;

  function TryFormat(aCol,ARow:Integer):string;
  begin
    try
      Result:=Trim(XLSReadWriteII51[0].AsFmtString[aCol,aRow]);
      //Result:=FormatDateTime('YYYY-MM-DD',XLSReadWriteII51[0].AsDateTime[aCol,aRow]);
    except
      Result:=FloatToStr(XLSReadWriteII51[0].AsFloat[aCol,aRow]);
    end;
  end;
begin
  if FListBody=nil then
  begin
    FListBody:=TStringList.Create;
  end;
  TKzUtils.JustCleanList(FListBody);


  for R := FLoadCnfg.ROWSTART-1 to XLSReadWriteII51[0].LastRow do
  begin
    CellRows:=TCellRows.Create;
    CellRows.RowIndex:=R;
    CellRows.ListData:=TStringList.Create;

    for C := XLSReadWriteII51[0].FirstCol to XLSReadWriteII51[0].LastCol do
    begin
      CellType := XLSReadWriteII51[0].CellType[C,R];
      if CellType = xctNone then Continue;

      CellData:=TCellData.Create;
      CellData.RowIndex:=R;
      CellData.ColIndex:=C;
      CellData.CellData:=Trim(XLSReadWriteII51[0].AsFmtString[C,R]);
      CellData.HeadName:=Trim(XLSReadWriteII51[0].AsString[C,FLoadCnfg.RowTitle-1]);

      CellRows.ListData.AddObject('',CellData);
    end;

    FListBody.AddObject(Format('%D',[CellRows.RowIndex]),CellRows);
  end;
end;

function TFormListLoad.ReadHead(var aList: TStringList): Boolean;
var
  I,C,R:Integer;
  cNull:Boolean;
  CellType: TXLSCellType;
begin
  Result:=False;

  for C := XLSReadWriteII51[0].FirstCol to XLSReadWriteII51[0].LastCol do
  begin
    CellType := XLSReadWriteII51[0].CellType[C,FLoadCnfg.RowTitle-1];
    if CellType = xctNone then Continue;

    aList.Add(Trim(XLSReadWriteII51[0].AsString[C,FLoadCnfg.RowTitle-1]));
  end;

  Result:=True;
end;

procedure TFormListLoad.SetComboItems;
begin
  inherited;

end;

procedure TFormListLoad.SetCommParams;
begin
  inherited;
  Caption:='数据导入';
end;

procedure TFormListLoad.SetGridParams;
begin
  inherited;
  with Grid_Data do
  begin
    RowCount:=2;
    ColCount:=2;
    DefaultColWidth:=100;
    ColWidths[0]:=40;
    ColWidths[1]:=40;
    ShowHint:=True;
    HintShowCells:=True;
    HintShowSizing:=True;

    Options:=Options+[goColSizing];

    Font.Size:=10;
    Font.Name:='宋体';

    FixedFont.Size:=10;
    FixedFont.Name:='宋体';

    with ColumnHeaders do
    begin
      Clear;
      Delimiter:=',';
      DelimitedText:='序号,勾选';
    end;

    ColCount:=ColumnHeaders.Count;
  end;
end;

procedure TFormListLoad.SetInitialize;
begin
  FLoadCnfg := nil;
  FListGrab := nil;
  FListHead := nil;
  FListBody := nil;
  FHashHead := nil;
  //#FCellHead := nil; //DO NOT.
  inherited;

end;

procedure TFormListLoad.TryFreeAndNil;
begin
  inherited;
  if FLoadCnfg <> nil then FreeAndNil(FLoadCnfg);
  if FHashHead <> nil then FreeAndNil(FHashHead);
  if FListHead <> nil then FreeAndNil(FListHead);
  if FListBody <> nil then TKzUtils.TryFreeAndNil(FListBody);
  if FCellHead <> nil then TKzUtils.TryFreeAndNil(FCellHead);
  if FListGrab <> nil then TKzUtils.TryFreeAndNil(FListGrab);
end;

end.