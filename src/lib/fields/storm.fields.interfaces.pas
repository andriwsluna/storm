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

  IIntegerField = interface(IStormField)['{C4E48CC3-648C-4097-B8C7-A62311914AA2}']
    Function  Value : IIntegerValue;
    Function  SetValue(value : integer) : Boolean;
    Function  GetValue() :  Maybe<integer>;
    Function  GetValueOrDefault(default : integer = 0) :  integer;
  end;

  IFloatField = interface(IStormField)['{5F749C89-A1C0-4D8C-AF63-ED6458A2DDAB}']
    Function  Value : IFloatValue;
    Function  SetValue(value : Extended) : Boolean;
    Function  GetValue() :  Maybe<Extended>;
    Function  GetValueOrDefault(default : Extended = 0.0) :  Extended;
  end;

  IBooleanField = interface(IStormField)['{561AD79E-FBE4-44E3-8014-3A0485409475}']
    Function  Value : IBooleanValue;
    Function  SetValue(value : Boolean) : Boolean;
    Function  GetValue() :  Maybe<Boolean>;
    Function  GetValueOrDefault(default : Boolean = false) :  Boolean;
  end;

  IDateTimeField = interface(IStormField)['{CE42FA20-4EC6-41BF-A3E7-136C6BD337C0}']
    Function  Value : IDateTimeValue;
    Function  SetValue(value : TDateTime) : Boolean;
    Function  GetValue() :  Maybe<TDateTime>;
    Function  GetValueOrDefault(default : TDateTime = 0) :  TDateTime;
  end;

  IDateField = interface(IStormField)['{0973ADCB-2CFB-49D8-B26D-641E82D0B1EB}']
    Function  Value : IDateValue;
    Function  SetValue(value : TDate) : Boolean;
    Function  GetValue() :  Maybe<TDate>;
    Function  GetValueOrDefault(default : TDate = 0) :  TDate;
  end;

implementation

end.
