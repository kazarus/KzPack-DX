unit Class_KzPrintEx;

interface
uses
  SysUtils,AdvGrid,frxClass,frxDesgn,Classes,XMLDoc,XMLIntf,Dialogs,frxXML,
  frxXMLSerializer,Graphics,Variants,frxEngine,Printers, frxExportPDF,Math,
  frxGraphicUtils;

type
  TKzCellTextEx=class(TObject)          //from tadvstringgrid
  public
    ColIndex:Integer;
    RowIndex:Integer;
    RowOrder:Integer;                 

    CellText:WideString;
    CellAlig:Integer;

    CellGapX:Integer;                    //spanX
    CellGapY:Integer;                    //spanY

    TopOrder:Integer;
    TotlTopX:Extended;
    TotlLeft:Extended;
    ThisWidt:Extended;
    ThisHeig:Extended;

    IsfsBold:Boolean;                    //
    FontName:string;                     //
    FontSize:Integer;                    //
  public
    function GetStrIndex:string;
  public
    constructor Create;
  public
    class function  CopyIt(AKzCellTextEx:TKzCellTextEx):TKzCellTextEx;overload;
    class procedure CopyIt(AKzCellTextEx:TKzCellTextEx;var Result:TKzCellTextEx);overload;
  end;

  TKzPrintExGetListCellHead = procedure (Sender:TObject;APrintIdentity:string;var AList:TStringList) of object;
  TKzPrintExGetListCellBody = procedure (Sender:TObject;APrintIdentity:string;var AList:TStringList) of object;
  //TKzPrintExWhichColumnJoinTextSplit = procedure (Sender:TObject;AColIndex:Integer;var Valid:Boolean) of object;

  //procedure OnKzPrintExGetListCellHead(Sender:TObject;APrintIdentity:string;var AList:TStringList);
  //procedure OnKzPrintExGetListCellBody(Sender:TObject;APrintIdentity:string;var AList:TStringList);

  
  TfrxObjectType=(fotHead,fotPage,fotMast,fotFoot);

  TKzPrintEx=class(TObject)
  private
    FIsDsgnMod  :Boolean;               //设计模式
    FIsFileCacheInited:Boolean;         //
    FRowCountInPage:Integer;            //

    FCanvas    :TCanvas;                //for text split
    FfrxReport :TfrxReport;             //for print
    MfrxReport :TfrxReport;             //for config

    FListCellHead:TStringList;          //*list of *TkzCellTextEx
    FListCellBody:TStringList;          //*list of *TkzCellTextEx
    FListCellGarb:TStringList;          //*list of *TkzCellTextEx.garbage
    FListPages   :TStringList;          //*list of tfrereportpage
    FListVariabl :TStringList;          //list of variable
  private
    FPrintIdentity:string;              //
    
    //can  not empty.    
    FFileCache    :string;              //*.fr3模块文件

    FDefaultRowHeightHead:Extended;     //*
    FDefaultRowHeightBody:Extended;     //*
    FTotalRowCountHead   :Integer;      //*
    FTotalRowCountBody   :Integer;      //*
  protected
    procedure InitializeFileCache;      //
    function  FindObject(AType:TfrxObjectType):TfrxComponent;
    function  FindMaster(ARowOrder:Integer;var APageOrder:Integer):TfrxMasterData;

    function  AddChildInMast(ACell:TKzCellTextEx;var APageOrder:Integer):TfrxMemoView;
    procedure AddChildInHead(AHeadStartPosY:Extended;ACell:TKzCellTextEx;AHead:TfrxPageHeader);
    procedure CopyMemoInBand(ATargetView,ASourceView:TfrxMemoView);

    function  GetPageCount:Integer;     //
  protected
    function  PreparX:Boolean;
    function  TstView:TfrxMemoView;
  protected
    procedure SetfrxVariabl;
    procedure OnGetValue(const VarName: String;var Value: Variant);    
  public
    OnKzPrintExGetListCellHead:TKzPrintExGetListCellHead;
    OnKzPrintExGetListCellBody:TKzPrintExGetListCellBody;
    //OnKzPrintExWhichColumnJoinTextSplit:TKzPrintExWhichColumnJoinTextSplit;
  public
    procedure Execute(IsDsgnMod:Boolean=False);
    function  ExportX:TfrxReport;       //loke same as execute method,just return tfrxreport
  public
    constructor Create;
    destructor Destroy; override;
  public
    property PrintIdentity       :string   read FPrintIdentity        write FPrintIdentity;
    property FileCache           :string   read FFileCache            write FFileCache;
    property DefaultRowHeightHead:Extended read FDefaultRowHeightHead write FDefaultRowHeightHead;
    property DefaultRowHeightBody:Extended read FDefaultRowHeightBody write FDefaultRowHeightBody;
    property TotalRowCountHead   :Integer  read FTotalRowCountHead    write FTotalRowCountHead;
    property TotalRowCountBody   :Integer  read FTotalRowCountBody    write FTotalRowCountBody;
    property ListVariabl         :TStringList read FListVariabl       write FListVariabl;
  public
    class procedure ImptListCellTextEx(AGrid:TAdvStringGrid;AColStart,AColEnded,ARowStart,ARowEnded:Integer;var AList:TStringList);
  end;


const
  CONST_KZPRINT_SYSVARIABL='KzPrintEx.系统变量';
  CONST_KZPRINT_APPVARIABL='KzPrintEx.程序变量';
    
implementation

uses
  Class_KzUtils,Class_KzDebug;

{ TKzPrintEx }




procedure TKzPrintEx.AddChildInHead(AHeadStartPosY: Extended;
  ACell: TKzCellTextEx; AHead: TfrxPageHeader);
var
  ViewA:TfrxMemoView;  
begin
  ViewA:=TfrxMemoView.Create(AHead);
  //@ViewA.CreateUniqueName;

  ViewA.Top       := AHeadStartPosY + FDefaultRowHeightBody * ACell.TopOrder;
  ViewA.Left      := ACell.TotlLeft;
  ViewA.Text      := ACell.CellText;
  ViewA.Width     := ACell.ThisWidt;
  ViewA.Height    := FDefaultRowHeightHead * (ACell.CellGapY+1);

  ViewA.Frame.Typ   :=[ftLeft,ftRight,ftTop,ftBottom];  
  ViewA.Font.Name   :=ACell.FontName;
  ViewA.Font.Size   :=ACell.FontSize;
  ViewA.Font.Charset:=1;
  
  ViewA.VAlign    := vaCenter;
  case ACell.CellAlig of
    1:ViewA.HAlign:=haLeft;
    2:ViewA.HAlign:=haCenter;
    3:ViewA.HAlign:=haRight;
  end;
  if ACell.IsfsBold then
  begin
    ViewA.Font.Style := ViewA.Font.Style + [fsBold];
  end;
end;

function  TKzPrintEx.AddChildInMast(ACell: TKzCellTextEx;var APageOrder:Integer):TfrxMemoView;
var
  PageOrder:Integer;
  
  ViewA:TfrxMemoView;
  MastA:TfrxMasterData;
begin
  MastA:=nil;
  MastA:=FindMaster(ACell.RowOrder,PageOrder);
  APageOrder:=PageOrder;
    
  if (MastA=nil)   then Exit;
  if APageOrder=-1 then Exit;

  ViewA:=TfrxMemoView.Create(MastA);
  //@ViewA.CreateUniqueName;
  
  ViewA.Height:=FDefaultRowHeightBody * (ACell.CellGapY+1);
  ViewA.Width :=ACell.ThisWidt;
  ViewA.Top   :=FDefaultRowHeightBody * (ACell.TopOrder) - (PageOrder-1) * FDefaultRowHeightBody * FRowCountInPage;
  ViewA.Left  :=ACell.TotlLeft;

  ViewA.Frame.Typ   := [ftLeft, ftRight, ftTop, ftBottom];
  ViewA.Font.Name   := ACell.FontName;
  ViewA.Font.Size   := ACell.FontSize;
  ViewA.Font.Charset:= 1;

  ViewA.Clipped     :=True;
  ViewA.GapX        :=2;
  ViewA.GapY        :=2;
  ViewA.LineSpacing :=0;
  //ViewA.GapX      :=2;
  //ViewA.GapY      :=10;

  ViewA.VAlign    := vaCenter;
  case ACell.CellAlig of
    1:ViewA.HAlign:=haLeft;
    2:ViewA.HAlign:=haCenter;
    3:ViewA.HAlign:=haRight;
  end;
  if ACell.IsfsBold then
  begin
    ViewA.Font.Style := ViewA.Font.Style + [fsBold];
  end;  

  ViewA.Text  :=ACell.CellText;

  Result:=ViewA;
end;

procedure TKzPrintEx.CopyMemoInBand(ATargetView,
  ASourceView: TfrxMemoView);
begin
  ATargetView.Left  := ASourceView.Left;
  ATargetView.Top   := ASourceView.Top;
  ATargetView.Height:= ASourceView.Height;
  ATargetView.Width := ASourceView.Width;
  ATargetView.Frame.Typ := ASourceView.Frame.Typ;
  ATargetView.Text  := ASourceView.Text;
  ATargetView.VAlign:= ASourceView.VAlign;
  ATargetView.HAlign:= ASourceView.HAlign;
  ATargetView.Align := ASourceView.Align;
  ATargetView.Font.Name := ASourceView.Font.Name;
  ATargetView.Font.Size := ASourceView.Font.Size;
  ATargetView.Font.Charset:=ASourceView.Font.Charset;
  ATargetView.Font.Style  :=ASourceView.Font.Style;
end;

constructor TKzPrintEx.Create;
begin
  FCanvas   :=TCanvas.Create;
  FfrxReport:=nil;
  MfrxReport:=nil;
  
  FListPages   :=TStringList.Create;
  FListPages.Sorted:=True;
  FListVariabl :=TStringList.Create;
  FListCellHead:=TStringList.Create;
  FListCellBody:=TStringList.Create;
  FListCellGarb:=TStringList.Create;
end;

destructor TKzPrintEx.Destroy;
begin
  if FCanvas     <>nil then FreeAndNil(FCanvas);
  if FfrxReport  <>nil then FreeAndNil(FfrxReport);
  if MfrxReport  <>nil then FreeAndNil(MfrxReport);
  if FListPages  <>nil then FreeAndNil(FListPages);
  if FListVariabl<>nil then FreeAndNil(FListVariabl);

  if FListCellHead<>nil then TKzUtils.TryFreeAndNil(FListCellHead);
  if FListCellBody<>nil then TKzUtils.TryFreeAndNil(FListCellBody);
  if FListCellGarb<>nil then TKzUtils.TryFreeAndNil(FListCellGarb);
  inherited;
end;

procedure TKzPrintEx.Execute(IsDsgnMod:Boolean);
begin
  FIsDsgnMod:=IsDsgnMod;

  KzDebug.Started;
  KzDebug.TickLog('1:VAR');
  if not PreparX then Exit;
  KzDebug.TickLog('2:VAR');

  if FIsDsgnMod then
  begin
    FfrxReport.DesignReport();
  end else
  begin
    FfrxReport.ShowReport();
  end;
  KzDebug.TickLog('3:VAR');
end;

function TKzPrintEx.ExportX: TfrxReport;
begin
  if not PreparX then Exit;
  FfrxReport.PrepareReport(True);
  Result:=FfrxReport;
end;



function TKzPrintEx.FindMaster(ARowOrder: Integer;var APageOrder:Integer): TfrxMasterData;
var
  I:Integer;
  PageA:TfrxReportPage;
  MastA:TfrxMasterData;
  PageIndex:Integer;
  PageOrder:Integer;
begin
  Result:=nil;
  APageOrder:=-1;
  
  if ARowOrder < FRowCountInPage  then
  begin
    PageOrder:=1;
  end else
  begin
    PageOrder:=ARowOrder div FRowCountInPage;
    if ARowOrder mod FRowCountInPage >0 then
    begin
      Inc(PageOrder);
    end;
  end;

  APageOrder:=PageOrder;

  PageIndex:=FListPages.IndexOf(IntToStr(PageOrder));
  if PageIndex<>-1 then
  begin
    PageA:=TfrxReportPage(FListPages.Objects[PageIndex]);
    for I:=0 to PageA.Objects.Count-1 do
    begin
      if TfrxComponent(PageA.Objects.Items[I]) is TfrxMasterData then
      begin
        Result:=TfrxMasterData(TfrxComponent(PageA.Objects.Items[I]));
        Break;
      end;
    end;
  end else
  begin
    Result:=nil;
    APageOrder:=-1;  
  end;
end;

function TKzPrintEx.FindObject(AType: TfrxObjectType): TfrxComponent;
var
  I:Integer;
  BoolA:Boolean;
begin
  Result:=nil;
  
  if not FIsFileCacheInited then 
  begin
    InitializeFileCache;
  end;

  for I:=0 to MfrxReport.AllObjects.Count-1 do
  begin
    BoolA:=False;
    case AType of
      fotHead:BoolA:=TfrxComponent(MfrxReport.AllObjects.Items[I]) is TfrxPageHeader;
      fotPage:BoolA:=TfrxComponent(MfrxReport.AllObjects.Items[I]) is TfrxReportPage;
      fotMast:BoolA:=TfrxComponent(MfrxReport.AllObjects.Items[I]) is TfrxMasterData;
      fotFoot:BoolA:=TfrxComponent(MfrxReport.AllObjects.Items[I]) is TfrxPageFooter;
    end;
    if BoolA then
    begin
      Result:=TfrxComponent(MfrxReport.AllObjects.Items[I]);
      Break;
    end;
  end;
end;

function TKzPrintEx.GetPageCount: Integer;
var
  PageA:TfrxReportPage;
  MastA:TfrxMasterData;
  HeadA:TfrxPageHeader;
  FootA:TfrxPageFooter;

  X:Extended;
  PageHeight:Extended;
  HeadHeight:Extended;
  FootHeight:Extended;
  MastHeight:Extended;//=pageheight-headheight-footheight
  AllMargins:Extended;//
begin
  Result:=0;

  PageHeight:=0;
  HeadHeight:=0;
  FootHeight:=0;
  MastHeight:=0;

  PageA:=nil;
  PageA:=TfrxReportPage(FindObject(fotPage));
  if PageA=nil  then Exit;

  PageHeight:=PageA.Height;
  AllMargins:=(PageA.TopMargin + PageA.BottomMargin) * fr01cm;

  HeadA:=nil;
  HeadA:=TfrxPageHeader(FindObject(fotHead));
  if HeadA<>nil then HeadHeight:=HeadA.Height;

  FootA:=nil;
  FootA:=TfrxPageFooter(FindObject(fotFoot));
  if FootA<>nil then FootHeight:=FootA.Height;

  MastHeight:=PageHeight - HeadHeight - FootHeight - AllMargins ;

  FRowCountInPage:=Trunc(MastHeight / DefaultRowHeightBody);
  Result := FTotalRowCountBody div FRowCountInPage;
  if FTotalRowCountBody mod FRowCountInPage >0 then
  begin
    Inc(Result);
  end;
end;



class procedure TKzPrintEx.ImptListCellTextEx(AGrid: TAdvStringGrid;
  AColStart, AColEnded, ARowStart, ARowEnded: Integer;
  var AList: TStringList);
var
  C,R:Integer;
  CellA:TKzCellTextEx;

  RowOrder :Integer;
  TotalTopX:Extended;
  TotalLeft:Extended;
begin
  with AGrid do
  begin
    if AColEnded=-1 then AColEnded:=AGrid.ColCount-1;
    if ARowEnded=-1 then ARowEnded:=AGrid.RowCount-1;

    TotalLeft:=0;
    for C:=AColStart to AColEnded do
    begin
      TotalTopX:=0;
      RowOrder :=1;
      for R:=ARowStart to ARowEnded do
      begin
        if IsMergedCell(C,R) then
        begin
          if not IsBaseCell(C,R) then
          begin
            TotalTopX:=TotalTopX+RowHeights[R];
            Inc(RowOrder);
            Continue;
          end;
        end;

        CellA:=TKzCellTextEx.Create;
        CellA.ColIndex:=C;
        CellA.RowIndex:=R;
        CellA.RowOrder:=RowOrder;
        CellA.CellText:=Format('cell:%d:%d',[C,R]);
        CellA.CellText:=Trim(Cells[C,R]);
        CellA.CellGapX:=0;
        CellA.CellGapY:=0;

        case  Alignments[C,R] of
          taLeftJustify :CellA.CellAlig:=1;
          taCenter      :CellA.CellAlig:=2;
          taRightJustify:CellA.CellAlig:=3;
        end;

        if fsBold in FontStyles[C,R] then 
        begin
          CellA.IsfsBold:=True;
        end;
        CellA.FontSize:=FontSizes[C,R];
        CellA.FontName:=FontNames[C,R];

        if IsMergedCell(C,R) then
        begin
          if IsBaseCell(C,R) then
          begin
            CellA.CellGapX:=CellProperties[C,R].CellSpanX;
            CellA.CellGapY:=CellProperties[C,R].CellSpanY;
          end;
        end;

        CellA.ThisWidt:=CellSize(C,R).X;
        CellA.ThisHeig:=CellSize(C,R).Y;

        CellA.TopOrder:=RowOrder -1;
        CellA.TotlTopX:=TotalTopX;
        CellA.TotlLeft:=TotalLeft;

        AList.AddObject('',CellA);

        TotalTopX:=TotalTopX+RowHeights[R];
        Inc(RowOrder);
      end;
      
      TotalLeft:=TotalLeft+ColWidths[C];
    end;
  end;
end;

procedure TKzPrintEx.InitializeFileCache;
begin
  if MfrxReport=nil then
  begin
    MfrxReport:=TfrxReport.Create(nil);
  end;
  MfrxReport.LoadFromFile(FFileCache);

  FIsFileCacheInited:=True; 
end;

procedure TKzPrintEx.OnGetValue(const VarName: String; var Value: Variant);
var
  I:Integer;
begin
  if VarName='页面信息'      then
  begin
    Value:=Format('第%d页，共%d页',[FfrxReport.PreviewPages.Count,FfrxReport.Engine.TotalPages]);
  end;
  if VarName='第几页'        then Value:=FfrxReport.PreviewPages.Count;
  if VarName='共几页'        then Value:=FfrxReport.Engine.TotalPages;

  if (FListVariabl<>nil) and (FListVariabl.Count>0) then
  begin
    if (FListVariabl.IndexOfName(VarName)=-1) and (VarName<>'页面信息') and (VarName<>'第几页') and (VarName<>'共几页') then
    begin
      Value:=Format('[%S]',[VarName]);
      Exit;
    end;
    
    for I:=0 to FListVariabl.Count -1 do
    begin
      if VarName=FListVariabl.Names[I] then
      begin
        Value:=FListVariabl.ValueFromIndex[I];
      end;
    end;
  end;
end;

function TKzPrintEx.PreparX: Boolean;
var
  I,M,N:Integer;
  Valid:Boolean;
    
  PageCount:Integer;
  PageOrder:Integer;

  PageA:TfrxReportPage;
  HeadA:TfrxPageHeader;
  FootA:TfrxPageFooter;
  MastA:TfrxMasterData;
  ViewA:TfrxMemoView;

  CellA:TKzCellTextEx;

  //from mfrxreport
  PageX:TfrxReportPage;
  HeadX:TfrxPageHeader;
  FootX:TfrxPageFooter;
  MastX:TfrxMasterData;
  ViewX:TfrxMemoView;

  CellX:TKzCellTextEx;

  NewCellGapY:Integer;

  HeadStartPosY:Extended;
begin
  Result:=False;

  if FfrxReport=nil then
  begin
    FfrxReport:=TfrxReport.Create(nil);
  end;
  FfrxReport.Clear;
  FfrxReport.ShowProgress :=True;
  FfrxReport.EngineOptions.DoublePass:=True;
  FfrxReport.PrintOptions.ShowDialog :=True;

  if not FileExists(FFileCache) then
  begin
    FfrxReport.SaveToFile(FFileCache);
  end;

  if FIsDsgnMod then
  begin
    FfrxReport.LoadFromFile(FFileCache);
    SetfrxVariabl;    
    Result:=True;
    Exit;    
  end;

  if Assigned(OnKzPrintExGetListCellHead) then
  begin
    OnKzPrintExGetListCellHead(Self,FPrintIdentity,FListCellHead);
  end;
  if Assigned(OnKzPrintExGetListCellBody) then
  begin
    OnKzPrintExGetListCellBody(Self,FPrintIdentity,FListCellBody);
  end;

  PageCount:=GetPageCount;
  if PageCount=0 then
  begin
    ShowMessage('操作退出:打印页面为零.');
    Exit;
  end;
  
  for I:=1 to PageCount do
  begin
    PageA:=TfrxReportPage.Create(FfrxReport);
    //@PageA.CreateUniqueName;
    PageA.SetDefaults;

    //YXC_2014_08_05_10_42_37_copy_from_mfrxreport
    PageX:=TfrxReportPage(FindObject(fotPage));
    if PageX<>nil then
    begin
      PageA.Orientation :=PageX.Orientation;
      PageA.PaperSize   :=PageX.PaperSize;
      PageA.Font.Name   :=PageX.Font.Name;
      PageA.Font.Size   :=PageX.Font.Size;
      PageA.Font.Height :=PageX.Font.Height;
      PageA.Font.Charset:=PageX.Font.Charset;

      PageA.LeftMargin  :=PageX.LeftMargin;
      PageA.TopMargin   :=PageX.TopMargin;
      PageA.RightMargin :=PageX.RightMargin;
      PageA.BottomMargin:=PageX.BottomMargin;
    end;

    HeadX:=nil;
    HeadX:=TfrxPageHeader(FindObject(fotHead));
    if HeadX<>nil then
    begin
      HeadA:=TfrxPageHeader.Create(PageA);
      //@HeadA.CreateUniqueName;

      HeadA.Height:=HeadX.Height;

      //YXC_2014_08_06_11_07_29_<_copy_headx.objects to heada
      if (HeadX.Objects<>nil) and (HeadX.Objects.Count>0) then
      begin
        for M:=0 to HeadX.Objects.Count-1 do
        begin
          if TfrxComponent(HeadX.Objects.Items[M]) is TfrxMemoView then
          begin
            ViewX:=TfrxMemoView(HeadX.Objects.Items[M]);

            ViewA:=TfrxMemoView.Create(HeadA);
            CopyMemoInBand(ViewA,ViewX);
          end;
        end;
      end;
      //YXC_2014_08_06_11_07_29_>

      //YXC_2014_08_06_10_08_42_<_add_listcellhead_to_frxpageheader
      if (FListCellHead<>nil) and (FListCellHead.Count>0) then 
      begin
        HeadStartPosY:=HeadA.Height - (FTotalRowCountHead * FDefaultRowHeightHead);

        for M:=0 to FListCellHead.Count-1 do
        begin
          CellA:=TKzCellTextEx(FListCellHead.Objects[M]);
          if CellA=nil then Continue;

          AddChildInHead(HeadStartPosY,CellA,HeadA);
        end;
      end;  
      //YXC_2014_08_06_10_08_42_>
    end;

    FootX:=nil;
    FootX:=TfrxPageFooter(FindObject(fotFoot));
    if FootX<>nil then
    begin
      FootA:=TfrxPageFooter.Create(PageA);
      //@FootA.CreateUniqueName;

      FootA.Height:=FootX.Height;

      //YXC_2014_08_06_11_07_29_<_copy_footx.objects to foota
      if (FootX.Objects<>nil) and (FootX.Objects.Count>0) then
      begin
        for M:=0 to FootX.Objects.Count-1 do
        begin
          if TfrxComponent(FootX.Objects.Items[M]) is TfrxMemoView then
          begin
            ViewX:=TfrxMemoView(FootX.Objects.Items[M]);

            ViewA:=TfrxMemoView.Create(FootA);
            CopyMemoInBand(ViewA,ViewX);
          end;
        end;
      end;
      //YXC_2014_08_06_11_07_29_>      
    end;

    MastX:=nil;
    MastX:=TfrxMasterData(FindObject(fotMast));
    if MastX<>nil then
    begin
      MastA:=TfrxMasterData.Create(PageA);
      //@MastA.CreateUniqueName;
      MastA.RowCount:=1;

      MastA.Height:=FRowCountInPage * DefaultRowHeightBody;
    end;
    FListPages.AddObject(IntToStr(I),PageA);
  end;

  if FListCellBody.Count>0 then
  begin
    for I:=0 to FListCellBody.Count-1 do
    begin
      CellA:=TKzCellTextEx(FListCellBody.Objects[I]);
      if CellA=nil then Continue;

      PageOrder:=0;
      ViewA:=AddChildInMast(CellA,PageOrder);
      if PageOrder=-1 then Continue;

      //YXC_2014_08_05_13_50_17_<
      {if (CellA.TopOrder + CellA.CellGapY  + 1 ) > (PageOrder * FRowCountInPage) then
      begin
        CellX:=TKzCellTextEx.Create;
        TKzCellTextEx.CopyIt(CellA,CellX);
        FListCellGarb.AddObject('',CellX);

        //set new CellGapY after cut
        NewCellGapY :=FRowCountInPage * PageOrder - CellA.TopOrder - 1;
        ViewA.Height:=FDefaultRowHeightBody * (NewCellGapY +1);

        //important.text split
        ViewA.FPartMemo:=ViewA.Text;
        ViewA.SetDrawParams(FCanvas,1,1,0,0);
        ViewA.DrawPart;
        CellX.CellText:=ViewA.FPartMemo;

        //important.set new cellx postion.
        CellX.CellGapY:=CellA.CellGapY - (NewCellGapY + 1);
        CellX.RowOrder:=FRowCountInPage * PageOrder+1;
        CellX.TopOrder:=FRowCountInPage * PageOrder;

        AddChildInMast(CellX,PageOrder);
      end;}
      //YXC_2014_08_05_13_50_17_>

      //如果格子超出范围,逐步修正VIEWA.
      while (CellA.TopOrder + CellA.CellGapY  + 1 ) > (PageOrder * FRowCountInPage) do 
      begin
        CellX:=TKzCellTextEx.Create;
        TKzCellTextEx.CopyIt(CellA,CellX);
        FListCellGarb.AddObject('',CellX);

        //set new CellGapY after cut
        NewCellGapY :=FRowCountInPage * PageOrder - CellA.TopOrder - 1;
        ViewA.Height:=FDefaultRowHeightBody * (NewCellGapY +1);

        //important.text split
        ViewA.FPartMemo:=ViewA.Text;
        //ViewA.SetDrawParams(FCanvas,1,1,0,0);
        ViewA.DrawPart;
        CellX.CellText:=ViewA.FPartMemo;

        //important.set new cellx postion.
        CellX.CellGapY:=CellA.CellGapY - (NewCellGapY + 1);
        CellX.RowOrder:=FRowCountInPage * PageOrder+1;
        CellX.TopOrder:=FRowCountInPage * PageOrder;

        ViewA:=AddChildInMast(CellX,PageOrder);

        TKzCellTextEx.CopyIt(CellX,CellA);
      end;
    end;
  end;

  FfrxReport.OnGetValue:=OnGetValue;

  Result:=True;
end;

procedure TKzPrintEx.SetfrxVariabl;
var
  I:Integer;
  VarName:string;
begin
  FfrxReport.Variables.Clear;
  FfrxReport.Variables[' '+CONST_KZPRINT_SYSVARIABL]:=Null;

  FfrxReport.Variables.AddVariable(CONST_KZPRINT_SYSVARIABL,'页面信息','');
  FfrxReport.Variables.AddVariable(CONST_KZPRINT_SYSVARIABL,'第几页','');
  FfrxReport.Variables.AddVariable(CONST_KZPRINT_SYSVARIABL,'共几页','');

  if (FListVariabl<>nil) and (FListVariabl.Count>0) then
  begin
    FfrxReport.Variables[' '+CONST_KZPRINT_APPVARIABL]:=Null;
    for I:=0 to FListVariabl.Count -1 do
    begin
      VarName:=FListVariabl.Names[I];
      FfrxReport.Variables.AddVariable(CONST_KZPRINT_APPVARIABL,VarName,'');
    end;
  end;
end;

function TKzPrintEx.TstView: TfrxMemoView;
begin

end;

{ TKzCellTextEx }

class function TKzCellTextEx.CopyIt(
  AKzCellTextEx: TKzCellTextEx): TKzCellTextEx;
begin
  Result:=TKzCellTextEx.Create;
  TKzCellTextEx.CopyIt(AKzCellTextEx,Result);
end;

class procedure TKzCellTextEx.CopyIt(AKzCellTextEx: TKzCellTextEx;
  var Result: TKzCellTextEx);
begin
  Result.ColIndex:=AKzCellTextEx.ColIndex;
  Result.RowIndex:=AKzCellTextEx.RowIndex;
  Result.RowOrder:=AKzCellTextEx.RowOrder;
  Result.CellText:=AKzCellTextEx.CellText;
  Result.CellAlig:=AKzCellTextEx.CellAlig;
  Result.CellGapX:=AKzCellTextEx.CellGapX;
  Result.CellGapY:=AKzCellTextEx.CellGapY;
  Result.TopOrder:=AKzCellTextEx.TopOrder;
  Result.TotlTopX:=AKzCellTextEx.TotlTopX;
  Result.TotlLeft:=AKzCellTextEx.TotlLeft;
  Result.ThisWidt:=AKzCellTextEx.ThisWidt;
  Result.ThisHeig:=AKzCellTextEx.ThisHeig;

  //
  Result.IsfsBold:=AKzCellTextEx.IsfsBold;
  Result.FontName:=AKzCellTextEx.FontName;
  Result.FontSize:=AKzCellTextEx.FontSize;
end;

constructor TKzCellTextEx.Create;
begin
  IsfsBold:=False;
  FontName:='宋体';
  FontSize:=10;
end;

function TKzCellTextEx.GetStrIndex: string;
begin
  Result:=Format('%D-%D:%f,%f,thiswidt:%f,thisheig:%f,%S',[ColIndex,RowIndex,TotlTopX,TotlLeft,ThisWidt,ThisHeig,CellText]);
end;

end.

      {MastA:=nil;
      MastA:=FindMaster(CellA.RowOrder,PageOrder);
      if MastA=nil then Continue;
      
      ViewA:=TfrxMemoView.Create(MastA);
      ViewA.Height:=FDefaultRowHeightBody * (CellA.CellGapY+1);
      ViewA.Width :=CellA.ThisWidt;
      ViewA.Top   :=FDefaultRowHeightBody * (CellA.TopOrder) - (PageOrder-1) * FDefaultRowHeightBody * FRowCountInPage;
      ViewA.Left  :=CellA.TotlLeft;

      ViewA.Frame.Typ :=  [ftLeft, ftRight, ftTop, ftBottom];
      ViewA.Font.Name :=  '宋体';
      ViewA.Font.Size :=  10;
      ViewA.Font.Charset:=1;
      ViewA.Font.Height:=-13;
      
      ViewA.HAlign:=haLeft;
      ViewA.VAlign:=vaTop;

      ViewA.Text  :=CellA.CellText;}

      //YXC_2014_08_05_14_26_22_<
      {MastA:=nil;
      MastA:=FindMaster(CellX.RowOrder,PageOrder);
      if MastA=nil then Continue;
      
      ViewA:=TfrxMemoView.Create(MastA);
      ViewA.Height:=FDefaultRowHeightBody * (CellX.CellGapY+1);
      ViewA.Width :=CellX.ThisWidt;
      ViewA.Top   :=FDefaultRowHeightBody * (CellX.TopOrder) - (PageOrder-1) * FDefaultRowHeightBody * FRowCountInPage;
      ViewA.Left  :=CellX.TotlLeft;

      ViewA.Frame.Typ :=  [ftLeft, ftRight, ftTop, ftBottom];
      ViewA.Font.Name :=  '宋体';
      ViewA.Font.Size :=  10;
      ViewA.Font.Charset:=1;
      ViewA.Font.Height:=-13;
      
      ViewA.HAlign:=haLeft;
      ViewA.VAlign:=vaTop;

      ViewA.Text  :=CellX.CellText;}
      //YXC_2014_08_05_14_26_22_>

      {if DebugHook=1 then
      begin
        ViewA:=TfrxMemoView.Create(MastA);
        ViewA.CreateUniqueName;
        ViewA.Frame.Typ := [ftLeft,ftBottom,ftRight,ftTop];
        ViewA.Align     := baClient;
        ViewA.Text:='mast';
        ViewA.Frame.Color:=clRed;      
      end;}

      {if DebugHook=1 then
      begin
        ViewA:=TfrxMemoView.Create(FootA);
        ViewA.CreateUniqueName;
        ViewA.Frame.Typ := [ftLeft,ftBottom,ftRight,ftTop];
        ViewA.Align     := baClient;
        ViewA.Text:='foot';
        ViewA.Frame.Color:=clRed;
      end;}

      {if DebugHook=1 then
      begin
        ViewA:=TfrxMemoView.Create(HeadA);
        ViewA.CreateUniqueName;
        ViewA.Frame.Typ := [ftLeft,ftBottom,ftRight,ftTop];
        ViewA.Align     := baClient;
        ViewA.Text:='head';
        ViewA.Frame.Color:=clRed;
      end;}
      
      {Valid:=False;
      if Assigned(OnKzPrintExWhichColumnJoinTextSplit) then
      begin
        OnKzPrintExWhichColumnJoinTextSplit(Self,CellA.ColIndex,Valid);
      end;
      if Valid then
      begin
        CellX.CellText:='after';
        KzDebug.FileFmt('%F:%F:%F:%F',[ViewA.Width,ViewA.Height,ViewA.CalcHeight,ViewA.CalcWidth]);
      end else
      begin
        CellX.CellText:='';
      end;}

      {if IsMergedCell(C,R) then
      begin
        if not IsBaseCell(C,R) then Continue;
      end;

      CellA:=TKzCellTextEx.Create;
      CellA.ColIndex:=C;
      CellA.RowIndex:=R;
      CellA.RowOrder:=RowOrder;
      CellA.CellText:=Format('cell:%d:%d',[C,R]);
      CellA.CellText:=Trim(Cells[C,R]);
      CellA.CellAlig:=1;
      CellA.CellGapX:=0;
      CellA.CellGapY:=0;

      if IsMergedCell(C,R) then
      begin
        if IsBaseCell(C,R) then
        begin
          CellA.CellGapX:=CellProperties[C,R].CellSpanX;
          CellA.CellGapY:=CellProperties[C,R].CellSpanY;
        end;
      end;

      CellA.ThisWidt:=CellSize(C,R).X;
      CellA.ThisHeig:=CellSize(C,R).Y;

      CellA.TopOrder:=RowOrder -1;
      CellA.TotlTopX:=TotalTopX;
      CellA.TotlLeft:=TotalLeft;

      AList.AddObject('',CellA);}

      {ViewA.Left  := ViewX.Left;
      ViewA.Top   := ViewX.Top;
      ViewA.Height:= ViewX.Height;
      ViewA.Width := ViewX.Width;
      ViewA.Frame.Typ := ViewX.Frame.Typ;
      ViewA.Text  := ViewX.Text;
      ViewA.VAlign:= ViewX.VAlign;
      ViewA.HAlign:= ViewX.HAlign;
      ViewA.Font.Name := ViewX.Font.Name;
      ViewA.Font.Size := ViewX.Font.Size;
      ViewA.Font.Charset:=ViewX.Font.Charset;}

      //deprecated
      {FRowHeadStart:Integer;              //表头起始
      FRowHeadEnded:Integer;              //表头结束

      FRowBodyStart:Integer;              //表体起始
      FRowBodyEnded:Integer;              //表体结束}      
