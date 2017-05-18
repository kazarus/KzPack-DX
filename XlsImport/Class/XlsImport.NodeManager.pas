unit XlsImport.NodeManager;

interface
uses
  SysUtils, Classes, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxCore, dxCoreClasses, dxHashUtils, dxSpreadSheetCore,
  dxSpreadSheetCoreHistory, dxSpreadSheetConditionalFormatting,
  dxSpreadSheetConditionalFormattingRules, dxSpreadSheetClasses,
  dxSpreadSheetContainers, dxSpreadSheetFormulas, dxSpreadSheetHyperlinks,
  dxSpreadSheetFunctions, dxSpreadSheetGraphics, dxSpreadSheetPrinting,
  dxSpreadSheetTypes, dxSpreadSheetUtils, dxSpreadSheet;

type
  TNodeManager = class(TObject)
  public
    class function ReadNode(aSpreadSheet:TdxSpreadSheet;var aList:TStringList):Boolean;
  end;

implementation

uses
  XlsImport.Class_Cell_Node,Class_KzDebug,Class_KzUtils;


class function TNodeManager.ReadNode(aSpreadSheet: TdxSpreadSheet;
  var aList: TStringList): Boolean;
var
  I,C,R:Integer;
  ColEnded:Integer;
  ColStart:Integer;
  RowStart:Integer;
  RowEnded:Integer;

  cItem:TdxSpreadSheetMergedCell;
  cCell:TdxSpreadSheetCell;

  cIndx:Integer;
  cList:TStringList;
  cNode:TCellNode;
  xNode:TCellNode;

  function FindNext(aNode:TCellNode):Integer;
  var
    I:Integer;
  begin
    Result := 0;

    for I := 0 to aList.Count-1  do
    begin
      xNode := TCellNode(aList.Objects[I]);
      if xNode.DataINDX = aNode.DataINDX then Continue;                         //如果是自已,拉倒.

      if cNode.Top-1 = xNode.Bottom then
      begin
        if TKzUtils.NumbInRect(cNode.Left,xNode.Left,xNode.Right) then
        begin
          if TKzUtils.NumbInRect(cNode.Right,xNode.Left,xNode.Right) then
          begin
            Result := xNode.DataINDX;
            Break;
          end;
        end;
      end;
    end;
  end;
begin
  Result := False;

  if aList = nil then Exit;
  TKzUtils.JustCleanList(aList);

  with aSpreadSheet.ActiveSheetAsTable do
  begin
    ColStart := Selection.Area.Left;
    ColEnded := Selection.Area.Right;
    RowStart := Selection.Area.Top;
    RowEnded := Selection.Area.Bottom;

    for C := ColStart to ColEnded do
    begin
      for R := RowStart to RowEnded do
      begin
        cCell := Cells[R,C];
        if cCell <> nil then
        begin
          if Trim(cCell.DisplayText)='' then Continue;

          cNode := TCellNode.Create;
          cNode.Col := C;
          cNode.Row := R;
          cNode.Left := C;
          cNode.Top := R;
          cNode.Right := C;
          cNode.Bottom := R;

          cNode.Text := Trim(cCell.DisplayText);

          with cNode do
          begin
            aList.AddObject(Format('%D-%D',[cNode.Col,cNode.Row]),cNode);
          end;
        end;
      end;
    end;

    for I := 0 to MergedCells.Count-1 do
    begin
      cItem:=MergedCells.Items[I];
      if cItem=nil then Continue;

      with cItem.Area do
      begin
        cNode := TCellNode.Create;
        cNode.Col := cItem.Area.Left;
        cNode.Row := cItem.Area.Top;
        if cItem.ActiveCell <> nil then
        begin
          cNode.Text := Trim(cItem.ActiveCell.DisplayText);
        end;
        cNode.Left := cItem.Area.Left;
        cNode.Right := cItem.Area.Right;
        cNode.Top := cItem.Area.Top;
        cNode.Bottom := cItem.Area.Bottom;
      end;

      cIndx := aList.IndexOf(Format('%D-%D',[cNode.Col,cNode.Row]));
      if cIndx <> -1 then
      begin
        xNode := TCellNode(aList.Objects[cIndx]);
        if xNode <> nil then
        begin
          TCellNode.CopyIt(cNode,xNode);
        end;
      end;

      FreeAndNil(cNode);
    end;
  end;

  for I := 0 to aList.Count-1 do
  begin
    cNode := TCellNode(aList.Objects[I]);
    if cNode = nil then Continue;
    cNode.DataINDX := I+1;
  end;

  for I := 0 to aList.Count-1 do
  begin
    cNode := TCellNode(aList.Objects[I]);
    if cNode = nil then Continue;
    cNode.DataINDX := I+1;
    cNode.ParentID := FindNext(cNode);
  end;

  Result := True;
end;

end.
