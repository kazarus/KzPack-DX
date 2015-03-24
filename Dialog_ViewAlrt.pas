unit Dialog_ViewAlrt;
//alrt=alert

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TDialogViewAlrt = class(TForm)
    Btnx_Mrok: TButton;
    Btnx_Quit: TButton;
    Chkb_KEEP: TCheckBox;
    Labl_Text: TLabel;
    procedure Btnx_QuitClick(Sender: TObject);
    procedure Btnx_MrokClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FAlrtText:string;
  protected
    procedure ImptKeep(var AKeep:Boolean);
  public
  end;

  TKeepManager=class(TObject)
  private
    FListKeep:TStringList;
  public
    procedure Initialize;
    function  IsPushed(AKeepIdentity:string):Boolean;
    procedure PushKeep(AKeepIdentity:string;AValue:Boolean);
    function  PullKeep(AKeepIdentity:string):Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  DialogViewAlrt: TDialogViewAlrt;
  KeepManager   : TKeepManager;



function ViewViewAlrt(AText:string;var AKeep:Boolean):Integer;

implementation

{$R *.dfm}

function ViewViewAlrt(AText:string;var AKeep:Boolean):Integer;
begin
  try
    DialogViewAlrt:=TDialogViewAlrt.Create(nil);
    DialogViewAlrt.FAlrtText:=AText;
    Result:=DialogViewAlrt.ShowModal;
    DialogViewAlrt.ImptKeep(AKeep);
  finally
    FreeAndNil(DialogViewAlrt);
  end;
end;                  

{ TDialogViewAlrt }

procedure TDialogViewAlrt.ImptKeep(var AKeep: Boolean);
begin
  AKeep:=Chkb_KEEP.Checked;
end;

procedure TDialogViewAlrt.Btnx_QuitClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TDialogViewAlrt.Btnx_MrokClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TDialogViewAlrt.FormShow(Sender: TObject);
begin
  Btnx_Mrok.Caption:='确定';
  Btnx_Quit.Caption:='取消';
  Labl_Text.Caption:=FAlrtText;
end;

{ TKeepManager }

constructor TKeepManager.Create;
begin
  FListKeep:=TStringList.Create;
  FListKeep.Sorted:=True;
end;

destructor TKeepManager.Destroy;
begin
  if FListKeep<>nil then FreeAndNil(FListKeep);
  inherited;
end;

procedure TKeepManager.Initialize;
begin
  FListKeep.Clear;
end;

function TKeepManager.IsPushed(AKeepIdentity: string): Boolean;
begin
  if Trim(AKeepIdentity)='' then raise Exception.Create('AKEEPIDENTITY CAN NOT NULL');
  Result:=False;
  if (FListKeep=nil) or (FListKeep.Count=0) then Exit;

  Result:=FListKeep.IndexOfName(AKeepIdentity)<>-1;
end;

function TKeepManager.PullKeep(AKeepIdentity: string): Boolean;
begin
  if Trim(AKeepIdentity)='' then raise Exception.Create('AKEEPIDENTITY CAN NOT NULL');
  
  Result:=StrToBool(FListKeep.Values[AKeepIdentity]);
end;

procedure TKeepManager.PushKeep(AKeepIdentity: string; AValue: Boolean);
var
  IdexA:Integer;
begin
  if Trim(AKeepIdentity)='' then raise Exception.Create('AKEEPIDENTITY CAN NOT NULL');
  
  if FListKeep=nil then
  begin
    FListKeep:=TStringList.Create;
  end;
  IdexA:=FListKeep.IndexOfName(AKeepIdentity);
  if IdexA=-1 then
  begin
    FListKeep.Add(Format('%S=%S',[AKeepIdentity,BoolToStr(AValue)]));
  end else
  begin
    FListKeep.ValueFromIndex[IdexA]:=BoolToStr(AValue);
  end;    
end;

initialization
begin
  KeepManager:=TKeepManager.Create;
end;

finalization
begin
  if KeepManager<>nil then FreeAndNil(KeepManager);
end;

end.
