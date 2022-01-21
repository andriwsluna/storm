unit uORMProduto;

interface

uses
  storm.orm.base,
  storm.orm.where,
  storm.orm.update,
  storm.orm.interfaces,
  storm.model.interfaces,
  storm.schema.interfaces,
  uEntityProduto,
  uSchemaProduto;

Type
  IModelProduto = IStormModel<IProduto>;

  TProdutoPossibleFields = (Codigo=0, Descricao=1);
  TProdutoSETFieldSelection = set of TProdutoPossibleFields;

  TProdutoWhereSelection<ExecutorType : TStormSqlPartition> = class(TStormSqlPartition)
  protected
    Schema : IStormTableSchema;

    Procedure Initialize; Override;
  public
    Function OpenParentheses() : TProdutoWhereSelection<ExecutorType>;
  public

    Function Codigo : IStringWhere<IStormWhereCompositor<TProdutoWhereSelection<ExecutorType>,ExecutorType>>;
    Function Descricao : InullableStringWhere<IStormWhereCompositor<TProdutoWhereSelection<ExecutorType>,ExecutorType>>;
  end;

  IProdutoFieldSelection<ExecutorType : TStormSqlPartition> = interface['{9AA32BD0-45FD-42D6-B88A-42570723FD21}']
    Function All() : IWhereNode<TProdutoWhereSelection<ExecutorType>>;
    Function Only(fields : TProdutoSETFieldSelection) : IWhereNode<TProdutoWhereSelection<ExecutorType>>;
  end;

  IProdutoFieldUpdate<ExecutorType : TStormSqlPartition> = interface
    Function Codigo : IStormStringUpdater<TWhereNode<TProdutoWhereSelection<ExecutorType>>>;
    Function Descricao : IStormStringNullableUpdater<IWhereNode<TProdutoWhereSelection<ExecutorType>>>;
  end;


  IORMProduto = interface['{F49CF2B7-E6F3-44BC-A28C-6FCF75930CDC}']
    Function Select()  : IProdutoFieldSelection<TStormSelectExecutor<IProduto>>;
    Function Update() : IProdutoFieldUpdate<TStormUpdateExecutor<IProduto>>;
  end;








Function ORMProduto : IORMProduto;


implementation

uses

  System.Sysutils;

VAR
  FSchema : IStormTableSchema;


Type


  TProdutoFieldSelection<ExecutorType : TStormSqlPartition> = class
  (
    TStormFieldSelection<TProdutoWhereSelection<ExecutorType>,TStormSelectExecutor<IProduto>>,
    IProdutoFieldSelection<ExecutorType>
  )
  public
    Constructor Create(sql : string);Reintroduce;
    Function Only(fields : TProdutoSETFieldSelection) : IWhereNode<TProdutoWhereSelection<ExecutorType>>;
  end;


  TProdutoFieldUpdate<ExecutorType : TStormSqlPartition> = class(TStormSqlPartition, IProdutoFieldUpdate<ExecutorType>)
  protected
    Schema : IStormTableSchema;

    Procedure Initialize; Override;
  public
  public
    Function Codigo : IStormStringUpdater<TWhereNode<TProdutoWhereSelection<ExecutorType>>>;
    Function Descricao : IStormStringNullableUpdater<IWhereNode<TProdutoWhereSelection<ExecutorType>>>;
  end;

  TORMProduto = class(TInterfacedObject, IORMProduto)
  private

  protected


    Procedure Initialize();
    Procedure Finalize();
  public
    Constructor Create(); Reintroduce;
    Destructor  Destroy(); Override;
  public
    Function Select()  : IProdutoFieldSelection<TStormSelectExecutor<IProduto>>;
    Function Update() : IProdutoFieldUpdate<TStormUpdateExecutor<IProduto>>;
  end;


Function ORMProduto : IORMProduto;
begin
  Result := TORMProduto.Create;
end;

Procedure InitializeSchema();
begin
  FSchema := TSchemaProduto.Create;
end;

Procedure FinalizeSchema();
begin
  FSchema := nil;
end;

{ TORMProduto }

constructor TORMProduto.Create;
begin
  inherited create();
  Initialize();
end;

destructor TORMProduto.Destroy;
begin
  Finalize();
  inherited;
end;

procedure TORMProduto.Finalize;
begin

end;

procedure TORMProduto.Initialize;
begin

end;

function TORMProduto.Select: IProdutoFieldSelection<TStormSelectExecutor<IProduto>>;
begin
  result := TProdutoFieldSelection<TStormSelectExecutor<IProduto>>.Create('select ');
end;


function TORMProduto.Update: IProdutoFieldUpdate<TStormUpdateExecutor<IProduto>>;
begin
  Result := TProdutoFieldUpdate<TStormUpdateExecutor<IProduto>>.Create();
end;

constructor TProdutoFieldSelection<ExecutorType>.Create(sql : string);
begin
  AddSQL(sql);
  inherited create(self,FSchema,TSchemaProduto(FSchema).Codigo);

end;

function TProdutoFieldSelection<ExecutorType>.Only(fields : TProdutoSETFieldSelection):
IWhereNode<TProdutoWhereSelection<ExecutorType>>;
VAR
  s : string;
  field : TProdutoPossibleFields;
begin
  s := '';
  for field in fields do
  begin
    FSchema.ColumnById(integer(field)).Bind
    (
      procedure(colum : IStormSchemaColumn)
      begin
        s := s + ', ' + FSchema.GetTableName + '.' + colum.GetColumnName;
      end
    );
  end;

  AddSQL(Copy(s,2, length(s)));
  Result := from;

end;

function TProdutoWhereSelection<ExecutorType>.Codigo : IStringWhere<IStormWhereCompositor<TProdutoWhereSelection<ExecutorType>,ExecutorType>>;
begin
  result :=
  TStringWhere<TProdutoWhereSelection<ExecutorType>,ExecutorType>
  .create(self,Schema,TSchemaProduto(Schema).Codigo);
end;


function TProdutoWhereSelection<ExecutorType>.Descricao: INullableStringWhere<IStormWhereCompositor<TProdutoWhereSelection<ExecutorType>,ExecutorType>>;
begin
  result := TNullableStringWhere<TProdutoWhereSelection<ExecutorType>,ExecutorType>
  .create(self,Schema,TSchemaProduto(Schema).Descricao);
end;


procedure TProdutoWhereSelection<ExecutorType>.Initialize;
begin
  inherited;
  Self.Schema := TSchemaProduto.Create;
end;

function TProdutoWhereSelection<ExecutorType>.OpenParentheses: TProdutoWhereSelection<ExecutorType>;
begin
  Result := TStormWhereSelection<TProdutoWhereSelection<ExecutorType>>.Create(self).OpenParentheses;
end;


{ TProdutoFieldUpdate<ExecutorType> }

function TProdutoFieldUpdate<ExecutorType>.Codigo: IStormStringUpdater<TWhereNode<TProdutoWhereSelection<ExecutorType>>>;
begin
  Result := TStormStringUpdater<TWhereNode<TProdutoWhereSelection<ExecutorType>>>.Create(self, Schema, TSchemaProduto(Schema).Codigo);
end;

function TProdutoFieldUpdate<ExecutorType>.Descricao: IStormStringNullableUpdater<IWhereNode<TProdutoWhereSelection<ExecutorType>>>;
begin

end;

procedure TProdutoFieldUpdate<ExecutorType>.Initialize;
begin
  inherited;
  Self.Schema := TSchemaProduto.Create;
  AddSQL('UPDATE ' + SQLDriver.GetFullTableName(Self.Schema) + ' SET ');
end;

INITIALIZATION
  InitializeSchema;

finalization
  FinalizeSchema;

end.

