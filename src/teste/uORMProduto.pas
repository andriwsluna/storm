unit uORMProduto;

interface

uses
  storm.orm.base,
  storm.orm.where,
  storm.orm.interfaces,
  storm.model.interfaces,
  storm.schema.interfaces,
  uEntityProduto,
  uSchemaProduto;

Type
  QueryProdutoSuccess = IStormQuerySuccessExecution<IProduto>;
  IModelProduto = IStormModel<IProduto>;
  TProdutoWhereSelection = class(TStormQueryPartition<IProduto>, IStormWhereSelection<IProduto,TProdutoWhereSelection>)
  protected
    Procedure Initialize; Override;
  public
    Function OpenParentheses() : TProdutoWhereSelection;
  public

    Function Codigo : IStringWhere<IProduto,TProdutoWhereSelection>;
    Function Descricao : InullableStringWhere<IProduto,TProdutoWhereSelection>;

     Constructor Create(owner : TStormSQLPartition = nil); Override;
     Destructor  Destroy(); Override;
  end;


  TProdutoPossibleFields = (Codigo=0, Descricao=1);
  TProdutoSETFieldSelection = set of TProdutoPossibleFields;

  IProdutoFieldSelection = interface['{9AA32BD0-45FD-42D6-B88A-42570723FD21}']
    Function All() : IWhereNode<IProduto,TProdutoWhereSelection>;
    Function Only(fields : TProdutoSETFieldSelection) : IWhereNode<IProduto,TProdutoWhereSelection>;
  end;


  TProdutoFieldSelection = class(TStormFieldSelection<IProduto,TProdutoWhereSelection>, IProdutoFieldSelection)
  public
    Constructor Create(sql : string);Reintroduce;
    Function Only(fields : TProdutoSETFieldSelection) : IWhereNode<IProduto,TProdutoWhereSelection>;
  end;



  IORMProduto = interface['{F49CF2B7-E6F3-44BC-A28C-6FCF75930CDC}']
    Function Select()  : IProdutoFieldSelection;
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
    Function Select()  : IProdutoFieldSelection;
  end;

VAR
  FSchema : IStormTableSchema;

Procedure InitializeSchema();
Procedure FinalizeSchema();
Function ORMProduto : IORMProduto;


implementation

uses
  System.Sysutils;

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

function TORMProduto.Select: IProdutoFieldSelection;
begin
  result := TProdutoFieldSelection.Create('select ');
end;


constructor TProdutoFieldSelection.Create(sql : string);
begin
  AddSQL(sql);
  inherited create(self,FSchema,TSchemaProduto(FSchema).Codigo);

end;

function TProdutoFieldSelection.Only(fields : TProdutoSETFieldSelection): IWhereNode<IProduto,TProdutoWhereSelection>;
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

function TProdutoWhereSelection.Codigo: IStringWhere<IProduto,TProdutoWhereSelection>;
begin
  result := TStringWhere<IProduto,TProdutoWhereSelection>.create(self,FSchema,TSchemaProduto(FSchema).Codigo);
end;

constructor TProdutoWhereSelection.Create(owner: TStormSQLPartition);
begin
  inherited;

end;

function TProdutoWhereSelection.Descricao: INullableStringWhere<IProduto,TProdutoWhereSelection>;
begin
  result := TNullableStringWhere<IProduto,TProdutoWhereSelection>.create(self,FSchema,TSchemaProduto(FSchema).Descricao);
end;

destructor TProdutoWhereSelection.Destroy;
begin

  inherited;
end;

procedure TProdutoWhereSelection.Initialize;
begin
  inherited;
end;

function TProdutoWhereSelection.OpenParentheses: TProdutoWhereSelection;
begin
  Result := TStormWhereSelection<IProduto,TProdutoWhereSelection>.Create(self).OpenParentheses;
end;


INITIALIZATION
  InitializeSchema;

finalization
  FinalizeSchema;

end.

