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
    Function GetLimitSyntax(Limit : integer ; Sql : string) : string;
    Function GetBooleanType : String;
  end;

implementation
uses
  System.SysUtils,
  System.StrUtils;

{ TStormMySqlDriver }

function TStormMySqlDriver.GetBooleanType: String;
begin
  Result := 'BOOLEAN';
end;

function TStormMySqlDriver.GetFullTableName(Table: IStormTableSchema): string;
begin
  Result := Table.GetTableName;
end;

function TStormMySqlDriver.GetLimitSyntax(Limit: integer; Sql: string): string;
begin
  Result := sql + ' limit ' + IntToStr(Limit);
end;

end.
