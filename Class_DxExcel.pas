unit Class_DxExcel;
//Kazarus.Excel.From TAdvStringGrid To ExpressSpreadSheet.For D7.
//YXC_2012_02_21_10_24_44_����֧�����ص���
//YXC_2012_02_21_10_24_44_���ӵ�Ԫ��ڿ�
//YXC_2012_02_21_10_24_44_����ColTotal����
//YXC_2012_02_21_10_24_44_������Format����������Text������.
//YXC_2012_02_21_10_24_44_��Tools->Environment->Library->LibraryPath����ExpressSpreadSheet.Source�ļ��к�Ḳ��Sheet����.
//YXC_2012_02_21_10_24_44_�������ı�ʱ,����662256554521015,662256554521015������ʱ�ᱨ��.���Ժ��������.
//YXC_2012_05_22_14_58_50_���񵼳�ʱ,��ͨ���¼�ָ����Ч�ĵ�������
//YXC_2012_08_11_11_17_27_add_setvalidcols&setvalidrows
//YXC_2012_08_11_11_17_55_add_exenegl&exeneglall
//YXC_2012_08_11_11_18_10_add_gethorztextalign
//YXC_2012_09_14_14_26_09_modify_ColInGrid-excursiona->ColInExcl-excursiona
//YXC_2012_10_30_09_21_37_add_ext_.xls
//YXC_2012_10_30_09_59_28_add_datatype_cxdtdoubex
//YXC_2012_11_09_14_30_15_modify_setvalidarea
//YXC_2012_11_09_14_38_40_add_includecolssize
//ZZD_2012_11_12_11_00_00_add_setacelltext&setacellstyle
//YXC_2012_11_14_11_59_50_add_colexcursionsiz
//YXC_2012_11_21_09_36_49_not_line_at_586
//YXC_2012_12_03_17_00_48_add_insertcols&insertrows&mergecells&autonumber
//YXC_2013_01_16_13_44_55_add_TDxCellStyl.keepcelltxtstyl
//YXC_2013_08_09_16_38_58_add_TDxCellStyl.fontcolor&backcolor
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
  Classes,SysUtils,StrUtils,Windows,Controls,Dialogs,Graphics,Math,AdvGrid,dxSpreadSheet,
  dxSpreadSheetTypes,Class_KzUtils,dxSpreadSheetClasses,dxSpreadSheetCore,dxSpreadSheetGraphics,
  dxCore;

type
  TDxExcel = class;

  TDxDataType=(cxdtText,cxdtNumb,cxdtDoub,cxdtDate,cxdtLongText,cxdtLongTextEx,cxdtDoubEx,cxdtNumbEx);

  TDxCellData=class(TObject)
  public
    ListData:TStringList;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TDxCellStyl=class(TObject)
  public
    DataType:TDxDataType;
    FontName:string;
    FontSize:Integer;
    IsfsBold:Boolean;
    //HorAlign:tdx; //Cell.HorzTextAlign
    KeepCellTxtStyl:Boolean;   //�Ƿ�cella.text:=Trim(cells[1,1]),ֻ���cxdtlogntext��cxdttext��Ч
    FontColor:Integer;         //[0..55].cell.style.font.fontcolor
    BackColor:Integer;         //[0..55].cell.style.brush.backgroundcolor
  public
    function GetxlsDataFormat:Word;overload;
  public
    constructor Create;overload;
    constructor Create(ADataType:TDxDataType);overload;
    constructor Create(ACellStyl:TDxCellStyl);overload;
  public
    class function GetxlsDataFormat(ADataType:TDxDataType):Word;overload;
  end;

  TKzGridStyl=class(TObject)
  public
    RealGrid:TAdvStringGrid;  //RealGrid
    LablName:string;          //sheet��ǩ
  end;

  TDxExcelGridCellStyl =procedure (Sender: TObject; ARealGrid:TAdvStringGrid; ARow, ACol: Integer;var ACellStyl:TDxCellStyl) of object;
  //procedure OnKzExcelGridCellStyl(Sender: TObject; ARealGrid:TAdvStringGrid; ARow, ACol: Integer;var ACellStyl:TDxCellStyl);
  TDxExcelGridValidArea=procedure (Sender: TObject; ARealGrid:TAdvStringGrid;var AColStart,AColEnd,ARowStart,ARowEnd:Integer) of object;
  //procedure OnKzExcelGridValidArea(Sender: TObject; ARealGrid:TAdvStringGrid;var AColStart,AColEnd,ARowStart,ARowEnd:Integer);
  TDxExcelGridValidRows=procedure (Sender: TObject; ARealGrid:TAdvStringGrid;ARow:Integer;var Valid:Boolean) of object;
  //procedure OnKzExcelGridValidRows(Sender: TObject; ARealGrid:TAdvStringGrid;ARow:Integer;var Valid:Boolean);
  TDxExcelGridValidCols=procedure (Sender: TObject; ARealGrid:TAdvStringGrid;ACol:Integer;var Valid:Boolean) of object;
  //procedure OnKzExcelGridValidCols(Sender: TObject; ARealGrid:TAdvStringGrid;ACol:Integer;var Valid:Boolean);

  TDxExcelGetSavePath = procedure (Sender: TObject; var ASavePath:string) of object;
  //procedure OnKzExcelGetSavePath(Sender: TObject; var ASavePath:string);

  TDxExcelGetCellStyl = procedure (Sender: TObject; ARow, ACol: Integer;var ACellStyl:TDxCellStyl) of object;
  //procedure OnKzExcelGetCellStyl(Sender: TObject; ARow, ACol: Integer;var ACellStyl:TDxCellStyl);
  TDxExcelBeforeSaved = procedure (Sender: TdxSpreadSheet) of object;
  //procedure OnKzExcelBeforeSaved(Sender: TdxSpreadSheet);

  TDxExcel=class(TObject)
  private
    FCxExcel: TdxSpreadSheet;
    ListRows: TStringList;       //*list of interger
    ListCols: TStringList;       //*list of interger;
    ListGrid: TStringList;       //*list of &tadvstringgrid.multi.
  public
    RealGrid: TAdvStringGrid;    //tadvstringgrid.single.
    FileName: string;            //�ļ�����
    ShetName: string;            //Sheet��ǩ

    ColTotal: Integer;           //�����������Ŀ��
    
    IncludeHideCols: Boolean;    //�Ƿ����������Ŀ
    IncludeColsSize: Boolean;    //�Ƿ������Ŀ���
    ColExcursionSiz: Integer;    //��IncludeColsSize�й�
    ShowCellsBorder: Boolean;    //����Ƿ���ʾ�ڿ�
    ShowCellGridLin: Boolean;    //�Ƿ���ʾ����

    ColStart: Integer;
    ColEnd  : Integer;
    RowStart: Integer;
    RowEnd  : Integer;
    
    DefaultCellStyl:TDxCellStyl;//The Default CellStyl

    OnKzExcelGetSavePath  :TDxExcelGetSavePath;
    OnKzExcelGetCellStyl  :TDxExcelGetCellStyl;
    OnKzExcelBeforeSaved  :TDxExcelBeforeSaved;
    OnKzExcelGridCellStyl :TDxExcelGridCellStyl;
    OnKzExcelGridValidArea:TDxExcelGridValidArea;
    OnKzExcelGridValidRows:TDxExcelGridValidRows;
    OnKzExcelGridValidCols:TDxExcelGridValidCols;
  protected
    procedure SetValidRows;
    procedure SetValidCols;
    procedure SetValidArea;overload;
    function  GetValidSheetName:string;
    function  GetValidSheetIdex:string;//Sheet1,Sheet2...
  public
    procedure PushGrid(AGridStyl:TKzGridStyl);
    procedure SetValidArea(AColStart,AColEnd,ARowStart,ARowEnd:Integer);overload;
    procedure Initialize;

    procedure Execute;    //singl grid.not neglect rows;
    procedure ExecuteAll; //multi grid.not neglect rows;

    function  ExeNegl:Boolean;    //singl grid.has neglect rows;
    function  ExeNeglAll:Boolean; //multi grid.has neglect rows;

    procedure ImpData(AFileName:string;ARowStart,ARowEnded,AColStart,AColEnded:Integer;var AListData:TStringList);
  public
    constructor Create;
    destructor  Destroy;override;
  public
    class function  GetHorzTextAlign(AValue:Integer):TdxSpreadSheetCellStyles;
    class procedure InsertRows(Sender:TdxSpreadSheet;ACount:Integer;AIndex:Integer=0;AAutoStyle:Boolean=False);overload;
    class procedure InsertCols(Sender:TdxSpreadSheet;ACount:Integer;AIndex:Integer=0);overload;
    class procedure StyleCells(Sender:TdxSpreadSheet;AFromRowIndex,AToRowIndex,AFromColIndex,AToColIndex:Integer);
    class procedure MergeCells(Sender:TdxSpreadSheet;AFromRowIndex,AToRowIndex:Integer;AToColIndex:Integer=-1);overload;
    class procedure AutoNumber(Sender:TdxSpreadSheet;AColIndex,AStartRowIndex:Integer);overload;
    //rename it
    //#class procedure SetCellTxt(ASheetBook: TdxSpreadSheet; ACol, ARow: Integer; AText: string;AFontName: TFontName='����'; AFontSize: Integer=10;AAlign: TdxSpreadSheetDataAlignHorz;ADataType:TDxDataType=cxdtText);
    //#class procedure SetCellStyl(ASheetBook: TdxSpreadSheet; ACol, ARow: Integer; bBorder: array of Integer; ASheet: TdxSpreadSheet=nil);
  end;

  {TFkExcel=class(TDxExcel) //��������.Fuck.Excel.
  public
    HeadRowx:Integer;      //��ͷ������
    PageCols:Integer;      //�ּ���
    PageRows:Integer;      //һҳ��ӡ����
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
    function GetActualGrp(ACol,ARow:Integer):Integer;//������һ��.
    function GetActualRow(ACol,ARow:Integer):Integer;//������һ��.
  public
    function TruncEx(AValue,AAxis:Integer):Integer;  //����������Ǹ�ɶ.����С����,��ȡ��.
    function GetRowx(AValue,AAxis:Integer):Integer;
  public
    procedure Execute;
  public
    destructor  Destroy;override;       
  end;}

var
  KzExcel:TDxExcel;

implementation

uses
  Forms;

{ TDxExcel }


constructor TDxExcel.Create;
begin
  RealGrid:=nil;
  ListGrid:=nil;
  
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
    
  FCxExcel:=TdxSpreadSheet.Create(nil);
  FCxExcel.Visible:=False;
  FCxExcel.Parent :=Application.MainForm;

  DefaultCellStyl:=TDxCellStyl.Create;
end;

destructor TDxExcel.Destroy;
begin
  if FCxExcel<>nil then FreeAndNil(FCxExcel);
  if ListRows<>nil then FreeAndNil(ListRows);
  if ListCols<>nil then FreeAndNil(ListCols);
  if DefaultCellStyl<>nil then  FreeAndNil(DefaultCellStyl);
  if ListGrid<>nil then TKzUtils.TryFreeAndNil(ListGrid);
end;

procedure TDxExcel.Execute;
var
  ColInGrid:Integer;
  RowInGrid:Integer;
  ColInExcl:Integer;        //��Χ����ʱ��������ƫ��
  RowInExcl:Integer;        //��Χ����ʱ��������ƫ��
  CellA:TdxSpreadSheetCell;
  StylA:TDxCellStyl;
  SD   :TSaveDialog;

  PathA:string;
  TempA:string;
  NumbA:Integer;
  RectA:TRect;
  BordA:TdxSpreadSheetCellBorder;
  ExcursionA:Integer;   //���غ�ķ�������ƫ��.������.

  X:Integer;
  ExcursionB:Integer;   //���غ�ķ�������ƫ��.ȡ�п�.
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
    ShowMessage('�����˳�:δָ���ļ�����·��.');
    Exit;
  end;  

  with RealGrid,FCxExcel do
  begin
    //FCxExcel.ShowGrid:=ShowCellGridLin;
    if ShowCellGridLin then
    begin
      FCxExcel.ActiveSheetAsTable.Options.GridLines:=bTrue;
    end else
    begin
      FCxExcel.ActiveSheetAsTable.Options.GridLines:=bFalse;
    end;
    //
    FCxExcel.BeginUpdate;

    if FileExists(PathA) then
    begin
      TempA:='�ļ���[%S]������.'+#13
            +'��ѡ�񵼳���ʽ:���ǻ���׷�ӱ�ǩҳ.'+#13
            +'ѡ��[��]:�����ļ�.'+#13
            +'ѡ��[��]:׷�ӱ�ǩҳ.'+#13
            +'ѡ��[ȡ��]:ȡ������.';
      TempA:=Format(TempA,[PathA]);
            
      NumbA:=Application.MessageBox(PChar(TempA), '��ʾ', MB_YESNOCANCEL +MB_ICONINFORMATION);

      if NumbA=mrCancel then Exit;

      if NumbA=mrNo then
      begin
        LoadFromFile(PathA);
        //#AddSheetPage(GetValidSheetName);
        //#ActivePage:=FCxExcel.PageCount-1;
        AddSheet(GetValidSheetName);
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
    
    ClearAll;

    if RealGrid <>nil then
    begin
      SetValidArea;

      ColInExcl:=0;
      ExcursionA:=0;

      for ColInGrid := ColStart to ColEnd do
      begin
        //YXC_2012_02_20_15_48_10
        if (not IncludeHideCols) then
        begin
          if IsHiddenColumn(ColInGrid) then
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
          for X:=0 to ColInGrid do
          begin
            if IsHiddenColumn(X) then
            begin
              Inc(ExcursionB);
            end;
          end;
          ActiveSheet.Cols.Size[ColInExcl]:=ColWidths[ColInGrid-ExcursionB]+ColExcursionSiz;
          ActiveSheetAsTable.Columns[ColInExcl].CreateCell()
        end;
        //YXC_2012_11_08_16_59_50_>

        RowInExcl:=0;
        for RowInGrid := RowStart to RowEnd do
        begin

          //YXC_2012_05_17_08_26_45_<
          if ShowCellsBorder then
          begin
            CellA:=ActiveSheet.GetCellObject(ColInExcl-ExcursionA,RowInExcl);
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

          if IsMergedCell(ColInGrid-ExcursionA,RowInGrid) then
          begin
            if not CellProperties[ColInGrid-ExcursionA,RowInGrid].IsBaseCell then
            begin
              Inc(RowInExcl);
              Continue;
            end;
            //δƫ��
            //FCxExcel.ActiveSheet.SetMergedState(Rect(ColInGrid,RowInGrid,CellProperties[ColInGrid,RowInGrid].CellSpanX+ColInGrid,CellProperties[ColInGrid,RowInGrid].CellSpanY+RowInGrid),True);
            //��ƫ��
            //FCxExcel.ActiveSheet.SetMergedState(Rect(ColInExcl,RowInExcl,CellProperties[ColInGrid,RowInGrid].CellSpanX+ColInExcl,CellProperties[ColInGrid,RowInGrid].CellSpanY+RowInExcl),True);
            //��ƫ��,������

            //ALeft:=ColInExcl;
            //ATop :=RowInExcl;
            //ARight :=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanX+ColInExcl;
            //ABottom:=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanY+RowInExcl;
            //FCxExcel.ActiveSheet.SetMergedState(Rect(ALeft,ATop,ARight,ABottom),True);

            RectA.Left:=ColInExcl;
            RectA.Top :=RowInExcl;
            RectA.Right :=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanX+ColInExcl;
            RectA.Bottom:=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanY+RowInExcl;
            
            FCxExcel.ActiveSheet.SetMergedState(RectA,True);
          end;

          CellA:=ActiveSheet.GetCellObject(ColInExcl,RowInExcl);
          StylA:=TDxCellStyl.Create(DefaultCellStyl);
          
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

          
          //YXC_2012_02_21_16_41_42_����һ��ʱ��
          if StylA.DataType<>cxdtLongText then
          begin
            try
              if StylA.KeepCellTxtStyl then
              begin
                CellA.Text:=(Cells[ColInGrid,RowInGrid]);
              end else
              begin
                CellA.Text:=Trim(Cells[ColInGrid,RowInGrid]);
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
            OnKzExcelGetCellStyl(Self,RowInGrid,ColInGrid,StylA);
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

          //YXC_2012_02_21_16_41_42_����һ��ʱ��
          if (StylA.DataType=cxdtLongText) or (StylA.DataType=cxdtText) then
          begin
            try
              if StylA.KeepCellTxtStyl then
              begin
                CellA.Text:=(Cells[ColInGrid,RowInGrid]);
              end else
              begin
                CellA.Text:=Trim(Cells[ColInGrid,RowInGrid]);
              end;
            except
            end;
          end;

          CellA.Free;
          StylA.Free;
          
          Inc(RowInExcl);          
        end;
        
        Inc(ColInExcl);        
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

procedure TDxExcel.SetValidArea(AColStart, AColEnd, ARowStart,
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

procedure TDxExcel.Initialize;
begin
  RealGrid:=nil;
  
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

procedure TDxExcel.SetValidArea;
var
  I:Integer;
  NumbA:Integer;
begin
  if RealGrid=nil then Exit;
  if ColStart=-1 then ColStart:=0;
  if RowStart=-1 then RowStart:=0;
  //if ColEnd  =-1 then ColEnd  :=RealGrid.ColCount-1;
  if RowEnd  =-1 then RowEnd  :=RealGrid.RowCount-1;

  if ColEnd  =-1 then
  begin
    ColEnd  :=RealGrid.ColCount-1;
    if ColTotal<>-1 then ColEnd :=ColTotal-1;
  end;

  //����������
  //YXC_2015_03_02_13_26_27_add_{}
  {with RealGrid do
  begin
    if (ColTotal<>-1) and (RealGrid.ColCount<>ColTotal) then
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
  end;}
end;

function TDxExcel.GetValidSheetName: string;
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

function TDxExcel.GetValidSheetIdex: string;
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

procedure TDxExcel.ExecuteAll;
var
  I:Integer;
  ColInGrid:Integer;
  RowInGrid:Integer;
  ColInExcl:Integer;        //��Χ����ʱ��������ƫ��
  RowInExcl:Integer;        //��Χ����ʱ��������ƫ��
  CellA:TCxSSCellObject;
  StylA:TDxCellStyl;
  SD   :TSaveDialog;

  PathA:string;
  TempA:string;
  NumbA:Integer;
  RectA:TRect;
  BordA:TcxSSEdgeBorder;
  ExcursionA:Integer;   //���غ�ķ�������ƫ��.������.

  X:Integer;
  ExcursionB:Integer;   //���غ�ķ�������ƫ��.ȡ�п�.  
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
    ShowMessage('�����˳�:δָ���ļ�����·��.');
    Exit;
  end;  

  if (ListGrid=nil) or (ListGrid.Count=0) then Exit;

  with FCxExcel do
  begin
    FCxExcel.ShowGrid:=ShowCellGridLin;
    FCxExcel.BeginUpdate;

    if FileExists(PathA) then
    begin
      if TKzUtils.WarnBox('�ļ�������,�Ƿ񸲸�?')<>Mrok then Exit;
      DeleteFile(PChar(PathA));
    end;

    FCxExcel.ClearAll;
    for I:= 0 to ListGrid.Count-1 do
    begin
      AddSheetPage(GetValidSheetName);
      FCxExcel.Pages[FCxExcel.PageCount-1].Caption:=TKzGridStyl(ListGrid.Objects[I]).LablName;

      RealGrid :=TKzGridStyl(ListGrid.Objects[I]).RealGrid;
      ActivePage:=FCxExcel.PageCount-1;

      with RealGrid do
      begin
        if RealGrid <>nil then
        begin
          //YXC_2012_05_22_14_54_43_Replace by Custom Event 
          {ColEnd:=-1;
          RowEnd:=-1;}
          
          if Assigned(OnKzExcelGridValidArea) then
          begin
            OnKzExcelGridValidArea(FCxExcel,RealGrid,ColStart,ColEnd,RowStart,RowEnd);
          end;

          SetValidArea;

          ColInExcl:=0;
          ExcursionA:=0;

          for ColInGrid := ColStart to ColEnd do
          begin
            //YXC_2012_02_20_15_48_10
            if (not IncludeHideCols) then
            begin
              if IsHiddenColumn(ColInGrid) then
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
              for X:=0 to ColInGrid do
              begin
                if IsHiddenColumn(X) then
                begin
                  Inc(ExcursionB);
                end;
              end;
              ActiveSheet.Cols.Size[ColInExcl]:=ColWidths[ColInGrid-ExcursionB]+ColExcursionSiz;
            end;
            //YXC_2012_11_08_16_59_50_>

            RowInExcl:=0;
            for RowInGrid := RowStart to RowEnd do
            begin
              //YXC_2012_05_17_08_26_45_<
              if ShowCellsBorder then
              begin
                CellA:=ActiveSheet.GetCellObject(ColInExcl-ExcursionA,RowInGrid);
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


              if IsMergedCell(ColInGrid-ExcursionA,RowInGrid) then
              begin
                if not CellProperties[ColInGrid-ExcursionA,RowInGrid].IsBaseCell then
                begin
                  Inc(RowInExcl);
                  Continue;
                end;
                //δƫ��
                //FCxExcel.ActiveSheet.SetMergedState(Rect(ColInGrid,RowInGrid,CellProperties[ColInGrid,RowInGrid].CellSpanX+ColInGrid,CellProperties[ColInGrid,RowInGrid].CellSpanY+RowInGrid),True);
                //��ƫ��
                //FCxExcel.ActiveSheet.SetMergedState(Rect(ColInExcl,RowInExcl,CellProperties[ColInGrid,RowInGrid].CellSpanX+ColInExcl,CellProperties[ColInGrid,RowInGrid].CellSpanY+RowInExcl),True);
                //��ƫ��,������

                //ALeft:=ColInExcl;
                //ATop :=RowInExcl;
                //ARight :=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanX+ColInExcl;
                //ABottom:=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanY+RowInExcl;
                //FCxExcel.ActiveSheet.SetMergedState(Rect(ALeft,ATop,ARight,ABottom),True);

                RectA.Left:=ColInExcl;
                RectA.Top :=RowInExcl;
                RectA.Right :=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanX+ColInExcl;
                RectA.Bottom:=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanY+RowInExcl;

                FCxExcel.ActiveSheet.SetMergedState(RectA,True);
              end;

              CellA:=ActiveSheet.GetCellObject(ColInExcl,RowInExcl);
              StylA:=TDxCellStyl.Create(DefaultCellStyl);

              //YXC_2012_02_21_16_41_42_����һ��ʱ��
              {if StylA.DataType<>cxdtLongText then
              begin
                try
                  CellA.Text:=Trim(Cells[ColInGrid,RowInGrid]);
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
                    CellA.Text:=(Cells[ColInGrid,RowInGrid]);
                  end else
                  begin
                    CellA.Text:=Trim(Cells[ColInGrid,RowInGrid]);
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
                OnKzExcelGridCellStyl(FCxExcel,RealGrid,RowInGrid,ColInGrid,StylA);
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

              //YXC_2012_02_21_16_41_42_����һ��ʱ��
              {if StylA.DataType=cxdtLongText then
              begin
                try
                  CellA.Text:=Trim(Cells[ColInGrid,RowInGrid]);
                except
                end;
              end;}
              if (StylA.DataType=cxdtLongText) or (StylA.DataType=cxdtText) then
              begin
                try
                  if StylA.KeepCellTxtStyl then
                  begin
                    CellA.Text:=(Cells[ColInGrid,RowInGrid]);
                  end else
                  begin
                    CellA.Text:=Trim(Cells[ColInGrid,RowInGrid]);
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

              Inc(RowInExcl);
            end;

            Inc(ColInExcl);
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

function TDxExcel.ExeNegl:Boolean;
var
  I,M:Integer;
  ColInGrid:Integer;
  RowInGrid:Integer;
  ColInExcl:Integer;        //��Χ����ʱ��������ƫ��
  RowInExcl:Integer;        //��Χ����ʱ��������ƫ��
  CellA:TCxSSCellObject;
  StylA:TDxCellStyl;
  SD   :TSaveDialog;

  PathA:string;
  TempA:string;
  NumbA:Integer;
  RectA:TRect;
  BordA:TcxSSEdgeBorder;
  ExcursionA:Integer;   //���غ�ķ�������ƫ��.������.

  X:Integer;
  ExcursionB:Integer;   //���غ�ķ�������ƫ��.ȡ�п�.  
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
    ShowMessage('�����˳�:δָ���ļ�����·��.');
    Exit;
  end;  

  with RealGrid,FCxExcel do
  begin
    FCxExcel.ShowGrid:=ShowCellGridLin;
    FCxExcel.BeginUpdate;

    if FileExists(PathA) then
    begin
      TempA:='�ļ���[%S]������.'+#13
            +'��ѡ�񵼳���ʽ:���ǻ���׷�ӱ�ǩҳ.'+#13
            +'ѡ��[��]:�����ļ�.'+#13
            +'ѡ��[��]:׷�ӱ�ǩҳ.'+#13
            +'ѡ��[ȡ��]:ȡ������.';
      TempA:=Format(TempA,[PathA]);
            
      NumbA:=Application.MessageBox(PChar(TempA), '��ʾ', MB_YESNOCANCEL +MB_ICONINFORMATION);

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

    if RealGrid <>nil then
    begin
      SetValidArea;

      ColInExcl:=0;
      ExcursionA:=0;

      SetValidCols;
      SetValidRows;

      //for ColInGrid := ColStart to ColEnd do
      for I:=0 to ListCols.Count-1 do 
      begin
        ColInGrid:=StrToInt(ListCols.Strings[I]);

        //YXC_2012_02_20_15_48_10
        if (not IncludeHideCols) then
        begin
          if IsHiddenColumn(ColInGrid) then
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
          for X:=0 to ColInGrid do
          begin
            if IsHiddenColumn(X) then
            begin
              Inc(ExcursionB);
            end;
          end;
          ActiveSheet.Cols.Size[ColInExcl]:=ColWidths[ColInGrid-ExcursionB]+ColExcursionSiz;
        end;
        //YXC_2012_11_08_16_59_50_>        

        RowInExcl:=0;
        for M:=0 to ListRows.Count-1 do
        //for RowInGrid := RowStart to RowEnd do
        begin
          RowInGrid:=StrToInt(ListRows.Strings[M]);

          //YXC_2012_05_17_08_26_45_<
          if ShowCellsBorder then
          begin
            CellA:=ActiveSheet.GetCellObject(ColInExcl-ExcursionA,RowInExcl);
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

          if IsMergedCell(ColInGrid-ExcursionA,RowInGrid) then
          begin
            if not CellProperties[ColInGrid-ExcursionA,RowInGrid].IsBaseCell then
            begin
              Inc(RowInExcl);
              Continue;
            end;
            //δƫ��
            //FCxExcel.ActiveSheet.SetMergedState(Rect(ColInGrid,RowInGrid,CellProperties[ColInGrid,RowInGrid].CellSpanX+ColInGrid,CellProperties[ColInGrid,RowInGrid].CellSpanY+RowInGrid),True);
            //��ƫ��
            //FCxExcel.ActiveSheet.SetMergedState(Rect(ColInExcl,RowInExcl,CellProperties[ColInGrid,RowInGrid].CellSpanX+ColInExcl,CellProperties[ColInGrid,RowInGrid].CellSpanY+RowInExcl),True);
            //��ƫ��,������

            //ALeft:=ColInExcl;
            //ATop :=RowInExcl;
            //ARight :=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanX+ColInExcl;
            //ABottom:=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanY+RowInExcl;
            //FCxExcel.ActiveSheet.SetMergedState(Rect(ALeft,ATop,ARight,ABottom),True);

            RectA.Left:=ColInExcl;
            RectA.Top :=RowInExcl;
            RectA.Right :=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanX+ColInExcl;
            RectA.Bottom:=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanY+RowInExcl;
            
            FCxExcel.ActiveSheet.SetMergedState(RectA,True);
          end;

          CellA:=ActiveSheet.GetCellObject(ColInExcl,RowInExcl);
          StylA:=TDxCellStyl.Create(DefaultCellStyl);
          
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

          
          //YXC_2012_02_21_16_41_42_����һ��ʱ��
          {if StylA.DataType<>cxdtLongText then
          begin
            try
              CellA.Text:=Trim(Cells[ColInGrid,RowInGrid]);
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
                CellA.Text:=(Cells[ColInGrid,RowInGrid]);
              end else
              begin
                CellA.Text:=Trim(Cells[ColInGrid,RowInGrid]);
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
            OnKzExcelGetCellStyl(Self,RowInGrid,ColInGrid,StylA);
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

          //YXC_2012_02_21_16_41_42_����һ��ʱ��
          {if StylA.DataType=cxdtLongText then
          begin
            try
              CellA.Text:=Trim(Cells[ColInGrid,RowInGrid]);
            except
            end;
          end;}
          if (StylA.DataType=cxdtLongText) or (StylA.DataType=cxdtText) then
          begin
            try
              if StylA.KeepCellTxtStyl then
              begin
                CellA.Text:=(Cells[ColInGrid,RowInGrid]);
              end else
              begin
                CellA.Text:=Trim(Cells[ColInGrid,RowInGrid]);
              end;
            except
            end;
          end;          

          CellA.Free;
          StylA.Free;
          
          Inc(RowInExcl);          
        end;
        
        Inc(ColInExcl);        
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

procedure TDxExcel.SetValidRows;
var
  I:Integer;
  Valid:Boolean;
begin
  Valid:=True;

  if ListRows=nil then
  begin
    ListRows:=TStringList.Create;
  end else
  begin
    ListRows.Clear;
  end;    

  with RealGrid do
  begin
    for I := RowStart to RowEnd do
    begin
      Valid:=True;
      if Assigned(OnKzExcelGridValidRows) then
      begin
        OnKzExcelGridValidRows(FCxExcel,RealGrid,I,Valid);
      end;

      if Valid then
      begin
        ListRows.Add(IntToStr(I));
      end;  
    end;
  end;
end;

function TDxExcel.ExeNeglAll:Boolean;
var
  I,M,N:Integer;
  ColInGrid:Integer;
  RowInGrid:Integer;
  ColInExcl:Integer;        //��Χ����ʱ��������ƫ��
  RowInExcl:Integer;        //��Χ����ʱ��������ƫ��
  CellA:TCxSSCellObject;
  StylA:TDxCellStyl;
  SD   :TSaveDialog;

  PathA:string;
  TempA:string;
  NumbA:Integer;
  RectA:TRect;
  BordA:TcxSSEdgeBorder;
  ExcursionA:Integer;   //���غ�ķ�������ƫ��.������.

  X:Integer;
  ExcursionB:Integer;   //���غ�ķ�������ƫ��.ȡ�п�.  
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
    ShowMessage('�����˳�:δָ���ļ�����·��.');
    Exit;
  end;  

  if (ListGrid=nil) or (ListGrid.Count=0) then Exit;

  with FCxExcel do
  begin
    FCxExcel.ShowGrid:=ShowCellGridLin;
    FCxExcel.BeginUpdate;

    if FileExists(PathA) then
    begin
      if TKzUtils.WarnBox('�ļ�������,�Ƿ񸲸�?')<>Mrok then Exit;
      DeleteFile(PChar(PathA));
    end;

    FCxExcel.ClearAll;
    for I:= 0 to ListGrid.Count-1 do
    begin
      AddSheetPage(GetValidSheetName);
      FCxExcel.Pages[FCxExcel.PageCount-1].Caption:=TKzGridStyl(ListGrid.Objects[I]).LablName;

      RealGrid :=TKzGridStyl(ListGrid.Objects[I]).RealGrid;
      ActivePage:=FCxExcel.PageCount-1;

      with RealGrid do
      begin
        if RealGrid <>nil then
        begin
          //YXC_2012_05_22_14_54_43_Replace by Custom Event 
          {ColEnd:=-1;
          RowEnd:=-1;}
          
          if Assigned(OnKzExcelGridValidArea) then
          begin
            OnKzExcelGridValidArea(FCxExcel,RealGrid,ColStart,ColEnd,RowStart,RowEnd);
          end;

          SetValidArea;

          ColInExcl:=0;
          ExcursionA:=0;

          SetValidCols;
          SetValidRows;


          //for ColInGrid := ColStart to ColEnd do
          for N:=0 to ListCols.Count-1 do
          begin
            ColInGrid:=StrToInt(ListCols.Strings[N]);
            //YXC_2012_02_20_15_48_10
            if (not IncludeHideCols) then
            begin
              if IsHiddenColumn(ColInGrid) then
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
              for X:=0 to ColInGrid do
              begin
                if IsHiddenColumn(X) then
                begin
                  Inc(ExcursionB);
                end;
              end;
              ActiveSheet.Cols.Size[ColInExcl]:=ColWidths[ColInGrid-ExcursionB]+ColExcursionSiz;
            end;
            //YXC_2012_11_08_16_59_50_>            

            RowInExcl:=0;
            //for RowInGrid := RowStart to RowEnd do
            for M:=0 to ListRows.Count-1 do
            begin
              RowInGrid:=StrToInt(ListRows.Strings[M]);

              //YXC_2012_05_17_08_26_45_<
              if ShowCellsBorder then
              begin
                CellA:=ActiveSheet.GetCellObject(ColInExcl-ExcursionA,RowInExcl);
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


              if IsMergedCell(ColInGrid-ExcursionA,RowInGrid) then
              begin
                if not CellProperties[ColInGrid-ExcursionA,RowInGrid].IsBaseCell then
                begin
                  Inc(RowInExcl);
                  Continue;
                end;
                //δƫ��
                //FCxExcel.ActiveSheet.SetMergedState(Rect(ColInGrid,RowInGrid,CellProperties[ColInGrid,RowInGrid].CellSpanX+ColInGrid,CellProperties[ColInGrid,RowInGrid].CellSpanY+RowInGrid),True);
                //��ƫ��
                //FCxExcel.ActiveSheet.SetMergedState(Rect(ColInExcl,RowInExcl,CellProperties[ColInGrid,RowInGrid].CellSpanX+ColInExcl,CellProperties[ColInGrid,RowInGrid].CellSpanY+RowInExcl),True);
                //��ƫ��,������

                //ALeft:=ColInExcl;
                //ATop :=RowInExcl;
                //ARight :=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanX+ColInExcl;
                //ABottom:=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanY+RowInExcl;
                //FCxExcel.ActiveSheet.SetMergedState(Rect(ALeft,ATop,ARight,ABottom),True);

                RectA.Left:=ColInExcl;
                RectA.Top :=RowInExcl;
                RectA.Right :=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanX+ColInExcl;
                RectA.Bottom:=CellProperties[ColInGrid-ExcursionA,RowInGrid].CellSpanY+RowInExcl;

                FCxExcel.ActiveSheet.SetMergedState(RectA,True);
              end;

              CellA:=ActiveSheet.GetCellObject(ColInExcl,RowInExcl);
              StylA:=TDxCellStyl.Create(DefaultCellStyl);

              //YXC_2012_02_21_16_41_42_����һ��ʱ��
              {if StylA.DataType<>cxdtLongText then
              begin
                try
                  CellA.Text:=Trim(Cells[ColInGrid,RowInGrid]);
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
                    CellA.Text:=(Cells[ColInGrid,RowInGrid]);
                  end else
                  begin
                    CellA.Text:=Trim(Cells[ColInGrid,RowInGrid]);
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
                OnKzExcelGridCellStyl(FCxExcel,RealGrid,RowInGrid,ColInGrid,StylA);
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

              //YXC_2012_02_21_16_41_42_����һ��ʱ��
              {if StylA.DataType=cxdtLongText then
              begin
                try
                  CellA.Text:=Trim(Cells[ColInGrid,RowInGrid]);
                except
                end;
              end;}
              
              if (StylA.DataType=cxdtLongText) or (StylA.DataType=cxdtText) then
              begin
                try
                  if StylA.KeepCellTxtStyl then
                  begin
                    CellA.Text:=(Cells[ColInGrid,RowInGrid]);
                  end else
                  begin
                    CellA.Text:=Trim(Cells[ColInGrid,RowInGrid]);
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

              Inc(RowInExcl);
            end;

            Inc(ColInExcl);
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

procedure TDxExcel.SetValidCols;
var
  I:Integer;
  Valid:Boolean;
begin
  Valid:=True;

  if ListCols=nil then
  begin
    ListCols:=TStringList.Create;
  end else
  begin
    ListCols.Clear;
  end;    

  with RealGrid do
  begin
    for I := ColStart to ColEnd do
    begin
      Valid:=True;
      if Assigned(OnKzExcelGridValidCols) then
      begin
        OnKzExcelGridValidCols(Self,RealGrid,I,Valid);
      end;

      if Valid then
      begin
        ListCols.Add(IntToStr(I));
      end;  
    end;
  end;
end;

class function TDxExcel.GetHorzTextAlign(
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

class procedure TDxExcel.InsertCols(Sender: TdxSpreadSheet; ACount,
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

class procedure TDxExcel.InsertRows(Sender: TdxSpreadSheet; ACount,
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

class procedure TDxExcel.MergeCells(Sender:TdxSpreadSheet;AFromRowIndex,AToRowIndex:Integer;AToColIndex:Integer);
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

class procedure TDxExcel.AutoNumber(Sender: TdxSpreadSheet; AColIndex,
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
      CellA.Style.Font.Name:='����';
      CellA.Style.Font.Size:=10;
      CellA.Style.HorzTextAlign:=haCENTER;
      CellA.Free;
    end;
    
    EndUpdate;
  end;  
end;

class procedure TDxExcel.StyleCells(Sender: TdxSpreadSheet;
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
        CellA.Style.Font.Name:='����';
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

class procedure TDxExcel.SetCellStyl(ASheetBook: TdxSpreadSheet; ACol,
  ARow: Integer; bBorder: array of Integer; ASheet: TcxSSBookSheet);
begin
  TDxExcel.SetACellStyle(ASheetBook,ACol,ARow,bBorder,ASheet);
end;

{class procedure TDxExcel.SetCellTxt(ASheetBook: TdxSpreadSheet; ACol,
  ARow: Integer; AText: string; AFontName: TFontName; AFontSize: Integer;
  AAlign: TcxHorzTextAlign; ADataType: TDxDataType);
begin
  TDxExcel.SetACellText(ASheetBook,ACol,ARow,AText,AFontName,AFontSize,AAlign,ADataType);
end;}

procedure TDxExcel.PushGrid(AGridStyl: TKzGridStyl);
begin
  if ListGrid=nil then
  begin
    ListGrid:=TStringList.Create;
  end;

  ListGrid.AddObject('',AGridStyl);
end;



procedure TDxExcel.ImpData(AFileName: string; ARowStart, ARowEnded,
  AColStart, AColEnded: Integer; var AListData: TStringList);
var
  I,M:Integer;
  CellObjt:TcxSSCellObject;
  CellData:TCxCellData;
  RowStart:Integer;
  RowEnded:Integer;
  ColStart:Integer;
  ColEnded:Integer;
begin
  if AListData=nil then Exit;
  TKzUtils.JustCleanList(AListData);

  
  FCxExcel.ClearAll;
  FCxExcel.LoadFromFile(AFileName);

  RowStart:=ARowStart;
  RowEnded:=ARowEnded;
  ColStart:=AColStart;
  ColEnded:=AColEnded;

  if RowStart=-1 then
  begin
    RowStart:=0;
  end;
  if RowEnded=-1 then
  begin
    RowEnded:=FCxExcel.ActiveSheet.ContentRowCount-1;
  end;
  if ColStart=-1 then
  begin
    ColStart:=0;
  end;
  if ColEnded=-1 then
  begin
    ColEnded:=FCxExcel.ActiveSheet.ContentColCount-1;
  end;

  with FCxExcel.ActiveSheet do
  begin
    for I:=RowStart to RowEnded do
    begin
      CellData:=TCxCellData.Create;
      for M:=ColStart to ColEnded do
      begin
        CellObjt:=GetCellObject(M,I);
        CellData.ListData.Add(Format('%D=%S',[M,Trim(CellObjt.Text)]));
        CellObjt.Free;
      end;

      AListData.AddObject(Format('%D',[I]),CellData);
    end;
  end;
end;

{ TDxCellStyl }

constructor TDxCellStyl.Create;
begin
  DataType:=cxdtText;
  FontName:='����';
  FontSize:=10;
  FontColor:=0;
  IsfsBold:=False;
  HorAlign:=haLEFT;
  KeepCellTxtStyl:=False;
  BackColor:=1;
end;

constructor TDxCellStyl.Create(ADataType: TDxDataType);
begin
  DataType:=ADataType;
  FontName:='����';
  FontSize:=10;
  FontColor:=0;
  IsfsBold:=False;
  HorAlign:=haLEFT;
  KeepCellTxtStyl:=False;
  BackColor:=1;
end;

constructor TDxCellStyl.Create(ACellStyl: TDxCellStyl);
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

function TDxCellStyl.GetxlsDataFormat: Word;
begin
  Result:=$00;

  case DataType of
    cxdtText :Result:=$00;
    cxdtNumb :Result:=$01;
    cxdtDoub :Result:=$04;
    cxdtDate :Result:=$0E;
    cxdtLongText  :Result:=$22;//�ϰ汾.TdxSpreadSheet.���ֶ�����
    cxdtLongTextEx:Result:=$23;//�°汾.TdxSpreadSheet.���ֶ�����
    cxdtDoubEx    :Result:=$03;//û�нǷֵ�����ֵ����.
    cxdtNumbEx    :Result:=$02;//    
  end;
end;

{initialization
begin
  KzExcel:=TDxExcel.Create;
end;

finalization
begin
  if KzExcel<>nil then
  begin
    FreeAndNil(KzExcel);
  end;
end;}

class function TDxCellStyl.GetxlsDataFormat(ADataType: TDxDataType): Word;
begin
  Result:=$00;

  case ADataType of
    cxdtText :Result:=$00;
    cxdtNumb :Result:=$01;
    cxdtDoub :Result:=$04;
    cxdtDate :Result:=$0E;
    cxdtLongText  :Result:=$22;//�ϰ汾.TdxSpreadSheet.���ֶ�����
    cxdtLongTextEx:Result:=$23;//�°汾.TdxSpreadSheet.���ֶ�����
    cxdtDoubEx    :Result:=$03;//û�нǷֵ�����ֵ����.
    cxdtNumbEx    :Result:=$02;//    
  end;
end;

{ TFkExcel }

destructor TFkExcel.Destroy;
begin

  inherited;
end;

procedure TFkExcel.Execute;
var
  I,M:Integer;
  ColInGrid:Integer;
  RowInGrid:Integer;
  ColInExcl:Integer;        //��Χ����ʱ��������ƫ��
  RowInExcl:Integer;        //��Χ����ʱ��������ƫ��

  CellA:TCxSSCellObject;
  StylA:TDxCellStyl;
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

  with RealGrid,FCxExcel do
  begin
    FCxExcel.BeginUpdate;

    if FileExists(SD.FileName) then
    begin
      TempA:='�ļ�����������.��ѡ�񵼳���ʽ:���ǻ���׷�ӱ�ǩҳ.'+#13
            +'ѡ��[��]:�����ļ�.'+#13
            +'ѡ��[��]:׷�ӱ�ǩҳ.'+#13
            +'ѡ��[ȡ��]:ȡ������.';
            
      NumbA:=Application.MessageBox(PChar(TempA), '��ʾ', MB_YESNOCANCEL +MB_ICONINFORMATION);

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

    if RealGrid <>nil then
    begin
      SetValidArea;
      //
      ColInGrid:=1;
      RowInGrid:=1;

      for I:=ColStart to ColEnd do
      begin
        RowInGrid:=1;

        if NeglectCrew then
        begin
          if I=2 then Continue;
        end;  
        
        for M:=RowStart to RowEnd do
        begin
          ColInExcl:=GetActualGrp(ColInGrid,RowInGrid);
          RowInExcl:=GetActualRow(ColInGrid,RowInGrid);
          CellA:=ActiveSheet.GetCellObject(ColInExcl-1,RowInExcl-1);

          //YXC_2012_03_14_17_30_57_<
          StylA:=TDxCellStyl.Create(DefaultCellStyl);
          if StylA.DataType<>cxdtLongText then
          begin
            try
              CellA.Text:=RealGrid.Cells[I,M];
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
              CellA.Text:=RealGrid.Cells[I,M];
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

          Inc(RowInGrid);
        end;
        Inc(ColInGrid);
      end;

      //YXC_2012_03_19_14_47_45_<
      //at here
      RowInExcl:=ActiveSheet.ContentColCount-2;
      Count:=ColEnd-ColStart+1;
      if NeglectCrew then
      begin
        Dec(Count);
      end;

      for I:=1 to RowInExcl+1 do
      begin
        ColInGrid:=I mod Count;
        if ColInGrid=0 then ColInGrid:=Count;

        if NeglectCrew then
        begin
          if ColInGrid>=2 then Inc(ColInGrid);
        end;  
        
        CellA:=ActiveSheet.GetCellObject(I-1,0);
        //CellA.Text:=Cells[ColInGrid,0];//replace the headrow;

        StylA:=TDxCellStyl.Create(DefaultCellStyl);
        if StylA.DataType<>cxdtLongText then
        begin
          try
            CellA.Text:=RealGrid.Cells[ColInGrid,HeadRowx];
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
          OnKzExcelGetCellStyl(FCxExcel,RowInGrid,ColInGrid,StylA);
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
            CellA.Text:=RealGrid.Cells[ColInGrid,HeadRowx];
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

  //Ϊʲô��3
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

class procedure TDxExcel.SetACellStyle(ASheetBook: TdxSpreadSheet; ACol, ARow: Integer;
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

class procedure TDxExcel.SetACellText(ASheetBook: TdxSpreadSheet; ACol,
  ARow: Integer; AText: string; AFontName: TFontName; AFontSize: Integer;AAlign: TcxHorzTextAlign;ADataType:TDxDataType);
var
  ACell: tdxspreadsheet;
begin
  ASheetBook.BeginUpdate;
  try
    ACell:=ASheetBook.ActiveSheet.GetCellObject(ACol,ARow);
    ACell.Text:= AText;
    ACell.Style.Font.Size:=AFontSize;
    if AFontSize>15 then
    begin
      ACell.Style.Font.Style:= [fsBold];
    end;
    ACell.Style.Font.Name:=AFontName;
    ACell.Style.HorzTextAlign:=AAlign;
    ACell.Style.Format   :=TDxCellStyl.GetxlsDataFormat(ADataType);
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


{ TCxCellData }

constructor TCxCellData.Create;
begin
  ListData:=TStringList.Create;
end;

destructor TCxCellData.Destroy;
begin
  if ListData<>nil then FreeAndNil(ListData);
  inherited;
end;

end.
