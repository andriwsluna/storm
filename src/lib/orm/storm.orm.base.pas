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
    Procedure Initialize; Override;
    function  AddParameter(value : variant) : string;

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

  TStormGenericColumnSQLPartition<ReturnType> = Class(TStormSqlPartition)
  protected

    ColumnSchema : IStormSchemaColumn;

    Function GetColumnName : String;
    Function GetReturn : ReturnType; Virtual;
  public
    Constructor Create(Owner : TStormSQLPartition ; Const ColumnSchema : IStormSchemaColumn); Reintroduce;
  End;

  TStormGeneric2ColumnSQLPartition<ReturnType, SubReturnType> = Class(TStormGenericColumnSQLPartition<ReturnType>)
  protected

    Function GetReturn : ReturnType; Override;
  public
  End;

  TStormColumnPartition = class(TInterfacedObject)
  protected
    Owner : TStormSQLPartition;
    ColumnSchema : IStormSchemaColumn;

    Function GetColumnName : String;
    Function SQLDriver : IStormSQLDriver;
    Function TableSchema : IStormTableSchema;
    Procedure AddSQL(const  content : string);
    Procedure AddOpenParenthesis();
    Procedure AddCloseParenthesis();
    function  AddParameter(value : variant) : string;
  public
    Constructor Create(Owner : TStormSQLPartition ; Const ColumnSchema : IStormSchemaColumn); Reintroduce;
  end;

  TStormFieldSelection = class(TStormSQLPartition)
  protected
    Procedure Initialize; Override;
    Procedure SelectAll;
    Procedure From;
  end;

  TStormWhere = Class(TStormSQLPartition)
  protected
    Procedure AddWhere();
  End;

  TStormWherePartition = Class(TStormSQLPartition)
  protected

  End;


  TStormSQLExecutor = class(TStormSQLPartition)
  protected
    Function DbSQLConnecton  : IStormSQLConnection;
  end;


  TStormExecutionFail = class(TInterfacedObject)
  protected
    ErrorMessage : string;
    ExecutedCommand : string;
  public
    Constructor Create(Const ErrorMessage : String ; Const ExecutedCommand : string); Reintroduce;
    Function GetErrorMessage()    : String;
    Function GetExecutedCommand() : String;
  end;

  TStormSelectSuccess<EntityType : IStormEntity> = class(TInterfacedObject)
  protected
    Dataset : TDataset;
  public
    Constructor Create(VAR Dataset : TDataset); Reintroduce;
    Function GetDataset : TDataset;
    Function GetModel   : IStormModel<EntityType>;
  end;

  TStormUpdateSuccess = class(TInterfacedObject)
  protected
    RowsAffected : integer;
  public
    Constructor Create(Const RowsAffected : integer); Reintroduce;
    Function GetRowsUpdated : integer;
  end;

  TStormSelectExecutor = Class(TStormSQLExecutor)
  protected
    Function OpenSQL : TResult<TDataset, String>;
  End;

   TStormUpdateExecutor = Class(TStormSQLExecutor)
  protected
    Function ExecuteSQL : TResult<Integer, String>;
  End;

  TStormFieldAssignment = Class(TStormSQLPartition)
  protected
    Procedure Initialize; Override;
    Procedure AddWhere();
  end;



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

{ TStormFieldSelection }

procedure TStormFieldSelection.From;
begin
  AddSQL('FROM ' + SQLDriver.GetFullTableName(TableSchema));
end;

procedure TStormFieldSelection.Initialize;
begin
  inherited;
  AddSQL('SELECT');
end;

procedure TStormFieldSelection.SelectAll;
begin
  AddSQL('*');
  From;
end;



{ TStormWhere }

procedure TStormWhere.AddWhere;
begin
  AddSQL('WHERE');
end;

{ TStormColumnPartition }

procedure TStormColumnPartition.AddCloseParenthesis;
begin
  Self.Owner.AddCloseParenthesis;
end;

procedure TStormColumnPartition.AddOpenParenthesis;
begin
  Self.Owner.AddOpenParenthesis;
end;

function TStormColumnPartition.AddParameter(value: variant): string;
begin
  Result := Self.Owner.AddParameter(value);
end;

procedure TStormColumnPartition.AddSQL(const content: string);
begin
  self.Owner.AddSQL(content);
end;

constructor TStormColumnPartition.Create(Owner: TStormSQLPartition;
  const ColumnSchema: IStormSchemaColumn);
begin
  inherited create();
  if Assigned(Owner) then
  begin
    Self.Owner := Owner;
    if Assigned(ColumnSchema) then
    begin
      Self.ColumnSchema := ColumnSchema;
    end
    else
    begin
      raise Exception.Create('Parameter ColumnSchema must be assigned');
    end;
  end
  else
  begin
    raise Exception.Create('Parameter Owner must be assigned');
  end;
end;

function TStormColumnPartition.GetColumnName: String;
begin
  Result := TableSchema.GetTableName + '.' + ColumnSchema.GetColumnName;
end;

function TStormColumnPartition.SQLDriver: IStormSQLDriver;
begin
  Result := self.Owner.SQLDriver;
end;

function TStormColumnPartition.TableSchema: IStormTableSchema;
begin
  Result := self.Owner.TableSchema;
end;

{ TStormSelectExecutor }

function TStormSelectExecutor.OpenSQL: TResult<TDataset, String>;
begin
  DbSQLConnecton.SetSQL(SQL);
  DbSQLConnecton.LoadParameters(QueryParameters.Items);
  try
    DbSQLConnecton.Open;
    result := DbSQLConnecton.Dataset;
  except
    on e : exception do
    begin
      Result := e.Message;
    end;
  end;
end;

{ TStormSQLExecutor }

function TStormSQLExecutor.DbSQLConnecton: IStormSQLConnection;
begin
  Result := self.ORM.DbSQLConnecton;
end;

{ TStormExecutionFail }

constructor TStormExecutionFail.Create(const ErrorMessage,
  ExecutedCommand: string);
begin
  inherited create();
  self.ErrorMessage := ErrorMessage;
  self.ExecutedCommand := ExecutedCommand;
end;

function TStormExecutionFail.GetErrorMessage: String;
begin
  Result := ErrorMessage;
end;

function TStormExecutionFail.GetExecutedCommand: String;
begin
  Result := ExecutedCommand;
end;

{ TStormSelectSuccess<EntityType> }

constructor TStormSelectSuccess<EntityType>.Create(var Dataset: TDataset);
begin
  inherited create();
  Self.Dataset := Dataset;
end;

function TStormSelectSuccess<EntityType>.GetDataset: TDataset;
begin
  Result := Self.Dataset;
end;

function TStormSelectSuccess<EntityType>.GetModel: IStormModel<EntityType>;
begin
  Result := TStormModel<EntityType>.FromDataset(Dataset);
end;

{ TStormFieldAssignment }

procedure TStormFieldAssignment.AddWhere;
begin
  AddSQL('WHERE');
end;

procedure TStormFieldAssignment.Initialize;
begin
  inherited;
  if self.SQL = '' then
  begin
    AddSQL('UPDATE ' + GetFullTableName + ' SET');
  end;

end;

{ TStormUpdateExecutor }

function TStormUpdateExecutor.ExecuteSQL: TResult<Integer, String>;
begin
  DbSQLConnecton.SetSQL(SQL);
  DbSQLConnecton.LoadParameters(QueryParameters.Items);
  try
    DbSQLConnecton.Execute;

    result := DbSQLConnecton.RowsAffected;


  except
    on e : exception do
    begin
      Result := e.Message;
    end;
  end;
end;

{ TStormUpdateSuccess }

constructor TStormUpdateSuccess.Create(const RowsAffected: integer);
begin
  inherited create();
  Self.RowsAffected := RowsAffected;
end;

function TStormUpdateSuccess.GetRowsUpdated: integer;
begin
   Result := self.RowsAffected;
end;

{ TStormGenericReturn }



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

{ TStormGenericColumnSQLPartition<ReturnType> }

constructor TStormGenericColumnSQLPartition<ReturnType>.Create(
  Owner: TStormSQLPartition; const ColumnSchema: IStormSchemaColumn);
begin
  inherited create(Owner);
  self.ColumnSchema := ColumnSchema;
end;

function TStormGenericColumnSQLPartition<ReturnType>.GetColumnName: String;
begin
  Result := TableSchema.GetTableName + '.' + ColumnSchema.GetColumnName;
end;

function TStormGenericColumnSQLPartition<ReturnType>.GetReturn: ReturnType;
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

{ TStormGeneric2ColumnSQLPartition<ReturnType, SubReturnType> }

function TStormGeneric2ColumnSQLPartition<ReturnType, SubReturnType>.GetReturn: ReturnType;
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

end.
