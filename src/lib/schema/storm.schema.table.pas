unit storm.schema.table;

interface

Uses
  storm.schema.interfaces,
  storm.additional.maybe,
  System.Generics.Collections,
  System.Classes,
  System.Sysutils;

Type
  TStormTableSchema = Class Abstract(TInterfacedObject, IStormTableSchema)
  private
    FColumns : TList<IStormSchemaColumn>;
    FColumnsDictionary : TDictionary<string,IStormSchemaColumn>;
  protected

    FSchemaName : String;
    FTableName  : String;
    FEntityName : String;

    Procedure AddColumn(column : IStormSchemaColumn);
    Procedure Initialize(); Virtual;
  public
    Function GetSchemaName : String;
    Function GetTableName : String;
    Function GetEntityName : String;
  public

    property SchemaName : String read FSchemaName;
    property TableName  : String read FTableName;
    property EntityName : String read GetEntityName;

    Function  GetColumns : TList<IStormSchemaColumn>;

    Function ColumnByName(name : string) : Maybe<IStormSchemaColumn>;
    Function ColumnById(id : integer) : Maybe<IStormSchemaColumn>;


  public
    Constructor Create(SchemaName, TableName,  EntityName : string); Reintroduce; Virtual;

  End;

implementation

{ TStormTableSchema }

procedure TStormTableSchema.AddColumn(column: IStormSchemaColumn);
begin
  FColumns.Add(column);
  FColumnsDictionary.Add(column.GetFieldName, column);
end;

function TStormTableSchema.ColumnById(id: integer): Maybe<IStormSchemaColumn>;
begin
  if Assigned(FColumns.Items[id]) then
  begin
    result := FColumns.Items[id];
  end;
end;

function TStormTableSchema.ColumnByName(
  name: string): Maybe<IStormSchemaColumn>;
begin
  if FColumnsDictionary.ContainsKey(name) then
  begin
    result := FColumnsDictionary.Items[name];
  end;
end;

constructor TStormTableSchema.Create(SchemaName, TableName, EntityName: string);
begin
  inherited Create();
  FSchemaName := SchemaName;
  FTableName  := TableName;
  FEntityName := EntityName;
  Initialize;

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

procedure TStormTableSchema.Initialize;
begin
  FColumns := TList<IStormSchemaColumn>.Create;
  FColumnsDictionary := TDictionary<string,IStormSchemaColumn>.Create();
end;

end.
