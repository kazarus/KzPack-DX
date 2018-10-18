unit Helpr_UniTableX;


interface
uses
  System.SysUtils,System.Classes,Uni,UniTableX,UniConfig,UniFieldX;

type
  TObjectEx = class helper for TUniTableX
  protected
    function  KeyExist(var aKeyField:string): Boolean;
  public
    function  ToScript(aProviderName:string=CONST_PROVIDER_SQLSRV):string;
    procedure ReadFrom(aUniConnection:TUniConnection);
  end;

implementation
uses
  Class_KzUtils, Class_KzDebug, Helpr_UniFieldX;

function TObjectEx.KeyExist(var aKeyField: string): Boolean;
var
  I:Integer;
  cField:TUniFieldX;
begin
  Result := False;

  if (FListCols = nil) or (FListCols.Count = 0) then Exit;

  aKeyField := '';
  for I:=0 to FListCols.Count -1 do
  begin
    cField := TUniFieldX(FListCols.Objects[I]);
    if cField = nil then Continue;
    if cField.IsKey then
    begin
      Result := True;
      aKeyField :=  aKeyField + ',' + cField.COLVNAME;
    end;
  end;

  if Result then
  begin
    Delete(aKeyField,1,1);
  end;
end;

procedure TObjectEx.ReadFrom(aUniConnection: TUniConnection);
var
  cSQL:string;
begin
  if self.FListCols = nil then
  begin
    self.FListCols := TStringList.Create;
  end;
  TKzUtils.JustCleanList(self.FListCols);

  if aUniConnection.ProviderName = CONST_PROVIDER_SQLSRV then
  begin
    cSQL := TUniFieldX.ExpSQLInSQLSRV(Self.TABLNAME);
  end else
  if aUniConnection.ProviderName = CONST_PROVIDER_ORACLE then
  begin
    cSQL := TUniFieldX.ExpSQLInORACLE(Self.TABLNAME);
  end;

  KzDebug.FileFmt('%S:%S',[self.ClassName,cSQL]);
  TUniFieldX.ListDB(cSQL,aUniConnection,self.FListCols);
end;

function TObjectEx.ToScript(aProviderName:string):string;
var
  I:Integer;
  sText:string;
  cList:TStringList;
  cField:TUniFieldX;
  kText:string;
begin
  try
    cList := TStringList.Create;

    if aProviderName = CONST_PROVIDER_SQLSRV then
    begin
      cList.Add(Format('IF OBJECT_ID(%S) IS NULL',[QuotedStr(self.TABLNAME)]));
    end;

    cList.Add('BEGIN');

    cList.Add(Format('CREATE TABLE [%S] (',[self.TABLNAME]));
    if (self.FListCols <> nil) and (self.FListCols.Count>0) then
    begin
      for I := 0 to self.FListCols.Count-1 do
      begin
        cField := TUniFieldX(self.FListCols.Objects[I]);
        if cField = nil then Continue;

        sText := 'NULL';
        if cField.IsKey  then
        begin
          sText := 'NOT NULL';
        end;
        if (cField.IsInc) and (aProviderName = CONST_PROVIDER_SQLSRV) then
        begin
          sText := 'NOT NULL IDENTITY(1,1)';
        end;

        if I = self.FListCols.Count-1 then
        begin
          cList.Add(Format('%S %S %S' ,[cField.COLVNAME,cField.ToScript,sText]));
        end else
        begin
          cList.Add(Format('%S %S %S,',[cField.COLVNAME,cField.ToScript,sText]));
        end;
      end;
    end;
    cList.Add(');');

    //#是否存在主
    if KeyExist(kText) then
    begin
      cList.Add(Format('ALTER TABLE %S ADD CONSTRAINT PK_%S PRIMARY KEY (%S);',[self.TABLNAME,self.TABLNAME,kText]));
    end;

    cList.Add(Format('PRINT %s',[QuotedStr(Format('添加新表:%S',[self.TABLNAME]))]));
    cList.Add('END;');

    Result := cList.Text;
  finally
    FreeAndNil(cList);
  end;
end;

end.
