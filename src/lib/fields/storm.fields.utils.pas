unit storm.fields.utils;

interface

uses
  storm.fields.interfaces;

Function FieldsIsAssigned(Const Field : IStormField) : Boolean;

implementation

Function FieldsIsAssigned(Const Field : IStormField) : Boolean;
begin
  result := Field.IsAssigned;
end;

end.
