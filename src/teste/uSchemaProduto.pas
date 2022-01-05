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
    Function Codigo() : IStormSchemaColumn;
    Function Descricao() : IStormSchemaColumn;
  protected

  public
    Constructor Create(); Reintroduce;
end;



implementation

{ TSchemaProduto }

constructor TSchemaProduto.Create;
begin
  inherited Create('dbo', 'produto', 'Produto');
  AddColumn(Codigo);
  AddColumn(Descricao);
end;

function TSchemaProduto.Codigo: IStormSchemaColumn;
begin
  Result := TStormColumnSchema.Create(
    'codigo_produto',
    'Codigo',
    TStormVarchar.Create(50),
    [PrimaryKey, NotNull]
  );
end;

function TSchemaProduto.Descricao: IStormSchemaColumn;
begin
  Result := TStormColumnSchema.Create(
    'descricao_produto',
    'Descricao',
    TStormVarchar.Create(200),
    [NotNull]
  );
end;

end.
