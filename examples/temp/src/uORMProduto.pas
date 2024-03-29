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

  IProdutoWhereSelector<Executor : IInterface> = interface['{6FC7F94B-555E-4D15-8903-6BB4C7FA57CC}']
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

  IProdutoOrderBySelection = interface['{8FFA4E16-BFDE-4416-AD44-A1E21B8F7042}']
    function CodigoProduto : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Descricao     : IStormOrderBySelector<IProdutoOrderBySelected>;
    function CodigoMarca   : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Preco         : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Ativo         : IStormOrderBySelector<IProdutoOrderBySelected>;
    function DataCriacao   : IStormOrderBySelector<IProdutoOrderBySelected>;
    function DataAlteracao : IStormOrderBySelector<IProdutoOrderBySelected>;
  end;

  IProdutoOrderBySelected = interface(IProdutoOrderBySelection)['{C44710E4-8DF8-4CF4-9D20-C784187A0A00}']
    function Open() : TResult<IStormSelectSuccess<IProduto>,IStormExecutionFail>;
  end;

  IProdutoFieldsSelection = interface['{D8D67C41-38B0-4DE3-B9E6-32D212491752}']
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

  IProdutoFieldsSelectionWithLimit = interface(IProdutoFieldsSelection)['{211F27C2-F255-4FB5-B7A3-6347E911C0B0}']
    function Limit(Const Count : Integer) : IProdutoFieldsSelection;
  end;

  IProdutoFieldsAssignmentWithWhere = interface;

  IProdutoFieldsAssignmentBase = interface['{36A1C7C4-EC9A-432F-8EA8-116D80B45E56}']
    function CodigoProduto : IStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Descricao     : IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function CodigoMarca   : IStormIntegerNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Preco         : IStormFloatNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Ativo         : IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function DataCriacao   : IStormDateNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function DataAlteracao : IStormDateTimeNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
  end;

  IProdutoFieldsAssignmentWithWhere = interface(IProdutoFieldsAssignmentBase)['{C6863F3C-76B6-43E6-8ECB-F3160215A2C7}']
    function Where : IProdutoWhereSelector<IStormUpdateExecutor>;
  end;

  IProdutoFieldsAssignment = interface(IProdutoFieldsAssignmentBase)['{EBCCE32C-279A-4563-A338-E64C1D959785}']
    function FromEntyity(Entity : IProduto) : IStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>>;
  end;

  IProdutoFieldsInsertionWithGo = interface;

  IProdutoFieldsInsertionBase = interface['{FCEFD50E-10DD-45CB-AD0B-DBFD19C102A6}']
    function CodigoProduto : IStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Descricao     : IStormStringNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function CodigoMarca   : IStormIntegerNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Preco         : IStormFloatNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Ativo         : IStormBooleanNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function DataCriacao   : IStormDateNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function DataAlteracao : IStormDateTimeNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
  end;

  IProdutoFieldsInsertionWithGo = interface(IProdutoFieldsInsertionBase)['{4A0BA665-CFE3-460A-810E-B52E20AE1641}']
    function Go : IStormInsertExecutor<IProduto>;
  end;

  IProdutoFieldsInsertion = interface(IProdutoFieldsInsertionBase)['{0D3CE2CD-4A15-4F28-8343-A3B46DF02A2E}']
    function FromEntyity(Entity : IProduto) : IStormInsertExecutor<IProduto>;
  end;

  IProdutoORM = interface(IStormORM)['{6A883822-A6DA-4276-8339-9E19FD9B9CAB}']
    function Select() : IProdutoFieldsSelectionWithLimit;
    function Update() : IProdutoFieldsAssignment;
    function Insert() : IProdutoFieldsInsertion;
    function Delete() : IStormWherePoint<IProdutoWhereSelector<IStormDeleteExecutor>>;

    function SelectByID
    (
      Const CodigoProduto : Integer
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

    function OnInsertedSetValueToCodigoProduto(value : Maybe<Integer>) : Boolean;
    function OnInsertedSetValueToDescricao(value : Maybe<String>) : Boolean;
    function OnInsertedSetValueToCodigoMarca(value : Maybe<Integer>) : Boolean;
    function OnInsertedSetValueToPreco(value : Maybe<Extended>) : Boolean;
    function OnInsertedSetValueToAtivo(value : Maybe<Boolean>) : Boolean;
    function OnInsertedSetValueToDataCriacao(value : Maybe<TDate>) : Boolean;
    function OnInsertedSetValueToDataAlteracao(value : Maybe<TDateTime>) : Boolean;
  public
    constructor Create(DbSQLConnecton : IStormSQLConnection);

    function Select() : IProdutoFieldsSelectionWithLimit;
    function Update() : IProdutoFieldsAssignment;
    function Insert() : IProdutoFieldsInsertion;
    function Delete() : IStormWherePoint<IProdutoWhereSelector<IStormDeleteExecutor>>;

    function SelectByID
    (
      Const CodigoProduto : Integer
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
    function CodigoProduto : IProdutoFieldsSelection;
    function Descricao     : IProdutoFieldsSelection;
    function CodigoMarca   : IProdutoFieldsSelection;
    function Preco         : IProdutoFieldsSelection;
    function Ativo         : IProdutoFieldsSelection;
    function DataCriacao   : IProdutoFieldsSelection;
    function DataAlteracao : IProdutoFieldsSelection;
  end;

  TProdutoOrderBySelection = Class(TStormSqlPartition,IProdutoOrderBySelection,IProdutoOrderBySelected)
  public
    function CodigoProduto : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Descricao     : IStormOrderBySelector<IProdutoOrderBySelected>;
    function CodigoMarca   : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Preco         : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Ativo         : IStormOrderBySelector<IProdutoOrderBySelected>;
    function DataCriacao   : IStormOrderBySelector<IProdutoOrderBySelected>;
    function DataAlteracao : IStormOrderBySelector<IProdutoOrderBySelected>;
    function Open() : TResult<IStormSelectSuccess<IProduto>,IStormExecutionFail>;
  end;

  TProdutoWhereSelector<Executor : IInterface> = class(TStormSqlPartition, IProdutoWhereSelector<Executor>)
  public
    function CodigoProduto : IStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Descricao     : IStormStringNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function CodigoMarca   : IStormIntegerNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Preco         : IStormFloatNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function Ativo         : IStormBooleanNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function DataCriacao   : IStormDateNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    function DataAlteracao : IStormDateTimeNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
    Function OpenParenthesis : IProdutoWhereSelector<Executor>;
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
    function CodigoProduto : IStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Descricao     : IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function CodigoMarca   : IStormIntegerNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Preco         : IStormFloatNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function Ativo         : IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function DataCriacao   : IStormDateNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function DataAlteracao : IStormDateTimeNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
    function FromEntyity(Entity : IProduto) : IStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>>;
  end;

  TProdutoFieldsInsertion = class
  (
    TStormSqlPartition,
    IProdutoFieldsInsertion,
    IProdutoFieldsInsertionWithGo
  )
  Public
    function CodigoProduto : IStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Descricao     : IStormStringNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function CodigoMarca   : IStormIntegerNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Preco         : IStormFloatNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function Ativo         : IStormBooleanNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function DataCriacao   : IStormDateNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
    function DataAlteracao : IStormDateTimeNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
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

function TProdutoORM.OnInsertedSetValueToCodigoProduto(value: Maybe<Integer>): Boolean;
begin
  result := InsertedEntity.CodigoProduto.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToDescricao(value: Maybe<String>): Boolean;
begin
  result := InsertedEntity.Descricao.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToCodigoMarca(value: Maybe<Integer>): Boolean;
begin
  result := InsertedEntity.CodigoMarca.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToPreco(value: Maybe<Extended>): Boolean;
begin
  result := InsertedEntity.Preco.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToAtivo(value: Maybe<Boolean>): Boolean;
begin
  result := InsertedEntity.Ativo.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToDataCriacao(value: Maybe<TDate>): Boolean;
begin
  result := InsertedEntity.DataCriacao.Value.SetValue(value);
end;

function TProdutoORM.OnInsertedSetValueToDataAlteracao(value: Maybe<TDateTime>): Boolean;
begin
  result := InsertedEntity.DataAlteracao.Value.SetValue(value);
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
  Const CodigoProduto : Integer
): ISelectByIDResult;
begin
  result :=
  Self
  .Select
  .AllColumns
  .Where
  .CodigoProduto.IsEqualsTo(CodigoProduto)
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
    .CodigoProduto.IsEqualsTo(Entity.CodigoProduto.GetValueOrDefault())
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

function TProdutoFieldsSelection.CodigoProduto: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.CodigoProduto));
  result := Self;
end;

function TProdutoFieldsSelection.Descricao: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.Descricao));
  result := Self;
end;

function TProdutoFieldsSelection.CodigoMarca: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.CodigoMarca));
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

function TProdutoFieldsSelection.DataCriacao: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.DataCriacao));
  result := Self;
end;

function TProdutoFieldsSelection.DataAlteracao: IProdutoFieldsSelection;
begin
  AddColumn(Integer(TProdutoPossibleFields.DataAlteracao));
  result := Self;
end;


function TProdutoFieldsSelection.Limit(
Const Count: Integer): IProdutoFieldsSelection;
begin
  AddLimit(Count);
  result := Self;
end;

{ TProdutoWhereSelector<Executor> }
function TProdutoWhereSelector<Executor>.CodigoProduto: IStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.CodigoProduto);
end;

function TProdutoWhereSelector<Executor>.Descricao: IStormStringNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormStringWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Descricao);
end;

function TProdutoWhereSelector<Executor>.CodigoMarca: IStormIntegerNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormIntegerWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.CodigoMarca);
end;

function TProdutoWhereSelector<Executor>.Preco: IStormFloatNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormFloatWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Preco);
end;

function TProdutoWhereSelector<Executor>.Ativo: IStormBooleanNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormBooleanWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Ativo);
end;

function TProdutoWhereSelector<Executor>.DataCriacao: IStormDateNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormDateWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.DataCriacao);
end;

function TProdutoWhereSelector<Executor>.DataAlteracao: IStormDateTimeNullableWhere<IProdutoWhereSelector<Executor>, Executor>;
begin
  result := TStormDateTimeWhere<IProdutoWhereSelector<Executor>, Executor>.Create(self, TProdutoORM(self.ORM).SchemaProduto.DataAlteracao);
end;

function TProdutoWhereSelector<Executor>.OpenParenthesis: IProdutoWhereSelector<Executor>;
begin
  AddOpenParenthesis;
  result := Self;
end;

{ TProdutoFieldsAssignment }

function TProdutoFieldsAssignment.CodigoProduto: IStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  result := TStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.CodigoProduto);
end;

function TProdutoFieldsAssignment.Descricao: IStormStringNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  result := TStormStringFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Descricao);
end;

function TProdutoFieldsAssignment.CodigoMarca: IStormIntegerNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  result := TStormIntegerFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.CodigoMarca);
end;

function TProdutoFieldsAssignment.Preco: IStormFloatNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  result := TStormFloatFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Preco);
end;

function TProdutoFieldsAssignment.Ativo: IStormBooleanNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  result := TStormBooleanFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.Ativo);
end;

function TProdutoFieldsAssignment.DataCriacao: IStormDateNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  result := TStormDateFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.DataCriacao);
end;

function TProdutoFieldsAssignment.DataAlteracao: IStormDateTimeNullableFieldAssignement<IProdutoFieldsAssignmentWithWhere>;
begin
  result := TStormDateTimeFieldAssignement<IProdutoFieldsAssignmentWithWhere>.Create(Self, TProdutoORM(self.ORM).SchemaProduto.DataAlteracao);
end;

function TProdutoFieldsAssignment.FromEntyity(
Entity: IProduto): IStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>>;
begin
  result := TStormWherePoint<IProdutoWhereSelector<IStormUpdateExecutor>,IStormUpdateExecutor>.Create
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

{ TProdutoFieldsInsertion }

function TProdutoFieldsInsertion.CodigoProduto: IStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  result := TStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).CodigoProduto,
    TProdutoORM(self.ORM).OnInsertedSetValueToCodigoProduto
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

function TProdutoFieldsInsertion.CodigoMarca: IStormIntegerNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  result := TStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).CodigoMarca,
    TProdutoORM(self.ORM).OnInsertedSetValueToCodigoMarca
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

function TProdutoFieldsInsertion.DataCriacao: IStormDateNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  result := TStormDateFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).DataCriacao,
    TProdutoORM(self.ORM).OnInsertedSetValueToDataCriacao
  );
end;

function TProdutoFieldsInsertion.DataAlteracao: IStormDateTimeNullableFieldInsertion<IProdutoFieldsInsertionWithGo>;
begin
  result := TStormDateTimeFieldInsertion<IProdutoFieldsInsertionWithGo>.Create
  (
    Self,
    TSchemaProduto(Self.TableSchema).DataAlteracao,
    TProdutoORM(self.ORM).OnInsertedSetValueToDataAlteracao
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
  Insertions := (Insertions.CodigoProduto as TStormIntegerFieldInsertion<IProdutoFieldsInsertionWithGo>)
  .SetValue(Entity.CodigoProduto.GetValue());

  Insertions := Insertions.Descricao.SetValue(Entity.Descricao.GetValue());

  Insertions := Insertions.CodigoMarca.SetValue(Entity.CodigoMarca.GetValue());

  Insertions := Insertions.Preco.SetValue(Entity.Preco.GetValue());

  Insertions := Insertions.Ativo.SetValue(Entity.Ativo.GetValue());

  Insertions := Insertions.DataCriacao.SetValue(Entity.DataCriacao.GetValue());

  Insertions := Insertions.DataAlteracao.SetValue(Entity.DataAlteracao.GetValue());

  result := TStormInsertExecutor<IProduto>.Create
  (
    Insertions as TStormSqlPartition,
    TProdutoORM(self.ORM).InsertedEntity
  );
end;

{ TProdutoOrderBySelection }

function TProdutoOrderBySelection.CodigoProduto: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.CodigoProduto),Self);
end;

function TProdutoOrderBySelection.Descricao: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.Descricao),Self);
end;

function TProdutoOrderBySelection.CodigoMarca: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.CodigoMarca),Self);
end;

function TProdutoOrderBySelection.Preco: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.Preco),Self);
end;

function TProdutoOrderBySelection.Ativo: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.Ativo),Self);
end;

function TProdutoOrderBySelection.DataCriacao: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.DataCriacao),Self);
end;

function TProdutoOrderBySelection.DataAlteracao: IStormOrderBySelector<IProdutoOrderBySelected>;
begin
  result := TStormOrderBySelector<IProdutoOrderBySelected>.Create(Integer(TProdutoPossibleFields.DataAlteracao),Self);
end;

function TProdutoOrderBySelection.Open: TResult<IStormSelectSuccess<Iproduto>, IStormExecutionFail>;
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
