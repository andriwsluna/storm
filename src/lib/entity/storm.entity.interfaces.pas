unit storm.entity.interfaces;

interface

uses
  System.Classes,
  System.Json,
  System.Generics.Collections,
  storm.fields.interfaces,
  storm.additional.maybe;

Type

  IStormEntity = interface['{19C164F3-5C69-4618-8AA1-37D8DCAE40D0}']
    Function StormFields() : TList<IStormField>;
    Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONObject>;
    Function FieldByName(Name : String) : Maybe<IStormField>;
  end;

implementation

end.
