unit Class_UiUtils;
//#

interface
uses
  Classes, SysUtils, AdvGrid, frxClass, ElTree, Math, Graphics, RzBtnEdt,
  IniFiles, Forms;

type
  TUiUtils=class(TObject)
  public
    class function  GetMiddLeft(AParentWidth, ASelfWidth: Integer): Integer;

    class function  GetPrevCode(aSelfLevl: Integer; aSelfCode, aCodeRule: string; aWithDash: Boolean = False): string;
    class function  GetRuleNumb(aCodeRule: string; aLevl: Integer = -1; aWithDash: Boolean = True): Integer;
    class function  GetRuleLevl(aCodeRule: string; aSelfCode: string; aWithDash: Boolean = True): Integer;
  public
    class function  StringToColorDef(AValue: string; ADef: string = 'clWhite'): TColor;
  public
    //rz
    class procedure WhenEditExit(Sender:TObject);
  public
    class procedure ToScrennCenter(aForm:TForm);
  public
    //grid
    class function  GetCheckBoxState(aGrid: TAdvStringGrid; aCol, ARow: Integer): Integer;
    class procedure SetCheckBoxState(aGrid: TAdvStringGrid; aCol, ARow, AStat: Integer);

    class function  GetCellTextState(aGrid: TAdvStringGrid; aCol, ARow: Integer): Integer;
    class procedure SetCellTextState(aGrid: TAdvStringGrid; aCol, ARow, AStat: Integer);

    class procedure SetGridColParams(aGrid: TAdvStringGrid; aColParams: TStringList; aFontColor: TColor = clBlack);

    class function  GetCellTextAlign(aGrid: TAdvStringGrid; aCol, ARow: Integer): Integer;
    class procedure SetCellTextAlign(aGrid: TAdvStringGrid; aCol, ARow, AAlig: Integer);
    class function  GetGridAlignment(AAlig: Integer): TAlignment;

    class function  GetStrsCellChked(aGrid: TAdvStringGrid; aCol: Integer): TStringList; deprecated;
    class function  GetListCellChked(aGrid: TAdvStringGrid; aCol: Integer = 1): TStringList;
    class function  GetSizeCellChked(aGrid: TAdvStringGrid; aCol: Integer): Integer;
    class procedure SetGridCellChked(aGrid: TAdvStringGrid; aCol: Integer; AValue: Boolean);

    class procedure ClearGrid(aGrid: TAdvStringGrid; aRowCount: Integer; aDefaultRowCount: Integer = 2);
    class procedure CleanGrid(aGrid: TAdvStringGrid; aDefaultRowCount: Integer = 1); deprecated;//#逐条清空,性能较差.以零计数.
    class procedure BatchGrid(aGrid: TAdvStringGrid; aDefaultRowHeadCount: Integer = 1); //#批量清空,性能要比CleanGrid好.

    class procedure CellIndex(aGrid: TAdvStringGrid; aCol: Integer = 0; aRowStart: Integer = 1; aRowEndEd: Integer = -1);

    class procedure HeadIndex(aGrid: TAdvStringGrid; ARow: Integer = 0);

    class function  GridCheck(aGrid: TAdvStringGrid; aCol: Integer = 1; aRowStart: Integer = 1; aRowEndEd: Integer = -1): TStringList;
    class procedure CellCheck(aGrid: TAdvStringGrid; AValue: Boolean; aCol: Integer = 1; aRowStart: Integer = 1; aRowEndEd: Integer = -1);
    class procedure CellClick(Sender: TObject; ARow, aCol: Integer; aCheckBoxCol: Integer = 1);
    class procedure WordWarps(aGrid: TAdvStringGrid; aStartCol: Integer = 0; aStartRow: Integer = 1);

    class procedure SelectArea(aGrid:TAdvStringGrid;aCol:Integer=1;aValue:Boolean=True);

    class procedure DblClickCell(aGrid: TAdvStringGrid; aRow: Integer);
  public
    {begin
      if Item.Checked then
      begin
        TUiUtils.SetItemNextChecked(TElTree(Sender),Item,True);
      end else
      begin
        TUiUtils.SetItemNextChecked(TElTree(Sender),Item,False);
        TUiUtils.SetItemPrevChecked(TElTree(Sender),Item,False);
      end;
    end;}
    class procedure SetItemNextChecked(aTree: TElTree; aItem: TElTreeItem; AStat: Boolean);
    class procedure SetItemPrevChecked(aTree: TElTree; aItem: TElTreeItem; AStat: Boolean);
    //eltree.common
    class function  GetSizeItemChked(aTree: TElTree; aCheckChild: Boolean = False): Integer;
    class procedure SetTreeItemChked(Value, IncludeLast: Boolean; aTree: TElTree);
    class function  GetMaxLevelInTreeView(aTree: TElTree): Integer;
    class procedure TreeIndex(aTree: TElTree);
    class procedure TreeInit(aTree: TElTree);
    class function  GetNamePath(aNameDash: string; aItem: TElTreeItem; aTree: TElTree): string;
    class procedure GetCodePath(aCodeRule: string; aCodeDash: string; aTree: TElTree; var aHash: THashedStringList);
  public
    //frxreport
    class function  GetfrxReportPage(aFrxReport: TfrxReport): string;
  public
    class procedure FillDATA(aIndx: Integer; aData: TObject; aGrid: TAdvStringGrid; iCheckEd: Boolean = False);
    class procedure TreeDATA(aCodeRule: string; aList: TCollection; aTree: TElTree; iCheckEd: Boolean = False; aRoot: TElTreeItem = nil; aRootName: string = ''); overload;
  end;

const
  CONST_COLOR_LOCKED = clInfoBk;
  CONST_COLOR_EDITED = $00D0FFD0;

const
  CONST_COL_OBJECT_ID = 0;
  CONST_COL_CHECK_BOX = 1;

implementation

uses
  Class_KzUtils,PerlRegEx;


class procedure TUiUtils.BatchGrid(aGrid: TAdvStringGrid; aDefaultRowHeadCount: Integer);
begin
  with aGrid do
  begin
    BeginUpdate;

    aDefaultRowHeadCount := aDefaultRowHeadCount + 1;
    RemoveRows(aDefaultRowHeadCount - 1, RowCount - aDefaultRowHeadCount);
    ClearRows(aDefaultRowHeadCount - 1, 1);

    EndUpdate;
  end;
end;

class procedure TUiUtils.CellCheck(aGrid: TAdvStringGrid; AValue: Boolean;
  aCol, aRowStart, aRowEndEd: Integer);
var
  I:Integer;
  StatA:Boolean;  
begin
  with aGrid do
  begin
    if aRowEndEd=-1 then aRowEndEd:=RowCount-1;
    
    for I:=aRowStart to aRowEndEd do
    begin
      SetCheckBoxState(aCol,I,AValue);
    end;
  end;
end;

class procedure TUiUtils.CellClick(Sender: TObject; ARow, aCol: Integer; aCheckBoxCol: Integer);
var
  cChkd:Boolean;
begin
  inherited;
  if not (TObject(Sender) is TAdvStringGrid)  then Exit;
  
  with TAdvStringGrid(Sender) do
  begin
    if ARow > 0 then
    begin
      cChkd := False;

      GetCheckBoxState(aCheckBoxCol,ARow,cChkd);
      cChkd := not cChkd;
      SetCheckBoxState(aCheckBoxCol,ARow,cChkd);

      if cChkd then
      begin
        RowColor[ARow] := SelectionColor;
        RowFontColor[ARow] := clWhite;
      end else
      begin
        RowColor[ARow] := clWhite;
        RowFontColor[ARow] := clBlack;
      end;
    end;
  end;
end;

class procedure TUiUtils.CellIndex(aGrid: TAdvStringGrid; aCol, aRowStart,
  aRowEndEd: Integer);
var
  I,M:Integer;
begin
  if aRowEndEd = -1 then aRowEndEd := aGrid.RowCount - 1;

  with aGrid do
  begin
    BeginUpdate;

    M:=1;
    for I:=aRowStart to aRowEndEd do
    begin
      Ints[aCol,I]:=M;

      Inc(M);
    end;

    EndUpdate;
  end;  
end;

class procedure TUiUtils.CleanGrid(aGrid: TAdvStringGrid; aDefaultRowCount: Integer);
var
  I: Integer;
begin
  with aGrid do
  begin
    BeginUpdate;

    for I := RowCount -1 downto aDefaultRowCount do
    begin
      if I = aDefaultRowCount then
      begin
        ClearRows(I,1);
        Objects[0,I] := nil;
      end else
      begin
        RemoveRows(I,1);
      end;
    end;

    {@aDefaultRowCount := aDefaultRowCount + 1;
    RemoveRows(aDefaultRowCount - 1, RowCount - aDefaultRowCount);
    ClearRows(aDefaultRowCount - 1, 1);}

    EndUpdate;
  end;
end;

class procedure TUiUtils.ClearGrid(aGrid: TAdvStringGrid; aRowCount, aDefaultRowCount: Integer);
begin
  with aGrid do
  begin
    BeginUpdate;

    SelectRows(1,1);

    Filter.Clear;
    FilterActive:=False;

    ClearRows(1, RowCount - 1);
    RemoveRows(2, RowCount - 2);

    if aRowCount > 1 then
    begin
      RowCount := aRowCount + 1;
    end else
    begin
      RowCount := aDefaultRowCount;
    end;

    EndUpdate;
  end;
end;

class procedure TUiUtils.DblClickCell(aGrid: TAdvStringGrid; aRow: Integer);
var
  I:Integer;
begin
  with aGrid do
  begin
    if ARow =0 then Exit;

    BeginUpdate;
    TUiUtils.CellCheck(aGrid,False);
    for I:=1 to RowCount-1 do
    begin
      RowColor[I] := clWhite;
      RowFontColor[I] := clBlack;
    end;
    TUiUtils.CellCheck(aGrid,True,1,ARow,ARow);
    RowColor[ARow] := SelectionColor;
    RowFontColor[ARow] := clWhite;
    EndUpdate;
  end;
end;

class procedure TUiUtils.FillDATA(aIndx: Integer; aData: TObject;
  aGrid: TAdvStringGrid; iCheckEd: Boolean);
begin

end;

class function TUiUtils.GetCellTextAlign(aGrid: TAdvStringGrid; aCol,
  ARow: Integer): Integer;
begin

end;

class function TUiUtils.GetCellTextState(aGrid: TAdvStringGrid; aCol,
  ARow: Integer): Integer;
begin

end;

class function TUiUtils.GetCheckBoxState(aGrid: TAdvStringGrid; aCol,
  ARow: Integer): Integer;
var
  StatA:Boolean;
begin
  Result := 0;

  with aGrid do
  begin
    if GetCheckBoxState(aCol,ARow,StatA) then
    begin
      if StatA then Result := 1;
    end;
  end;  
end;

class procedure TUiUtils.GetCodePath(aCodeRule, aCodeDash: string;aTree:TElTree;
  var aHash: THashedStringList);
var
  I:Integer;
  cIndx: Integer;
  pIndx: Integer;
  sIndx: string;
  Value: Integer;
  cItem: TElTreeItem;
  cHash: THashedStringList;

  function CodeLength(aLevel:Integer):Integer;
  begin
    Result := 2;
    if Trim(aCodeRule) = '' then Exit;
    
    if Length(aCodeRule)<aLevel then
    begin
      Result := StrToIntDef(aCodeRule[Length(aCodeRule)-1],2);
    end else
    begin
      Result := StrToIntDef(aCodeRule[aLevel],2);
    end;
  end;
begin
  try
    cHash := THashedStringList.Create;

    with aTree do
    begin
      for I := 0 to Items.Count-1 do
      begin
        cItem := Items.Item[I];
        cItem.Tag := I;

        pIndx := 0;
        if cItem.Parent <> nil then
        begin
          pIndx := cItem.Parent.Tag;
        end;

        sIndx := Format('%D-%D',[pIndx,cItem.Level]);

        cIndx := cHash.IndexOfName(sIndx);
        if cIndx = -1 then
        begin
          cHash.Add(Format('%S=%D',[sIndx,1]));
          //#cItem.Text := TKzUtils.FormatCode(1,2);

          aHash.Add(Format('%D=%S',[I,TKzUtils.FormatCode(1,CodeLength(cItem.Level+1))]));
        end else
        begin
          Value := StrToInt(cHash.Values[sIndx]);
          Inc(Value);
          //#cItem.Text := TKzUtils.FormatCode(Value,2);
          aHash.Add(Format('%D=%S',[I,TKzUtils.FormatCode(Value,CodeLength(cItem.Level+1))]));

          cHash.Values[sIndx]:=IntToStr(Value);
        end;
      end;
    end;
  finally
    FreeAndNil(cHash);
  end;
end;

class function TUiUtils.GetfrxReportPage(Afrxreport: TfrxReport): string;
begin
  if not Afrxreport.EngineOptions.DoublePass then
  begin
    Afrxreport.EngineOptions.DoublePass:=True;
  end;  
  Result:=Format('第%d页（共%d页）',[Afrxreport.PreviewPages.Count,Afrxreport.Engine.TotalPages]);
end;

class function TUiUtils.GetGridAlignment(AAlig: Integer): TAlignment;
begin
  if AAlig=1 then
  begin
    Result:=taLeftJustify;
  end else
  if AAlig=2 then
  begin
    Result:=taCenter;
  end else
  if AAlig=3 then
  begin
    Result:=taRightJustify;
  end;      
end;

class function TUiUtils.GetListCellChked(aGrid: TAdvStringGrid;
  aCol: Integer): TStringList;
begin
  Result:=GetStrsCellChked(aGrid,aCol);
end;



class function TUiUtils.GetMiddLeft(AParentWidth,
  ASelfWidth: Integer): Integer;
begin
  Result:=(AParentWidth - ASelfWidth) div 2;
end;

class function TUiUtils.GetNamePath(aNameDash:string;aItem: TElTreeItem; aTree: TElTree): string;
var
  cPath:string;
  pItem:TElTreeItem;
begin
  Result := '';
  with aTree do
  begin
    if aItem = nil  then Exit;

    cPath := aItem.Text;
    pItem := aItem.Parent;
    while  pItem <> nil do
    begin
      cPath := pItem.Text + aNameDash + cPath;
      pItem := pItem.Parent;
    end;
  end;

  Result := cPath;
end;

class function TUiUtils.GetSizeCellChked(aGrid: TAdvStringGrid;
  aCol: Integer): Integer;
var
  I:Integer;
  StatA:Boolean;
begin
  Result:=0;
  with aGrid do
  begin
    BeginUpdate;
    for I:=1 to RowCount-1 do
    begin
      StatA:=False;
      GetCheckBoxState(aCol,I,StatA);
      if StatA then
      begin
        Inc(Result);
      end;
    end;
    EndUpdate;
  end;
end;

class function TUiUtils.GetPrevCode(aSelfLevl: Integer; aSelfCode,
  aCodeRule: string; aWithDash: Boolean): string;
var
  NumbA:Integer;  
begin
  Result:='';
  NumbA :=StrToInt(aCodeRule[aSelfLevl]);

  if aWithDash then
  begin
    Result:=Copy(aSelfCode,1,Length(aSelfCode)-NumbA-1);
  end else
  begin
    Result:=Copy(aSelfCode,1,Length(aSelfCode)-NumbA);
  end;
end;

class function TUiUtils.GetRuleLevl(aCodeRule, aSelfCode: string;
  aWithDash: Boolean): Integer;
var
  I:Integer;
begin
  Result:=-1;
  for I:=1 to Length(aCodeRule) do
  begin
    if Length(aSelfCode)=GetRuleNumb(aCodeRule,I,aWithDash) then
    begin
      Result:=I;
      Break;
    end;  
  end;
end;

class function TUiUtils.GetRuleNumb(aCodeRule: string; aLevl: Integer; aWithDash: Boolean): Integer;
var
  I:Integer;
begin
  if aLevl=-1 then
  begin
    aLevl := Length(aCodeRule);
  end;
  
  Result := 0;
  if aWithDash then
  begin
    for I:=1 to aLevl do
    begin
      Result := Result + StrToInt(aCodeRule[I]) + 1;
    end;

    Result := Result - 1;
  end else
  begin
    for I:=1 to aLevl do
    begin
      Result := Result + StrToInt(aCodeRule[I]);
    end;
  end;
end;

class function TUiUtils.GetStrsCellChked(aGrid: TAdvStringGrid;
  aCol: Integer): TStringList;
var
  I:Integer;
  StatA:Boolean;
begin
  Result:=TStringList.Create;
  with aGrid do
  begin
    BeginUpdate;
    for I:=1 to RowCount-1 do
    begin
      StatA:=False;
      GetCheckBoxState(aCol,I,StatA);
      if StatA then
      begin
        Result.Add(IntToStr(I));
      end;
    end;
    EndUpdate;
  end;
end;



class function TUiUtils.GridCheck(aGrid: TAdvStringGrid; aCol, aRowStart,
  aRowEndEd: Integer): TStringList;
var
  I:Integer;
  StatA:Boolean;  
begin
  Result:=TStringList.Create;
  with aGrid do
  begin
    if aRowEndEd=-1 then aRowEndEd:=RowCount-1;
    
    for I:=aRowStart to aRowEndEd do
    begin
      StatA:=False;
      GetCheckBoxState(aCol,I,StatA);
      if StatA then
      begin
        Result.Add(Format('%D',[I]));
      end;
    end;
  end;
end;

class procedure TUiUtils.HeadIndex(aGrid: TAdvStringGrid; ARow: Integer);
var
  I,X,Y:Integer;
  R,S  :string;
begin
  inherited;
  with aGrid do
  begin
    for I:=1 to ColCount-1 do
    begin
      X:=I div 26;
      Y:=I mod 26;

      if I<=26 then
      begin
        Cells[I,ARow]:=Format('%S',[Chr(I+64)]);
      end else
      begin
        R:=Chr(X+64);
        if Y=0 then
        begin
          R:=Chr(X-1+64);
          S:=Chr(26+64);
        end else
        begin
          S:=Chr(Y+64);
        end;
        Cells[I,ARow]:=Format('%S%S',[R,S]);
      end;
      Alignments[I,ARow]:=taCenter;          
    end;
  end;  
end; 


class procedure TUiUtils.SelectArea(aGrid: TAdvStringGrid;aCol:Integer;aValue:Boolean);
var
  I:Integer;
  Start:Integer;
  Right:Integer;
begin
  with aGrid do
  begin
    Start := Selection.Top;
    Right := Selection.Bottom;


    BeginUpdate;
    for I := Start to Right do
    begin
      SetCheckBoxState(aCol,I,aValue);
    end;
    EndUpdate;
  end;
end;

class procedure TUiUtils.SetCellTextAlign(aGrid: TAdvStringGrid; aCol,
  ARow, AAlig: Integer);
begin

end;

class procedure TUiUtils.SetCellTextState(aGrid: TAdvStringGrid; aCol,
  ARow, AStat: Integer);
begin

end;

class procedure TUiUtils.SetCheckBoxState(aGrid: TAdvStringGrid; aCol,
  ARow, AStat: Integer);
begin
  with aGrid do
  begin
    SetCheckBoxState(aCol,ARow,AStat=1);
  end;  
end;

class procedure TUiUtils.SetGridCellChked(aGrid: TAdvStringGrid;
  aCol: Integer; AValue: Boolean);
var
  I:Integer;
begin
  with aGrid do
  begin
    BeginUpdate;
    for I:=1 to RowCount-1 do
    begin
      SetCheckBoxState(aCol,I,AValue);
    end;
    EndUpdate;
  end;
end;

class procedure TUiUtils.SetGridColParams(aGrid: TAdvStringGrid;
  aColParams: TStringList; aFontColor: TColor);
var
  I,A,B,C,D:Integer;
  RegEx:TPerlRegEx;
  pList:TStringList;
begin
  if aColParams.Count=0 then raise Exception.Create('参数个数为零.');

  RegEx := TPerlRegEx.Create;
  pList := TStringList.Create;
  try
    for I:=0 to aColParams.Count-1 do
    begin
      with AGrid do
      begin
        pList.Clear;
        RegEx.Subject := aColParams.Strings[I];
        RegEx.RegEx := ',';
        RegEx.Split(pList, MaxInt);

        A := StrToInt(Trim(pList.Strings[0]));
        B := StrToInt(Trim(pList.Strings[1]));
        C := StrToInt(Trim(pList.Strings[2]));
        D := StrToInt(Trim(pList.Strings[3]));

        MergeCells(A, B, C, D);
        Cells[A, B] := TKzUtils.jsdecode(Trim(pList.Strings[4]));
        FontStyles[A, B] := [fsBold];
        FontColors[A, B] := aFontColor;
        Alignments[A, B] := taCenter;
      end;
    end;
  finally
    FreeAndNil(RegEx);
    FreeAndNil(pList);
  end;
end;

class function TUiUtils.GetSizeItemChked(aTree: TElTree;
  aCheckChild: Boolean): Integer;
var
  I:Integer;
  ItemA:TElTreeItem;
begin
  Result:=0;
  with aTree do
  begin
    for I:=0 to aTree.Items.Count-1 do
    begin
      ItemA:=aTree.Items.Item[I];
      if (ItemA.ShowCheckBox) and (ItemA.Checked) then
      begin
        if aCheckChild then
        begin
          if not ItemA.HasChildren then
          begin
            Inc(Result);
          end;
        end else
        begin
          Inc(Result);
        end;
      end;
    end;
  end;
end;

class function TUiUtils.GetMaxLevelInTreeView(aTree: TElTree): Integer;
var
  I:Integer;
begin
  Result:=0;
  for I:=0 to aTree.Items.Count-1 do
  begin
    Result:=Max(Result,aTree.Items.Item[I].Level);
  end;
  Inc(Result);
end;

class procedure TUiUtils.SetItemNextChecked(aTree: TElTree;
  aItem: TElTreeItem; AStat: Boolean);
var
  ItemA:TElTreeItem;
  I:Integer;
begin
  if aItem.HasChildren then
  begin
    for I:=0 to aItem.Count-1 do
    begin
      ItemA:=aItem.Item[I];
      ItemA.Checked:=AStat;
      SetItemNextChecked(aTree,ItemA,AStat);
    end;
  end;  
end;

class procedure TUiUtils.SetItemPrevChecked(aTree: TElTree;
  aItem: TElTreeItem; AStat: Boolean);
var
  ItemA:TElTreeItem;
begin
  ItemA:=aItem.Parent;
  while ItemA <>nil do
  begin
    ItemA.Checked:=AStat;
    ItemA:=ItemA.Parent;
  end;
end;

class procedure TUiUtils.SetTreeItemChked(Value,
  IncludeLast: Boolean; aTree: TElTree);
var
  I:Integer;
begin
  with aTree do
  begin
    Items.BeginUpdate;
    for I:=0 to Items.Count-1 do
    begin
      if not IncludeLast then
      begin
        if Items.Item[I].HasChildren then Continue;
      end;
      Items.Item[I].Checked := Value;
    end;
    Items.EndUpdate;
  end;  
end;

class procedure TUiUtils.ToScrennCenter(aForm: TForm);
var
  nTop: Integer;
  nLeft: Integer;
begin
  nTop := (Screen.Height - aForm.Height) div 2;
  nLeft := (Screen.Width - aForm.Width) div 2;

  aForm.Top := nTop;
  aForm.Left := nLeft;
end;

class procedure TUiUtils.TreeDATA(aCodeRule: string; aList: TCollection;
  aTree: TElTree; iCheckEd: Boolean; aRoot: TElTreeItem; aRootName: string);
begin

end;

class procedure TUiUtils.TreeIndex(aTree: TElTree);
var
  I:Integer;
begin
  with aTree do
  begin
    Items.BeginUpdate;
    for I:=0 to Items.Count-1 do
    begin
      Items.Item[I].Text:=IntToStr(I+1);
    end;
    Items.EndUpdate;
  end;
end;


class procedure TUiUtils.TreeInit(aTree: TElTree);
begin
  with aTree do
  begin
    Items.Clear;
    ShowColumns := True;
    LockHeaderHeight := True;
    AutoLineHeight   := False;
    LineHeight       := 22;
    HeaderHeight     := 22;
    HeaderSections.Item[0].Width := aTree.Width - 40;
  end;
end;

class procedure TUiUtils.WhenEditExit(Sender: TObject);
begin
  TRzButtonEdit(Sender).Text := TKzUtils.FloatToText(TKzUtils.TextToFloat(TRzButtonEdit(Sender).Text));
end;

class procedure TUiUtils.WordWarps(aGrid: TAdvStringGrid; aStartCol,
  aStartRow: Integer);
var
  I,M:Integer;
begin
  with aGrid do
  begin
    for I := aStartCol to ColCount-1 do
    begin
      for M := aStartRow to RowCount-1 do
      begin
        WordWraps[I,M] := True;
      end;
    end;
  end;
end;

class function TUiUtils.StringToColorDef(AValue, ADef: string): TColor;
begin
  Result:=clWhite;
  if Trim(AValue)='' then
  begin
    Result:=StringToColor(ADef);
  end else
  begin
    Result:=StringToColor(Trim(AValue));
  end;
end;


end.
