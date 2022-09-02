unit storm.entity.base;

interface

USES
  storm.entity.interfaces,
  storm.values.interfaces,
  storm.fields.interfaces,
  storm.schema.interfaces,
  DFE.Maybe,

  Data.DB,
  System.Classes,
  System.JSON,
  System.Generics.Collections,
  System.SysUtils;


type
  TStormEntity = class(TInterfacedObject, IStormEntity)
  private

  protected
    FTableSchema : IStormTableSchema;
    FFieldList        : TList<IStormField>;
    FFieldDictionary  : TDictionary<String,IStormField>;

    Procedure Initialize();  Virtual;
    Procedure Finalize();  Virtual;

    Procedure AddStormField(Field : IStormField);
  public

    Constructor Create(schema : IStormTableSchema); Reintroduce;
    Destructor  Destroy(); override;

    Function StormFields() : TList<IStormField>;
    Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONObject>;
    Function FieldByName(Name : String) : Maybe<IStormField>;
    Function ThisFieldIsAssigned(Name : String) : Boolean;
    Function ThisColumnIsNotAssigned(SchemaColumn : IStormSchemaColumn) : Boolean;
    Function FromJSON(Value : TJSONObject) : Boolean;
    Function FromDataset(Value : TDataset) : Boolean;
    Function LoadAutoFieldsFromDataset(Value : TDataset) : Boolean;
    Function PopulateDataset(Dataset : TDataset) : Boolean;
    Function Clone( Target : IStormEntity) : Boolean;
  end;


implementation

uses
  storm.schema.column,
  storm.fields.utils;

Function ReturnFalse() : Boolean;
BEGIN
  Result := False;
End;
{ TStormEntity }

procedure TStormEntity.AddStormField(Field: IStormField);
begin
  FFieldDictionary.Add(field.FieldName,Field);
  FFieldList.Add(Field);
end;

function TStormEntity.Clone(Target: IStormEntity): Boolean;
var
  field : IStormField;
begin
  if Assigned(Target) then
  BEGIN
    Result := true;
    for field in FFieldList do
    begin
      Result := Result and Target.FieldByName(field.FieldName).BindTo<Boolean>
      (
        function(targetField : IStormField) : Boolean
        begin
          result := field.Clone(targetField);
        end
        ,
        Function() : Boolean
        begin
          result := false;
        end
      );
    end;
  END
  else
  begin
    Result := False;
  end;
end;

constructor TStormEntity.Create(schema : IStormTableSchema);
begin
  FTableSchema := schema;
  inherited Create();

  Initialize;
end;

destructor TStormEntity.Destroy;
begin
  Finalize;
  inherited;
end;

function TStormEntity.FieldByName(Name: String): Maybe<IStormField>;
begin
  if FFieldDictionary.ContainsKey(Name) then
  begin
    Result := FFieldDictionary.Items[Name];
  end;
end;

procedure TStormEntity.Finalize;
begin
  FFieldList.Free;
  FFieldDictionary.Free;
end;

function TStormEntity.FromDataset(Value: TDataset): Boolean;
var
  field : IStormField;
begin
  if Assigned(Value) then
  BEGIN
    Result := false;
    for field in FFieldList do
    begin
      Result := field.FromDataset(Value) or result;
    end;
  END
  else
  begin
    Result := False;
  end;
end;

function TStormEntity.FromJSON(Value: TJSONObject): Boolean;
var
  field : IStormField;
begin
  if Assigned(Value) then
  BEGIN
    Result := false;
    for field in FFieldList do
    begin
      Result := field.FromJSON(Value) or result;
    end;
  END
  else
  begin
    Result := False;
  end;
end;

procedure TStormEntity.Initialize;
begin
  FFieldList        := TList<IStormField>.Create;
  FFieldDictionary  := TDictionary<String,IStormField>.Create();
end;

function TStormEntity.LoadAutoFieldsFromDataset(Value: TDataset): Boolean;
  var
  field : IStormField;
  return : Boolean;
begin
  return := False;
  if Assigned(Value) then
  BEGIN

    for field in FFieldList do
    begin
      FTableSchema.ColumnByName(field.FieldName)
      .OnSome
      (
        procedure(column : IStormSchemaColumn)
        begin
          if ThisColumnIsAutoIncrement(column) then
          begin
            if not field.IsAssigned then
            begin
              Return := field.FromDataset(Value) or Return;
            end;

          end;
        end
      );



    end;
  END;

  Result := Return;
end;

function TStormEntity.PopulateDataset(Dataset: TDataset): Boolean;
var
  field : IStormField;
begin
  Result := false;
  if Assigned(Dataset) then
  BEGIN
    if Not Dataset.IsEmpty then
    begin
      if Not (Dataset.State = TDataSetState.dsEdit) then
      begin
        Dataset.Edit;
      end;

      for field in FFieldList do
      begin
        Result := field.PopulateDataset(Dataset) or result;
      end;
    end;
  END
end;

function TStormEntity.StormFields: TList<IStormField>;
begin
  Result := FFieldList;
end;

function TStormEntity.ThisColumnIsNotAssigned(
  SchemaColumn: IStormSchemaColumn): Boolean;
begin
  Result := Not ThisFieldIsAssigned(SchemaColumn.GetColumnName);
end;

function TStormEntity.ThisFieldIsAssigned(Name: String): Boolean;
begin
  Result := FieldByName(Name).BindTo<Boolean>(FieldsIsAssigned, ReturnFalse)
end;



function TStormEntity.ToJSON(ConvertNulls: Boolean): Maybe<TJSONObject>;
var
  field : IStormField;
  obj : TJSONObject;
begin
  obj := TJSONObject.Create;

  for field in FFieldList do
  begin
    field.ToJSON(ConvertNulls).Bind
    (
      procedure(pair : TJSONPair)
      begin
        obj.AddPair(pair);
      end
    );
  end;

  if obj.Count > 0 then
  begin
    result := obj;
  end
  else
  begin
    obj.free;
  end;


end;


end.
