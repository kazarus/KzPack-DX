unit Class_UiUtils;
//YXC_2012_11_21_10_19_57

interface
uses
  Classes,SysUtils,AdvGrid,frxClass,ElTree,Math,Graphics,RzBtnEdt,IniFiles;

type
  TUiUtils=class(TObject)
  public
    class function  GetMiddLeft(AParentWidth,ASelfWidth:Integer):Integer;
    
    class function  GetPrevCode(ASelfLevl:Integer;ASelfCode,ACodeRule:string;AWithDash:Boolean=False):string;
    class function  GetRuleNumb(ACodeRule:string;ALevl:Integer=-1;AWithDash:Boolean=True):Integer;
    class function  GetRuleLevl(ACodeRule:string;ASelfCode:string;AWithDash:Boolean=True):Integer;
  public
    class function  StringToColorDef(AValue:string;ADef:string='clWhite'): TColor;
  public
    //rz
    class procedure WhenEditExit(Sender:TObject);
  public
    //grid
    class function  GetCheckBoxState(aGrid:TAdvStringGrid;ACol,ARow:Integer):Integer;
    class procedure SetCheckBoxState(aGrid:TAdvStringGrid;ACol,ARow,AStat:Integer);

    class function  GetCellTextState(aGrid:TAdvStringGrid;ACol,ARow:Integer):Integer;
    class procedure SetCellTextState(aGrid:TAdvStringGrid;ACol,ARow,AStat:Integer);

    class procedure SetGridColParams(aGrid:TAdvStringGrid;aColParams:TStringList;aFontColor:TColor=clBlack);

    class function  GetCellTextAlign(aGrid:TAdvStringGrid;ACol,ARow:Integer):Integer;
    class procedure SetCellTextAlign(aGrid:TAdvStringGrid;ACol,ARow,AAlig:Integer);
    class function  GetGridAlignment(AAlig:Integer):TAlignment;

    class function  GetStrsCellChked(aGrid:TAdvStringGrid;ACol:Integer):TStringList;deprecated;
    class function  GetListCellChked(aGrid:TAdvStringGrid;ACol:Integer = 1):TStringList;
    class function  GetSizeCellChked(aGrid:TAdvStringGrid;ACol:Integer):Integer;
    class procedure SetGridCellChked(aGrid:TAdvStringGrid;ACol:Integer;AValue:Boolean);

    class procedure ClearGrid(aGrid:TAdvStringGrid;ARowCount:Integer;ADefaultRowCount:Integer=2);
    class procedure CleanGrid(aGrid:TAdvStringGrid;aDefaultRowCount:Integer=1);
    class procedure CellIndex(aGrid:TAdvStringGrid;ACol:Integer=0;aRowStart:Integer=1;aRowEndEd:Integer=-1);

    class procedure HeadIndex(aGrid:TAdvStringGrid;ARow:Integer=0);

    class function  GridCheck(aGrid:TAdvStringGrid;ACol:Integer=1;aRowStart:Integer=1;aRowEndEd:Integer=-1):TStringList;
    class procedure CellCheck(aGrid:TAdvStringGrid;AValue:Boolean;ACol:Integer=1;aRowStart:Integer=1;aRowEndEd:Integer=-1);

    class procedure SelectArea(aGrid:TAdvStringGrid;aCol:Integer=1;aValue:Boolean=True);
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
    class procedure SetItemNextChecked(aTree:TElTree;aItem:TElTreeItem;AStat:Boolean);
    class procedure SetItemPrevChecked(aTree:TElTree;aItem:TElTreeItem;AStat:Boolean);
    //eltree.common
    class function  GetSizeItemChked(aTree:TElTree;ACheckChild:Boolean=False):Integer;
    class procedure SetTreeItemChked(Value,IncludeLast:Boolean;aTree:TElTree);
    class function  GetMaxLevelInTreeView(aTree:TElTree):Integer;
    class procedure TreeIndex(aTree:TElTree);
    class procedure TreeInit(aTree:TElTree);
    class function  GetNamePath(aNameDash:string;aItem:TElTreeItem;aTree:TElTree):string;
    class procedure GetCodePath(aCodeRule:string;aCodeDash:string;aTree:TElTree;var aHash:THashedStringList);
  public
    //frxreport
    class function  GetfrxReportPage(Afrxreport:TfrxReport):string;
  end;

const
  CONST_COLOR_LOCKED = clInfoBk;
  CONST_COLOR_EDITED = $00D0FFD0;

implementation

uses
  Class_KzUtils,PerlRegEx;


class procedure TUiUtils.CellCheck(aGrid: TAdvStringGrid; AValue: Boolean;
  ACol, aRowStart, aRowEndEd: Integer);
var
  I:Integer;
  StatA:Boolean;  
begin
  with aGrid do
  begin
    if aRowEndEd=-1 then aRowEndEd:=RowCount-1;
    
    for I:=aRowStart to aRowEndEd do
    begin
      SetCheckBoxState(ACol,I,AValue);
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

class procedure TUiUtils.CleanGrid(aGrid: TAdvStringGrid;
  aDefaultRowCount: Integer);
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
      end else
      begin
        RemoveRows(I,1);
      end;
    end;
    EndUpdate;
  end;
end;

class procedure TUiUtils.ClearGrid(aGrid: TAdvStringGrid; ARowCount,
  ADefaultRowCount: Integer);
begin
  with aGrid do
  begin
    BeginUpdate;

    SelectRows(1,1);
    Filter.Clear;
    FilterActive:=False;
    ClearRows(1, RowCount - 1);
    RemoveRows(2, RowCount - 2);
    if ARowCount > 1 then
      RowCount:=ARowCount+1
    else
      RowCount:=ADefaultRowCount;

    EndUpdate;
  end;
end;

class function TUiUtils.GetCellTextAlign(aGrid: TAdvStringGrid; ACol,
  ARow: Integer): Integer;
begin

end;

class function TUiUtils.GetCellTextState(aGrid: TAdvStringGrid; ACol,
  ARow: Integer): Integer;
begin

end;

class function TUiUtils.GetCheckBoxState(aGrid: TAdvStringGrid; ACol,
  ARow: Integer): Integer;
var
  StatA:Boolean;
begin
  Result := 0;

  with aGrid do
  begin
    if GetCheckBoxState(ACol,ARow,StatA) then
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
  ACol: Integer): TStringList;
begin
  Result:=GetStrsCellChked(aGrid,ACol);
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
  ACol: Integer): Integer;
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
      GetCheckBoxState(ACol,I,StatA);
      if StatA then
      begin
        Inc(Result);
      end;
    end;
    EndUpdate;
  end;
end;

class function TUiUtils.GetPrevCode(ASelfLevl: Integer; ASelfCode,
  ACodeRule: string; AWithDash: Boolean): string;
var
  NumbA:Integer;  
begin
  Result:='';
  NumbA :=StrToInt(ACodeRule[ASelfLevl]);

  if AWithDash then
  begin
    Result:=Copy(ASelfCode,1,Length(ASelfCode)-NumbA-1);  
  end else
  begin
    Result:=Copy(ASelfCode,1,Length(ASelfCode)-NumbA);
  end;
end;

class function TUiUtils.GetRuleLevl(ACodeRule, ASelfCode: string;
  AWithDash: Boolean): Integer;
var
  I:Integer;
begin
  Result:=-1;
  for I:=1 to Length(ACodeRule) do
  begin
    if Length(ASelfCode)=GetRuleNumb(ACodeRule,I,AWithDash) then
    begin
      Result:=I;
      Break;
    end;  
  end;  
end;

class function TUiUtils.GetRuleNumb(ACodeRule: string; ALevl: Integer;
  AWithDash: Boolean): Integer;
var
  I:Integer;
begin
  if ALevl=-1 then
  begin
    ALevl:=Length(ACodeRule);
  end;
  
  Result:=0;
  if AWithDash then
  begin
    for I:=1 to ALevl do
    begin
      Result:=Result+ StrToInt(ACodeRule[I])+1;
    end;

    Result:=Result-1;
  end else
  begin
    for I:=1 to ALevl do
    begin
      Result:=Result+StrToInt(ACodeRule[I]);
    end;
  end;
end;

class function TUiUtils.GetStrsCellChked(aGrid: TAdvStringGrid;
  ACol: Integer): TStringList;
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
      GetCheckBoxState(ACol,I,StatA);
      if StatA then
      begin
        Result.Add(IntToStr(I));
      end;
    end;
    EndUpdate;
  end;
end;



class function TUiUtils.GridCheck(aGrid: TAdvStringGrid; ACol, aRowStart,
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
      GetCheckBoxState(ACol,I,StatA);
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

class procedure TUiUtils.SetCellTextAlign(aGrid: TAdvStringGrid; ACol,
  ARow, AAlig: Integer);
begin

end;

class procedure TUiUtils.SetCellTextState(aGrid: TAdvStringGrid; ACol,
  ARow, AStat: Integer);
begin

end;

class procedure TUiUtils.SetCheckBoxState(aGrid: TAdvStringGrid; ACol,
  ARow, AStat: Integer);
begin
  with aGrid do
  begin
    SetCheckBoxState(ACol,ARow,AStat=1);
  end;  
end;

class procedure TUiUtils.SetGridCellChked(aGrid: TAdvStringGrid;
  ACol: Integer; AValue: Boolean);
var
  I:Integer;
begin
  with aGrid do
  begin
    BeginUpdate;
    for I:=1 to RowCount-1 do
    begin
      SetCheckBoxState(ACol,I,AValue);
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
    for I:=0 to AColParams.Count-1 do
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
  ACheckChild: Boolean): Integer;
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
        if ACheckChild then
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
