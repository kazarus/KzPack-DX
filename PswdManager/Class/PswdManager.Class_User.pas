unit PswdManager.Class_USER;


interface
uses
  Classes, SysUtils, UniEngine;

type
  TUSER4PSWD = class(TUniEngine)
  private
    FUserName: string;
    FUserCode: string;
    FPassWord: string;
    FUpdateMM: string;
  published
    property UserName: string read FUserName write FUserName;
    property UserCode: string read FUserCode write FUserCode;
    property PassWord: string read FPassWord write FPassWord;
    property UpdateMM: string read FUpdateMM write FUpdateMM;
  end;
implementation

end.
