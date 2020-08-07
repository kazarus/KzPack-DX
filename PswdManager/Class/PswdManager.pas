unit PswdManager;
//#�������


interface
uses
  Classes, SysUtils;

type
  TPasswordStrongLevel = (pslNull, pslWeakly, pslMiddle, pslStrong);

  TPswdManager = class(TObject)
  public
    class function ChkPasswordStrongLevel(aValue: string; count: Integer = 6): TPasswordStrongLevel;
    class function GetPasswordStrongLevel(aLevel: TPasswordStrongLevel): string;
  end;

implementation

uses
  Class_KzUtils;

class function TPswdManager.ChkPasswordStrongLevel(aValue: string; count: Integer): TPasswordStrongLevel;
var
  Level: Integer;
  pText: string;
begin
  Result := pslNull;

  {#if Length(aValue) < count then
  begin
    Exit;
  end;}

  {#if UpperCase(aValue) = 'A111111' then
  begin
    Result := pslWeakly;
    Exit;
  end;}

  Level  := 0;
  //#����
  if TKzUtils.DidStrMatched(aValue, '\d+', pText) then
  begin
    Inc(Level);
  end;
  //#Сд
  if TKzUtils.DidStrMatched(aValue, '[a-z]+', pText) then
  begin
    Inc(Level);
  end;
  //#��д
  if TKzUtils.BoolStrMatchx(aValue, '[A-Z]+', pText) then
  begin
    Inc(Level);
  end;
  //#����
  if TKzUtils.DidStrMatched(aValue, '[!@#$%^&*()_+;<>?{}|]+', pText) then
  begin
    Inc(Level);
  end;

  if Level = 1 then
  begin
    Result := pslWeakly;
  end else
  if Level = 2 then
  begin
    Result := pslMiddle;
  end else
  if Level >= 3 then
  begin
    Result := pslStrong;
  end;
end;

class function TPswdManager.GetPasswordStrongLevel(aLevel: TPasswordStrongLevel): string;
begin
  Result := '';
  case ALevel of
    pslNull  : Result := 'ǿ��:��';
    pslWeakly: Result := 'ǿ��:��';
    pslMiddle: Result := 'ǿ��:��';
    pslStrong: Result := 'ǿ��:ǿ';
  end;
end;

end.
