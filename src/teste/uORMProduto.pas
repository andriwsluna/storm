unit uORMProduto;

interface

uses
  storm.orm.base,
  storm.orm.where,
  storm.orm.interfaces,
  storm.schema.interfaces,
  uSchemaProduto;

Type



  TProdutoWhereSelection = class(TStormQueryPartition, IStormWhereSelection<TProdutoWhereSelection>)
  public
    Function OpenParentheses() : TProdutoWhereSelection;
    Function CloseParentheses() : TProdutoWhereSelection;
  public

    Function Codigo : IStringWhere<TProdutoWhereSelection>;
    Function Descricao : InullableStringWhere<TProdutoWhereSelection>;

     Constructor Create(owner : TStormSQLPartition = nil); Override;
     Destructor  Destroy(); Override;
  end;


  TProdutoPossibleFields = (Codigo=0, Descricao=1);
  TProdutoSETFieldSelection = set of TProdutoPossibleFields;

  IProdutoFieldSelection = interface['{9AA32BD0-45FD-42D6-B88A-42570723FD21}']
    Function All() : IWhereNode<TProdutoWhereSelection>;
    Function Only(fields : TProdutoSETFieldSelection) : IWhereNode<TProdutoWhereSelection>;
  end;


  TProdutoFieldSelection = class(TStormFieldSelection<TProdutoWhereSelection>, IProdutoFieldSelection)
  public
    Constructor Create(sql : string);Reintroduce;
    Function Only(fields : TProdutoSETFieldSelection) : IWhereNode<TProdutoWhereSelection>;
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


implementation

uses
  System.Sysutils;

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

function TProdutoFieldSelection.Only(fields : TProdutoSETFieldSelection): IWhereNode<TProdutoWhereSelection>;
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

{ TProdutoWhereSelection }

function TProdutoWhereSelection.CloseParentheses: TProdutoWhereSelection;
begin
  Result := TStormWhereSelection<TProdutoWhereSelection>.Create(self).CloseParentheses;
end;

function TProdutoWhereSelection.Codigo: IStringWhere<TProdutoWhereSelection>;
begin
  result := TStringWhere<TProdutoWhereSelection>.create(self,FSchema,TSchemaProduto(FSchema).Codigo);
end;




constructor TProdutoWhereSelection.Create(owner: TStormSQLPartition);
begin
  inherited;

end;

function TProdutoWhereSelection.Descricao: INullableStringWhere<TProdutoWhereSelection>;
begin
  result := TNullableStringWhere<TProdutoWhereSelection>.create(self,FSchema,TSchemaProduto(FSchema).Descricao);
end;

destructor TProdutoWhereSelection.Destroy;
begin

  inherited;
end;

function TProdutoWhereSelection.OpenParentheses: TProdutoWhereSelection;
begin
  Result := TStormWhereSelection<TProdutoWhereSelection>.Create(self).OpenParentheses;
end;


INITIALIZATION
  InitializeSchema;

finalization
  FinalizeSchema;

end.
