unit storm.orm.insert;

interface
uses
  storm.orm.interfaces,
  storm.orm.base,
  DFE.Maybe,
  DFE.Result,
  System.Classes,
  System.SysUtils ,
  System.Generics.Collections;

Type
  TStormFieldInsertion<FieldInsertion> = class(TStormColumnSQLPartition)
  public
     Function SetValue(Const Value : variant) : FieldInsertion;
  end;

  TStormStringFieldInsertion<FieldInsertion> = class(TStormFieldInsertion<FieldInsertion>, IStormStringFieldInsertion<FieldInsertion>)
    Function SetValue(Const Value : String) : FieldInsertion; Reintroduce;
  end;


implementation

{ TStormFieldInsertion<FieldInsertion> }

function TStormFieldInsertion<FieldInsertion>.SetValue(
  const Value: variant): FieldInsertion;
begin
  self.ORM.AddInsertField(self.ColumnSchema.GetColumnName, self.AddParameter(Value));
  Result := Self.GetReturnInstance<FieldInsertion>;
end;

{ TStormStringFieldInsertion<FieldInsertion> }

function TStormStringFieldInsertion<FieldInsertion>.SetValue(
  const Value: String): FieldInsertion;
begin
  Result := inherited SetValue(Value);
end;

end.
