unit XlsImport.Class_Land_Cell;


interface
uses
  Classes, SysUtils, UniEngine;

type
  TLandCell=class(TUniEngine)
  private
    FCol: Integer;
    FRow: Integer;
    FText: string;
    FSpanX: Integer;
    FSpanY: Integer;
    FIsLasted: Boolean;
  public
    Data: Pointer;
  published
    property Col: Integer read FCol write FCol;
    property Row: Integer read FRow write FRow;
    property Text: string read FText write FText;
    property SpanX: Integer read FSpanX write FSpanX;
    property SpanY: Integer read FSpanY write FSpanY;
    property IsLasted: Boolean read FIsLasted write FIsLasted;
  public
    constructor Create;
  end;

implementation

constructor TLandCell.Create;
begin
  FSpanY := 1;
  FSpanX := 1;
end;

end.
