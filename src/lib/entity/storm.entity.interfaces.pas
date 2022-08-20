unit storm.entity.interfaces;

interface

uses
  DFE.Interfaces,
  System.Classes,
  System.Json,
  Data.DB,
  System.Generics.Collections,
  storm.fields.interfaces,
  storm.schema.interfaces,
  DFE.Maybe;

Type

  IStormEntity = interface['{19C164F3-5C69-4618-8AA1-37D8DCAE40D0}']
    Function StormFields() : TList<IStormField>;
    Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONObject>;
    Function FromJSON(Value : TJSONObject) : Boolean;
    Function FromDataset(Value : TDataset) : Boolean;
    Function FieldByName(Name : String) : Maybe<IStormField>;
    Function ThisFieldIsAssigned(Name : String) : Boolean;
    Function PopulateDataset(Dataset : TDataset) : Boolean;

  end;

implementation

end.
