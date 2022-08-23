unit storm.data.driver.mysql;

interface

Uses
  DFE.Maybe,
  storm.schema.interfaces,
  storm.data.interfaces;

Type
  TStormMySqlDriver = class(TInterfacedObject, storm.data.interfaces.IStormSQLDriver)
  private

  public
    Function GetFullTableName(Table : IStormTableSchema) : string;
    Function GetInitialLimitSyntax(Limit : integer) : Maybe<string>;
    Function GetFinalLimitSyntax(Limit : integer) : Maybe<string>;
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

function TStormMySqlDriver.GetFinalLimitSyntax(Limit: integer): Maybe<string>;
begin
  Result := 'LIMIT ' + Limit.ToString;
end;

function TStormMySqlDriver.GetFullTableName(Table: IStormTableSchema): string;
begin
  Result := Table.GetTableName;
end;


function TStormMySqlDriver.GetInitialLimitSyntax(Limit: integer): Maybe<string>;
begin

end;

end.
