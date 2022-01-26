{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
unit uvcl_form;

interface

uses
  storm.model.interfaces,
  firedac.DApt,
  System.JSON,
  uORMProduto,
  storm.model.base,
  storm.data.driver.ado,
  storm.data.driver.firedac,
  storm.entity.interfaces,
  storm.values.interfaces,
  System.Generics.Collections,
  DFE.Result,
  storm.data.driver.mssql,
  storm.orm.interfaces,
  storm.data.interfaces,
  storm.values.int,
  DFE.Maybe,
  storm.data.driver.mysql,
  uEntityProduto,
  storm.orm.query,
  uSchemaProduto,
  storm.dependency.register,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.ObjectScope
  ;

type

  Tvcl_form = class(TForm)
    ADOConnection1: TADOConnection;
    Button1: TButton;
    memosql: TMemo;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    Button2: TButton;
    MemoJson: TMemo;
    EditCodigo: TEdit;
    EditDescricao: TEdit;
    Label1: TLabel;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    Function  GetConnection : IStormSQLConnection;
    procedure freeDataset;
    Procedure ShowDataset(resultado : IStormSelectSuccess<IProduto>);
    Procedure MostrarErro(resultado : IStormExecutionFail);
    Function  GetDescricao() : Maybe<String>;
    procedure MostrarResultadoInsertPositivo(resultado : IStormInsertSuccess);
  public


  end;

var
  vcl_form : Tvcl_form;

implementation

{$R *.dfm}


procedure Tvcl_form.Button1Click(Sender: TObject);
begin
  Produto_ORM(GetConnection())
    .Select
      .Only([Codigo, Descricao])
    .Where
      .Codigo.IsNotEqualsTo('0')
      ._And
      .OpenParenthesis
      .Descricao.IsNotEqualsTo('')
      ._Or
      .Descricao.IsNull
      .CloseParenthesis
    .Go
    .Open
    .OnSuccess(ShowDataset)
    .OnFail(self.MostrarErro)
end;


procedure Tvcl_form.Button2Click(Sender: TObject);
begin
  Produto_ORM(Getconnection)
    .Update
    .Descricao.SetThisOrNull(GetDescricao())
    .Where
    .Codigo.IsEqualsTo(self.DataSource1.DataSet.FieldByName('codigo_produto').AsString)
    .Go
    .Execute
    .OnSuccess
    (
      procedure(resultado : IStormUpdateSuccess)
      begin
        self.Label1.Caption := resultado.RowsUpdated.ToString;
        Button1Click(nil);
      end
    )
    .OnFail(MostrarErro)
end;

procedure Tvcl_form.Button3Click(Sender: TObject);
begin
  Produto_ORM(Getconnection)
    .Insert
    .Codigo.SetValue(editcodigo.text)
    .Descricao.SetValue(GetDescricao())
    .Go
    .Execute
    .OnSuccess(MostrarResultadoInsertPositivo)
    .OnFail(MostrarErro)

end;

procedure Tvcl_form.Button4Click(Sender: TObject);
begin
  Produto_ORM(Getconnection)
    .Delete
    .Where
    .OpenParenthesis
    .Codigo.IsEqualsTo(editcodigo.text)
    .CloseParenthesis
    .Go
    .Execute
    .OnSuccess
    (
      procedure(resultado : IStormDeleteSuccess)
      begin
        showmessage(resultado.RowsDeleted.ToString);
      end
    )
    .OnFail(MostrarErro)


end;

procedure Tvcl_form.Button5Click(Sender: TObject);
begin
//  NewProdutoORM(Getconnection)
//    .SelectByID('8')
//    .OnSuccess
//    (
//      procedure(resultado : IProdutoSelectByIDSuccess)
//      begin
//        resultado.GetEntity;
//      end
//    );
end;



procedure Tvcl_form.FormCreate(Sender: TObject);
begin
  DependencyRegister.RegisterSQLDriver(storm.data.driver.mysql.TStormMySqlDriver.Create);
  //DependencyRegister.RegisterSQLDriver(storm.data.driver.mssql.TStormMSSQlDriver.Create);
end;

procedure Tvcl_form.FormDestroy(Sender: TObject);
begin
  freeDataset
end;

procedure Tvcl_form.freeDataset;
begin
  if Assigned(DataSource1.DataSet) then
  begin
    DataSource1.DataSet.Free;
  end;
end;

function Tvcl_form.GetConnection: IStormSQLConnection;
begin
  Result := FDconnection1.StormDriver;
  //result := Adoconnection1.StormDriver;
end;



function Tvcl_form.GetDescricao: Maybe<String>;
begin
  if EditDescricao.Text <> '' then
  begin
    Result := EditDescricao.Text;
  end;
end;

procedure Tvcl_form.MostrarErro(resultado: IStormExecutionFail);
begin
  memosql.Text := resultado.GetExecutedCommand;
  ShowMessage(resultado.GetErrorMessage);
end;

procedure Tvcl_form.MostrarResultadoInsertPositivo(
  resultado: IStormInsertSuccess);
begin
  ShowMessage('Dados inseriods com sucesso');
end;

procedure Tvcl_form.ShowDataset(resultado: IStormSelectSuccess<IProduto>);
begin
  freeDataset;
  DataSource1.DataSet := resultado.GetDataset;
end;

end.
