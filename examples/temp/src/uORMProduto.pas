unit uORMProduto;

interface

uses
  DFE.Result,
  storm.model.interfaces,
  Data.DB,
  storm.data.interfaces,
  storm.orm.interfaces,
  System.TypInfo,
  uEntityProduto;

Type
  TProdutoPossibleFields = (Codigo=0, Descricao=1);
  TProdutoSETFieldSelection = set of TProdutoPossibleFields;

  IProdutoWhereSelector<Executor : IInterface> = interface['{CECF6A72-8A5C-491A-9B1A-BF0DB19A6C9A}']
    Function Codigo : IStormStringWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function Descricao : IStormStringNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function OpenParenthesis : IProdutoWhereSelector<Executor>;
  end;

  IProdutoFieldsSelection = interface['{20985878-707D-4DCD-B38E-0728934F48BC}']
    Function All() : IStormWherePoint<IProdutoWhereSelector<IStormSelectExecutor<IProduto>>>;
    Function Only(fields : TProdutoSETFieldSelection) : IStormWherePoint<IProdutoWhereSelector<IStormSelectExecutor<IProduto>>>;
  end;

  IProdutoFieldsAssignmentWithWhere=  interface['{990EF674-B643-4063-987E-6C28E5821B90}']
    Function Codigo : IStormStringFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Descricao : IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Where : IProdutoWhereSelector<IStormUpdateExecutor>;
  end;

  IProdutoFieldsAssignment = interface['{C36AB855-61F1-4BEE-9FE2-F0D134EA5809}']
    Function Codigo : IStormStringFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Descricao : IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
  end;

  IProdutoFinalFieldsInsertion =  interface['{B8B4616B-7527-4617-A92F-9C0832044F7A}']
    Function Codigo : IStormStringFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Go : IStormInsertExecutor<IProduto>;
  end;

  IProdutoFieldsInsertion = interface
    Function Codigo : IStormStringFieldInsertion<IProdutoFinalFieldsInsertion>;
  end;

  IProdutoORM = interface(IStormORM)['{E6255D1D-30FE-400A-8355-DD8CC1E62CB4}']
    Function Select() : IProdutoFieldsSelection;
    Function Update() : IProdutoFieldsAssignment;
    Function Insert() : IProdutoFieldsInsertion;
    Function Delete() : IStormWherePoint<IProdutoWhereSelector<IStormDeleteExecutor>>;
  end;


  Function Produto_ORM(DbSQLConnecton: IStormSQLConnection) : IProdutoORM;

implementation

Uses
  storm.schema.interfaces,
  storm.dependency.register,storm.orm.update,
  uSchemaProduto,
  System.Sysutils,
  storm.orm.where,
  storm.orm.insert,
  storm.orm.base;

Type
  TProdutoORM = Class(TStormORM, IProdutoORM)
  private
    Function SchemaProduto : TSchemaProduto;
  protected
    procedure Initialize; override;

  public
    Constructor Create(DbSQLConnecton : IStormSQLConnection);
  public
    Function Select() : IProdutoFieldsSelection;
    Function Update() : IProdutoFieldsAssignment;
    Function Insert() : IProdutoFieldsInsertion;
    Function Delete() : IStormWherePoint<IProdutoWhereSelector<IStormDeleteExecutor>>;
  End;


  TProdutoFieldsSelection = Class
  (
    TStormFieldsSelection<IProdutoWhereSelector<IStormSelectExecutor<IProduto>>, IStormSelectExecutor<IProduto>>,
    IProdutoFieldsSelection
  )
    Function Only(fields : TProdutoSETFieldSelection) : IStormWherePoint<IProdutoWhereSelector<IStormSelectExecutor<IProduto>>>;
  end;

  TProdutoWhereSelector<Executor : IInterface> = class(TStormSqlPartition, IProdutoWhereSelector<Executor>)
    Function Codigo : IStormStringWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function Descricao : IStormStringNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function OpenParenthesis : IProdutoWhereSelector<Executor>;
  end;

  TProdutoFieldsAssignment
  = Class(TStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>,IStormUpdateExecutor>, IProdutoFieldsAssignment,IProdutoFieldsAssignmentWithWhere)
  protected
    procedure Initialize; Override;
  public
    Function Codigo : IStormStringFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Descricao : IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
  end;

  TProdutoFieldsInsertion = class(TStormSqlPartition, IProdutoFieldsInsertion, IProdutoFinalFieldsInsertion)
    Function Codigo : IStormStringFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Go : IStormInsertExecutor<IProduto>;
  end;


  {-----------Constructores -----}
  TProdutoWhereSelectorSelectConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoWhereSelector<IStormSelectExecutor<IProduto>>>)
  public
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoWhereSelector<IStormSelectExecutor<IProduto>>;
  End;

  TProdutoWhereSelectorUpdateConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoWhereSelector<IStormUpdateExecutor>>)
  public
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoWhereSelector<IStormUpdateExecutor>;
  End;

  TSelectExecutorConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IStormSelectExecutor<IProduto>>)
  public
    Function GetGenericInstance(Owner : TStormSQLPartition) : IStormSelectExecutor<IProduto>;
  End;

  TProdutoFieldsAssignmentWithWhereConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoFieldsAssignmentWithWhere>)
  public
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoFieldsAssignmentWithWhere;
  End;

  TProdutoFinalFieldsInsertionConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoFinalFieldsInsertion>)
  public
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoFinalFieldsInsertion;
  End;

  TProdutoEntityConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProduto>)
  public
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProduto;
  End;


Function Produto_ORM(DbSQLConnecton: IStormSQLConnection) : IProdutoORM;
begin
  Result := TProdutoORM.Create(DbSQLConnecton);
end;



{ TProdutoORM }

constructor TProdutoORM.Create(DbSQLConnecton: IStormSQLConnection);
begin
  inherited create(DbSQLConnecton, TSchemaProduto.Create);
end;


function TProdutoORM.Delete: IStormWherePoint<IProdutoWhereSelector<IStormDeleteExecutor>>;
begin

end;

procedure TProdutoORM.Initialize;
begin
  inherited;
  FClassConstructor.Add
  (
    TGUID(IProdutoWhereSelector<IStormSelectExecutor<IProduto>>).ToString +
    TGUID(IStormSelectExecutor<IProduto>).ToString,
    TProdutoWhereSelectorSelectConstructor.Create
  );

  FClassConstructor.Add
  (
    TGUID(IProdutoWhereSelector<IStormUpdateExecutor>).ToString +
    TGUID(IStormUpdateExecutor).ToString,
    TProdutoWhereSelectorUpdateConstructor.Create
  );


  FClassConstructor.Add
  (
    TGUID(IStormSelectExecutor<IProduto>).ToString,
    TSelectExecutorConstructor.Create
  );

  FClassConstructor.Add
  (
    TGUID(IProdutoFieldsAssignment).ToString,
    TProdutoFieldsAssignmentWithWhereConstructor.Create
  );

  FClassConstructor.Add
  (
    TGUID(IProdutoFieldsAssignmentWithWhere).ToString,
    TProdutoFieldsAssignmentWithWhereConstructor.Create
  );

  FClassConstructor.Add
  (
    TGUID(IProdutoFinalFieldsInsertion).ToString,
    TProdutoFinalFieldsInsertionConstructor.Create
  );

  FClassConstructor.Add
  (
    TGUID(IProduto).ToString,
    TProdutoEntityConstructor.Create
  );








end;


function TProdutoORM.Insert: IProdutoFieldsInsertion;
begin
  Result := TProdutoFieldsInsertion.Create(self);
end;

function TProdutoORM.SchemaProduto: TSchemaProduto;
begin
  Result := self.TableSchema as TSchemaProduto;
end;





function TProdutoORM.Select: IProdutoFieldsSelection;
begin
  Result := TProdutoFieldsSelection.Create(self);
end;

function TProdutoORM.Update: IProdutoFieldsAssignment;
begin
  Result := TProdutoFieldsAssignment.Create(self);
end;

{ TProdutoFieldsSelection }

function TProdutoFieldsSelection.Only(
  fields: TProdutoSETFieldSelection): IStormWherePoint<IProdutoWhereSelector<IStormSelectExecutor<IProduto>>>;
VAR
  s : string;
  field : TProdutoPossibleFields;
begin
  s := '';

  for field in fields do
  begin
    TableSchema.ColumnById(integer(field)).Onsome
    (
      procedure(colum : IStormSchemaColumn)
      begin
        s := s + ', ' + TableSchema.GetTableName + '.' + colum.GetColumnName;
      end
    );
  end;

  AddSQL(Copy(s,2, length(s)));
  AddFrom;
  Result := TStormWherePoint<IProdutoWhereSelector<IStormSelectExecutor<IProduto>>, IStormSelectExecutor<IProduto>>.Create(self);
end;

{ TProdutoWhereSelectorSelectConstructor }

function TProdutoWhereSelectorSelectConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoWhereSelector<IStormSelectExecutor<IProduto>>;
begin
  Result := TProdutoWhereSelector<IStormSelectExecutor<IProduto>>.Create(Owner);
end;

{ TProdutoWhereSelector<Executor> }

function TProdutoWhereSelector<Executor>.Codigo: IStormStringWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormStringWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Codigo);
end;

function TProdutoWhereSelector<Executor>.Descricao: IStormStringNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormStringWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Descricao);
end;

function TProdutoWhereSelector<Executor>.OpenParenthesis: IProdutoWhereSelector<Executor>;
begin
  AddOpenParenthesis;
  Result := Self;
end;

{ TSelectExecutorConstructor }

function TSelectExecutorConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IStormSelectExecutor<IProduto>;
begin
  Result := TStormSelectExecutor<IProduto>.Create(Owner);
end;

{ TProdutoFieldsAssignment }

function TProdutoFieldsAssignment.Codigo: IStormStringFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  Result := TStormStringFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Codigo);
end;

function TProdutoFieldsAssignment.Descricao: IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  Result := TStormStringFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Descricao);
end;

procedure TProdutoFieldsAssignment.initialize;
begin
  inherited;
  if self.SQL.IsEmpty then
  begin
    AddSQL('UPDATE ' + self.GetFullTableName + ' SET');
  end;
end;

{ TProdutoFieldsAssignmentWithWhereConstructor }

function TProdutoFieldsAssignmentWithWhereConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoFieldsAssignmentWithWhere;
begin
  Result := TProdutoFieldsAssignment.Create(Owner);
end;

{ TProdutoWhereSelectorUpdateConstructor }

function TProdutoWhereSelectorUpdateConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoWhereSelector<IStormUpdateExecutor>;
begin
  Result :=  TProdutoWhereSelector<IStormUpdateExecutor>.Create(owner);
end;

{ TProdutoFieldsInsertion }

function TProdutoFieldsInsertion.Codigo: IStormStringFieldInsertion<IProdutoFinalFieldsInsertion>;
begin
  Result := TStormStringFieldInsertion<IProdutoFinalFieldsInsertion>.Create(Self, TSchemaProduto(Self.TableSchema).Codigo);
end;

function TProdutoFieldsInsertion.Go: IStormInsertExecutor<IProduto>;
begin
  Result := TStormInsertExecutor<IProduto>.Create(Self);
end;

{ TProdutoFinalFieldsInsertionConstructor }

function TProdutoFinalFieldsInsertionConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoFinalFieldsInsertion;
begin
  Result := TProdutoFieldsInsertion.Create(Owner);
end;

{ TProdutoEntityConstructor }

function TProdutoEntityConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProduto;
begin
  Result := NewProduto();
end;

end.
