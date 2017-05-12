unit XlsImport.Class_Land_View;

interface
uses
  Classes,SysUtils,ElXPThemedControl, ElTreeInplaceEditors,ElTree;

type
  TLandView=class(TObject)
  public
    iReadied: Boolean;
    ColTotal: Integer;
    ListCell: TStringList;
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
  Class_KzUtils,XlsImport.Class_Land_Cell,Class_KzDebug;

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
  iReadied := False;
  TKzUtils.JustCleanList(ListCell);
end;


class function TLandView.ReadView(aMaxLevel:Integer;aTree: TElTree;var aLandView: TLandView): Boolean;
var
  I, M: Integer;
  cIndx: Integer;
  cItem: TElTreeItem;
  dItem: TElTreeItem;
  cCell: TLandCell;
  dCell: TLandCell;

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
begin
  if aLandView=nil then Exit;

  cIndx:=0;

  with aTree do
  begin
    for I:=0 to Items.Count-1 do
    begin
      cItem:=Items.Item[I];
      if cItem = nil then Continue;

      cCell := TLandCell.Create;
      cCell.Col := cIndx;
      cCell.Row := cItem.Level;
      cCell.SpanX := GetSpanX(cItem);
      cCell.SpanY := 1;
      if not cItem.HasChildren then
      begin
        cCell.SpanY := aMaxLevel - cItem.Level;
        cCell.IsLasted := True;

        Inc(cIndx);
      end;
      cCell.Text := cItem.Text;

      aLandView.ListCell.AddObject('',cCell);
    end;

    aLandView.ColTotal := cIndx;
  end;

  aLandView.iReadied := True;
end;

end.
