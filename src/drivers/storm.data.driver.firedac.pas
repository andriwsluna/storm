unit storm.data.driver.firedac;

interface

USES
  System.Generics.Collections,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  Data.DB,
  storm.data.interfaces,
  storm.orm.interfaces;

Type
  TStormFireDacQuery = Class(TInterfacedObject, IStormSQLQuery)
  private

  protected
    FConnection : TFDConnection;
    FQuery : TFDQuery;
  public
    Constructor Create(connection : TFDConnection); Reintroduce;
    Destructor  Destroy(); Override;
  public
    Procedure SetSQL(sql : string);
    Procedure LoadParameters(parameters : TList<IQueryParameter>);
    Function  Execute() : Boolean;
    Function  Open() : Boolean;
    Function  Dataset : Tdataset;
  End;

  TStormFireDacHelper = class helper for TFDConnection
  public
    Function StormDriver() : IStormSQLQuery;
  end;

implementation

{ TStormFireDacQuery }

constructor TStormFireDacQuery.Create(connection : TFDConnection);
begin
  inherited create();
  FConnection := connection;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := connection;
end;

function TStormFireDacQuery.Dataset: Tdataset;
begin
  Result := TFDMemTable.Create(nil);
  TFDMemTable(Result).CopyDataSet(FQuery,[coStructure, coAppend, coRestart]);
end;

destructor TStormFireDacQuery.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function TStormFireDacQuery.Execute: Boolean;
begin
  FQuery.ExecSQL;
  Result := true;
end;

procedure TStormFireDacQuery.LoadParameters(parameters: TList<IQueryParameter>);
VAR
  parameter : IQueryParameter;
begin
  for parameter in Parameters do
  begin
    FQuery.Params.ParamByName(parameter.getParamName).Value := parameter.getValue;
  end;
end;

function TStormFireDacQuery.Open: Boolean;
begin
  FQuery.Open;
  Result := true;
end;

procedure TStormFireDacQuery.SetSQL(sql: string);
begin
  FQuery.SQL.Text := sql;
end;

{ TStormADOHelper }

function TStormFireDacHelper.StormDriver: IStormSQLQuery;
begin
   Result := TStormFireDacQuery.Create(self);
end;

end.
