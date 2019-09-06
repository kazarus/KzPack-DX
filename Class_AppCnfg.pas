unit Class_AppCnfg;


interface
uses
  System.Classes,System.SysUtils,UniEngine;

type
  TAppCnfg=class(TUniEngine)
  private
    FSrvrAddr: string;
    FSrvrPort: string;
    FSrvrMemo: string;
    FInUseZIP: Integer;
    FInUseTLS: Integer;
    FUserLast: string;
  published
    property SrvrAddr: string read FSrvrAddr write FSrvrAddr;
    property SrvrPort: string read FSrvrPort write FSrvrPort;
    property SrvrMemo: string read FSrvrMemo write FSrvrMemo;
    property InUseZIP: Integer read FInUseZIP write FInUseZIP;
    property InUseTLS: Integer read FInUseTLS write FInUseTLS;
    property UserLast: string read FUserLast write FUserLast;
  public
    constructor Create;
  end;

implementation



constructor TAppCnfg.Create;
begin
  FInUseZIP:=0;
end;

end.
