unit storm.orm.base;

interface

Uses
  DAta.DB,
  DFE.Maybe,
  DFE.Result,
  storm.orm.interfaces,
  storm.entity.interfaces,
  storm.model.interfaces,
  storm.model.base,
  DFE.Interfaces,
  storm.data.interfaces,
  storm.orm.query,
  System.Generics.Collections,
  System.Sysutils, System.Classes;

Type

  TStormSQLPartition = class abstract (TInterfacedObject)
  private

    FLimit : Maybe<Integer>;
    Fowner : TStormSQLPartition;
    FSQL : String;
    FParameters : IStormQueryParameters;



  protected
    SQLDriver : IStormSQLDriver;
    Procedure Initialize; Virtual;


    Procedure  AddSQL(sql : string);
    function   AddParameter(value : variant) : string;
    Procedure ProccessLimit();

    Function _GetSQL() : String;
  public
    Constructor Create(owner : TStormSQLPartition = nil); Reintroduce; Virtual;
    Destructor  Destroy(); Override;


  end;



  TStormSelectSuccessExecution<EntityType : IStormEntity> = class(TInterfacedObject, IStormSelectSuccessExecution<EntityType>)
  private
    FData : Tdataset;
  protected

  public
    Constructor Create(dataset : TDataset); Reintroduce;
  public
    Function GetDataset : TDataset;
    Function GetModel : IStormModel<EntityType>;
  end;

  TStormSelectFailExecution = class(TInterfacedObject, IStormSelectFailExecution)
  private
    FErrorMessage : String;
    FSQL : String;
  protected

  public
    Constructor Create(errorMessage : String ; sql : string); Reintroduce;
  public
    Function GetErrorMessage : String;
    Function GetSQL() : String;
  end;

  TStormSelectExecutor<EntityType : IStormEntity> =
  class(TStormSQLPartition, IStormSelectExecutor<EntityType>, IStormSelectExecutorLimited<EntityType>)
  private

  protected

  public
    Function Limit(count : Integer) : IStormSelectExecutorLimited<EntityType>;
    Function GetSQL(callback : TGetSqlCallback) : IStormSelectExecutor<EntityType>;
    Function Open(connection : IStormSQLConnection) : TResult<IStormSelectSuccessExecution<EntityType>,IStormSelectFailExecution>;
  end;


  TStormUpdateSuccessExecution<EntityType : IStormEntity> = class(TInterfacedObject, IStormUpdateSuccessExecution)
  private
    FRowsAffected : integer;
  protected

  public
    Constructor Create(rowscount : integer); Reintroduce;
  public
    Function GetUpdatedRowsCount : integer;
  end;

  TStormUpdateFailExecution = class(TStormSelectFailExecution, IStormUpdateFailExecution)
  private

  end;


  TStormUpdateExecutor<EntityType : IStormEntity> =
  class(TStormSQLPartition, IStormUpdateExecutor<EntityType>)
  private

  protected

  public
    Function GetSQL(callback : TGetSqlCallback) : IStormUpdateExecutor<EntityType>;
    Function Execute(connection : IStormSQLConnection) : TResult<IStormUpdateSuccessExecution,IStormUpdateFailExecution>;
  end;



implementation

Uses
  storm.dependency.register;


function TStormSQLPartition.AddParameter(value: variant): string;
begin
  result := FParameters.Add(value);
end;

procedure TStormSQLPartition.AddSQL(sql: string);
begin
  FSQL := FSQL + sql;
end;



constructor TStormSQLPartition.Create(owner : TStormSQLPartition);
begin
  inherited create();
  Fowner := owner;
  Initialize;
end;


destructor TStormSQLPartition.Destroy;
begin
  if Assigned(Fowner) then
  BEGIN
    if Fowner.FRefCount = 0 then
    begin
      Fowner.Free;
    end;
  END;
  inherited;
end;

procedure TStormSQLPartition.Initialize;
begin
  DependencyRegister.GetSQLDriverInstance.Bind
  (
    procedure(driver : IStormSQLDriver)
    begin
      SQLDriver := driver;
    end,
    procedure()
    begin
      raise Exception.Create('No SQL driver registered');
    end
  );

  if Assigned(Fowner) then
  begin
    FSQL := Fowner.FSQL;
    if assigned(Fowner.FParameters) then
    begin
      FParameters := Fowner.FParameters;
    end
    else
    begin
      FParameters := TStormQueryParameters.Create;
    end;
  end
  else
  begin
    FParameters := TStormQueryParameters.Create;
  end;
end;

procedure TStormSQLPartition.ProccessLimit;
var
  newSql : string;
begin
  newSql := self.FSQL;
  FLimit.OnSome
  (
    procedure(limit : integer)
    begin
      newSql := self.SQLDriver.GetLimitSyntax(limit, newsql);
    end
  );
  FSQL := newSql;
end;

function TStormSQLPartition._GetSQL: String;
begin
  Result := FSQL;
end;



{ TStormQueryExecution }

constructor TStormSelectSuccessExecution<EntityType>.Create(dataset: TDataset);
begin
  inherited create();
  FData := dataset;
end;

function TStormSelectSuccessExecution<EntityType>.GetDataset: TDataset;
begin
  Result := FData;
end;



function TStormSelectSuccessExecution<EntityType>.GetModel: IStormModel<EntityType>;
begin
  Result := TStormModel<EntityType>.FromDataset(FData);
end;

{ TStormSelectExecutor }

function TStormSelectExecutor<EntityType>.Open(connection : IStormSQLConnection): TResult<IStormSelectSuccessExecution<EntityType>,IStormSelectFailExecution>;
var
  return : IStormSelectSuccessExecution<EntityType>;
begin
  connection.SetSQL(_GetSQL);
  connection.LoadParameters(FParameters.Items);
  try
    connection.Open;
    return := TStormSelectSuccessExecution<EntityType>.Create(connection.Dataset);
    result := return;
  except
    on e : exception do
    begin
      Result := TStormSelectFailExecution.Create(e.Message, _GetSQL);
    end;
  end;


end;

function TStormSelectExecutor<EntityType>.Limit(
  count: Integer): IStormSelectExecutorLimited<EntityType>;
begin
  Self.FLimit := count;
  ProccessLimit();
  Result := Self;
end;

function TStormSelectExecutor<EntityType>.GetSQL(callback : TGetSqlCallback) : IStormSelectExecutor<EntityType>;
begin
  if assigned(callback) then
  begin
    callback(_GetSQL);
  end;
  Result := self;
end;

{ TStormSelectFailExecution }

constructor TStormSelectFailExecution.Create(errorMessage: String ; sql : string);
begin
  inherited create();
  FErrorMessage := errorMessage;
  FSQL := sql;
end;

function TStormSelectFailExecution.GetErrorMessage: String;
begin
  Result := FErrorMessage;
end;

function TStormSelectFailExecution.GetSQL: String;
begin
  Result := FSQL;
end;


{ TStormUpdateExecutor<EntityType> }

function TStormUpdateExecutor<EntityType>.Execute(
  connection: IStormSQLConnection): TResult<IStormUpdateSuccessExecution, IStormUpdateFailExecution>;
var
  return : IStormUpdateSuccessExecution;
begin
  connection.SetSQL(_GetSQL);
  connection.LoadParameters(FParameters.Items);
  try
    connection.Execute;

    return := TStormUpdateSuccessExecution<EntityType>.Create(connection.RowsAffected);
    result := return;
  except
    on e : exception do
    begin
      Result := TStormUpdateFailExecution.Create(e.Message, _GetSQL);
    end;
  end;


end;

function TStormUpdateExecutor<EntityType>.GetSQL(
  callback: TGetSqlCallback): IStormUpdateExecutor<EntityType>;
begin
  if assigned(callback) then
  begin
    callback(_GetSQL);
  end;
  Result := self;
end;

{ TStormUpdateSuccessExecution<EntityType> }

constructor TStormUpdateSuccessExecution<EntityType>.Create(rowscount: integer);
begin
  inherited create;
  FRowsAffected := rowscount;
end;

function TStormUpdateSuccessExecution<EntityType>.GetUpdatedRowsCount: integer;
begin
  Result := self.FRowsAffected;
end;

end.
