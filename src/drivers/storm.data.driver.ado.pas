unit storm.data.driver.ado;

interface

USES
  System.Generics.Collections,
  Data.Win.ADODB,
  Data.DB,
  storm.data.interfaces,
  storm.orm.interfaces;

Type
  TStormADOQuery = Class(TInterfacedObject, IStormSQLQuery)
  private

  protected
    FConnection : TADOConnection;
    Fquery : TADOQuery;
  public
    Constructor Create(connection : TADOConnection); Reintroduce;
    Destructor  Destroy(); Override;
  public
    Procedure SetSQL(sql : string);
    Procedure LoadParameters(parameters : TList<IQueryParameter>);
    Function  Execute() : Boolean;
    Function  Open() : Boolean;
    Function  Dataset : Tdataset;
  End;

  TStormADOHelper = class helper for TADOConnection
  public
    Function StormDriver() : IStormSQLQuery;
  end;

implementation

{ TStormADOQuery }

constructor TStormADOQuery.Create(connection : TADOConnection);
begin
  inherited create();
  FConnection := connection;
  Fquery := TADOQuery.Create(nil);
  Fquery.Connection := connection;
end;

function TStormADOQuery.Dataset: Tdataset;
begin
  Result := TADODataSet.Create(nil);
  TADODataSet(Result).Clone(Fquery);
end;

destructor TStormADOQuery.Destroy;
begin
  Fquery.Free;
  inherited;
end;

function TStormADOQuery.Execute: Boolean;
begin
  Fquery.ExecSQL;
  Result := true;
end;

procedure TStormADOQuery.LoadParameters(parameters: TList<IQueryParameter>);
VAR
  parameter : IQueryParameter;
begin
  for parameter in Parameters do
  begin
    Fquery.Parameters.ParamByName(parameter.getParamName).Value := parameter.getValue;
  end;
end;

function TStormADOQuery.Open: Boolean;
begin
  Fquery.Open;
  Result := true;
end;

procedure TStormADOQuery.SetSQL(sql: string);
begin
  Fquery.SQL.Text := sql;
end;

{ TStormADOHelper }

function TStormADOHelper.StormDriver: IStormSQLQuery;
begin
  Result := TStormADOQuery.Create(self);
end;

end.
