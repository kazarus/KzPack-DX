unit XlsImport.Class_Cell_Node;

interface
uses
  SysUtils,Classes;

type
  TCellNode = class(TObject)
  public
    DataINDX:Integer;
    ParentID:Integer;
  public
    Col: Integer;
    Row: Integer;
    Text: string;
  public
    Left: Integer;
    Right: Integer;
    Top: Integer;
    Bottom: Integer;
  public
    Info: string;
    FontSize: Integer;
    Align: Integer;
  public
    class function  CopyIt(aCellNode:TCellNode):TCellNode;overload;
    class procedure CopyIt(aCellNode:TCellNode;var Result:TCellNode);overload;
  end;
implementation


class function TCellNode.CopyIt(aCellNode: TCellNode): TCellNode;
begin
  Result := TCellNode.Create;
  TCellNode.CopyIt(aCellNode,Result);
end;

class procedure TCellNode.CopyIt(aCellNode: TCellNode; var Result: TCellNode);
begin
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

end.
