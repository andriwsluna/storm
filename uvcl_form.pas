unit uvcl_form;

interface

uses
  firedac.DApt,
  System.JSON,
  uORMProduto,
  storm.data.driver.ado,
  storm.data.driver.firedac,
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
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure freeDataset;
    procedure ShowSql(sql : string);
    procedure AtribuirDatasetAoGrid(resultado : IStormQuerySuccessExecution);
    procedure MostrarMensagemDeErro(resultado : IStormQueryFailExecution);
  public










  end;

var
  vcl_form : Tvcl_form;

implementation

{$R *.dfm}

procedure Tvcl_form.MostrarMensagemDeErro(resultado: IStormQueryFailExecution);
begin
  ShowMessage(resultado.GetErrorMessage);
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
    .Codigo.IsIn(['1','3'])
    .Or_
    .Descricao.Contains('farinha')
    .Go
    .GetSQL(ShowSql)
    .Open(ADOConnection1.StormDriver)
    .OnSuccess(AtribuirDatasetAoGrid)
    .OnFail(MostrarMensagemDeErro);
end;






procedure Tvcl_form.Button2Click(Sender: TObject);
var
  produto1 : IProduto;
  produto2 : IProduto;
begin
  produto1 := NewProduto;
  produto2 := NewProduto;

  produto1.Codigo.Value.SetValue('1');
  produto1.Descricao.Value.SetValue('farinha');
  produto1.ToJSON(false).OnSome
  (
    procedure(value :Tjsonobject)
    begin
      memosql.Lines.add(value.ToString);
      produto2.FromJSON(value);
      value.Free;
      produto2.ToJSON(false).OnSome
      (
        procedure(value :Tjsonobject)
        begin
          memosql.Lines.add(value.ToString);
          value.Free;
        end
      )
    end
  )

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


procedure Tvcl_form.AtribuirDatasetAoGrid(resultado: IStormQuerySuccessExecution);
begin
  freeDataset;
  DataSource1.DataSet := resultado.GetDataset;
end;

end.
