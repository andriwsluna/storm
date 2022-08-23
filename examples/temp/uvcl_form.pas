{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
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
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.ObjectScope, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.Buttons, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  Vcl.NumberBox
  ;

type
  Tx = function(item : tobject)  : Boolean of object;
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
    RadioGroup: TRadioGroup;
    RadioButtonSim: TRadioButton;
    RadioButtonNao: TRadioButton;
    SpeedButton1: TSpeedButton;
    EditDataCriacao: TMaskEdit;
    EditDataAlteracao: TMaskEdit;
    Button7: TButton;
    Label2: TLabel;
    Label3: TLabel;
    ComboBoxMarca: TComboBox;
    EditPreco: TMaskEdit;
    Label4: TLabel;
    Label5: TLabel;
    FDMemTable1: TFDMemTable;
    Button8: TButton;
    Button9: TButton;
    NumberBoxLimit: TNumberBox;
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
  private
    ProdutoAtual :  IProduto;

    procedure freeDataset;
    Procedure ShowDataset(resultado : IStormSelectSuccess<IProduto>);
    procedure ShowJson(json : TJsonObject);
    procedure ShowJsonModel(json : TJsonArray);
    Procedure MostrarErro(resultado : IStormExecutionFail);
    Function  GetCodigo() : Maybe<String>;
    Function  GetDescricao() : Maybe<String>;
    Function  GetCodigoMarca() : Maybe<integer>;
    Function  GetPreco() : Maybe<Extended>;
    Function  GetAtivo() : Maybe<Boolean>;
    Function  GetDataCriacao() : Maybe<TDate>;
    Function  GetDataAlteracao() : Maybe<TDateTime>;
    procedure MostrarResultadoInsertPositivo(resultado : IStormInsertSuccess);
    Procedure ProdutoToJson(produto : IProduto);
    Procedure AtualizarGridDoProduto(produto : IProduto);
    Procedure AtualizarGridAposInsercao(produto : IProduto);
    Procedure AtualizarGridAposExclusao(produto : IProduto);
    Procedure CarregarProduto();
    Procedure AlimentarProduto(produto : Iproduto);
  public


  end;

procedure dofunc(x : Tx);

var
  vcl_form : Tvcl_form;

implementation

procedure dofunc(x : Tx);
begin
  x(nil);
end;

{$R *.dfm}


procedure Tvcl_form.AlimentarProduto(produto: Iproduto);
begin
  produto.Codigo.Value.SetValue(getCodigo());
  produto.Descricao.Value.SetValue(GetDescricao());
  produto.CodigoMarca.Value.SetValue(GetCodigoMarca());
  produto.Preco.Value.SetValue(getpreco());
  produto.Ativo.Value.SetValue(GetAtivo());
  produto.DataCriacao.Value.SetValue(GetDataCriacao());
  produto.DataAlteracao.Value.SetValue(GetDataAlteracao());
end;

procedure Tvcl_form.AtualizarGridAposExclusao(produto: IProduto);
begin
  FDMemTable1.Locate('codigo_produto',produto.Codigo.GetValueOrDefault());
  FDMemTable1.Delete;
end;

procedure Tvcl_form.AtualizarGridAposInsercao(produto: IProduto);
begin
  Produto_ORM()
    .Select
    .AllColumns
    .Where
    .Codigo.IsNotNull
    .Go
    .Open
    .OnSuccess(ShowDataset)
    .OnFail(MostrarErro);

    FDMemTable1.Locate('codigo_produto',produto.Codigo.GetValueOrDefault());
end;

procedure Tvcl_form.AtualizarGridDoProduto(produto: IProduto);
begin
  FDMemTable1.DisableControls;
  try
    if produto.PopulateDataset(FDMemTable1) then
    begin
      FDMemTable1.Post;
    end
    else
    begin
      FDMemTable1.Cancel;
    end;

  finally
    FDMemTable1.EnableControls;
  end;

end;

procedure Tvcl_form.Button1Click(Sender: TObject);
begin
  Produto_ORM
    .Select
      .Codigo
      .Descricao
      .CodigoMarca
      .Ativo
      .Preco
      .DataCriacao
      .DataAlteracao
    .From
    .Where
      .Codigo.IsNotNull
    .Go
    .Open
      .OnSuccess(ShowDataset)
      .OnFail(MostrarErro);
end;


procedure Tvcl_form.Button2Click(Sender: TObject);
begin
  Produto_ORM()
    .Update
    .Descricao.SetThisOrNull(GetDescricao())
    .CodigoMarca.SetThisOrNull(GetCodigoMarca())
    .Preco.SetThisOrNull(GetPreco())
    .Ativo.SetThisOrNull(GetAtivo())
    .DataCriacao.SetThisOrNull(GetDataCriacao())
    .DataAlteracao.SetThisOrNull(GetDataAlteracao())
    .Where
    .Codigo.IsEqualsTo(produtoatual.Codigo.GetValueOrDefault())
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
  Produto_ORM()
    .Insert
    .Codigo.SetValue(editcodigo.text)
    .Descricao.SetValue(GetDescricao())
    .CodigoMarca.SetValue(GetCodigoMarca())
    .Preco.SetValue(GetPreco())
    .Ativo.SetValue(GetAtivo())
    .DataCriacao.SetValue(GetDataCriacao())
    .DataAlteracao.SetValue(GetDataAlteracao())
    .Go
    .Execute
    .OnSuccess(MostrarResultadoInsertPositivo)
    .OnFail(MostrarErro)

end;

procedure Tvcl_form.Button4Click(Sender: TObject);
begin
  Produto_ORM()
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
  Produto_ORM()
    .SelectByID(editcodigo.text)
    .OnSuccess(ProdutoToJson)
    .OnFail(MostrarErro)
end;

procedure Tvcl_form.Button6Click(Sender: TObject);
VAR
  produto : IProduto;
begin
  produto := NewProduto();
  AlimentarProduto(produto);


  Produto_ORM()
  .InsertEntity(produto)
  .OnSuccess(AtualizarGridAposInsercao)
  .OnFail(MostrarErro)
end;



procedure Tvcl_form.Button7Click(Sender: TObject);

begin
  AlimentarProduto(ProdutoAtual);
  Produto_ORM()
  .UpdateEntity(ProdutoAtual)
  .OnSuccess(AtualizarGridDoProduto)
  .OnFail(MostrarErro)

end;

procedure Tvcl_form.Button8Click(Sender: TObject);
VAR
  produto : IProduto;
begin
  produto := NewProduto();
  AlimentarProduto(produto);


  Produto_ORM()
  .DeleteEntity(produto)
  .OnSuccess(AtualizarGridAposExclusao)
  .OnFail(MostrarErro)
end;

procedure Tvcl_form.Button9Click(Sender: TObject);
begin
  uORMProduto.Produto_ORM
  .Select
    .Limit(NumberBoxLimit.ValueInt)
    .AllColumns
  .Where
    .Codigo.IsNotNull
  .Go
  .OrderBy
    .Codigo.ASC
    .Descricao.ASC
    .CodigoMarca.DESC
    .Preco.DESC
  .Open
    .OnSuccess(ShowDataset)
    .OnFail(MostrarErro);
end;

procedure Tvcl_form.CarregarProduto;
begin
    EditCodigo.Text := ProdutoAtual.Codigo.GetValueOrDefault();
    EditDescricao.Text := ProdutoAtual.Descricao.GetValueOrDefault();
    ComboBoxMarca.Text := ProdutoAtual.CodigoMarca.GetValueOrDefault().ToString;
    EditPreco.Text := ProdutoAtual.Preco.GetValueOrDefault().ToString;
end;

procedure Tvcl_form.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  ProdutoAtual.FromDataset(datasource1.dataset);
  CarregarProduto();
end;

procedure Tvcl_form.FormCreate(Sender: TObject);
begin
  DependencyRegister.RegisterSQLDriver(storm.data.driver.mysql.TStormMySqlDriver.Create);
  //DependencyRegister.RegisterSQLDriver(storm.data.driver.mssql.TStormMSSQlDriver.Create);

  DependencyRegister.RegisterSQLConnection(FDConnection1.StormDriver);

  ProdutoAtual := NewProduto();
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

function Tvcl_form.GetAtivo: Maybe<Boolean>;
begin
  if RadioButtonSim.Checked then
  begin
    result := true;
  end
  else
  if RadioButtonNao.Checked then
  begin
    result := false;
  end;
end;

function Tvcl_form.GetCodigo: Maybe<String>;
begin
  if EditCodigo.Text <> '' then
  begin
    Result := EditCodigo.Text;
  end;
end;

function Tvcl_form.GetCodigoMarca: Maybe<integer>;
var
  i : integer;
begin
  if ComboBoxMarca.ItemIndex > -1 then
  begin
    if TryStrToInt(ComboBoxMarca.Items[ComboBoxMarca.ItemIndex], i) then
    begin
      result := i;
    end;

  end;
end;




function Tvcl_form.GetDataAlteracao: Maybe<TDateTime>;
VAR
  d : TDateTime;
begin
  if EditDataAlteracao.Text <> '__/__/____ __:__:__' then
  begin
    if TryStrToDateTime(EditDataAlteracao.Text, d) then
    begin
      result := d;
    end;
  end;
end;

function Tvcl_form.GetDataCriacao: Maybe<TDate>;
VAR
  d : TDateTime;
begin
  if EditDataCriacao.Text <> '__/__/____' then
  begin
    if TryStrToDate(EditDataCriacao.Text, d) then
    begin
      result := TDate(d);
    end;
  end;
end;

function Tvcl_form.GetDescricao: Maybe<String>;
begin
  if EditDescricao.Text <> '' then
  begin
    Result := EditDescricao.Text;
  end;
end;

function Tvcl_form.GetPreco: Maybe<Extended>;
VAR
  f : Extended;
begin
  if EditPreco.Text <> '' then
  begin
    if TryStrToFloat(EditPreco.Text, f) then
    begin
      result := f;
    end;
  end;
end;

procedure Tvcl_form.MostrarErro(resultado: IStormExecutionFail);
begin
  memosql.Text := resultado.GetErrorMessage;
  memosql.lines.add('');
  memosql.lines.add(resultado.GetExecutedCommand);

end;

procedure Tvcl_form.MostrarResultadoInsertPositivo(
  resultado: IStormInsertSuccess);
  VAR
    cod : string;
begin
  cod := EditCodigo.Text;
  Produto_ORM()
    .Select
    .AllColumns
    .Where
    .Codigo.IsNotNull
    .Go
    .Open
    .OnSuccess(ShowDataset)
    .OnFail(MostrarErro);

    FDMemTable1.Locate('codigo_produto',cod);
end;

procedure Tvcl_form.ProdutoToJson(produto: IProduto);
begin
  produto.ToJSON(true).OnSome(showJson);
end;

procedure Tvcl_form.ShowDataset(resultado: IStormSelectSuccess<IProduto>);
VAR
  ds : tdataset;
begin
  ds :=  resultado.GetDataset;
  FDMemTable1.CopyDataSet(ds,[coStructure,coAppend,coRestart]);
  ds.Free;
  resultado.GetModel.ToJSON(true).OnSome(ShowJsonModel)
end;

procedure Tvcl_form.ShowJson(json: TJsonObject);
begin
  MemoJson.lines.add(json.ToString);
  json.Free;

end;

procedure Tvcl_form.ShowJsonModel(json: TJsonArray);
begin
  MemoJson.lines.add(json.ToString);
  json.Free;
end;

procedure Tvcl_form.SpeedButton1Click(Sender: TObject);
begin
  RadioButtonSim.Checked := false;
  RadioButtonNao.Checked := false;
end;



end.
