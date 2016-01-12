unit Class_Dict;

interface
uses
  Classes,SysUtils,UniEngine;

type
  TDict=class(TUniEngine)
  private
    FDictIndx:Integer;
    FDictCode:string;
    FDictName:string;
    FDictMemo:string;
    FCodeLink:string;
    FParentID:string;
    FDictLevl:Integer;
    FDictOrdr:Integer;
  public
    class function  CopyIt(ADict:TDict):TDict;overload;
    class procedure CopyIt(ADict:TDict;var Result:TDict);overload;        
  published
    property DictIndx:Integer read FDictIndx write FDictIndx;
    property DictCode:string read FDictCode write FDictCode;
    property DictName:string read FDictName write FDictName;
    property DictMemo:string read FDictMemo write FDictMemo;
    property CodeLink:string read FCodeLink write FCodeLink;
    property ParentID:string read FParentID write FParentID;
    property DictLevl:Integer read FDictLevl write FDictLevl;
    property DictOrdr:Integer read FDictOrdr write FDictOrdr;
  end;

implementation

{ TDict }

class function TDict.CopyIt(ADict: TDict): TDict;
begin
  Result:=TDict.Create;
  TDict.CopyIt(ADict,Result);
end;

class procedure TDict.CopyIt(ADict: TDict; var Result: TDict);
begin
  Result.FDictIndx:=ADict.FDictIndx;
  Result.FDictCode:=ADict.FDictCode;
  Result.FDictName:=ADict.FDictName;
  Result.FDictMemo:=ADict.FDictMemo;
  Result.FCodeLink:=ADict.FCodeLink;
  Result.FParentID:=ADict.FParentID;
  Result.FDictLevl:=ADict.FDictLevl;
  Result.FDictOrdr:=ADict.FDictOrdr;
end;

end.
