unit storm.values.interfaces;

interface

USES
  storm.additional.maybe,


  System.JSON;


Type
  IStormValue = interface['{1B737EFB-BFD4-4752-952A-BEBB76B501B1}']

    Function IsAssigned() : Boolean;
    Procedure Clear();

    Function ToString : Maybe<String>;
    Function FromString(Value : String) : Boolean;

    Function ToInt : Maybe<Integer>;
    Function FromInt(Value : Integer) : Boolean;

    Function ToFloat : Maybe<Extended>;
    Function FromFloat(Value : Extended) : Boolean;

    Function ToBool : Maybe<Boolean>;
    Function FromBool(Value : Boolean) : Boolean;

    Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONValue>;
    Function FromJSON(Value : TJSONValue) : Boolean;
  end;



implementation

end.
