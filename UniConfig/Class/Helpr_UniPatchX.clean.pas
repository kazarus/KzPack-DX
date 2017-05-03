unit Helpr_UniPatchX;
//tbl_loft

interface
uses
  System.SysUtils,System.Classes,Uni,UniPatchX,UniConnct;

type
  THelprUniPatchX=class helper for TUniPatchX
  public
    function  GetCurrentDataBaseVersion:Integer;
  public
    class procedure RollbackOnDataBaseVersion(AEndedV:Integer;AStartV:Integer=10001);
  public
    procedure Execute10001;
    procedure Execute10002;
    procedure Execute10003;
    procedure Execute10004;
    procedure Execute10005;
    procedure Execute10006;
    procedure Execute10007;
    procedure Execute10008;
    procedure Execute10009;
    procedure Execute10010;
  end;

implementation

uses
  Dialogs,Class_AppUtil,Class_SQLX;


procedure THelprUniPatchX.Execute10001;
begin
  //
end;

procedure THelprUniPatchX.Execute10002;
begin
end;

procedure THelprUniPatchX.Execute10003;
begin
end;

procedure THelprUniPatchX.Execute10004;
begin
end;

procedure THelprUniPatchX.Execute10005;
begin
end;

procedure THelprUniPatchX.Execute10006;
begin
end;

procedure THelprUniPatchX.Execute10007;
begin
end;

procedure THelprUniPatchX.Execute10008;
begin
end;

procedure THelprUniPatchX.Execute10009;
begin
end;

procedure THelprUniPatchX.Execute10010;
begin
end;


function THelprUniPatchX.GetCurrentDataBaseVersion: Integer;
begin
  Result:=10010;
end;

class procedure THelprUniPatchX.RollbackOnDataBaseVersion(AEndedV:Integer;AStartV:Integer);
var
  IDXA:Integer;
  TMPA:string;
  SQLA:string;
  UniConnct:TUniConnection;
begin
  if InputQuery('数据库版本回退',Format('请输入基于%D与%D之间的5位数字     ',[AStartV,AEndedV]),TMPA) then
  begin
    IDXA:=StrToInt(TMPA);

    if (IDXA >= AStartV)  and (IDXA < AEndedV) then
    begin
      SQLA:='UPDATE %S SET DICT_CODE=%D WHERE DICT_MODE=%S';
      SQLA:=Format(SQLA,[UniPatchxEx.TargetTabl,IDXA,QuotedStr('00001')]);
      try
        UniConnct:=UniConnctEx.GetConnection(UniPatchxEx.TargetMark);
        //->
        UniConnctEx.ExecuteSQL(SQLA,UniConnct);
        //-<
      finally
        FreeAndNil(UniConnct);
      end;
      ShowMessage('版本号回退成功,请重启应用.');
    end else
    begin
      ShowMessage('非法的版本号');
    end;
  end;
end;

initialization
begin
  UniPatchxEx.AddPatch('10002',CONST_MARK_CBHS,@TUniPatchX.Execute10002);
  UniPatchxEx.AddPatch('10003',CONST_MARK_CBHS,@TUniPatchX.Execute10003);
  UniPatchxEx.AddPatch('10004',CONST_MARK_CBHS,@TUniPatchX.Execute10004);
  UniPatchxEx.AddPatch('10005',CONST_MARK_CBHS,@TUniPatchX.Execute10005);
  UniPatchxEx.AddPatch('10006',CONST_MARK_CBHS,@TUniPatchX.Execute10006);
  UniPatchxEx.AddPatch('10007',CONST_MARK_CBHS,@TUniPatchX.Execute10007);
  UniPatchxEx.AddPatch('10008',CONST_MARK_CBHS,@TUniPatchX.Execute10008);
  UniPatchxEx.AddPatch('10009',CONST_MARK_CBHS,@TUniPatchX.Execute10009);
  UniPatchxEx.AddPatch('10010',CONST_MARK_CBHS,@TUniPatchX.Execute10010);
end;

finalization
begin

end;
end.
