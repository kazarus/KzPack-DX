unit Class_UiUtils;
//YXC_2012_11_21_10_19_57

interface
uses
  Classes,SysUtils,AdvGrid,frxClass,ElTree,Math,Graphics,RzBtnEdt;

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
    class function  GetCheckBoxState(AGrid:TAdvStringGrid;ACol,ARow:Integer):Integer;
    class procedure SetCheckBoxState(AGrid:TAdvStringGrid;ACol,ARow,AStat:Integer);

    class function  GetCellTextState(AGrid:TAdvStringGrid;ACol,ARow:Integer):Integer;
    class procedure SetCellTextState(AGrid:TAdvStringGrid;ACol,ARow,AStat:Integer);

    class function  GetCellTextAlign(AGrid:TAdvStringGrid;ACol,ARow:Integer):Integer;
    class procedure SetCellTextAlign(AGrid:TAdvStringGrid;ACol,ARow,AAlig:Integer);
    class function  GetGridAlignment(AAlig:Integer):TAlignment;

    class function  GetStrsCellChked(AAdvGrid:TAdvStringGrid;ACol:Integer):TStringList;deprecated;
    class function  GetListCellChked(AAdvGrid:TAdvStringGrid;ACol:Integer):TStringList;
    class function  GetSizeCellChked(AAdvGrid:TAdvStringGrid;ACol:Integer):Integer;
    class procedure SetGridCellChked(AAdvGrid:TAdvStringGrid;ACol:Integer;AValue:Boolean);

    class procedure ClearGrid(AGrid:TAdvStringGrid;ARowCount:Integer;ADefaultRowCount:Integer=2);
    class procedure CellIndex(AGrid:TAdvStringGrid;ACol:Integer;ARowStart:Integer=1;ARowEnd:Integer=-1);

    class procedure HeadIndex(AGrid:TAdvStringGrid;ARow:Integer=0);

    class function  GridCheck(AGrid:TAdvStringGrid;ACol:Integer=1;ARowStart:Integer=1;ARowEnd:Integer=-1):TStringList;
    class procedure CellCheck(AGrid:TAdvStringGrid;AValue:Boolean;ACol:Integer=1;ARowStart:Integer=1;ARowEnd:Integer=-1);
  public
    {begin
      if Item.Checked then
      begin
        TAppUtil.SetItemNextChecked(TElTree(Sender),Item,True);
      end else
      begin
        TAppUtil.SetItemNextChecked(TElTree(Sender),Item,False);
        TAppUtil.SetItemPrevChecked(TElTree(Sender),Item,False);
      end;
    end;}
    class procedure SetItemNextChecked(ATree:TElTree;AItem:TElTreeItem;AStat:Boolean);
    class procedure SetItemPrevChecked(ATree:TElTree;AItem:TElTreeItem;AStat:Boolean);
    //eltree.common
    class function  GetSizeItemChked(ATree:TElTree;ACheckChild:Boolean=False):Integer;
    class procedure SetTreeItemCheckedState(AValue,ALastLevl:Boolean;ATree:TElTree);
    class function  GetMaxLevelInTreeView(ATree:TElTree):Integer;
    class procedure TreeIndex(ATree:TElTree);
    class procedure TreeInit(aTree:TElTree);
  public
    //frxreport
    class function  GetfrxReportPage(Afrxreport:TfrxReport):string;
  end;

const
  CONST_CELL_STAT_TEXT  ='文本';
  CONST_CELL_STAT_NUMB  ='数值';

  CONST_MARK_DATA       ='DATA';
  CONST_MARK_ZBGL       ='ZBGL';
  CONST_TABL_DICT       ='TBL_YOTO_DICT';

  CONST_DICT_MODE_SJKBBH='00001';//数据库版本号
  CONST_DICT_MODE_APPBBH='00002';//程序版本号  

  CONST_DICT_MODE_DWBMGZ='00003';//单位编码规则
  CONST_DICT_MODE_BMBMGZ='00004';//部门编码规则
  CONST_DICT_MODE_LXBMGZ='00005';//类型编码规则
  CONST_DICT_MODE_RYBMCD='00006';//人员编码长度

  CONST_DICT_MODE_BDCZDW='00007';//本地操作单位
  CONST_DICT_MODE_KJNDKD='00008';//会计年度跨度
  CONST_DICT_MODE_YZDGZD='00009';//月最大工资单号
  CONST_DICT_MODE_NZDGZD='00010';//年最大工资单号
  CONST_DICT_MODE_LXGXCX='00011';//类型关系查询  

implementation

uses
  Class_KzUtils;


{ TUiUtils }

class procedure TUiUtils.CellCheck(AGrid: TAdvStringGrid; AValue: Boolean;
  ACol, ARowStart, ARowEnd: Integer);
var
  I:Integer;
  StatA:Boolean;  
begin
  with AGrid do
  begin
    if ARowEnd=-1 then ARowEnd:=RowCount-1;
    
    for I:=ARowStart to ARowEnd do
    begin
      SetCheckBoxState(ACol,I,AValue);
    end;
  end;
end;

class procedure TUiUtils.CellIndex(AGrid: TAdvStringGrid; ACol, ARowStart,
  ARowEnd: Integer);
var
  I,M:Integer;
begin
  if ARowEnd=-1 then ARowEnd:=AGrid.RowCount-1;

  with AGrid do
  begin
    BeginUpdate;

    M:=1;
    for I:=ARowStart to ARowEnd do
    begin
      Ints[ACol,I]:=M;

      Inc(M);
    end;

    EndUpdate;
  end;  
end;

class procedure TUiUtils.ClearGrid(AGrid: TAdvStringGrid; ARowCount,
  ADefaultRowCount: Integer);
begin
  with AGrid do
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

class function TUiUtils.GetCellTextAlign(AGrid: TAdvStringGrid; ACol,
  ARow: Integer): Integer;
begin

end;

class function TUiUtils.GetCellTextState(AGrid: TAdvStringGrid; ACol,
  ARow: Integer): Integer;
begin

end;

class function TUiUtils.GetCheckBoxState(AGrid: TAdvStringGrid; ACol,
  ARow: Integer): Integer;
var
  StatA:Boolean;
begin
  Result:=0;

  with AGrid do
  begin
    if GetCheckBoxState(ACol,ARow,StatA) then
    begin
      if StatA then Result:=1;
    end;
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

class function TUiUtils.GetListCellChked(AAdvGrid: TAdvStringGrid;
  ACol: Integer): TStringList;
begin
  Result:=GetStrsCellChked(AAdvGrid,ACol);
end;



class function TUiUtils.GetMiddLeft(AParentWidth,
  ASelfWidth: Integer): Integer;
begin
  Result:=(AParentWidth - ASelfWidth) div 2;
end;

class function TUiUtils.GetSizeCellChked(AAdvGrid: TAdvStringGrid;
  ACol: Integer): Integer;
var
  I:Integer;
  StatA:Boolean;
begin
  Result:=0;
  with AAdvGrid do
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

class function TUiUtils.GetStrsCellChked(AAdvGrid: TAdvStringGrid;
  ACol: Integer): TStringList;
var
  I:Integer;
  StatA:Boolean;
begin
  Result:=TStringList.Create;
  with AAdvGrid do
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



class function TUiUtils.GridCheck(AGrid: TAdvStringGrid; ACol, ARowStart,
  ARowEnd: Integer): TStringList;
var
  I:Integer;
  StatA:Boolean;  
begin
  Result:=TStringList.Create;
  with AGrid do
  begin
    if ARowEnd=-1 then ARowEnd:=RowCount-1;
    
    for I:=ARowStart to ARowEnd do
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

class procedure TUiUtils.HeadIndex(AGrid: TAdvStringGrid; ARow: Integer);
var
  I,X,Y:Integer;
  R,S  :string;
begin
  inherited;
  with AGrid do
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


class procedure TUiUtils.SetCellTextAlign(AGrid: TAdvStringGrid; ACol,
  ARow, AAlig: Integer);
begin

end;

class procedure TUiUtils.SetCellTextState(AGrid: TAdvStringGrid; ACol,
  ARow, AStat: Integer);
begin

end;

class procedure TUiUtils.SetCheckBoxState(AGrid: TAdvStringGrid; ACol,
  ARow, AStat: Integer);
begin
  with AGrid do
  begin
    SetCheckBoxState(ACol,ARow,AStat=1);
  end;  
end;

class procedure TUiUtils.SetGridCellChked(AAdvGrid: TAdvStringGrid;
  ACol: Integer; AValue: Boolean);
var
  I:Integer;
begin
  with AAdvGrid do
  begin
    BeginUpdate;
    for I:=1 to RowCount-1 do
    begin
      SetCheckBoxState(ACol,I,AValue);
    end;
    EndUpdate;
  end;
end;

class function TUiUtils.GetSizeItemChked(ATree: TElTree;
  ACheckChild: Boolean): Integer;
var
  I:Integer;
  ItemA:TElTreeItem;
begin
  Result:=0;
  with ATree do
  begin
    for I:=0 to ATree.Items.Count-1 do
    begin
      ItemA:=ATree.Items.Item[I];
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

class function TUiUtils.GetMaxLevelInTreeView(ATree: TElTree): Integer;
var
  I:Integer;
begin
  Result:=0;
  for I:=0 to ATree.Items.Count-1 do
  begin
    Result:=Max(Result,ATree.Items.Item[I].Level);
  end;
  Inc(Result);
end;

class procedure TUiUtils.SetItemNextChecked(ATree: TElTree;
  AItem: TElTreeItem; AStat: Boolean);
var
  ItemA:TElTreeItem;
  I:Integer;
begin
  if AItem.HasChildren then
  begin
    for I:=0 to AItem.Count-1 do
    begin
      ItemA:=AItem.Item[I];
      ItemA.Checked:=AStat;
      SetItemNextChecked(ATree,ItemA,AStat);
    end;
  end;  
end;

class procedure TUiUtils.SetItemPrevChecked(ATree: TElTree;
  AItem: TElTreeItem; AStat: Boolean);
var
  ItemA:TElTreeItem;
begin
  ItemA:=AItem.Parent;
  while ItemA <>nil do
  begin
    ItemA.Checked:=AStat;
    ItemA:=ItemA.Parent;
  end;
end;

class procedure TUiUtils.SetTreeItemCheckedState(AValue,
  ALastLevl: Boolean; ATree: TElTree);
var
  I:Integer;
begin
  with ATree do
  begin
    Items.BeginUpdate;
    for I:=0 to Items.Count-1 do
    begin
      if ALastLevl then
      begin
        if Items.Item[I].HasChildren then Continue;
      end;
      Items.Item[I].Checked:=AValue;
    end;  
    Items.EndUpdate;
  end;  
end;

class procedure TUiUtils.TreeIndex(ATree: TElTree);
var
  I:Integer;
begin
  with ATree do
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
