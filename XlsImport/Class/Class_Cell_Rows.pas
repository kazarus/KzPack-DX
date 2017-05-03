unit Class_Cell_Rows;
//#XlsImport

interface
uses
  Classes,SysUtils;

type
  TCellRows=class(TObject)
  public
    RowIndex:Integer;
    ListData:TStringList;//*list of *tcelldata
  public
    destructor Destroy; override;
  end;

  TCellData=class(TObject)
  public
    ColIndex:Integer;
    RowIndex:Integer;
    CellData:string;
    HeadName:string;
  end;

implementation

uses
  Class_KzUtils;


destructor TCellRows.Destroy;
begin
  if ListData<>nil then TKzUtils.TryFreeAndNil(ListData);
  inherited;
end;

end.
