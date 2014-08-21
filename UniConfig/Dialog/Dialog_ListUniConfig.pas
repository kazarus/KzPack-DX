unit Dialog_ListUniConfig;
//YXC_2012_06_19_12_13_54
//数据库配置列表

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Dialog_View, Grids, BaseGrid, AdvGrid, StdCtrls, ExtCtrls,Uni,UniConfig,
  UniConnct, RzButton, RzRadChk, AdvObj, RzStatus, RzPanel, RzCmboBx;

type
  TDialogListUniConfigEditMode=(dlucemEdit,dlucemView);

  TDialogListUniConfig = class(TDialogView)
    Panl_1: TPanel;
    Btnx_Edit: TButton;
    Btnx_Addx: TButton;
    Btnx_Delt: TButton;
    Btnx_Test: TButton;
    Btnx_Mrok: TButton;
    Btnx_Quit: TButton;
    ChkBox_All: TRzCheckBox;
    Btnx_1: TButton;
    Btnx_2: TButton;
    Btnx_Copy: TButton;
    RzStatusBar1: TRzStatusBar;
    Panl_UnixMemo: TRzStatusPane;
    Panl_DataBase: TRzStatusPane;
    Grid_Cnfg: TAdvStringGrid;
    Comb_UnixMark: TRzComboBox;
    Comb_UnixType: TRzComboBox;
    procedure Btnx_QuitClick(Sender: TObject);
    procedure Grid_CnfgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure Grid_CnfgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure Btnx_AddxClick(Sender: TObject);
    procedure Grid_CnfgDblClick(Sender: TObject);
    procedure Btnx_EditClick(Sender: TObject);
    procedure Btnx_DeltClick(Sender: TObject);
    procedure Btnx_MrokClick(Sender: TObject);
    procedure Btnx_TestClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChkBox_AllClick(Sender: TObject);
    procedure Btnx_1Click(Sender: TObject);
    procedure Grid_CnfgClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure Btnx_2Click(Sender: TObject);
    procedure Grid_CnfgRowMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure Btnx_CopyClick(Sender: TObject);
    procedure Grid_CnfgSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Comb_UnixTypeCloseUp(Sender: TObject);
  private
    FEditMode:TDialogListUniConfigEditMode;
    FListCnfg:TStringList;
    FCellIdex:Integer;

    //YXC_2014_04_28_10_43_31
    FConnectionMark:string;
  protected
    procedure SetInitialize;override;
    procedure SetCommParams;override;
    procedure SetComboItems;override;
    procedure SetGridParams;override;
  public
    procedure InitCnfg;
    procedure AddxCnfg;
    procedure EditCnfg;
    procedure CopyCnfg;
    procedure ActvCnfg(IsFill:Boolean=True);
    procedure OrdrCnfg;
    procedure FillCnfg(AList:TStringList);overload;
    procedure FillCnfg(AIdex:Integer;ACnfg:TUniConfig);overload;
  public
    function  ExptCnfg:TUniConfig;overload;
    procedure ExptCnfg(var ACnfg:TUniConfig);overload;
  public    
    procedure FreeAndNilList(AList:TStringList);
    procedure ClearGrid(AGrid:TAdvStringGrid;ARowCount:Integer;ADefaultRowCount:Integer=2);
  end;

var
  DialogListUniConfig: TDialogListUniConfig;

function ViewListUniConfig(AEditMode:TDialogListUniConfigEditMode;AConnectionMark:string=''):Integer;overload;
function ViewListUniConfig(AEditMode:TDialogListUniConfigEditMode;var ACnfg:TUniConfig;IsCreate:Boolean=True;AConnectionMark:string=''):Integer;overload;

implementation

uses
  Dialog_EditUniConfig;

{$R *.dfm}

function ViewListUniConfig(AEditMode:TDialogListUniConfigEditMode;AConnectionMark:string):Integer;
begin
  try
    DialogListUniConfig:=TDialogListUniConfig.Create(nil);
    
    DialogListUniConfig.FEditMode:=AEditMode;
    DialogListUniConfig.FConnectionMark:=AConnectionMark;
    Result:=DialogListUniConfig.ShowModal;
  finally
    FreeAndNil(DialogListUniConfig);
  end;
end;

function ViewListUniConfig(AEditMode:TDialogListUniConfigEditMode;var ACnfg:TUniConfig;IsCreate:Boolean;AConnectionMark:string):Integer;
begin
  try
    DialogListUniConfig:=TDialogListUniConfig.Create(nil);
    
    DialogListUniConfig.FEditMode:=AEditMode;
    DialogListUniConfig.FConnectionMark:=AConnectionMark;    
    Result:=DialogListUniConfig.ShowModal;
    if Result=Mrok then
    begin
      if IsCreate then
      begin
        ACnfg:=DialogListUniConfig.ExptCnfg;
      end else
      begin
        DialogListUniConfig.ExptCnfg(ACnfg);
      end;
    end;
  finally
    FreeAndNil(DialogListUniConfig);
  end;
end;

{ TDialogListCnfg }

procedure TDialogListUniConfig.SetCommParams;
begin
  inherited;
  Caption:='数据库列表配置';
  Width :=1024;
  Height:=Trunc(1024 * 0.618);
  Btnx_Mrok.SetFocus;
end;

procedure TDialogListUniConfig.SetGridParams;
begin
  inherited;
  with Grid_Cnfg do
  begin
    RowCount:=2;
    ColCount:=20;
    DefaultColWidth:=90;
    ColWidths[0]:=40;
    ColWidths[1]:=40;
    ColWidths[2]:=40;
    ColWidths[3]:=40;
    ColWidths[5]:=40;
    ColWidths[6]:=40;
    ColWidths[7]:=160;
    ColWidths[8]:=130;
    ColWidths[9 ]:=40;
    ColWidths[10]:=40;
    ColWidths[11]:=40;


    ShowHint:=True;
    HintShowCells:=True;
    HintShowSizing:=True;

    Options:=Options+[goColSizing];
    Options:=Options+[goRowSelect];
    Options:=Options+[goRowMoving];

    Font.Size:=10;
    Font.Name:='宋体';

    FixedFont.Size:=10;
    FixedFont.Name:='宋体';

    with ColumnHeaders do
    begin
      Clear;
      Delimiter:=',';
      DelimitedText:='序号,勾选,年度,标志,驱动,用户,密码,服务器,数据库,端口号,直联,状态';
    end;

    ColCount:=ColumnHeaders.Count;

    ColumnSize.StretchColumn:=8;
    ColumnSize.Stretch:=True;
  end;
end;

procedure TDialogListUniConfig.SetInitialize;
begin
  inherited;
  FCellIdex:=1;
  
  InitCnfg;
end;

procedure TDialogListUniConfig.Btnx_QuitClick(Sender: TObject);
begin
  inherited;
  ModalResult:=mrCancel;
end;

procedure TDialogListUniConfig.Grid_CnfgGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  inherited;
  if (ARow=0) or (ACol in [0,1]) then
  begin
    HAlign:=taCenter;
  end;         
end;

procedure TDialogListUniConfig.FillCnfg(AList:TStringList);
var
  I:Integer;
  IdexA:Integer;
  UniConfig:TUniConfig;
begin
  with Grid_Cnfg do
  begin
    ClearGrid(Grid_Cnfg,1);
    if (AList=nil) or (AList.Count=0) then Exit;
    ClearGrid(Grid_Cnfg,AList.Count);    

    BeginUpdate;    
    for I:=0 to AList.Count -1 do
    begin
      IdexA:=I+1;
      
      UniConfig:=TUniConfig(AList.Objects[I]);
      if UniConfig=nil then Continue;

      Ints[0,IdexA]:=IdexA;
      Objects[0,IdexA]:=UniConfig;

      AddCheckBox(1,IdexA,False,False);

      Cells[2,IdexA] :=IntToStr(UniConfig.UnixYear);
      Cells[3,IdexA] :=UniConfig.UnixMark;
      Alignments[2,IdexA]:=taCenter;
      Alignments[3,IdexA]:=taCenter;
      Cells[4,IdexA] :=UniConfig.UnixType;
      Alignments[4,IdexA]:=taCenter;
      Cells[5,IdexA] :=UniConfig.UnixUser;
      Alignments[5,IdexA]:=taCenter;      
      Cells[6,IdexA] :='**';
      Alignments[6,IdexA]:=taCenter;      
      Cells[7,IdexA] :=UniConfig.UnixServ;
      Cells[8,IdexA] :=UniConfig.DataBase;
      Cells[9,IdexA] :=UniConfig.UnixPort;
      Alignments[9,IdexA]:=taCenter;
      Cells[10,IdexA]:=UniConfig.GetIsDirect;
      Cells[11,IdexA]:=UniConfig.GetUnixStat;
      if UniConfig.UnixStat=1 then
      begin
        FontColors[11,IdexA]:=clGreen;
      end;        
      Alignments[10,IdexA]:=taCenter;
      Alignments[11,IdexA]:=taCenter;
      
    end;
    EndUpdate;
  end;
end;
  
procedure TDialogListUniConfig.InitCnfg;
var
  SQLA :string;
  UniConnct:TUniConnection;
begin
  UniConnct:=UniConnctEx.GetConnection(FConnectionMark);
  
  FreeAndNilList(FListCnfg);
  
  SQLA :='SELECT * FROM TBL_UNICONFIG WHERE 1=1';
  if Comb_UnixType.ItemIndex<>0 then
  begin
    SQLA:=SQLA+Format('    AND  UNIX_TYPE=%S',[QuotedStr(Comb_UnixType.Text)]);
  end;  
  SQLA:=SQLA+'    ORDER BY UNIX_TYPE,UNIX_ORDR';
  
  FListCnfg:=TUniConfig.StrsDB(SQLA,UniConnct);

  FillCnfg(FListCnfg);

  if UniConnct<>nil then
  begin
    FreeAndNil(UniConnct);
  end;

  with Grid_Cnfg do
  begin
    FCellIdex:=UniConnctEx.ConnctLast;
    
    if FCellIdex in [1..RowCount-1] then
    begin
      ScrollInView(1,FCellIdex);
      SelectRows(FCellIdex,1);
    end;  
  end;


  if Assigned(UniConnctEx.OnDialogListUniConfigCustomStyleEvent) then
  begin
    UniConnctEx.OnDialogListUniConfigCustomStyleEvent(Grid_Cnfg);
  end;    
end;

procedure TDialogListUniConfig.Grid_CnfgCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  inherited;
  CanEdit:=ACol=1;
end;

procedure TDialogListUniConfig.Btnx_AddxClick(Sender: TObject);
begin
  inherited;
  AddxCnfg;
end;

procedure TDialogListUniConfig.Grid_CnfgDblClick(Sender: TObject);
begin
  inherited;
  if FEditMode=dlucemEdit then
  begin
    EditCnfg;
  end else
  if FEditMode=dlucemView then
  begin
    Btnx_MrokClick(Btnx_Mrok);
  end;
end;

procedure TDialogListUniConfig.AddxCnfg;
begin
  if ViewEditCnfg(deuemAddx,nil,FConnectionMark)=Mrok then
  begin
    InitCnfg;
  end;
end;

procedure TDialogListUniConfig.EditCnfg;
var
  UniConfig:TUniConfig;
begin
  inherited;
  with Grid_Cnfg do
  begin
    UniConfig:=nil;
    UniConfig:=TUniConfig(Objects[0,RealRow]);
    if UniConfig=nil then Exit;

    if ViewEditCnfg(deuemEdit,UniConfig,FConnectionMark)=Mrok then
    begin
      InitCnfg;
      UniConfig:=nil;
    end;
  end;
end;

procedure TDialogListUniConfig.Btnx_EditClick(Sender: TObject);
begin
  inherited;
  EditCnfg;
end;

procedure TDialogListUniConfig.Btnx_DeltClick(Sender: TObject);
var
  I:Integer;
  StatA:Boolean;
  
  UniConfig:TUniConfig;
  UniConnct:TUniConnection;
begin
  inherited;
  UniConnct:=nil;
  UniConnct:=UniConnctEx.GetConnection(FConnectionMark);
  if UniConnct=nil then Exit;

  try
    UniConnct.StartTransaction;

    try
      with Grid_Cnfg do
      begin
        BeginUpdate;
        for I:=RowCount-1 downto 1 do
        begin
          StatA:=False;
          if GetCheckBoxState(1,I,StatA) then
          begin
            if StatA then
            begin
              UniConfig:=nil;
              UniConfig:=TUniConfig(Objects[0,I]);
              if UniConfig=nil then Continue;

              UniConfig.DeleteDB(UniConnct);

              if RowCount=2 then
              begin
                ClearRows(I,1);
              end else
              begin
                ClearRows(I,1);
                RemoveRows(I,1);
              end;
            end;
          end;
        end;
        EndUpdate;
      end;
      UniConnct.Commit;
    except
      UniConnct.Rollback;
    end;
  finally
    FreeAndNil(UniConnct);
  end;
end;

procedure TDialogListUniConfig.Btnx_MrokClick(Sender: TObject);
var
  UniConfig:TUniConfig;
begin
  inherited;
  with Grid_Cnfg do
  begin
    UniConfig:=nil;
    UniConfig:=ExptCnfg;

    //YXC_2014_03_21_17_08_30_<
    if Assigned(UniConnctEx.OnUniConfigCustomDecryptEvent) then
    begin
      UniConnctEx.OnUniConfigCustomDecryptEvent(UniConfig,UniConfig);
    end;    
    //YXC_2014_03_21_17_08_30_>

    UniConfig.TstConnection(UniConfig);

    if UniConnctEx.ActiveHint then
    begin
      if UniConfig.UnixStat<>1 then
      begin
        if MessageBox(Handle,'是否将该连接设为活动?','提示',MB_OKCANCEL+MB_ICONQUESTION)=Mrok then
        begin
          ActvCnfg(False);
        end;
      end;
    end;

    FreeAndNil(UniConfig);
  end;

  UniConnctEx.ConnctLast:=FCellIdex;

  ModalResult:=mrOk;
end;

function TDialogListUniConfig.ExptCnfg: TUniConfig;
begin
  Result:=nil;
  with Grid_Cnfg do
  begin
    if Objects[0,RealRow]=nil then Exit;
    Result:=TUniConfig.CopyIt(TUniConfig(Objects[0,RealRow]));
  end;  
end;

procedure TDialogListUniConfig.Btnx_TestClick(Sender: TObject);
var
  UniConfigA:TUniConfig;
begin
  inherited;
  with Grid_Cnfg do
  begin
    UniConfigA:=nil;
    UniConfigA:=TUniConfig(Objects[0,RealRow]);
    if UniConfigA=nil then Exit;

    if Assigned(UniConnctEx.OnUniConfigCustomDecryptEvent) then
    begin
      UniConnctEx.OnUniConfigCustomDecryptEvent(UniConfigA,UniConfigA);
    end;

    if not UniConfigA.TstConnection(UniConfigA) then Exit;
    ShowMessage('该数据库连接有效.');
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

procedure TDialogListUniConfig.FormCreate(Sender: TObject);
begin
  inherited;
  FListCnfg:=nil;
end;

procedure TDialogListUniConfig.FreeAndNilList(AList: TStringList);
var
  I:Integer;
begin
  if (AList=nil) or (AList.Count=0) then Exit;
  for I:=0 to AList.Count -1 do
  begin
    if AList.Objects[I]<>nil then
    begin
      AList.Objects[I].Free;
      AList.Objects[I]:=nil;
    end;
  end;
  AList.Clear;
  FreeAndNil(AList);
end;

procedure TDialogListUniConfig.ExptCnfg(var ACnfg: TUniConfig);
begin
  with Grid_Cnfg do
  begin
    if Objects[0,RealRow]=nil then Exit;
    TUniConfig.CopyIt(TUniConfig(Objects[0,RealRow]),ACnfg);
  end; 
end;

procedure TDialogListUniConfig.ChkBox_AllClick(Sender: TObject);
var
  I:Integer;
begin
  inherited;
  with Grid_Cnfg do
  begin
    BeginUpdate;
    for I:=1 to RowCount-1 do
    begin
      SetCheckBoxState(1,I,TRzCheckBox(Sender).Checked);
    end;  
    EndUpdate;
  end;  
end;

procedure TDialogListUniConfig.Btnx_1Click(Sender: TObject);
begin
  inherited;
  ActvCnfg;
end;

procedure TDialogListUniConfig.ActvCnfg(IsFill:Boolean);
var
  SQLA :string;
  StatA:Boolean;
  UniConfig:TUniConfig;
  UniConnct:TUniConnection;
begin
  with Grid_Cnfg do
  begin
    UniConfig:=nil;
    UniConfig:=TUniConfig(Objects[0,RealRow]);
    if UniConfig=nil then Exit;


    StatA:=False;
    try
      try
        UniConnct:=UniConnctEx.GetConnection(FConnectionMark);
        UniConnct.StartTransaction;

        SQLA:='UPDATE TBL_UNICONFIG SET UNIX_STAT=0 WHERE UNIX_IDEX<>%D  AND UNIX_MARK=%S';
        SQLA:=Format(SQLA,[UniConfig.UnixIdex,QuotedStr(UniConfig.UnixMark)]);
        UniConfig.ExecuteSQL(SQLA,UniConnct);

        SQLA:='UPDATE TBL_UNICONFIG SET UNIX_STAT=1 WHERE UNIX_IDEX=%D   AND UNIX_MARK=%S';
        SQLA:=Format(SQLA,[UniConfig.UnixIdex,QuotedStr(UniConfig.UnixMark)]);
        UniConfig.ExecuteSQL(SQLA,UniConnct);        

        UniConnct.Commit;
        StatA:=True;
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

procedure TDialogListUniConfig.Grid_CnfgClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  //
  FCellIdex:=Grid_Cnfg.RealRow;
  UniConnctEx.ConnctLast:=FCellIdex;
end;

procedure TDialogListUniConfig.Btnx_2Click(Sender: TObject);
begin
  inherited;
  OrdrCnfg;
end;

procedure TDialogListUniConfig.OrdrCnfg;
var
  I:Integer;
  StatA:Boolean;
  UniConfig:TUniConfig;
  UniConnct:TUniConnection;
begin
  with Grid_Cnfg do
  begin
    StatA:=False;
    try
      try
        UniConnct:=UniConnctEx.GetConnection(FConnectionMark);
        UniConnct.StartTransaction;

        for I:=1 to RowCount-1 do
        begin
          UniConfig:=nil;
          UniConfig:=TUniConfig(Objects[0,I]);
          if UniConfig=nil then Continue;
          UniConfig.UnixOrdr:=I;
          UniConfig.UpdateDB(UniConnct);
        end;

        UniConnct.Commit;
        StatA:=True;
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

procedure TDialogListUniConfig.Grid_CnfgRowMoved(Sender: TObject;
  FromIndex, ToIndex: Integer);
begin
  inherited;
  FCellIdex:=ToIndex;
end;

procedure TDialogListUniConfig.ClearGrid(AGrid: TAdvStringGrid;
  ARowCount, ADefaultRowCount: Integer);
begin
  with AGrid do
  begin
    BeginUpdate;

    SelectRows(1,1);

    Filter.Clear;
    FilterActive:=False;
    ClearRows(1, RowCount - 1);
    RemoveRows(2,RowCount-2);

    if ARowCount > 1 then
      RowCount:=ARowCount+1
    else
      RowCount:=ADefaultRowCount;
      
    EndUpdate;
  end;
end;

procedure TDialogListUniConfig.FillCnfg(AIdex: Integer; ACnfg: TUniConfig);
begin

end;

procedure TDialogListUniConfig.Btnx_CopyClick(Sender: TObject);
begin
  inherited;
  CopyCnfg;
end;

procedure TDialogListUniConfig.CopyCnfg;
var
  UniConfig:TUniConfig;
  UniConfiH:TUniConfig;//*:copy form *config
  UniConnct:TUniConnection;
begin
  inherited;
  with Grid_Cnfg do
  begin
    UniConfig:=nil;
    UniConfig:=TUniConfig(Objects[0,RealRow]);
    if UniConfig=nil then Exit;
    
    try
      UniConfiH:=TUniConfig.Create;
      TUniConfig.CopyIt(UniConfig,UniConfiH);


      UniConfiH.IsDecrypt:=False;
      UniConfiH.IsEncrypt:=False;
      if Assigned(UniConnctEx.OnUniConfigCustomDecryptEvent) then
      begin
        UniConnctEx.OnUniConfigCustomDecryptEvent(UniConfiH,UniConfiH);
      end;

      UniConnct :=UniConnctEx.GetConnection(FConnectionMark);
      //->
      UniConfiH.UnixIdex:=UniConfiH.GetNextIdex(UniConnct);
      UniConfiH.UnixStat:=0;

      if Assigned(UniConnctEx.OnUniConfigCustomEncryptEvent) then
      begin
        UniConnctEx.OnUniConfigCustomEncryptEvent(UniConfiH,UniConfiH);
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

procedure TDialogListUniConfig.Grid_CnfgSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  UniConfig:TUniConfig;  
begin
  inherited;
  with Grid_Cnfg do
  begin
    UniConfig:=nil;
    UniConfig:=TUniConfig(Objects[0,ARow]);
    if UniConfig<>nil then
    begin
      Panl_DataBase.Caption:=UniConfig.DataBase;
      Panl_UnixMemo.Caption:=UniConfig.UnixMemo;
    end;
  end;
end;

procedure TDialogListUniConfig.SetComboItems;
begin
  inherited;
  with Comb_UnixMark do
  begin
    Clear;
    Visible:=False;
  end;

  with Comb_UnixType do
  begin
    Clear;
    Add('全部');
    Add(CONST_PROVIDER_ACCESS);
    Add(CONST_PROVIDER_SQLSRV);
    Add(CONST_PROVIDER_ORACLE);
    ItemIndex:=0;
    Style:=csDropDownList;

    //YXC_2013_03_26_10_51_37
    ItemIndex:=UniConnctEx.ConnctType;
  end;
end;

procedure TDialogListUniConfig.Comb_UnixTypeCloseUp(Sender: TObject);
begin
  inherited;
  InitCnfg;
  UniConnctEx.ConnctType:=TRzComboBox(Sender).ItemIndex;
end;

end.

