unit storm.data.driver.ado;

interface

USES
  System.Generics.Collections,
  Data.Win.ADODB,
  Data.DB,
  storm.data.interfaces,
  storm.orm.interfaces;

Type
  TStormADOConnection = Class(TInterfacedObject, IStormSQLConnection)
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
    Function  RowsAffected: integer;
    Function  CopyDataset(target : tDataset) : TDataset;
    Function  IsEmpty : Boolean;
  End;

  TStormADOHelper = class helper for TADOConnection
  public
    Function StormDriver() : IStormSQLConnection;
  end;

implementation

{ TStormADOConnection }

function TStormADOConnection.CopyDataset(target: tDataset): TDataset;
begin
  Result := TADODataSet.Create(nil);
  TADODataSet(Result).Clone(target as TCustomADODAtaset);
end;

constructor TStormADOConnection.Create(connection : TADOConnection);
begin
  inherited create();
  FConnection := connection;
  Fquery := TADOQuery.Create(nil);
  Fquery.Connection := connection;
end;

function TStormADOConnection.Dataset: Tdataset;
begin
  Result := CopyDataset(Fquery);
end;

destructor TStormADOConnection.Destroy;
begin
  Fquery.Free;
  inherited;
end;

function TStormADOConnection.Execute: Boolean;
begin
  Fquery.ExecSQL;
  Result := true;
end;

function TStormADOConnection.IsEmpty: Boolean;
begin
  Result := Fquery.IsEmpty;
end;

procedure TStormADOConnection.LoadParameters(parameters: TList<IQueryParameter>);
VAR
  parameter : IQueryParameter;
begin
  for parameter in Parameters do
  begin
    Fquery.Parameters.ParamByName(parameter.getParamName).Value := parameter.getValue;
  end;
end;

function TStormADOConnection.Open: Boolean;
begin
  Fquery.Open;
  Result := true;
end;

function TStormADOConnection.RowsAffected: integer;
begin
  Result := Fquery.RowsAffected;
end;

procedure TStormADOConnection.SetSQL(sql: string);
begin
  Fquery.SQL.Text := sql;
end;

{ TStormADOHelper }

function TStormADOHelper.StormDriver: IStormSQLConnection;
begin
  Result := TStormADOConnection.Create(self);
end;

end.
