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
    Procedure Initialize; Virtual;


    Procedure  AddSQL(sql : string);
    function   AddParameter(value : variant) : string;

    Function _GetSQL() : String;
  public
    Constructor Create(owner : TStormSQLPartition = nil); Reintroduce; Virtual;
    Destructor  Destroy(); Override;
  end;

  TStormQueryExecution = class(TInterfacedObject, IStormQueryExecution)
  private
    FData : Tdataset;
  protected


  public
    Constructor Create(dataset : TDataset); Reintroduce;
  public
    Function Dataset : TDataset;
  end;

  TStormQueryExecutor = class(TStormSQLPartition, IStormQueryExecutor)
  private

  protected

  public
    Function GetSQL() : String;
    Function Execute(query : IStormSQLQuery) : IStormQueryExecution;
  end;

  TStormQueryPartition = class abstract (TStormSQLPartition, IStormQueryPartition)
  private
  protected
  public
    Function Go() : IStormQueryExecutor;

  end;





implementation


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

constructor TStormQueryExecution.Create(dataset: TDataset);
begin
  inherited create();
  FData := dataset;
end;

function TStormQueryExecution.Dataset: TDataset;
begin
  Result := FData;
end;

{ TStormQueryExecutor }

function TStormQueryExecutor.Execute(query : IStormSQLQuery): IStormQueryExecution;
begin
  query.SetSQL(GetSQL);
  query.LoadParameters(FParameters.Items);
  query.Open;
  Result := TStormQueryExecution.Create(query.Dataset);
end;

function TStormQueryExecutor.GetSQL: String;
begin
  Result := _GetSQL;
end;

end.
