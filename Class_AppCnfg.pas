unit Class_AppCnfg;

interface
uses
  System.Classes,System.SysUtils,UniEngine;

type
  TAppCnfg=class(TUniEngine)
  private
    FSrvrAddr:string;
    FSrvrPort:string;
    FSrvrMemo:string;
  published
    property SrvrAddr:string  read FSrvrAddr write FSrvrAddr;
    property SrvrPort:string  read FSrvrPort write FSrvrPort;
    property SrvrMemo:string  read FSrvrMemo write FSrvrMemo;
  end;

implementation

end.
