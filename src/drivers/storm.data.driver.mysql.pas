unit storm.data.driver.mysql;

interface

Uses
  storm.schema.interfaces,
  storm.data.interfaces;

Type
  TStormMySqlDriver = class(TInterfacedObject, storm.data.interfaces.IStormSQLDriver)
  private

  public
    Function GetFullTableName(Table : IStormTableSchema) : string;
  end;

implementation

{ TStormMySqlDriver }

function TStormMySqlDriver.GetFullTableName(Table: IStormTableSchema): string;
begin
  Result := Table.GetTableName;
end;

end.
