unit XlsImport.Class_Cell_Node;


interface
uses
  SysUtils, Classes, UniEngine;

type
  TCellNode = class(TUniEngine)
  public
    FDataINDX: Integer;
    FParentID: Integer;
  public
    FCol: Integer;
    FRow: Integer;
    FText: string;
  public
    FLeft: Integer;
    FRight: Integer;
    FTop: Integer;
    FBottom: Integer;
  public
    FInfo: string;
    FFontSize: Integer;
    FAlign: Integer;
  published
    property DataINDX: Integer read FDataINDX write FDataINDX;
    property ParentID: Integer read FParentID write FParentID;
  published
    property Col: Integer read FCol write FCol;
    property Row: Integer read FRow write FRow;
    property Text: string read FText write FText;
  published
    property Left: Integer read FLeft write FLeft;
    property Right: Integer read FRight write FRight;
    property Top: Integer read FTop write FTop;
    property Bottom: Integer read FBottom write FBottom;
  published
    property Info: string read FInfo write FInfo;
    property FontSize: Integer read FFontSize write FFontSize;
    property Align: Integer read FAlign write FAlign;
  public
    class function  CopyIt(aCellNode: TCellNode): TCellNode; overload;
    class procedure CopyIt(aCellNode: TCellNode; var Result: TCellNode); overload;
  public
    class procedure CopyIt(SourceList: TStringList; var TargetList: TCollection); overload;
  end;
implementation


class function TCellNode.CopyIt(aCellNode: TCellNode): TCellNode;
begin
  Result := TCellNode.Create;
  TCellNode.CopyIt(aCellNode,Result);
end;

class procedure TCellNode.CopyIt(aCellNode: TCellNode; var Result: TCellNode);
begin
  Result.DataINDX := aCellNode.DataINDX;
  Result.ParentID := aCellNode.ParentID;

  Result.Col := aCellNode.Col;
  Result.Row := aCellNode.Row;
  Result.Text := aCellNode.Text;

  Result.Left := aCellNode.Left;
  Result.Right := aCellNode.Right;
  Result.Top := aCellNode.Top;
  Result.Bottom := aCellNode.Bottom;

  Result.FontSize := aCellNode.FontSize;
  Result.Info := aCellNode.Info;
  Result.Align := aCellNode.Align;
end;

class procedure TCellNode.CopyIt(SourceList: TStringList; var TargetList: TCollection);
var
  I: Integer;
  cNode: TCellNode;
  xNode: TCellNode;
begin
  if SourceList = nil then Exit;
  if TargetList = nil then Exit;
  

  for I := 0  to SourceList.Count-1 do
  begin
    cNode := TCellNode(SourceList.Objects[I]);
    if cNode = nil then Continue;

    xNode := TCellNode(TargetList.Add);
    TCellNode.CopyIt(cNode,xNode);
  end;
end;

end.
