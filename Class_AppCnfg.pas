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
    FInUseZIP:Integer;
  published
    property SrvrAddr:string  read FSrvrAddr write FSrvrAddr;
    property SrvrPort:string  read FSrvrPort write FSrvrPort;
    property SrvrMemo:string  read FSrvrMemo write FSrvrMemo;
    property InUseZIP:Integer read FInUseZIP write FInUseZIP;
  public
    constructor Create;
  end;

implementation

{ TAppCnfg }

constructor TAppCnfg.Create;
begin
  FInUseZIP:=0;
end;

end.
