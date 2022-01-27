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
    Function GetLimitSyntax(Limit : integer ; Sql : string) : string;
    Function GetBooleanType : String;
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils;

{ TStormMySqlDriver }

function TStormMSSQlDriver.GetBooleanType: String;
begin
  Result := 'BIT';
end;

function TStormMSSQlDriver.GetFullTableName(Table: IStormTableSchema): string;
begin
  Result := Table.GetSchemaName + '.' + Table.GetTableName;
end;

function TStormMSSQlDriver.GetLimitSyntax(Limit: integer; Sql: string): string;
begin
  Result := ReplaceStr(Sql,'select', 'select top ' + IntToStr(Limit));
end;

end.
