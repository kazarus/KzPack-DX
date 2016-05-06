unit Class_KzPrint;
//YXC_2012_12_05_22_08_24_modify_name_to_class_kzprint.
//YXC_2012_12_20_16_34_30_remove_printmode.
//YXC_2012_12_21_09_20_17_add_onkzprintgridvalidrows&onkzprintgridvalidcols
//YXC_2013_03_18_16_27_47_add_breakmodel.
//YXC_2013_03_18_16_27_47_add_executemultihead

//notes:
//the breakmodal only support execute method.

//notes:
//the exportx method need code like this:
//frxreport1 can not be empty,less one page.
//frxreport1.preparereport();
//frxreport:=kzprint.exportx;
//frxreport1.previewpages.addfrom(frxreport);
//frxreport1.previewpages.deletepage(0);
//frxreport1.showpreparedreport;

interface
uses
  SysUtils,AdvGrid,frxClass,frxDesgn,Classes,XMLDoc,XMLIntf,Dialogs,frxXML,
  frxXMLSerializer,Graphics,Variants,frxExportPDF;

type
  TPrintOrder = (poColFirst,poRowFirst);  //(Default) poColFirst,poRowFirst
  TBreakModel = (bmPagBreak,bmRowBreak);  //(Default) bmPagBreak,bmRowBreak  

  TKzCellText =class(TObject) //from tadvstringrid                 
  public
    Idex:Integer;
    Text:string;      //FieldX
    Titl:string;      //Cells[FieldX,I]
    Widt:Extended;    //width,if width=0 it would not be print.
    High:Extended;    //*new:Height.
    Left:Extended;    //*new:Left.
    Fill:Boolean;     //if filled.
    Alig:Integer;     //alignment
    Scal:Extended;    //scale,for zoom.
    GapX:Integer;     //*new
    GapY:Integer;     //*new
    PagX:Integer;     //*new
    TopX:Extended;    //*new

    TestFill:Boolean; //text if filled.
    TestHide:Boolean; //if testhide=true,it would not be init.
    AutoNumb:Boolean; //automate number index
    RowIndex:Integer; //*new
    ColIndex:Integer; //*new
  public
    function  GetStrIndex:string;
    class function  CopyIt(AKzCellText:TKzCellText):TKzCellText;overload;
    class procedure CopyIt(AKzCellText:TKzCellText;var Result:TKzCellText);overload;
  end;


  TKzPageCutX =class(TObject)
  public
    PageIdex:Integer;
    PageWidt:Extended;     //all page width.
    PageCutX:Extended;     //cut point.

    PagePrev:Extended;     //begin
    PageNext:Extended;     //end
  public
    function GetStrIndex:string;  
  end;

  
  TKzTreeList=class(TObject)
  private
    ListItem:TStringList;//list of tkztreeitem
  public
    procedure AddObject(ARowIndex:Integer;AObject:TObject);
    procedure InsertObj(ARowIndex:Integer;AObject:TObject;ALockCount:Integer=0);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TKzTreeItem=class(TStringList)
  public
    RowIndex:Integer;
  public
    constructor Create;
    destructor Destroy; override;
  end;
  
  TKzCellView =class(TObject)//from kzprint.fr3
  public
    PrevCont:string;//上级容器类型
    PrevName:string;//上级容器名称
    
    ViewName:string;//对象名称,lineview or memoview ,like this
    ViewText:string;//对象文本

    ViewLeft:Extended;
    ViewWidt:Extended;
    ViewTop :Extended;
    ViewHeig:Extended;

    FontName:string;
    FontHeig:Integer;
    FontStyl:string; //0:normal|1:fsbold
    FontColr:Integer;//Colour
    FCharset:Integer;

    FramType :string;
    FramStyl :string;
    VAlign   :string;
    HAlign   :string;
    AutoWidt :Boolean;//自动宽度
    //YXC_2010_06_17_10_00_12
    Align    :string;
    AutoFontSize:Boolean;//
    CharSpacing :Integer;//
  public
    constructor Create;
  end;


  TKzPrintGridValidRows=procedure (Sender: TObject; AActvGrid:TAdvStringGrid;ARow:Integer;var Valid:Boolean) of object;
  //procedure OnKzPrintGridValidRows(Sender: TObject; AActvGrid:TAdvStringGrid;ARow:Integer;var Valid:Boolean);
  TKzPrintGridValidCols=procedure (Sender: TObject; AActvGrid:TAdvStringGrid;ACol:Integer;var CellA:TKzCellText) of object;
  //procedure OnKzPrintGridValidCols(Sender: TObject; AActvGrid:TAdvStringGrid;ACol:Integer;var CellA:TKzCellText);

    
  TKzPrint=class(TObject)
  private
    LockWidth :Extended;//锁定列宽度
    FreeWidth :Extended;//自由宽度
    TotlWidth :Extended;//表格总宽度
    RealWidth :Extended;//实际可以被填充宽度 factwidth - lockwidht
    FactWidth :Extended;//实际页面宽度,PaperWidt - margleft - margrigh
    
    FListRows :TStringList;    //rows is valid.
    FListCols :TStringList;    //cols is valid.
    FListPage :TStringList;    //page onenddoc.list of tfrxreportpage.
    
    FListCell :TStringList;    //cell of ui.grids.it included all grid's cellproperty at therowmostdetailed.
    FListView :TStringList;    //view of fr3.xml.element.etc(tfrxmemoview,tfrxlineview)
    FListCutX :TStringList;    //list of tkzpagecutx.

    FfrxReport :TfrxReport;
    FPageCount :Integer;
    FUseDataSet:TfrxUserDataSet;

    //YXC_2010_05_24_11_32_33
    HeadCellHeig:Extended;
    HeadCellLeft:Extended;
    HeadCellTop :Extended;

    BodyCellHeig:Extended;
    BodyCellLeft:Extended;
    BodyCellTop :Extended;

    //YXC_2010_05_24_16_14_37_标题高度(TitlHeig)
    TitlHeig:Extended;
    HeadHeig:Extended;
    FootHeig:Extended;
    MastHeig:Extended;
    
    //YXC_2010_05_24_16_51_31_页面参数(Paper Params)
    PaperWidt:Extended; //纸张宽度
    PaperSize:Integer;  //纸张大小
    PaperHeig:Extended; //纸张高度
    
    MargLeft:Extended;  //左边距
    MargRigh:Extended;  //右边距
    MargTop :Extended;  //上边距
    MargBott:Extended;  //下边距
    Orientation:string; //横纵向

    FTreeCellWhenMultiHead:TKzTreeList;
    
    FListVariabl:TStringList; //变量列表
  public
    SourceGrid  :TAdvStringGrid;
    FFilePath   :string;
    FBackMark   :string;
    LockCount   :Integer;//锁定列数

    //YXC_2011_09_19_15_41_00
    FColStart   :Integer;//起始列
    FRowTitle   :Integer;//标题行
    
    FRowBodyStart      :Integer;//the start line of body.
    FRowBodyEnd        :Integer;//the end   line of body.

    FTheRowMostDetailed:Integer;//*new:like his name.
    FRowHeadStart      :Integer;//*new:the start line of head
    FRowHeadEnd        :Integer;//*new:the end   line of head

    FTotlCount  :Integer;      //表格列数.SourceGrid.TotalColCount
    FPrintOrder :TPrintOrder;  //打印顺序
    FBreakModel :TBreakModel;  //折页模式

    BoolCutZero :Boolean;
    BoolCutMark :Boolean;
    BoolDesigMod:Boolean;

    BoolPageCent:Boolean;     //页面是否居中

    BoolHeadSize:Boolean;     //BoolHeadContAutoFontSize
    BoolBodySize:Boolean;     //BoolBodyContAutoFontSize
    
    BoolReadFromCnfg:Boolean; //读取conf,还是读取*.fr3
    BoolUseFieldCell:Boolean; //variable.name is named by field%d.otherwise,use the cells[x,frowtitle]

    CharLinkPrevPage:string;  //*new like his name.it active only whenmultihead.
  public
    OnKzPrintGridValidRows:TKzPrintGridValidRows;
    OnKzPrintGridValidCols:TKzPrintGridValidCols;
  protected
    procedure SetCellTextParams;
    procedure SetCellTextParamsWhenMultiHead;    //just for fill head 
    procedure SetCellPostParamsWhenMultiHead;    //deal cell.pagx and cella.postion property.
    function  GetTopCellRect(AColIndex,ARowIndex:Integer):Extended;
    function  GetLefCellRect(AColIndex,ARowIndex:Integer):Extended;

    procedure SetCellViewParams;                 //read xml from *.fr3

    function  GetPageCountEx:Integer;
    function  GetPageCountWhenMultiHead:Integer;

    procedure SetUseDataSet;
    procedure SetValidRows;
    procedure SetValidCols;
    
    procedure OnUseDataSetGetValue(const VarName: String;var Value: Variant);
    
    procedure SetfrxVariabl;
    procedure OnGetValue(const VarName: String;var Value: Variant);
    
    procedure OnEndDoc(Sender: TObject);
    procedure OnfrxReportBeforePrint(Sender: TfrxReportComponent);

    function  GetPageInfoAfterCutted:string;

    function  GetLineStyle(AValue:string):TfrxFrameStyle;
    function  GetMemoHAlig(AValue:string):TfrxHAlign;
    function  GetMemoVAlig(AValue:string):TfrxVAlign;
    function  GetMemoAlign(AValue:string):TfrxAlign;
    function  GetFrameType(AValue:Integer):TfrxFrameTypes;
  protected
    function PreparX:Boolean;
    function PrepareMultiHead:Boolean;
  public
    procedure PushVariable(AVarName,Value:string);overload;
    procedure PushVariable(AValueInFormat:string);overload;
  public
    function DesignX:Boolean;

    function Execute:Boolean;
    function ExportX:TfrxReport;            //loke same as execute method,just return tfrxreport
    
    function ExecuteMultiHead:Boolean;
    function ExportxMultiHead:TfrxReport;   //loke same as execute method,just return tfrxreport
  public
    constructor Create;
    destructor  Destroy; override;
  end;

var
  KzPrint:TKzPrint;

const
  CONST_KZPRINT_SYSVARIABL='KzPrint.系统变量';
  CONST_KZPRINT_APPVARIABL='KzPrint.程序变量';  

implementation

uses
  Printers,Class_KzUtils,Forms,Class_KzDebug;


constructor TKzPrint.Create;
begin
  FfrxReport :=TfrxReport.Create(nil);
  FUseDataSet:=TfrxUserDataSet.Create(nil);

  FPrintOrder:=poColFirst;//Default
  FBreakModel:=bmPagBreak;//Default
    
  BoolReadFromCnfg:=True;
  BoolUseFieldCell:=False;
  
  TitlHeig:=-1;
  HeadHeig:=-1;
  FootHeig:=-1;

  FListCutX:=nil;
  FListCell:=nil;
  FTreeCellWhenMultiHead:=nil;

  FTotlCount   :=-1;
  FRowBodyStart:=1;
  FRowBodyEnd  :=-1;
  
  FRowHeadStart:=-1;
  FRowHeadEnd  :=-1;

  CharLinkPrevPage:='<-';
end;

function TKzPrint.DesignX: Boolean;
begin
  if not FileExists(FFilePath) then
  begin
    ShowMessage('模板文件不存在');
    Exit;
  end;

  FfrxReport.LoadFromFile(FFilePath);
  SetfrxVariabl;
  FfrxReport.DesignReport();
end;

destructor TKzPrint.Destroy;
begin
  FreeAndNil(FfrxReport);
  if FUseDataSet<>nil then
  begin
    FreeAndNil(FUseDataSet);
  end;
  if FListRows<>nil then
  begin
    FreeAndNil(FListRows);
  end;  
  if FListVariabl<>nil then
  begin
    FreeAndNil(FListVariabl);
  end;
  if FListPage<>nil then
  begin
    TKzUtils.TryFreeAndNil(FListPage);
  end;
  if FListCell<>nil then
  begin
    TKzUtils.TryFreeAndNil(FListCell);
  end;
  if FListView<>nil then
  begin
    TKzUtils.TryFreeAndNil(FListView);
  end;

  if FTreeCellWhenMultiHead<>nil then
  begin
    FreeAndNil(FTreeCellWhenMultiHead);
  end;

  if FListCutX<>nil then TKzUtils.TryFreeAndNil(FListCutX);

  inherited;
end;

function TKzPrint.Execute: Boolean;
begin
  if not PreparX then Exit;

  if BoolDesigMod then
  begin
    FfrxReport.DesignReport();
  end else
  begin
    FfrxReport.ShowReport();
  end;
end;

function TKzPrint.ExecuteMultiHead: Boolean;
begin
  if not PrepareMultiHead then Exit;
  
  if BoolDesigMod then
  begin
    FfrxReport.DesignReport();
  end else
  begin
    FfrxReport.ShowReport();
  end;
end;

function TKzPrint.ExportX: TfrxReport;
begin
  if not PreparX then Exit;
  FfrxReport.PrepareReport(True);
  Result:=FfrxReport;
end;

function TKzPrint.GetFrameType(AValue: Integer): TfrxFrameTypes;
type
  PfrxFrameTypes = ^ TfrxFrameTypes;
var
  dst: TfrxFrameTypes;
  src:  Integer;
begin
  src := AValue;
  dst := PfrxFrameTypes(@src)^;
  //Typ := dst;
  Result := dst;
end;

function TKzPrint.GetLineStyle(AValue: string): TfrxFrameStyle;
begin
  Result:=fsSolid;
  if AValue='fsSolid' then
  begin
    Result:=fsSolid;
  end else
  if AValue='fsDash' then
  begin
    Result:=fsDash;
  end else
  if AValue='fsDot' then
  begin
    Result:=fsDot;
  end else
  if AValue='fsDashDot' then
  begin
    Result:=fsDashDot;
  end else
  if AValue='fsDashDotDot' then
  begin
    Result:=fsDashDotDot;
  end else
  if AValue='fsDouble' then
  begin
    Result:=fsDouble;
  end else
  if AValue='fsAltDot' then
  begin
    Result:=fsAltDot;
  end else
  if AValue='fsSquare' then
  begin
    Result:=fsSquare;
  end;
end;

function TKzPrint.GetMemoAlign(AValue: string): TfrxAlign;
begin
  Result:=baNone;
  if AValue='baBottom' then
  begin
    Result:=baBottom;
  end else
  if AValue='baCenter' then
  begin
    Result:=baCenter;
  end else
  if AValue='baClient' then 
  begin
    Result:=baClient;
  end else
  if AValue='baLeft' then 
  begin
    Result:=baLeft;
  end else
  if AValue='baNone' then
  begin
    Result:=baNone;
  end else
  if AValue='baRight' then
  begin
    Result:=baRight;
  end else
  if AValue='baWidth' then
  begin
    Result:=baWidth;
  end;  
end;

function TKzPrint.GetMemoHAlig(AValue: string): TfrxHAlign;
begin
  Result:=haCenter;
  if AValue='haCenter' then
  begin
    Result:=haCenter;
  end else
  if AValue='haLeft' then
  begin
    Result:=haLeft;
  end else
  if AValue='haRight' then
  begin
    Result:=haRight;
  end else
  if AValue='haBlack' then
  begin
    Result:=haBlock;
  end;
end;

function TKzPrint.GetMemoVAlig(AValue: string): TfrxVAlign;
begin
  Result:=vaCenter;
  if AValue='vaCenter' then
  begin
    Result:=vaCenter;
  end else
  if AValue='vaTop' then
  begin
    Result:=vaTop;
  end else
  if AValue='vaBottom' then
  begin
    Result:=vaBottom;
  end;  
end;

function TKzPrint.GetPageCountWhenMultiHead: Integer;
var
  I:Integer;
  CellA:TKzCellText;
  DoubA:Extended;
  PosxA:Extended;
  PosxB:Extended;
  TotlA:Extended;
  CutxA:TKzPageCutX;
begin
  Result:=1;

  FactWidth:=(PaperWidt - MargLeft - MargRigh ) * 3.78;

  if FListCutX=nil then
  begin
    FListCutX:=TStringList.Create;
  end;
  
  if FBreakModel=bmPagBreak then
  begin
    DoubA:=(PaperWidt - MargLeft - MargRigh ) * 3.78 - LockWidth;
    PosxA:=0;
    PosxB:=0;
    TotlA:=0;
    for I:=LockCount to FListCell.Count-1 do
    begin
      CellA:=nil;
      CellA:=TKzCellText(FListCell.Objects[I]);
      if CellA=nil then Continue;

      PosxA:=PosxA+CellA.Widt;
      PosxB:=PosxB+CellA.Widt;
      
      if PosxA >= DoubA then      //begin new page.
      begin
        CellA.PagX:=Result;

        //YXC_2013_11_04_17_13_35_<         
        CutxA:=TKzPageCutX.Create;
        CutxA.PageIdex:=Result;

        if PosxA - CellA.Widt < DoubA then
        begin
          CutxA.PageWidt:=DoubA;
        end else
        begin
          CutxA.PageWidt:=PosxA - CellA.Widt;
        end;  

        CutxA.PageCutX:=PosxA-CellA.Widt;

        CutxA.PagePrev:=TotlA;
        CutxA.PageNext:=CutxA.PageCutX+TotlA;

        FListCutX.AddObject(IntToStr(CutxA.PageIdex),CutxA);

        KzDebug.FileLog(CutxA.GetStrIndex);
        //YXC_2013_11_04_17_13_35_>

        Inc(Result);
        TotlA:=CutxA.PageCutX+TotlA;

        PosxA:=CellA.Widt;
      end;
    end;
  end;

  //YXC_2013_11_07_09_25_28_<
  CutxA:=TKzPageCutX.Create;
  CutxA.PageIdex:=Result;
  CutxA.PageWidt:=DoubA;
  CutxA.PageCutX:=DoubA;
  CutxA.PagePrev:=TotlA;
  CutxA.PageNext:=TotlA+DoubA;
  FListCutX.AddObject(IntToStr(CutxA.PageIdex),CutxA);
  KzDebug.FileLog(CutxA.GetStrIndex);  
  //YXC_2013_11_07_09_25_28_>

  FPageCount:=Result;
end;

function TKzPrint.GetPageCountEx: Integer;
var
  I:Integer;
  CellA:TKzCellText;
  DoubA:Extended;
  PosxA:Extended;
begin
  Result:=1;

  FactWidth:=(PaperWidt - MargLeft - MargRigh ) * 3.78;

  if FBreakModel=bmPagBreak then
  begin
    DoubA:=(PaperWidt - MargLeft - MargRigh ) * 3.78 - LockWidth;
    PosxA:=0;
    for I:=LockCount to FListCell.Count-1 do
    begin
      CellA:=nil;
      CellA:=TKzCellText(FListCell.Objects[I]);
      if CellA=nil then Continue;

      PosxA:=PosxA+CellA.Widt;
      if PosxA >= DoubA then
      begin
        CellA.PagX:=Result;

        Inc(Result);

        PosxA:=CellA.Widt;
      end;
    end;
  end;

  FPageCount:=Result;
end;

function TKzPrint.GetPageInfoAfterCutted: string;
var
  CuttPage:Integer;//分页号
  Temp    :Extended;
  ActvPage:Integer;//分子页
  TotlPage:Integer;//共几页
begin
  Result:='第%d--%d/%d页（共%d页）';
  TotlPage:=FfrxReport.Engine.TotalPages div FPageCount;

  if FfrxReport.PreviewPages.Count <= TotlPage then
  begin
    CuttPage:=FfrxReport.PreviewPages.Count;
    ActvPage:=1;
  end else
  begin
    if TotlPage<>0 then
    begin
      CuttPage:=FfrxReport.PreviewPages.Count mod TotlPage;
      ActvPage:=FfrxReport.PreviewPages.Count div TotlPage;
    end;
    if CuttPage=0 then
    begin
      CuttPage:=TotlPage;
    end else
    begin
      Inc(ActvPage);
    end;
  end;

  Result:=Format(Result,[CuttPage,ActvPage,FPageCount,TotlPage]);
end;

procedure TKzPrint.OnEndDoc(Sender: TObject);
var
  I,M,N:Integer;
  NumbA:Integer;
  ListA:TStringList;
  NumbB:Integer;
  TempA:string;

  PageA:TfrxReportPage;
  PageB:TfrxReportPage;
  StrmA:TMemoryStream;
  //ListB:TStringList;
  IdexA:Integer;
begin
  ListA:=TStringList.Create;
  
  NumbA:=FfrxReport.Engine.TotalPages div FPageCount;
  for M:=0 to NumbA-1 do
  begin
    for N:=0 to FPageCount-1 do
    begin
      NumbB:=M + N * NumbA +1;
      ListA.Add(IntToStr(NumbB));
    end;
  end;


  if FListPage<>nil then
  begin
    TKzUtils.TryFreeAndNil(FListPage);
  end;  
  FListPage:=TStringList.Create;
  for I:=0 to FfrxReport.PreviewPages.Count-1 do
  begin
    StrmA:=TMemoryStream.Create;

    PageB:=FfrxReport.PreviewPages.Page[I];
    PageB.SaveToStream(StrmA);
    
    StrmA.Position:=0;
    PageA:=TfrxReportPage.Create(nil);
    PageA.LoadFromStream(StrmA);

    FListPage.AddObject(IntToStr(I+1),PageA);
    StrmA.Free;
  end;

  //for I:=ListA.Count-1 downto 0 do
  for I:=0 to ListA.Count-1 do 
  begin
    TempA:=ListA.Strings[I];
    
    IdexA:=-1;
    IdexA:=FListPage.IndexOf(TempA);

    FListPage.Move(IdexA,I);
  end;
  FreeAndNil(ListA);


  for I:=0 to FListPage.Count-1 do
  begin
    PageA:=nil;
    PageA:=TfrxReportPage(FListPage.Objects[I]);
    if PageA=nil then Continue;
    FfrxReport.PreviewPages.ModifyPage(I,PageA);
  end;
  //YXC_2014_08_01_14_24_15
  //FfrxReport.Preview.Init;
end;

procedure TKzPrint.OnfrxReportBeforePrint(Sender: TfrxReportComponent);
begin

end;

procedure TKzPrint.OnGetValue(const VarName: String; var Value: Variant);
var
  I:Integer;
begin
  if VarName='页面信息'      then
  begin
    Value:=Format('第%d页，共%d页',[FfrxReport.PreviewPages.Count,FfrxReport.Engine.TotalPages]);
    
    //YXC_2012_12_21_10_12_32_keep_a_version
    {if FPageCount=1 then
    begin
    end else
    begin
      Value:=GetPageInfoAfterCutted;
    end;}
  end;

  if VarName='分页信息/分页' then
  begin
    begin
      if FPageCount=1 then
      begin
        Value:=Format('第%d页，共%d页',[FfrxReport.PreviewPages.Count,FfrxReport.Engine.TotalPages]);
      end else
      begin
        Value:=GetPageInfoAfterCutted;
      end;
    end;
  end;

  if VarName='第几页'        then Value:=FfrxReport.PreviewPages.Count;
  if VarName='共几页'        then Value:=FfrxReport.Engine.TotalPages;


  if (FListVariabl<>nil) and (FListVariabl.Count>0) then
  begin
    for I:=0 to FListVariabl.Count -1 do
    begin
      if VarName=FListVariabl.Names[I] then
      begin
        Value:=FListVariabl.ValueFromIndex[I];
      end;
      //WritelnFmt('%S|%S',[varname,Value]);
    end;    
  end;
end;

procedure TKzPrint.OnUseDataSetGetValue(const VarName: String;
  var Value: Variant);
var
  I    :Integer;
  RowxA:Integer;
  CellA:TKzCellText;
  TempA:string;
begin
  for I:=0 to FListCell.Count-1 do  
  begin
    CellA:=TKzCellText(FListCell.Objects[I]);

    if CellA.AutoNumb then
    begin
      if VarName=CellA.Text then Value:=FUseDataSet.RecNo+1;
    end else
    begin
      RowxA:=StrToIntDef(FListRows.Strings[FUseDataSet.RecNo],0);
      TempA:=SourceGrid.Cells[CellA.Idex,RowxA];

      if BoolCutMark then
      begin
        TempA:=TKzUtils.StrxCutMark(TempA);
      end;  

      if BoolCutZero then
      begin
        TempA:=TKzUtils.StrxCutZero(TempA);
      end;

      if VarName=CellA.Text then Value:=TempA;
    end;    
  end;
end;

procedure TKzPrint.SetCellTextParams;
var
  I       :Integer;
  CellA   :TKzCellText;
  DecCount:Integer;  
begin
  LockWidth:=0;
  TotlWidth:=0;
  DecCount :=0;

  if FListCell<>nil then
  begin
    TKzUtils.TryFreeAndNil(FListCell);
  end;

  if FTotlCount=-1 then
  begin
    FTotlCount:=SourceGrid.TotalColCount;
  end;
  
  FListCell:=TStringList.Create;
  with SourceGrid do
  begin
    for I:=FColStart to FTotlCount-1  do
    begin

      CellA:=TKzCellText.Create;
      CellA.Idex:=I;

      CellA.Titl:=Cells[I,FRowTitle];
      
      if BoolUseFieldCell then
      begin
        CellA.Text:=Format('FIELD%D',[I]);    //YXC_2014_07_08_11_38_31_ERROR
      end else
      begin
        CellA.Text:=Cells[I,FRowTitle];
      end;

      case Alignments[I,FRowBodyStart] of   //表体列
        taLeftJustify :CellA.Alig:=1;
        taCenter      :CellA.Alig:=2;
        taRightJustify:CellA.Alig:=3;
      end;

      if IsHiddenColumn(I) then
      begin
        Inc(DecCount);
        CellA.Widt:=0;
      end else
      begin
        CellA.Widt:=ColWidths[I-DecCount];
      end;

      if Assigned(OnKzPrintGridValidCols) then
      begin
        OnKzPrintGridValidCols(Self,SourceGrid,I,CellA);
      end;

      if CellA.Widt=0 then
      begin
        FreeAndNil(CellA);
        Continue;
      end;  

      TotlWidth :=TotlWidth + CellA.Widt;
      //CellA.Text+IntTostr(CellA.Widt)
      FListCell.AddObject(Format('%S:%F',[CellA.Text,CellA.Widt]),CellA);
    end;
    
    //YXC_2010_05_26_19_49_06_锁定列宽
    for I:=0 to LockCount-1 do
    begin
      CellA:=TKzCellText(FListCell.Objects[I]);
      LockWidth:=LockWidth+CellA.Widt;
    end;
  end;
end;


procedure TKzPrint.SetCellTextParamsWhenMultiHead;
var
  I,M,X   :Integer;
  Y       :Extended;
  CellA   :TKzCellText;
  //DecCount:Integer;  
begin
  //LockWidth:=0;
  //TotlWidth:=0;
  //DecCount :=0;
  if FTreeCellWhenMultiHead<>nil then
  begin
    TKzUtils.TryFreeAndNil(FTreeCellWhenMultiHead);
  end;
  FTreeCellWhenMultiHead:=TKzTreeList.Create;

  if FRowHeadStart=-1 then raise Exception.Create('NOT SUPPORT THIS METHOD:[TKzPrint.SetCellTextParamsWhenMultiHead] AT [Class_KzPrint.pas]');
  if FRowHeadEnd  =-1 then raise Exception.Create('NOT SUPPORT THIS METHOD:[TKzPrint.SetCellTextParamsWhenMultiHead] AT [Class_KzPrint.pas]');

  if FTotlCount=-1 then
  begin
    FTotlCount:=SourceGrid.TotalColCount;
  end;
    
  with SourceGrid do
  begin
    for I:=FRowHeadStart to FRowHeadEnd  do
    begin
      Y:=0;
      for M:=FColStart to FTotlCount-1 do 
      begin
        if IsMergedCell(M,I) then
        begin
          if IsBaseCell(M,I) then
          begin
            CellA:=TKzCellText.Create;
            CellA.Idex:=X;
            CellA.Text:=Cells[M,I];

            CellA.Widt:=CellSize(M,I).X;
            CellA.High:=CellSize(M,I).Y;
            CellA.Left:=Y;
            CellA.Alig:=-1;
            CellA.ColIndex:=M;
            CellA.RowIndex:=I;
            CellA.PagX    :=-1;

            //if use grid.alignment.
            {case Alignments[M,I] of
              taLeftJustify :CellA.Alig:=1;
              taCenter      :CellA.Alig:=2;
              taRightJustify:CellA.Alig:=3;
            end;}

            CellA.GapX    :=CellProperties[M,I].CellSpanX;
            CellA.GapY    :=CellProperties[M,I].CellSpanY;
            CellA.TopX    :=GetTopCellRect(M,I);
            CellA.Left    :=GetLefCellRect(M,I);

            FTreeCellWhenMultiHead.AddObject(CellA.RowIndex,CellA);

            Y:=Y+CellA.Widt;
          end else
          begin
            CellA:=TKzCellText.Create;
            CellA.Idex:=X;
            CellA.Text:=Cells[M,I];

            CellA.Widt:=CellSize(M,I).X;
            CellA.High:=CellSize(M,I).Y;
            CellA.Left:=Y;
            CellA.Alig:=-1;
            CellA.ColIndex:=M;
            CellA.RowIndex:=I;
            CellA.PagX    :=-1;
            
            //if use grid.alignment.
            {case Alignments[M,I] of
              taLeftJustify :CellA.Alig:=1;
              taCenter      :CellA.Alig:=2;
              taRightJustify:CellA.Alig:=3;
            end;}
            
            CellA.GapX    :=CellProperties[M,I].CellSpanX;
            CellA.GapY    :=CellProperties[M,I].CellSpanY;
            CellA.TopX    :=GetTopCellRect(M,I);
            CellA.Left    :=GetLefCellRect(M,I);
            CellA.TestHide:=True;

            if CellProperties[M,I].CellSpanY<>0 then
            begin
              CellA.Widt    :=ColWidths[M];
            end else
            begin
              CellA.Widt    :=0;
            end; 

            FTreeCellWhenMultiHead.AddObject(CellA.RowIndex,CellA);

            Y:=Y+CellA.Widt;
          end;
        end else
        begin
          CellA:=TKzCellText.Create;
          CellA.Idex:=X;
          CellA.Text:=Cells[M,I];

          CellA.Widt:=CellSize(M,I).X;
          CellA.High:=CellSize(M,I).Y;
          CellA.Left:=Y;
          CellA.Alig:=-1;
          
          //if use grid.alignment.
          {case Alignments[M,I] of
            taLeftJustify :CellA.Alig:=1;
            taCenter      :CellA.Alig:=2;
            taRightJustify:CellA.Alig:=3;
          end;}
                    
          CellA.ColIndex:=M;
          CellA.RowIndex:=I;
          CellA.PagX    :=-1;
          CellA.GapX    :=CellProperties[M,I].CellSpanX;          
          CellA.GapY    :=CellProperties[M,I].CellSpanY;
          CellA.TopX    :=GetTopCellRect(M,I);
          CellA.Left    :=GetLefCellRect(M,I);            

          FTreeCellWhenMultiHead.AddObject(CellA.RowIndex,CellA);          

          Y:=Y+CellA.Widt;
        end;
      end;
      Inc(X);
    end;
  end;
end;

procedure TKzPrint.SetCellViewParams;
var
  frxXML:TfrxXMLDocument;
  XmlNod:TfrxXMLItem;//主节点
  PagNod:TfrxXMLItem;//页面信息


  TMPA  :string;
  ListA :TStringList;
  ViewA :TKzCellView;


  procedure DoRead(ANode:TfrxXMLItem);
  var
    I    :Integer;
    TMPB :string;
    ListB:TStringList;
  begin
    if (ANode<>nil) and (ANode.Name<>'TfrxReportPage') then
    begin
      ViewA:=TKzCellView.Create;

      if ANode.Parent<>nil then
      begin
        ViewA.PrevCont:=ANode.Parent.Name;
      end;

      TMPB:=ANode.Text;
      TMPB:=StringReplace(TMPB,'"','',[rfReplaceAll]);

      ListB:=TStringList.Create;
      ListB.CommaText:=TMPB;
      //WritelnFmt('%S',[ListB.Text]);
      KzDebug.FileFmt('%S:%S',[Self.ClassName,ListB.Text]);

      ViewA.ViewName:=ANode.Name;

      //YXC_2016_05_06_16_39_17_<_for_d7
      //ViewA.ViewText:=Utf8Decode(frxXMLToStr(ListB.Values['Text']));
      //ViewA.ViewText:=StringReplace(ViewA.ViewText,'"','',[rfReplaceAll]);
      //YXC_2016_05_06_16_39_17_>

      ViewA.ViewText:=Trim(ListB.Values['Text']);
      ViewA.ViewText:=StringReplace(ViewA.ViewText,'"','',[rfReplaceAll]);


      if ListB.Values['Left']<>'' then
      begin
        ViewA.ViewLeft:=StrToFloat(ListB.Values['Left']);
      end;
      if ListB.Values['Width']<>'' then
      begin
        ViewA.ViewWidt:=StrToFloat(ListB.Values['Width']);
      end;
      if ListB.Values['Top']<>'' then
      begin
        ViewA.ViewTop :=StrToFloat(ListB.Values['Top']);
      end;
      if ListB.Values['Height']<>'' then
      begin
        ViewA.ViewHeig:=StrToFloat(ListB.Values['Height']);
      end;

      ViewA.FontName:=ListB.Values['Font.Name'];

      if ListB.Values['Font.Height']<>'' then
      begin
        ViewA.FontHeig:=StrToInt(ListB.Values['Font.Height']);
      end;

      if ListB.Values['Font.Color']<>'' then
      begin
        ViewA.FontColr:=StrToIntDef(ListB.Values['Font.Color'],-1);
      end;

      if ListB.Values['Font.Charset']<>'' then
      begin
        ViewA.FCharSet:=StrToIntDef(ListB.Values['Font.Charset'],1);
      end;

      ViewA.AutoWidt:=False;
      if ListB.Values['AutoWidth']<>'' then
      begin
        if ListB.Values['AutoWidth']='True' then
        begin
          ViewA.AutoWidt:=True;
        end else
        if ListB.Values['AutoWidth']='False' then
        begin
          ViewA.AutoWidt:=False;
        end;
      end;

      ViewA.AutoFontSize:=False;
      if ListB.Values['AutoFontSize']<>'' then
      begin
        if ListB.Values['AutoFontSize']='True' then
        begin
          ViewA.AutoFontSize:=True;
        end else
        if ListB.Values['AutoFontSize']='False' then
        begin
          ViewA.AutoFontSize:=False;
        end;
      end;

      ViewA.CharSpacing:=0;
      if ListB.Values['CharSpacing']<>'' then
      begin
        ViewA.CharSpacing:=StrToIntDef(ListB.Values['CharSpacing'],0);
      end;
             
      ViewA.FontStyl:=ListB.Values['Font.Style'];
      ViewA.FramType:=ListB.Values['Frame.Typ'];
      ViewA.VAlign  :=ListB.Values['VAlign'];
      if ListB.Values['HAlign']<>'' then
      begin
        ViewA.HAlign  :=ListB.Values['HAlign'];
      end;
      ViewA.FramStyl:=ListB.Values['Frame.Style'];
      if ListB.Values['Align']<>'' then
      begin
        ViewA.Align   :=ListB.Values['Align'];
      end;

      FListView.AddObject(ViewA.ViewText,ViewA);

      if ViewA.ViewText='[表头内容]' then
      begin
        HeadCellHeig:=ViewA.ViewHeig;
        HeadCellLeft:=ViewA.ViewLeft;
        HeadCellTop :=ViewA.ViewTop;
      end else
      if ViewA.ViewText='[表体内容]' then
      begin
        BodyCellHeig:=ViewA.ViewHeig;
        BodyCellLeft:=ViewA.ViewLeft;
        BodyCellTop :=ViewA.ViewTop;
      end;
    end;

    FreeAndNil(ListB);

    if ANode.Count>0 then
    begin
      for I:=0 to ANode.Count-1 do
      begin
        DoRead(ANode.Items[I]);
      end;
    end;     
  end;
begin
  if FListView<>nil then
  begin
    TKzUtils.TryFreeAndNil(FListView);
  end;
  FListView:=TStringList.Create;


  frxXML:=TfrxXMLDocument.Create;
  frxXML.Clear;
  frxXML.LoadFromFile(FFilePath); //FFilePath:fr3文档路径
  XmlNod:=FrxXml.Root;

  PagNod:=XmlNod.FindItem('TfrxReportPage');
  if PagNod<>nil then
  begin
    TMPA:=PagNod.Text;
    TMPA:=StringReplace(TMPA,'"','',[rfReplaceAll]);

    ListA:=TStringList.Create;
    ListA.CommaText:=TMPA;

    PaperWidt:=StrToFloat(ListA.Values['PaperWidth']);
    PaperSize:=StrToInt(ListA.Values['PaperSize']);
    PaperHeig:=StrToFloat(ListA.Values['PaperHeight']);

    MargLeft :=StrToFloat(ListA.Values['LeftMargin']);
    MargRigh :=StrToFloat(ListA.Values['RightMargin']);
    MargTop  :=StrToFloat(ListA.Values['TopMargin']);
    MargBott :=StrToFloat(ListA.Values['BottomMargin']);

    Orientation:=ListA.Values['Orientation'];
    
    FreeAndNil(ListA);

    try
      DoRead(PagNod);
    except
      raise Exception.Create('NOT SUPPORT THIS METHOD:[TKzPrint.SetCellViewParams] AT [Class_KzPrint.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
    end;    
  end;

  FreeAndNil(frxXML);
end;


procedure TKzPrint.SetfrxVariabl;
var
  I:Integer;
  KzPrint:string;
  VarName:string;
begin
  KzPrint:='KzPrint';

  FfrxReport.Variables.Clear;
  FfrxReport.Variables[' '+CONST_KZPRINT_SYSVARIABL]:=Null;

  FfrxReport.Variables.AddVariable(CONST_KZPRINT_SYSVARIABL,'页面信息','');
  FfrxReport.Variables.AddVariable(CONST_KZPRINT_SYSVARIABL,'分页信息/分页','');
  FfrxReport.Variables.AddVariable(CONST_KZPRINT_SYSVARIABL,'第几页','');
  FfrxReport.Variables.AddVariable(CONST_KZPRINT_SYSVARIABL,'共几页','');
  FfrxReport.Variables.AddVariable(CONST_KZPRINT_SYSVARIABL,'表头内容','');
  FfrxReport.Variables.AddVariable(CONST_KZPRINT_SYSVARIABL,'表体内容','');
  
  if (FListVariabl<>nil) and (FListVariabl.Count>0) then
  begin
    FfrxReport.Variables[' '+CONST_KZPRINT_APPVARIABL]:=Null;
    for I:=0 to FListVariabl.Count -1 do
    begin
      VarName:=FListVariabl.Names[I];
      FfrxReport.Variables.AddVariable(CONST_KZPRINT_APPVARIABL,VarName,'');
    end;   
  end;

  {FfrxReport.Variables.AddVariable('KzPrint','打印人','');
  FfrxReport.Variables.AddVariable('KzPrint','打印日期','');
  FfrxReport.Variables.AddVariable('KzPrint','页面信息','');}
end;

procedure TKzPrint.SetUseDataSet;
var
  I    :Integer;
  ACell:TKzCellText;
begin
  FUseDataSet.Fields.Clear;
  FUseDataSet.UserName:='KzPrint';
  for I:=0 to FListCell.Count-1 do 
  begin
    ACell:=TKzCellText(FListCell.Objects[I]);
    FUseDataSet.Fields.Add(ACell.Text);
  end;

  SetValidRows;
  
  FUseDataSet.RangeEnd     :=reCount;
  FUseDataSet.RangeEndCount:=FListRows.Count;
  
  FUseDataSet.OnGetValue:=OnUseDataSetGetValue;
end;

procedure TKzPrint.SetValidCols;
{var
  I:Integer;
  Valid:Boolean;}
begin
  raise Exception.Create('NOT SUPPORT THIS METHOD:[TKzPrint.SetValidCols] AT [Class_KzPrint.pas]'+#13+'此函数已被更新或弃用,请向开发人员报告错误场合.');
  //had not achieve yet  
  {Valid:=True;

  if FListCols=nil then
  begin
    FListCols:=TStringList.Create;
  end else
  begin
    FListCols.Clear;
  end;    

  with SourceGrid do
  begin
    for I := FColStart to FTotlCount-1 do
    begin
      Valid:=True;
      if Assigned(OnKzPrintGridValidCols) then
      begin
        OnKzPrintGridValidCols(Self,SourceGrid,I,Valid);
      end;

      if Valid then
      begin
        FListCols.Add(IntToStr(I));
      end;  
    end;
  end;}
end;

procedure TKzPrint.SetValidRows;
var
  I:Integer;
  Valid:Boolean;
begin
  Valid:=True;

  if FListRows=nil then
  begin
    FListRows:=TStringList.Create;
  end else
  begin
    FListRows.Clear;
  end;    

  if FRowBodyEnd = -1 then
  begin
    FRowBodyEnd := SourceGrid.RowCount-1;
  end;
    
  with SourceGrid  do
  begin
    for I := FRowBodyStart to FRowBodyEnd do
    begin
      Valid:=True;
      if Assigned(OnKzPrintGridValidRows) then
      begin
        OnKzPrintGridValidRows(Self,SourceGrid,I,Valid);
      end;

      if Valid then
      begin
        FListRows.Add(IntToStr(I));
      end;  
    end;
  end;
end;

{ TKzCellView }

constructor TKzCellView.Create;
begin
  VAlign:='-1';
  HAlign:='-1';
  HAlign:='haLeft';
  Align :='-1';

  PrevCont:='-1';
  PrevName:='-1';

  ViewName:='-1';
  ViewText:='-1';

  FramType:='-1';
  FramStyl:='-1';

  FCharSet:=1;
end;

{ TKzCellText }

class function TKzCellText.CopyIt(AKzCellText: TKzCellText): TKzCellText;
begin
  Result:=TKzCellText.Create;

  Result.Idex:=AKzCellText.Idex;
  Result.Text:=AKzCellText.Text;
  Result.Widt:=AKzCellText.Widt;
  Result.High:=AKzCellText.High;
  Result.Left:=AKzCellText.Left;
  Result.Fill:=AKzCellText.Fill;
  Result.Alig:=AKzCellText.Alig;
  Result.Scal:=AKzCellText.Scal;
  Result.GapX:=AKzCellText.GapX;
  Result.GapY:=AKzCellText.GapY;
  Result.PagX:=AKzCellText.PagX;
  Result.TopX:=AKzCellText.TopX;
  Result.TestFill:=AKzCellText.TestFill;
  Result.TestHide:=AKzCellText.TestHide;
  Result.AutoNumb:=AKzCellText.AutoNumb;
  Result.RowIndex:=AKzCellText.RowIndex;
  Result.ColIndex:=AKzCellText.ColIndex;
end;

class procedure TKzCellText.CopyIt(AKzCellText: TKzCellText;
  var Result: TKzCellText);
begin
  if Result=nil then Exit;
  
  Result.Idex:=AKzCellText.Idex;
  Result.Text:=AKzCellText.Text;
  Result.Widt:=AKzCellText.Widt;
  Result.High:=AKzCellText.High;
  Result.Left:=AKzCellText.Left;
  Result.Fill:=AKzCellText.Fill;
  Result.Alig:=AKzCellText.Alig;
  Result.Scal:=AKzCellText.Scal;
  Result.GapX:=AKzCellText.GapX;
  Result.GapY:=AKzCellText.GapY;
  Result.PagX:=AKzCellText.PagX;
  Result.TopX:=AKzCellText.TopX;
  Result.TestFill:=AKzCellText.TestFill;
  Result.TestHide:=AKzCellText.TestHide;
  Result.AutoNumb:=AKzCellText.AutoNumb;
  Result.RowIndex:=AKzCellText.RowIndex;
  Result.ColIndex:=AKzCellText.ColIndex;
end;

function TKzCellText.GetStrIndex: string;
begin
  Result:=Format('%F:%F:%F:%S:%D',[Widt,High,Left,Text,PagX]);
end;

procedure TKzPrint.SetCellPostParamsWhenMultiHead;
var
  I,M,N:Integer;
  IsFinded:Boolean;

  NumbA:Integer;
  PostX:Extended;
  PostY:Extended;  
  DoubA:Extended;
  DoubB:Extended;
  LengA:Extended; //when it is too long then cut it.
  PageX:Integer;  //which page.

  ListA:TStringList;
      
  CellA:TKzCellText;
  CellB:TKzCellText;
  CellC:TKzCellText;

  CutxA:TKzPageCutX;
  CutxB:TKzPageCutX;

  TreeItem:TKzTreeItem;

  function GetObjtCutX(APageIdex:Integer):TKzPageCutX;overload;
  var
    X:Integer;
  begin
    Result:=nil;
    X:=FListCutX.IndexOf(IntToStr(APageIdex));
    if X<>-1 then
    begin
      Result:=TKzPageCutX(FListCutX.Objects[X]);
    end;
  end;

  function GetObjtCutx(AWidth:Extended;IsPrev:Boolean):TKzPageCutX;overload;
  var
    X:Integer;
    CutxX:TKzPageCutX;
  begin
    Result:=nil;
    for X:=0 to FListCutX.Count-1 do
    begin
      CutxX:=TKzPageCutX(FListCutX.Objects[X]);

      if IsPrev then
      begin
        if (CutxX.PagePrev <= AWidth) and (CutxX.PageNext > AWidth) then
        begin
          Break;
        end;
      end else
      begin
        if CutxX.PageNext >= AWidth then
        begin
          Break;
        end;
      end;
    end;
    Result:=CutxX;
  end;  

  function GetPageIdex(AWidth,BWidth:Extended):Integer;
  var
    X:Integer;
  begin
    Result:=-1;
    CutxA:=GetObjtCutX(AWidth,False);              //get the max page could be show
    CutxB:=GetObjtCutX(AWidth - BWidth,True);      //get the min page could be show

    if (CutxA.PageIdex=CutxB.PageIdex)  then       //if max page = min page
    begin
      Result:=CutxA.PageIdex;
    end else                                       //if max page<> min page,fill min page first.
    begin
      KzDebug.FileFmt('page:%D:%D',[CutxA.PageIdex,CutxB.PageIdex]);

      if CutxB.PageIdex < CutxA.PageIdex then
      begin
        CellA.Widt:=CutxB.PageNext - (AWidth - BWidth);
        Result:=CutxB.PageIdex;
      end else
      begin
        CellA.Widt:=CutxA.PageNext - (AWidth - BWidth);
        Result:=CutxA.PageIdex;
      end;


      LengA:=AWidth - CellA.Widt - (AWidth - BWidth);
      if LengA<0 then Exit;
      KzDebug.FileFmt('left:%F',[LengA]);

      X:=Result+1;
      CutxB:=GetObjtCutX(X);
      while (CutxB<>nil) and (LengA > CutxB.PageCutX) do
      begin
        LengA:=LengA - CutxB.PageCutX;

        CellB:=TKzCellText.Create;
        TKzCellText.CopyIt(CellA,CellB);
        CellB.PagX:=X;
        CellB.Widt:=CutxB.PageCutX;
        CellB.Text:=CharLinkPrevPage+CellA.Text;
        ListA.AddObject('',CellB);

        Inc(X);
        CutxB:=GetObjtCutX(X);
      end;

      if LengA>0 then
      begin
        CellB:=TKzCellText.Create;
        TKzCellText.CopyIt(CellA,CellB);
        CellB.PagX:=X;
        CellB.Widt:=LengA;
        CellB.Text:=CharLinkPrevPage+CellA.Text;        
        ListA.AddObject('',CellB);
      end;  
    end;
  end;
begin
  if (FTreeCellWhenMultiHead=nil) or (FTreeCellWhenMultiHead.ListItem.Count=0) then Exit;
  if (FListCutX=nil) or (FListCutX.Count=0) then Exit;

  ListA:=TStringList.Create;

  for I:=0 to FTreeCellWhenMultiHead.ListItem.Count-1 do
  begin
    TreeItem:=TKzTreeItem(FTreeCellWhenMultiHead.ListItem.Objects[I]);

    PostX:=0;
    PageX:=1;
    NumbA:=0;        
    for M:=0 to TreeItem.Count-1 do
    begin
      CellA:=nil;
      CellA:=TKzCellText(TreeItem.Objects[M]);
      if CellA=nil then Continue;

      if LockCount>0 then
      begin
        if NumbA < LockCount then
        begin
          Inc(NumbA);
          Continue;
        end;
      end;

      PostX:=PostX+CellA.Widt;
      CellA.PagX:=GetPageIdex(PostX,CellA.Widt);
      KzDebug.FileFmt('the page is %D,%F,%F,%S',[CellA.PagX,PostX,PostX-cella.Widt,CellA.Text]);
    end;
  end;

  for I:=0 to ListA.Count-1 do
  begin
    CellB:=TKzCellText(ListA.Objects[I]);
    FTreeCellWhenMultiHead.InsertObj(CellB.RowIndex,CellB,LockCount);
  end;

  if ListA<>nil then FreeAndNil(ListA);
end;

{ TKzTreeList }

procedure TKzTreeList.AddObject(ARowIndex: Integer; AObject: TObject);
var
  IdexA:Integer;
  ItemA:TKzTreeItem;
begin
  IdexA:=ListItem.IndexOf(IntToStr(ARowIndex));
  if IdexA=-1 then 
  begin
    ItemA:=TKzTreeItem.Create;
    ItemA.RowIndex:=ARowIndex;
    ItemA.AddObject('',AObject);

    ListItem.AddObject(IntToStr(ARowIndex),ItemA);
  end else  
  begin
    ItemA:=TKzTreeItem(ListItem.Objects[IdexA]);
    ItemA.AddObject('',AObject);
  end;  
end;

constructor TKzTreeList.Create;
begin
  ListItem:=TStringList.Create;
end;

destructor TKzTreeList.Destroy;
begin
  TKzUtils.TryFreeAndNil(ListItem);
  inherited;
end;

function TKzPrint.GetLefCellRect(AColIndex, ARowIndex: Integer): Extended;
var
  I:Integer;
begin
  Result:=0;
  with SourceGrid do
  begin
    for I:=FColStart to AColIndex -1 do
    begin
      Result:=Result+ ColWidths[I];
    end;   
  end;  
end;

function TKzPrint.GetTopCellRect(AColIndex, ARowIndex: Integer): Extended;
var
  I:Integer;
begin
  Result:=0;
  with SourceGrid do
  begin
    for I:=FRowHeadStart to ARowIndex -1 do
    begin
      Result:=Result+ RowHeights[I];
    end;   
  end;  
end;

procedure TKzTreeList.InsertObj(ARowIndex: Integer; AObject: TObject;ALockCount:Integer);
var
  IdexA:Integer;
  ItemA:TKzTreeItem;
begin
  IdexA:=ListItem.IndexOf(IntToStr(ARowIndex));
  if IdexA=-1 then 
  begin
    ItemA:=TKzTreeItem.Create;
    ItemA.RowIndex:=ARowIndex;

    if ALockCount=0 then
    begin
      ItemA.InsertObject(0,'',AObject);
    end else
    begin
      ItemA.InsertObject(ALockCount+1,'',AObject);
    end;


    ListItem.AddObject(IntToStr(ARowIndex),ItemA);
  end else  
  begin
    ItemA:=TKzTreeItem(ListItem.Objects[IdexA]);
    
    if ALockCount=0 then
    begin
      ItemA.InsertObject(0,'',AObject);
    end else
    begin
      ItemA.InsertObject(ALockCount+1,'',AObject);
    end;
  end;  
end;

{ TKzTreeItem }

constructor TKzTreeItem.Create;
begin

end;

destructor TKzTreeItem.Destroy;
var
  I:Integer;
begin
  for I:=0 to Count-1 do
  begin
    Objects[I].Free;
    Objects[I]:=nil;
  end;  
  inherited;
end;

function TKzPrint.ExportxMultiHead: TfrxReport;
begin
  if not PrepareMultiHead then Exit;
  FfrxReport.PrepareReport(True);
  Result:=FfrxReport;
end;

{ TKzPageCutX }

function TKzPageCutX.GetStrIndex: string;
begin
  Result:=Format('%D:%F:%F:%F:%F',[PageIdex,PageWidt,PageCutX,PagePrev,PageNext]);
end;

function TKzPrint.PrepareMultiHead: Boolean;
var
  I,M,N:Integer;
  IdexA:Integer;
  IdexB:Integer;

  PageCount:Integer;

  PageA:TfrxReportPage;
  TitlA:TfrxReportTitle;
  LineA:TfrxLineView;

  //YXC_2010_05_25_10_28_36
  HeadA:TfrxPageHeader;
  FootA:TfrxPageFooter;
  FootB:TfrxFooter;
  MastA:TfrxMasterData;

  PostX:Extended;  
  PostA:Extended;
  PostB:Extended;

  TopXA:Extended;
  TopXB:Extended;

  NumbA:Integer;
  NumbB:Integer;

  TextA:TKzCellText;
  TextB:TKzCellText;

  ViewA:TKzCellView;
  ViewB:TKzCellView;

  MemoA:TfrxMemoView;
  MemoB:TfrxMemoView;

  ItemA:TKzTreeItem;

  //YXC_2010_06_17_11_20_43
  CenterMargin:Extended;   //居中页边距
  HeadHeightAdded:Boolean;

  function FindComponent(AClassName:string):TfrxComponent;
  begin
    if AClassName='TfrxMasterData' then
    begin
      Result:=MastA;
    end else
    if AClassName='TfrxPageFooter' then
    begin
      Result:=FootA;
    end else
    if AClassName='TfrxPageHeader' then
    begin
      Result:=HeadA;
    end else
    if AClassName='TfrxReportTitle' then
    begin
      Result:=TitlA;
    end else
    if AClassName='TfrxFooter' then
    begin
      Result:=FootB;
    end;
  end;


  function FindPrevCont(AValue:string):TfrxComponent;
  var
    CellB:TKzCellView;
  begin
    CellB:=TKzCellView(FListView.Objects[FListView.IndexOf(AValue)]);
    if CellB<>nil then
    begin
      Result:=FindComponent(CellB.PrevCont);
    end;
  end;
begin
  Result:=False;
  if not FileExists(FFilePath) then
  begin
    ShowMessage('模板文件不存在');
    Exit;
  end;

  FfrxReport.Clear;
  FfrxReport.StoreInDFM:=False;
  FfrxReport.EngineOptions.DoublePass:=True;
  FfrxReport.OnGetValue   :=OnGetValue;
  FfrxReport.OnBeforePrint:=OnfrxReportBeforePrint;
  if FPrintOrder=poRowFirst then
  begin
    FfrxReport.OnEndDoc:=OnEndDoc;
  end;

  //YXC_2013_11_07_11_02_36_<_more important
  FRowTitle := FTheRowMostDetailed;
  //YXC_2013_11_07_11_02_36_>

  SetCellTextParams;
  SetCellTextParamsWhenMultiHead;
  
  SetCellViewParams;
  SetUseDataSet;
  SetfrxVariabl;

  FfrxReport.DataSets.Add(FUseDataSet);


  //YXC_2013_11_08_09_42_31_<
  HeadHeightAdded:=False;
  PostA:=0;
  PostB:=0;
  PostX:=0;  
  //YXC_2013_11_08_09_42_31_>


  if FBreakModel<>bmPagBreak then raise Exception.Create('ERROR:Class_KzPrint.pas.TKzPrint.ExecuteMultiHead.LINE:3269.INFO:CAN NOT SUPPORT THIS BREAKMODEL:BMPAGBREAK'); 

  if FBreakModel=bmPagBreak then
  begin
    PageCount:=GetPageCountWhenMultiHead;
    SetCellPostParamsWhenMultiHead;

    for I:=1 to PageCount do
    begin
      //YXC_2013_11_08_09_42_31_<
      HeadHeightAdded:=False;
      PostA:=0;
      PostB:=0;
      PostX:=0;  
      //YXC_2013_11_08_09_42_31_>    
      
      PageA:=TfrxReportPage.Create(FfrxReport);
      PageA.CreateUniqueName;
      
      if Orientation='poLandscape' then
      begin
        PageA.Orientation:=poLandscape;
      end else
      if Orientation='poPortrait' then
      begin
        PageA.Orientation:=poPortrait;
      end;

      PageA.PaperSize   :=PaperSize;
      if PageA.PaperSize=256 then
      begin
        PageA.PaperWidth  :=PaperWidt;
        PageA.PaperHeight :=PaperHeig;
      end;
      PageA.LeftMargin  :=MargLeft;
      PageA.TopMargin   :=MargTop;
      PageA.RightMargin :=MargRigh;
      PageA.BottomMargin:=MargBott;

      for M:=0 to FListView.Count-1 do
      begin
        ViewA:=TKzCellView(FListView.Objects[M]);

        if ViewA.ViewText='[表头内容]' then Continue;
        if ViewA.ViewText='[表体内容]' then Continue;

        if ViewA.ViewName='TfrxMasterData' then
        begin
          MastA:=TfrxMasterData.Create(PageA);
          MastA.CreateUniqueName;
          MastA.Height:=ViewA.ViewHeig;
          MastA.Top   :=ViewA.ViewTop;
          MastA.DataSet:=FUseDataSet;
        end else
        if ViewA.ViewName='TfrxPageFooter' then
        begin
          FootA:=TfrxPageFooter.Create(PageA);
          FootA.CreateUniqueName;
          FootA.Height:=ViewA.ViewHeig;
          FootA.Top   :=ViewA.ViewTop;
        end else
        if ViewA.ViewName='TfrxPageHeader' then
        begin
          HeadA:=TfrxPageHeader.Create(PageA);
          HeadA.CreateUniqueName;
          HeadA.Height:=ViewA.ViewHeig;
          HeadA.Top   :=ViewA.ViewTop;
        end else
        if ViewA.ViewName='TfrxReportTitle' then
        begin
          TitlA:=TfrxReportTitle.Create(PageA);
          TitlA.CreateUniqueName;
          TitlA.Height:=ViewA.ViewHeig;
          TitlA.Top   :=ViewA.ViewTop;
        end else
        if ViewA.ViewName='TfrxFooter' then
        begin
          FootB:=TfrxFooter.Create(PageA);
          FootB.CreateUniqueName;
          FootB.Height:=ViewA.ViewHeig;
          FootB.Top   :=ViewA.ViewTop;
        end else
        if ViewA.ViewName='TfrxMemoView' then
        begin
          MemoA:=TfrxMemoView.Create(FindComponent(ViewA.PrevCont));
          MemoA.CreateUniqueName;

          MemoA.Text  :=ViewA.ViewText;
          MemoA.Height:=ViewA.ViewHeig;
          MemoA.Width :=ViewA.ViewWidt;
          MemoA.Top   :=ViewA.ViewTop;
          MemoA.Left  :=ViewA.ViewLeft;

          MemoA.Font.Name  :=ViewA.FontName;
          MemoA.Font.Height:=ViewA.FontHeig;
          MemoA.Font.Color :=ViewA.FontColr;
          MemoA.Font.Charset:=ViewA.FCharSet;

          MemoA.Frame.Typ:=GetFrameType(StrToIntDef(ViewA.FramType,0));

          MemoA.AutoWidth:=ViewA.AutoWidt;

          if ViewA.VAlign<>'-1' then
          begin
            MemoA.VAlign:=GetMemoVAlig(ViewA.VAlign);
          end;

          //KAZARUS:TO BE PREFECT
          if ViewA.HAlign<>'-1' then
          begin
            MemoA.HAlign:=GetMemoHAlig(ViewA.HAlign);
          end;

          if ViewA.Align<>'-1' then
          begin
            MemoA.Align :=GetMemoAlign(ViewA.Align);
          end;

          if ViewA.FontStyl='1' then
          begin
            MemoA.Font.Style:=[fsBold];
          end;
        end else
        if ViewA.ViewName='TfrxLineView' then
        begin
          LineA:=TfrxLineView.Create(FindComponent(ViewA.PrevCont));
          LineA.CreateUniqueName;
          LineA.Height:=ViewA.ViewHeig;
          LineA.Width :=ViewA.ViewWidt;
          LineA.Top   :=ViewA.ViewTop;
          LineA.Left  :=ViewA.ViewLeft;

          if ViewA.FramStyl<>'-1' then
          begin
            LineA.Frame.Style:=GetLineStyle(ViewA.FramStyl);
          end;

          if ViewA.Align<>'-1' then
          begin
            LineA.Align:=GetMemoAlign(ViewA.Align);
          end;
        end;
      end;

      ViewA:=nil;
      IdexA:=FListView.IndexOf('[表头内容]');
      ViewB:=nil;
      IdexB:=FListView.IndexOf('[表体内容]');
      if IdexA<>-1 then
      begin
        ViewA:=TKzCellView(FListView.Objects[IdexA]);
      end;
      if IdexB<>-1 then
      begin
        ViewB:=TKzCellView(FListView.Objects[IdexB]);
      end;

      if FRowHeadEnd  - FRowHeadStart >0 then
      begin
        if not HeadHeightAdded then
        begin
          FindComponent(ViewA.PrevCont).Height:=FindComponent(ViewA.PrevCont).Height+ (FRowHeadEnd  - FRowHeadStart) * ViewA.ViewHeig;
        end;
      end;      

      if LockCount>0 then
      begin
        //lock.head.postx
        if ViewA<>nil then
        begin
          TopXA:=0;
          for M:=0 to FTreeCellWhenMultiHead.ListItem.Count-1 do
          begin
            ItemA:=TKzTreeItem(FTreeCellWhenMultiHead.ListItem.Objects[M]);
            PostX:=0;
            NumbA:=0;
            for N:=0 to ItemA.Count-1 do
            begin
              TextA:=TKzCellText(ItemA.Objects[N]);
              if TextA=nil then Continue;

              if NumbA=LockCount then Break;
              if TextA.TestHide then Continue;

              MemoA:=TfrxMemoView.Create(FindComponent(ViewA.PrevCont));
              MemoA.CreateUniqueName;
              MemoA.Width :=TextA.Widt;
              //MemoA.Height:=TextA.High;
              MemoA.Height:=ViewA.ViewHeig;
              if TextA.GapY >0 then
              begin
                MemoA.Height:=ViewA.ViewHeig * (TextA.GapY +1) ;
              end;
              MemoA.Left  :=PostX;

              MemoA.Text  :=TextA.Text;
              //MemoA.Top   :=TextA.TopX +  HeadCellTop;
              MemoA.Top   :=TopXA + HeadCellTop;

              MemoA.Font.Name  :=ViewA.FontName;
              MemoA.Font.Height:=ViewA.FontHeig;
              MemoA.Font.Color :=ViewA.FontColr;
              MemoA.Font.Charset:=ViewA.FCharSet;
              
              MemoA.Frame.Typ:=GetFrameType(StrToIntDef(ViewA.FramType,0));

              MemoA.AutoWidth:=ViewA.AutoWidt;
              if ViewA.VAlign<>'-1' then
              begin
                MemoA.VAlign:=GetMemoVAlig(ViewA.VAlign);
              end;
              if ViewA.HAlign<>'-1' then
              begin
                MemoA.HAlign:=GetMemoHAlig(ViewA.HAlign);
              end;
              if ViewA.Align<>'-1' then
              begin
                MemoA.Align :=GetMemoAlign(ViewA.Align);
              end;
              if ViewA.FontStyl='1' then
              begin
                MemoA.Font.Style:=[fsBold];
              end;

              PostX:=PostX+TextA.Widt;
              Inc(NumbA);
            end;
            TopXA:=TopXA+MemoA.Height;
          end;
        end;

        if ViewB<>nil then
        begin
          //lock.body.posta
          PostA:=0;
          for M:=0 to LockCount-1 do
          begin
            TextA:=TKzCellText(FListCell.Objects[M]);
            //YXC_2010_05_26_20_21_50_{
            MemoB:=TfrxMemoView.Create(FindComponent(ViewB.PrevCont));
            MemoB.CreateUniqueName;
            MemoB.Left:=PostA;
            MemoB.Top :=BodyCellTop;
            MemoB.Width:=TextA.Widt;

            MemoB.VAlign:=frxClass.vaCenter;
            case TextA.Alig of
              1:MemoB.HAlign:=haLeft ;
              2:MemoB.HAlign:=haCenter ;
              3:MemoB.HAlign:=haRight;
            end;

            MemoB.Frame.Typ:=GetFrameType(StrToIntDef(ViewB.FramType,0));
            MemoB.Height:=BodyCellHeig;

            MemoB.Font.Name  :=ViewB.FontName;
            MemoB.Font.Height:=ViewB.FontHeig;
            MemoB.Font.Color :=ViewB.FontColr;
            MemoB.Font.Charset:=ViewB.FCharSet;

            //YXC_2010_05_31_17_52_41_<
            if BoolReadFromCnfg then
            begin
              MemoB.AutoFontSize:=BoolHeadSize;
            end else
            begin
              MemoB.AutoFontSize:=ViewB.AutoFontSize;
            end;

            MemoB.CharSpacing:=ViewB.CharSpacing;

            if ViewB.FontStyl='1' then
            begin
              MemoB.Font.Style:=[fsBold];
            end;

            MemoB.DataSet  :=FUseDataSet;
            MemoB.DataField:=TextA.Text;
            //YXC_2010_05_26_20_14_45_>

            PostA:=PostA+MemoB.Width;
          end;
        end;
      end;

      if ViewA<>nil then
      begin
        //unlock.head.postx
        TopXA:=0;
        for M:=0 to FTreeCellWhenMultiHead.ListItem.Count-1 do
        begin
          ItemA:=TKzTreeItem(FTreeCellWhenMultiHead.ListItem.Objects[M]);
          PostX:=0;
          for N:=0 to ItemA.Count-1 do
          begin
            TextA:=TKzCellText(ItemA.Objects[N]);

            if TextA=nil then Continue;
            if TextA.PagX=-1 then Continue;
            if TextA.PagX<>I then Continue;
            
            if TextA.TestHide then
            begin
              PostX:=PostX+TextA.Widt;
              Continue; 
            end;  

            MemoA:=TfrxMemoView.Create(FindComponent(ViewA.PrevCont));

            MemoA.CreateUniqueName;
            MemoA.Width :=TextA.Widt;
            MemoA.Height:=ViewA.ViewHeig;
            if TextA.GapY >0 then
            begin
              MemoA.Height:=ViewA.ViewHeig * (TextA.GapY +1) ;
            end;
            MemoA.Left  :=LockWidth + PostX;
        
            MemoA.Text  :=TextA.Text;
            MemoA.Top   :=TopXA + HeadCellTop;

            MemoA.Font.Name  :=ViewA.FontName;
            MemoA.Font.Height:=ViewA.FontHeig;
            MemoA.Font.Color :=ViewA.FontColr;
            MemoA.Font.Charset:=ViewA.FCharSet;
            
            MemoA.Frame.Typ:=GetFrameType(StrToIntDef(ViewA.FramType,0));

            MemoA.AutoWidth:=ViewA.AutoWidt;
            if ViewA.VAlign<>'-1' then
            begin
              MemoA.VAlign:=GetMemoVAlig(ViewA.VAlign);
            end;
            if ViewA.HAlign<>'-1' then
            begin
              MemoA.HAlign:=GetMemoHAlig(ViewA.HAlign);
            end;
            if ViewA.Align<>'-1' then
            begin
              MemoA.Align :=GetMemoAlign(ViewA.Align);
            end;
            if ViewA.FontStyl='1' then
            begin
              MemoA.Font.Style:=[fsBold];
            end; 

            PostX:=PostX+TextA.Widt;
          end;
          TopXA:=TopXA+ViewA.ViewHeig;
        end;
      end;

      if ViewB<>nil then
      begin
        //unlock.body.posta;
        PostB:=PostA;
        for M:=LockCount to  FListCell.Count-1 do
        begin
          TextA:=TKzCellText(FListCell.Objects[M]);
          if TextA.Fill then Continue;
          
          PostA:=PostA+TextA.Widt;
          if PostA >= FactWidth then Break;
        
          //YXC_2010_05_26_20_21_33_<
          MemoB:=TfrxMemoView.Create(FindComponent(ViewB.PrevCont));
          MemoB.CreateUniqueName;
          MemoB.Left:=PostB;
          MemoB.Top :=BodyCellTop;
          MemoB.Width:=TextA.Widt;


          MemoB.VAlign:=frxClass.vaCenter;
          case TextA.Alig of
            1:MemoB.HAlign:=haLeft ;
            2:MemoB.HAlign:=haCenter ;
            3:MemoB.HAlign:=haRight;
          end;

          MemoB.Frame.Typ:=GetFrameType(StrToIntDef(ViewB.FramType,0));

          MemoB.Height:=BodyCellHeig;
      
          MemoB.Font.Name  :=ViewB.FontName;
          MemoB.Font.Height:=ViewB.FontHeig;
          MemoB.Font.Color :=ViewB.FontColr;
          MemoB.Font.Charset:=ViewB.FCharSet;
        
          //YXC_2010_05_31_17_52_41
          if BoolReadFromCnfg then
          begin
            MemoB.AutoFontSize:=BoolBodySize;
          end else
          begin
            MemoB.AutoFontSize:=ViewB.AutoFontSize;
          end;

          MemoB.CharSpacing:=ViewB.CharSpacing;

          if ViewB.FontStyl='1' then
          begin
            MemoB.Font.Style:=[fsBold];
          end;  

          MemoB.DataSet  :=FUseDataSet;
          MemoB.DataField:=TextA.Text;
          //YXC_2010_05_26_20_21_35_>

          PostB:=PostB+TextA.Widt;
          TextA.Fill:=True;
        end;
      end;

      //like 210cm
      if BoolPageCent then
      begin
        CenterMargin :=(PaperWidt * 3.78  - PostB ) /  2  / 3.78;
        PageA.LeftMargin :=CenterMargin ;
        PageA.RightMargin:=CenterMargin ;
      end;
    end;
  end;
  
  Result:=True;
end;

function TKzPrint.PreparX: Boolean;
var
  I,M,N:Integer;
  IdexA:Integer;
  IdexB:Integer;

  PageCount:Integer;

  PageA:TfrxReportPage;
  TitlA:TfrxReportTitle;
  LineA:TfrxLineView;

  //YXC_2010_05_25_10_28_36
  HeadA:TfrxPageHeader;
  FootA:TfrxPageFooter;
  FootB:TfrxFooter;
  MastA:TfrxMasterData;

  PostX:Extended;
  PostA:Extended;
  PostB:Extended;

  TopXA:Extended;
  TopXB:Extended;
  
  NumbA:Integer;
  NumbB:Integer;
    
  TextA:TKzCellText;
  TextB:TKzCellText;

  ViewA:TKzCellView;
  ViewB:TKzCellView;

  MemoA:TfrxMemoView;
  MemoB:TfrxMemoView;
  //YXC_2010_06_17_11_20_43
  CenterMargin:Extended;   //居中页边距

  function FindComponent(AClassName:string):TfrxComponent;
  begin
    if AClassName='TfrxMasterData' then
    begin
      Result:=MastA;
    end else
    if AClassName='TfrxPageFooter' then
    begin
      Result:=FootA;
    end else
    if AClassName='TfrxPageHeader' then
    begin
      Result:=HeadA;
    end else
    if AClassName='TfrxReportTitle' then
    begin
      Result:=TitlA;
    end else
    if AClassName='TfrxFooter' then
    begin
      Result:=FootB;
    end;
  end;


  function FindPrevCont(AValue:string):TfrxComponent;
  var
    CellB:TKzCellView;
  begin
    CellB:=TKzCellView(FListView.Objects[FListView.IndexOf(AValue)]);
    if CellB<>nil then
    begin
      Result:=FindComponent(CellB.PrevCont);
    end;
  end;
begin
  Result:=False;
  if not FileExists(FFilePath) then
  begin
    ShowMessage('模板文件不存在');
    Exit;
  end;

  FfrxReport.Clear;
  FfrxReport.StoreInDFM:=False;
  FfrxReport.EngineOptions.DoublePass:=True;
  FfrxReport.OnGetValue   :=OnGetValue;
  FfrxReport.OnBeforePrint:=OnfrxReportBeforePrint;
  if FPrintOrder=poRowFirst then
  begin
    FfrxReport.OnEndDoc:=OnEndDoc;
  end;

  SetCellTextParams;
  SetCellViewParams;
  SetUseDataSet;
  SetfrxVariabl;

  FfrxReport.DataSets.Add(FUseDataSet);
  FfrxReport.PreviewOptions.Buttons := FfrxReport.PreviewOptions.Buttons - [pbEdit];
  FfrxReport.PreviewOptions.Buttons := FfrxReport.PreviewOptions.Buttons + [pbExport];

  if FBreakModel=bmPagBreak then
  begin
    PageCount:=GetPageCountEx;

    for I:=1 to PageCount do
    begin
      PageA:=TfrxReportPage.Create(FfrxReport);
      PageA.CreateUniqueName;

      if (Trim(FBackMark)<>'') and (FileExists(FBackMark)) then
      begin
        PageA.BackPicture.LoadFromFile(FBackMark);
      end;

      if Orientation='poLandscape' then
      begin
        PageA.Orientation:=poLandscape;
      end else
      if Orientation='poPortrait' then
      begin
        PageA.Orientation:=poPortrait;
      end;

      PageA.PaperSize   :=PaperSize;
      if PageA.PaperSize=256 then
      begin
        PageA.PaperWidth  :=PaperWidt;
        PageA.PaperHeight :=PaperHeig;
      end;
      PageA.LeftMargin  :=MargLeft;
      PageA.TopMargin   :=MargTop;
      PageA.RightMargin :=MargRigh;
      PageA.BottomMargin:=MargBott;

      for M:=0 to FListView.Count-1 do
      begin
        ViewA:=TKzCellView(FListView.Objects[M]);

        if ViewA.ViewText='[表头内容]' then Continue;
        if ViewA.ViewText='[表体内容]' then Continue;

        if ViewA.ViewName='TfrxMasterData' then
        begin
          MastA:=TfrxMasterData.Create(PageA);
          MastA.CreateUniqueName;
          MastA.Height:=ViewA.ViewHeig;
          MastA.Top   :=ViewA.ViewTop;
          MastA.DataSet:=FUseDataSet;
        end else
        if ViewA.ViewName='TfrxPageFooter' then
        begin
          FootA:=TfrxPageFooter.Create(PageA);
          FootA.CreateUniqueName;
          FootA.Height:=ViewA.ViewHeig;
          FootA.Top   :=ViewA.ViewTop;
        end else
        if ViewA.ViewName='TfrxPageHeader' then
        begin
          HeadA:=TfrxPageHeader.Create(PageA);
          HeadA.CreateUniqueName;
          HeadA.Height:=ViewA.ViewHeig;
          HeadA.Top   :=ViewA.ViewTop;
        end else
        if ViewA.ViewName='TfrxReportTitle' then
        begin
          TitlA:=TfrxReportTitle.Create(PageA);
          TitlA.CreateUniqueName;
          TitlA.Height:=ViewA.ViewHeig;
          TitlA.Top   :=ViewA.ViewTop;
        end else
        if ViewA.ViewName='TfrxFooter' then
        begin
          FootB:=TfrxFooter.Create(PageA);
          FootB.CreateUniqueName;
          FootB.Height:=ViewA.ViewHeig;
          FootB.Top   :=ViewA.ViewTop;
        end else
        if ViewA.ViewName='TfrxMemoView' then
        begin
          MemoA:=TfrxMemoView.Create(FindComponent(ViewA.PrevCont));
          MemoA.CreateUniqueName;

          MemoA.Text  :=ViewA.ViewText;
          MemoA.Height:=ViewA.ViewHeig;
          MemoA.Width :=ViewA.ViewWidt;
          MemoA.Top   :=ViewA.ViewTop;
          MemoA.Left  :=ViewA.ViewLeft;

          MemoA.Font.Name  :=ViewA.FontName;
          MemoA.Font.Height:=ViewA.FontHeig;
          MemoA.Font.Color :=ViewA.FontColr;
          MemoA.Font.Charset:=ViewA.FCharSet;

          MemoA.Frame.Typ:=GetFrameType(StrToIntDef(ViewA.FramType,0));

          MemoA.AutoWidth:=ViewA.AutoWidt;

          if ViewA.VAlign<>'-1' then
          begin
            MemoA.VAlign:=GetMemoVAlig(ViewA.VAlign);
          end;

          //KAZARUS:TO BE PREFECT
          if ViewA.HAlign<>'-1' then
          begin
            MemoA.HAlign:=GetMemoHAlig(ViewA.HAlign);
          end;

          if ViewA.Align<>'-1' then
          begin
            MemoA.Align :=GetMemoAlign(ViewA.Align);
          end;
          
          //YXC_2014_04_03_15_35_55_<
          if BoolReadFromCnfg then
          begin
            MemoA.AutoFontSize:=BoolHeadSize;
          end else
          begin
            MemoA.AutoFontSize:=ViewA.AutoFontSize;
          end;

          MemoA.CharSpacing:=ViewA.CharSpacing;
          //YXC_2014_04_03_15_35_55_>
          
          if ViewA.FontStyl='1' then
          begin
            MemoA.Font.Style:=[fsBold];
          end;
        end else
        if ViewA.ViewName='TfrxLineView' then
        begin
          LineA:=TfrxLineView.Create(FindComponent(ViewA.PrevCont));
          LineA.CreateUniqueName;
          LineA.Height:=ViewA.ViewHeig;
          LineA.Width :=ViewA.ViewWidt;
          LineA.Top   :=ViewA.ViewTop;
          LineA.Left  :=ViewA.ViewLeft;

          if ViewA.FramStyl<>'-1' then
          begin
            LineA.Frame.Style:=GetLineStyle(ViewA.FramStyl);
          end;

          if ViewA.Align<>'-1' then
          begin
            LineA.Align:=GetMemoAlign(ViewA.Align);
          end;
        end;
      end;

      ViewA:=nil;
      IdexA:=FListView.IndexOf('[表头内容]');
      ViewB:=nil;
      IdexB:=FListView.IndexOf('[表体内容]');
      if IdexA<>-1 then
      begin
        ViewA:=TKzCellView(FListView.Objects[IdexA]);
      end;
      if IdexB<>-1 then
      begin
        ViewB:=TKzCellView(FListView.Objects[IdexB]);
      end;

      PostX:=0;
      PostA:=0;
      if LockCount>0 then
      begin
        if ViewA<>nil then
        begin
          //lock.head.postx
          PostX:=0;
          for M:=0 to LockCount-1 do
          begin
            TextA:=TKzCellText(FListCell.Objects[M]);

            MemoA:=TfrxMemoView.Create(FindComponent(ViewA.PrevCont));
            MemoA.CreateUniqueName;

            MemoA.Left :=PostX;
            MemoA.Top  :=HeadCellTop;

            MemoA.Width:=TKzCellText(FListCell.Objects[M]).Widt;
            MemoA.Text :=TKzCellText(FListCell.Objects[M]).Titl;
            //Writeln('锁定列:'+TKzCellText(FListCell.Objects[M]).Text);
            MemoA.HAlign:=frxClass.haCenter;
            MemoA.VAlign:=frxClass.vaCenter;

            MemoA.Frame.Typ:=GetFrameType(StrToIntDef(ViewA.FramType,0));
            MemoA.Height:=HeadCellHeig;

            MemoA.Font.Name  :=ViewA.FontName;
            MemoA.Font.Height:=ViewA.FontHeig;
            MemoA.Font.Color :=ViewA.FontColr;
            MemoA.Font.Charset:=ViewA.FCharSet;

            //YXC_2010_05_31_17_52_41
            if BoolReadFromCnfg then
            begin
              MemoA.AutoFontSize:=BoolHeadSize;
            end else
            begin
              MemoA.AutoFontSize:=ViewA.AutoFontSize;
            end;

            MemoA.CharSpacing:=ViewA.CharSpacing;

            if ViewA.FontStyl='1' then
            begin
              MemoA.Font.Style:=[fsBold];
            end;

            PostX:=PostX+MemoA.Width;               
          end;
        end;

        if ViewB<>nil then
        begin
          //lock.body.posta
          PostA:=0;
          for M:=0 to LockCount-1 do
          begin
            TextA:=TKzCellText(FListCell.Objects[M]);

            //YXC_2010_05_26_20_21_50_<
            MemoB:=TfrxMemoView.Create(FindComponent(ViewB.PrevCont));
            MemoB.CreateUniqueName;
            MemoB.Left:=PostA;
            MemoB.Top :=BodyCellTop;
            MemoB.Width:=TextA.Widt;

            MemoB.VAlign:=frxClass.vaCenter;
            case TextA.Alig of
              1:MemoB.HAlign:=haLeft ;
              2:MemoB.HAlign:=haCenter ;
              3:MemoB.HAlign:=haRight;
            end;

            MemoB.Frame.Typ:=GetFrameType(StrToIntDef(ViewB.FramType,0));
            MemoB.Height:=BodyCellHeig;

            MemoB.Font.Name  :=ViewB.FontName;
            MemoB.Font.Height:=ViewB.FontHeig;
            MemoB.Font.Color :=ViewB.FontColr;
            MemoB.Font.Charset:=ViewB.FCharSet;

            if BoolReadFromCnfg then
            begin
              MemoB.AutoFontSize:=BoolHeadSize;
            end else
            begin
              MemoB.AutoFontSize:=ViewB.AutoFontSize;
            end;

            MemoB.CharSpacing:=ViewB.CharSpacing;

            if ViewB.FontStyl='1' then
            begin
              MemoB.Font.Style:=[fsBold];
            end;

            MemoB.DataSet  :=FUseDataSet;
            MemoB.DataField:=TextA.Text;
            //YXC_2010_05_26_20_14_45_>            

            PostA:=PostA+MemoB.Width;            
          end;
        end;
      end;

      PostB:=PostA;   //also postb:=postx
      for M:=LockCount to  FListCell.Count-1 do
      begin
        TextA:=TKzCellText(FListCell.Objects[M]);
        if TextA.Fill then Continue;

        PostA:=PostA+TextA.Widt;
        if PostA >= FactWidth then Break;

        if ViewA<>nil then
        begin
          MemoA:=TfrxMemoView.Create(FindComponent(ViewA.PrevCont));
          MemoA.CreateUniqueName;

          MemoA.Left :=PostB;
          MemoA.Top  :=HeadCellTop;
          MemoA.Width:=TKzCellText(FListCell.Objects[M]).Widt;
          MemoA.Text :=TKzCellText(FListCell.Objects[M]).Titl;
          //Writeln(TKzCellText(FListCell.Objects[M]).Text);
          MemoA.HAlign:=frxClass.haCenter;
          MemoA.VAlign:=frxClass.vaCenter;

          MemoA.Frame.Typ:=GetFrameType(StrToIntDef(ViewA.FramType,0));
      
          MemoA.Height:=HeadCellHeig;

          MemoA.Font.Name  :=ViewA.FontName;
          MemoA.Font.Height:=ViewA.FontHeig;
          MemoA.Font.Color :=ViewA.FontColr;
          MemoA.Font.Charset:=ViewA.FCharSet;
        
          //YXC_2010_05_31_17_52_41
          if BoolReadFromCnfg then
          begin
            MemoA.AutoFontSize:=BoolHeadSize;
          end else
          begin
            MemoA.AutoFontSize:=ViewA.AutoFontSize;
          end;

          MemoA.CharSpacing:=ViewA.CharSpacing;

          if ViewA.FontStyl='1' then
          begin
            MemoA.Font.Style:=[fsBold];
          end;
        end;

        if ViewB<>nil then
        begin
          //YXC_2010_05_26_20_21_33_<
          MemoB:=TfrxMemoView.Create(FindComponent(ViewB.PrevCont));
          MemoB.CreateUniqueName;
          MemoB.Left:=PostB;
          MemoB.Top :=BodyCellTop;
          MemoB.Width:=TextA.Widt;


          MemoB.VAlign:=frxClass.vaCenter;
          case TextA.Alig of
            1:MemoB.HAlign:=haLeft ;
            2:MemoB.HAlign:=haCenter ;
            3:MemoB.HAlign:=haRight;
          end;

          MemoB.Frame.Typ:=GetFrameType(StrToIntDef(ViewB.FramType,0));

          MemoB.Height:=BodyCellHeig;

          MemoB.Font.Name  :=ViewB.FontName;
          MemoB.Font.Height:=ViewB.FontHeig;
          MemoB.Font.Color :=ViewB.FontColr;
          MemoB.Font.Charset:=ViewB.FCharSet;

          //YXC_2010_05_31_17_52_41
          if BoolReadFromCnfg then
          begin
            MemoB.AutoFontSize:=BoolBodySize;
          end else
          begin
            MemoB.AutoFontSize:=ViewB.AutoFontSize;
          end;

          MemoB.CharSpacing:=ViewB.CharSpacing;

          if ViewB.FontStyl='1' then
          begin
            MemoB.Font.Style:=[fsBold];
          end;

          MemoB.DataSet  :=FUseDataSet;
          MemoB.DataField:=TextA.Text;
          //YXC_2010_05_26_20_21_35_>
        end;

        PostB:=PostB+TextA.Widt;
        TextA.Fill:=True;
      end;
    
      //like 210cm
      if BoolPageCent then
      begin
        CenterMargin :=(PaperWidt * 3.78  - PostB ) /  2  / 3.78;
        PageA.LeftMargin :=CenterMargin ;
        PageA.RightMargin:=CenterMargin ;
      end;
    end;
  end else
  begin
    PageCount:=GetPageCountEx;
    for I:=1 to PageCount do
    begin
      PageA:=TfrxReportPage.Create(FfrxReport);
      PageA.CreateUniqueName;

      if Orientation='poLandscape' then
      begin
        PageA.Orientation:=poLandscape;
      end else
      if Orientation='poPortrait' then
      begin
        PageA.Orientation:=poPortrait;
      end;

      PageA.PaperSize   :=PaperSize;
      if PageA.PaperSize=256 then
      begin
        PageA.PaperWidth  :=PaperWidt;
        PageA.PaperHeight :=PaperHeig;
      end;
      PageA.LeftMargin  :=MargLeft;
      PageA.TopMargin   :=MargTop;
      PageA.RightMargin :=MargRigh;
      PageA.BottomMargin:=MargBott;

      for M:=0 to FListView.Count-1 do
      begin
        ViewA:=TKzCellView(FListView.Objects[M]);

        if ViewA.ViewText='[表头内容]' then Continue;
        if ViewA.ViewText='[表体内容]' then Continue;

        if ViewA.ViewName='TfrxMasterData' then
        begin
          MastA:=TfrxMasterData.Create(PageA);
          MastA.CreateUniqueName;
          MastA.Height:=ViewA.ViewHeig;
          MastA.Top   :=ViewA.ViewTop;
          MastA.DataSet:=FUseDataSet;
        end else
        if ViewA.ViewName='TfrxPageFooter' then
        begin
          FootA:=TfrxPageFooter.Create(PageA);
          FootA.CreateUniqueName;
          FootA.Height:=ViewA.ViewHeig;
          FootA.Top   :=ViewA.ViewTop;
        end else
        if ViewA.ViewName='TfrxPageHeader' then
        begin
          HeadA:=TfrxPageHeader.Create(PageA);
          HeadA.CreateUniqueName;
          HeadA.Height:=ViewA.ViewHeig;
          HeadA.Top   :=ViewA.ViewTop;
        end else
        if ViewA.ViewName='TfrxReportTitle' then
        begin
          TitlA:=TfrxReportTitle.Create(PageA);
          TitlA.CreateUniqueName;
          TitlA.Height:=ViewA.ViewHeig;
          TitlA.Top   :=ViewA.ViewTop;
        end else
        if ViewA.ViewName='TfrxFooter' then
        begin
          FootB:=TfrxFooter.Create(PageA);
          FootB.CreateUniqueName;
          FootB.Height:=ViewA.ViewHeig;
          FootB.Top   :=ViewA.ViewTop;
        end else
        if ViewA.ViewName='TfrxMemoView' then
        begin
          MemoA:=TfrxMemoView.Create(FindComponent(ViewA.PrevCont));
          MemoA.CreateUniqueName;

          MemoA.Text  :=ViewA.ViewText;
          MemoA.Height:=ViewA.ViewHeig;
          MemoA.Width :=ViewA.ViewWidt;
          MemoA.Top   :=ViewA.ViewTop;
          MemoA.Left  :=ViewA.ViewLeft;

          MemoA.Font.Name  :=ViewA.FontName;
          MemoA.Font.Height:=ViewA.FontHeig;
          MemoA.Font.Color :=ViewA.FontColr;
          MemoA.Font.Charset:=ViewA.FCharSet;

          MemoA.Frame.Typ:=GetFrameType(StrToIntDef(ViewA.FramType,0));
          MemoA.AutoWidth:=ViewA.AutoWidt;

          if ViewA.VAlign<>'-1' then
          begin
            MemoA.VAlign:=GetMemoVAlig(ViewA.VAlign);
          end;

          if ViewA.HAlign<>'-1' then
          begin
            MemoA.HAlign:=GetMemoHAlig(ViewA.HAlign);
          end;

          if ViewA.Align<>'-1' then
          begin
            MemoA.Align :=GetMemoAlign(ViewA.Align);
          end;

          if ViewA.FontStyl='1' then
          begin
            MemoA.Font.Style:=[fsBold];
          end;

        end else
        if ViewA.ViewName='TfrxLineView' then
        begin
          LineA:=TfrxLineView.Create(FindComponent(ViewA.PrevCont));
          LineA.CreateUniqueName;
          LineA.Height:=ViewA.ViewHeig;
          LineA.Width :=ViewA.ViewWidt;
          LineA.Top   :=ViewA.ViewTop;
          LineA.Left  :=ViewA.ViewLeft;

          if ViewA.FramStyl<>'-1' then
          begin
            LineA.Frame.Style:=GetLineStyle(ViewA.FramStyl);
          end;

          if ViewA.Align<>'-1' then
          begin
            LineA.Align:=GetMemoAlign(ViewA.Align);
          end;
        end;
      end;
      
      ViewA:=TKzCellView(FListView.Objects[FListView.IndexOf('[表头内容]')]);
      ViewB:=TKzCellView(FListView.Objects[FListView.IndexOf('[表体内容]')]);
      
      PostA:=0;
      PostB:=0;
      TopXA:=HeadCellTop;
      TopXB:=BodyCellTop;
      NumbA:=0;
      NumbB:=0;

      for M:=0 to  FListCell.Count-1 do
      begin
        TextA:=TKzCellText(FListCell.Objects[M]);
        if TextA.Fill then Continue;

        MemoA:=TfrxMemoView.Create(FindComponent(ViewA.PrevCont));
        MemoA.CreateUniqueName;
        MemoA.Left:=PostA;
        MemoA.Top   :=TopXA;
        MemoA.Width :=TextA.Widt;
        MemoA.Height:=HeadCellHeig;
        MemoA.Text  :=TextA.Titl;
        MemoA.HAlign:=frxClass.haCenter;
        MemoA.VAlign:=frxClass.vaCenter;
        MemoA.Frame.Typ:=GetFrameType(StrToIntDef(ViewA.FramType,0));
        MemoA.Font.Name  :=ViewA.FontName;
        MemoA.Font.Height:=ViewA.FontHeig;
        MemoA.Font.Color :=ViewA.FontColr;
        MemoA.Font.Charset:=ViewA.FCharSet;
        
        if BoolReadFromCnfg then
        begin
          MemoA.AutoFontSize:=BoolHeadSize;
        end else
        begin
          MemoA.AutoFontSize:=ViewA.AutoFontSize;
        end;
        if ViewA.FontStyl='1' then
        begin
          MemoA.Font.Style:=[fsBold];
        end;
        
        MemoB.CharSpacing:=ViewA.CharSpacing;
        
        PostA:=PostA+TextA.Widt;
        if PostA>=FactWidth-TextA.Widt then
        begin
          Inc(NumbA);
          PostA:=0;
          TopXA:=TopXA+(ViewA.ViewHeig+ViewB.ViewHeig);
        end;  


        MemoB:=TfrxMemoView.Create(FindComponent(ViewB.PrevCont));
        MemoB.CreateUniqueName;
        MemoB.Left  :=PostB;
        MemoB.Top   :=TopXB;
        MemoB.Width :=TextA.Widt;
        MemoB.Height:=BodyCellHeig;
        MemoB.Text  :=TextA.Text;
        MemoB.HAlign:=frxClass.haCenter;
        MemoB.VAlign:=frxClass.vaCenter;
        MemoB.Frame.Typ:=GetFrameType(StrToIntDef(ViewB.FramType,0));
        MemoB.Font.Name  :=ViewB.FontName;
        MemoB.Font.Height:=ViewB.FontHeig;
        MemoB.Font.Color :=ViewB.FontColr;
        MemoB.Font.Charset:=ViewB.FCharSet;
        
        if BoolReadFromCnfg then
        begin
          MemoB.AutoFontSize:=BoolHeadSize;
        end else
        begin
          MemoB.AutoFontSize:=ViewB.AutoFontSize;
        end;

        MemoB.CharSpacing:=ViewB.CharSpacing;

        if ViewA.FontStyl='1' then
        begin
          MemoB.Font.Style:=[fsBold];
        end;

        MemoB.DataSet  :=FUseDataSet;
        MemoB.DataField:=TextA.Text;                
        PostB:=PostB+TextA.Widt;
        if PostB>=FactWidth-TextA.Widt then
        begin
          Inc(NumbB);
          PostB:=0;
          TopXB:=TopXB+ViewA.ViewHeig+ViewB.ViewHeig;
          TfrxComponent(FindComponent(ViewB.PrevCont)).Height:=TfrxComponent(FindComponent(ViewB.PrevCont)).Height+ViewA.ViewHeig+ViewB.ViewHeig;                    
        end;  
      end;
    end;
  end;  
  
  Result:=True;
end;

procedure TKzPrint.PushVariable(AVarName, Value: string);
begin
  if FListVariabl=nil then
  begin
    FListVariabl:=TStringList.Create;
  end;
  FListVariabl.Add(Format('%S=%S',[AVarName,Value]));
end;

procedure TKzPrint.PushVariable(AValueInFormat: string);
begin
  if FListVariabl=nil then
  begin
    FListVariabl:=TStringList.Create;
  end;
  FListVariabl.Add(AValueInFormat);
end;

end.

      IsFinded:=False;
      PostX   :=0;
      for N:=0 to FListCutX.Count-1 do
      begin
        CutxA:=nil;
        CutxA:=TKzPageCutX(FListCutX.Objects[N]);

        if CutxA.PageCutX >= CellA.Left  then
        begin
          CellA.PagX:=N+1;
          IsFinded  :=True;

          
          {if CellA.Widt >= CellA.PagX * FactWidth - (CellA.PagX - 1) * LockWidth then
          begin
            CellA.Widt:=CellA.PagX * CutxA.PageWidt - (CellA.PagX - 1) * LockWidth - CellA.Left;
          end;}


          //CellA.Left +
          //YXC_2013_11_05_14_47_29_more_important
          {if CellA.Widt >= CellA.PagX * FactWidth - (CellA.PagX - 1) * LockWidth then
          begin
            DoubA:=CutxA.PageWidt - LockWidth;

            CellB:=TKzCellText.Create;
            TKzCellText.CopyIt(CellA,CellB);
            CellB.Widt:=DoubA;
            CellB.PagX:=CellA.PagX+1;
            ListA.AddObject('',CellB);

            LengA:=CellA.Widt - DoubA;
            PageX:=CellB.PagX;    //second page

            CutxB:=GetObjtCutX(PageX);
            while (CutxB <> nil) and (LengA > (CutxB.PageWidt - LockWidth))  do
            begin
              CellC:=TKzCellText.Create;
              TKzCellText.CopyIt(CellB,CellC);
              CellC.Widt:=CutxB.PageWidt - LockWidth;
              CellC.PagX:=PageX;
              ListA.AddObject('',CellC);

              LengA:=LengA - CellC.Widt;
              Inc(PageX);
            end;

            CellB.Widt:=LengA-PostX;
            CellB.PagX:=PageX;

            CellA.Widt:=DoubA;
            PostX:=0;            
          end;}
          {if CellA.Left + CellA.Widt >= CellA.PagX * (FactWidth) then
          begin
            DoubA :=CutxA.PageWidt - CellA.Left;
            //DoubA:=CellB.Widt;

            CellB:=TKzCellText.Create;
            TKzCellText.CopyIt(CellA,CellB);
            CellB.Widt:=CellA.Widt - DoubA;
            //CellB.Widt :=CutxA.PageWidt - CellB.Left;

            CellB.PagX:=CellA.PagX+1;
            ListA.AddObject('',CellB);

            LengA:=CellB.Widt;
            PageX:=CellB.PagX;    //second page

            CutxB:=GetObjtCutX(PageX);
            while (CutxB <> nil) and (LengA > (CutxB.PageWidt - LockWidth))  do
            begin
              CellC:=TKzCellText.Create;
              TKzCellText.CopyIt(CellB,CellC);
              CellC.Widt:=CutxB.PageWidt - LockWidth;
              CellC.PagX:=PageX;
              ListA.AddObject('',CellC);

              LengA:=LengA - CellC.Widt;
              Inc(PageX);
            end;

            CellB.Widt:=LengA;
            CellB.PagX:=PageX;

            CellA.Widt:=DoubA;
          end;}
          Break;
        end;
      end;
      if not IsFinded then
      begin
        CellA.PagX := FListCutX.Count+1;
      end;

       if FRowHeadEnd  - FRowHeadStart >0 then
        begin
          if not HeadHeightAdded then
          begin
            FindComponent(ViewA.PrevCont).Height:=FindComponent(ViewA.PrevCont).Height+(FRowHeadEnd  - FRowHeadStart)*ViewA.ViewHeig;
            HeadHeightAdded:=True;
          end;
        end;      
