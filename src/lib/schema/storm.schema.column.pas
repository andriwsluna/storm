unit storm.schema.column;

interface

Uses
  storm.schema.interfaces,

  System.Classes,
  System.Sysutils;

Type
  TEnumColumnAtributes =
  (
    PrimaryKey,
    AutoIncrement,
    NotNull
  );
  TColumnAtributes = Set of TEnumColumnAtributes;
  TStormColumnSchema = Class(TInterfacedObject, IStormSchemaColumn)
  private

  protected
    FColumnName       : String;
    FFieldName        : String;
    FColumnType       : IStormSchemaType;
    FColumnAtributes  : TColumnAtributes;
  public
    Function GetColumnName() : String;
    Function GetFieldName() : String;
    Function GetColumnType() : IStormSchemaType;

    Function IsPrimaryKey() : Boolean;
    Function IsAutoIncrement() : Boolean;
  public
    property ColumnName       : String            read GetColumnName;
    property FieldName        : String            read GetFieldName;
    property ColumnType       : IStormSchemaType  read GetColumnType;
    property ColumnAtributes  : TColumnAtributes  read FColumnAtributes;
  public
    Constructor Create
    (
      ColumnName : string;
      FieldName  : string;
      ColumnType : IStormSchemaType;
      ColumnAtributes : TColumnAtributes
    ); Reintroduce;
  End;

  function ThisColumnIsPrimaryKey(column : IStormSchemaColumn) : boolean;
  function ThisColumnIsPrimaryKeyAndNotAutoIncrement(column : IStormSchemaColumn) : boolean;
  function ThisColumnIsAutoIncrement(column : IStormSchemaColumn) : boolean;

implementation

function ThisColumnIsPrimaryKey(column : IStormSchemaColumn) : boolean;
begin
  Result := column.IsPrimaryKey();
end;

function ThisColumnIsPrimaryKeyAndNotAutoIncrement(column : IStormSchemaColumn) : boolean;
begin
  Result := (column.IsPrimaryKey() and not column.IsAutoIncrement);
end;

function ThisColumnIsAutoIncrement(column : IStormSchemaColumn) : boolean;
begin
  Result := column.IsAutoIncrement;
end;
{ TStormColumnSchema }

constructor TStormColumnSchema.Create(ColumnName, FieldName: string;
  ColumnType: IStormSchemaType; ColumnAtributes : TColumnAtributes);
begin
  inherited Create();
  FColumnName       := ColumnName;
  FFieldName        := FieldName;
  FColumnType       := ColumnType;
  FColumnAtributes  := ColumnAtributes;
end;

function TStormColumnSchema.GetColumnName: String;
begin
  Result := FColumnName;
end;

function TStormColumnSchema.GetColumnType: IStormSchemaType;
begin
  Result := FColumnType;
end;

function TStormColumnSchema.GetFieldName: String;
begin
  Result := FFieldName;
end;

function TStormColumnSchema.IsAutoIncrement: Boolean;
begin
  Result := (AutoIncrement in ColumnAtributes);
end;

function TStormColumnSchema.IsPrimaryKey: Boolean;
begin
  Result := (PrimaryKey in ColumnAtributes);
end;

end.
