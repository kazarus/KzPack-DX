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
    class function ReadNodeH(aSpreadSheet: TdxSpreadSheet; var aList: TStringList): Boolean; overload;//#横向栏目
    class function ReadNodeV(aSpreadSheet: TdxSpreadSheet; var aList: TStringList): Boolean; overload;//#纵向栏目
    //@class function ReadExpt(aSpreadSheet: TdxSpreadSheet; var aList: TStringList): Boolean; overload;
  end;

implementation

uses
  XlsImport.Class_Cell_Node,Class_KzDebug,Class_KzUtils;


{@class function TNodeManager.ReadExpt(aSpreadSheet: TdxSpreadSheet; var aList: TStringList): Boolean;
var
  I,C,R:Integer;
  ColEnded:Integer;
  ColStart:Integer;
  RowStart:Integer;
  RowEnded:Integer;

  cITEM:TdxSpreadSheetMergedCell;
  cCell:TdxSpreadSheetCell;


  cIndx:Integer;
  cList:TStringList;
  cNODE:TCellNode;
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

      if cNODE.Top-1 = xNode.Bottom then
      begin
        if TKzUtils.NumbInRect(cNODE.Left,xNode.Left,xNode.Right) then
        begin
          if TKzUtils.NumbInRect(cNODE.Right,xNode.Left,xNode.Right) then
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

          cNODE := TCellNode.Create;
          cNODE.Col := C;
          cNODE.Row := R;
          cNODE.Left := C-ColStart;      //->tgzjgexpt
          cNODE.Top := R-RowStart;
          cNODE.Right := C-ColStart;
          cNODE.Bottom := R-RowStart;

          cNODE.Text := Trim(cCell.DisplayText);


          with cNODE do
          begin
            aList.AddObject(Format('%D-%D',[cNODE.Col,cNODE.Row]),cNODE);
          end;
        end;
      end;
    end;

    for I := 0 to MergedCells.Count-1 do
    begin
      cITEM:=MergedCells.Items[I];
      if cITEM=nil then Continue;

      with cITEM.Area do
      begin
        cNODE := TCellNode.Create;
        cNODE.Col := cITEM.Area.Left;
        cNODE.Row := cITEM.Area.Top;
        if cITEM.ActiveCell <> nil then
        begin
          if Trim(cITEM.ActiveCell.DisplayText) <> '' then
          begin
            cNODE.Text := Trim(cITEM.ActiveCell.DisplayText);
          end;

          cNODE.FontSize := cITEM.ActiveCell.Style.Font.Size;

          case cITEM.ActiveCell.Style.AlignHorz of
            ssahGeneral,ssahLeft:
            begin
              cNODE.Align :=1;
            end;
            ssahCenter:
            begin
              cNODE.Align :=2;
            end;
            ssahRight:
            begin
              cNODE.Align :=3;
            end;
          end;
        end;

        cNODE.Left := cITEM.Area.Left-Selection.Area.Left;
        cNODE.Right := cITEM.Area.right-ColStart;
        cNODE.Top := cITEM.Area.Top-Selection.Area.Top;
        cNODE.Bottom := cITEM.Area.Bottom-RowStart;
        if cITEM.Area.Right = ColEnded  then
        begin
          cNODE.Right:=-1;
          //tgzjgexpt.EXPTMERGECOLEND :=-1;
        end;
      end;

      cIndx := aList.IndexOf(Format('%D-%D',[cNODE.Col,cNODE.Row]));
      if cIndx <> -1 then
      begin
        xNode := TCellNode(aList.Objects[cIndx]);
        if xNode <> nil then
        begin
          TCellNode.CopyIt(cNODE,xNode);
        end;
      end;

      FreeAndNil(cNODE);
    end;
  end;

  for I := 0 to aList.Count-1 do
  begin
    cNODE := TCellNode(aList.Objects[I]);
    if cNODE = nil then Continue;
    cNODE.DataINDX := I+1;
  end;

  for I := 0 to aList.Count-1 do
  begin
    cNODE := TCellNode(aList.Objects[I]);
    if cNODE = nil then Continue;
    cNODE.DataINDX := I+1;
    cNODE.ParentID := FindNext(cNODE);
  end;

  Result := True;
end;}

class function TNodeManager.ReadNodeH(aSpreadSheet: TdxSpreadSheet; var aList: TStringList): Boolean;
var
  I, C, R: Integer;
  ColEnded: Integer;
  ColStart: Integer;
  RowStart: Integer;
  RowEnded: Integer;

  cITEM: TdxSpreadSheetMergedCell;
  cCell: TdxSpreadSheetCell;

  cIndx: Integer;
  cList: TStringList;
  cNODE: TCellNode;
  xNode: TCellNode;

  function FindNext(aNode:TCellNode):Integer;
  var
    I:Integer;
  begin
    Result := 0;

    for I := 0 to aList.Count-1  do
    begin
      xNode := TCellNode(aList.Objects[I]);
      if xNode.DataIndx = aNode.DataIndx then Continue;                         //#如果是自已,拉倒.

      if cNODE.Top - 1 = xNode.Bottom then
      begin
        if TKzUtils.NumbInRect(cNODE.Left,xNode.Left,xNode.Right) then
        begin
          if TKzUtils.NumbInRect(cNODE.Right,xNode.Left,xNode.Right) then
          begin
            Result := xNode.DataIndx;
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

          cNODE := TCellNode.Create;
          cNODE.Col := C;
          cNODE.Row := R;
          cNODE.Left := C;
          cNODE.Top := R;
          cNODE.Right := C;
          cNODE.Bottom := R;

          cNODE.Text := Trim(cCell.DisplayText);

          with cNODE do
          begin
            aList.AddObject(Format('%D-%D',[cNODE.Col,cNODE.Row]),cNODE);
          end;
        end;
      end;
    end;

    for I := 0 to MergedCells.Count-1 do
    begin
      cITEM := MergedCells.Items[I];
      if cITEM = nil then Continue;

      with cITEM.Area do
      begin
        cNODE := TCellNode.Create;
        cNODE.Col := cITEM.Area.Left;
        cNODE.Row := cITEM.Area.Top;
        if cITEM.ActiveCell <> nil then
        begin
          cNODE.Text := Trim(cITEM.ActiveCell.DisplayText);
        end;
        cNODE.Left := cITEM.Area.Left;
        cNODE.Right := cITEM.Area.Right;
        cNODE.Top  := cITEM.Area.Top;
        cNODE.Bottom := cITEM.Area.Bottom;
        KzDebug.FileFmt('%S:%D:%D:%D:%D',[cNODE.Text,cNODE.Left,cNODE.Right,cNODE.Top,cNODE.Bottom]);

        //@cNODE.Top := Selection.Area.Top - cITEM.Area.Top;
        //@cNODE.Bottom := Selection.Area.Bottom - cITEM.Area.Bottom;
        //@cNODE.Top := Selection.Area.Top;
        //@cNODE.Bottom := Selection.Area.Bottom;
      end;

      cIndx := aList.IndexOf(Format('%D-%D',[cNODE.Col,cNODE.Row]));
      if cIndx <> -1 then
      begin
        xNode := TCellNode(aList.Objects[cIndx]);
        if xNode <> nil then
        begin
          cNODE.Top := xNode.Top;
          cNODE.Bottom := xNode.Bottom;
          TCellNode.CopyIt(cNODE,xNode);
        end;
      end;

      FreeAndNil(cNODE);
    end;
  end;

  for I := 0 to aList.Count-1 do
  begin
    cNODE := TCellNode(aList.Objects[I]);
    if cNODE = nil then Continue;
    cNODE.DataIndx := I+1;
  end;

  for I := 0 to aList.Count-1 do
  begin
    cNODE := TCellNode(aList.Objects[I]);
    if cNODE = nil then Continue;
    cNODE.DataIndx := I+1;
    cNODE.ParentID := FindNext(cNODE);
  end;

  Result := True;
end;

class function TNodeManager.ReadNodeV(aSpreadSheet: TdxSpreadSheet; var aList: TStringList): Boolean;
var
  I, C, R: Integer;
  ColEnded: Integer;
  ColStart: Integer;
  RowStart: Integer;
  RowEnded: Integer;

  cITEM: TdxSpreadSheetMergedCell;
  cCell: TdxSpreadSheetCell;

  cIndx: Integer;
  cList: TStringList;
  cNODE: TCellNode;
  xNode: TCellNode;

  function FindNext(aNode:TCellNode):Integer;
  var
    I:Integer;
  begin
    Result := 0;

    for I := 0 to aList.Count-1  do
    begin
      xNode := TCellNode(aList.Objects[I]);
      if xNode.DataIndx = aNode.DataIndx then Continue;                         //#如果是自已,拉倒.

      if cNODE.Left - 1 = xNode.Right then
      begin
        if TKzUtils.NumbInRect(cNODE.Top,xNode.Top,xNode.Bottom) then
        begin
          if TKzUtils.NumbInRect(cNODE.Bottom, xNode.Top, xNode.Bottom) then
          begin
            Result := xNode.DataIndx;
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

          cNODE := TCellNode.Create;
          cNODE.Col := C;
          cNODE.Row := R;
          cNODE.Left := C;
          cNODE.Top := R;
          cNODE.Right := C;
          cNODE.Bottom := R;

          //#cNODE.Text := Trim(cCell.DisplayText);
          cNODE.Text := cCell.DisplayText;

          with cNODE do
          begin
            aList.AddObject(Format('%D-%D',[cNODE.Col,cNODE.Row]),cNODE);
          end;
        end;
      end;
    end;

    for I := 0 to MergedCells.Count-1 do
    begin
      cITEM := MergedCells.Items[I];
      if cITEM = nil then Continue;

      with cITEM.Area do
      begin
        cNODE := TCellNode.Create;
        cNODE.Col := cITEM.Area.Left;
        cNODE.Row := cITEM.Area.Top;
        if cITEM.ActiveCell <> nil then
        begin
          //#cNODE.Text := Trim(cITEM.ActiveCell.DisplayText);
          cNODE.Text := cITEM.ActiveCell.DisplayText;
        end;
        cNODE.Left := cITEM.Area.Left;
        cNODE.Right := cITEM.Area.Right;
        cNODE.Top  := cITEM.Area.Top;
        cNODE.Bottom := cITEM.Area.Bottom;

        //@cNODE.Top := Selection.Area.Top - cITEM.Area.Top;
        //@cNODE.Bottom := Selection.Area.Bottom - cITEM.Area.Bottom;
        //@cNODE.Top := Selection.Area.Top;
        //@cNODE.Bottom := Selection.Area.Bottom;
      end;

      cIndx := aList.IndexOf(Format('%D-%D',[cNODE.Col,cNODE.Row]));
      if cIndx <> -1 then
      begin
        xNode := TCellNode(aList.Objects[cIndx]);
        if xNode <> nil then
        begin
          xNode.Left := cNODE.Left;
          xNode.Right := cNODE.Right;
          TCellNode.CopyIt(cNODE,xNode);
        end;
      end;

      FreeAndNil(cNODE);
    end;
  end;

  for I := 0 to aList.Count-1 do
  begin
    cNODE := TCellNode(aList.Objects[I]);
    if cNODE = nil then Continue;
    cNODE.DataIndx := I+1;
  end;

  for I := 0 to aList.Count-1 do
  begin
    cNODE := TCellNode(aList.Objects[I]);
    if cNODE = nil then Continue;
    cNODE.DataIndx := I+1;
    cNODE.ParentID := FindNext(cNODE);
  end;

  Result := True;
end;

end.
