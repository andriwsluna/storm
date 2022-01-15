unit storm.fields.interfaces;

interface

USES
  storm.values.interfaces,
  storm.additional.maybe,
  System.JSON;

Type
  IStormField = interface['{521BE47A-2192-4786-ACC6-D4B3E79B9DD7}']
    Function IsAssigned() : Boolean;
    procedure Clear();

    Function JSONName() : String;
    Function FieldName() : String;
    Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONPair>;
    Function FromJSON(Value : TJSONPair) : Boolean; Overload;
    Function  FromJSON(Value : TJSONObject) : Boolean; Overload;

    Function StormValue() : IStormValue;

    Function Clone(Target : IStormField) : Boolean;
  end;


  IStringField<T> = interface['{58484363-174F-4028-8C39-4E97DEA5D6DC}']
    Function IsAssigned() : Boolean;
    function Clear() : T;

    Function JSONName() : String;
    Function FieldName() : String;
    Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONPair>;
    Function FromJSON(Value : TJSONPair) : Boolean; Overload;
    Function FromJSON(Value : TJSONObject) : Boolean; Overload;

    function Value : IStringValue;

    Function Clone(Target : IStormField) : Boolean;
  end;

implementation

end.
