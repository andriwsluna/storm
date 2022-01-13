unit uvcl_form;

interface

uses
  uORMProduto,
  System.Generics.Collections,
  storm.orm.interfaces,
  uEntityProduto,
  storm.orm.query,
  uSchemaProduto,
  storm.schema.register,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids;

type
  Tvcl_form = class(TForm)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    Button1: TButton;
    memosql: TMemo;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  vcl_form: Tvcl_form;

implementation

{$R *.dfm}

procedure Tvcl_form.Button1Click(Sender: TObject);
var
  parameters : TList<TQueryParameter>;
  parameter : TQueryParameter;
  produto : IORMProduto;
  select : IProdutoFieldSelection;
  only : IWhereNode<TProdutoWhereSelection>;
  where : IStormQueryPartition;
  cod : IStringWhere<TProdutoWhereSelection>;
  compo : IStormWhereCompositor<TProdutoWhereSelection>;
begin



    produto := TORMProduto.Create;
    //memosql.Text := produto.Select.Only([Codigo]).Where.Codigo.EqualsTo('2').GetSQL


    memosql.Text := produto
        .Select
      .Only([Codigo, Descricao])
      .Where
      .OpenParentheses
      .Codigo.EqualsTo('1')
      .Or_
      .Codigo.EqualsTo('2')
      .CloseParentheses
      .And_
      .Descricao.NotEqualsTo('Alooooha!')
      .GetSQL;



    //ADOQuery1.SQL.Text := memosql.Text;

//    for parameter in Parameters do
//    begin
//      ADOQuery1.Parameters.ParamByName(parameter.getParamName).Value := parameter.Value;
//    end;








end;

procedure Tvcl_form.Button2Click(Sender: TObject);
begin

  ADOQuery1.Open;
end;


end.
