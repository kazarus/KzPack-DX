unit XlsImport.Class_Cell_Head;
//#XlsImport

interface
type
  TCellHeadDataType = (chdtString,chdtInteger,chdtFloat,dhdtDate,chdtTime);

  TCellHead=class(TObject)
  private
    FHeadName: string;
    FHeadCode: string;
    FDataType: TCellHeadDataType;
    FNonEmpty: Boolean;           //不允许为空;
    FIsLastEd: Boolean;           //是否最明细;
  public
    class function  PushHead(AName, ACode: string; AType: TCellHeadDataType = chdtString; aNonEmpty: Boolean = False; aIsLastEd: Boolean = False): TCellHead;
    class function  CopyIt(aCellHead: TCellHead): TCellHead; overload;
    class procedure CopyIt(aCellHead: TCellHead; var Result: TCellHead); overload;
  published
    property HeadName:string  read FHeadName write FHeadName;
    property HeadCode:string  read FHeadCode write FHeadCode;
    property DataType:TCellHeadDataType read FDataType write FDataType;
    property NonEmpty:Boolean read FNonEmpty write FNonEmpty;
    property IsLasted:Boolean read FIsLastEd write FIsLastEd;
  end;

implementation


class function TCellHead.CopyIt(aCellHead: TCellHead): TCellHead;
begin
  Result:=TCellHead.Create;
  TCellHead.CopyIt(aCellHead,Result);
end;

class procedure TCellHead.CopyIt(aCellHead: TCellHead; var Result: TCellHead);
begin
  Result.HeadName := aCellHead.HeadName;
  Result.HeadCode := aCellHead.HeadCode;
  Result.DataType := aCellHead.DataType;
  Result.NonEmpty := aCellHead.NonEmpty;
  Result.IsLasted := aCellHead.IsLasted;
end;

class function TCellHead.PushHead(AName, ACode: string; AType: TCellHeadDataType; aNonEmpty: Boolean; aIsLastEd: Boolean): TCellHead;
begin
  Result:=TCellHead.Create;
  Result.HeadName := AName;
  Result.HeadCode := ACode;
  Result.DataType := AType;
  Result.NonEmpty := aNonEmpty;
  Result.IsLasted := aIsLastEd;
end;

end.
