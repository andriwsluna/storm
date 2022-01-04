unit storm.fields.base;

interface


USES
  storm.values.interfaces,
  storm.fields.interfaces,
  storm.additional.maybe,
  System.Classes,
  System.JSON,
  System.SysUtils;


Type
  TStormField = Class Abstract(TInterfacedObject)
    private

    protected
      FJSONName : String;
      FStormValue : IStormValue;
      Procedure Initialize();  Virtual;
      Procedure InitializeStormValue(); Virtual; Abstract;

    public


       Constructor Create(name : String); Reintroduce;

      Function  IsAssigned() : Boolean;
      Procedure Clear();
      Function  StormValue() : IStormValue;
      Function JSONName() : String;

      Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONPair>;
      Function FromJSON(Value : TJSONPair) : Boolean;


  End;

implementation

{ TStormField }

procedure TStormField.Clear;
begin
  FStormValue.Clear();
end;



constructor TStormField.Create(name: String);
begin
  inherited Create();
  FJSONName := name;
  _AddRef();
  Initialize();
end;

function TStormField.FromJSON(Value: TJSONPair): Boolean;
begin
  if Value.JsonString.Value = FJSONName then
  begin
    Result := StormValue.FromJSON(Value.JsonValue);
  end
  else
  begin
    result := false;
  end;
end;

procedure TStormField.Initialize;
begin
  InitializeStormValue();
end;

function TStormField.IsAssigned: Boolean;
begin
  Result := FStormValue.IsAssigned();
end;






function TStormField.JSONName: String;
begin
  Result := FJSONName;
end;

function TStormField.StormValue: IStormValue;
begin
  Result := FStormValue;
end;

function TStormField.ToJSON(ConvertNulls: Boolean): Maybe<TJSONPair>;
VAR
  pair : TJSONPair;
begin
  StormValue.ToJSON(ConvertNulls).Map
  (
    procedure(val : TJSONValue)
    begin
      pair := TJSONPair.Create(FJSONName,val);
    end
  );

  if assigned(pair) then
  begin
    result := pair;
  end;
end;

end.
