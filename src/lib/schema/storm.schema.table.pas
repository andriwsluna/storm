unit storm.schema.table;

interface

Uses
  storm.schema.interfaces,

  System.Generics.Collections,
  System.Classes,
  System.Sysutils;

Type
  TStormTableSchema = Class Abstract(TInterfacedObject, IStormTableSchema)
  private
    FColumns : TList<IStormSchemaColumn>;
  protected

    FSchemaName : String;
    FTableName  : String;
    FEntityName : String;

    Procedure AddColumn(column : IStormSchemaColumn);
  public
    Function GetSchemaName : String;
    Function GetTableName : String;
    Function GetEntityName : String;
  public

    property SchemaName : String read FSchemaName;
    property TableName  : String read FTableName;
    property EntityName : String read GetEntityName;

    Function  GetColumns : TList<IStormSchemaColumn>;


  public
    Constructor Create(SchemaName, TableName,  EntityName : string); Reintroduce; Virtual;

  End;

implementation

{ TStormTableSchema }

procedure TStormTableSchema.AddColumn(column: IStormSchemaColumn);
begin
  FColumns.Add(column)
end;

constructor TStormTableSchema.Create(SchemaName, TableName, EntityName: string);
begin
  inherited Create();
  FSchemaName := SchemaName;
  FTableName  := TableName;
  FEntityName := EntityName;

  FColumns := TList<IStormSchemaColumn>.Create;
end;

function TStormTableSchema.GetColumns: TList<IStormSchemaColumn>;
begin
  Result := FColumns;
end;

function TStormTableSchema.GetEntityName: String;
begin
  Result := FEntityName;
end;

function TStormTableSchema.GetSchemaName: String;
begin
  Result := FSchemaName;
end;

function TStormTableSchema.GetTableName: String;
begin
  Result := FTableName;
end;

end.
