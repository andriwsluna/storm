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
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.ObjectScope;

type

  Tvcl_form = class(TForm)
    ADOConnection1: TADOConnection;
    Button1: TButton;
    memosql: TMemo;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    FDMemTable1: TFDMemTable;
    FDMemTable2: TFDMemTable;
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    Button2: TButton;
    MemoJson: TMemo;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure freeDataset;
    procedure ShowSql(sql : string);
    procedure AtribuirDatasetAoGrid(resultado : IStormQuerySuccessExecution<IProduto>);
    procedure MostrarMensagemDeErro(resultado : IStormQueryFailExecution);
    procedure printproduto(produto : Iproduto);
    procedure showjson(const json : tjsonarray);
    function  MapperProdutoDeCodigo2(produto : Iproduto) : Maybe<Iproduto>;
    function  ProdutosCujoDescricaoContem_F(produto : Iproduto) : Boolean;
  public


  end;

var
  vcl_form : Tvcl_form;

implementation

{$R *.dfm}

procedure Tvcl_form.MostrarMensagemDeErro(resultado: IStormQueryFailExecution);
begin
  ShowMessage(resultado.GetErrorMessage);
  ShowSql(resultado.GetSQL);
end;


procedure Tvcl_form.printproduto(produto: Iproduto);
begin
  produto.Codigo.GetValueOrDefault();
  MemoJson.Lines.Add('produto: ' +
  produto.Descricao.Value.GetValue.GetValueOrDefault('') + ' Código: ' + produto.Codigo.Value.GetValue.GetValueOrDefault(''));
end;

procedure Tvcl_form.showjson(const json: tjsonarray);
begin
  MemoJson.Lines.add(json.ToString);
  json.Free;
end;

procedure Tvcl_form.ShowSql(sql: string);
begin
  memosql.Text := sql;
end;

procedure Tvcl_form.Button1Click(Sender: TObject);
begin
  ORMproduto
    .Select
    .Only([Codigo, Descricao])
    .Where
    .Descricao.IsNotNull
    .Go
    .Limit(1)
    .GetSQL(ShowSql)
    //.Open(ADOConnection1.StormDriver)
    .Open(FDConnection1.StormDriver)
    .OnSuccess(AtribuirDatasetAoGrid)
    .OnFail(MostrarMensagemDeErro);
end;


procedure Tvcl_form.Button2Click(Sender: TObject);
VAR
  v : IIntegerValue;
begin
  v := TIntegerValue.Create;
  v.SetValue(1);
  v.ToString.OnSome(ShowMessage);
end;

function Tvcl_form.MapperProdutoDeCodigo2(produto: Iproduto): Maybe<Iproduto>;
VAR
  MyNewProduto : IProduto;
begin
  if produto.Codigo.Value.GetValue.GetValueOrDefault('') = '2' then
  begin
    MyNewProduto := newProduto;
    MyNewProduto.Clone(produto);
    Result := MyNewProduto;
  end;
end;

function Tvcl_form.ProdutosCujoDescricaoContem_F(produto: Iproduto): Boolean;
begin
  Result := produto.Descricao.Value.GetValue.GetValueOrDefault('').Contains('f');
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


procedure Tvcl_form.AtribuirDatasetAoGrid(resultado: IStormQuerySuccessExecution<IProduto>);

begin
  freeDataset;
  DataSource1.DataSet := resultado.GetDataset;

  resultado.GetModel
    .ForEach(PrintProduto)
    .Filter(ProdutosCujoDescricaoContem_F)
    .Map(MapperProdutoDeCodigo2)
    .ToJSON(true)
    .OnSome(showjson)
end;

end.
