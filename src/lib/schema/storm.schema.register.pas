unit storm.schema.register;

interface

USES
  storm.entity.base,
  storm.schema.interfaces,
  storm.entity.interfaces,
  storm.additional.maybe,
  System.Generics.Collections,
  System.Classes,
  System.Sysutils;



Type
  TSchemaRegister = class(TObject)

  private
    FRegisteredSchemas : TDictionary<TClass,IStormTableSchema>;

    Constructor Create(); Reintroduce;
    Destructor Destroy(); Override;
  protected

  public
    Function RegisterSchema(entityClas : TClass ; schemaInstance : IStormTableSchema) : Boolean;
    Function GetSchemaInstance(entityClas : TClass) : Maybe<IStormTableSchema>;

  public
    Class Procedure Initialize();
    Class Procedure Finalize();
    Class Function  GetInstance() : TSchemaRegister;




  end;

VAR
  SchemaRegister : TSchemaRegister;

Function RegisterSchema(entityClas : TClass ; schemaInstance : IStormTableSchema) : Boolean;
Function GetSchemaInstance(entityClas : TClass) : Maybe<IStormTableSchema>;

implementation

Function RegisterSchema(entityClas : TClass ; schemaInstance : IStormTableSchema) : Boolean;
Begin
  Result := SchemaRegister.RegisterSchema(entityClas, schemaInstance);
End;
Function GetSchemaInstance(entityClas : TClass) : Maybe<IStormTableSchema>;
begin
  result := SchemaRegister.GetSchemaInstance(entityClas);
end;

{ TSchemaRegister }

constructor TSchemaRegister.Create;
begin
  inherited;
  FRegisteredSchemas := TDictionary<TClass,IStormTableSchema>.Create();
end;

destructor TSchemaRegister.Destroy;
begin
  FRegisteredSchemas.Free;
  inherited;
end;

class procedure TSchemaRegister.Finalize;
begin
  if Assigned(SchemaRegister) then
  begin
    SchemaRegister.Free;
  end;
end;

class function TSchemaRegister.GetInstance: TSchemaRegister;
begin
  Initialize;
  Result := SchemaRegister;
end;

function TSchemaRegister.GetSchemaInstance(
  entityClas: TClass): Maybe<IStormTableSchema>;
begin
  if FRegisteredSchemas.ContainsKey(entityClas) then
  begin
    Result := FRegisteredSchemas.Items[entityClas];
  end;
end;


class procedure TSchemaRegister.Initialize;
begin
  if Not Assigned(SchemaRegister) then
  begin
    SchemaRegister := TSchemaRegister.Create;
  end;
end;

function TSchemaRegister.RegisterSchema(entityClas: TClass;
  schemaInstance: IStormTableSchema): Boolean;
begin
  if Supports(entityClas, IStormEntity)then
  begin
    FRegisteredSchemas.Add(entityClas, schemaInstance);
    Result := true;
  end
  else
  begin
    result := false;
  end;
end;

//INITIALIZATION
//  TSchemaRegister.Initialize();
//
//FINALIZATION
//  TSchemaRegister.Finalize();

end.
