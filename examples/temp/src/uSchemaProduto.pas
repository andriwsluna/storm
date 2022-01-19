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
  protected
    Procedure Initialize(); Override;
  public
    property Codigo: IStormSchemaColumn read FCodigo;
    property Descricao: IStormSchemaColumn read FDescricao;
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
    TStormVarchar.Create(50),
    [PrimaryKey, NotNull]
  );

  FDescricao := TStormColumnSchema.Create(
    'descricao',
    'Descricao',
    TStormVarchar.Create(200),
    [NotNull]
  );

  AddColumn(Codigo);
  AddColumn(Descricao);
end;

end.
