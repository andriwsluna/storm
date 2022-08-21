unit storm.fields.utils;

interface

uses
  Data.DB,
  storm.fields.interfaces;

Function FieldsIsAssigned(Const Field : IStormField) : Boolean;



Procedure ClearDataField(Const Field : TField);

implementation

Function FieldsIsAssigned(Const Field : IStormField) : Boolean;
begin
  result := Field.IsAssigned;
end;


Procedure ClearDataField(Const Field : TField);
begin
  Field.Clear;
end;

end.
