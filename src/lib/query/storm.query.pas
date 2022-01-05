unit storm.query;

interface

USES
  storm.entity.base,
  storm.entity.interfaces,
  storm.schema.interfaces,
  storm.schema.register,

  System.Classes,
  System.Json,
  System.SysUtils;

Type
  TStormEntityClass = Class of TStormEntity;

  TStormPart = class abstract (TInterfacedObject)
  protected
    FSQL : String;
    FClass : TStormEntityClass;
    FSchema : IStormTableSchema;
    Constructor Create(Cls : TStormEntityClass ; Schema : IStormTableSchema ; SQL : String = '');
  end;

  TStormWhereSelection = class(TStormPart)
  public
    Function WherePkIs() : String;
  end;

  TStormFieldSelection = class(TStormPart)
  public
    Function All() : TStormWhereSelection;
    Function Only() : String;
  end;

  TStormQuery = class
  private

  protected

  public
    Function Select(cls : TStormEntityClass) : TStormFieldSelection;
  end;

implementation

{ TStormQuery }

function TStormQuery.Select( cls : TStormEntityClass): TStormFieldSelection;
VAR
  FieldSelection : TStormFieldSelection;
begin
  SchemaRegister.GetSchemaInstance(cls).Bind
  (
    procedure(schema : IStormTableSchema)
    begin
      FieldSelection := TStormFieldSelection.Create(cls, schema);
    end
  );

  if Assigned(FieldSelection) then
  BEGIN
    Result := FieldSelection;
  END
  else
  begin
    result := nil;
    raise Exception.Create('The schema for class ' + cls.ClassName + ' is not registered.');
  end;
end;

{ TStormFieldSelection }



function TStormFieldSelection.All: TStormWhereSelection;
begin
  FSQL := format('select * from [%s].[%s]',[FSchema.GetSchemaName, fSchema.GetTableName]);
  Result := TStormWhereSelection.Create(FClass,FSchema, FSQL)
end;


function TStormFieldSelection.Only: String;
begin

end;

{ TStormPart }

constructor TStormPart.Create(Cls: TStormEntityClass;
  Schema: IStormTableSchema ; SQL : String);
begin
  inherited create();
  FSQL := SQL;
  FClass := Cls;
  FSchema := Schema;
end;

{ TStormWhereSelection }

function TStormWhereSelection.WherePkIs: String;
VAR
  col : IStormSchemaColumn;
begin
  FSQL := FSQL + ' where ';
  for col in FSchema.GetColumns do
  begin
    if col.IsPrimaryKey then
    BEGIN
       FSQL := FSQL + col.GetColumnName + ' = ''1''';
    END;

  end;
  Result := FSQL;
end;

end.
