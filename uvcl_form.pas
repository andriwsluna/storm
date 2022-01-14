unit uvcl_form;

interface

uses
  firedac.DApt,
  uORMProduto,
  storm.data.driver.ado,
  storm.data.driver.firedac,
  System.Generics.Collections,
  storm.orm.interfaces,
  storm.data.interfaces,
  uEntityProduto,
  storm.orm.query,
  uSchemaProduto,
  storm.schema.register,
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
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDMemTable2: TFDMemTable;
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure freeDataset;
  public
    { Public declarations }
  end;

var
  vcl_form: Tvcl_form;

implementation

{$R *.dfm}

procedure Tvcl_form.Button1Click(Sender: TObject);
begin
  freeDataset();

  DataSource1.DataSet :=
  ORMproduto.Select
    .Only([Codigo, Descricao])
    .Where
    .Codigo.IsIn(['1','3'])
    .Or_
    .Descricao.Contains('trigo')
    .Go
    .Execute(FDConnection1.StormDriver)
    //.Execute(ADOConnection1.StormDriver)
    .Dataset;






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

end.
