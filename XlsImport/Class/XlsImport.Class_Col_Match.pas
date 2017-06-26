unit XlsImport.Class_Col_Match;
//#XlsImport

interface
uses
  Classes,SysUtils,DB,Uni,UniEngine;

type
  TColMatch = class(TUniEngine)
  private
    FColStart:string;
    FColRight:string;
  published
    property ColStart: string read FColStart write FColStart;
    property ColRight: string read FColRight write FColRight;
  end;


implementation

end.
