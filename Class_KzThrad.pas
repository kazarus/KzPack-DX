unit Class_KzThrad;

interface

uses
  Classes,Variants;

type
  TKzThradGetMaxProgress  = procedure (Sender: TObject;AMaxProgress:Integer) of object;
  //procedure OnKzThradGetMaxProgress(Sender: TObject;AMaxProgress:Integer);
  TKzThradGetOneProgress  = procedure (Sender: TObject;AOneProgress:Integer) of object;
  //procedure OnKzThradGetOneProgress(Sender: TObject;AOneProgress:Integer);
  TKzThradGetTxtProgress  = procedure (Sender: TObject;ATxtProgress:string) of object;
  //procedure OnKzThradGetTxtProgress(Sender: TObject;ATxtProgress:string);
  TKzThradGetMsgProgress  = procedure (Sender: TObject;AMsgProgress:string;AVarProgress:array of Variant) of object;
  //procedure OnKzThradGetMsgProgress(Sender: TObject;AMsgProgress:string;AVarProgress:array of Variant);
    

  TKzThradParamType  = (ktptMax,ktptOne,ktptTxt,ktptMsg);

  TKzThrad = class(TThread)
  private
    FMaxProgress:Integer;
    FOneProgress:Integer;
    FTxtProgress:string;

    FMsgProgress:string;
    FVarProgress:array of Variant;
  private  
    procedure GetMaxProgress();overload;
    procedure GetOneProgress();overload;
    procedure GetTxtProgress();overload;

    procedure GetMsgProgress();overload;
  public
    FActionOnTerminate     :string;
  public
    OnKzThradGetMaxProgress:TKzThradGetMaxProgress;
    OnKzThradGetOneProgress:TKzThradGetOneProgress;
    OnKzThradGetTxtProgress:TKzThradGetTxtProgress;

    OnKzThradGetMsgProgress:TKzThradGetMsgProgress;
  public
    procedure GetMaxProgress(AMaxProgress:Integer);overload;
    procedure GetOneProgress(AOneProgress:Integer);overload;
    procedure GetTxtProgress(ATxtProgress:string); overload;

    procedure GetMsgProgress(AMsgProgress:string;AVarProgress:array of Variant);overload;
  protected
    procedure Execute; override;
  end;


const
  CONST_THRAD_STAT_EROR='EROR';
  CONST_THRAD_STAT_TRUE='TRUE';
  CONST_THRAD_STAT_FAIL='FAIL';    
  

implementation

uses
  Class_KzDebug;
{ TKzThrad }


{ TKzThrad }

procedure TKzThrad.Execute;
begin
  inherited;
end;

procedure TKzThrad.GetMaxProgress(AMaxProgress: Integer);
begin
  FMaxProgress:=AMaxProgress;
  Synchronize(GetMaxProgress);
end;

procedure TKzThrad.GetOneProgress(AOneProgress: Integer);
begin
  FOneProgress:=AOneProgress;
  Synchronize(GetOneProgress);
end;

procedure TKzThrad.GetTxtProgress(ATxtProgress: string);
begin
  FTxtProgress:=ATxtProgress;
  Synchronize(GetTxtProgress);
end;

procedure TKzThrad.GetMaxProgress;
begin
  if Assigned(OnKzThradGetMaxProgress) then
  begin
    OnKzThradGetMaxProgress(Self,FMaxProgress);
  end;
end;

procedure TKzThrad.GetOneProgress;
begin
  if Assigned(OnKzThradGetOneProgress) then
  begin
    OnKzThradGetOneProgress(Self,FOneProgress);
  end;
end;

procedure TKzThrad.GetTxtProgress;
begin
  if Assigned(OnKzThradGetTxtProgress) then
  begin
    OnKzThradGetTxtProgress(Self,FTxtProgress);
  end;
end;

procedure TKzThrad.GetMsgProgress(AMsgProgress: string;
  AVarProgress: array of Variant);
var
  I:Integer;
begin
  FMsgProgress:=AMsgProgress;

  if Length(AVarProgress)<>0 then
  begin
    SetLength(FVarProgress,Length(AVarProgress));

    for I:=0 to Length(AVarProgress)-1 do
    begin
      FVarProgress[I]:=AVarProgress[I];
    end;
  end;
  Synchronize(GetMsgProgress);
end;

procedure TKzThrad.GetMsgProgress;
begin
  if Assigned(OnKzThradGetMsgProgress) then
  begin
    OnKzThradGetMsgProgress(Self,FMsgProgress,FVarProgress);
  end;
end;

end.
