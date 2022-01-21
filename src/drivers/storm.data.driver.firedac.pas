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
  TStormFireDACConnection = Class(TInterfacedObject, IStormSQLConnection)
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
    Function  RowsAffected: integer;
  End;

  TStormFireDacHelper = class helper for TFDConnection
  public
    Function StormDriver() : IStormSQLConnection;
  end;

implementation

USES
  FireDAC.Stan.Param;

{ TStormFireDACConnection }

constructor TStormFireDACConnection.Create(connection : TFDConnection);
begin
  inherited create();
  FConnection := connection;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := connection;
end;

function TStormFireDACConnection.Dataset: Tdataset;
begin
  Result := TFDMemTable.Create(nil);
  TFDMemTable(Result).CopyDataSet(FQuery,[coStructure, coAppend, coRestart]);
end;

destructor TStormFireDACConnection.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function TStormFireDACConnection.Execute: Boolean;
begin
  FQuery.ExecSQL;
  Result := true;
end;

procedure TStormFireDACConnection.LoadParameters(parameters: TList<IQueryParameter>);
VAR
  parameter : IQueryParameter;
begin
  for parameter in Parameters do
  begin
    FQuery.Params.ParamByName(parameter.getParamName).Value := parameter.getValue;
  end;
end;

function TStormFireDACConnection.Open: Boolean;
begin
  FQuery.Open;
  Result := true;
end;

function TStormFireDACConnection.RowsAffected: integer;
begin
  Result := FQuery.RowsAffected;
end;

procedure TStormFireDACConnection.SetSQL(sql: string);
begin
  FQuery.SQL.Text := sql;
end;

{ TStormADOHelper }

function TStormFireDacHelper.StormDriver: IStormSQLConnection;
begin
   Result := TStormFireDACConnection.Create(self);
end;

end.
