unit Class_Dict;
//YXC_2012_09_11_20_12_30
//TBL_UNIDICT

interface
uses
  Classes,SysUtils,Uni,UniEngine;

type
  TDict=class(TUniEngine)
  public
    DictIdex: Integer; //*�ֵ�����
    DictMode: string;  //����ģ��
    DictInfo: string;  //�ֵ����
    DictCode: string;  //�ֵ����
    DictName: string;  //�ֵ�����
    DictMemo: string;  //�ֵ䱸ע
  protected
    procedure SetParameters;override;
    function  GetStrInsert:string;override;
    function  GetStrUpdate:string;override;
    function  GetStrDelete:string;override;
    function  GetStrsIndex:string;override;    
  public
    function  GetNextIdex:Integer;overload;
    function  GetNextIdex(AUniConnection:TUniConnection):Integer;overload;
  public
    function  CheckExist(AUniConnection:TUniConnection):Boolean;override;       
  public
    class function ReadDS(AUniQuery:TUniQuery):TUniEngine;override;

    class procedure SetDefault(AUniConnection:TUniConnection);
    class procedure SetUpgrade(AUniConnection:TUniConnection);
    class procedure UpdateDict(ADictMode,ADictCode:string;AUniConnection:TUniConnection);        
  end;

implementation

{ TDict }

function TDict.CheckExist(AUniConnection: TUniConnection): Boolean;
begin
  Result:=CheckExist('TBL_UNIDICT',['DICT_MODE',DictMode],AUniConnection);
end;

function TDict.GetNextIdex: Integer;
begin

end;

function TDict.GetNextIdex(AUniConnection: TUniConnection): Integer;
begin
  Result:=CheckField('DICT_IDEX','TBL_UNIDICT',[],AUniConnection);
end;

function TDict.GetStrDelete: string;
begin
  Result:='DELETE FROM TBL_UNIDICT WHERE DICT_IDEX=:DICT_IDEX';
end;

function TDict.GetStrInsert: string;
begin
  Result:='INSERT INTO TBL_UNIDICT (DICT_IDEX,DICT_MODE,DICT_INFO,DICT_CODE,DICT_NAME,DICT_MEMO) '
          +'    VALUES(:DICT_IDEX,:DICT_MODE,:DICT_INFO,:DICT_CODE,:DICT_NAME,:DICT_MEMO)';
end;

function TDict.GetStrsIndex: string;
begin
  Result:=DictMode;
end;

function TDict.GetStrUpdate: string;
begin
  Result:='UPDATE TBL_UNIDICT SET'
         +'    DICT_MODE = :DICT_MODE,'
         +'    DICT_CODE = :DICT_CODE,'
         +'    DICT_INFO = :DICT_INFO,'
         +'    DICT_NAME = :DICT_NAME,'
         +'    DICT_MEMO = :DICT_MEMO'
         +'    WHERE DICT_IDEX = :DICT_IDEX';
end;

class function TDict.ReadDS(AUniQuery: TUniQuery): TUniEngine;
begin
  Result:=TDict.Create;
  with TDict(Result) do
  begin
    DICTIDEX := AUniQuery.FieldByName('DICT_IDEX').AsInteger;
    DICTMODE := Trim(AUniQuery.FieldByName('DICT_MODE').AsString);
    DictInfo := Trim(AUniQuery.FieldByName('DICT_INFO').AsString);
    DICTCODE := Trim(AUniQuery.FieldByName('DICT_CODE').AsString);
    DICTNAME := Trim(AUniQuery.FieldByName('DICT_NAME').AsString);
    DictMemo := Trim(AUniQuery.FieldByName('DICT_MEMO').AsString);
  end;
end;

class procedure TDict.SetDefault(AUniConnection: TUniConnection);
var
  DictA:TDict;
begin
  //CONST_DICT_MODE_DWBMGZ='00003';//��λ�������
  //CONST_DICT_MODE_BMBMGZ='00004';//���ű������
  //CONST_DICT_MODE_LXBMGZ='00005';//���ͱ������
  //CONST_DICT_MODE_RYBMCD='00006';//��Ա���볤��
  
  //CONST_DICT_MODE_BDCZDW='00007';//���ز�����λ
  //CONST_DICT_MODE_KJNDKD='00008';//�����ȿ��
  //CONST_DICT_MODE_ZDGZDH='00009';//����ʵ���
  //CONST_DICT_MODE_LXGXCX='00010';//���͹�ϵ��ѯ

  DictA:=TDict.Create;
    
  DictA.DictIdex:=1;
  DictA.DictMode:='00001';
  DictA.DictInfo:='���ݿ�汾��';
  DictA.DictCode:='10001';
  DictA.DictName:='';
  DictA.DictMemo:='';
  DictA.SaveItWhenNotExist(AUniConnection);

  DictA.DictIdex:=2;
  DictA.DictMode:='00002';
  DictA.DictInfo:='����汾��';
  DictA.DictCode:='0.0.0.1';
  DictA.DictName:='';
  DictA.DictMemo:='';
  DictA.SaveItWhenNotExist(AUniConnection);  

  DictA.DictIdex:=3;
  DictA.DictMode:='00003';
  DictA.DictInfo:='��λ�������';
  DictA.DictCode:='444';
  DictA.DictName:='';
  DictA.DictMemo:='';
  DictA.SaveItWhenNotExist(AUniConnection);

  DictA.DictIdex:=4;
  DictA.DictMode:='00004';
  DictA.DictInfo:='���ű������';
  DictA.DictCode:='22';
  DictA.DictName:='';
  DictA.DictMemo:='';
  DictA.SaveItWhenNotExist(AUniConnection);

  DictA.DictIdex:=5;
  DictA.DictMode:='00005';
  DictA.DictInfo:='���ز�����λ';
  DictA.DictCode:='-1';
  DictA.DictName:='';
  DictA.DictMemo:='';
  DictA.SaveItWhenNotExist(AUniConnection);


  {DictA.DictIdex:=10;
  DictA.DictMode:='00010';
  DictA.DictInfo:='���͹�ϵ��ѯ';
  DictA.DictCode:='0';
  DictA.DictName:='';
  DictA.DictMemo:='';
  DictA.InsertDB(AUniConnection);}

  FreeAndNil(DictA);
end;

procedure TDict.SetParameters;
begin
  inherited;
  with FUniSQL do
  begin
    case FOptTyp of
      otAddx,otEdit:
      begin
        ParamByName('DICT_IDEX').Value := DICTIDEX;
        ParamByName('DICT_MODE').Value := DICTMODE;
        ParamByName('DICT_INFO').Value := DictInfo;
        ParamByName('DICT_CODE').Value := DICTCODE;
        ParamByName('DICT_NAME').Value := DICTNAME;
        ParamByName('DICT_MEMO').Value := DictMemo;
      end;  
      otDelt:
      begin
        ParamByName('DICT_IDEX').Value := DICTIDEX;
      end;  
    end;
  end;
end;

class procedure TDict.UpdateDict(ADictMode, ADictCode: string;
  AUniConnection: TUniConnection);
var
  SqlA:string;  
begin
  SQLA:='UPDATE TBL_UNIDICT SET DICT_CODE=%S WHERE DICT_MODE=%S';
  SqlA:=Format(SqlA,[QuotedStr(ADictCode),QuotedStr(ADictMode)]);

  TDict.ExecuteSQL(SqlA,AUniConnection);  
end;

class procedure TDict.SetUpgrade(AUniConnection: TUniConnection);
begin

end;

end.
