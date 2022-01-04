unit storm.entity.base;

interface

USES
  storm.entity.interfaces,
  storm.values.interfaces,
  storm.fields.interfaces,
  storm.additional.maybe,
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

    Procedure AddStormField(Field : IStormField);
  public

    Constructor Create(); Reintroduce;

    Function StormFields() : TList<IStormField>;
    Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONObject>;
    Function FieldByName(Name : String) : Maybe<IStormField>;

    Function Clone(Target : IStormEntity) : Boolean;
  end;

implementation

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
      Result := Result and Target.FieldByName(field.FieldName).Bind
      (
        function(targetField : IStormField) : Boolean
        begin
          result := field.Clone(targetField);
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
  _AddRef();
  Initialize;
end;

function TStormEntity.FieldByName(Name: String): Maybe<IStormField>;
begin
  if FFieldDictionary.ContainsKey(Name) then
  begin
    Result := FFieldDictionary.Items[Name];
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
