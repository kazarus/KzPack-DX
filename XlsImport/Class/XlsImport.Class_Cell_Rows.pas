unit XlsImport.Class_Cell_Rows;
//#XlsImport


interface
uses
  Classes, SysUtils, UniEngine;

type
  TCellRows = class(TUniEngine)
  private
    FRowIndex: Integer;
    FListData: TCollection; //*list of *tcelldata
  published
    property RowIndex: Integer read FRowIndex write FRowIndex;
    property ListData: TCollection read FListData write FListData;
  public
    destructor Destroy; override;
  end;

  TCellData = class(TUniEngine)
  private
    FColIndex: Integer;
    FRowIndex: Integer;
    FCellData: string;
    FHeadName: string;
  published
    property ColIndex: Integer read FColIndex write FColIndex;
    property RowIndex: Integer read FRowIndex write FRowIndex;
    property CellData: string read FCellData write FCellData;
    property HeadName: string read FHeadName write FHeadName;
  end;

implementation

uses
  Class_KzUtils;


destructor TCellRows.Destroy;
begin
  if FListData <> nil then TKzUtils.TryFreeAndNil(FListData);

  inherited;
end;

end.
