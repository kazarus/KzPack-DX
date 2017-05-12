unit XlsImport.Class_Land_Cell;

interface
uses
  Classes,SysUtils;

type
  TLandCell=class(TObject)
  public
    Col: Integer;
    Row: Integer;
    SpanX: Integer;
    SpanY: Integer;
    Text: string;
    Data: Pointer;
    IsLasted: Boolean;
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
