unit storm.fields.interfaces;

interface

USES
  storm.values.interfaces,
  storm.additional.maybe,
  System.JSON;

Type
  IStormField = interface['{521BE47A-2192-4786-ACC6-D4B3E79B9DD7}']
    Function IsAssigned() : Boolean;
    Procedure Clear();

    Function JSONName() : String;
    Function FieldName() : String;
    Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONPair>;
    Function FromJSON(Value : TJSONPair) : Boolean;

    Function StormValue() : IStormValue;

    Function Clone(Target : IStormField) : Boolean;
  end;

implementation

end.
