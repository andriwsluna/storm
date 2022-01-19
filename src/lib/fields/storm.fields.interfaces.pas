unit storm.fields.interfaces;

interface

USES
  Data.DB,
  storm.values.interfaces,
  DFE.Maybe,
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
    Function  FromDataField(field : TField) : boolean;
    Function  FromDataset(dataset : TDataset) : boolean;

    Function StormValue() : IStormValue;

    Function Clone(Target : IStormField) : Boolean;
  end;


  IStringField = interface(IStormField)['{58484363-174F-4028-8C39-4E97DEA5D6DC}']

    Function  Value : IStringValue;
    Function  SetValue(value : String) : Boolean;
    Function  GetValue() :  Maybe<String>;
    Function  GetValueOrDefault(default : string = '') :  string;
  end;

implementation

end.
