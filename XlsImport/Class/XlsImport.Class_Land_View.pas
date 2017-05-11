unit XlsImport.Class_Land_View;

interface
uses
  Classes,SysUtils,ElXPThemedControl, ElTreeInplaceEditors,ElTree;

type
  TLandView=class(TObject)
  public
    ColTotal:Integer;
    ListCell:TStringList;
    IsReadied :Boolean;
  public
    procedure Initialize;
  public
    constructor Create;
    destructor Destroy; override;
  public
    class function ReadView(aMaxLevel:Integer;aTree:TElTree;var aLandView:TLandView):Boolean;
  end;

implementation

uses
  Class_KzUtils,XlsImport.Class_Land_Cell;

constructor TLandView.Create;
begin
  ListCell := TStringList.Create;
end;

destructor TLandView.Destroy;
begin
  TKzUtils.TryFreeAndNil(ListCell);
  inherited;
end;

procedure TLandView.Initialize;
begin
  ColTotal := 0;
  IsReadied :=False;
  TKzUtils.JustCleanList(ListCell);
end;


class function TLandView.ReadView(aMaxLevel:Integer;aTree: TElTree;var aLandView: TLandView): Boolean;
var
  I,M:Integer;
  cIndx:Integer;
  cItem:TElTreeItem;
  dItem:TElTreeItem;
  cCell:TLandCell;
  dCell:TLandCell;

  function GetSpanX(aItem:TEltreeItem):Integer;
  var
    X:Integer;
  begin
    Result:=1;
    if not aItem.HasChildren then Exit;

    Result:=0;
    for X:=0 to aItem.Count-1 do
    begin
      if aItem.Item[X].HasChildren then
      begin
        Result:=Result+GetSpanX(aItem.Item[X]);
      end else
      begin
        Inc(Result);
      end;
    end;
  end;

  procedure AddCells(aItem:TelTreeItem;aIndx:Integer);
  var
    X:Integer;
    xIndx:Integer;
  begin
    xIndx:=aIndx;

    for X:=0 to aItem.Count-1 do
    begin
      dItem:=aItem.Item[X];

      if not dItem.HasChildren then
      begin
        dCell:=TLandCell.Create;
        dCell.ColIndex:=xIndx;
        dCell.RowIndex:=dItem.Level;
        dCell.CellText:=dItem.Text;
        dCell.SpanX   :=1;
        dCell.SpanY   :=1;
        dCell.SpanY   :=aMaxLevel - dItem.Level;

        dCell.ObjtData:=dItem.Data;
        dCell.IsLasted:=not dItem.HasChildren;

        aLandView.ListCell.AddObject('',dCell);

        Inc(xIndx);
      end else
      begin
        dCell:=TLandCell.Create;
        dCell.ColIndex:=xIndx;
        dCell.RowIndex:=dItem.Level;
        dCell.CellText:=dItem.Text;
        dCell.SpanX   :=1;
        dCell.SpanY   :=1;
        dCell.SpanX   :=GetSpanX(dItem);

        dCell.ObjtData:=dItem.Data;
        dCell.IsLasted:=not dItem.HasChildren;

        aLandView.ListCell.AddObject('',dCell);

        AddCells(dItem,xIndx);
      end;
    end;
  end;

begin
  if aLandView=nil then Exit;

  cIndx:=0;

  with aTree do
  begin
    for I:=0 to Items.RootCount-1 do
    begin
      cItem:=Items.RootItem[I];
      if not cItem.HasChildren then
      begin
        cCell:=TLandCell.Create;
        cCell.ColIndex:=cIndx;
        cCell.RowIndex:=0;
        cCell.CellText:=cItem.Text;
        cCell.SpanX   :=1;
        cCell.SpanY   :=aMaxLevel - cItem.Level;

        cCell.ObjtData:=cItem.Data;
        cCell.IsLasted:=not cItem.HasChildren;

        aLandView.ListCell.AddObject('',cCell);

        Inc(cIndx);
      end else
      begin
        cCell:=TLandCell.Create;
        cCell.ColIndex:=cIndx;
        cCell.RowIndex:=0;
        cCell.CellText:=cItem.Text;
        cCell.SpanX   :=1;
        cCell.SpanY   :=1;
        cCell.SpanX   :=GetSpanX(cItem);

        cCell.ObjtData:=cItem.Data;
        cCell.IsLasted:=not cItem.HasChildren;

        aLandView.ListCell.AddObject('',cCell);

        AddCells(cItem,cIndx);

        cIndx:=cIndx+cCell.SpanX;
      end;
    end;

    aLandView.ColTotal := cIndx;
  end;

  aLandView.IsReadied := True;
end;

end.
