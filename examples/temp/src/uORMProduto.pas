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
  TProdutoPossibleFields =
  (
     Codigo         = 0
    ,Descricao      = 1
    ,CodigoMarca    = 2
    ,Preco          = 3
    ,Ativo          = 4
    ,DataCriacao    = 5
    ,DataAlteracao  = 6
  );
  TProdutoSETFieldSelection = set of TProdutoPossibleFields;


  ISelectByIDResult = TResult<IProduto, IStormExecutionFail>;
  IUpdateEntityResult = TResult<IProduto, IStormExecutionFail>;
  IInsertEntityResult = TResult<IProduto, IStormExecutionFail>;
  IDeleteEntityResult = TResult<IProduto, IStormExecutionFail>;

  IProdutoWhereSelector<Executor : IInterface> = interface['{CECF6A72-8A5C-491A-9B1A-BF0DB19A6C9A}']
    Function Codigo : IStormStringWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function Descricao : IStormStringNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function CodigoMarca : IStormIntegerNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function Preco : IStormFloatNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function Ativo : IStormBooleanNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function DataCriacao : IStormDateNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function DataAlteracao : IStormDateTimeNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function OpenParenthesis : IProdutoWhereSelector<Executor>;
  end;

  IProdutoFieldsSelection = interface['{20985878-707D-4DCD-B38E-0728934F48BC}']
    Function AllColumns() : IStormWherePoint<IProdutoWhereSelector<IStormSelectExecutor<IProduto>>>;
    Function Codigo() : IProdutoFieldsSelection;
    Function Descricao() : IProdutoFieldsSelection;
    Function CodigoMarca() : IProdutoFieldsSelection;
    Function Preco() : IProdutoFieldsSelection;
    Function Ativo() : IProdutoFieldsSelection;
    Function DataCriacao() : IProdutoFieldsSelection;
    Function DataAlteracao() : IProdutoFieldsSelection;
    Function From : IStormWherePoint<IProdutoWhereSelector<IStormSelectExecutor<IProduto>>>;
  end;

  IProdutoFieldsSelectionWithLimit = interface(IProdutoFieldsSelection)['{20985878-707D-4DCD-B38E-0728934F48BC}']
    Function Limit(Const Count : Integer) : IProdutoFieldsSelection;
  end;

  IProdutoFieldsAssignmentWithWhere=  interface['{990EF674-B643-4063-987E-6C28E5821B90}']
    Function Codigo : IStormStringFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Descricao : IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function CodigoMarca : IStormIntegerNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Preco : IStormFloatNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Ativo : IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function DataCriacao : IStormDateNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function DataAlteracao : IStormDateTimeNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Where : IProdutoWhereSelector<IStormUpdateExecutor>;
  end;

  IProdutoFieldsAssignment = interface['{C36AB855-61F1-4BEE-9FE2-F0D134EA5809}']
    Function Codigo : IStormStringFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Descricao : IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function CodigoMarca : IStormIntegerNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Ativo : IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Preco : IStormFloatNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function DataCriacao : IStormDateNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function DataAlteracao : IStormDateTimeNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function FromEntyity(Entity : IProduto) : IStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>>;
  end;

  IProdutoFinalFieldsInsertion =  interface['{B8B4616B-7527-4617-A92F-9C0832044F7A}']
    Function Codigo : IStormStringFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Descricao : IStormStringNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function CodigoMarca : IStormIntegerNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Preco : IStormFloatNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Ativo : IStormBooleanNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function DataCriacao : IStormDateNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function DataAlteracao : IStormDateTimeNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Go : IStormInsertExecutor<IProduto>;
  end;

  IProdutoFieldsInsertion = interface
    Function Codigo : IStormStringFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Descricao : IStormStringNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function CodigoMarca : IStormIntegerNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Preco : IStormFloatNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Ativo : IStormBooleanNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function DataCriacao : IStormDateNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function DataAlteracao : IStormDateTimeNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function FromEntyity(Entity : IProduto) : IStormInsertExecutor<IProduto>;
  end;

  IProdutoORM = interface(IStormORM)['{E6255D1D-30FE-400A-8355-DD8CC1E62CB4}']
    Function Select() : IProdutoFieldsSelectionWithLimit;
    Function Update() : IProdutoFieldsAssignment;
    Function Insert() : IProdutoFieldsInsertion;
    Function Delete() : IStormWherePoint<IProdutoWhereSelector<IStormDeleteExecutor>>;

    Function SelectByID(const Codigo : String) : ISelectByIDResult;
    Function UpdateEntity(Entity : IProduto) : IUpdateEntityResult;
    Function InsertEntity(Entity : IProduto) : IInsertEntityResult;
    Function DeleteEntity(Entity : IProduto) : IDeleteEntityResult;
  end;


  function Produto_ORM(DbSQLConnecton: IStormSQLConnection): IProdutoORM;  Overload;
  Function Produto_ORM() : IProdutoORM; Overload;

implementation

Uses
  storm.schema.interfaces,
  storm.dependency.register,
  storm.orm.update,
  uSchemaProduto,
  System.Sysutils,
  storm.orm.where,
  storm.orm.insert,
  storm.orm.base;

Type
  TProdutoORM = Class(TStormORM, IProdutoORM)
  private
    Function SchemaProduto : TSchemaProduto;

    function ProccessSelectSuccess(res : IStormSelectSuccess<Iproduto>) : ISelectByIDResult;
    function ProccessSelectFail(res : IStormExecutionFail) : ISelectByIDResult;

  protected
    procedure Initialize; override;

  public
    Constructor Create(DbSQLConnecton : IStormSQLConnection);
  public
    Function Select() : IProdutoFieldsSelectionWithLimit;
    Function Update() : IProdutoFieldsAssignment;
    Function Insert() : IProdutoFieldsInsertion;
    Function Delete() : IStormWherePoint<IProdutoWhereSelector<IStormDeleteExecutor>>;

    Function SelectByID(const Codigo : String) : ISelectByIDResult;
    Function UpdateEntity(Entity : IProduto) : IUpdateEntityResult;
    Function InsertEntity(Entity : IProduto) : IInsertEntityResult;
    Function DeleteEntity(Entity : IProduto) : IDeleteEntityResult;
  End;


  TProdutoFieldsSelection = Class
  (
    TStormFieldsSelection<IProdutoWhereSelector<IStormSelectExecutor<IProduto>>, IStormSelectExecutor<IProduto>>,
    IProdutoFieldsSelection,
    IProdutoFieldsSelectionWithLimit
  )
    Function Only(fields : TProdutoSETFieldSelection) : IStormWherePoint<IProdutoWhereSelector<IStormSelectExecutor<IProduto>>>;
    Function Limit(Const Count : Integer) : IProdutoFieldsSelection;
    Function Codigo() : IProdutoFieldsSelection;
    Function Descricao() : IProdutoFieldsSelection;
    Function CodigoMarca() : IProdutoFieldsSelection;
    Function Preco() : IProdutoFieldsSelection;
    Function Ativo() : IProdutoFieldsSelection;
    Function DataCriacao() : IProdutoFieldsSelection;
    Function DataAlteracao() : IProdutoFieldsSelection;
  end;

  TProdutoWhereSelector<Executor : IInterface> = class(TStormSqlPartition, IProdutoWhereSelector<Executor>)
    Function Codigo : IStormStringWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function Descricao : IStormStringNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function CodigoMarca : IStormIntegerNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function Preco : IStormFloatNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function Ativo : IStormBooleanNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function DataCriacao : IStormDateNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function DataAlteracao : IStormDateTimeNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function OpenParenthesis : IProdutoWhereSelector<Executor>;
  end;

  TProdutoFieldsAssignment
  = Class(TStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>,IStormUpdateExecutor>, IProdutoFieldsAssignment,IProdutoFieldsAssignmentWithWhere)
  protected
    procedure Initialize; Override;
  public
    Function Codigo : IStormStringFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Descricao : IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function CodigoMarca : IStormIntegerNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Preco : IStormFloatNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Ativo : IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function DataCriacao : IStormDateNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function DataAlteracao : IStormDateTimeNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function FromEntyity(Entity : IProduto) : IStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>>;
  end;

  TProdutoFieldsInsertion = class(TStormSqlPartition, IProdutoFieldsInsertion, IProdutoFinalFieldsInsertion)
    Function Codigo : IStormStringFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Descricao : IStormStringNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function CodigoMarca : IStormIntegerNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Preco : IStormFloatNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Ativo : IStormBooleanNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function DataCriacao : IStormDateNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function DataAlteracao : IStormDateTimeNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Go : IStormInsertExecutor<IProduto>;
    Function FromEntyity(Entity : IProduto) : IStormInsertExecutor<IProduto>;
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

  TProdutoWhereSelectorDeleteConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoWhereSelector<IStormDeleteExecutor>>)
  public
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoWhereSelector<IStormDeleteExecutor>;
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

Function Produto_ORM() : IProdutoORM;
begin
  Result :=
  storm.dependency.register.DependencyRegister.GetSQLConnectionInstance.
  BindTo<IProdutoORM>
  (
    Produto_ORM,
    Function : IProdutoORM
    begin
      Result := nil;
    end
  );
end;



{ TProdutoORM }

constructor TProdutoORM.Create(DbSQLConnecton: IStormSQLConnection);
begin
  inherited create(DbSQLConnecton, TSchemaProduto.Create);
end;


function TProdutoORM.Delete: IStormWherePoint<IProdutoWhereSelector<IStormDeleteExecutor>>;
begin
  Result := TStormWherePoint<IProdutoWhereSelector<IStormDeleteExecutor>,IStormDeleteExecutor>.Create(self);
end;

function TProdutoORM.DeleteEntity(Entity: IProduto): IDeleteEntityResult;
begin
  if VerifyPrimaryKeyFields(Entity) then
  begin
    Result := Delete()
    .Where
    .Codigo.IsEqualsTo(Entity.Codigo.GetValueOrDefault())
    .Go
    .Execute
    .BindTo<IDeleteEntityResult>
    (
      function(res : IStormDeleteSuccess) : IDeleteEntityResult
      begin
        result := Entity;
      end,
      function(res : IStormExecutionFail) : IDeleteEntityResult
      begin
        Result := res;
      end
    );
  end
  else
  begin
    Result := TStormExecutionFail.Create(TStormSqlPartition.Create(Self),'All Primary key fields must be assigned.');
  end;
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
    TGUID(IProdutoWhereSelector<IStormDeleteExecutor>).ToString +
    TGUID(IStormDeleteExecutor).ToString,
    TProdutoWhereSelectorDeleteConstructor.Create
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

function TProdutoORM.InsertEntity(Entity: IProduto): IInsertEntityResult;
begin
  if VerifyPrimaryKeyFields(Entity) then
  begin
    Result := Insert()
    .FromEntyity(Entity)
    .Execute
    .BindTo<IInsertEntityResult>
    (
      function(res : IStormInsertSuccess) : IInsertEntityResult
      begin
        result := Entity;
      end,
      function(res : IStormExecutionFail) : IInsertEntityResult
      begin
        Result := res;
      end
    );
  end
  else
  begin
    Result := TStormExecutionFail.Create(TStormSqlPartition.Create(Self),'All Primary key fields must be assigned.');
  end;
end;

function TProdutoORM.ProccessSelectFail(
  res: IStormExecutionFail): ISelectByIDResult;
begin
  Result := res;
end;

function TProdutoORM.ProccessSelectSuccess(
  res: IStormSelectSuccess<Iproduto>): ISelectByIDResult;
begin
  if not res.IsEmpty then
  begin
    result := res.GetModel.Records[0]
  end
  else
  begin
    result := TStormExecutionFail.Create
    (
      TStormSelectSuccess<Iproduto>(res) , 'Record not found'
    );
  end;
end;


function TProdutoORM.SchemaProduto: TSchemaProduto;
begin
  Result := self.TableSchema as TSchemaProduto;
end;





function TProdutoORM.Select: IProdutoFieldsSelectionWithLimit;
begin
  Result := TProdutoFieldsSelection.Create(self);
end;

function TProdutoORM.SelectByID(
  const Codigo: String): TResult<IProduto, IStormExecutionFail>;
begin
  result :=
  Self
    .Select
    .AllColumns
    .Where
    .Codigo.IsEqualsTo(Codigo)
    .Go
    .Open
    .BindTo<ISelectByIDResult>
      (ProccessSelectSuccess,ProccessSelectFail);

end;

function TProdutoORM.UpdateEntity(Entity: IProduto): IUpdateEntityResult;
begin
  if VerifyPrimaryKeyFields(Entity) then
  begin
    Result := Update()
    .FromEntyity(Entity)
    .Where
    .Codigo.IsEqualsTo(Entity.Codigo.GetValue.GetValueOrDefault(''))
    .Go
    .Execute
    .BindTo<IUpdateEntityResult>
    (
      function(res : IStormUpdateSuccess) : IUpdateEntityResult
      begin
        if res.RowsUpdated >= 1 then
        begin
          result := Entity;
        end
        else
        begin
          Result := TStormExecutionFail.Create(TStormSqlPartition(res),'Record not found');
        end;
      end,
      function(res : IStormExecutionFail) : IUpdateEntityResult
      begin
        Result := res;
      end
    );
  end
  else
  begin
    Result := TStormExecutionFail.Create(TStormSqlPartition.Create(Self),'All Primary key fields must be assigned.');
  end;



end;

function TProdutoORM.Update: IProdutoFieldsAssignment;
begin
  Result := TProdutoFieldsAssignment.Create(self);
end;

{ TProdutoFieldsSelection }

function TProdutoFieldsSelection.Ativo: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.Ativo));
  Result := Self;
end;

function TProdutoFieldsSelection.Codigo: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.Codigo));
  Result := Self;
end;

function TProdutoFieldsSelection.CodigoMarca: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.CodigoMarca));
  Result := Self;
end;

function TProdutoFieldsSelection.DataAlteracao: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.DataAlteracao));
  Result := Self;
end;

function TProdutoFieldsSelection.DataCriacao: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.DataCriacao));
  Result := Self;
end;

function TProdutoFieldsSelection.Descricao: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.Descricao));
  Result := Self;
end;


function TProdutoFieldsSelection.Limit(
  const Count: Integer): IProdutoFieldsSelection;
begin
  AddSQL('TOP ' + Count.ToString);
  Result := Self;
end;

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



function TProdutoFieldsSelection.Preco: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.Preco));
  Result := Self;
end;

{ TProdutoWhereSelectorSelectConstructor }

function TProdutoWhereSelectorSelectConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoWhereSelector<IStormSelectExecutor<IProduto>>;
begin
  Result := TProdutoWhereSelector<IStormSelectExecutor<IProduto>>.Create(Owner);
end;

{ TProdutoWhereSelector<Executor> }

function TProdutoWhereSelector<Executor>.Ativo: IStormBooleanNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  Result := TStormBooleanWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Ativo);
end;

function TProdutoWhereSelector<Executor>.Codigo: IStormStringWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormStringWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Codigo);
end;

function TProdutoWhereSelector<Executor>.CodigoMarca: IStormIntegerNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  Result := TStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.CodigoMarca);
end;

function TProdutoWhereSelector<Executor>.DataAlteracao: IStormDateTimeNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  Result := TStormDateTimeWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.DataAlteracao);
end;

function TProdutoWhereSelector<Executor>.DataCriacao: IStormDateNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  Result := TStormDateWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.DataCriacao);
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

function TProdutoWhereSelector<Executor>.Preco: IStormFloatNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  Result := TStormFloatWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Preco);
end;

{ TSelectExecutorConstructor }

function TSelectExecutorConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IStormSelectExecutor<IProduto>;
begin
  Result := TStormSelectExecutor<IProduto>.Create(Owner);
end;

{ TProdutoFieldsAssignment }

function TProdutoFieldsAssignment.Ativo: IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  Result := TStormBooleanFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Ativo);
end;

function TProdutoFieldsAssignment.Codigo: IStormStringFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  Result := TStormStringFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Codigo);
end;

function TProdutoFieldsAssignment.CodigoMarca: IStormIntegerNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  Result := TStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.CodigoMarca);
end;

function TProdutoFieldsAssignment.DataAlteracao: IStormDateTimeNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  Result := TStormDateTimeFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.DataAlteracao);
end;

function TProdutoFieldsAssignment.DataCriacao: IStormDateNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  Result := TStormDateFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.DataCriacao);
end;

function TProdutoFieldsAssignment.Descricao: IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  Result := TStormStringFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Descricao);
end;

function TProdutoFieldsAssignment.FromEntyity(
  Entity: IProduto): IStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>>;
begin
  Result := TStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>,IStormUpdateExecutor>.Create
  (
    Self
    .Descricao.SetThisOrNull(Entity.Descricao.GetValue())
    .CodigoMarca.SetThisOrNull(Entity.CodigoMarca.GetValue())
    .Preco.SetThisOrNull(Entity.Preco.GetValue())
    .Ativo.SetThisOrNull(Entity.Ativo.GetValue())
    .DataCriacao.SetThisOrNull(Entity.DataCriacao.GetValue())
    .DataAlteracao.SetThisOrNull(Entity.DataAlteracao.GetValue())
    as TStormSqlPartition
  );
end;

procedure TProdutoFieldsAssignment.initialize;
begin
  inherited;
  if self.SQL.IsEmpty then
  begin
    AddSQL('UPDATE ' + self.GetFullTableName + ' SET');
  end;
end;

function TProdutoFieldsAssignment.Preco: IStormFloatNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  Result := TStormFloatFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Preco);
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

function TProdutoFieldsInsertion.Ativo: IStormBooleanNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
begin
  Result := TStormBooleanFieldInsertion<IProdutoFinalFieldsInsertion>.Create(Self, TSchemaProduto(Self.TableSchema).Ativo);
end;

function TProdutoFieldsInsertion.Codigo: IStormStringFieldInsertion<IProdutoFinalFieldsInsertion>;
begin
  Result := TStormStringFieldInsertion<IProdutoFinalFieldsInsertion>.Create(Self, TSchemaProduto(Self.TableSchema).Codigo);
end;

function TProdutoFieldsInsertion.CodigoMarca: IStormIntegerNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
begin
  Result := TStormIntegerFieldInsertion<IProdutoFinalFieldsInsertion>.Create(Self, TSchemaProduto(Self.TableSchema).CodigoMarca);
end;

function TProdutoFieldsInsertion.DataAlteracao: IStormDateTimeNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
begin
  Result := TStormDateTimeFieldInsertion<IProdutoFinalFieldsInsertion>.Create(Self, TSchemaProduto(Self.TableSchema).DataAlteracao);
end;

function TProdutoFieldsInsertion.DataCriacao: IStormDateNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
begin
  Result := TStormDateFieldInsertion<IProdutoFinalFieldsInsertion>.Create(Self, TSchemaProduto(Self.TableSchema).DataCriacao);
end;

function TProdutoFieldsInsertion.Descricao: IStormStringNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
begin
  Result := TStormStringFieldInsertion<IProdutoFinalFieldsInsertion>.Create(Self, TSchemaProduto(Self.TableSchema).Descricao);
end;

function TProdutoFieldsInsertion.FromEntyity(
  Entity: IProduto): IStormInsertExecutor<IProduto>;
begin
  Result := TStormInsertExecutor<IProduto>.Create
  (
    Self
    .Codigo.SetValue(Entity.codigo.GetValueOrDefault())
    .Descricao.SetValue(Entity.Descricao.GetValue())
    .CodigoMarca.SetValue(Entity.CodigoMarca.GetValue())
    .Preco.SetValue(Entity.Preco.GetValue())
    .Ativo.SetValue(Entity.Ativo.GetValue())
    .DataCriacao.SetValue(Entity.DataCriacao.GetValue())
    .DataAlteracao.SetValue(Entity.DataAlteracao.GetValue())
    as TStormSqlPartition
  );
end;

function TProdutoFieldsInsertion.Go: IStormInsertExecutor<IProduto>;
begin
  Result := TStormInsertExecutor<IProduto>.Create(Self);
end;

function TProdutoFieldsInsertion.Preco: IStormFloatNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
begin
  Result := TStormFloatFieldInsertion<IProdutoFinalFieldsInsertion>.Create(Self, TSchemaProduto(Self.TableSchema).Preco);
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

{ TProdutoWhereSelectorDeleteConstructor }

function TProdutoWhereSelectorDeleteConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoWhereSelector<IStormDeleteExecutor>;
begin
  Result :=  TProdutoWhereSelector<IStormDeleteExecutor>.Create(owner);
end;

end.
