unit storm.schema.table;

interface

Uses
  storm.schema.interfaces,
  DFE.Maybe,
  DFE.interfaces,
  System.Generics.Collections,
  System.Classes,
  System.Sysutils;

Type
  TStormTableSchema = Class Abstract(TInterfacedObject, IStormTableSchema)
  private
    FColumns : IIterator<IStormSchemaColumn>;
    FColumnsDictionary : TDictionary<string,IStormSchemaColumn>;
  protected

    FSchemaName : String;
    FTableName  : String;
    FEntityName : String;

    Procedure AddColumn(column : IStormSchemaColumn);
    Procedure Initialize(); Virtual;
    Procedure Finalize(); Virtual;
  public
    Function GetSchemaName : String;
    Function GetTableName : String;
    Function GetEntityName : String;
  public

    property SchemaName : String read FSchemaName;
    property TableName  : String read FTableName;
    property EntityName : String read GetEntityName;

    Function  GetColumns : IIterator<IStormSchemaColumn>;

    Function ColumnByName(name : string) : Maybe<IStormSchemaColumn>;
    Function ColumnById(id : integer) : Maybe<IStormSchemaColumn>;


  public
    Constructor Create(SchemaName, TableName,  EntityName : string); Reintroduce; Virtual;
    Destructor Destroy(); Override;

  End;

implementation

USES
  DFE.Iterator;


{ TStormTableSchema }

procedure TStormTableSchema.AddColumn(column: IStormSchemaColumn);
begin
  FColumns.Add(column);
  FColumnsDictionary.Add(column.GetFieldName, column);
end;

function TStormTableSchema.ColumnById(id: integer): Maybe<IStormSchemaColumn>;
begin
  Result := FColumns.GetItem(id);
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

destructor TStormTableSchema.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TStormTableSchema.Finalize;
begin
  FColumnsDictionary.Free;
end;

function TStormTableSchema.GetColumns: IIterator<IStormSchemaColumn>;
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
  FColumns := TIterator<IStormSchemaColumn>.Create;
  FColumnsDictionary := TDictionary<string,IStormSchemaColumn>.Create();
end;

end.
