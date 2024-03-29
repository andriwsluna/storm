unit storm.orm.base;

interface

Uses
  DAta.DB,
  DFE.Maybe,
  DFE.Result,
  DFE.Interfaces,
  storm.schema.interfaces,
  System.Generics.Collections,
  storm.data.interfaces,
  storm.orm.interfaces,
  storm.orm.query,
  storm.model.base,
  storm.fields.interfaces,
  storm.model.interfaces,
  storm.entity.interfaces,
  storm.entity.base,
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
    Protected_SQL : String;
    QueryParameters : IStormQueryParameters;
    SelectLimit : Maybe<integer>;
    Procedure AddSQL(const  content : string); Virtual;
    Procedure AddOpenParenthesis();
    Procedure AddCloseParenthesis();
    Procedure AddAnd();
    Procedure AddOr();
    Procedure AddWhere();
    Procedure AddOrderBy();
    Procedure AddFrom();
    Procedure AddUpdate();
    Procedure Initialize; Override;
    function  AddParameter(value : variant) : string;
    Procedure RemoveLastSqlCharacter();
    Procedure ResolveFinalLimit();

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
    Procedure AddColumn(Const index : Integer);
    Procedure RemoveLastComma();
    Procedure AddLimit(Const Limit : Integer); Virtual;
  public
    Function AllColumns() : IStormWherePoint<WhereSelector>;
    Function From : IStormWherePoint<WhereSelector>;
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

  TStormSelectExecutor<EntityType: IStormEntity ; OrderSelection : IInterface> = Class(TStormSQLExecutor, IStormSelectExecutor<EntityType,OrderSelection>)
    Function Open() : TResult<IStormSelectSuccess<EntityType>,IStormExecutionFail>;
    Function OrderBy() : OrderSelection;
  end;

  TStormOrderBySelector<OrderSelection> = Class(TStormSQLPartition,IStormOrderBySelector<OrderSelection>)
  protected
    Column : IStormSchemaColumn;
  public
    Function ASC() : OrderSelection;
    Function DESC() : OrderSelection;

    Constructor Create(Const ColumnIndex : Integer ; Const Owner : TStormSQLPartition); Reintroduce;Overload;
  End;

  TStormSelectSuccess<EntityType : IStormEntity> = class(TStormSQLPartition, IStormSelectSuccess<EntityType>)
  protected
    SQL : string;
    Dataset : TDataset;
    Procedure Finalize; Override;
  public
    Constructor Create(Owner : TStormSQLPartition ; Dataset : TDataset ; SQL : String); Reintroduce;
    Function GetDataset : TDataset;
    Function GetModel : IStormModel<EntityType>;
    Function IsEmpty : Boolean;
    Function GetSQL() : String;
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
    procedure Initialize; override;
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

  TStormInsertExecutor<EntityType: IStormEntity> = class(TStormSQLExecutor,IStormInsertExecutor<EntityType>)
  protected
    InsertedEntity :EntityType;
    Procedure Initialize; Override;
    Procedure PrepareSQL();
  public
    Function Execute() : TResult<IStormInsertSuccess<EntityType>,IStormExecutionFail>;
    Constructor Create
    (
      Const Owner : TStormSQLPartition;
      InsertedEntity : EntityType
    ); Reintroduce;
  end;

  TStormInsertSuccess<EntityType: IStormEntity> = class(TStormSQLPartition, IStormInsertSuccess<EntityType>)
  protected
    InsertedEntity : EntityType;
  public
    Function GetInserted() : EntityType;
    Constructor Create
    (
      Const Owner : TStormSQLPartition;
      InsertedEntity : EntityType
    ); Reintroduce;
  end;

  TStormDeleteExecutor = Class(TStormSQLExecutor, IStormDeleteExecutor)
  protected
    Procedure Initialize; Override;
  public
    Function Execute() : TResult<IStormDeleteSuccess,IStormExecutionFail>;
  end;

  TStormDeleteSuccess = class(TStormSQLPartition, IStormDeleteSuccess)
  protected
    RowsAffected : Integer;
  public
    Constructor Create(Owner : TStormSQLPartition ; RowsAffected : integer); Reintroduce;
    Function RowsDeleted : integer;
  end;


  TUpdateExecutorConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IStormUpdateExecutor>)
  public
    Function GetGenericInstance(Owner : TStormSQLPartition) : IStormUpdateExecutor;
  End;

  TDeleteExecutorConstructor
  = Class(TInterfacedObject, IStormGenericReturn<IStormDeleteExecutor>)
  public
    Function GetGenericInstance(Owner : TStormSQLPartition) : IStormDeleteExecutor;
  End;










  TStormORM = Class(TInterfacedObject)
  protected
    TableSchema     : IStormTableSchema;
    DbSQLConnecton  : IStormSQLConnection;
    SQLDriver       : IStormSQLDriver;
    InsertColumnList : TDictionary<string, string>;





     Procedure Initialize; Virtual;
     Procedure Finalize; Virtual;

     Function VerifyPrimaryKeyFields(Entity : IStormEntity ; ExcludeAutIncFields: Boolean = False) : Boolean;
  public

    FClassConstructor : TDictionary<string, IInterface>;
    procedure AddInsertField(const ColumnName : String; const ParamName : string);
    Constructor Create(Const DbSQLConnecton : IStormSQLConnection ; Const TableSchema : IStormTableSchema);
    DEstructor Destroy(); Override;
  End;


implementation

Uses
  storm.schema.column,
  System.TypInfo,
  System.Strutils,
  storm.dependency.register;


{ TStormORM }

procedure TStormORM.AddInsertField(const ColumnName, ParamName: string);
begin
  if Not InsertColumnList.ContainsKey(ColumnName) then
  begin
    InsertColumnList.Add(ColumnName,ParamName)
  end
  else
  begin
    InsertColumnList.Items[ColumnName] := ParamName;
  end;


end;

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
  Finalize();
  inherited;
end;

procedure TStormORM.Finalize;
begin
  FClassConstructor.Free;
  InsertColumnList.Free;
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
  FClassConstructor.Add(TGUID(IStormDeleteExecutor).ToString, TDeleteExecutorConstructor.Create);

  InsertColumnList := TDictionary<string, string>.Create();

end;

function TStormORM.VerifyPrimaryKeyFields(Entity: IStormEntity ; ExcludeAutIncFields: Boolean): Boolean;
VAR
  Columns : DFE.Interfaces.IIterator<IStormSchemaColumn>;
begin
  Columns := TableSchema.GetColumns();
  if ExcludeAutIncFields then
  begin
    Columns := Columns.Filter(ThisColumnIsPrimaryKeyAndNotAutoIncrement);
  end
  else
  begin
    Columns := Columns.Filter(ThisColumnIsPrimaryKey);
  end;


  Columns := Columns.Filter(TStormEntity(Entity).ThisColumnIsNotAssigned);
  Result := Columns.Count = 0 ;
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

procedure TStormSQLPartition.AddOrderBy;
begin
  AddSQL('ORDER BY');
end;

function TStormSQLPartition.AddParameter(value: variant): string;
begin
  Result := QueryParameters.Add(value);
end;

procedure TStormSQLPartition.AddSQL(const content: string);
begin
  if Not self.Protected_SQL.IsEmpty then
  begin
    self.Protected_SQL := self.Protected_SQL + ' ' + content;
  end
  else
  begin
    self.Protected_SQL := self.Protected_SQL + content;
  end;
end;

procedure TStormSQLPartition.AddUpdate;
begin
  AddSQL('UPDATE ' + self.GetFullTableName + ' SET');
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
    Self.Protected_SQL := Owner.Protected_SQL;
    Self.SelectLimit := Owner.SelectLimit;
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




procedure TStormSQLPartition.RemoveLastSqlCharacter;
begin
  self.Protected_SQL := copy(Protected_SQL,1,length(Protected_SQL)-1);
end;

procedure TStormSQLPartition.ResolveFinalLimit;
begin
  SelectLimit
  .OnSome
  (
    procedure(Limit :  integer)
    begin
      SQLDriver
      .GetFinalLimitSyntax(Limit)
      .OnSome(AddSql);
    end
  )
      
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

procedure TStormFieldsSelection<WhereSelector, Executor>.AddColumn(
  const index: Integer);
begin
   TableSchema.ColumnById(index).Onsome
  (
    procedure(colum : IStormSchemaColumn)
    begin
      Self.AddSQL(TableSchema.GetTableName + '.' + colum.GetColumnName + ',');
    end
  );
end;

procedure TStormFieldsSelection<WhereSelector, Executor>.AddLimit(
  const Limit: Integer);
begin
  Self.SelectLimit := Limit;
  
 
  SQLDriver
  .GetInitialLimitSyntax(Limit)
  .OnSome(AddSql);
end;

function TStormFieldsSelection<WhereSelector, Executor>.AllColumns: IStormWherePoint<WhereSelector>;
begin
  AddSQL('*');
  AddFrom;
  Result := TStormWherePoint<WhereSelector, Executor>.Create(Self);
end;

function TStormFieldsSelection<WhereSelector, Executor>.From: IStormWherePoint<WhereSelector>;
begin
  RemoveLastComma;
  AddFrom;
  Result := TStormWherePoint<WhereSelector, Executor>.Create(self);
end;

{ TStormWherePoint<WhereSelector> }

function TStormWherePoint<WhereSelector, Executor>.Where: WhereSelector;
begin
  AddWhere;
  result := self.GetReturnInstance2<WhereSelector, Executor>();
end;

{ TStormSelectExecutor<EntityType> }

function TStormSelectExecutor<EntityType,OrderSelection>.Open: TResult<IStormSelectSuccess<EntityType>, IStormExecutionFail>;
begin
  ResolveFinalLimit();
  DbSQLConnecton.Clear();
  DbSQLConnecton.SetSQL(Protected_SQL);
  
  DbSQLConnecton.LoadParameters(QueryParameters.Items);
  try
    DbSQLConnecton.Open;
//    if Not DbSQLConnecton.IsEmpty then
//    begin
      result := TStormSelectSuccess<EntityType>.Create(self, DbSQLConnecton.Dataset, Protected_SQL);
//    end
//    else
//    begin
//      Result := TStormExecutionFail.Create(Self, 'No records founded');
//    end;


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
  Dataset: TDataset; SQL : String);
begin
  Self.Dataset := Dataset;
  SElf.SQL := sql;
  inherited create(Owner);

end;

procedure TStormSelectSuccess<EntityType>.Finalize;
begin
  inherited;
  if assigned(Self.Dataset) then
  begin
    Self.Dataset.Free;
  end;


end;

function TStormSelectSuccess<EntityType>.GetDataset: TDataset;
begin
  Result := self.ORM.DbSQLConnecton.CopyDataset(self.Dataset);
end;

function TStormSelectSuccess<EntityType>.GetModel: IStormModel<EntityType>;
begin
  Result := TStormModel<EntityType>.FromDataset(Self.Dataset);
end;

function TStormSelectSuccess<EntityType>.GetSQL: String;
begin
  Result := SQL;
end;

function TStormSelectSuccess<EntityType>.IsEmpty: Boolean;
begin
  Result := Dataset.IsEmpty;
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
  Result := self.Protected_SQL;
end;

procedure TStormFieldsSelection<WhereSelector, Executor>.Initialize;
begin
  inherited;
  AddSQL('SELECT');
end;

procedure TStormFieldsSelection<WhereSelector, Executor>.RemoveLastComma;
begin
  if self.Protected_SQL[Length(self.Protected_SQL)] = ',' then
  begin
    self.Protected_SQL := copy(self.Protected_SQL,1,Length(self.Protected_SQL)-1);
  end;


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
  DbSQLConnecton.Clear();
  DbSQLConnecton.SetSQL(Protected_SQL);
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

  SELF.Protected_SQL := stringreplace(self.Protected_SQL,' ,','',[])

end;

{ TStormInsertExecutor<EntityType> }

constructor TStormInsertExecutor<EntityType>.Create(
  const Owner: TStormSQLPartition; InsertedEntity: EntityType);
begin
 inherited Create(Owner);
 Self.InsertedEntity := InsertedEntity;
end;

function TStormInsertExecutor<EntityType>.Execute: TResult<IStormInsertSuccess<EntityType>, IStormExecutionFail>;
var
  i : integer;
  DS : TDataset;
begin
  DbSQLConnecton.Clear();
  DbSQLConnecton.SetSQL(Protected_SQL);
  DbSQLConnecton.LoadParameters(QueryParameters.Items);
  try



    DbSQLConnecton.Open;
    ds := DbSQLConnecton.Dataset;
    IStormEntity(InsertedEntity).LoadAutoFieldsFromDataset(ds);
    ds.Free;


    result := TStormInsertSuccess<EntityType>.create(self,self.InsertedEntity);


  except
    on e : exception do
    begin
      Result := TStormExecutionFail.Create(Self,e.Message);
    end;
  end;
end;

procedure TStormInsertExecutor<EntityType>.Initialize;
begin
  inherited;
  if self.Protected_SQL.IsEmpty then
  begin
    PrepareSQL();
  end;
end;

procedure TStormInsertExecutor<EntityType>.PrepareSQL;
VAR
  Columns, Values : string;
  Item : TPair<String, String>;
  Output : String;
  InsertedSelect : String;
  column : IStormSchemaColumn;
begin
  Columns := '';
  Values  := '';

  for item in self.ORM.InsertColumnList do
  begin
    Columns := Columns + ', ' + item.Key;
    Values := Values + ', ' + item.Value;
  end;

  Output := '';
  InsertedSelect := '';

  self.ORM.TableSchema
  .GetColumns
  .Filter(ThisColumnIsAutoIncrement).ForEach
  (
    procedure(column : IStormSchemaColumn)
    begin
      SQLDriver.ProccessInsertOutput(Output,column);
      SQLDriver.ProccessInsertSelect(InsertedSelect,column);
    end
  );



  Columns := ' (' + StringReplace(Columns,', ','',[]) + ')';
  Values := ' (' + StringReplace(Values,', ','',[]) + ')';

  if nOT Output.IsEmpty then
  BEGIN
    Output := ' OUTPUT ' + StringReplace(Output,', ','',[]) + ' ';
    AddSQL(SQLDriver.GetIDENTITY_INSERT(self.GetFullTableName));
  END;


  if Not InsertedSelect.IsEmpty then
  begin
    InsertedSelect := InsertedSelect + ' FROM ' + self.GetFullTableName;
    AddSQL(SQLDriver.GetIDENTITY_INSERT(self.GetFullTableName));
  end;

  AddSQL('INSERT INTO ' + self.GetFullTableName + Columns + Output + ' VALUES' + Values + InsertedSelect);
end;

{ TStormInsertSuccess<EntityType> }


{ TStormDeleteSuccess }

constructor TStormDeleteSuccess.Create(Owner: TStormSQLPartition;
  RowsAffected: integer);
begin
  inherited create(Owner);
  self.RowsAffected := RowsAffected;
end;

function TStormDeleteSuccess.RowsDeleted: integer;
begin
  Result := SELF.RowsAffected;
end;

{ TStormDeleteExecutor }

function TStormDeleteExecutor.Execute: TResult<IStormDeleteSuccess, IStormExecutionFail>;
begin
  DbSQLConnecton.Clear();
  DbSQLConnecton.SetSQL(Protected_SQL);
  DbSQLConnecton.LoadParameters(QueryParameters.Items);
  try
    DbSQLConnecton.Execute;

    result := TStormDeleteSuccess.create(self, DbSQLConnecton.RowsAffected);


  except
    on e : exception do
    begin
      Result := TStormExecutionFail.Create(Self,e.Message);
    end;
  end;
end;

procedure TStormDeleteExecutor.Initialize;
begin
  inherited;
  self.Protected_SQL := 'DELETE FROM ' + SELF.GetFullTableName  + ' ' + SELF.Protected_SQL;
end;

{ TDeleteExecutorConstructor }

function TDeleteExecutorConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IStormDeleteExecutor;
begin
  Result := TStormDeleteExecutor.Create(Owner);
end;

function TStormSelectExecutor<EntityType, OrderSelection>.OrderBy: OrderSelection;
begin
  AddOrderBy;
  result := self.GetReturnInstance<OrderSelection>();
end;

{ TStormOrderBySelector<OrderSelection> }

function TStormOrderBySelector<OrderSelection>.ASC: OrderSelection;
begin
  AddSQL(Self.Column.GetColumnName + ' ASC,');
  result := self.GetReturnInstance<OrderSelection>();
end;

constructor TStormOrderBySelector<OrderSelection>.Create(
  const ColumnIndex: Integer; const Owner: TStormSQLPartition);
begin
  Inherited Create(Owner);
  Self.Column := TableSchema.ColumnById(ColumnIndex).GetValueOrDefault(nil);
end;

function TStormOrderBySelector<OrderSelection>.DESC: OrderSelection;
begin
  AddSQL(Self.Column.GetColumnName + ' DESC,');
  result := self.GetReturnInstance<OrderSelection>();
end;

{ TStormInsertSuccess<EntityType> }

constructor TStormInsertSuccess<EntityType>.Create(
  const Owner: TStormSQLPartition; InsertedEntity: EntityType);
begin
  inherited Create(Owner);
  self.InsertedEntity := InsertedEntity;
end;

function TStormInsertSuccess<EntityType>.GetInserted: EntityType;
begin
  Result := InsertedEntity;
end;

end.
