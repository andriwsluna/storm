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
    FCodigo_produto : IStormSchemaColumn;
    FDescricao     : IStormSchemaColumn;
    FCodigo_marca  : IStormSchemaColumn;
    FPreco         : IStormSchemaColumn;
    FAtivo         : IStormSchemaColumn;
    FData_criacao  : IStormSchemaColumn;
    FData_alteracao : IStormSchemaColumn;
    
  protected
    procedure Initialize(); override;
    
  public
    property Codigo_produto : IStormSchemaColumn read FCodigo_produto;
    property Descricao     : IStormSchemaColumn read FDescricao;
    property Codigo_marca  : IStormSchemaColumn read FCodigo_marca;
    property Preco         : IStormSchemaColumn read FPreco;
    property Ativo         : IStormSchemaColumn read FAtivo;
    property Data_criacao  : IStormSchemaColumn read FData_criacao;
    property Data_alteracao : IStormSchemaColumn read FData_alteracao;
    
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
  FCodigo_produto := TStormColumnSchema.Create
  (
    'codigo_produto',
    'Codigo_produto',
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
  
  FCodigo_marca := TStormColumnSchema.Create
  (
    'codigo_marca',
    'Codigo_marca',
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
  
  FData_criacao := TStormColumnSchema.Create
  (
    'data_criacao',
    'Data_criacao',
    TStormDate.Create(),
    []
  );
  
  FData_alteracao := TStormColumnSchema.Create
  (
    'data_alteracao',
    'Data_alteracao',
    TStormDateTime.Create(),
    []
  );
  
  AddColumn(Codigo_produto);
  AddColumn(Descricao);
  AddColumn(Codigo_marca);
  AddColumn(Preco);
  AddColumn(Ativo);
  AddColumn(Data_criacao);
  AddColumn(Data_alteracao);
end;

end.
