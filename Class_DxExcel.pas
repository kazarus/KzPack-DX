unit Class_DxExcel;


//uses:Class_DxExcel,dxSpreadSheetTypes,dxSpreadSheetGraphics;
interface
uses
  System.Classes,System.SysUtils,Vcl.Graphics,Vcl.Dialogs,
  dxSpreadSheet,dxSpreadSheetCore,dxSpreadSheetGraphics,dxSpreadSheetTypes;

type
  TDxCellStyl=class;

  TDxExcelStyleCell=procedure (Sender: TObject; ATabIndex:Integer;ACol,ARow: Integer;var ACellStyl:TDxCellStyl) of object;
  //procedure OnDxExcelStyleCell(Sender: TObject; ATabSheet:string; ACol,ARow: Integer;var ACellStyl:TObject);
  TDxExcelValidArea=procedure (Sender: TObject; ATabIndex:Integer;var AColStart,AColEnded,ARowStart,ARowEnded:Integer) of object;
  //procedure OnDxExcelValidArea(Sender: TObject; ATabSheet:string;var AColStart,AColEnded,ARowStart,ARowEnded:Integer);
  TDxExcelValidRows=procedure (Sender: TObject; ATabIndex:Integer;ARow:Integer;var Valid:Boolean) of object;
  //procedure OnDxExcelValidRows(Sender: TObject; ATabSheet:string;ARow:Integer;var Valid:Boolean);
  TDxExcelValidCols=procedure (Sender: TObject; ATabIndex:Integer;ACol:Integer;var Valid:Boolean) of object;
  //procedure OnDxExcelValidCols(Sender: TObject; ATabSheet:string;ACol:Integer;var Valid:Boolean);
  TDxExcelResizeCol=procedure (Sender: TObject; ATabIndex:Integer;ACol:Integer;var Value:Integer) of object;
  //procedure OnDxExcelResizeCol(Sender: TObject; ATabSheet:string;ACol:Integer;var Value:Integer);
  TDxExcelResizeRow=procedure (Sender: TObject; ATabIndex:Integer;ARow:Integer;var Value:Integer) of object;
  //procedure OnDxExcelResizeRow(Sender: TObject; ATabSheet:string;ARow:Integer;var Value:Integer);

  TDxCellStyl=class(TObject)
  public
    CellText:string;
    DataType:TdxSpreadSheetCellDataType;
    FontName:string;
    FontSize:Integer;
    IsfsBold:Boolean;
    FontColor:TColor; //[0..55].cell.style.font.fontcolor
    BackColor:Integer;//[0..55].cell.style.brush.backgroundcolor
    AlignHorz:TdxSpreadSheetDataAlignHorz;
    AlignVert:TdxSpreadSheetDataAlignVert;

    CellMerge:Boolean;
    CellSpanX:Integer;
    CellSpanY:Integer;
  protected
    procedure Initialize;
  public
    constructor Create;
  end;

  TDxExcel=class(TObject)
  private
    FDxExcel:TdxSpreadSheet;
    FDxCount:Integer;
  public
    OnDxExcelStyleCell:TDxExcelStyleCell;
    OnDxExcelValidArea:TDxExcelValidArea;
    OnDxExcelValidRows:TDxExcelValidRows;
    OnDxExcelValidCols:TDxExcelValidCols;
    OnDxExcelResizeRow:TDxExcelResizeRow;
    OnDxExcelResizeCol:TDxExcelResizeCol;
  public
    procedure Initialize;
    function  Execute(ATabIndex:Integer;ATabSheet:string=''):Boolean;
    function  SaveXLS(AFileName:string=''):Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  DxExcel:TDxExcel;

implementation

uses
  Class_KzDebug,Class_KzUtils;

{ TDxExcel }

constructor TDxExcel.Create;
begin
  FDxExcel:=TdxSpreadSheet.Create(nil);
  FDxCount:=0;
end;

destructor TDxExcel.Destroy;
begin
  if FDxExcel<>nil then FreeAndNil(FDxExcel);
  
  inherited;
end;

function TDxExcel.Execute(ATabIndex:Integer;ATabSheet:string):Boolean;
var
  I,M,N:Integer;

  ColIndex:Integer;
  RowIndex:Integer;

  ColStart:Integer;
  ColEnded:Integer;
  RowStart:Integer;
  RowEnded:Integer;

  Cell:TdxSpreadSheetCell;
  Styl:TDxCellStyl;

  Valid:Boolean;
  Value:Integer;
begin
  Inc(FDxCount);

  if Assigned(OnDxExcelValidArea) then
  begin
    OnDxExcelValidArea(FDxExcel,ATabIndex,ColStart,ColEnded,RowStart,RowEnded);
  end;

  KzDebug.Started;
  KzDebug.TickFmt('%S:%S',[self.ClassName,'V01']);

  try
    Styl:=TDxCellStyl.Create;

    if FDxCount<FDxExcel.SheetCount then
    begin
      FDxExcel.ActiveSheetIndex:=FDxExcel.SheetCount-1;
    end;

    if Trim(ATabSheet)<>'' then
    begin
      FDxExcel.ActiveSheet.Caption := ATabSheet;
    end;
    FDxExcel.ActiveSheetAsTable.BeginUpdate;

    ColIndex:=0;
    for I := ColStart to ColEnded do
    begin
      Valid:=True;
      if Assigned(OnDxExcelValidCols) then
      begin
        OnDxExcelValidCols(FDxExcel,ATabIndex,I,Valid);
      end;
      if not Valid then Continue;

      RowIndex:=0;
      for M := RowStart to RowEnded do
      begin
        Valid:=True;
        if Assigned(OnDxExcelValidRows) then
        begin
          OnDxExcelValidRows(FDxExcel,ATabIndex,M,Valid);
        end;
        if not Valid then Continue;

        Cell:=FDxExcel.ActiveSheetAsTable.CreateCell(RowIndex,ColIndex);
        if Cell=nil then Continue;

        Styl.Initialize;
        if Assigned(OnDxExcelStyleCell) then
        begin
          OnDxExcelStyleCell(FDxExcel,ATabIndex,I,M,Styl);
        end;

        if Styl.CellMerge then
        begin
          FDxExcel.ActiveSheetAsTable.MergedCells.Add(Rect(ColIndex,RowIndex,ColIndex+Styl.CellSpanX,RowIndex+Styl.CellSpanY));
        end;
        Cell.Style.AlignHorz :=Styl.AlignHorz;
        Cell.Style.AlignVert :=Styl.AlignVert;
        Cell.Style.Font.Name :=Styl.FontName;
        Cell.Style.Font.Size :=Styl.FontSize;
        Cell.Style.Font.Color:=Styl.FontColor;

        //Cell.AsString := Styl.CellText;

        try
          case Styl.DataType of
            cdtBlank: ;
            cdtBoolean: ;
            cdtError: ;
            cdtCurrency :Cell.AsCurrency := TKzUtils.TextToFloat(Styl.CellText);
            cdtFloat    :Cell.AsFloat    := TKzUtils.TextToFloat(Styl.CellText);
            cdtDateTime :;
            cdtInteger  :Cell.AsInteger  := StrToIntDef(Styl.CellText,0);
            cdtString   :Cell.AsString   := Styl.CellText;
            cdtFormula: ;
          end;
        except
          on E:Exception do
          begin
            raise Exception.Create(E.Message);
          end;
        end;

        Inc(RowIndex);
      end;

      Value:=0;
      if Assigned(OnDxExcelResizeCol) then
      begin
        OnDxExcelResizeCol(FDxExcel,ATabIndex,I,Value);
      end;
      if (Value<>0) and (FDxExcel.ActiveSheetAsTable.Columns[ColIndex]<>nil) then
      begin
        FDxExcel.ActiveSheetAsTable.Columns[ColIndex].Size:=Value;
      end;

      Inc(ColIndex);
    end;


    RowIndex:=0;
    for M := RowStart to RowEnded do
    begin
      Valid:=True;
      if Assigned(OnDxExcelValidRows) then
      begin
        OnDxExcelValidRows(FDxExcel,ATabIndex,M,Valid);
      end;
      if not Valid then Continue;

      Value:=0;
      if Assigned(OnDxExcelResizeRow) then
      begin
        OnDxExcelResizeRow(FDxExcel,ATabIndex,M,Value);
      end;
      if (Value<>0) and (FDxExcel.ActiveSheetAsTable.Rows[RowIndex]<>nil) then
      begin
        FDxExcel.ActiveSheetAsTable.Rows[RowIndex].Size:=Value;
      end;

      Inc(RowIndex);
    end;

    FDxExcel.ActiveSheetAsTable.EndUpdate;
    KzDebug.TickFmt('%S:%S',[self.ClassName,'V02']);
  finally
    FreeAndNil(Styl);
  end;
end;

procedure TDxExcel.Initialize;
begin
  FDxCount:=0;
end;

function TDxExcel.SaveXLS(AFileName:string): Boolean;
var
  SD:TSaveDialog;
  FileName:string;
begin
  try
    SD:=TSaveDialog.Create(nil);
    SD.Filter:='*.xls|*.xls|*.xlsx|*.xlsx';
    SD.FileName:=AFileName;
    if SD.Execute then
    begin
      FileName:=SD.FileName;
      if ExtractFileExt(FileName)='' then
      begin
        FileName:=Format('%S.xlsx',[FileName]);
      end;

      FDxExcel.ActiveSheet.SpreadSheet.SaveToFile(FileName);
    end;
  finally
    FreeAndNil(SD);
  end;
end;

{ TDxCellStyl }

constructor TDxCellStyl.Create;
begin
  Initialize;
end;

procedure TDxCellStyl.Initialize;
begin
  DataType :=cdtString;
  CellText :='';
  FontName :='ËÎÌו';
  FontSize :=10;
  IsfsBold :=False;
  AlignHorz:=ssahLeft;
  AlignVert:=ssavCenter;

  CellMerge:=False;
  CellSpanX:=0;
  CellSpanY:=0;
end;

end.
