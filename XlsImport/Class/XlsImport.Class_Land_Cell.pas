unit XlsImport.Class_Land_Cell;

interface
uses
  Classes,SysUtils;

type
  TLandCell=class(TObject)
  public
    ColIndex:Integer;
    RowIndex:Integer;
    SpanX   :Integer;
    SpanY   :Integer;
    CellText:string;
    ObjtData:Pointer;
    IsLasted:Boolean;
  public
    constructor Create;
  end;

implementation

constructor TLandCell.Create;
begin
  SpanX:=1;
  SpanY:=1;
end;

end.
