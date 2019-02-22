unit Class_DxExcel;


//uses:Class_DxExcel,dxSpreadSheetTypes,dxSpreadSheetGraphics;
interface
uses
  System.Classes, System.SysUtils, Vcl.Graphics, Vcl.Dialogs, Vcl.Controls,
  cxGraphics, dxSpreadSheet, dxSpreadSheetCore, dxSpreadSheetGraphics,
  dxSpreadSheetTypes;

type
  TDxCellStyl=class;

  TDxExcelStyleCell = procedure(Sender: TObject; aTabSheet: Integer; ACol, ARow: Integer; var ACellStyl: TDxCellStyl) of object;
  //procedure OnDxExcelStyleCell(Sender: TObject; aTabSheet:string; ACol,ARow: Integer;var ACellStyl:TObject);

  TDxExcelValidArea = procedure(Sender: TObject; aTabSheet: Integer; var AColStart, AColEnded, ARowStart, ARowEnded: Integer) of object;
  //procedure OnDxExcelValidArea(Sender: TObject; aTabSheet:string;var AColStart,AColEnded,ARowStart,ARowEnded:Integer);

  TDxExcelValidRows = procedure(Sender: TObject; aTabSheet: Integer; ARow: Integer; var Valid: Boolean) of object;
  //procedure OnDxExcelValidRows(Sender: TObject; aTabSheet:string;ARow:Integer;var Valid:Boolean);

  TDxExcelValidCols = procedure(Sender: TObject; aTabSheet: Integer; ACol: Integer; var Valid: Boolean) of object;
  //procedure OnDxExcelValidCols(Sender: TObject; aTabSheet:string;ACol:Integer;var Valid:Boolean);

  TDxExcelResizeCol = procedure(Sender: TObject; aTabSheet: Integer; ACol: Integer; var Value: Integer) of object;
  //procedure OnDxExcelResizeCol(Sender: TObject; aTabSheet:string;ACol:Integer;var Value:Integer);

  TDxExcelResizeRow = procedure(Sender: TObject; aTabSheet: Integer; ARow: Integer; var Value: Integer) of object;
  //procedure OnDxExcelResizeRow(Sender: TObject; aTabSheet:string;ARow:Integer;var Value:Integer);

  TDxExcelStartSave = procedure(Sender: TObject; aTabSheet: Integer) of object;
  //procedure OnDxExcelStartSave(Sener: TObject; aTabSheet:Integer);

  TDxCellStyl=class(TObject)
  public
    CellText: string;
    DataType: TdxSpreadSheetCellDataType;
    FontName: string;
    FontSize: Integer;
    //@IsfsBold: Boolean;
    FontStyle: TFontStyles;
    FontColor: TColor; //[0..55].cell.style.font.fontcolor
    BackColor: TColor; //[0..55].cell.style.brush.backgroundcolor
    ForeColor: TColor; //[0..55].cell.style.brush.backgroundcolor
    AlignHorz: TdxSpreadSheetDataAlignHorz;
    AlignVert: TdxSpreadSheetDataAlignVert;
    CellMerge: Boolean;
    CellSpanX: Integer;
    CellSpanY: Integer;
    AddBorder: Boolean;
  protected
    procedure Initialize;
  public
    constructor Create;
  end;

  TDxExcel=class(TObject)
  private
    FDxExcel: TdxSpreadSheet;
    FDxCount: Integer;
  public
    OnDxExcelStyleCell: TDxExcelStyleCell;
    OnDxExcelValidArea: TDxExcelValidArea;
    OnDxExcelValidRows: TDxExcelValidRows;
    OnDxExcelValidCols: TDxExcelValidCols;
    OnDxExcelResizeRow: TDxExcelResizeRow;
    OnDxExcelResizeCol: TDxExcelResizeCol;
    OnDxExcelStartSave: TDxExcelStartSave;
  public
    procedure Initialize;
    function  Execute(aTablIndex:Integer;aTabSheet:string=''):Boolean;
    function  SaveXLS(aFileName:string=''):Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  DxExcel:TDxExcel;

implementation

uses
  Class_KzDebug,Class_KzUtils;

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

function TDxExcel.Execute(aTablIndex:Integer;aTabSheet:string):Boolean;
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
    OnDxExcelValidArea(FDxExcel,aTablIndex,ColStart,ColEnded,RowStart,RowEnded);
  end;

  KzDebug.Started;
  KzDebug.TickFmt('%S:%S',[self.ClassName,'V01']);

  try
    Styl:=TDxCellStyl.Create;

    if FDxCount > FDxExcel.SheetCount then
    begin
      FDxExcel.AddSheet();
    end;
    FDxExcel.ActiveSheetIndex:=FDxExcel.SheetCount-1;

    if Trim(aTabSheet)<>'' then
    begin
      FDxExcel.ActiveSheet.Caption := aTabSheet;
    end;
    FDxExcel.ActiveSheetAsTable.BeginUpdate;


    ColIndex:=0;
    for I := ColStart to ColEnded do
    begin
      Valid:=True;
      if Assigned(OnDxExcelValidCols) then
      begin
        OnDxExcelValidCols(FDxExcel,aTablIndex,I,Valid);
      end;
      if not Valid then Continue;

      RowIndex:=0;
      for M := RowStart to RowEnded do
      begin
        Valid:=True;
        if Assigned(OnDxExcelValidRows) then
        begin
          OnDxExcelValidRows(FDxExcel,aTablIndex,M,Valid);
        end;
        if not Valid then Continue;

        Cell:=FDxExcel.ActiveSheetAsTable.CreateCell(RowIndex,ColIndex);
        if Cell=nil then Continue;

        Styl.Initialize;
        if Assigned(OnDxExcelStyleCell) then
        begin
          OnDxExcelStyleCell(FDxExcel,aTablIndex,I,M,Styl);
        end;

        if Styl.CellMerge then
        begin
          FDxExcel.ActiveSheetAsTable.MergedCells.Add(Rect(ColIndex,RowIndex,ColIndex+Styl.CellSpanX,RowIndex+Styl.CellSpanY));
        end;
        Cell.Style.AlignHorz  := Styl.AlignHorz;
        Cell.Style.AlignVert  := Styl.AlignVert;
        Cell.Style.Font.Name  := Styl.FontName;
        Cell.Style.Font.Size  := Styl.FontSize;
        Cell.Style.Font.Color := Styl.FontColor;
        Cell.Style.Font.Style := Styl.FontStyle;
        Cell.Style.Brush.BackgroundColor := Styl.BackColor;
        Cell.Style.Brush.BackgroundColor := Styl.BackColor;
        Cell.Style.Brush.ForegroundColor := Styl.ForeColor;

        if Styl.AddBorder then
        begin
          Cell.Style.Borders[bLeft]  .Style := sscbsThin;
          Cell.Style.Borders[bTop]   .Style := sscbsThin;
          Cell.Style.Borders[bRight] .Style := sscbsThin;
          Cell.Style.Borders[bBottom].Style := sscbsThin;
        end;


        {#Cell.Style.Borders[bLeft].Color:=clRed;
        Cell.Style.Borders[bTop].Color:=clRed;
        Cell.Style.Borders[bRight].Color:=clRed;
        Cell.Style.Borders[bBottom].Color:=clRed;}

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
        OnDxExcelResizeCol(FDxExcel,aTablIndex,I,Value);
      end;
      if (Value<>0) and (FDxExcel.ActiveSheetAsTable.Columns[ColIndex]<>nil) then
      begin
        FDxExcel.ActiveSheetAsTable.Columns[ColIndex].Size:=Value;
      end;

      Inc(ColIndex);
    end;

    //#ValidRows,ResizeRow
    RowIndex:=0;
    for M := RowStart to RowEnded do
    begin
      Valid:=True;
      if Assigned(OnDxExcelValidRows) then
      begin
        OnDxExcelValidRows(FDxExcel,aTablIndex,M,Valid);
      end;
      if not Valid then Continue;

      Value:=0;
      if Assigned(OnDxExcelResizeRow) then
      begin
        OnDxExcelResizeRow(FDxExcel,aTablIndex,M,Value);
      end;
      if (Value<>0) and (FDxExcel.ActiveSheetAsTable.Rows[RowIndex]<>nil) then
      begin
        FDxExcel.ActiveSheetAsTable.Rows[RowIndex].Size:=Value;
      end;

      Inc(RowIndex);
    end;

    //#StartSave
    if Assigned(OnDxExcelStartSave) then
    begin
      OnDxExcelStartSave(FDxExcel,aTablIndex);
    end;


    FDxExcel.ActiveSheetAsTable.EndUpdate;
    KzDebug.TickFmt('%S:%S',[self.ClassName,'V02']);
  finally
    FreeAndNil(Styl);
  end;
end;

procedure TDxExcel.Initialize;
begin
  FDxCount := 0;
end;

function TDxExcel.SaveXLS(aFileName:string): Boolean;
var
  SD: TSaveDialog;
  FileName: string;
begin
  Result := False;

  try
    SD:=TSaveDialog.Create(nil);
    SD.Filter:='*.xlsx|*.xlsx|*.xls|*.xls';
    SD.FileName:=aFileName;
    if not SD.Execute then Exit;

    FileName:=SD.FileName;
    if ExtractFileExt(FileName) = '' then
    begin
      FileName := Format('%S.xlsx', [FileName]);
    end;

    if FileExists(FileName) then
    begin
      if TKzUtils.ShowFmt('文件名[%S]已经存在'+#13+'是否覆盖?',[FileName]) <> Mrok then Exit;
    end;

    FDxExcel.ActiveSheet.SpreadSheet.SaveToFile(FileName);
  finally
    FreeAndNil(SD);
  end;

  Result := True;
end;

constructor TDxCellStyl.Create;
begin
  Initialize;
end;

procedure TDxCellStyl.Initialize;
begin
  DataType := cdtString;
  CellText := '';
  FontName := '宋体';
  FontSize := 10;
  //@IsfsBold :=False;
  FontStyle := [];
  AlignHorz := ssahLeft;
  AlignVert := ssavCenter;

  CellMerge := False;
  CellSpanX := 0;
  CellSpanY := 0;

  BackColor := clDefault;
  FontColor := clDefault;
  ForeColor := clDefault;
end;

end.
