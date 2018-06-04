unit Helpr_UniFieldX;


interface
uses
  System.SysUtils,System.Classes,Uni,UniTableX,UniConfig,UniFieldX,UniEngine;

type
  TObjectEx = class helper for TUniFieldX
  public
    function  ToScript:string;
    function  AddAlter(aProviderName:string=CONST_PROVIDER_SQLSRV):string;
    function  ExpAlter(aProviderName:string=CONST_PROVIDER_SQLSRV):string;
    procedure ReadFrom(aUniConnection:TUniConnection);
  end;

implementation


function TObjectEx.AddAlter(aProviderName:string): string;
var
  sText:string;
  cList:TStringList;
begin
  try
    cList := TStringList.Create;

    if aProviderName = CONST_PROVIDER_SQLSRV then
    begin
      cList.Add(Format('IF COL_LENGTH(%S,%S) IS NULL',[QuotedStr(self.TABLNAME),QuotedStr(self.COLVNAME)]));
    end;

    sText := 'ALTER TABLE %s ADD %s %s NULL';
    sText := Format(sText,[self.TABLNAME,self.COLVNAME,self.ToScript]);
    cList.Add(sText);

    Result := cList.Text;
  finally
    FreeAndNil(cList);
  end;
end;

function TObjectEx.ExpAlter(aProviderName: string): string;
var
  sText:string;
  cList:TStringList;
begin
  try
    cList := TStringList.Create;

    if aProviderName = CONST_PROVIDER_SQLSRV then
    begin
      cList.Add(Format('IF COL_LENGTH(%S,%S) != %D',[QuotedStr(self.TABLNAME),QuotedStr(self.COLVNAME),self.DATASIZE]));
    end;

    sText := 'ALTER TABLE %s ALTER COLUMN %s %s NULL';
    sText := Format(sText,[self.TABLNAME,self.COLVNAME,self.ToScript]);
    cList.Add(sText);

    Result := cList.Text;
  finally
    FreeAndNil(cList);
  end;
end;

procedure TObjectEx.ReadFrom(aUniConnection: TUniConnection);
var
  cSQL:string;
begin
  if aUniConnection.ProviderName = CONST_PROVIDER_SQLSRV then
  begin
    cSQL := self.ExpSQLInSQLSRV(self.TABLNAME,self.COLVNAME);
  end else
  if aUniConnection.ProviderName = CONST_PROVIDER_ORACLE then
  begin
    cSQL := self.ExpSQLInORACLE(self.TABLNAME,self.COLVNAME);
  end;

  self.ReadDB(cSQL,aUniConnection,TUniEngine(self));
end;

function TObjectEx.ToScript: string;
var
  cText: string;
begin
  Result := TYPENAME;

  cText  := UpperCase(self.TYPENAME);
  if cText = 'VARCHAR' then
  begin
    Result := Format('%s(%d)',[self.TYPENAME,self.DATASIZE]);
  end else
  if cText = 'NUMERIC' then
  begin
    Result := Format('%s(%d,%d)',[self.TYPENAME,self.DATASIZE,self.DATASCAL]);
  end;
end;

end.

//if (select prec from syscolumns where name='DISPLAY' and id=OBJECT_ID('T_GAMS_PROJECT')) !=1
//print 'false'
