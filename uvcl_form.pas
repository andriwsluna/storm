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
  System.Generics.Collections,
  storm.additional.result,
  storm.data.driver.mssql,
  storm.orm.interfaces,
  storm.data.interfaces,
  storm.additional.maybe,
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
  FireDAC.VCLUI.Wait, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL;

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
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure freeDataset;
    procedure ShowSql(sql : string);
    procedure AtribuirDatasetAoGrid(resultado : QueryProdutoSuccess);
    procedure MostrarMensagemDeErro(resultado : IStormQueryFailExecution);
    procedure setEditText(str : string);
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


procedure Tvcl_form.setEditText(str: string);
begin
  Edit1.Text := str;
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
    .GetSQL(ShowSql)
    .Open(ADOConnection1.StormDriver)
    .OnSuccess(AtribuirDatasetAoGrid)
    .OnFail(MostrarMensagemDeErro);
end;






procedure Tvcl_form.FormCreate(Sender: TObject);
begin
  //DependencyRegister.RegisterSQLDriver(storm.data.driver.mysql.TStormMySqlDriver.Create);
  DependencyRegister.RegisterSQLDriver(storm.data.driver.mssql.TStormMSSQlDriver.Create);
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


procedure Tvcl_form.AtribuirDatasetAoGrid(resultado: QueryProdutoSuccess);

begin
  freeDataset;
  DataSource1.DataSet := resultado.GetDataset;

  resultado.GetModel.Records[0].Codigo.Value.GetValue.OnSome(seteditText);
  resultado.GetModel.ToJSON(true).OnSome
  (
    procedure(json : tjsonarray)
    begin
      MemoJson.Text := json.ToString;
      json.Free;
    end
  );
end;

end.
