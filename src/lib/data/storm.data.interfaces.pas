unit storm.data.interfaces;

interface

USES
  Data.DB,
  storm.schema.interfaces,
  System.Generics.Collections;



type
  IQueryParameter = interface['{710D25D7-939B-42BD-A446-1445A2832FC8}']
    function getParamName() : string;
    function getPlaceHolderName() : string;
    Function getValue() : variant;
  end;

  IStormSQLConnection = interface['{4464B702-43D2-4D74-B032-1CF1A09DB471}']
    Procedure SetSQL(sql : string);
    Procedure LoadParameters(parameters : TList<IQueryParameter>);
    Function  Execute() : Boolean;
    Function  Open() : Boolean;
    Function  Dataset : Tdataset;
    Function  RowsAffected: integer;
  end;

  IStormSQLDriver = interface['{5FF6388D-A47D-4608-BBE8-5ADB56885E45}']
    Function GetFullTableName(Table : IStormTableSchema) : string;
    Function GetLimitSyntax(Limit : integer ; Sql : string) : string;
  end;


implementation

end.
