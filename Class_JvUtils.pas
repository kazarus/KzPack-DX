unit Class_JvUtils;

interface
uses
  Classes,SysUtils;

type
  TJvUtils=class(TObject)
  public
    class function toString(paramInt1:Integer;paramInt2:Integer):string;
    class function hashCode(paramsStr1:string):Cardinal;
    class function hashText(const SoureStr: string):Cardinal;
    class function hashCode2(val: string): Integer;
  end;

implementation

uses
  System.Math;

{ TJvUtils }

class function TJvUtils.hashCode(paramsStr1: string): Cardinal;
var
  I:Integer;
begin
//  public String()
//  {
//    this.offset = 0;
//    this.count = 0;
//    this.value = new char[0];
//  }

//  public int hashCode()
//  {
//    int i = this.hash;
//    if (i == 0)
//    {
//      int j = this.offset;
//      char[] arrayOfChar = this.value;
//      int k = this.count;
//      for (int m = 0; m < k; m++)
//        i = 31 * i + arrayOfChar[(j++)];
//      this.hash = i;
//    }
//    return i;
//  }

  Result := 0;
  for I := 1 to Length(paramsStr1) do
  begin
    Result := Result * 31 + Ord(paramsStr1[I]);
  end;
end;

class function TJvUtils.hashCode2(val: string): Integer;
var
  i: Integer;
  res: Extended;
  x: Integer;

  function RoundEx(x: Extended): Integer;
  begin
    Result := Trunc(x) + Trunc(Frac(x) * 2);
  end;
begin
  if val = '' then Exit;

  res := 0;

  for i := 1 to Length(val) do
  begin
    res := res + Ord(val[i]) * Power(31, Length(val) - (i - 1) - 1);
  end;

  Result := RoundEx(res);
end;


class function TJvUtils.hashText(const SoureStr: string): Cardinal;
const
  cLongBits = 32;
  cOneEight = 4;
  cThreeFourths = 24;
  cHighBits = $F0000000;
var
  I: Integer;
  P: PChar;
  Temp: Cardinal;
begin
  Result := 0;
  P := PChar(SoureStr);
  I := Length(SoureStr);
  while I > 0 do
  begin
    Result := (Result shl cOneEight) + Ord(P^);
    Temp := Result and cHighBits;
    if Temp <> 0 then
      Result := (Result xor (Temp shr cThreeFourths)) and (not cHighBits);
    Dec(I);
    Inc(P);
  end;
end;

class function TJvUtils.toString(paramInt1, paramInt2: Integer): string;
const
  digits:array[0..35] of char = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' );
var
  I:Integer;
  J:Integer;
  arrayOfChar:array[0..32] of Char;
  arrayOfCopy:array[0..32] of Char;  
begin
//  public static String toString(int paramInt1, int paramInt2)
//  {
//    if ((paramInt2 < 2) || (paramInt2 > 36))
//      paramInt2 = 10;
//    if (paramInt2 == 10)
//      return toString(paramInt1);
//    char[] arrayOfChar = new char[33];
//    int i = paramInt1 < 0 ? 1 : 0;
//    int j = 32;
//    if (i == 0)
//      paramInt1 = -paramInt1;
//    while (paramInt1 <= -paramInt2)
//    {
//      arrayOfChar[(j--)] = digits[(-(paramInt1 % paramInt2))];
//      paramInt1 /= paramInt2;
//    }
//    arrayOfChar[j] = digits[(-paramInt1)];
//    if (i != 0)
//      arrayOfChar[(--j)] = '-';
//    return new String(arrayOfChar, j, 33 - j);
//  }

  Result:='';
  if (paramInt2<2) and (paramInt2<36) then
  begin
    paramInt2:=10;
  end;
  if paramInt2=10 then
  begin
    Result:=IntToStr(paramInt1);
    Exit;
  end;
  if paramInt1 <0 then
  begin
    I:=1;
  end else
  begin
    I:=0;
  end;
  J:=32;
  if I=0 then
  begin
    paramInt1 := paramInt1 * -1;
  end;

  while (paramInt1 <= -1 * paramInt2) do
  begin
    arrayOfChar[J]:=digits[-1 * (paramInt1 mod paramInt2 )];
    paramInt1 := paramInt1 div paramInt2;
    Dec(J);
  end;
  arrayOfChar[J]:=digits[-1 * paramInt1];
  if (I<>0) then
  begin
    Dec(J);
    arrayOfChar[J]:='-';
  end;

  for I:=J to Length(arrayOfChar)-1 do
  begin
    Result:=Result+arrayOfChar[I];
  end;
  Result:=Trim(Result);
end;

end.
