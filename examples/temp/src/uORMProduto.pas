unit uORMProduto;

interface

uses
  DFE.Result,
  DFE.Maybe,
  storm.model.interfaces,
  Data.DB,
  storm.data.interfaces,
  storm.orm.interfaces,
  storm.entity.interfaces,
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
    Function Codigo : IStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function Descricao : IStormStringNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function CodigoMarca : IStormIntegerNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function Preco : IStormFloatNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function Ativo : IStormBooleanNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function DataCriacao : IStormDateNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function DataAlteracao : IStormDateTimeNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function OpenParenthesis : IProdutoWhereSelector<Executor>;
  end;

  IProdutoOrderBySelected = interface;

  IProdutoOrderBySelection = interface['{9A4F96B3-4161-451D-85A7-EAD1A94561BF}']
    Function Codigo : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function Descricao : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function CodigoMarca : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function Preco : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function Ativo : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function DataCriacao : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function DataAlteracao : IStormOrderBySelector<IProdutoOrderBySelected>;
  end;

  IProdutoOrderBySelected = interface(IProdutoOrderBySelection)['{09A69EC3-FE09-4648-B195-BA8E63F7E2F0}']
    Function Open() : TResult<IStormSelectSuccess<Iproduto>,IStormExecutionFail>;
  end;

  IProdutoFieldsSelection = interface['{20985878-707D-4DCD-B38E-0728934F48BC}']
    Function AllColumns() : IStormWherePoint<IProdutoWhereSelector<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>>;
    Function Codigo() : IProdutoFieldsSelection;
    Function Descricao() : IProdutoFieldsSelection;
    Function CodigoMarca() : IProdutoFieldsSelection;
    Function Preco() : IProdutoFieldsSelection;
    Function Ativo() : IProdutoFieldsSelection;
    Function DataCriacao() : IProdutoFieldsSelection;
    Function DataAlteracao() : IProdutoFieldsSelection;
    Function From : IStormWherePoint<IProdutoWhereSelector<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>>;
  end;

  IProdutoFieldsSelectionWithLimit = interface(IProdutoFieldsSelection)['{20985878-707D-4DCD-B38E-0728934F48BC}']
    Function Limit(Const Count : Integer) : IProdutoFieldsSelection;
  end;

  IProdutoFieldsAssignmentWithWhere=  interface['{990EF674-B643-4063-987E-6C28E5821B90}']
    Function Codigo : IStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Descricao : IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function CodigoMarca : IStormIntegerNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Preco : IStormFloatNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Ativo : IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function DataCriacao : IStormDateNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function DataAlteracao : IStormDateTimeNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Where : IProdutoWhereSelector<IStormUpdateExecutor>;
  end;

  IProdutoFieldsAssignment = interface['{C36AB855-61F1-4BEE-9FE2-F0D134EA5809}']
    Function Codigo : IStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Descricao : IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function CodigoMarca : IStormIntegerNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Ativo : IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Preco : IStormFloatNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function DataCriacao : IStormDateNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function DataAlteracao : IStormDateTimeNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function FromEntyity(Entity : IProduto) : IStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>>;
  end;

  IProdutoFinalFieldsInsertion =  interface['{B8B4616B-7527-4617-A92F-9C0832044F7A}']
    Function Codigo : IStormIntegerNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Descricao : IStormStringNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function CodigoMarca : IStormIntegerNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Preco : IStormFloatNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Ativo : IStormBooleanNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function DataCriacao : IStormDateNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function DataAlteracao : IStormDateTimeNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
    Function Go : IStormInsertExecutor<IProduto>;
  end;

  IProdutoFieldsInsertion = interface
    Function Codigo : IStormIntegerNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
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

    Function SelectByID(Const Codigo : Integer) : ISelectByIDResult;
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

    function ProccessSelectSuccess(Res : IStormSelectSuccess<Iproduto>) : ISelectByIDResult;
    function ProccessSelectFail(Res : IStormExecutionFail) : ISelectByIDResult;

  protected
    InsertedEntity : IProduto;
    procedure Initialize; override;
    Function GetInsertedEntity<IProduto>() : uEntityProduto.IProduto; Reintroduce;

    function OnInsertedSetValueToCodigo(value : Maybe<Integer>) : Boolean;
    function OnInsertedSetValueToDescricao(value : Maybe<String>) : Boolean;
    function OnInsertedSetValueToCodigoMarca(value : Maybe<Integer>) : Boolean;
    function OnInsertedSetValueToPreco(value : Maybe<Extended>) : Boolean;
    function OnInsertedSetValueToAtivo(value : Maybe<Boolean>) : Boolean;
    function OnInsertedSetValueToDataCriacao(value : Maybe<TDate>) : Boolean;
    function OnInsertedSetValueToDataAlteracao(value : Maybe<TDateTime>) : Boolean;


  public
    Constructor Create(DbSQLConnecton : IStormSQLConnection);
  public
    Function Select() : IProdutoFieldsSelectionWithLimit;
    Function Update() : IProdutoFieldsAssignment;
    Function Insert() : IProdutoFieldsInsertion;
    Function Delete() : IStormWherePoint<IProdutoWhereSelector<IStormDeleteExecutor>>;

    Function SelectByID(Const Codigo : Integer) : ISelectByIDResult;
    Function UpdateEntity(Entity : IProduto) : IUpdateEntityResult;
    Function InsertEntity(Entity : IProduto) : IInsertEntityResult;
    Function DeleteEntity(Entity : IProduto) : IDeleteEntityResult;
  End;


  TProdutoFieldsSelection = Class
  (
    TStormFieldsSelection<IProdutoWhereSelector<IStormSelectExecutor<IProduto, IProdutoOrderBySelection>>, IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>,
    IProdutoFieldsSelection,
    IProdutoFieldsSelectionWithLimit
  )
    Function Limit(Const Count : Integer) : IProdutoFieldsSelection;
    Function Codigo() : IProdutoFieldsSelection;
    Function Descricao() : IProdutoFieldsSelection;
    Function CodigoMarca() : IProdutoFieldsSelection;
    Function Preco() : IProdutoFieldsSelection;
    Function Ativo() : IProdutoFieldsSelection;
    Function DataCriacao() : IProdutoFieldsSelection;
    Function DataAlteracao() : IProdutoFieldsSelection;
  end;

  TProdutoOrderBySelection = Class(TStormSqlPartition,IProdutoOrderBySelection,IProdutoOrderBySelected)
  public
    Function Codigo : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function Descricao : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function CodigoMarca : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function Preco : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function Ativo : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function DataCriacao : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function DataAlteracao : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function Open() : TResult<IStormSelectSuccess<Iproduto>,IStormExecutionFail>;
  End;

  TProdutoWhereSelector<Executor : IInterface> = class(TStormSqlPartition, IProdutoWhereSelector<Executor>)
    Function Codigo : IStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>;
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
    Function Codigo : IStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Descricao : IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function CodigoMarca : IStormIntegerNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Preco : IStormFloatNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Ativo : IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function DataCriacao : IStormDateNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function DataAlteracao : IStormDateTimeNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function FromEntyity(Entity : IProduto) : IStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>>;
  end;

  TProdutoFieldsInsertion = class(TStormSqlPartition, IProdutoFieldsInsertion, IProdutoFinalFieldsInsertion)
    Function Codigo : IStormIntegerNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
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
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoWhereSelector<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>>)
  public
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoWhereSelector<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>;
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
  = Class(TInterfacedObject, IStormGenericReturn<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>)
  public
    Function GetGenericInstance(Owner : TStormSQLPartition) : IStormSelectExecutor<IProduto,IProdutoOrderBySelection>;
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

  TProdutoOrderBySelectionConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoOrderBySelection>)
  public
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoOrderBySelection;
  End;

  TIProdutoOrderBySelectedConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoOrderBySelected>)
  public
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoOrderBySelected;
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
    .Codigo.IsEqualsTo(Entity.CodigoProduto.GetValueOrDefault())
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


function TProdutoORM.GetInsertedEntity<IProduto>: uEntityProduto.IProduto;
begin
  Result := self.InsertedEntity;
end;

procedure TProdutoORM.Initialize;
begin
  inherited;
  FClassConstructor.Add
  (
    TGUID(IProdutoWhereSelector<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>).ToString +
    TGUID(IStormSelectExecutor<IProduto,IProdutoOrderBySelection>).ToString,
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
    TGUID(IStormSelectExecutor<IProduto,IProdutoOrderBySelection>).ToString,
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

  FClassConstructor.Add
  (
    TGUID(IProdutoOrderBySelection).ToString,
    TProdutoOrderBySelectionConstructor.Create
  );

  FClassConstructor.Add
  (
    TGUID(IProdutoOrderBySelected).ToString,
    TIProdutoOrderBySelectedConstructor.Create
  );


end;


function TProdutoORM.Insert: IProdutoFieldsInsertion;
begin
  InsertedEntity := newProduto();
  Result := TProdutoFieldsInsertion.Create(self);
end;

function TProdutoORM.InsertEntity(Entity: IProduto): IInsertEntityResult;
begin
  if VerifyPrimaryKeyFields(Entity,True) then
  begin
    Result := Insert()
    .FromEntyity(Entity)
    .Execute
    .BindTo<IInsertEntityResult>
    (
      function(res : IStormInsertSuccess<Iproduto>) : IInsertEntityResult
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

function TProdutoORM.OnInsertedSetValueToAtivo(value: Maybe<Boolean>): Boolean;
begin
  Result := InsertedEntity.Ativo.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToCodigo(value: Maybe<Integer>): Boolean;
begin
  Result := InsertedEntity.CodigoProduto.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToCodigoMarca(
  value: Maybe<Integer>): Boolean;
begin
  Result := InsertedEntity.CodigoMarca.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToDataAlteracao(
  value: Maybe<TDateTime>): Boolean;
begin
  Result := InsertedEntity.DataAlteracao.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToDataCriacao(
  value: Maybe<TDate>): Boolean;
begin
  Result := InsertedEntity.DataCriacao.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToDescricao(value: Maybe<String>): Boolean;
begin
  Result := InsertedEntity.Descricao.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToPreco(value: Maybe<Extended>): Boolean;
begin
  Result := InsertedEntity.Preco.Value.SetValue(value);
end;

function TProdutoORM.ProccessSelectFail(
  Res: IStormExecutionFail): ISelectByIDResult;
begin
  Result := res;
end;

function TProdutoORM.ProccessSelectSuccess(
  Res: IStormSelectSuccess<Iproduto>): ISelectByIDResult;
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
  const Codigo: Integer): TResult<IProduto, IStormExecutionFail>;
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
    .Codigo.IsEqualsTo(Entity.CodigoProduto.GetValue.GetValueOrDefault(0))
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
  AddLimit(Count);
  Result := Self;
end;



function TProdutoFieldsSelection.Preco: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.Preco));
  Result := Self;
end;

{ TProdutoWhereSelectorSelectConstructor }

function TProdutoWhereSelectorSelectConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoWhereSelector<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>;
begin
  Result := TProdutoWhereSelector<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>.Create(Owner);
end;

{ TProdutoWhereSelector<Executor> }

function TProdutoWhereSelector<Executor>.Ativo: IStormBooleanNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  Result := TStormBooleanWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Ativo);
end;

function TProdutoWhereSelector<Executor>.Codigo: IStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.CodigoProduto);
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
  Owner: TStormSQLPartition): IStormSelectExecutor<IProduto,IProdutoOrderBySelection>;
begin
  Result := TStormSelectExecutor<IProduto,IProdutoOrderBySelection>.Create(Owner);
end;

{ TProdutoFieldsAssignment }

function TProdutoFieldsAssignment.Ativo: IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  Result := TStormBooleanFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Ativo);
end;

function TProdutoFieldsAssignment.Codigo: IStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  Result := TStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.CodigoProduto);
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
  if SQL.IsEmpty then
  begin
    AddUpdate();
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
  Result := TStormBooleanFieldInsertion<IProdutoFinalFieldsInsertion>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).Ativo,
    TProdutoORM(Self.ORM).OnInsertedSetValueToAtivo
  );
end;

function TProdutoFieldsInsertion.Codigo: IStormIntegerNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
begin
  Result := TStormIntegerFieldInsertion<IProdutoFinalFieldsInsertion>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).CodigoProduto,
    TProdutoORM(Self.ORM).OnInsertedSetValueToCodigo
  );
end;

function TProdutoFieldsInsertion.CodigoMarca: IStormIntegerNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
begin
  Result := TStormIntegerFieldInsertion<IProdutoFinalFieldsInsertion>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).CodigoMarca,
    TProdutoORM(self.ORM).OnInsertedSetValueToCodigoMarca
  );
end;

function TProdutoFieldsInsertion.DataAlteracao: IStormDateTimeNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
begin
  Result := TStormDateTimeFieldInsertion<IProdutoFinalFieldsInsertion>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).DataAlteracao,
    TProdutoORM(Self.ORM).OnInsertedSetValueToDataAlteracao
  );
end;

function TProdutoFieldsInsertion.DataCriacao: IStormDateNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
begin
  Result := TStormDateFieldInsertion<IProdutoFinalFieldsInsertion>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).DataCriacao,
    TProdutoORM(Self.ORM).OnInsertedSetValueToDataCriacao
  );
end;

function TProdutoFieldsInsertion.Descricao: IStormStringNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
begin
  Result := TStormStringFieldInsertion<IProdutoFinalFieldsInsertion>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).Descricao,
    TProdutoORM(Self.ORM).OnInsertedSetValueToDescricao
  );
end;

function TProdutoFieldsInsertion.FromEntyity(
  Entity: IProduto): IStormInsertExecutor<IProduto>;
begin
  Result := TStormInsertExecutor<IProduto>.Create
  (
    Self
    .Codigo.SetValue(Entity.CodigoProduto.GetValue())
    .Descricao.SetValue(Entity.Descricao.GetValue())
    .CodigoMarca.SetValue(Entity.CodigoMarca.GetValue())
    .Preco.SetValue(Entity.Preco.GetValue())
    .Ativo.SetValue(Entity.Ativo.GetValue())
    .DataCriacao.SetValue(Entity.DataCriacao.GetValue())
    .DataAlteracao.SetValue(Entity.DataAlteracao.GetValue())
    as TStormSqlPartition,
    TprodutoORM(self.ORM).InsertedEntity
  );
end;

function TProdutoFieldsInsertion.Go: IStormInsertExecutor<IProduto>;
begin
  Result := TStormInsertExecutor<IProduto>.Create(Self, TprodutoORM(self.ORM).InsertedEntity);
end;

function TProdutoFieldsInsertion.Preco: IStormFloatNullableFieldInsertion<IProdutoFinalFieldsInsertion>;
begin
  Result := TStormFloatFieldInsertion<IProdutoFinalFieldsInsertion>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).Preco,
    TProdutoORM(self.ORM).OnInsertedSetValueToPreco
  );
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

{ TProdutoOrderBySelection }

function TProdutoOrderBySelection.Ativo: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  Result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.Ativo),Self);
end;

function TProdutoOrderBySelection.Codigo: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  Result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.Codigo),Self);
end;

function TProdutoOrderBySelection.CodigoMarca: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  Result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.CodigoMarca),Self);
end;

function TProdutoOrderBySelection.DataAlteracao: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  Result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.DataAlteracao),Self);
end;

function TProdutoOrderBySelection.DataCriacao: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  Result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.DataCriacao),Self);
end;

function TProdutoOrderBySelection.Descricao: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  Result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.Descricao),Self);
end;

function TProdutoOrderBySelection.Open: TResult<IStormSelectSuccess<Iproduto>, IStormExecutionFail>;
begin
  RemoveLastSqlCharacter();
  Result := TStormSelectExecutor<Iproduto,IProdutoOrderBySelection>.Create(Self).Open();
end;

function TProdutoOrderBySelection.Preco: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  Result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.Preco),Self);
end;

{ TProdutoOrderBySelectionConstructor }

function TProdutoOrderBySelectionConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoOrderBySelection;
begin
  Result := TProdutoOrderBySelection.Create(Owner);
end;

{ TIProdutoOrderBySelectedConstructor }

function TIProdutoOrderBySelectedConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoOrderBySelected;
begin
  Result := TProdutoOrderBySelection.Create(Owner);
end;

end.
