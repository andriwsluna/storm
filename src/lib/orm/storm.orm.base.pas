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
  public
    Constructor Create(Const ORM : TStormORM); Reintroduce; Virtual;
    Destructor Destroy(); Override;
  end;

  TStormSQLPartition= class(TStormChild)
  protected
    Owner : TStormSQLPartition;
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
    Constructor Create(Const ORM : TStormORM ; Const Owner : TStormSQLPartition); Reintroduce; Overload; Virtual;
    Constructor Create(Const Owner : TStormSQLPartition); Reintroduce;Overload; Virtual;
  end;

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

  TStormSelectExecutor = Class(TStormSQLExecutor)
  protected
    Function OpenSQL : TResult<TDataset, String>;
  End;





  TStormORM = Class(TInterfacedObject)
  protected
    TableSchema     : IStormTableSchema;
    DbSQLConnecton  : IStormSQLConnection;
    SQLDriver       : IStormSQLDriver;

     Procedure Initialize; Virtual;
  public
    Constructor Create(Const DbSQLConnecton : IStormSQLConnection ; Const TableSchema : IStormTableSchema);
  End;


implementation

Uses
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
  )

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

procedure TStormSQLPartition.Initialize;
begin
  inherited;
  if Assigned(owner) and assigned(owner.QueryParameters) then
  begin
    self.QueryParameters := owner.QueryParameters;
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

end.
