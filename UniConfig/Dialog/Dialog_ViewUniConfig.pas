unit Dialog_ViewUniConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  ElXPThemedControl, ElTreeInplaceEditors, ElTree, Vcl.StdCtrls, Dialog_View,
  UniConfig,UniEngine;

type
  TDialogViewUniConfig = class(TDialogView)
    Tree_View: TElTree;
    Panel1: TPanel;
    Btnv_Mrok: TButton;
    Btnv_Quit: TButton;
    procedure Btnv_MrokClick(Sender: TObject);
    procedure Btnv_QuitClick(Sender: TObject);
    procedure Tree_ViewDblClick(Sender: TObject);
  protected
    procedure SetInitialize;override;
    procedure SetCommParams;override;
    procedure SetGridParams;override;
    procedure SetComboItems;override;
    procedure TryFreeAndNil;override;
  private
    FFileName: string;
    FLastText: string;
    FDBCONFIG: TUniConfig;
  public
    procedure ViewLast(Value:string);
  public
    procedure ReadCnfg(var uCnfg:TUniConfig);
    procedure TreeData;
    procedure InitDB;
  end;

var
  DialogViewUniConfig: TDialogViewUniConfig;

function ViewDataBase(var uCnfg: TUniConfig; FileName: string = 'config-default-sql server.json'; LastText: string = ''): Integer;

implementation
uses
  Class_KzUtils,Helpr_UniEngine;

{$R *.dfm}

function ViewDataBase(var uCnfg: TUniConfig; FileName: string; LastText: string): Integer;
begin
  try
    DialogViewUniConfig:=TDialogViewUniConfig.Create(nil);
    DialogViewUniConfig.FFileName := FileName;
    DialogViewUniConfig.FLastText := LastText;
    Result:=DialogViewUniConfig.ShowModal;
    if Result = Mrok then
    begin
      DialogViewUniConfig.ReadCnfg(uCnfg);
    end;
  finally
    FreeAndNil(DialogViewUniConfig);
  end;
end;

procedure TDialogViewUniConfig.SetComboItems;
begin
  inherited;

end;

procedure TDialogViewUniConfig.SetCommParams;
begin
  inherited;
  Caption:='数据连接';
  Btnv_Mrok.Caption:='确定';
  Btnv_Quit.Caption:='取消';
end;

procedure TDialogViewUniConfig.SetGridParams;
begin
  inherited;

end;

procedure TDialogViewUniConfig.SetInitialize;
begin
  inherited;
  InitDB;
end;

procedure TDialogViewUniConfig.TreeData;
var
  I:Integer;
  cData:TDataBase;
  Root:TElTreeItem;
  cItem:TElTreeItem;
begin
  Tree_View.Items.Clear;

  if (FDBCONFIG.FListData = nil) or (FDBCONFIG.FListData.Count = 0) then Exit;

  with Tree_View do
  begin
    Items.BeginUpdate;
    Root := Items.Add(nil,FDBCONFIG.UnicSrvr);

    for I := 0 to FDBCONFIG.FListData.Count-1 do
    begin
      cData := TDataBase(FDBCONFIG.FListData.Items[I]);
      if cData = nil then Continue;

      cItem := Items.AddChildObject(Root,cData.DataBase,cData);
    end;
    Root.Expanded := True;

    Items.EndUpdate;
  end;
end;

procedure TDialogViewUniConfig.Tree_ViewDblClick(Sender: TObject);
begin
  Btnv_MrokClick(Btnv_Mrok);
end;

procedure TDialogViewUniConfig.TryFreeAndNil;
begin
  inherited;
  if FDBCONFIG <> nil then TKzUtils.TryFreeAndNil(FDBCONFIG);

end;

procedure TDialogViewUniConfig.ViewLast(Value: string);
var
  I:Integer;
  cData:TDataBase;
  cItem:TElTreeItem;
  dItem:TElTreeItem;
begin
  if Value = '' then Exit;

  with Tree_View do
  begin
    for I := 0 to Items.Count - 1 do
    begin
      cItem := Items.Item[I];
      cData:= nil;
      cData := TDataBase(cItem.Data);
      if cData = nil then Continue;
      if Value = cData.DataBase then
      begin
        cItem.Selected := True;
        Tree_View.Selected := cItem;

        dItem := cItem.Parent;
        while dItem <> nil do
        begin
          dItem.Expanded := True;
          dItem := dItem.Parent;
        end;

        if not Tree_View.IsInView(cItem) then
        begin
          Tree_View.TopItem := cItem;
          cItem.Expanded := True;
        end;
        Break;
      end;
    end;
  end;
end;

procedure TDialogViewUniConfig.Btnv_QuitClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TDialogViewUniConfig.Btnv_MrokClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TDialogViewUniConfig.InitDB;
begin
  FDBCONFIG := TUniConfig.Create;
  FDBCONFIG.InFILE(TKzUtils.ExePath + FFileName);
  TreeData;
  if FLastText <> '' then
  begin
    ViewLast(FLastText);
  end;
end;

procedure TDialogViewUniConfig.ReadCnfg(var uCnfg: TUniConfig);
var
  cData:TDataBase;
begin
  with Tree_View do
  begin
    if Selected = nil then Exit;
    if Selected.Data = nil then Exit;

    cData := TDataBase(Selected.Data);
    if cData = nil then Exit;

    TUniConfig.CopyIt(FDBCONFIG,uCnfg);
    uCnfg.DataBase:= cData.DataBase;
  end;
end;

end.
