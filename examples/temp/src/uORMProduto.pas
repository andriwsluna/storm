unit uORMProduto;

interface

uses
  DFE.Result,
  DFE.Maybe,
  storm.data.interfaces,
  storm.orm.interfaces,
  storm.entity.interfaces,
  uEntityProduto;

type

  TProdutoPossibleFields =
  (
     CodigoProduto = 0
    ,Descricao     = 1
    ,CodigoMarca   = 2
    ,Preco         = 3
    ,Ativo         = 4
    ,DataCriacao   = 5
    ,DataAlteracao = 6
  );

  TProdutoSETFieldSelection = set of TProdutoPossibleFields;

  ISelectByIDResult   = TResult<IProduto, IStormExecutionFail>;
  IUpdateEntityResult = TResult<IProduto, IStormExecutionFail>;
  IInsertEntityResult = TResult<IProduto, IStormExecutionFail>;
  IDeleteEntityResult = TResult<IProduto, IStormExecutionFail>;

  IProdutoWhereSelector<Executor : IInterface> = interface['{C3088765-277C-4B03-8F09-9F1DDDA02B13}']
    function CodigoProduto : IStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Descricao     : IStormStringNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function CodigoMarca   : IStormIntegerNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Preco         : IStormFloatNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Ativo         : IStormBooleanNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function DataCriacao   : IStormDateNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function DataAlteracao : IStormDateTimeNullableWhere<IProdutoWhereSelector<Executor>, Executor>;

    function OpenParenthesis : IProdutoWhereSelector<Executor>;
  end;

  IProdutoOrderBySelected = interface;

  IProdutoOrderBySelection = interface['{74A5E92C-8300-45D9-8329-A6373AA31C7B}']
    function CodigoProduto : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Descricao     : IStormOrderBySelector<IProdutoOrderBySelected>;
    function CodigoMarca   : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Preco         : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Ativo         : IStormOrderBySelector<IProdutoOrderBySelected>;
    function DataCriacao   : IStormOrderBySelector<IProdutoOrderBySelected>;
    function DataAlteracao : IStormOrderBySelector<IProdutoOrderBySelected>;
  end;

  IProdutoOrderBySelected = interface(IProdutoOrderBySelection)['{95C7D617-155C-4F65-A426-3179F966014F}']
    function Open() : TResult<IStormSelectSuccess<IProduto>,IStormExecutionFail>;
  end;

  IProdutoFieldsSelection = interface['{88322807-5451-4632-8D57-0C1ECFA4E701}']
    function CodigoProduto : IProdutoFieldsSelection;
    function Descricao     : IProdutoFieldsSelection;
    function CodigoMarca   : IProdutoFieldsSelection;
    function Preco         : IProdutoFieldsSelection;
    function Ativo         : IProdutoFieldsSelection;
    function DataCriacao   : IProdutoFieldsSelection;
    function DataAlteracao : IProdutoFieldsSelection;
    function AllColumns() : IStormWherePoint<IProdutoWhereSelector<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>>;
    function From : IStormWherePoint<IProdutoWhereSelector<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>>;
  end;

  IProdutoFieldsSelectionWithLimit = interface(IProdutoFieldsSelection)['{26844A55-58B1-4FC2-AF3B-25E9D3EDA4BC}']
    function Limit(Const Count : Integer) : IProdutoFieldsSelection;
  end;

  IProdutoFieldsAssignmentWithWhere = interface;

  IProdutoFieldsAssignmentBase = interface['{B8BD6F8A-5058-474B-BC42-88087DBEC188}']
    function CodigoProduto : IStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Descricao     : IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function CodigoMarca   : IStormIntegerNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Preco         : IStormFloatNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Ativo         : IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function DataCriacao   : IStormDateNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function DataAlteracao : IStormDateTimeNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
  end;

  IProdutoFieldsAssignmentWithWhere = interface(IProdutoFieldsAssignmentBase)['{C1F27958-79E3-45F7-91D7-B8C752EF2F51}']
    function Where : IProdutoWhereSelector<IStormUpdateExecutor>;
  end;

  IProdutoFieldsAssignment = interface(IProdutoFieldsAssignmentBase)['{C3DF9CBA-CC5E-4416-A848-C2817486AA33}']
    function FromEntyity(Entity : IProduto) : IStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>>;
  end;

  IProdutoFieldsInsertionWithGo = interface;

  IProdutoFieldsInsertionBase = interface['{CBA959E2-DAB2-4CE5-BFDA-2C4FD64818C1}']
    function CodigoProduto : IStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Descricao     : IStormStringNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function CodigoMarca   : IStormIntegerNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Preco         : IStormFloatNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Ativo         : IStormBooleanNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function DataCriacao   : IStormDateNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function DataAlteracao : IStormDateTimeNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
  end;

  IProdutoFieldsInsertionWithGo = interface(IProdutoFieldsInsertionBase)['{B2298872-04A0-4CFC-ABD8-E739FB311842}']
    function Go : IStormInsertExecutor<IProduto>;
  end;

  IProdutoFieldsInsertion = interface(IProdutoFieldsInsertionBase)['{37B8DDA9-250C-48EB-B4B8-CE201E4D122B}']
    function FromEntyity(Entity : IProduto) : IStormInsertExecutor<IProduto>;
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
    Function CodigoProduto() : IProdutoFieldsSelection;
    Function Descricao() : IProdutoFieldsSelection;
    Function CodigoMarca() : IProdutoFieldsSelection;
    Function Preco() : IProdutoFieldsSelection;
    Function Ativo() : IProdutoFieldsSelection;
    Function DataCriacao() : IProdutoFieldsSelection;
    Function DataAlteracao() : IProdutoFieldsSelection;
  end;

  TProdutoOrderBySelection = Class(TStormSqlPartition,IProdutoOrderBySelection,IProdutoOrderBySelected)
  public
    Function CodigoProduto : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function Descricao : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function CodigoMarca : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function Preco : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function Ativo : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function DataCriacao : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function DataAlteracao : IStormOrderBySelector<IProdutoOrderBySelected>;
    Function Open() : TResult<IStormSelectSuccess<Iproduto>,IStormExecutionFail>;
  End;

  TProdutoWhereSelector<Executor : IInterface> = class(TStormSqlPartition, IProdutoWhereSelector<Executor>)
    Function CodigoProduto : IStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>;
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
    Function CodigoProduto : IStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Descricao : IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function CodigoMarca : IStormIntegerNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Preco : IStormFloatNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function Ativo : IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function DataCriacao : IStormDateNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function DataAlteracao : IStormDateTimeNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    Function FromEntyity(Entity : IProduto) : IStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>>;
  end;

  TProdutoFieldsInsertion = class(TStormSqlPartition, IProdutoFieldsInsertion, IProdutoFieldsInsertionWithGo)
    Function CodigoProduto : IStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>;
    Function Descricao : IStormStringNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    Function CodigoMarca : IStormIntegerNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    Function Preco : IStormFloatNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    Function Ativo : IStormBooleanNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    Function DataCriacao : IStormDateNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    Function DataAlteracao : IStormDateTimeNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
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
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoFieldsInsertionWithGo>)
  public
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoFieldsInsertionWithGo;
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
    .CodigoProduto.IsEqualsTo(Entity.CodigoProduto.GetValueOrDefault())
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
    TGUID(IProdutoFieldsInsertionWithGo).ToString,
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
    .CodigoProduto.IsEqualsTo(Codigo)
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
    .CodigoProduto.IsEqualsTo(Entity.CodigoProduto.GetValue.GetValueOrDefault(0))
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

function TProdutoFieldsSelection.CodigoProduto: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.CodigoProduto));
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

function TProdutoWhereSelector<Executor>.CodigoProduto: IStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>;
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

function TProdutoFieldsAssignment.CodigoProduto: IStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
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

function TProdutoFieldsInsertion.Ativo: IStormBooleanNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  Result := TStormBooleanFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).Ativo,
    TProdutoORM(Self.ORM).OnInsertedSetValueToAtivo
  );
end;

function TProdutoFieldsInsertion.CodigoProduto: IStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  Result := TStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).CodigoProduto,
    TProdutoORM(Self.ORM).OnInsertedSetValueToCodigo
  );
end;

function TProdutoFieldsInsertion.CodigoMarca: IStormIntegerNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  Result := TStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).CodigoMarca,
    TProdutoORM(self.ORM).OnInsertedSetValueToCodigoMarca
  );
end;

function TProdutoFieldsInsertion.DataAlteracao: IStormDateTimeNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  Result := TStormDateTimeFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).DataAlteracao,
    TProdutoORM(Self.ORM).OnInsertedSetValueToDataAlteracao
  );
end;

function TProdutoFieldsInsertion.DataCriacao: IStormDateNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  Result := TStormDateFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).DataCriacao,
    TProdutoORM(Self.ORM).OnInsertedSetValueToDataCriacao
  );
end;

function TProdutoFieldsInsertion.Descricao: IStormStringNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  Result := TStormStringFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).Descricao,
    TProdutoORM(Self.ORM).OnInsertedSetValueToDescricao
  );
end;

function TProdutoFieldsInsertion.FromEntyity(
  Entity: IProduto): IStormInsertExecutor<IProduto>;
var
  Insertions : IProdutoFieldsInsertionWithGo;
begin
  Insertions := Self;
  Insertions
  .Descricao.SetValue(Entity.Descricao.GetValue())
  .CodigoMarca.SetValue(Entity.CodigoMarca.GetValue())
  .Preco.SetValue(Entity.Preco.GetValue())
  .Ativo.SetValue(Entity.Ativo.GetValue())
  .DataCriacao.SetValue(Entity.DataCriacao.GetValue())
  .DataAlteracao.SetValue(Entity.DataAlteracao.GetValue());


  Insertions := (Insertions.CodigoProduto as TStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>)
  .SetValue(Entity.CodigoProduto.GetValue());


  Result := TStormInsertExecutor<IProduto>.Create
  (
    Insertions as TStormSqlPartition,
    TprodutoORM(self.ORM).InsertedEntity
  );
end;

function TProdutoFieldsInsertion.Go: IStormInsertExecutor<IProduto>;
begin
  Result := TStormInsertExecutor<IProduto>.Create(Self, TprodutoORM(self.ORM).InsertedEntity);
end;

function TProdutoFieldsInsertion.Preco: IStormFloatNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  Result := TStormFloatFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).Preco,
    TProdutoORM(self.ORM).OnInsertedSetValueToPreco
  );
end;

{ TProdutoFinalFieldsInsertionConstructor }

function TProdutoFinalFieldsInsertionConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoFieldsInsertionWithGo;
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

function TProdutoOrderBySelection.CodigoProduto: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  Result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.CodigoProduto),Self);
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
