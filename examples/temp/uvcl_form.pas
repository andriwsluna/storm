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
    .Go
    .Open
      .OnSuccess(ShowDataset)
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
    .Codigo.SetValue('2')
    .Go
    .Execute
    .OnSuccess
    (
      procedure(resultado : IStormInsertSuccess<IProduto>)
      begin
        resultado.GetInserted;
      end
    )


end;

procedure Tvcl_form.Button4Click(Sender: TObject);
begin
  Produto_ORM(Getconnection)
    .Delete
    .Where
    .OpenParenthesis
    .Codigo.IsEqualsTo('8')
    .CloseParenthesis
    .Go
    .Execute
    .OnSuccess
    (
      procedure(resultado : IStormDeleteSuccess)
      begin
        resultado.RowsDeleted;
      end
    )


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

procedure Tvcl_form.ShowDataset(resultado: IStormSelectSuccess<IProduto>);
begin
  freeDataset;
  DataSource1.DataSet := resultado.GetDataset;
end;

end.
