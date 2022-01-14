unit storm.orm.base;

interface

Uses
  DAta.DB,
  storm.additional.maybe,
  storm.orm.interfaces,
  storm.data.interfaces,
  storm.orm.query,
  System.Generics.Collections,
  System.Sysutils, System.Classes;

Type

  TStormSQLPartition = class abstract (TInterfacedObject)
  private

    Fowner : TStormSQLPartition;
    FSQL : String;
    FParameters : IStormQueryParameters;
  protected
    SQLDriver : IStormSQLDriver;
    Procedure Initialize; Virtual;


    Procedure  AddSQL(sql : string);
    function   AddParameter(value : variant) : string;

    Function _GetSQL() : String;
  public
    Constructor Create(owner : TStormSQLPartition = nil); Reintroduce; Virtual;
    Destructor  Destroy(); Override;
  end;

  TStormQuerySuccessExecution = class(TInterfacedObject, IStormQuerySuccessExecution)
  private
    FData : Tdataset;
  protected

  public
    Constructor Create(dataset : TDataset); Reintroduce;
  public
    Function GetDataset : TDataset;
  end;

  TStormQueryFailExecution = class(TInterfacedObject, IStormQueryFailExecution)
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

  TStormQueryExecutor = class(TStormSQLPartition, IStormQueryExecutor)
  private

  protected

  public
    Function GetSQL(callback : TGetSqlCallback) : IStormQueryExecutor;
    Function Open(connection : IStormSQLConnection) : TStormQueryResult;
  end;

  TStormQueryPartition = class abstract (TStormSQLPartition, IStormQueryPartition)
  private
  protected
  public
    Function Go() : IStormQueryExecutor;

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
    )


  end
  else
  begin
    FParameters := TStormQueryParameters.Create;
  end;
end;

function TStormSQLPartition._GetSQL: String;
begin
  Result := FSQL;
end;



{ TStormQueryPartition }



function TStormQueryPartition.Go: IStormQueryExecutor;
begin
  Result := TStormqueryExecutor.Create(self);
end;

{ TStormQueryExecution }

constructor TStormQuerySuccessExecution.Create(dataset: TDataset);
begin
  inherited create();
  FData := dataset;
end;

function TStormQuerySuccessExecution.GetDataset: TDataset;
begin
  Result := FData;
end;

{ TStormQueryExecutor }

function TStormQueryExecutor.Open(connection : IStormSQLConnection): TStormQueryResult;
begin
  connection.SetSQL(_GetSQL);
  connection.LoadParameters(FParameters.Items);
  try
    connection.Open;
    Result := TStormQuerySuccessExecution.Create(connection.Dataset);
  except
    on e : exception do
    begin
      Result := TStormQueryFailExecution.Create(e.Message, _GetSQL);
    end;
  end;


end;

function TStormQueryExecutor.GetSQL(callback : TGetSqlCallback) : IStormQueryExecutor;
begin
  if assigned(callback) then
  begin
    callback(_GetSQL);
  end;
  Result := self;
end;

{ TStormQueryFailExecution }

constructor TStormQueryFailExecution.Create(errorMessage: String ; sql : string);
begin
  inherited create();
  FErrorMessage := errorMessage;
  FSQL := sql;
end;

function TStormQueryFailExecution.GetErrorMessage: String;
begin
  Result := FErrorMessage;
end;

function TStormQueryFailExecution.GetSQL: String;
begin
  Result := FSQL;
end;

end.
