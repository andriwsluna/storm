unit storm.data.driver.mssql;

interface

Uses
  storm.schema.interfaces,
  storm.data.interfaces;

Type
  TStormMSSQlDriver = class(TInterfacedObject, storm.data.interfaces.IStormSQLDriver)
  private

  public
    Function GetFullTableName(Table : IStormTableSchema) : string;
  end;

implementation

{ TStormMySqlDriver }

function TStormMSSQlDriver.GetFullTableName(Table: IStormTableSchema): string;
begin
  Result := Table.GetSchemaName + '.' + Table.GetTableName;
end;

end.
