unit storm.orm.base;

interface

Uses
  DAta.DB,
  DFE.Maybe,
  DFE.Result,
  storm.schema.interfaces,
  System.Generics.Collections,
  storm.data.interfaces,
  storm.orm.interfaces,
  storm.orm.query,
  storm.model.base,
  storm.model.interfaces,
  storm.entity.interfaces,

  System.Sysutils, System.Classes;

Type
  TStormORM = Class;

  TStormChild = class(TInterfacedObject)
  protected
    ORM : TStormORM;

    Procedure Initialize; Virtual;
    Procedure Finalize; Virtual;

    Function SQLDriver : IStormSQLDriver;
    Function TableSchema : IStormTableSchema;
    Function GetFullTableName : String;
  public
    Constructor Create(Const ORM : TStormORM); Reintroduce; Virtual;
    Destructor Destroy(); Override;
  end;

  TStormSQLPartition= class(TStormChild, IStormSQLPartition)
  protected
    Owner : IStormSQLPartition;
    SQL : String;
    QueryParameters : IStormQueryParameters;
    Procedure AddSQL(const  content : string);
    Procedure AddOpenParenthesis();
    Procedure AddCloseParenthesis();
    Procedure AddAnd();
    Procedure AddOr();
    Procedure AddWhere();
    Procedure AddFrom();
    Procedure Initialize; Override;
    function  AddParameter(value : variant) : string;

    Function GetReturnInstance<ReturnType>() : ReturnType;
    Function GetReturnInstance2<ReturnType, SubReturnType>() : ReturnType;

  public
    Function GetOwner : TStormSQLPartition;
    Constructor Create(Const ORM : TStormORM ; Const Owner : TStormSQLPartition); Reintroduce; Overload; Virtual;
    Constructor Create(Const Owner : TStormSQLPartition); Reintroduce;Overload; Virtual;
  end;

  IStormGenericReturn<ReturnType> = interface['{0E863C1A-53DB-4F54-8A94-BE8F89D9982C}']
    Function GetGenericInstance(Owner : TStormSQLPartition) : ReturnType;
  end;

  TStormGenericReturn = class(TInterfacedObject)
    Function GetReturnInstance<ReturnType>(Target : TStormSQLPartition) : IStormGenericReturn<ReturnType>;
    Function GetReturnInstance2<ReturnType, SubReturnType>(Target : TStormSQLPartition) : IStormGenericReturn<ReturnType>;
  end;

  TStormColumnSQLPartition = Class(TStormSqlPartition)
  protected

    ColumnSchema : IStormSchemaColumn;

    Function GetColumnName : String;
  public
    Constructor Create(Owner : TStormSQLPartition ; Const ColumnSchema : IStormSchemaColumn); Reintroduce;
  End;





  TStormFieldsSelection<WhereSelector, Executor : IInterface>
  = class(TStormSQLPartition)
  protected
    procedure Initialize; override;

  public
    Function All() : IStormWherePoint<WhereSelector>;
  end;

  TStormWherePoint<WhereSelector, Executor : IInterface>
  = class(TStormSQLPartition, IStormWherePoint<WhereSelector>)
  public
    Function Where : WhereSelector;
  end;

  TStormSQLExecutor = class(TStormSQLPartition)
  protected
    Function DbSQLConnecton  : IStormSQLConnection;
  end;

  TStormSelectExecutor<EntityType: IStormEntity> = Class(TStormSQLExecutor, IStormSelectExecutor<EntityType>)
    Function Open() : TResult<IStormSelectSuccess<EntityType>,IStormExecutionFail>;
  end;

  TStormSelectSuccess<EntityType : IStormEntity> = class(TStormSQLPartition, IStormSelectSuccess<EntityType>)
  protected
    Dataset : TDataset;
  public
    Constructor Create(Owner : TStormSQLPartition ; Dataset : TDataset); Reintroduce;
    Function GetDataset : TDataset;
    Function GetModel : IStormModel<EntityType>;
  end;

  TStormExecutionFail = class(TStormSQLPartition, IStormExecutionFail)
  protected
    ErrorMessage : String;
  public
    Constructor Create(Owner : TStormSQLPartition ; Const ErrorMessage : String); Reintroduce;
    Function GetErrorMessage : String;
    Function GetExecutedCommand : String;
  end;

  TStormUpdateExecutor = Class(TStormSQLExecutor, IStormUpdateExecutor)
  protected
    procedure initialize; override;
  public
    Function Execute() : TResult<IStormUpdateSuccess,IStormExecutionFail>;
  end;

  TStormUpdateSuccess = class(TStormSQLPartition, IStormUpdateSuccess)
  protected
    RowsAffected : Integer;
  public
    Constructor Create(Owner : TStormSQLPartition ; RowsAffected : integer); Reintroduce;
    Function RowsUpdated : integer;
  end;


  TUpdateExecutorConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IStormUpdateExecutor>)
  public
    Function GetGenericInstance(Owner : TStormSQLPartition) : IStormUpdateExecutor;
  End;





  TStormORM = Class(TInterfacedObject)
  protected
    TableSchema     : IStormTableSchema;
    DbSQLConnecton  : IStormSQLConnection;
    SQLDriver       : IStormSQLDriver;



     Procedure Initialize; Virtual;
     Procedure Finalize; Virtual;
  public
    FClassConstructor : TDictionary<string, IInterface>;
    Constructor Create(Const DbSQLConnecton : IStormSQLConnection ; Const TableSchema : IStormTableSchema);
    DEstructor Destroy(); Override;
  End;


implementation

Uses
  System.TypInfo,
  System.Strutils,
  storm.dependency.register;


{ TStormORM }

constructor TStormORM.Create(Const DbSQLConnecton : IStormSQLConnection ;
Const TableSchema : IStormTableSchema);
begin
  inherited create;
  Self.TableSchema := TableSchema;
  Self.DbSQLConnecton := DbSQLConnecton;
  Initialize();
end;

destructor TStormORM.DEstroy;
begin
  FClassConstructor.Free;
  inherited;
end;

procedure TStormORM.Finalize;
begin

end;

procedure TStormORM.Initialize;
begin
  DependencyRegister.GetSQLDriverInstance
  .OnSome
  (
    procedure(sqldriver : IStormSQLDriver)
    begin
      self.SQLDriver := sqldriver;
    end
  )
  .OnNone
  (
    procedure
    begin
      raise Exception.Create('No Sql Driver Registered.');
    end
  );

  FClassConstructor := TDictionary<string, IInterface>.Create();

  FClassConstructor.Add(TGUID(IStormUpdateExecutor).ToString, TUpdateExecutorConstructor.Create);

end;

{ TStormChild }

constructor TStormChild.Create(Const ORM: TStormORM);
begin
  inherited Create;
  Self.ORM := ORM;
  Initialize();
end;

destructor TStormChild.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TStormChild.Finalize;
begin

end;

function TStormChild.GetFullTableName: String;
begin
  Result := self.ORM.SQLDriver.GetFullTableName(self.TableSchema);
end;

procedure TStormChild.Initialize;
begin

end;

function TStormChild.SQLDriver: IStormSQLDriver;
begin
  Result := self.ORM.SQLDriver;
end;

function TStormChild.TableSchema: IStormTableSchema;
begin
  Result := Self.ORM.TableSchema;
end;

{ TStormSQLPartition }

procedure TStormSQLPartition.AddAnd;
begin
  AddSQL('AND');
end;

procedure TStormSQLPartition.AddCloseParenthesis;
begin
  AddSQL(')');
end;

procedure TStormSQLPartition.AddFrom;
begin
  AddSQL('FROM ' + Self.GetFullTableName);
end;

procedure TStormSQLPartition.AddOpenParenthesis;
begin
  AddSQL('(');
end;

procedure TStormSQLPartition.AddOr;
begin
  AddSQL('OR');
end;

function TStormSQLPartition.AddParameter(value: variant): string;
begin
  Result := QueryParameters.Add(value);
end;

procedure TStormSQLPartition.AddSQL(const content: string);
begin
  if Not self.sql.IsEmpty then
  begin
    self.SQL := self.SQL + ' ' + content;
  end
  else
  begin
    self.SQL := self.SQL + content;
  end;
end;

procedure TStormSQLPartition.AddWhere;
begin
  AddSQL('WHERE');
end;

constructor TStormSQLPartition.Create(const ORM: TStormORM;
  Const Owner: TStormSQLPartition);
begin
  if assigned(Owner) then
  begin
    Self.Owner := Owner;
    Self.SQL := Owner.SQL;
  end;
  inherited Create(ORM);

end;

constructor TStormSQLPartition.Create(Const Owner: TStormSQLPartition);
begin
  if Assigned(Owner) then
  begin
    create(Owner.ORM, Owner);
  end
  else
  begin
    raise Exception.Create('Parameter Owner must be assigned');
  end;
end;

function TStormSQLPartition.GetOwner: TStormSQLPartition;
begin
  Result := self.Owner as TStormSQLPartition;
end;

function TStormSQLPartition.GetReturnInstance2<ReturnType, SubReturnType>: ReturnType;
var
  provider : TStormGenericReturn;
begin
  provider := TStormGenericReturn.Create;
  try
    Result := (provider.GetReturnInstance2<ReturnType, SubReturnType>(self) as IStormGenericReturn<ReturnType>).GetGenericInstance(self);
  finally
    provider.Free;
  end;
end;

function TStormSQLPartition.GetReturnInstance<ReturnType>: ReturnType;
var
  provider : TStormGenericReturn;
begin
  provider := TStormGenericReturn.Create;
  try
    Result := (provider.GetReturnInstance<ReturnType>(self) as IStormGenericReturn<ReturnType>).GetGenericInstance(self);
  finally
    provider.Free;
  end;
end;

procedure TStormSQLPartition.Initialize;
begin
  inherited;
  if Assigned(owner) and assigned(GetOwner.QueryParameters) then
  begin
    self.QueryParameters := GetOwner.QueryParameters;
  end
  else
  begin
    QueryParameters := TStormQueryParameters.Create;
  end;
end;




{ TStormGenericReturn }

function TStormGenericReturn.GetReturnInstance2<ReturnType, SubReturnType>(
  Target: TStormSQLPartition): IStormGenericReturn<ReturnType>;
VAR
  x : string;
begin
  x := GetTypeData(TypeInfo(ReturnType)).GUID.ToString + GetTypeData(TypeInfo(SubReturnType)).GUID.ToString;
  Result := TStormORM(Target.ORM).FClassConstructor.Items[x]  as IStormGenericReturn<ReturnType>;
end;

function TStormGenericReturn.GetReturnInstance<ReturnType>(
  Target: TStormSQLPartition): IStormGenericReturn<ReturnType>;
VAR
  x : string;
begin
  x := GetTypeData(TypeInfo(ReturnType)).GUID.ToString;
  Result := TStormORM(Target.ORM).FClassConstructor.Items[GetTypeData(TypeInfo(ReturnType)).GUID.ToString]  as IStormGenericReturn<ReturnType>;
end;

{ TStormColumnSQLPartition<ReturnType> }

constructor TStormColumnSQLPartition.Create(
  Owner: TStormSQLPartition; const ColumnSchema: IStormSchemaColumn);
begin
  inherited create(Owner);
  self.ColumnSchema := ColumnSchema;
end;

function TStormColumnSQLPartition.GetColumnName: String;
begin
  Result := TableSchema.GetTableName + '.' + ColumnSchema.GetColumnName;
end;




{ TStormFieldsSelection<WhereSelector> }

function TStormFieldsSelection<WhereSelector, Executor>.All: IStormWherePoint<WhereSelector>;
begin
  AddSQL('*');
  AddFrom;
  Result := TStormWherePoint<WhereSelector, Executor>.Create(Self);
end;

{ TStormWherePoint<WhereSelector> }

function TStormWherePoint<WhereSelector, Executor>.Where: WhereSelector;
begin
  AddWhere;
  result := self.GetReturnInstance2<WhereSelector, Executor>();
end;

{ TStormSelectExecutor<EntityType> }

function TStormSelectExecutor<EntityType>.Open: TResult<IStormSelectSuccess<EntityType>, IStormExecutionFail>;
begin
  DbSQLConnecton.SetSQL(SQL);
  DbSQLConnecton.LoadParameters(QueryParameters.Items);
  try
    DbSQLConnecton.Open;
    result := TStormSelectSuccess<EntityType>.Create(self, DbSQLConnecton.Dataset);
  except
    on e : exception do
    begin
      Result := TStormExecutionFail.Create(Self, e.Message);
    end;
  end;
end;

{ TStormSQLExecutor }

function TStormSQLExecutor.DbSQLConnecton: IStormSQLConnection;
begin
  Result := self.ORM.DbSQLConnecton;
end;

{ TStormSelectSuccess<EntityType> }

constructor TStormSelectSuccess<EntityType>.Create(Owner: TStormSQLPartition;
  Dataset: TDataset);
begin
  Self.Dataset := Dataset;
  inherited create(Owner);

end;

function TStormSelectSuccess<EntityType>.GetDataset: TDataset;
begin
  Result := Self.Dataset;
end;

function TStormSelectSuccess<EntityType>.GetModel: IStormModel<EntityType>;
begin
  Result := TStormModel<EntityType>.FromDataset(Self.Dataset);
end;

{ TStormExecutionFail }

constructor TStormExecutionFail.Create(Owner: TStormSQLPartition;
 Const  ErrorMessage: String);
begin
  Self.ErrorMessage := ErrorMessage;
  inherited create(Owner);
end;

function TStormExecutionFail.GetErrorMessage: String;
begin
  Result := ErrorMessage;
end;

function TStormExecutionFail.GetExecutedCommand: String;
begin
  Result := self.SQL;
end;

procedure TStormFieldsSelection<WhereSelector, Executor>.Initialize;
begin
  inherited;
  AddSQL('SELECT');
end;

{ TUpdateExecutorConstructor }

function TUpdateExecutorConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IStormUpdateExecutor;
begin
  Result := TStormUpdateExecutor.Create(Owner);
end;

{ TStormUpdateSuccess }

constructor TStormUpdateSuccess.Create(Owner: TStormSQLPartition;
  RowsAffected: integer);
begin
  self.RowsAffected := RowsAffected;
  inherited create(owner);
end;

function TStormUpdateSuccess.RowsUpdated: integer;
begin
  Result := self.RowsAffected;
end;

{ TStormUpdateExecutor }

function TStormUpdateExecutor.Execute: TResult<IStormUpdateSuccess, IStormExecutionFail>;
begin
  DbSQLConnecton.SetSQL(SQL);
  DbSQLConnecton.LoadParameters(QueryParameters.Items);
  try
    DbSQLConnecton.Execute;

    result := TStormUpdateSuccess.create(self, DbSQLConnecton.RowsAffected);


  except
    on e : exception do
    begin
      Result := TStormExecutionFail.Create(Self,e.Message);
    end;
  end;
end;

procedure TStormUpdateExecutor.initialize;
begin
  inherited;

  SELF.SQL := stringreplace(self.SQL,' ,','',[])

end;

end.
