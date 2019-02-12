unit SizeManager;

interface
uses
  System.Classes,System.SysUtils,System.IniFiles;

type
  TSizeObject = class(TObject)
  private
    FObjectID:string;
    FActCount:Integer;
    FListAttr:TStringList;        //*list of string;
  published
    property ObjectID:string   read FObjectID write FObjectID;
    property ActCount:Integer  read FActCount write FActCount;
    property ListAttr:TStringList read FListAttr write FListAttr;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TSizeManager = class(TObject)
  private
    FHashData : THashedStringList;//*list of *tsizeobject;
  public
    procedure PushSize(Key: string; Value: string = '');
    procedure Initialize;
  public
    procedure PullSize(var aList: TStringList; nowCount: Integer = 1; origin: Boolean = False);
    procedure PullKeys(var aList: TStringList; nowCount: Integer = 1);
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  Class_KzUtils;

constructor TSizeManager.Create;
begin
  FHashData := THashedStringList.Create;
end;

destructor TSizeManager.Destroy;
begin
  if FHashData <> nil then TKzUtils.TryFreeAndNil(FHashData);

  inherited;
end;

procedure TSizeManager.Initialize;
begin
  if FHashData = nil then
  begin
    FHashData := THashedStringList.Create;
  end;
  TKzUtils.JustCleanList(FHashData);
end;

procedure TSizeManager.PullKeys(var aList: TStringList;nowCount:Integer);
var
  I:Integer;
  cSize:TSizeObject;
begin
  if aList = nil then Exit;
  if (FHashData = nil) or (FHashData.Count=0) then Exit;

  for I := 0  to FHashData.Count-1 do
  begin
    cSize := TSizeObject(FHashData.Objects[I]);
    if cSize = nil then Continue;

    if cSize.ActCount >  nowCount then
    begin
      aList.Add(cSize.ObjectID);
    end;
  end;
end;

procedure TSizeManager.PullSize(var aList: TStringList; nowCount: Integer; origin: Boolean);
var
  I:Integer;
  cSize:TSizeObject;
begin
  if aList = nil then Exit;
  if (FHashData = nil) or (FHashData.Count=0) then Exit;

  for I := 0  to FHashData.Count-1 do
  begin
    cSize := TSizeObject(FHashData.Objects[I]);
    if cSize = nil then Continue;

    if cSize.ActCount >  nowCount then
    begin
      if origin then
      begin
        aList.Add(Format('%S',[cSize.ListAttr.CommaText]));
      end else
      begin
        aList.Add(Format('键值:%S,参考信息:%S',[cSize.ObjectID,cSize.ListAttr.CommaText]));
      end;
    end;
  end;
end;

procedure TSizeManager.PushSize(Key: string; Value: string);
var
  cIndx:Integer;
  cSize:TSizeObject;
begin
  if FHashData = nil then
  begin
    FHashData := THashedStringList.Create;
  end;

  cIndx := FHashData.IndexOf(Key);
  if cIndx <> -1 then
  begin
    cSize := TSizeObject(FHashData.Objects[cIndx]);
    if cSize <> nil then
    begin
      cSize.ActCount := cSize.ActCount + 1;
      cSize.ListAttr.Add(Value);
    end;
  end else
  begin
    cSize := TSizeObject.Create;
    cSize.ObjectID := Key;
    cSize.ActCount := 1;
    cSize.ListAttr.Add(Value);

    FHashData.AddObject(cSize.ObjectID,cSize);
  end;
end;

constructor TSizeObject.Create;
begin
  FListAttr := TStringList.Create;
end;

destructor TSizeObject.Destroy;
begin
  if FListAttr <> nil then FreeAndNil(FListAttr);
  inherited;
end;

end.
