unit storm.data.driver.mssql;

interface

Uses
  DFE.Maybe,
  storm.schema.interfaces,
  storm.data.interfaces;

Type
  TStormMSSQlDriver = class(TInterfacedObject, storm.data.interfaces.IStormSQLDriver)
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

function TStormMSSQlDriver.GetBooleanType: String;
begin
  Result := 'BIT';
end;

function TStormMSSQlDriver.GetFinalLimitSyntax(Limit: integer): Maybe<string>;
begin

end;

function TStormMSSQlDriver.GetFullTableName(Table: IStormTableSchema): string;
begin
  Result := Table.GetSchemaName + '.' + Table.GetTableName;
end;



function TStormMSSQlDriver.GetInitialLimitSyntax(Limit: integer): Maybe<string>;
begin
  Result := 'TOP ' + Limit.ToString;
end;

procedure TStormMSSQlDriver.ProccessInsertOutput(var OutPutString: String;
  column: IStormSchemaColumn);
begin
  OutPutString := OutPutString + ', INSERTED.' + column.GetColumnName;
end;

procedure TStormMSSQlDriver.ProccessInsertSelect(var InmsertedSelect: String;
  column: IStormSchemaColumn);
begin
  //nothing to do
end;

end.
