unit XlsImport.Class_Land_View;


interface
uses
  Classes, SysUtils, ElXPThemedControl, ElTreeInplaceEditors, ElTree, UniEngine,
  XlsImport.Class_Land_Cell;

type
  TLandView = class(TUniEngine)
  private
    FiReadiEd: Boolean;
    FCntTotal: Integer;
    FListCell: TCollection;  //*list of *xlsimport.tlandcell;
  published
    property iReadiEd: Boolean read FiReadiEd write FiReadiEd;
    property CntTotal: Integer read FCntTotal write FCntTotal;
    property ListCell: TCollection read FListCell write FListCell;
  public
    procedure Initialize;
  public
    constructor Create;
    destructor Destroy; override;
  public
    class function ReadViewH(aMaxLevel: Integer; aTree: TElTree; var aLandView: TLandView): Boolean;
    class function ReadViewV(aMaxLevel: Integer; aTree: TElTree; var aLandView: TLandView): Boolean;
  end;

implementation

uses
  Class_KzUtils, Class_KzDebug;

constructor TLandView.Create;
begin
  FListCell := TCollection.Create(XlsImport.Class_Land_Cell.TLandCell);
end;

destructor TLandView.Destroy;
begin
  if FListCell <> nil then TKzUtils.TryFreeAndNil(FListCell);
  inherited;
end;

procedure TLandView.Initialize;
begin
  FCntTotal := 0;
  FiReadiEd := False;
  TKzUtils.JustCleanList(FListCell);
end;


class function TLandView.ReadViewH(aMaxLevel: Integer; aTree: TElTree; var aLandView: TLandView): Boolean;
var
  I, M: Integer;
  cIndx: Integer;
  cITEM: TElTreeItem;
  dItem: TElTreeItem;
  cCELL: TLandCell;
  xCELL: TLandCell;

  function GetSpanX(aItem:TEltreeItem):Integer;
  var
    X:Integer;
  begin
    Result := 1;

    if not aItem.HasChildren then Exit;

    Result := 0;
    for X := 0 to aItem.Count - 1 do
    begin
      if aItem.Item[X].HasChildren then
      begin
        Result := Result + GetSpanX(aItem.Item[X]);
      end else
      begin
        Inc(Result);
      end;
    end;
  end;
begin
  if aLandView = nil then Exit;

  cIndx := 0;

  with aTree do
  begin
    for I := 0 to Items.Count - 1 do
    begin
      cITEM := Items.Item[I];
      if cITEM = nil then Continue;

      cCELL := TLandCELL(aLandView.ListCell.Add);
      cCELL.Col := cIndx;
      cCELL.Row := cITEM.Level;
      cCELL.SpanX := GetSpanX(cITEM);
      cCELL.SpanY := 1;
      if not cITEM.HasChildren then
      begin
        cCELL.SpanY := aMaxLevel - cITEM.Level;
        cCELL.IsLastEd := True;

        Inc(cIndx);
      end;
      cCELL.Data := cITEM.Data;
      cCELL.Text := cITEM.Text;
    end;

    aLandView.CntTotal := cIndx;
  end;

  aLandView.iReadied := True;
end;

class function TLandView.ReadViewV(aMaxLevel: Integer; aTree: TElTree; var aLandView: TLandView): Boolean;
var
  I, M: Integer;
  cIndx: Integer;
  cITEM: TElTreeItem;
  dItem: TElTreeItem;
  cCELL: TLandCELL;
  xCELL: TLandCELL;

  function GetSpanY(aITEM:TEltreeItem):Integer;
  var
    X:Integer;
  begin
    Result := 1;

    if not aITEM.HasChildren then Exit;

    Result := 0;
    for X := 0 to aITEM.Count - 1 do
    begin
      if aITEM.Item[X].HasChildren then
      begin
        Result := Result + GetSpanY(aITEM.Item[X]);
      end else
      begin
        Inc(Result);
      end;
    end;
  end;
begin
  if aLandView = nil then Exit;

  cIndx := 0;

  with aTree do
  begin
    for I := 0 to Items.Count - 1 do
    begin
      cITEM := Items.Item[I];
      if cITEM = nil then Continue;

      cCELL := TLandCELL(aLandView.ListCell.Add);
      cCELL.Col := cITEM.Level;
      cCELL.Row := cIndx;
      cCELL.SpanY := GetSpanY(cITEM);
      cCELL.SpanX := 1;

      if not cITEM.HasChildren then
      begin
        cCELL.SpanX := aMaxLevel - cITEM.Level;
        cCELL.IsLastEd := True;

        Inc(cIndx);
      end;
      cCELL.Data := cITEM.Data;
      cCELL.Text := cITEM.Text;
    end;

    aLandView.CntTotal := cIndx;
  end;

  aLandView.iReadied := True;
end;

end.

{
var
  I:Integer;
  Path:string;
  cITEM:TElTreeItem;
  pItem:TElTreeItem;
  cIndx:Integer;
  sIndx:string;
  pIndx:Integer;
  Value:Integer;
  cHash:THashedStringList;//*
begin
  //#
  {with Tree_View do
  begin
    if Selected = nil  then Exit;

    Path := Selected.Text;
    pItem := Selected.Parent;
    while  pItem <> nil do
    begin
      Path := pItem.Text + '\' + Path;
      pItem := pItem.Parent;
    end;
    ShowMessageFmt('%S',[Path]);
  end;}

  {#cHash := THashedStringList.Create;

  with Tree_View do
  begin
    for I := 0 to Items.Count-1 do
    begin
      cITEM := Items.Item[I];
      cITEM.Tag := I;


      pIndx := 0;
      if cITEM.Parent <> nil then
      begin
        pIndx := cITEM.Parent.Tag;
      end;

      sIndx := Format('%D-%D',[pIndx,cITEM.Level]);

      cIndx := cHash.IndexOfName(sIndx);
      if cIndx = -1 then
      begin
        cHash.Add(Format('%S=%D',[sIndx,1]));
        cITEM.Text := TKzUtils.FormatCode(1,2);
      end else
      begin
        Value := StrToInt(cHash.Values[sIndx]);
        Inc(Value);
        cITEM.Text := TKzUtils.FormatCode(Value,2);
        cHash.Values[sIndx]:=IntToStr(Value);
      end;
    end;
  end;

  FreeAndNil(cHash);}
end;}
