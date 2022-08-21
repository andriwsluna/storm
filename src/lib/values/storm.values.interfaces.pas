unit storm.values.interfaces;

interface

USES
  DFE.Maybe,


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

    Function ToDateTime : Maybe<TDateTime>;
    Function FromDateTime(Value : TDateTime) : Boolean;

    Function ToBool : Maybe<Boolean>;
    Function FromBool(Value : Boolean) : Boolean;

    Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONValue>;
    Function FromJSON(Value : TJSONValue) : Boolean;

    Function Clone(Target : IStormValue) : Boolean;
  end;

  IStringValue = interface(IStormValue)['{77A8492A-EE61-4AEE-A08A-20E3D543CEF0}']
    Function  SetValue(value : String) : Boolean; Overload;
    Function  SetValue(value : Maybe<String>) : Boolean;  Overload;
    Function  GetValue() :  Maybe<String>;
  end;

  IIntegerValue = interface(IStormValue)['{861A5011-84D0-4974-AEC8-8BDAB4E57DFC}']
    Function  SetValue(value : integer) : Boolean; Overload;
    Function  SetValue(value : Maybe<integer>) : Boolean;  Overload;
    Function  GetValue() :  Maybe<integer>;
  end;

  IFloatValue = interface(IStormValue)['{40C2EB6F-A3EF-463D-AF32-6E207791FEA5}']
    Function  SetValue(value : extended) : Boolean;  Overload;
    Function  SetValue(value : Maybe<Extended>) : Boolean; Overload;
    Function  GetValue() :  Maybe<extended>;

  end;

  IBooleanValue = interface(IStormValue)['{7C1C0C8A-0EC6-4C52-BE2D-2543DC8235B7}']
    Function  SetValue(value : boolean) : Boolean; Overload;
    Function  SetValue(value : Maybe<boolean>) : Boolean;  Overload;
    Function  GetValue() :  Maybe<boolean>;
  end;

  IDateTimeValue = interface(IStormValue)['{504443E4-C5EB-4FC5-984E-981C860AFF9E}']
    Function  SetValue(value : TDateTime) : Boolean; Overload;
    Function  SetValue(value : Maybe<TDateTime>) : Boolean;  Overload;
    Function  GetValue() :  Maybe<TDateTime>;
  end;

  IDateValue= interface(IStormValue)['{77BF3829-2915-45F8-BC6D-38627A3ED8B1}']
    Function  SetValue(value : TDate) : Boolean; Overload;
    Function  SetValue(value : Maybe<TDate>) : Boolean;  Overload;
    Function  GetValue() :  Maybe<TDate>;
  end;





implementation

end.
