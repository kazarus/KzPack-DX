unit Class_KzExcel;
//Kazarus.Excel.From TAdvStringGrid To ExpressSpreadSheet.For D7.
//YXC_2012_02_21_10_24_44_增加支持隐藏导出
//YXC_2012_02_21_10_24_44_增加单元格黑框
//YXC_2012_02_21_10_24_44_增加ColTotal属性
//YXC_2012_02_21_10_24_44_先设置Format还是先设置Text有区别.
//YXC_2012_02_21_10_24_44_当Tools->Environment->Library->LibraryPath引用ExpressSpreadSheet.Source文件夹后会覆盖Sheet名称.
//YXC_2012_02_21_10_24_44_导出长文本时,比如662256554521015,662256554521015在运行时会报错.忽略后程序正常.
//YXC_2012_05_22_14_58_50_多表格导出时,需通过事件指定有效的导出区域
//YXC_2012_08_11_11_17_27_add_setvalidcols&setvalidrows
//YXC_2012_08_11_11_17_55_add_exenegl&exeneglall
//YXC_2012_08_11_11_18_10_add_gethorztextalign
//YXC_2012_09_14_14_26_09_modify_colxa-excursiona->colxb-excursiona
//YXC_2012_10_30_09_21_37_add_ext_.xls
//YXC_2012_10_30_09_59_28_add_datatype_cxdtdoubex
//YXC_2012_11_09_14_30_15_modify_setvalidarea
//YXC_2012_11_09_14_38_40_add_includecolssize
//ZZD_2012_11_12_11_00_00_add_setacelltext&setacellstyle
//YXC_2012_11_14_11_59_50_add_colexcursionsiz
//YXC_2012_11_21_09_36_49_not_line_at_586
//YXC_2012_12_03_17_00_48_add_insertcols&insertrows&mergecells&autonumber
//YXC_2013_01_16_13_44_55_add_tcxcellstyl.keepcelltxtstyl
//YXC_2013_08_09_16_38_58_add_tcxcellstyl.fontcolor&backcolor
//YXC_2013_09_06_11_25_29_add_stylecells


{Index	Format
$00	Default
$01	0
$02	0.00
$03	#,##0
$04	#,##0.00
$05	_($#,##0_);($#,##0)
$06	_($#,##0_);[Red]($#,##0)
$07	_($#,##0.00_);($#,##0.00)
$08	_($#,##0.00_);[Red]($#,##0.00)
$09	0%
$0A	0.00%
$0B	0.00E+00
$0C	# ?/?
$0D	# ??/??
$0E	m/d/yy
$0F	d-mmm-yy
$10	d-mmm
$11	mmmm-yy
$12	h:mm AM/PM
$13	h:mm:ss AM/PM
$14	h:mm
$15	h:mm:ss
$16	m/d/yy h:mm
$17	(#,##0_);(#,##0)
$18	(#,##0_);[Red](#,##0)
$19	(#,##0.00_);(#,##0.00)
$1A	(#,##0.00_);[Red](#,##0.00)
$1B	_(* #,##0_);_(* (#,##0);_(* "-"_);_(@_)
$1C	_($* #,##0_);_($* (#,##0);_($* "-"_);_(@_)
$1D	_(* #,##0.00_);_(* (#,##0.00);_(* "-"??_);_(@_)
$1E	_($* #,##0.00_);_($* (#,##0.00);_($* "-"??_);_(@_)
$1F	mm:ss
$20	[h]:mm:ss
$21	mm:ss.0
$22	# #0.0E+0
$23	text}


interface
uses
  Classes,SysUtils,StrUtils,Windows,Controls,Dialogs,Graphics,Math,AdvGrid,cxSSheet,
  cxSSTypes,Class_KzUtils;

type
  TKzExcel = class;
  TFkExcel = class;

  TCxDataType=(cxdtText,cxdtNumb,cxdtDoub,cxdtDate,cxdtLongText,cxdtLongTextEx,cxdtDoubEx,cxdtNumbEx);

  TCxCellStyl=class(TObject)
  public
    DataType:TCxDataType;
    FontName:string;
    FontSize:Integer;
    IsfsBold:Boolean;
    HorAlign:TcxHorzTextAlign; //Cell.HorzTextAlign
    KeepCellTxtStyl:Boolean;   //是否cella.text:=Trim(cells[1,1]),只针对cxdtlogntext和cxdttext有效
    FontColor:Integer;         //[0..55].cell.style.font.fontcolor
    BackColor:Integer;         //[0..55].cell.style.brush.backgroundcolor
  public
    function GetxlsDataFormat:Word;
  public
    constructor Create;overload;
    constructor Create(ADataType:TCxDataType);overload;
    constructor Create(ACellStyl:TCxCellStyl);overload;
  end;

  TKzGridStyl=class(TObject)
  public
    ActvGrid:TAdvStringGrid;  //actvgrid
    LablName:string;          //sheet标签
  end;

  TKzExcelGridCellStyl =procedure (Sender: TObject; AActvGrid:TAdvStringGrid; ARow, ACol: Integer;var ACellStyl:TCxCellStyl) of object;
  //procedure OnKzExcelGridCellStyl(Sender: TObject; AActvGrid:TAdvStringGrid; ARow, ACol: Integer;var ACellStyl:TCxCellStyl);
  TKzExcelGridValidArea=procedure (Sender: TObject; AActvGrid:TAdvStringGrid;var AColStart,AColEnd,ARowStart,ARowEnd:Integer) of object;
  //procedure OnKzExcelGridValidArea(Sender: TObject; AActvGrid:TAdvStringGrid;var AColStart,AColEnd,ARowStart,ARowEnd:Integer);
  TKzExcelGridValidRows=procedure (Sender: TObject; AActvGrid:TAdvStringGrid;ARow:Integer;var Valid:Boolean) of object;
  //procedure OnKzExcelGridValidRows(Sender: TObject; AActvGrid:TAdvStringGrid;ARow:Integer;var Valid:Boolean);
  TKzExcelGridValidCols=procedure (Sender: TObject; AActvGrid:TAdvStringGrid;ACol:Integer;var Valid:Boolean) of object;
  //procedure OnKzExcelGridValidCols(Sender: TObject; AActvGrid:TAdvStringGrid;ACol:Integer;var Valid:Boolean);  

  TKzExcelGetSavePath = procedure (Sender: TObject; var ASavePath:string) of object;
  //procedure OnKzExcelGetSavePath(Sender: TObject; var ASavePath:string);

  TKzExcelGetCellStyl = procedure (Sender: TObject; ARow, ACol: Integer;var ACellStyl:TCxCellStyl) of object;
  //procedure OnKzExcelGetCellStyl(Sender: TObject; ARow, ACol: Integer;var ACellStyl:TCxCellStyl);
  TKzExcelBeforeSaved = procedure (Sender: TcxSpreadSheetBook) of object;
  //procedure OnKzExcelBeforeSaved(Sender: TcxSpreadSheetBook);

  TFkExcelBeforeSaved = procedure (AFkExcel:TFkExcel;Sender: TcxSpreadSheetBook) of object;
  //procedure OnFkExcelBeforeSaved(AFkExcel:TFkExcel;Sender: TcxSpreadSheetBook);
  TFkExcelAfterSaved  = procedure (AFkExcel:TFkExcel;APath :string) of object;
  //procedure OnFkExcelAfterSaved(AFkExcel:TFkEzcel:APath :string);

  TKzExcel=class(TObject)
  private
    FCxExcel: TcxSpreadSheetBook;
    StrsRows: TStringList;       //strs of interger
    StrsCols: TStringList;       //strs of interger;
  public
    ActvGrid: TAdvStringGrid;    //TAdvStringGrid.single.
    StrsGrid: TStringList;       //strs of TAdvStringGrid.multi.
    FileName: string;            //文件名称
    ShetName: string;            //Sheet标签

    ColTotal: Integer;           //导出表格总栏目数
    
    IncludeHideCols: Boolean;    //是否包含隐藏栏目
    IncludeColsSize: Boolean;    //是否包含栏目宽度
    ColExcursionSiz: Integer;    //与IncludeColsSize有关
    ShowCellsBorder: Boolean;    //表格是否显示黑框
    ShowCellGridLin: Boolean;    //是否显示格子

    ColStart: Integer;
    ColEnd  : Integer;
    RowStart: Integer;
    RowEnd  : Integer;
    
    DefaultCellStyl:TCxCellStyl;//The Default CellStyl

    OnKzExcelGetSavePath  :TKzExcelGetSavePath;
    OnKzExcelGetCellStyl  :TKzExcelGetCellStyl;
    OnKzExcelBeforeSaved  :TKzExcelBeforeSaved;
    OnKzExcelGridCellStyl :TKzExcelGridCellStyl;
    OnKzExcelGridValidArea:TKzExcelGridValidArea;
    OnKzExcelGridValidRows:TKzExcelGridValidRows;
    OnKzExcelGridValidCols:TKzExcelGridValidCols;    
  protected
    procedure SetValidRows;
    procedure SetValidCols;
    procedure SetValidArea;overload;
    function  GetValidSheetName:string;
    function  GetValidSheetIdex:string;//Sheet1,Sheet2...
  public
    procedure SetValidArea(AColStart,AColEnd,ARowStart,ARowEnd:Integer);overload;
    procedure Initialize;

    procedure Execute;    //singl grid.not neglect rows;
    procedure ExecuteAll; //multi grid.not neglect rows;

    function  ExeNegl:Boolean;    //singl grid.has neglect rows;
    function  ExeNeglAll:Boolean; //multi grid.has neglect rows;
  public
    constructor Create;
    destructor  Destroy;override;
  public
    class function  GetHorzTextAlign(AValue:Integer):TcxHorzTextAlign;
    class procedure InsertRows(Sender:TcxSpreadSheetBook;ACount:Integer;AIndex:Integer=0;AAutoStyle:Boolean=False);overload;
    class procedure InsertCols(Sender:TcxSpreadSheetBook;ACount:Integer;AIndex:Integer=0);overload;
    class procedure StyleCells(Sender:TcxSpreadSheetBook;AFromRowIndex,AToRowIndex,AFromColIndex,AToColIndex:Integer);
    class procedure MergeCells(Sender:TcxSpreadSheetBook;AFromRowIndex,AToRowIndex:Integer;AToColIndex:Integer=-1);overload;
    class procedure AutoNumber(Sender:TcxSpreadSheetBook;AColIndex,AStartRowIndex:Integer);overload;

    //set cxSSheet
    class procedure SetACellText(ASheetBook: TcxSpreadSheetBook; ACol, ARow: Integer; AText: string;
         AFontName: TFontName='宋体'; AFontSize: Integer=10;AAlign: TcxHorzTextAlign=haCENTER);
    class procedure SetACellStyle(ASheetBook: TcxSpreadSheetBook; ACol, ARow: Integer; bBorder: array of Integer; ASheet: TcxSSBookSheet=nil);
    
  end;

  TFkExcel=class(TKzExcel) //分栏导出.Fuck.Excel.
  public
    HeadRowx:Integer;      //表头所在行
    PageCols:Integer;      //分几栏
    PageRows:Integer;      //一页打印几栏
    NeglectCrew:Boolean;
    CrewColumn:Integer;

    //YXC_2012_03_19_16_40_32
    SetPrintStyl:Boolean;
    PrintPreview:Boolean;
    Orientation :Integer;
  public
    OnFkExcelBeforeSaved:TFkExcelBeforeSaved;
    OnFkExcelAfterSaved :TFkExcelAfterSaved;  
  public
    function GetActualGrp(ACol,ARow:Integer):Integer;//横向哪一组.
    function GetActualRow(ACol,ARow:Integer):Integer;//纵向哪一行.
  public
    function TruncEx(AValue,AAxis:Integer):Integer;  //这个函数是那个啥.无论小数点,都取整.
    function GetRowx(AValue,AAxis:Integer):Integer;

  public
    procedure Execute;
  public
    destructor  Destroy;override;       
  end;

var
  KzExcel:TKzExcel;
  FkExcel:TFkExcel;

implementation

uses
  Forms;

{ TKzExcel }


constructor TKzExcel.Create;
begin
  ActvGrid:=nil;
  
  ColTotal:=-1;
  ColStart:=-1;
  ColEnd  :=-1;
  RowStart:=-1;
  RowEnd  :=-1;

  IncludeHideCols:=False;
  IncludeColsSize:=True;
  ColExcursionSiz:=0;  
  ShowCellsBorder:=False;
  ShowCellGridLin:=True;
    
  FCxExcel:=TcxSpreadSheetBook.Create(nil);
  FCxExcel.Visible:=False;
  FCxExcel.Parent :=Application.MainForm;

  DefaultCellStyl:=TCxCellStyl.Create;
end;

destructor TKzExcel.Destroy;
begin
  if FCxExcel<>nil then
  begin
    FreeAndNil(FCxExcel);
  end;

  if StrsRows<>nil then
  begin
    FreeAndNil(StrsRows);
  end;
  
  if StrsCols<>nil then
  begin
    FreeAndNil(StrsCols);
  end;  
  
  if DefaultCellStyl<>nil then
  begin
    FreeAndNil(DefaultCellStyl);
  end;  
end;

procedure TKzExcel.Execute;
var
  ColxA:Integer;
  RowxA:Integer;
  ColxB:Integer;        //范围导出时发生的列偏移
  RowxB:Integer;        //范围导出时发生的行偏移
  CellA:TCxSSCellObject;
  StylA:TCxCellStyl;
  SD   :TSaveDialog;

  PathA:string;
  TempA:string;
  NumbA:Integer;
  RectA:TRect;
  BordA:TcxSSEdgeBorder;
  ExcursionA:Integer;   //隐藏后的发生的列偏移.画格子.

  X:Integer;
  ExcursionB:Integer;   //隐藏后的发生的列偏移.取列宽.
begin
  StylA:=nil;
  CellA:=nil;
  SD   :=nil;

  if Assigned(OnKzExcelGetSavePath) then
  begin
    OnKzExcelGetSavePath(Self,PathA);
    //PathA:=PathA+FileName;    
  end else
  begin
    SD:=TSaveDialog.Create(nil);
    SD.FileName:=FileName;
    if not SD.Execute then
    begin
      FreeAndNil(SD);
      Exit;
    end;
    PathA:=Trim(SD.FileName);
  end;

  if PathA='' then
  begin
    ShowMessage('操作退出:未指定文件保存路径.');
    Exit;
  end;  

  with ActvGrid,FCxExcel do
  begin
    FCxExcel.ShowGrid:=ShowCellGridLin;
    FCxExcel.BeginUpdate;

    if FileExists(PathA) then
    begin
      TempA:='文件名己经存在.请选择导出方式:覆盖或者追加标签页.'+#13
            +'选择[是]:覆盖文件.'+#13
            +'选择[否]:追加标签页.'+#13
            +'选择[取消]:取消导出.';
            
      NumbA:=Application.MessageBox(PChar(TempA), '提示', MB_YESNOCANCEL +MB_ICONINFORMATION);

      if NumbA=mrCancel then Exit;

      if NumbA=mrNo then
      begin
        LoadFromFile(PathA);
        AddSheetPage(GetValidSheetName);
        ActivePage:=FCxExcel.PageCount-1;
      end else
      if NumbA=mrYes then 
      begin
        DeleteFile(PChar(PathA));
        if ShetName<>'' then
        begin
          ActiveSheet.Caption:=ShetName;
        end else
        begin
          ActiveSheet.Caption:=GetValidSheetName;
        end;          
      end;  
    end else
    begin
      if ShetName<>'' then
      begin
        ActiveSheet.Caption:=ShetName;
      end else
      begin
        ActiveSheet.Caption:=GetValidSheetName;
      end;  
    end;
    
    ActiveSheet.ClearAll;

    if ActvGrid <>nil then
    begin
      SetValidArea;

      ColxB:=0;
      ExcursionA:=0;

      for ColxA := ColStart to ColEnd do
      begin
        //YXC_2012_02_20_15_48_10
        if (not IncludeHideCols) then
        begin
          if IsHiddenColumn(ColxA) then
          begin
            Inc(ExcursionA);
            Continue;
          end;
        end;


        //KAZARUS:TO BE PREFECT
        //YXC_2012_11_08_16_59_47_<
        if IncludeColsSize then
        begin
          ExcursionB:=0;
          for X:=0 to ColxA do
          begin
            if IsHiddenColumn(X) then
            begin
              Inc(ExcursionB);
            end;
          end;
          ActiveSheet.Cols.Size[ColxB]:=ColWidths[ColxA-ExcursionB]+ColExcursionSiz;
        end;
        //YXC_2012_11_08_16_59_50_>

        RowxB:=0;
        for RowxA := RowStart to RowEnd do
        begin

          //YXC_2012_05_17_08_26_45_<
          if ShowCellsBorder then
          begin
            CellA:=ActiveSheet.GetCellObject(ColxB-ExcursionA,RowxA);
            for BordA := eLeft to eBottom do
            begin
              with CellA.Style.Borders.Edges[BordA] do
              begin
                Style := lsThin;
                Color := clBlack;
              end;
            end;
            CellA.Free;
          end;
          //YXC_2012_05_17_08_26_48_>

          if IsMergedCell(ColxA-ExcursionA,RowxA) then
          begin
            if not CellProperties[ColxA-ExcursionA,RowxA].IsBaseCell then
            begin
              Inc(RowxB);
              Continue;
            end;
            //未偏移
            //FCxExcel.ActiveSheet.SetMergedState(Rect(ColxA,RowxA,CellProperties[ColxA,RowxA].CellSpanX+ColxA,CellProperties[ColxA,RowxA].CellSpanY+RowxA),True);
            //有偏移
            //FCxExcel.ActiveSheet.SetMergedState(Rect(ColxB,RowxB,CellProperties[ColxA,RowxA].CellSpanX+ColxB,CellProperties[ColxA,RowxA].CellSpanY+RowxB),True);
            //有偏移,有隐藏

            //ALeft:=ColxB;
            //ATop :=RowxB;
            //ARight :=CellProperties[ColxA-ExcursionA,RowxA].CellSpanX+ColxB;
            //ABottom:=CellProperties[ColxA-ExcursionA,RowxA].CellSpanY+RowxB;
            //FCxExcel.ActiveSheet.SetMergedState(Rect(ALeft,ATop,ARight,ABottom),True);

            RectA.Left:=ColxB;
            RectA.Top :=RowxB;
            RectA.Right :=CellProperties[ColxA-ExcursionA,RowxA].CellSpanX+ColxB;
            RectA.Bottom:=CellProperties[ColxA-ExcursionA,RowxA].CellSpanY+RowxB;
            
            FCxExcel.ActiveSheet.SetMergedState(RectA,True);
          end;

          CellA:=ActiveSheet.GetCellObject(ColxB,RowxB);
          StylA:=TCxCellStyl.Create(DefaultCellStyl);
          
          {if ShowCellsBorder then
          begin
            for BordA := eLeft to eBottom do
            begin
              with CellA.Style.Borders.Edges[BordA] do
              begin
                Style := lsThin;
                Color := clBlack; 
              end;
            end;            
          end;}

          
          //YXC_2012_02_21_16_41_42_保留一段时间
          if StylA.DataType<>cxdtLongText then
          begin
            try
              if StylA.KeepCellTxtStyl then
              begin
                CellA.Text:=(Cells[ColxA,RowxA]);
              end else
              begin
                CellA.Text:=Trim(Cells[ColxA,RowxA]);
              end;  

              if StylA.DataType=cxdtDoub then
              begin
                CellA.Text:=StringReplace(CellA.Text,',','',[rfReplaceAll]);
                //CellA.Text:=FloatToStr(TKzUtils.TextToFloat(CellA.Text));
              end;
            except
            end;
          end;

          if Assigned(OnKzExcelGetCellStyl) then
          begin
            OnKzExcelGetCellStyl(FCxExcel,RowxA,ColxA,StylA);
          end;

          CellA.Style.Font.Name:=StylA.FontName;
          CellA.Style.Font.Size:=StylA.FontSize;
          CellA.Style.Font.FontColor:=StylA.FontColor;
          if StylA.IsfsBold then
          begin
            CellA.Style.Font.Style:=[fsBold];
          end;
          CellA.Style.Format       :=StylA.GetxlsDataFormat;
          CellA.Style.HorzTextAlign:=StylA.HorAlign;
          CellA.Style.VertTextAlign:=cxSSTypes.vaCENTER;
          CellA.Style.Brush.BackgroundColor:=StylA.BackColor;

          //YXC_2012_02_21_16_41_42_保留一段时间
          if (StylA.DataType=cxdtLongText) or (StylA.DataType=cxdtText) then
          begin
            try
              if StylA.KeepCellTxtStyl then
              begin
                CellA.Text:=(Cells[ColxA,RowxA]);
              end else
              begin
                CellA.Text:=Trim(Cells[ColxA,RowxA]);
              end;
            except
            end;
          end;

          CellA.Free;
          StylA.Free;
          
          Inc(RowxB);          
        end;
        
        Inc(ColxB);        
      end;
    end;
    
    FCxExcel.EndUpdate;
  end;

  if Assigned(OnKzExcelBeforeSaved) then
  begin
    OnKzExcelBeforeSaved(FCxExcel);
  end;

  if Pos('.xls',LowerCase(PathA))=0 then
  begin
    PathA:=PathA+'.xls';
  end;
  FCxExcel.SaveToFile(PathA);

  if SD<>nil then
  begin
    FreeAndNil(SD);
  end;
end;

procedure TKzExcel.SetValidArea(AColStart, AColEnd, ARowStart,
  ARowEnd: Integer);
begin
  if AColStart<>-1 then
  begin
    ColStart:=AColStart;
  end;

  if AColEnd<>-1 then
  begin
    ColEnd  :=AColEnd;
  end;

  if ARowStart<>-1 then
  begin
    RowStart:=ARowStart;
  end;

  if ARowEnd<>-1 then
  begin
    RowEnd  :=ARowEnd;
  end;  
end;

procedure TKzExcel.Initialize;
begin
  ActvGrid:=nil;
  
  ColTotal:=-1;
  ColStart:=-1;
  ColEnd  :=-1;
  RowStart:=-1;
  RowEnd  :=-1;

  IncludeHideCols:=False;
  IncludeColsSize:=True;
  ColExcursionSiz:=0;
  ShowCellsBorder:=False;
  ShowCellGridLin:=True;

  FCxExcel.History.Clear;
  FCxExcel.ShowGrid:=ShowCellGridLin;
  FCxExcel.ClearAll;
  FCxExcel.AddSheetPage();
end;

procedure TKzExcel.SetValidArea;
var
  I:Integer;
  NumbA:Integer;
begin
  if ActvGrid=nil then Exit;
  if ColStart=-1 then ColStart:=0;
  if RowStart=-1 then RowStart:=0;
  //if ColEnd  =-1 then ColEnd  :=ActvGrid.ColCount-1;
  if RowEnd  =-1 then RowEnd  :=ActvGrid.RowCount-1;

  if ColEnd  =-1 then
  begin
    ColEnd  :=ActvGrid.ColCount-1;
    if ColTotal<>-1 then ColEnd :=ColTotal-1;
  end;

  //加上隐藏列
  with ActvGrid do
  begin
    if (ColTotal<>-1) and (ActvGrid.ColCount<>ColTotal) then
    begin
      NumbA:=0;
      for I:=0 to ColStart do
      begin
        if IsHiddenColumn(I) then
        begin
          Inc(NumbA);
        end;  
      end;
      ColStart:=ColStart+NumbA;

      NumbA:=0;
      //KAZARUS:TO BE PREFECT
      //YXC_2012_11_08_17_16_59
      //for I:=0 to ColEnd do
      for I:=ColStart to ColEnd do 
      begin
        if IsHiddenColumn(I) then
        begin
          Inc(NumbA);
        end;
      end;
      ColEnd:=ColEnd+NumbA;        
    end;
  end;
end;

function TKzExcel.GetValidSheetName: string;
var
  I:Integer;
  BoolDefault:Boolean;
begin
  //YXC_2012_02_18_16_47_44
  BoolDefault:=False;

  if Trim(ShetName)='' then
  begin
    BoolDefault:=True;
  end else
  begin
    BoolDefault:=False;
    
    for I:=0 to FCxExcel.PageCount-1 do
    begin
      if FCxExcel.Pages[I].Caption=ShetName then
      begin
        BoolDefault:=True;
        Break;
      end;
    end;    
  end;

  if BoolDefault then
  begin
    Result:=GetValidSheetIdex;
  end else
  begin
    Result:=ShetName;
  end;
   
  {Result:='';
  if Trim(ShetName)='' then Exit;
  Result:=ShetName;

  for I:=0 to FCxExcel.PageCount-1 do
  begin
    if FCxExcel.Pages[I].Caption=ShetName then
    begin
      Result:='';
      Break;
    end;
  end;}    
end;

function TKzExcel.GetValidSheetIdex: string;
var
  I:Integer;
  TempA:string;
  TempB:string;

  NumbA:Integer;
  NumbB:Integer;
begin
  NumbA:=0;
  for I:=0 to FCxExcel.PageCount-1 do
  begin
    TempA:=Trim(FCxExcel.Pages[I].Caption);
    if TKzUtils.BoolStrMatchx(TempA,'^Sheet\d+',TempB) then
    begin
      if TKzUtils.BoolStrMatchx(TempA,'\d+',TempB) then
      begin
        NumbB:=StrToInt(TempB);
        NumbA:=Max(NumbA,NumbB);
      end;  
    end;   
  end;

  Result:=Format('Sheet%D',[NumbA+1]);
end;

procedure TKzExcel.ExecuteAll;
var
  I:Integer;
  ColxA:Integer;
  RowxA:Integer;
  ColxB:Integer;        //范围导出时发生的列偏移
  RowxB:Integer;        //范围导出时发生的行偏移
  CellA:TCxSSCellObject;
  StylA:TCxCellStyl;
  SD   :TSaveDialog;

  PathA:string;
  TempA:string;
  NumbA:Integer;
  RectA:TRect;
  BordA:TcxSSEdgeBorder;
  ExcursionA:Integer;   //隐藏后的发生的列偏移.画格子.

  X:Integer;
  ExcursionB:Integer;   //隐藏后的发生的列偏移.取列宽.  
begin
  StylA:=nil;
  CellA:=nil;
  SD   :=nil;
  
  if Assigned(OnKzExcelGetSavePath) then
  begin
    OnKzExcelGetSavePath(Self,PathA);
    //PathA:=PathA+FileName;    
  end else
  begin
    SD:=TSaveDialog.Create(nil);
    SD.FileName:=FileName;
    if not SD.Execute then
    begin
      FreeAndNil(SD);
      Exit;
    end;
    PathA:=Trim(SD.FileName);
  end;

  if PathA='' then
  begin
    ShowMessage('操作退出:未指定文件保存路径.');
    Exit;
  end;  

  if (StrsGrid=nil) or (StrsGrid.Count=0) then Exit;

  with FCxExcel do
  begin
    FCxExcel.ShowGrid:=ShowCellGridLin;
    FCxExcel.BeginUpdate;

    if FileExists(PathA) then
    begin
      if TKzUtils.WarnBox('文件己存在,是否覆盖?')<>Mrok then Exit;
      DeleteFile(PChar(PathA));
    end;

    FCxExcel.ClearAll;
    for I:= 0 to StrsGrid.Count-1 do
    begin
      AddSheetPage(GetValidSheetName);
      FCxExcel.Pages[FCxExcel.PageCount-1].Caption:=TKzGridStyl(StrsGrid.Objects[I]).LablName;

      ActvGrid :=TKzGridStyl(StrsGrid.Objects[I]).ActvGrid;
      ActivePage:=FCxExcel.PageCount-1;

      with ActvGrid do
      begin
        if ActvGrid <>nil then
        begin
          //YXC_2012_05_22_14_54_43_Replace by Custom Event 
          {ColEnd:=-1;
          RowEnd:=-1;}
          
          if Assigned(OnKzExcelGridValidArea) then
          begin
            OnKzExcelGridValidArea(FCxExcel,ActvGrid,ColStart,ColEnd,RowStart,RowEnd);
          end;

          SetValidArea;

          ColxB:=0;
          ExcursionA:=0;

          for ColxA := ColStart to ColEnd do
          begin
            //YXC_2012_02_20_15_48_10
            if (not IncludeHideCols) then
            begin
              if IsHiddenColumn(ColxA) then
              begin
                Inc(ExcursionA);
                Continue;
              end;
            end;

            //KAZARUS:TO BE PREFECT
            //YXC_2012_11_08_16_59_47_<
            if IncludeColsSize then
            begin
              ExcursionB:=0;
              for X:=0 to ColxA do
              begin
                if IsHiddenColumn(X) then
                begin
                  Inc(ExcursionB);
                end;
              end;
              ActiveSheet.Cols.Size[ColxB]:=ColWidths[ColxA-ExcursionB]+ColExcursionSiz;
            end;
            //YXC_2012_11_08_16_59_50_>

            RowxB:=0;
            for RowxA := RowStart to RowEnd do
            begin
              //YXC_2012_05_17_08_26_45_<
              if ShowCellsBorder then
              begin
                CellA:=ActiveSheet.GetCellObject(ColxB-ExcursionA,RowxA);
                for BordA := eLeft to eBottom do
                begin
                  with CellA.Style.Borders.Edges[BordA] do
                  begin
                    Style := lsThin;
                    Color := clBlack;
                  end;
                end;
                CellA.Free;
              end;
              //YXC_2012_05_17_08_26_48_>


              if IsMergedCell(ColxA-ExcursionA,RowxA) then
              begin
                if not CellProperties[ColxA-ExcursionA,RowxA].IsBaseCell then
                begin
                  Inc(RowxB);
                  Continue;
                end;
                //未偏移
                //FCxExcel.ActiveSheet.SetMergedState(Rect(ColxA,RowxA,CellProperties[ColxA,RowxA].CellSpanX+ColxA,CellProperties[ColxA,RowxA].CellSpanY+RowxA),True);
                //有偏移
                //FCxExcel.ActiveSheet.SetMergedState(Rect(ColxB,RowxB,CellProperties[ColxA,RowxA].CellSpanX+ColxB,CellProperties[ColxA,RowxA].CellSpanY+RowxB),True);
                //有偏移,有隐藏

                //ALeft:=ColxB;
                //ATop :=RowxB;
                //ARight :=CellProperties[ColxA-ExcursionA,RowxA].CellSpanX+ColxB;
                //ABottom:=CellProperties[ColxA-ExcursionA,RowxA].CellSpanY+RowxB;
                //FCxExcel.ActiveSheet.SetMergedState(Rect(ALeft,ATop,ARight,ABottom),True);

                RectA.Left:=ColxB;
                RectA.Top :=RowxB;
                RectA.Right :=CellProperties[ColxA-ExcursionA,RowxA].CellSpanX+ColxB;
                RectA.Bottom:=CellProperties[ColxA-ExcursionA,RowxA].CellSpanY+RowxB;

                FCxExcel.ActiveSheet.SetMergedState(RectA,True);
              end;

              CellA:=ActiveSheet.GetCellObject(ColxB,RowxB);
              StylA:=TCxCellStyl.Create(DefaultCellStyl);

              //YXC_2012_02_21_16_41_42_保留一段时间
              {if StylA.DataType<>cxdtLongText then
              begin
                try
                  CellA.Text:=Trim(Cells[ColxA,RowxA]);
                  if StylA.DataType=cxdtDoub then
                  begin
                    CellA.Text:=StringReplace(CellA.Text,',','',[rfReplaceAll]);
                    CellA.Text:=FloatToStr(TKzUtils.TextToFloat(CellA.Text));
                  end;
                except
                end;
              end;}
              if StylA.DataType<>cxdtLongText then
              begin
                try
                  if StylA.KeepCellTxtStyl then
                  begin
                    CellA.Text:=(Cells[ColxA,RowxA]);
                  end else
                  begin
                    CellA.Text:=Trim(Cells[ColxA,RowxA]);
                  end;

                  if StylA.DataType=cxdtDoub then
                  begin
                    CellA.Text:=StringReplace(CellA.Text,',','',[rfReplaceAll]);
                    //CellA.Text:=FloatToStr(TKzUtils.TextToFloat(CellA.Text));
                  end;
                except
                end;
              end;

              if Assigned(OnKzExcelGridCellStyl) then
              begin
                OnKzExcelGridCellStyl(FCxExcel,ActvGrid,RowxA,ColxA,StylA);
              end;  

              CellA.Style.Font.Name:=StylA.FontName;
              CellA.Style.Font.Size:=StylA.FontSize;
              CellA.Style.Font.FontColor:=StylA.FontColor;
              if StylA.IsfsBold then
              begin
                CellA.Style.Font.Style:=[fsBold];
              end;
              CellA.Style.Format       :=StylA.GetxlsDataFormat;
              CellA.Style.HorzTextAlign:=StylA.HorAlign;
              CellA.Style.VertTextAlign:=cxSSTypes.vaCENTER;
              CellA.Style.Brush.BackgroundColor:=StylA.BackColor;

              //YXC_2012_02_21_16_41_42_保留一段时间
              {if StylA.DataType=cxdtLongText then
              begin
                try
                  CellA.Text:=Trim(Cells[ColxA,RowxA]);
                except
                end;
              end;}
              if (StylA.DataType=cxdtLongText) or (StylA.DataType=cxdtText) then
              begin
                try
                  if StylA.KeepCellTxtStyl then
                  begin
                    CellA.Text:=(Cells[ColxA,RowxA]);
                  end else
                  begin
                    CellA.Text:=Trim(Cells[ColxA,RowxA]);
                  end;
                except
                end;
              end;              

              {if ShowCellsBorder then
              begin
                for BordA := eLeft to eBottom do
                begin
                  with CellA.Style.Borders.Edges[BordA] do
                  begin
                    Style := lsThin;
                    Color := clBlack;
                  end;
                end;
              end;}

              CellA.Free;
              StylA.Free;

              Inc(RowxB);
            end;

            Inc(ColxB);
          end;
        end;
      end;
    end;
    FCxExcel.EndUpdate;
  end;

  if Assigned(OnKzExcelBeforeSaved) then
  begin
    OnKzExcelBeforeSaved(FCxExcel);
  end;  

  if Pos('.xls',LowerCase(PathA))=0 then
  begin
    PathA:=PathA+'.xls';
  end;  
  FCxExcel.SaveToFile(PathA);

  if SD<>nil then
  begin
    FreeAndNil(SD);
  end;
end;

function TKzExcel.ExeNegl:Boolean;
var
  I,M:Integer;
  ColxA:Integer;
  RowxA:Integer;
  ColxB:Integer;        //范围导出时发生的列偏移
  RowxB:Integer;        //范围导出时发生的行偏移
  CellA:TCxSSCellObject;
  StylA:TCxCellStyl;
  SD   :TSaveDialog;

  PathA:string;
  TempA:string;
  NumbA:Integer;
  RectA:TRect;
  BordA:TcxSSEdgeBorder;
  ExcursionA:Integer;   //隐藏后的发生的列偏移.画格子.

  X:Integer;
  ExcursionB:Integer;   //隐藏后的发生的列偏移.取列宽.  
begin
  Result:=False;
  
  StylA:=nil;
  CellA:=nil;
  SD   :=nil;

  if Assigned(OnKzExcelGetSavePath) then
  begin
    OnKzExcelGetSavePath(Self,PathA);
    //PathA:=PathA+FileName;    
  end else
  begin
    SD:=TSaveDialog.Create(nil);
    SD.FileName:=FileName;
    if not SD.Execute then
    begin
      FreeAndNil(SD);
      Exit;
    end;  
    PathA:=Trim(SD.FileName);
  end;

  if PathA='' then
  begin
    ShowMessage('操作退出:未指定文件保存路径.');
    Exit;
  end;  

  with ActvGrid,FCxExcel do
  begin
    FCxExcel.ShowGrid:=ShowCellGridLin;
    FCxExcel.BeginUpdate;

    if FileExists(PathA) then
    begin
      TempA:='文件名己经存在.请选择导出方式:覆盖或者追加标签页.'+#13
            +'选择[是]:覆盖文件.'+#13
            +'选择[否]:追加标签页.'+#13
            +'选择[取消]:取消导出.';
            
      NumbA:=Application.MessageBox(PChar(TempA), '提示', MB_YESNOCANCEL +MB_ICONINFORMATION);

      if NumbA=mrCancel then Exit;

      if NumbA=mrNo then
      begin
        LoadFromFile(PathA);
        AddSheetPage(GetValidSheetName);
        ActivePage:=FCxExcel.PageCount-1;
      end else
      if NumbA=mrYes then 
      begin
        DeleteFile(PChar(PathA));
        if ShetName<>'' then
        begin
          ActiveSheet.Caption:=ShetName;
        end else
        begin
          ActiveSheet.Caption:=GetValidSheetName;
        end;          
      end;  
    end else
    begin
      if ShetName<>'' then
      begin
        ActiveSheet.Caption:=ShetName;
      end else
      begin
        ActiveSheet.Caption:=GetValidSheetName;
      end;  
    end;
    
    ActiveSheet.ClearAll;

    if ActvGrid <>nil then
    begin
      SetValidArea;

      ColxB:=0;
      ExcursionA:=0;

      SetValidCols;
      SetValidRows;

      //for ColxA := ColStart to ColEnd do
      for I:=0 to StrsCols.Count-1 do 
      begin
        ColxA:=StrToInt(StrsCols.Strings[I]);

        //YXC_2012_02_20_15_48_10
        if (not IncludeHideCols) then
        begin
          if IsHiddenColumn(ColxA) then
          begin
            Inc(ExcursionA);
            Continue;
          end;
        end;

        //KAZARUS:TO BE PREFECT
        //YXC_2012_11_08_16_59_47_<
        if IncludeColsSize then
        begin
          ExcursionB:=0;
          for X:=0 to ColxA do
          begin
            if IsHiddenColumn(X) then
            begin
              Inc(ExcursionB);
            end;
          end;
          ActiveSheet.Cols.Size[ColxB]:=ColWidths[ColxA-ExcursionB]+ColExcursionSiz;
        end;
        //YXC_2012_11_08_16_59_50_>        

        RowxB:=0;
        for M:=0 to StrsRows.Count-1 do
        //for RowxA := RowStart to RowEnd do
        begin
          RowxA:=StrToInt(StrsRows.Strings[M]);

          //YXC_2012_05_17_08_26_45_<
          if ShowCellsBorder then
          begin
            CellA:=ActiveSheet.GetCellObject(ColxB-ExcursionA,RowxB);
            for BordA := eLeft to eBottom do
            begin
              with CellA.Style.Borders.Edges[BordA] do
              begin
                Style := lsThin;
                Color := clBlack;
              end;
            end;
            CellA.Free;
          end;
          //YXC_2012_05_17_08_26_48_>

          if IsMergedCell(ColxA-ExcursionA,RowxA) then
          begin
            if not CellProperties[ColxA-ExcursionA,RowxA].IsBaseCell then
            begin
              Inc(RowxB);
              Continue;
            end;
            //未偏移
            //FCxExcel.ActiveSheet.SetMergedState(Rect(ColxA,RowxA,CellProperties[ColxA,RowxA].CellSpanX+ColxA,CellProperties[ColxA,RowxA].CellSpanY+RowxA),True);
            //有偏移
            //FCxExcel.ActiveSheet.SetMergedState(Rect(ColxB,RowxB,CellProperties[ColxA,RowxA].CellSpanX+ColxB,CellProperties[ColxA,RowxA].CellSpanY+RowxB),True);
            //有偏移,有隐藏

            //ALeft:=ColxB;
            //ATop :=RowxB;
            //ARight :=CellProperties[ColxA-ExcursionA,RowxA].CellSpanX+ColxB;
            //ABottom:=CellProperties[ColxA-ExcursionA,RowxA].CellSpanY+RowxB;
            //FCxExcel.ActiveSheet.SetMergedState(Rect(ALeft,ATop,ARight,ABottom),True);

            RectA.Left:=ColxB;
            RectA.Top :=RowxB;
            RectA.Right :=CellProperties[ColxA-ExcursionA,RowxA].CellSpanX+ColxB;
            RectA.Bottom:=CellProperties[ColxA-ExcursionA,RowxA].CellSpanY+RowxB;
            
            FCxExcel.ActiveSheet.SetMergedState(RectA,True);
          end;

          CellA:=ActiveSheet.GetCellObject(ColxB,RowxB);
          StylA:=TCxCellStyl.Create(DefaultCellStyl);
          
          {if ShowCellsBorder then
          begin
            for BordA := eLeft to eBottom do
            begin
              with CellA.Style.Borders.Edges[BordA] do
              begin
                Style := lsThin;
                Color := clBlack; 
              end;
            end;            
          end;}

          
          //YXC_2012_02_21_16_41_42_保留一段时间
          {if StylA.DataType<>cxdtLongText then
          begin
            try
              CellA.Text:=Trim(Cells[ColxA,RowxA]);
              if StylA.DataType=cxdtDoub then
              begin
                CellA.Text:=StringReplace(CellA.Text,',','',[rfReplaceAll]);
              end;
            except
            end;
          end;}
          if StylA.DataType<>cxdtLongText then
          begin
            try
              if StylA.KeepCellTxtStyl then
              begin
                CellA.Text:=(Cells[ColxA,RowxA]);
              end else
              begin
                CellA.Text:=Trim(Cells[ColxA,RowxA]);
              end;  

              if StylA.DataType=cxdtDoub then
              begin
                CellA.Text:=StringReplace(CellA.Text,',','',[rfReplaceAll]);
                //CellA.Text:=FloatToStr(TKzUtils.TextToFloat(CellA.Text));
              end;
            except
            end;
          end;          

          if Assigned(OnKzExcelGetCellStyl) then
          begin
            OnKzExcelGetCellStyl(FCxExcel,RowxA,ColxA,StylA);
          end;

          CellA.Style.Font.Name:=StylA.FontName;
          CellA.Style.Font.Size:=StylA.FontSize;
          CellA.Style.Font.FontColor:=StylA.FontColor;          
          if StylA.IsfsBold then
          begin
            CellA.Style.Font.Style:=[fsBold];
          end;
          CellA.Style.Format       :=StylA.GetxlsDataFormat;
          CellA.Style.HorzTextAlign:=StylA.HorAlign;
          CellA.Style.VertTextAlign:=cxSSTypes.vaCENTER;
          CellA.Style.Brush.BackgroundColor:=StylA.BackColor;

          //YXC_2012_02_21_16_41_42_保留一段时间
          {if StylA.DataType=cxdtLongText then
          begin
            try
              CellA.Text:=Trim(Cells[ColxA,RowxA]);
            except
            end;
          end;}
          if (StylA.DataType=cxdtLongText) or (StylA.DataType=cxdtText) then
          begin
            try
              if StylA.KeepCellTxtStyl then
              begin
                CellA.Text:=(Cells[ColxA,RowxA]);
              end else
              begin
                CellA.Text:=Trim(Cells[ColxA,RowxA]);
              end;
            except
            end;
          end;          

          CellA.Free;
          StylA.Free;
          
          Inc(RowxB);          
        end;
        
        Inc(ColxB);        
      end;
    end;
    
    FCxExcel.EndUpdate;
  end;

  if Assigned(OnKzExcelBeforeSaved) then
  begin
    OnKzExcelBeforeSaved(FCxExcel);
  end;

  if Pos('.xls',LowerCase(PathA))=0 then
  begin
    PathA:=PathA+'.xls';
  end;  
  FCxExcel.SaveToFile(PathA);

  if SD<>nil then
  begin
    FreeAndNil(SD);
  end;

  Result:=True;
end;

procedure TKzExcel.SetValidRows;
var
  I:Integer;
  Valid:Boolean;
begin
  Valid:=True;

  if StrsRows=nil then
  begin
    StrsRows:=TStringList.Create;
  end else
  begin
    StrsRows.Clear;
  end;    

  with ActvGrid do
  begin
    for I := RowStart to RowEnd do
    begin
      Valid:=True;
      if Assigned(OnKzExcelGridValidRows) then
      begin
        OnKzExcelGridValidRows(FCxExcel,ActvGrid,I,Valid);
      end;

      if Valid then
      begin
        StrsRows.Add(IntToStr(I));
      end;  
    end;
  end;
end;

function TKzExcel.ExeNeglAll:Boolean;
var
  I,M:Integer;
  ColxA:Integer;
  RowxA:Integer;
  ColxB:Integer;        //范围导出时发生的列偏移
  RowxB:Integer;        //范围导出时发生的行偏移
  CellA:TCxSSCellObject;
  StylA:TCxCellStyl;
  SD   :TSaveDialog;

  PathA:string;
  TempA:string;
  NumbA:Integer;
  RectA:TRect;
  BordA:TcxSSEdgeBorder;
  ExcursionA:Integer;   //隐藏后的发生的列偏移.画格子.

  X:Integer;
  ExcursionB:Integer;   //隐藏后的发生的列偏移.取列宽.  
begin
  Result:=False;
  
  StylA:=nil;
  CellA:=nil;
  SD   :=nil;
  
  if Assigned(OnKzExcelGetSavePath) then
  begin
    OnKzExcelGetSavePath(Self,PathA);
    //PathA:=PathA+FileName;    
  end else
  begin
    SD:=TSaveDialog.Create(nil);
    SD.FileName:=FileName;
    if not SD.Execute then
    begin
      FreeAndNil(SD);
      Exit;
    end;
    PathA:=Trim(SD.FileName);
  end;

  if PathA='' then
  begin
    ShowMessage('操作退出:未指定文件保存路径.');
    Exit;
  end;  

  if (StrsGrid=nil) or (StrsGrid.Count=0) then Exit;

  with FCxExcel do
  begin
    FCxExcel.ShowGrid:=ShowCellGridLin;
    FCxExcel.BeginUpdate;

    if FileExists(PathA) then
    begin
      if TKzUtils.WarnBox('文件己存在,是否覆盖?')<>Mrok then Exit;
      DeleteFile(PChar(PathA));
    end;

    FCxExcel.ClearAll;
    for I:= 0 to StrsGrid.Count-1 do
    begin
      AddSheetPage(GetValidSheetName);
      FCxExcel.Pages[FCxExcel.PageCount-1].Caption:=TKzGridStyl(StrsGrid.Objects[I]).LablName;

      ActvGrid :=TKzGridStyl(StrsGrid.Objects[I]).ActvGrid;
      ActivePage:=FCxExcel.PageCount-1;

      with ActvGrid do
      begin
        if ActvGrid <>nil then
        begin
          //YXC_2012_05_22_14_54_43_Replace by Custom Event 
          {ColEnd:=-1;
          RowEnd:=-1;}
          
          if Assigned(OnKzExcelGridValidArea) then
          begin
            OnKzExcelGridValidArea(FCxExcel,ActvGrid,ColStart,ColEnd,RowStart,RowEnd);
          end;

          SetValidArea;

          ColxB:=0;
          ExcursionA:=0;

          SetValidRows;

          for ColxA := ColStart to ColEnd do
          begin
            //YXC_2012_02_20_15_48_10
            if (not IncludeHideCols) then
            begin
              if IsHiddenColumn(ColxA) then
              begin
                Inc(ExcursionA);
                Continue;
              end;
            end;

            //KAZARUS:TO BE PREFECT
            //YXC_2012_11_08_16_59_47_<
            if IncludeColsSize then
            begin
              ExcursionB:=0;
              for X:=0 to ColxA do
              begin
                if IsHiddenColumn(X) then
                begin
                  Inc(ExcursionB);
                end;
              end;
              ActiveSheet.Cols.Size[ColxB]:=ColWidths[ColxA-ExcursionB]+ColExcursionSiz;
            end;
            //YXC_2012_11_08_16_59_50_>            

            RowxB:=0;
            //for RowxA := RowStart to RowEnd do
            for M:=0 to StrsRows.Count-1 do
            begin
              RowxA:=StrToInt(StrsRows.Strings[M]);

              //YXC_2012_05_17_08_26_45_<
              if ShowCellsBorder then
              begin
                CellA:=ActiveSheet.GetCellObject(ColxB-ExcursionA,RowxB);
                for BordA := eLeft to eBottom do
                begin
                  with CellA.Style.Borders.Edges[BordA] do
                  begin
                    Style := lsThin;
                    Color := clBlack;
                  end;
                end;
                CellA.Free;
              end;
              //YXC_2012_05_17_08_26_48_>


              if IsMergedCell(ColxA-ExcursionA,RowxA) then
              begin
                if not CellProperties[ColxA-ExcursionA,RowxA].IsBaseCell then
                begin
                  Inc(RowxB);
                  Continue;
                end;
                //未偏移
                //FCxExcel.ActiveSheet.SetMergedState(Rect(ColxA,RowxA,CellProperties[ColxA,RowxA].CellSpanX+ColxA,CellProperties[ColxA,RowxA].CellSpanY+RowxA),True);
                //有偏移
                //FCxExcel.ActiveSheet.SetMergedState(Rect(ColxB,RowxB,CellProperties[ColxA,RowxA].CellSpanX+ColxB,CellProperties[ColxA,RowxA].CellSpanY+RowxB),True);
                //有偏移,有隐藏

                //ALeft:=ColxB;
                //ATop :=RowxB;
                //ARight :=CellProperties[ColxA-ExcursionA,RowxA].CellSpanX+ColxB;
                //ABottom:=CellProperties[ColxA-ExcursionA,RowxA].CellSpanY+RowxB;
                //FCxExcel.ActiveSheet.SetMergedState(Rect(ALeft,ATop,ARight,ABottom),True);

                RectA.Left:=ColxB;
                RectA.Top :=RowxB;
                RectA.Right :=CellProperties[ColxA-ExcursionA,RowxA].CellSpanX+ColxB;
                RectA.Bottom:=CellProperties[ColxA-ExcursionA,RowxA].CellSpanY+RowxB;

                FCxExcel.ActiveSheet.SetMergedState(RectA,True);
              end;

              CellA:=ActiveSheet.GetCellObject(ColxB,RowxB);
              StylA:=TCxCellStyl.Create(DefaultCellStyl);

              //YXC_2012_02_21_16_41_42_保留一段时间
              {if StylA.DataType<>cxdtLongText then
              begin
                try
                  CellA.Text:=Trim(Cells[ColxA,RowxA]);
                  if StylA.DataType=cxdtDoub then
                  begin
                    CellA.Text:=StringReplace(CellA.Text,',','',[rfReplaceAll]);
                  end;
                except
                end;
              end;}
              if StylA.DataType<>cxdtLongText then
              begin
                try
                  if StylA.KeepCellTxtStyl then
                  begin
                    CellA.Text:=(Cells[ColxA,RowxA]);
                  end else
                  begin
                    CellA.Text:=Trim(Cells[ColxA,RowxA]);
                  end;  

                  if StylA.DataType=cxdtDoub then
                  begin
                    CellA.Text:=StringReplace(CellA.Text,',','',[rfReplaceAll]);
                    //CellA.Text:=FloatToStr(TKzUtils.TextToFloat(CellA.Text));
                  end;
                except
                end;
              end;              

              if Assigned(OnKzExcelGridCellStyl) then
              begin
                OnKzExcelGridCellStyl(FCxExcel,ActvGrid,RowxA,ColxA,StylA);
              end;  

              CellA.Style.Font.Name:=StylA.FontName;
              CellA.Style.Font.Size:=StylA.FontSize;
              CellA.Style.Font.FontColor:=StylA.FontColor;              
              if StylA.IsfsBold then
              begin
                CellA.Style.Font.Style:=[fsBold];
              end;
              CellA.Style.Format       :=StylA.GetxlsDataFormat;
              CellA.Style.HorzTextAlign:=StylA.HorAlign;
              CellA.Style.VertTextAlign:=cxSSTypes.vaCENTER;
              CellA.Style.Brush.BackgroundColor:=StylA.BackColor;

              //YXC_2012_02_21_16_41_42_保留一段时间
              {if StylA.DataType=cxdtLongText then
              begin
                try
                  CellA.Text:=Trim(Cells[ColxA,RowxA]);
                except
                end;
              end;}
              
              if (StylA.DataType=cxdtLongText) or (StylA.DataType=cxdtText) then
              begin
                try
                  if StylA.KeepCellTxtStyl then
                  begin
                    CellA.Text:=(Cells[ColxA,RowxA]);
                  end else
                  begin
                    CellA.Text:=Trim(Cells[ColxA,RowxA]);
                  end;
                except
                end;
              end;              

              {if ShowCellsBorder then
              begin
                for BordA := eLeft to eBottom do
                begin
                  with CellA.Style.Borders.Edges[BordA] do
                  begin
                    Style := lsThin;
                    Color := clBlack;
                  end;
                end;
              end;}

              CellA.Free;
              StylA.Free;

              Inc(RowxB);
            end;

            Inc(ColxB);
          end;
        end;
      end;
    end;
    FCxExcel.EndUpdate;
  end;

  if Assigned(OnKzExcelBeforeSaved) then
  begin
    OnKzExcelBeforeSaved(FCxExcel);
  end;  

  if Pos('.xls',LowerCase(PathA))=0 then
  begin
    PathA:=PathA+'.xls';
  end;  
  FCxExcel.SaveToFile(PathA);

  if SD<>nil then
  begin
    FreeAndNil(SD);
  end;

  Result:=True;
end;

procedure TKzExcel.SetValidCols;
var
  I:Integer;
  Valid:Boolean;
begin
  Valid:=True;

  if StrsCols=nil then
  begin
    StrsCols:=TStringList.Create;
  end else
  begin
    StrsCols.Clear;
  end;    

  with ActvGrid do
  begin
    for I := ColStart to ColEnd do
    begin
      Valid:=True;
      if Assigned(OnKzExcelGridValidCols) then
      begin
        OnKzExcelGridValidCols(FCxExcel,ActvGrid,I,Valid);
      end;

      if Valid then
      begin
        StrsCols.Add(IntToStr(I));
      end;  
    end;
  end;
end;

class function TKzExcel.GetHorzTextAlign(
  AValue: Integer): TcxHorzTextAlign;
begin
  Result:=cxSSTypes.haLEFT;
  if AValue=2 then
  begin
    Result:=cxSSTypes.haCENTER;
  end else
  if AValue=3 then 
  begin
    Result:=cxSSTypes.haRIGHT;
  end;    
end;

class procedure TKzExcel.InsertCols(Sender: TcxSpreadSheetBook; ACount,
  AIndex: Integer);
var
  I:Integer;
  RectA:TRect;
begin
  with Sender do
  begin
    BeginUpdate;
    
    RectA.Left  :=0;
    RectA.Top   :=0;
    RectA.Right :=0;
    RectA.Bottom:=0;

    for I:=1 to ACount do
    begin
      ActiveSheet.InsertCells(RectA,msAllCol);
    end;

    EndUpdate;
  end;
end;

class procedure TKzExcel.InsertRows(Sender: TcxSpreadSheetBook; ACount,
  AIndex: Integer;AAutoStyle:Boolean);
var
  I:Integer;
  RectA:TRect;
begin
  with Sender do
  begin
    BeginUpdate;

    RectA.Left  :=0;
    RectA.Top   :=0;
    RectA.Right :=0;
    RectA.Bottom:=0;

    for I:=1 to ACount do
    begin
      ActiveSheet.InsertCells(RectA,msAllRow);
    end;

    EndUpdate; 
  end;
end;

class procedure TKzExcel.MergeCells(Sender:TcxSpreadSheetBook;AFromRowIndex,AToRowIndex:Integer;AToColIndex:Integer);
var
  RectA:TRect;  
begin
  with Sender do
  begin
    RectA.Left  :=0;
    RectA.Top   :=AFromRowIndex;

    RectA.Right :=AToColIndex;
    if RectA.Right=-1 then
    begin
      RectA.Right :=ActiveSheet.ContentColCount-1;
    end;
    RectA.Bottom:=AToRowIndex;

    ActiveSheet.SetMergedState(RectA,True);
  end;  
end;

class procedure TKzExcel.AutoNumber(Sender: TcxSpreadSheetBook; AColIndex,
  AStartRowIndex: Integer);
var
  I:Integer;
  CellA:TcxSSCellObject;
  NumbA:Integer; 
begin
  NumbA:=0;
  
  with Sender do
  begin
    BeginUpdate;

    for I:=AStartRowIndex  to ActiveSheet.ContentRowCount-1 do
    begin
      Inc(NumbA);
      
      CellA:=ActiveSheet.GetCellObject(AColIndex,I);
      CellA.Text:=IntToStr(NumbA);
      CellA.Style.Format:=$01;
      CellA.Style.Font.Name:='宋体';
      CellA.Style.Font.Size:=10;
      CellA.Style.HorzTextAlign:=haCENTER;
      CellA.Free;
    end;
    
    EndUpdate;
  end;  
end;

class procedure TKzExcel.StyleCells(Sender: TcxSpreadSheetBook;
  AFromRowIndex, AToRowIndex, AFromColIndex, AToColIndex: Integer);
var
  I,M:Integer;

  CellA:TcxSSCellObject;
  BordA:TcxSSEdgeBorder;  
begin
  with Sender do
  begin
    BeginUpdate;

    for I:=AFromColIndex to AToColIndex do
    begin
      for M:=AFromRowIndex to AToRowIndex do
      begin
        CellA:=ActiveSheet.GetCellObject(I,M);
        CellA.Style.Font.Name:='宋体';
        CellA.Style.Font.Size:=10;
        for BordA := eLeft to eBottom do
        begin
          with CellA.Style.Borders.Edges[BordA] do
          begin
            Style := lsThin;
            Color := clBlack;
          end;
        end;
        CellA.Free;
      end;
    end;

    EndUpdate;  
  end;  
end;

{ TCxCellStyl }

constructor TCxCellStyl.Create;
begin
  DataType:=cxdtText;
  FontName:='宋体';
  FontSize:=10;
  FontColor:=0;
  IsfsBold:=False;
  HorAlign:=haLEFT;
  KeepCellTxtStyl:=False;
  BackColor:=1;
end;

constructor TCxCellStyl.Create(ADataType: TCxDataType);
begin
  DataType:=ADataType;
  FontName:='宋体';
  FontSize:=10;
  FontColor:=0;
  IsfsBold:=False;
  HorAlign:=haLEFT;
  KeepCellTxtStyl:=False;
  BackColor:=1;
end;

constructor TCxCellStyl.Create(ACellStyl: TCxCellStyl);
begin
  DataType:=ACellStyl.DataType;
  FontName:=ACellStyl.FontName;
  FontSize:=ACellStyl.FontSize;
  FontColor:=ACellStyl.FontColor;
  IsfsBold:=ACellStyl.IsfsBold;
  HorAlign:=ACellStyl.HorAlign;
  KeepCellTxtStyl:=ACellStyl.KeepCellTxtStyl;
  BackColor:=ACellStyl.BackColor;
end;

function TCxCellStyl.GetxlsDataFormat: Word;
begin
  Result:=$00;

  case DataType of
    cxdtText :Result:=$00;
    cxdtNumb :Result:=$01;
    cxdtDoub :Result:=$04;
    cxdtDate :Result:=$0E;
    cxdtLongText  :Result:=$22;//老版本.TcxSpreadSheetBook.长字段类型
    cxdtLongTextEx:Result:=$23;//新版本.TcxSpreadSheetBook.长字段类型
    cxdtDoubEx    :Result:=$03;//没有角分的数据值类型.
    cxdtNumbEx    :Result:=$02;//    
  end;
end;

{initialization
begin
  KzExcel:=TKzExcel.Create;
end;

finalization
begin
  if KzExcel<>nil then
  begin
    FreeAndNil(KzExcel);
  end;
end;}

{ TFkExcel }

destructor TFkExcel.Destroy;
begin

  inherited;
end;

procedure TFkExcel.Execute;
var
  I,M:Integer;
  ColxA:Integer;
  RowxA:Integer;
  ColxB:Integer;        //范围导出时发生的列偏移
  RowxB:Integer;        //范围导出时发生的行偏移

  CellA:TCxSSCellObject;
  StylA:TCxCellStyl;
  SD   :TSaveDialog;

  TempA:string;
  NumbA:Integer;

  BordA:TcxSSEdgeBorder;

  Count:Integer;
begin
  StylA:=nil;
  CellA:=nil;
  
  SD:=TSaveDialog.Create(nil);
  SD.FileName:=FileName;
  if not SD.Execute then
  begin
    FreeAndNil(SD);
    Exit;
  end;

  with ActvGrid,FCxExcel do
  begin
    FCxExcel.BeginUpdate;

    if FileExists(SD.FileName) then
    begin
      TempA:='文件名己经存在.请选择导出方式:覆盖或者追加标签页.'+#13
            +'选择[是]:覆盖文件.'+#13
            +'选择[否]:追加标签页.'+#13
            +'选择[取消]:取消导出.';
            
      NumbA:=Application.MessageBox(PChar(TempA), '提示', MB_YESNOCANCEL +MB_ICONINFORMATION);

      if NumbA=mrCancel then Exit;

      if NumbA=mrNo then
      begin
        LoadFromFile(SD.FileName);
        AddSheetPage(GetValidSheetName);
        ActivePage:=FCxExcel.PageCount-1;
      end else
      if NumbA=mrYes then 
      begin
        DeleteFile(PChar(SD.FileName));
        if ShetName<>'' then
        begin
          ActiveSheet.Caption:=ShetName;
        end else
        begin
          ActiveSheet.Caption:=GetValidSheetName;
        end;          
      end;  
    end else
    begin
      if ShetName<>'' then
      begin
        ActiveSheet.Caption:=ShetName;
      end else
      begin
        ActiveSheet.Caption:=GetValidSheetName;
      end;  
    end;
    
    ActiveSheet.ClearAll;

    if ActvGrid <>nil then
    begin
      SetValidArea;
      //
      ColxA:=1;
      RowxA:=1;

      for I:=ColStart to ColEnd do
      begin
        RowxA:=1;

        if NeglectCrew then
        begin
          if I=2 then Continue;
        end;  
        
        for M:=RowStart to RowEnd do
        begin
          ColxB:=GetActualGrp(ColxA,RowxA);
          RowxB:=GetActualRow(ColxA,RowxA);
          CellA:=ActiveSheet.GetCellObject(ColxB-1,RowxB-1);

          //YXC_2012_03_14_17_30_57_<
          StylA:=TCxCellStyl.Create(DefaultCellStyl);
          if StylA.DataType<>cxdtLongText then
          begin
            try
              CellA.Text:=ActvGrid.Cells[I,M];
              if StylA.DataType=cxdtDoub then
              begin
                CellA.Text:=StringReplace(CellA.Text,',','',[rfReplaceAll]);
                //CellA.Text:=FloatToStr(TKzUtils.TextToFloat(CellA.Text));
              end;
            except
            end;
          end;

          if Assigned(OnKzExcelGetCellStyl) then
          begin
            OnKzExcelGetCellStyl(FCxExcel,M,I,StylA);
          end;

          CellA.Style.Font.Name:=StylA.FontName;
          CellA.Style.Font.Size:=StylA.FontSize;
          CellA.Style.Font.FontColor:=StylA.FontColor;          
          if StylA.IsfsBold then
          begin
            CellA.Style.Font.Style:=[fsBold];
          end;
          CellA.Style.Format       :=StylA.GetxlsDataFormat;
          CellA.Style.HorzTextAlign:=StylA.HorAlign;
          CellA.Style.VertTextAlign:=cxSSTypes.vaCENTER;
          CellA.Style.Brush.BackgroundColor:=StylA.BackColor;

          if StylA.DataType=cxdtLongText then
          begin
            try
              CellA.Text:=ActvGrid.Cells[I,M];
            except
            end;
          end;

          if ShowCellsBorder then
          begin
            for BordA := eLeft to eBottom do
            begin
              with CellA.Style.Borders.Edges[BordA] do
              begin
                Style := lsThin;
                Color := clBlack; 
              end;
            end;            
          end;  
          //YXC_2012_03_14_17_30_42_>

          CellA.Free;
          StylA.Free;

          Inc(RowxA);
        end;
        Inc(ColxA);
      end;

      //YXC_2012_03_19_14_47_45_<
      //at here
      RowxB:=ActiveSheet.ContentColCount-2;
      Count:=ColEnd-ColStart+1;
      if NeglectCrew then
      begin
        Dec(Count);
      end;

      for I:=1 to RowxB+1 do
      begin
        ColxA:=I mod Count;
        if ColxA=0 then ColxA:=Count;

        if NeglectCrew then
        begin
          if ColxA>=2 then Inc(ColxA);
        end;  
        
        CellA:=ActiveSheet.GetCellObject(I-1,0);
        //CellA.Text:=Cells[ColxA,0];//replace the headrow;

        StylA:=TCxCellStyl.Create(DefaultCellStyl);
        if StylA.DataType<>cxdtLongText then
        begin
          try
            CellA.Text:=ActvGrid.Cells[ColxA,HeadRowx];
            if StylA.DataType=cxdtDoub then
            begin
              CellA.Text:=StringReplace(CellA.Text,',','',[rfReplaceAll]);
              //CellA.Text:=FloatToStr(TKzUtils.TextToFloat(CellA.Text));
            end;
          except
          end;
        end;

        if Assigned(OnKzExcelGetCellStyl) then
        begin
          OnKzExcelGetCellStyl(FCxExcel,RowxA,ColxA,StylA);
        end;

        CellA.Style.Font.Name:=StylA.FontName;
        CellA.Style.Font.Size:=StylA.FontSize;
        CellA.Style.Font.FontColor:=StylA.FontColor;        
        if StylA.IsfsBold then
        begin
          CellA.Style.Font.Style:=[fsBold];
        end;
        CellA.Style.Format       :=StylA.GetxlsDataFormat;
        CellA.Style.HorzTextAlign:=StylA.HorAlign;
        CellA.Style.VertTextAlign:=cxSSTypes.vaCENTER;
        CellA.Style.Brush.BackgroundColor:=StylA.BackColor;

        if StylA.DataType=cxdtLongText then
        begin
          try
            CellA.Text:=ActvGrid.Cells[ColxA,HeadRowx];
          except
          end;
        end;

        if ShowCellsBorder then
        begin
          for BordA := eLeft to eBottom do
          begin
            with CellA.Style.Borders.Edges[BordA] do
            begin
              Style := lsThin;
              Color := clBlack; 
            end;
          end;            
        end;
        
        CellA.Free;
      end;
      //YXC_2012_03_19_14_47_50_>      
    end;
    FCxExcel.EndUpdate;
  end;

  if Assigned(OnFkExcelBeforeSaved) then
  begin
    OnFkExcelBeforeSaved(Self,FCxExcel);
  end;

  FCxExcel.SaveToFile(SD.FileName);

  if Assigned(OnFkExcelAfterSaved) then
  begin
    OnFkExcelAfterSaved(Self,SD.FileName);
  end;  
    
  FreeAndNil(SD);  
end;

function TFkExcel.GetActualGrp(ACol, ARow: Integer): Integer;
var
  AreaA:Integer;
  NumbA:Integer;
begin
  AreaA:=PageRows * PageCols;
  Result:=ARow mod AreaA;
  Result:=TruncEx(Result,PageRows);

  //为什么是3
  if Result=0 then
  begin
    Result:=PageCols;
  end;

  NumbA :=ColEnd - ColStart +1;
  
  if (ColStart < CrewColumn) and (NeglectCrew) then
  begin
    Dec(NumbA);
  end;   

  Result:=(Result-1)*NumbA +ACol;
end;

function TFkExcel.GetActualRow(ACol, ARow: Integer): Integer;
var
  AreaA:Integer;
begin
  AreaA:=PageRows * PageCols;

  Result:=ARow mod AreaA;
  Result:=GetRowx(Result,PageRows);

  //Result:=(TruncEx(ARow,AreaA)-1) * (PageRows+1)+1 +Result;
  Result:=(TruncEx(ARow,AreaA)-1) * (PageRows)+1 +Result;  
end;


function TFkExcel.GetRowx(AValue, AAxis: Integer): Integer;
begin
  Result:= AValue mod AAxis;
  if Result=0 then
  begin
    Result:=AAxis;
  end;
end;

class procedure TKzExcel.SetACellStyle(ASheetBook: TcxSpreadSheetBook; ACol, ARow: Integer;
  bBorder: array of Integer; ASheet: TcxSSBookSheet);
var
  ACell : TcxSSCellObject;
  Border: TcxSSEdgeBorder;
begin
  ASheetBook.EndUpdate;
  try
    ACell:=ASheetBook.ActiveSheet.GetCellObject(ACol,ARow);
    with ACell do
    for Border:=eLeft to eBottom do
    begin
      if ((Border=eleft) and (bBorder[0]=1)) or
         ((Border=eTop) and (bBorder[1]=1)) or
         ((Border=eRight) and (bBorder[2]=1)) or
         ((Border=eBottom) and (bBorder[3]=1))
      then
      with Style.Borders.Edges[Border] do
      begin
        Style := lsThin;
        Color := clBlack; //   clGreen 3;}
      end;
    end;
  finally
    ACell.Free;
    ASheetBook.EndUpdate;
  end;    
end;

class procedure TKzExcel.SetACellText(ASheetBook: TcxSpreadSheetBook; ACol,
  ARow: Integer; AText: string; AFontName: TFontName; AFontSize: Integer;AAlign: TcxHorzTextAlign);
var
  ACell: TcxSSCellObject;
begin
  ASheetBook.BeginUpdate; 
  try
    ACell:=ASheetBook.ActiveSheet.GetCellObject(ACol,ARow);
    ACell.Text:= AText;
    ACell.Style.Font.Size:=AFontSize;
    if AFontSize>15 then
      ACell.Style.Font.Style:= [fsBold];
    ACell.Style.Font.Name:=AFontName;
    ACell.Style.HorzTextAlign:=AAlign;
  finally
    ACell.Free;
    ASheetBook.EndUpdate;
  end;
end;

function TFkExcel.TruncEx(AValue, AAxis: Integer): Integer;
var
  I:Integer;
begin
  Result:=Trunc(AValue / AAxis);

  if (AValue mod AAxis) >0 then
  begin
    Inc(Result);
  end;
end;


end.
