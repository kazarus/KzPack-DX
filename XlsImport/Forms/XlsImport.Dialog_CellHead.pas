unit XlsImport.Dialog_CellHead;
//#XlsImport

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, AdvObj,
  BaseGrid, AdvGrid,XlsImport.Class_Cell_Head,Dialog_View, Vcl.StdCtrls;

type
  TDialogCellHead = class(TDialogView)
    Grid_Head: TAdvStringGrid;
    Panl_Main: TPanel;
    Btnv_Mrok: TButton;
    Btnv_Quit: TButton;
    procedure Grid_HeadGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure Btnv_MrokClick(Sender: TObject);
    procedure Btnv_QuitClick(Sender: TObject);
    procedure Grid_HeadDblClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    FListHead:TStringList;//&list of &tcellhead
  protected
    procedure SetInitialize;override;
    procedure SetCommParams;override;
    procedure SetGridParams;override;
    procedure SetComboItems;override;
    procedure TryFreeAndNil;override;
  public
    procedure InitHead;
    procedure ImptHead(var aCellHead:TCellHead);
  end;

var
  DialogCellHead: TDialogCellHead;

function ViewCellHead(aListHead:TStringList;var aCellHead:TCellHead):Integer;

implementation

uses
  Class_KzUtils,Class_UiUtils;

{$R *.dfm}
function ViewCellHead(aListHead:TStringList;var aCellHead:TCellHead):Integer;
begin
  try
    DialogCellHead:=TDialogCellHead.Create(nil);
    DialogCellHead.FListHead:=aListHead;
    Result:=DialogCellHead.ShowModal;
    if Result=Mrok then
    begin
      DialogCellHead.ImptHead(aCellHead);
    end;
  finally
    FreeAndNil(DialogCellHead);
  end;
end;

procedure TDialogCellHead.Btnv_MrokClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TDialogCellHead.Btnv_QuitClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TDialogCellHead.Grid_HeadDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  Btnv_MrokClick(Btnv_Mrok);
end;

procedure TDialogCellHead.Grid_HeadGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ARow=0) or (ACol in [0]) then
  begin
    HAlign:=taCenter;
  end;
end;

procedure TDialogCellHead.ImptHead(var aCellHead: TCellHead);
var
  cHead:TCellHead;
begin
  with Grid_Head do
  begin
    cHead:=TCellHead(Objects[0,RealRow]);
    if cHead=nil then Exit;

    TCellHead.CopyIt(cHead,aCellHead);
  end;
end;

procedure TDialogCellHead.InitHead;
var
  I:Integer;
  cIDX:Integer;
  cHead:TCellHead;
begin
  with Grid_Head do
  begin
    TUiUtils.ClearGrid(Grid_Head,0);
    if (FListHead=nil) or (FListHead.Count=0) then Exit;
    TUiUtils.ClearGrid(Grid_Head,FListHead.Count);

    BeginUpdate;
    for I:=0 to FListHead.Count-1 do
    begin
      cIDX:=I+1;

      cHead:=TCellHead(FListHead.Objects[I]);
      if cHead=nil then Continue;

      Objects[0,cIDX]:=cHead;
      Cells[0,cIDX]:=Format('%D',[cIDX]);
      Cells[1,cIDX]:=cHead.HeadName;
    end;
    EndUpdate;
  end;
end;

procedure TDialogCellHead.SetComboItems;
begin
  inherited;

end;

procedure TDialogCellHead.SetCommParams;
begin
  inherited;
  Caption:='对象属性';
  Btnv_Quit.Caption:='取消';
  Btnv_Mrok.Caption:='确定';
end;

procedure TDialogCellHead.SetGridParams;
begin
  inherited;
  with Grid_Head do
  begin
    RowCount:=2;
    ColCount:=20;
    DefaultColWidth:=100;
    ColWidths[0]:=40;
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
      DelimitedText:='序号,属性';
    end;

    ColCount:=ColumnHeaders.Count;

    ColumnSize.Stretch:=True;
  end;
end;

procedure TDialogCellHead.SetInitialize;
begin
  inherited;
  InitHead;
end;

procedure TDialogCellHead.TryFreeAndNil;
begin
  inherited;

end;

end.
