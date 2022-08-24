unit uSchemaProduto;

interface

Uses
  storm.schema.table,
  storm.schema.column,
  storm.schema.interfaces,
  storm.schema.types.varchar,

  System.Classes,
  System.Sysutils;


Type

TSchemaProduto = class(TStormTableSchema)
  private
    FCodigo : IStormSchemaColumn;
    FDescricao : IStormSchemaColumn;
    FCodigoMarca : IStormSchemaColumn;
    FPreco  : IStormSchemaColumn;
    FAtivo  : IStormSchemaColumn;
    FDataCriacao  : IStormSchemaColumn;
    FDataAlteracao  : IStormSchemaColumn;
  protected
    Procedure Initialize(); Override;
  public
    property Codigo: IStormSchemaColumn read FCodigo;
    property Descricao: IStormSchemaColumn read FDescricao;
    property CodigoMarca: IStormSchemaColumn read FCodigoMarca;
    property Preco: IStormSchemaColumn read FPreco;
    property Ativo: IStormSchemaColumn read FAtivo;
    property DataCriacao: IStormSchemaColumn read FDataCriacao;
    property DataAlteracao: IStormSchemaColumn read FDataAlteracao;
    Constructor Create(); Reintroduce;
    Destructor Destroy(); Override;
end;



implementation

{ TSchemaProduto }

constructor TSchemaProduto.Create;
begin
  inherited Create('dbo', 'produto', 'Produto');
end;


destructor TSchemaProduto.Destroy;
begin
  FCodigo := nil;
  inherited;
end;

procedure TSchemaProduto.Initialize;
begin
  inherited;
  FCodigo := TStormColumnSchema.Create(
    'codigo_produto',
    'Codigo',
    TStormInt.Create(),
    [PrimaryKey, AutoIncrement, NotNull]
  );

  FDescricao := TStormColumnSchema.Create(
    'descricao',
    'Descricao',
    TStormVarchar.Create(200),
    []
  );

  FCodigoMarca := TStormColumnSchema.Create(
    'codigo_marca',
    'CodigoMarca',
    TStormInt.Create,
    []
  );

  FPreco:= TStormColumnSchema.Create(
    'preco',
    'Preco',
    TStormNumeric.Create(18,3),
    []
  );

  FAtivo:= TStormColumnSchema.Create(
    'ativo',
    'Ativo',
    TStormBoolean.Create,
    []
  );

  FDataCriacao:= TStormColumnSchema.Create(
    'data_criacao',
    'DataCriacao',
    TStormDate.Create,
    []
  );

  FDataAlteracao:= TStormColumnSchema.Create(
    'data_alteracao',
    'DataAlteracao',
    TStormDateTime.Create,
    []
  );

  AddColumn(Codigo);
  AddColumn(Descricao);
  AddColumn(CodigoMarca);
  AddColumn(Preco);
  AddColumn(Ativo);
  AddColumn(DataCriacao);
  AddColumn(DataAlteracao);
end;

end.
