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
    Procedure ProccessInsertOutput(Var OutPutString : String ; column : IStormSchemaColumn);
    Procedure ProccessInsertSelect(Var InmsertedSelect : String ; column : IStormSchemaColumn);
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

procedure TStormMySqlDriver.ProccessInsertOutput(var OutPutString: String;
  column: IStormSchemaColumn);
begin
  //nothing to do
end;

procedure TStormMySqlDriver.ProccessInsertSelect(var InmsertedSelect: String;
  column: IStormSchemaColumn);
begin
  if InmsertedSelect.IsEmpty then
  begin
    InmsertedSelect := ';SELECT ';
  end;

  InmsertedSelect := InmsertedSelect + 'LAST_INSERT_ID() as ' + column.GetColumnName;
end;

end.
