unit StylManager;


interface
uses
  Classes,SysUtils,UniEngine,AdvGrid,RzSplit,Forms;

type
  TStylManager=class(TUniEngine)
  private
    FStylName:string;
    FFormSizh:Integer;
    FFormSizw:Integer;
    FSplitVal:Integer;
    FListCols:TCollection;
  published
    property StylName:string  read FStylName write FStylName;
    property SplitVal:Integer read FSplitVal write FSplitVal;
    property FormSizh:Integer read FFormSizh write FFormSizh;
    property FormSizw:Integer read FFormSizw write FFormSizw;
    property ListCols:TCollection read FListCols write FListCols;
  public
    class procedure InitColWidth(aFileName:string;aGrid:TAdvStringGrid);
    class procedure SaveColWidth(aFileName:string;aGrid:TAdvStringGrid);

    class procedure InitSplitVal(aFileName:string;aSplit:TRzSplitter);
    class procedure SaveSplitVal(aFileName:string;aSplit:TRzSplitter);

    class procedure InitFormSize(aFileName:string;aForm:TForm);
    class procedure SaveFormSize(aFileName:string;aForm:TForm);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TColWidth=class(TUniEngine)
  private
    FColIndex:Integer;
    FColWidth:Integer;
  published
    property ColIndex:Integer read FColIndex write FColIndex;
    property ColWidth:Integer read FColWidth write FColWidth;
  end;

implementation

uses
  Class_KzUtils,Helpr_UniEngine;

constructor TStylManager.Create;
begin
  FListCols:=nil;
end;

destructor TStylManager.Destroy;
begin
  if FListCols<>nil then TKzUtils.TryFreeAndNil(FListCols);
  inherited;
end;

class procedure TStylManager.InitFormSize(aFileName: string; aForm: TForm);
var
  I:Integer;
  RootPath:string;
  FilePath:string;
  StylManager:TStylManager;
begin
  RootPath:=TKzUtils.ExePath+'样式';
  if not DirectoryExists(RootPath) then
  begin
    CreateDir(RootPath);
  end;

  FilePath:=Format('%s/style_%s_%s.json',[RootPath,aFileName,'size']);
  if not FileExists(FilePath) then Exit;

  try
    StylManager:=TStylManager.Create;
    StylManager.InFILE(FilePath);
    aForm.Height := StylManager.FFormSizh;
    aForm.Width  := StylManager.FFormSizw;
  finally
    FreeAndNil(StylManager);
  end;
end;

class procedure TStylManager.InitSplitVal(aFileName: string;
  aSplit: TRzSplitter);
var
  I:Integer;
  RootPath:string;
  FilePath:string;
  ColWidth:TColWidth;
  StylManager:TStylManager;
begin
  RootPath:=TKzUtils.ExePath+'样式';
  if not DirectoryExists(RootPath) then
  begin
    CreateDir(RootPath);
  end;

  FilePath:=Format('%s/style_%s_%s.json',[RootPath,aFileName,aSplit.Name]);
  if not FileExists(FilePath) then Exit;

  try
    StylManager:=TStylManager.Create;
    StylManager.InFILE(FilePath);
    aSplit.Percent:=StylManager.SplitVal;
  finally
    FreeAndNil(StylManager);
  end;
end;

class procedure TStylManager.InitColWidth(aFileName: string;aGrid:TAdvStringGrid);
var
  I:Integer;
  RootPath:string;
  FilePath:string;
  ColWidth:TColWidth;
  StylManager:TStylManager;
begin
  RootPath:=TKzUtils.ExePath+'样式';
  if not DirectoryExists(RootPath) then
  begin
    CreateDir(RootPath);
  end;


  FilePath:=Format('%s/style_%s_%s.json',[RootPath,aFileName,aGrid.Name]);
  if not FileExists(FilePath) then Exit;

  try
    StylManager:=TStylManager.Create;
    StylManager.ListCols:=TCollection.Create(TColWidth);

    StylManager.InFILE(FilePath);
    with aGrid do
    begin
      for I:=0 to ColCount-1 do
      begin
        if StylManager.ListCols.Count-1< I then Break;
        ColWidth:=TColWidth(StylManager.ListCols.Items[I]);
        ColWidths[I]:=ColWidth.ColWidth;
      end;
    end;
  finally
    FreeAndNil(StylManager);
  end;
end;


class procedure TStylManager.SaveFormSize(aFileName: string; aForm: TForm);
var
  I:Integer;
  RootPath:string;
  FilePath:string;
  StylManager:TStylManager;
begin
  RootPath:=TKzUtils.ExePath+'样式';
  if not DirectoryExists(RootPath) then
  begin
    CreateDir(RootPath);
  end;

  FilePath:=Format('%s/style_%s_%s.json',[RootPath,aFileName,'size']);
  FilePath:=LowerCase(FilePath);

  try
    StylManager:=TStylManager.Create;
    StylManager.FFormSizh:=aForm.Height;
    StylManager.FFormSizw:=aForm.Width;

    StylManager.ToFILE(FilePath);
  finally
    FreeAndNil(StylManager);
  end;
end;

class procedure TStylManager.SaveSplitVal(aFileName: string;
  aSplit: TRzSplitter);
var
  I:Integer;
  RootPath:string;
  FilePath:string;
  ColWidth:TColWidth;
  StylManager:TStylManager;
begin
  RootPath:=TKzUtils.ExePath+'样式';
  if not DirectoryExists(RootPath) then
  begin
    CreateDir(RootPath);
  end;

  FilePath:=Format('%s/style_%s_%s.json',[RootPath,aFileName,aSplit.Name]);
  FilePath:=LowerCase(FilePath);

  try
    StylManager:=TStylManager.Create;
    StylManager.SplitVal:=aSplit.Percent;
    StylManager.ToFILE(FilePath);
  finally
    FreeAndNil(StylManager);
  end;
end;

class procedure TStylManager.SaveColWidth(aFileName: string;
  aGrid: TAdvStringGrid);
var
  I:Integer;
  RootPath:string;
  FilePath:string;
  ColWidth:TColWidth;
  StylManager:TStylManager;
begin
  RootPath:=TKzUtils.ExePath+'样式';
  if not DirectoryExists(RootPath) then
  begin
    CreateDir(RootPath);
  end;

  FilePath:=Format('%s/style_%s_%s.json',[RootPath,aFileName,aGrid.Name]);
  FilePath:=LowerCase(FilePath);

  try
    StylManager:=TStylManager.Create;
    StylManager.ListCols:=TCollection.Create(TColWidth);

    with aGrid do
    begin
      for I:=0 to ColCount-1 do
      begin
        ColWidth:=TColWidth(StylManager.ListCols.Add);
        ColWidth.ColIndex:=I;
        ColWidth.ColWidth:=ColWidths[I];
      end;
    end;

    StylManager.ToFILE(FilePath);
  finally
    FreeAndNil(StylManager);
  end;
end;

end.
