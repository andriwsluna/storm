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
     Codigo_produto = 0
    ,Descricao     = 1
    ,Codigo_marca  = 2
    ,Preco         = 3
    ,Ativo         = 4
    ,Data_criacao  = 5
    ,Data_alteracao = 6
  );
  
  
  ISelectByIDResult   = TResult<IProduto, IStormExecutionFail>;
  IUpdateEntityResult = TResult<IProduto, IStormExecutionFail>;
  IInsertEntityResult = TResult<IProduto, IStormExecutionFail>;
  IDeleteEntityResult = TResult<IProduto, IStormExecutionFail>;



  IProdutoWhereSelector<Executor : IInterface>
  = interface['{4156D147-A7A0-4804-8610-7E8F51B61C38}']
    function Codigo_produto : IStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Descricao     : IStormStringNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Codigo_marca  : IStormIntegerNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Preco         : IStormFloatNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Ativo         : IStormBooleanNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Data_criacao  : IStormDateNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Data_alteracao : IStormDateTimeNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    
    function OpenParenthesis : IProdutoWhereSelector<Executor>;
    function IFTHEN(Condition : Boolean) : IProdutoWhereSelector<Executor>;
    Function ENDIF() : IProdutoWhereSelector<Executor>;

  end;


  
  IProdutoOrderBySelected = interface;
  
  IProdutoOrderBySelection = interface['{49066D19-BD13-43F5-8B2C-307EC444CC16}']
    function Codigo_produto : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Descricao     : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Codigo_marca  : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Preco         : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Ativo         : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Data_criacao  : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Data_alteracao : IStormOrderBySelector<IProdutoOrderBySelected>;
  end;
  
  IProdutoOrderBySelected = interface(IProdutoOrderBySelection)['{7623D77D-220F-41EE-8874-5B5056BEF027}']
    function Open() : TResult<IStormSelectSuccess<IProduto>,IStormExecutionFail>;
  end;
  
  IProdutoFieldsSelection = interface['{B58166BB-4835-4F4C-9DB5-F8C10CFE6D25}']
    function Codigo_produto : IProdutoFieldsSelection;
    function Descricao     : IProdutoFieldsSelection;
    function Codigo_marca  : IProdutoFieldsSelection;
    function Preco         : IProdutoFieldsSelection;
    function Ativo         : IProdutoFieldsSelection;
    function Data_criacao  : IProdutoFieldsSelection;
    function Data_alteracao : IProdutoFieldsSelection;
    function AllColumns() : IStormWherePoint<IProdutoWhereSelector<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>>;
    function From : IStormWherePoint<IProdutoWhereSelector<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>>;
  end;
  
  IProdutoFieldsSelectionWithLimit = interface(IProdutoFieldsSelection)['{0CC37D5A-586F-4BD0-808E-D4979DAB6876}']
    function Limit(Const Count : Integer) : IProdutoFieldsSelection;
  end;
  
  IProdutoFieldsAssignmentWithWhere = interface;
  
  IProdutoFieldsAssignmentBase = interface['{AB76C723-8E31-481A-A918-5827D4574381}']
    function Codigo_produto : IStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Descricao     : IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Codigo_marca  : IStormIntegerNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Preco         : IStormFloatNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Ativo         : IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Data_criacao  : IStormDateNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Data_alteracao : IStormDateTimeNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
  end;
  
  IProdutoFieldsAssignmentWithWhere = interface(IProdutoFieldsAssignmentBase)['{BE718FF8-E0DC-4245-8F23-080EED071C97}']
    function Where : IProdutoWhereSelector<IStormUpdateExecutor>;
  end;
  
  IProdutoFieldsAssignment = interface(IProdutoFieldsAssignmentBase)['{602CAB4E-2382-4117-866A-74ED96835B81}']
    function FromEntyity(Entity : IProduto) : IStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>>;
  end;
  
  IProdutoFieldsInsertionWithGo = interface;
  
  IProdutoFieldsInsertionBase = interface['{2C4EA769-8286-4D8E-BD2D-9369F27A2491}']
    function Codigo_produto : IStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Descricao     : IStormStringNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Codigo_marca  : IStormIntegerNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Preco         : IStormFloatNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Ativo         : IStormBooleanNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Data_criacao  : IStormDateNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Data_alteracao : IStormDateTimeNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
  end;
  
  IProdutoFieldsInsertionWithGo = interface(IProdutoFieldsInsertionBase)['{04167F3E-ADA2-4AB0-8F93-3970CE41EBC0}']
    function Go : IStormInsertExecutor<IProduto>;
  end;
  
  IProdutoFieldsInsertion = interface(IProdutoFieldsInsertionBase)['{AB2AEFC1-5C5C-4A81-A17C-E7A79845F370}']
    function FromEntyity(Entity : IProduto) : IStormInsertExecutor<IProduto>;
  end;
  
  IProdutoORM = interface(IStormORM)['{1A006342-C7C3-4AD7-9223-7BA0A4555C97}']
    function Select() : IProdutoFieldsSelectionWithLimit;
    function Update() : IProdutoFieldsAssignment;
    function Insert() : IProdutoFieldsInsertion;
    function Delete() : IStormWherePoint<IProdutoWhereSelector<IStormDeleteExecutor>>;
    
    function SelectByID
    (
      Const Codigo_produto : Integer
    ): ISelectByIDResult;
    function UpdateEntity(Entity : IProduto) : IUpdateEntityResult;
    function InsertEntity(Entity : IProduto) : IInsertEntityResult;
    function DeleteEntity(Entity : IProduto) : IDeleteEntityResult;
  end;
  
  function Produto_ORM(DbSQLConnecton: IStormSQLConnection): IProdutoORM;  overload;
  function Produto_ORM() : IProdutoORM; overload;
  
implementation

uses
  storm.schema.interfaces,
  storm.dependency.register,
  storm.orm.update,
  uSchemaProduto,
  System.Sysutils,
  storm.orm.where,
  storm.orm.insert,
  storm.orm.base;
  
type
  TProdutoORM = Class(TStormORM, IProdutoORM)
  private
    function SchemaProduto : TSchemaProduto;
    
    function ProccessSelectSuccess(Res : IStormSelectSuccess<IProduto>) : ISelectByIDResult;
    function ProccessSelectFail(Res : IStormExecutionFail) : ISelectByIDResult;
  protected
    InsertedEntity : IProduto;
    
    procedure Initialize; override;
    Function GetInsertedEntity<IProduto>() : uEntityProduto.IProduto; Reintroduce;
    
    function OnInsertedSetValueToCodigo_produto(value : Maybe<Integer>) : Boolean;
    function OnInsertedSetValueToDescricao(value : Maybe<String>) : Boolean;
    function OnInsertedSetValueToCodigo_marca(value : Maybe<Integer>) : Boolean;
    function OnInsertedSetValueToPreco(value : Maybe<Extended>) : Boolean;
    function OnInsertedSetValueToAtivo(value : Maybe<Boolean>) : Boolean;
    function OnInsertedSetValueToData_criacao(value : Maybe<TDate>) : Boolean;
    function OnInsertedSetValueToData_alteracao(value : Maybe<TDateTime>) : Boolean;
  public
    constructor Create(DbSQLConnecton : IStormSQLConnection);
    
    function Select() : IProdutoFieldsSelectionWithLimit;
    function Update() : IProdutoFieldsAssignment;
    function Insert() : IProdutoFieldsInsertion;
    function Delete() : IStormWherePoint<IProdutoWhereSelector<IStormDeleteExecutor>>;
    
    function SelectByID
    (
      Const Codigo_produto : Integer
    ): ISelectByIDResult;
    function UpdateEntity(Entity : IProduto) : IUpdateEntityResult;
    function InsertEntity(Entity : IProduto) : IInsertEntityResult;
    function DeleteEntity(Entity : IProduto) : IDeleteEntityResult;
  end;
  
  TProdutoFieldsSelection = Class
  (
    TStormFieldsSelection<IProdutoWhereSelector<IStormSelectExecutor<IProduto, IProdutoOrderBySelection>>, IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>,
    IProdutoFieldsSelection,
    IProdutoFieldsSelectionWithLimit
  )
    function Limit(Const Count : Integer) : IProdutoFieldsSelection;
    function Codigo_produto : IProdutoFieldsSelection;
    function Descricao     : IProdutoFieldsSelection;
    function Codigo_marca  : IProdutoFieldsSelection;
    function Preco         : IProdutoFieldsSelection;
    function Ativo         : IProdutoFieldsSelection;
    function Data_criacao  : IProdutoFieldsSelection;
    function Data_alteracao : IProdutoFieldsSelection;
  end;
  
  TProdutoOrderBySelection = Class(TStormSqlPartition,IProdutoOrderBySelection,IProdutoOrderBySelected)
  public
    function Codigo_produto : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Descricao     : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Codigo_marca  : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Preco         : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Ativo         : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Data_criacao  : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Data_alteracao : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Open() : TResult<IStormSelectSuccess<IProduto>,IStormExecutionFail>;
  end;
  

  TProdutoWhereSelector<Executor : IInterface>
  = class
  (
    TStormSQLPartition,
    IProdutoWhereSelector<Executor>,
    IStormConditionner
  )
  protected
    Conditionner : IStormConditionner;
    Conditioned : Boolean;
    Condition : Boolean;
  public
    Constructor Create(Const Owner : TStormSQLPartition); Reintroduce;

    function Codigo_produto : IStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Descricao     : IStormStringNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Codigo_marca  : IStormIntegerNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Preco         : IStormFloatNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Ativo         : IStormBooleanNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Data_criacao  : IStormDateNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Data_alteracao : IStormDateTimeNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function OpenParenthesis : IProdutoWhereSelector<Executor>;
    function IFTHEN(Condition : Boolean) : IProdutoWhereSelector<Executor>;
    Function ENDIF() : IProdutoWhereSelector<Executor>;
    Function GetCondition : Boolean;
    Function GetConditioned : Boolean;
    Procedure SetConditioned(Value : Boolean);
  end;
  
  TProdutoFieldsAssignment = Class
  (
    TStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>,
    IStormUpdateExecutor>,
    IProdutoFieldsAssignment,
    IProdutoFieldsAssignmentWithWhere
  )
  protected
    procedure Initialize; Override;
  public
    function Codigo_produto : IStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Descricao     : IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Codigo_marca  : IStormIntegerNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Preco         : IStormFloatNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Ativo         : IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Data_criacao  : IStormDateNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Data_alteracao : IStormDateTimeNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function FromEntyity(Entity : IProduto) : IStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>>;
  end;
  
  TProdutoFieldsInsertion = class
  (
    TStormSqlPartition,
    IProdutoFieldsInsertion,
    IProdutoFieldsInsertionWithGo
  )
  Public
    function Codigo_produto : IStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Descricao     : IStormStringNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Codigo_marca  : IStormIntegerNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Preco         : IStormFloatNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Ativo         : IStormBooleanNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Data_criacao  : IStormDateNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Data_alteracao : IStormDateTimeNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Go : IStormInsertExecutor<IProduto>;
    function FromEntyity(Entity : IProduto) : IStormInsertExecutor<IProduto>;
  end;
  
  TProdutoWhereSelectorSelectConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoWhereSelector<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>>)
  public
    function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoWhereSelector<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>;
  end;
  
  TProdutoWhereSelectorUpdateConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoWhereSelector<IStormUpdateExecutor>>)
  public
    function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoWhereSelector<IStormUpdateExecutor>;
  end;
  
  TProdutoWhereSelectorDeleteConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoWhereSelector<IStormDeleteExecutor>>)
  public
    function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoWhereSelector<IStormDeleteExecutor>;
  end;
  
  TSelectExecutorConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IStormSelectExecutor<IProduto, IProdutoOrderBySelection>>)
  public
    function GetGenericInstance(Owner : TStormSQLPartition) : IStormSelectExecutor<IProduto, IProdutoOrderBySelection>;
  end;
  
  TProdutoFieldsAssignmentWithWhereConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoFieldsAssignmentWithWhere>)
  public
    function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoFieldsAssignmentWithWhere;
  end;
  
  TProdutoFieldsInsertionWithGoConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoFieldsInsertionWithGo>)
  public
    function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoFieldsInsertionWithGo;
  end;
  
  TProdutoEntityConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProduto>)
  public
    function GetGenericInstance(Owner : TStormSQLPartition) : IProduto;
  end;
  
  TProdutoOrderBySelectionConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoOrderBySelection>)
  public
    function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoOrderBySelection;
  end;
  
  TProdutoOrderBySelectedConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IProdutoOrderBySelected>)
  public
    function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoOrderBySelected;
  end;
  
function Produto_ORM(DbSQLConnecton: IStormSQLConnection) : IProdutoORM;
begin
  result := TProdutoORM.Create(DbSQLConnecton);
end;

function Produto_ORM() : IProdutoORM;
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

constructor TProdutoORM.Create(DbSQLConnecton: IStormSQLConnection);
begin
  inherited create(DbSQLConnecton, TSchemaProduto.Create);
end;

function TProdutoORM.Delete: IStormWherePoint<IProdutoWhereSelector<IStormDeleteExecutor>>;
begin
  Result := TStormWherePoint<IProdutoWhereSelector<IStormDeleteExecutor>,IStormDeleteExecutor>.Create(self);
end;

function TProdutoORM.GetInsertedEntity<IProduto>: uEntityProduto.IProduto;
begin
  result := self.InsertedEntity;
end;

function TProdutoORM.Insert: IProdutoFieldsInsertion;
begin
  InsertedEntity := newProduto();
  result := TProdutoFieldsInsertion.Create(self);
end;

function TProdutoORM.ProccessSelectFail(
Res: IStormExecutionFail): ISelectByIDResult;
begin
  result := res;
end;

function TProdutoORM.Select: IProdutoFieldsSelectionWithLimit;
begin
  result := TProdutoFieldsSelection.Create(self);
end;

function TProdutoORM.SchemaProduto: TSchemaProduto;
begin
  result := self.TableSchema as TSchemaProduto;
end;

function TProdutoORM.Update: IProdutoFieldsAssignment;
begin
  result := TProdutoFieldsAssignment.Create(self);
end;

function TProdutoORM.DeleteEntity(Entity: IProduto): IDeleteEntityResult;
begin
  if VerifyPrimaryKeyFields(Entity) then
  begin
    Result := Delete()
    .Where
    .Codigo_produto.IsEqualsTo(Entity.Codigo_produto.GetValueOrDefault())
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
        result := res;
      end
    );
  end
  else
  begin
    result := TStormExecutionFail.Create(TStormSqlPartition.Create(Self),'All Primary key fields must be assigned.');
  end;
end;

procedure TProdutoORM.Initialize();
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
    TProdutoFieldsInsertionWithGoConstructor.Create
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
    TProdutoOrderBySelectedConstructor.Create
  );
end;

function TProdutoORM.InsertEntity(Entity: IProduto): IInsertEntityResult;
begin
  if VerifyPrimaryKeyFields(Entity,True) then
  begin
    result := Insert()
    .FromEntyity(Entity)
    .Execute
    .BindTo<IInsertEntityResult>
    (
    function(res : IStormInsertSuccess<IProduto>) : IInsertEntityResult
    begin
      result := res.GetInserted;
    end,
    function(res : IStormExecutionFail) : IInsertEntityResult
    begin
      result := res;
    end
    );
  end
  else
  begin
    result := TStormExecutionFail.Create(TStormSqlPartition.Create(Self),'All Primary key fields must be assigned.');
  end;
end;

function TProdutoORM.OnInsertedSetValueToCodigo_produto(value: Maybe<Integer>): Boolean;
begin
  result := InsertedEntity.Codigo_produto.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToDescricao(value: Maybe<String>): Boolean;
begin
  result := InsertedEntity.Descricao.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToCodigo_marca(value: Maybe<Integer>): Boolean;
begin
  result := InsertedEntity.Codigo_marca.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToPreco(value: Maybe<Extended>): Boolean;
begin
  result := InsertedEntity.Preco.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToAtivo(value: Maybe<Boolean>): Boolean;
begin
  result := InsertedEntity.Ativo.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToData_criacao(value: Maybe<TDate>): Boolean;
begin
  result := InsertedEntity.Data_criacao.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToData_alteracao(value: Maybe<TDateTime>): Boolean;
begin
  result := InsertedEntity.Data_alteracao.Value.SetValue(value);
end;


function TProdutoORM.ProccessSelectSuccess(
Res: IStormSelectSuccess<IProduto>): ISelectByIDResult;
begin
  if not res.IsEmpty then
  begin
    result := res.GetModel.Records[0]
  end
  else
  begin
    result := TStormExecutionFail.Create
    (
      TStormSelectSuccess<IProduto>(res) , 'Record not found'
    );
  end;
end;

function TProdutoORM.SelectByID
(
  Const Codigo_produto : Integer
): ISelectByIDResult;
begin
  result :=
  Self
  .Select
  .AllColumns
  .Where
  .Codigo_produto.IsEqualsTo(Codigo_produto)
  .Go
  .Open
  .BindTo<ISelectByIDResult>
  (ProccessSelectSuccess,ProccessSelectFail);
  
end;

function TProdutoORM.UpdateEntity(Entity: IProduto): IUpdateEntityResult;
begin
  if VerifyPrimaryKeyFields(Entity) then
  begin
    result := Update()
    .FromEntyity(Entity)
    .Where
    .Codigo_produto.IsEqualsTo(Entity.Codigo_produto.GetValueOrDefault())
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
          result := TStormExecutionFail.Create(TStormSqlPartition(res),'Record not found');
        end;
      end,
      function(res : IStormExecutionFail) : IUpdateEntityResult
      begin
        result := res;
      end
    );
  end
  else
  begin
    Result := TStormExecutionFail.Create(TStormSqlPartition.Create(Self),'All Primary key fields must be assigned.');
  end;
end;


{ TProdutoFieldsSelection }

function TProdutoFieldsSelection.Codigo_produto: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.Codigo_produto));
  result := Self;
end;

function TProdutoFieldsSelection.Descricao: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.Descricao));
  result := Self;
end;

function TProdutoFieldsSelection.Codigo_marca: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.Codigo_marca));
  result := Self;
end;

function TProdutoFieldsSelection.Preco: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.Preco));
  result := Self;
end;

function TProdutoFieldsSelection.Ativo: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.Ativo));
  result := Self;
end;

function TProdutoFieldsSelection.Data_criacao: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.Data_criacao));
  result := Self;
end;

function TProdutoFieldsSelection.Data_alteracao: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.Data_alteracao));
  result := Self;
end;


function TProdutoFieldsSelection.Limit(
Const Count: Integer): IProdutoFieldsSelection;
begin
  AddLimit(Count);
  result := Self;
end;

{ TProdutoWhereSelector<Executor> }
function TProdutoWhereSelector<Executor>.Codigo_produto: IStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Codigo_produto);
end;

constructor TProdutoWhereSelector<Executor>.Create(
  const Owner: TStormSQLPartition);
begin
  inherited;
  if Supports(Owner, IStormConditionner) then
  begin
    Conditionner := Owner as IStormConditionner;
  end
  else
  if Supports(Owner.GetOwner, IStormConditionner) then
  begin
    Conditionner := Owner.GetOwner as IStormConditionner;
  end
end;

function TProdutoWhereSelector<Executor>.Descricao: IStormStringNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormStringWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Descricao);
end;

function TProdutoWhereSelector<Executor>.ENDIF: IProdutoWhereSelector<Executor>;
begin
  SetConditioned(False);
  Result := self;
end;

function TProdutoWhereSelector<Executor>.GetCondition: Boolean;
begin
  Result :=((Not assigned(Conditionner))or (Not Conditionner.GetConditioned) or Conditionner.GetCondition) AND ((Not Conditioned) or Condition);
end;

function TProdutoWhereSelector<Executor>.GetConditioned: Boolean;
begin
  Result := ((Not assigned(Conditionner))or (Conditionner.GetConditioned)) or self.Conditioned;
end;

function TProdutoWhereSelector<Executor>.IFTHEN(
  Condition: Boolean): IProdutoWhereSelector<Executor>;
begin
  SetConditioned(True);
  Self.Condition := Condition;
  Result := self;
end;

function TProdutoWhereSelector<Executor>.Codigo_marca: IStormIntegerNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Codigo_marca);
end;

function TProdutoWhereSelector<Executor>.Preco: IStormFloatNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormFloatWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Preco);
end;

procedure TProdutoWhereSelector<Executor>.SetConditioned(Value: Boolean);
begin
  if (Not Value) then
  begin
    if self.Conditioned then
    begin
      self.Conditioned := False
    end
    else
    if Assigned(Conditionner) then
    begin
      Conditionner.SetConditioned(Value);
    end;
  end
  else
  begin
    if Not self.Conditioned then
    begin
      self.Conditioned := True
    end
    else
    if Assigned(Conditionner) then
    begin
      Conditionner.SetConditioned(Value);
    end;
  end;
end;

function TProdutoWhereSelector<Executor>.Ativo: IStormBooleanNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormBooleanWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Ativo);
end;

function TProdutoWhereSelector<Executor>.Data_criacao: IStormDateNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormDateWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Data_criacao);
end;

function TProdutoWhereSelector<Executor>.Data_alteracao: IStormDateTimeNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormDateTimeWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Data_alteracao);
end;

function TProdutoWhereSelector<Executor>.OpenParenthesis: IProdutoWhereSelector<Executor>;
begin
  AddOpenParenthesis;
  result := Self;
end;

{ TProdutoFieldsAssignment }

function TProdutoFieldsAssignment.Codigo_produto: IStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  result := TStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Codigo_produto);
end;

function TProdutoFieldsAssignment.Descricao: IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  result := TStormStringFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Descricao);
end;

function TProdutoFieldsAssignment.Codigo_marca: IStormIntegerNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  result := TStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Codigo_marca);
end;

function TProdutoFieldsAssignment.Preco: IStormFloatNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  result := TStormFloatFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Preco);
end;

function TProdutoFieldsAssignment.Ativo: IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  result := TStormBooleanFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Ativo);
end;

function TProdutoFieldsAssignment.Data_criacao: IStormDateNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  result := TStormDateFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Data_criacao);
end;

function TProdutoFieldsAssignment.Data_alteracao: IStormDateTimeNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  result := TStormDateTimeFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Data_alteracao);
end;

function TProdutoFieldsAssignment.FromEntyity(
Entity: IProduto): IStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>>;
VAR
  FieldAssignment : IProdutoFieldsAssignmentWithWhere;
begin
  FieldAssignment := self;
  FieldAssignment := FieldAssignment.Descricao.SetThisOrNull(Entity.Descricao.GetValue());
  FieldAssignment := FieldAssignment.Codigo_marca.SetThisOrNull(Entity.Codigo_marca.GetValue());
  FieldAssignment := FieldAssignment.Preco.SetThisOrNull(Entity.Preco.GetValue());
  FieldAssignment := FieldAssignment.Ativo.SetThisOrNull(Entity.Ativo.GetValue());
  FieldAssignment := FieldAssignment.Data_criacao.SetThisOrNull(Entity.Data_criacao.GetValue());
  FieldAssignment := FieldAssignment.Data_alteracao.SetThisOrNull(Entity.Data_alteracao.GetValue());
  result := TStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>,IStormUpdateExecutor>.Create
  (
    FieldAssignment as TStormSqlPartition
  );
end;

procedure TProdutoFieldsAssignment.initialize;
begin
  inherited;
  if Protected_SQL.IsEmpty then
  begin
    AddUpdate();
  end;
end;

{ TProdutoFieldsInsertion }

function TProdutoFieldsInsertion.Codigo_produto: IStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  result := TStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).Codigo_produto,
    TProdutoORM(self.ORM).OnInsertedSetValueToCodigo_produto
  );
end;

function TProdutoFieldsInsertion.Descricao: IStormStringNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  result := TStormStringFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).Descricao,
    TProdutoORM(self.ORM).OnInsertedSetValueToDescricao
  );
end;

function TProdutoFieldsInsertion.Codigo_marca: IStormIntegerNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  result := TStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).Codigo_marca,
    TProdutoORM(self.ORM).OnInsertedSetValueToCodigo_marca
  );
end;

function TProdutoFieldsInsertion.Preco: IStormFloatNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  result := TStormFloatFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).Preco,
    TProdutoORM(self.ORM).OnInsertedSetValueToPreco
  );
end;

function TProdutoFieldsInsertion.Ativo: IStormBooleanNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  result := TStormBooleanFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).Ativo,
    TProdutoORM(self.ORM).OnInsertedSetValueToAtivo
  );
end;

function TProdutoFieldsInsertion.Data_criacao: IStormDateNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  result := TStormDateFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).Data_criacao,
    TProdutoORM(self.ORM).OnInsertedSetValueToData_criacao
  );
end;

function TProdutoFieldsInsertion.Data_alteracao: IStormDateTimeNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  result := TStormDateTimeFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).Data_alteracao,
    TProdutoORM(self.ORM).OnInsertedSetValueToData_alteracao
  );
end;

function TProdutoFieldsInsertion.Go: IStormInsertExecutor<IProduto>;
begin
  result := TStormInsertExecutor<IProduto>.Create(Self, TProdutoORM(self.ORM).InsertedEntity);
end;

function TProdutoFieldsInsertion.FromEntyity(
Entity: IProduto): IStormInsertExecutor<IProduto>;
var
  Insertions : IProdutoFieldsInsertionWithGo;
begin
  Insertions := Self;
  Insertions := (Insertions.Codigo_produto as TStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>)
  .SetValue(Entity.Codigo_produto.GetValue());
  
  Insertions := Insertions.Descricao.SetValue(Entity.Descricao.GetValue());
  
  Insertions := Insertions.Codigo_marca.SetValue(Entity.Codigo_marca.GetValue());
  
  Insertions := Insertions.Preco.SetValue(Entity.Preco.GetValue());
  
  Insertions := Insertions.Ativo.SetValue(Entity.Ativo.GetValue());
  
  Insertions := Insertions.Data_criacao.SetValue(Entity.Data_criacao.GetValue());
  
  Insertions := Insertions.Data_alteracao.SetValue(Entity.Data_alteracao.GetValue());
  
  result := TStormInsertExecutor<IProduto>.Create
  (
    Insertions as TStormSqlPartition,
    TProdutoORM(self.ORM).InsertedEntity
  );
end;

{ TProdutoOrderBySelection }

function TProdutoOrderBySelection.Codigo_produto: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.Codigo_produto),Self);
end;

function TProdutoOrderBySelection.Descricao: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.Descricao),Self);
end;

function TProdutoOrderBySelection.Codigo_marca: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.Codigo_marca),Self);
end;

function TProdutoOrderBySelection.Preco: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.Preco),Self);
end;

function TProdutoOrderBySelection.Ativo: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.Ativo),Self);
end;

function TProdutoOrderBySelection.Data_criacao: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.Data_criacao),Self);
end;

function TProdutoOrderBySelection.Data_alteracao: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.Data_alteracao),Self);
end;

function TProdutoOrderBySelection.Open: TResult<IStormSelectSuccess<IProduto>, IStormExecutionFail>;
begin
  RemoveLastSqlCharacter();
  result := TStormSelectExecutor<IProduto,IProdutoOrderBySelection>.Create(Self).Open();
end;

{ TProdutoConstructors }

function TProdutoOrderBySelectionConstructor.GetGenericInstance(
Owner: TStormSQLPartition): IProdutoOrderBySelection;
begin
  result := TProdutoOrderBySelection.Create(Owner);
end;

function TProdutoOrderBySelectedConstructor.GetGenericInstance(
Owner: TStormSQLPartition): IProdutoOrderBySelected;
begin
  result := TProdutoOrderBySelection.Create(Owner);
end;

function TProdutoWhereSelectorSelectConstructor.GetGenericInstance(
Owner: TStormSQLPartition): IProdutoWhereSelector<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>;
begin
  result := TProdutoWhereSelector<IStormSelectExecutor<IProduto,IProdutoOrderBySelection>>.Create(Owner);
end;

function TSelectExecutorConstructor.GetGenericInstance(
Owner: TStormSQLPartition): IStormSelectExecutor<IProduto,IProdutoOrderBySelection>;
begin
  result := TStormSelectExecutor<IProduto,IProdutoOrderBySelection>.Create(Owner);
end;

function TProdutoFieldsAssignmentWithWhereConstructor.GetGenericInstance(
Owner: TStormSQLPartition): IProdutoFieldsAssignmentWithWhere;
begin
  result := TProdutoFieldsAssignment.Create(Owner);
end;

function TProdutoWhereSelectorUpdateConstructor.GetGenericInstance(
Owner: TStormSQLPartition): IProdutoWhereSelector<IStormUpdateExecutor>;
begin
  result :=  TProdutoWhereSelector<IStormUpdateExecutor>.Create(owner);
end;

function TProdutoFieldsInsertionWithGoConstructor.GetGenericInstance(
Owner: TStormSQLPartition): IProdutoFieldsInsertionWithGo;
begin
  result := TProdutoFieldsInsertion.Create(Owner);
end;

function TProdutoEntityConstructor.GetGenericInstance(
Owner: TStormSQLPartition): IProduto;
begin
  result := NewProduto();
end;

function TProdutoWhereSelectorDeleteConstructor.GetGenericInstance(
Owner: TStormSQLPartition): IProdutoWhereSelector<IStormDeleteExecutor>;
begin
  result :=  TProdutoWhereSelector<IStormDeleteExecutor>.Create(owner);
end;

end.
