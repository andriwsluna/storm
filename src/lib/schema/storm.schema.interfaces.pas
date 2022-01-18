unit storm.schema.interfaces;

interface
USES
  DFE.Maybe,
  System.Generics.Collections;

Type
  IStormSchemaType = interface['{5FDDEBC9-874E-4FD3-B3E7-417D7079F283}']
    Function GetType() : String;
  end;

  IStormSchemaColumn = interface['{C0EC3CFF-87A6-4378-8668-8E4507B84F24}']
    Function GetColumnName() : String;
    Function GetFieldName() : String;
    Function GetColumnType() : IStormSchemaType;
    Function IsPrimaryKey() : Boolean;
  end;

  IStormTableSchema = interface['{383E3F0E-7185-425D-AFAA-567585AD36E5}']
    Function GetSchemaName : String;
    Function GetTableName : String;
    Function GetEntityName : String;
    Function GetColumns : TList<IStormSchemaColumn>;
    Function ColumnByName(name : string) : Maybe<IStormSchemaColumn>;
    Function ColumnById(id : integer) : Maybe<IStormSchemaColumn>;
  end;

implementation

end.
