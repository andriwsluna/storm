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
    FFieldList        : TList<IStormField>;
    FFieldDictionary  : TDictionary<String,IStormField>;

    Procedure Initialize();  Virtual;
    Procedure Finalize();  Virtual;

    Procedure AddStormField(Field : IStormField);
  public

    Constructor Create(); Reintroduce;
    Destructor  Destroy(); override;

    Function StormFields() : TList<IStormField>;
    Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONObject>;
    Function FieldByName(Name : String) : Maybe<IStormField>;
    Function ThisFieldIsAssigned(Name : String) : Boolean;
    Function ThisColumnIsNotAssigned(SchemaColumn : IStormSchemaColumn) : Boolean;
    Function FromJSON(Value : TJSONObject) : Boolean;
    Function FromDataset(Value : TDataset) : Boolean;
    Function Clone( Target : IStormEntity) : Boolean;
  end;


implementation

uses
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

constructor TStormEntity.Create;
begin
  inherited;
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
