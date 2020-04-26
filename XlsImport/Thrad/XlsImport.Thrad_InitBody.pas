unit XlsImport.Thrad_InitBody;

interface

uses
  Classes,SysUtils,Class_KzThrad,AdvGrid,IniFiles,XlsImport.Class_Cell_Rows;

type
  TThradInitBody = class(TKzThrad)
  public
    FRealGrid: TAdvStringGrid; //&
    FListBody: TCollection;   //&
    FBodySize: Integer;       //&
    FHashHead: THashedStringList; //&
  public
    procedure Initialize;
  protected
    procedure Execute; override;
  end;

implementation

uses
  Class_KzUtils,Class_UiUtils;

procedure TThradInitBody.Execute;
begin
  Synchronize(Initialize);
end;

procedure TThradInitBody.Initialize;
var
  I,M:Integer;
  cIDX:Integer;
  cCol:Integer;
  Size:Integer;

  CellRows:TCellRows;
  CellData:TCellData;
begin
  try
    with FRealGrid do
    begin
      BeginUpdate;

      //YXC_2017_05_18_15_17_55_<
      for I := RowCount-1 downto 1 do
      begin
        if RowCount = 2 then
        begin
        end else
        begin
          RemoveRows(I,1);
        end;
      end;
      //YXC_2017_05_18_15_17_55_>

      Size := FListBody.Count;
      if FBodySize<>0 then
      begin
        Size := FBodySize;
        if FListBody.Count<Size then
        begin
          Size := FListBody.Count;
        end;
      end;

      GetMaxProgress(Size);

      for I:=0 to Size-1 do
      begin
        GetOneProgress(I+1);

        CellRows:=TCellRows(FListBody.Items[I]);

        AddRow;

        //@Cells[0,RowCount-1]:=Format('%D',[I+1]);
        AddCheckBox(1,RowCount-1,True,False);

        for M:=0 to CellRows.ListData.Count-1 do
        begin
          CellData := TCellData(CellRows.ListData.Items[M]);
          if CellData = nil then Continue;

          cIDX := FHashHead.IndexOfName(CellData.HeadName);
          if cIDX<>-1 then
          begin
            cCol := StrToIntDef(FHashHead.ValueFromIndex[cIDX], -1);
            if cCol<>-1 then
            begin
              Cells[cCol,RowCount-1]:=CellData.CellData;
            end;
          end;
        end;
      end;

      GetEndProgrees;
      GetMsgProgress(Class_KzThrad.CONST_THRAD_STAT_TRUE,[]);

      EndUpdate;
    end;
  finally
  end;
end;

end.
