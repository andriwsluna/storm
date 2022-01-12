unit storm.orm.base;

interface

Uses
  storm.additional.maybe,
  storm.orm.interfaces,

  System.Sysutils, System.Classes;

Type

  TStormSQLPartition = class abstract (TInterfacedObject)
  private
    FSQL : String;
  protected



    Procedure   AddSQL(sql : string);

    Function _GetSQL() : String;
    Function _GetSqlWith(sql  :string) : string;
  public
    Constructor Create(SQL : String = ''); Reintroduce; Virtual;
  end;

  TStormQueryPartition = class abstract (TStormSQLPartition, IStormQueryPartition)
  private

  protected
    Function GetSqlWith(sql  :string) : string;
  public


    Function GetSQL() : String;

  end;

implementation


procedure TStormSQLPartition.AddSQL(sql: string);
begin
  FSQL := FSQL + sql;
end;



constructor TStormSQLPartition.Create(SQL: String);
begin
  inherited create();
  FSQL := SQL;
  _AddRef;
end;


function TStormSQLPartition._GetSQL: String;
begin
  Result := FSQL;
end;

function TStormSQLPartition._GetSqlWith(sql: string): string;
begin
  AddSQL(sql);
  result := FSQL;
end;

{ TStormQueryPartition }


function TStormQueryPartition.GetSQL: String;
begin
  result := _GetSQL;
end;

function TStormQueryPartition.GetSqlWith(sql: string): string;
begin
  result := _GetSqlWith(sql);
end;

end.
