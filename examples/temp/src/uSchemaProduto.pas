unit uSchemaProduto;

interface

uses
  storm.schema.table,
  storm.schema.column,
  storm.schema.interfaces,
  storm.schema.types,

  System.Classes,
  System.Sysutils;

type

  TSchemaProduto = class(TStormTableSchema)
  private
    FCodigoProduto : IStormSchemaColumn;
    FDescricao     : IStormSchemaColumn;
    FCodigoMarca   : IStormSchemaColumn;
    FPreco         : IStormSchemaColumn;
    FAtivo         : IStormSchemaColumn;
    FDataCriacao   : IStormSchemaColumn;
    FDataAlteracao : IStormSchemaColumn;

  protected
    procedure Initialize(); override;

  public
    property CodigoProduto : IStormSchemaColumn read FCodigoProduto;
    property Descricao     : IStormSchemaColumn read FDescricao;
    property CodigoMarca   : IStormSchemaColumn read FCodigoMarca;
    property Preco         : IStormSchemaColumn read FPreco;
    property Ativo         : IStormSchemaColumn read FAtivo;
    property DataCriacao   : IStormSchemaColumn read FDataCriacao;
    property DataAlteracao : IStormSchemaColumn read FDataAlteracao;

    constructor Create(); reintroduce;
    destructor Destroy(); override;
  end;

implementation

constructor TSchemaProduto.Create;
begin
  inherited Create('dbo', 'produto', 'Produto');
end;

destructor TSchemaProduto.Destroy;
begin
  inherited;
end;

procedure TSchemaProduto.Initialize;
begin
  inherited;
  FCodigoProduto := TStormColumnSchema.Create
  (
    'codigo_produto',
    'CodigoProduto',
    TStormInt.Create(),
    [PrimaryKey,AutoIncrement,NotNull]
  );

  FDescricao := TStormColumnSchema.Create
  (
    'descricao',
    'Descricao',
    TStormVarchar.Create(200),
    []
  );

  FCodigoMarca := TStormColumnSchema.Create
  (
    'codigo_marca',
    'CodigoMarca',
    TStormInt.Create(),
    []
  );

  FPreco := TStormColumnSchema.Create
  (
    'preco',
    'Preco',
    TStormNumeric.Create(18, 3),
    []
  );

  FAtivo := TStormColumnSchema.Create
  (
    'ativo',
    'Ativo',
    TStormBoolean.Create(),
    []
  );

  FDataCriacao := TStormColumnSchema.Create
  (
    'data_criacao',
    'DataCriacao',
    TStormDate.Create(),
    []
  );

  FDataAlteracao := TStormColumnSchema.Create
  (
    'data_alteracao',
    'DataAlteracao',
    TStormDateTime.Create(),
    []
  );

  AddColumn(CodigoProduto);
  AddColumn(Descricao);
  AddColumn(CodigoMarca);
  AddColumn(Preco);
  AddColumn(Ativo);
  AddColumn(DataCriacao);
  AddColumn(DataAlteracao);
end;

end.

