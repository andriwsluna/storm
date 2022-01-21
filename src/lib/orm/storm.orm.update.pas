unit storm.orm.update;

interface

uses
  storm.orm.base,
  storm.schema.interfaces,
  storm.orm.interfaces;

type
  TStormColumnUpdater = class abstract(TStormSqlPartition)
  protected
    FTable : IStormTableSchema;
    FColumn : IStormSchemaColumn;
     Function GetColumnName : string;
  public
    Constructor create
    (
      owner : TStormSQLPartition;
      Table : IStormTableSchema ;
      column : IStormSchemaColumn
    ); Reintroduce; Virtual;
  end;
  TStormStringUpdater<UpdaterType : TStormSQLPartition> = class(TStormColumnUpdater, IStormStringUpdater<UpdaterType>)
  public
    Function SetTo(value : string) : UpdaterType;
  end;

implementation

{ TStormStringUpdater<UpdaterType> }

function TStormStringUpdater<UpdaterType>.SetTo(value: string): UpdaterType;
begin
  AddSQL(GetColumnName + ' = ' + AddParameter(value));
  Result := UpdaterType.Create(Self);
end;

{ TStormColumnUpdater }

constructor TStormColumnUpdater.create(owner: TStormSQLPartition;
  Table: IStormTableSchema; column: IStormSchemaColumn);
begin
  inherited create(owner);
  Self.FTable := table;
  self.FColumn := column;
end;

function TStormColumnUpdater.GetColumnName: string;
begin
  Result := FTable.GetTableName + '.' + FColumn.GetColumnName;
end;

end.
