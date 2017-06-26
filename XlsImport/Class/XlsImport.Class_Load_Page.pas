unit XlsImport.Class_Load_Page;
//#XlsImport

interface
uses
  Classes,SysUtils,DB,Uni,UniEngine;

type
  TLoadPage = class(TUniEngine)
  private
    FPAGEINDX: Integer;
    FPAGENAME: string;
  published
    property PAGEINDX:Integer read FPAGEINDX write FPAGEINDX;
    property PAGENAME:string  read FPAGENAME write FPAGENAME;
  end;

implementation

end.
