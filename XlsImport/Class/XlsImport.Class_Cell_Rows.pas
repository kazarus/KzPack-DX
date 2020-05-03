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
  public
    function  getListData: TCollection;
  public
    function  getColValue(aColIndex: Integer): string;
  published
    property RowIndex: Integer read FRowIndex write FRowIndex;
    property ListData: TCollection read getListData write FListData;
  public
    class function  CopyIt(aCellRows: TCellRows): TCellRows; overload;
    class procedure CopyIt(aCellRows: TCellRows; var Result: TCellRows); overload;

    class function  CopyIt(aUniEngine: TUniEngine): TUniEngine; overload; override;
    class procedure CopyIt(aUniEngine: TUniEngine; var Result: TUniEngine)overload; override;
  public
    destructor Destroy; override;
  end;

  TCellData = class(TUniEngine)
  private
    FColIndex: Integer;
    FRowIndex: Integer;
    FCellData: string;
    FHeadName: string;
  private
    FkFormula: string;
    FbkColour: Integer;
  published
    property ColIndex: Integer read FColIndex write FColIndex;
    property RowIndex: Integer read FRowIndex write FRowIndex;
    property CellData: string read FCellData write FCellData;
    property HeadName: string read FHeadName write FHeadName;
  published
    property kFormula: string read FkFormula write FkFormula;
    property bkColour: Integer read FbkColour write FbkColour;
  public
    class function  CopyIt(aCellData: TCellData): TCellData; overload;
    class procedure CopyIt(aCellData: TCellData; var Result: TCellData); overload;

    class function  CopyIt(aUniEngine: TUniEngine): TUniEngine; overload; override;
    class procedure CopyIt(aUniEngine: TUniEngine; var Result: TUniEngine)overload; override;
  end;

implementation

uses
  Class_KzUtils;


class procedure TCellRows.CopyIt(aCellRows: TCellRows; var Result: TCellRows);
begin
  if Result = nil then Exit;

  Result.RowIndex := aCellRows.RowIndex;

  if (aCellRows.ListData <> nil) and (aCellRows.ListData.Count > 0) then
  begin
    Result.ListData;
    TCellData.CopyIt(aCellRows.ListData, Result.FListData);
  end;
end;

class function TCellRows.CopyIt(aCellRows: TCellRows): TCellRows;
begin
  Result := TCellRows.Create;
  TCellRows.CopyIt(aCellRows, Result)
end;

class procedure TCellRows.CopyIt(aUniEngine: TUniEngine; var Result: TUniEngine);
begin
  if Result = nil then Exit;
  TCellRows.CopyIt(TCellRows(aUniEngine), TCellRows(Result));
end;

class function TCellRows.CopyIt(aUniEngine: TUniEngine): TUniEngine;
begin
  Result := TCellRows.Create;
  TUniEngine.CopyIt(aUniEngine,Result);
end;

destructor TCellRows.Destroy;
begin
  if FListData <> nil then TKzUtils.TryFreeAndNil(FListData);

  inherited;
end;

function TCellRows.getColValue(aColIndex: Integer): string;
var
  I: Integer;
  CellData: TCellData;
begin
  Result := '';

  if self.FListData = nil then Exit;
  if self.FListData.Count = 0 then Exit;

  for I := 0 to self.FListData.Count-1 do
  begin
    CellData := TCellData(self.FListData.Items[I]);
    if CellData = nil then Continue;

    if CellData.ColIndex = aColIndex then
    begin
      if CellData.CellData <> '#DIV/0!' then
      begin
        Result := CellData.CellData;
      end;
      Break;
    end;
  end;
end;

function TCellRows.getListData: TCollection;
begin
  if FListData = nil then
  begin
    FListData := TCollection.Create(TCellData);
  end;

  Result := FListData;
end;

class procedure TCellData.CopyIt(aCellData: TCellData; var Result: TCellData);
begin
  if Result = nil then Exit;

  Result.ColIndex := aCellData.ColIndex;
  Result.RowIndex := aCellData.RowIndex;
  Result.CellData := aCellData.CellData;
  Result.HeadName := aCellData.HeadName;

  Result.kFormula := aCellData.kFormula;
  Result.bkColour := aCellData.bkColour;
end;

class function TCellData.CopyIt(aCellData: TCellData): TCellData;
begin
  Result := TCellData.Create;
  TCellData.CopyIt(aCellData, Result)
end;

class procedure TCellData.CopyIt(aUniEngine: TUniEngine; var Result: TUniEngine);
begin
  if Result = nil then Exit;
  TCellData.CopyIt(TCellData(aUniEngine), TCellData(Result));
end;

class function TCellData.CopyIt(aUniEngine: TUniEngine): TUniEngine;
begin
  Result := TCellData.Create;
  TUniEngine.CopyIt(aUniEngine,Result);
end;

end.
