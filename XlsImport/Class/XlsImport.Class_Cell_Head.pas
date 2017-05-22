unit XlsImport.Class_Cell_Head;
//#XlsImport

interface
type
  TCellHeadDataType = (chdtString,chdtInteger,chdtFloat,dhdtDate,chdtTime);

  TCellHead=class(TObject)
  private
    FHeadName:string;
    FHeadCode:string;
    FDataType:TCellHeadDataType;
    FNonEmpty:Boolean;           //²»ÔÊÐíÎª¿Õ;
  public
    class function  PushHead(AName,ACode:string;AType:TCellHeadDataType=chdtString;aNonEmpty:Boolean=False):TCellHead;
    class function  CopyIt(aCellHead:TCellHead):TCellHead;overload;
    class procedure CopyIt(aCellHead:TCellHead;var Result:TCellHead);overload;
  published
    property HeadName:string  read FHeadName write FHeadName;
    property HeadCode:string  read FHeadCode write FHeadCode;
    property DataType:TCellHeadDataType read FDataType write FDataType;
    property NonEmpty:Boolean read FNonEmpty write FNonEmpty;
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
end;

class function TCellHead.PushHead(AName, ACode: string;
  AType: TCellHeadDataType;aNonEmpty:Boolean): TCellHead;
begin
  Result:=TCellHead.Create;
  Result.HeadName := AName;
  Result.HeadCode := ACode;
  Result.DataType := AType;
  Result.NonEmpty := aNonEmpty;
end;

end.
