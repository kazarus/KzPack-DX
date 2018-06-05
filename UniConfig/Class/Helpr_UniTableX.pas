unit Helpr_UniTableX;


interface
uses
  System.SysUtils,System.Classes,Uni,UniTableX,UniConfig,UniFieldX;

type
  TObjectEx = class helper for TUniTableX
  public
    function  ToScript(aProviderName:string=CONST_PROVIDER_SQLSRV):string;
    procedure ReadFrom(aUniConnection:TUniConnection);
  end;

implementation
uses
  Class_KzUtils,Helpr_UniFieldX;

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

  TUniFieldX.ListDB(cSQL,aUniConnection,self.FListCols);
end;

function TObjectEx.ToScript(aProviderName:string):string;
var
  I:Integer;
  sText:string;
  cList:TStringList;
  cField:TUniFieldX;
begin
  try
    cList := TStringList.Create;

    if aProviderName = CONST_PROVIDER_SQLSRV then
    begin
      cList.Add(Format('IF OBJECT_ID(%S) IS NULL',[QuotedStr(self.TABLNAME)]));
    end;

    cList.Add(Format('CREATE TABLE %S (',[self.TABLNAME]));
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
        if I = self.FListCols.Count-1 then
        begin
          cList.Add(Format('%S %S %S' ,[cField.COLVNAME,cField.ToScript,sText]));
        end else
        begin
          cList.Add(Format('%S %S %S,',[cField.COLVNAME,cField.ToScript,sText]));
        end;
      end;
    end;
    cList.Add(')');

    Result := cList.Text;
  finally
    FreeAndNil(cList);
  end;
end;

end.
