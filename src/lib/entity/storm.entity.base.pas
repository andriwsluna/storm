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
  end;

implementation

{ TStormEntity }

procedure TStormEntity.AddStormField(Field: IStormField);
begin
  FFieldDictionary.Add(field.JSONName,Field);
  FFieldList.Add(Field);
end;

constructor TStormEntity.Create;
begin
  inherited;
  Initialize;
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
    field.ToJSON(ConvertNulls).Map
    (
      procedure(pair : TJSONPair)
      begin
        obj.AddPair(pair);
      end
    );
  end;

  result := obj;
end;

end.
