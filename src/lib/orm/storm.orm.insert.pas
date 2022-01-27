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
  protected
    Function GetReturn : FieldInsertion;
  public
     Function SetValue(Const Value : variant) : FieldInsertion;
  end;

  TStormStringFieldInsertion<FieldInsertion> =
  class
  (
    TStormFieldInsertion<FieldInsertion>,
    IStormStringFieldInsertion<FieldInsertion>,
    IStormStringNullableFieldInsertion<FieldInsertion>
  )
    Function SetValue(Const Value : String) : FieldInsertion; Reintroduce; Overload;
    Function SetValue( Value : Maybe<String>) : FieldInsertion; Reintroduce; Overload;
  end;

  TStormIntegerFieldInsertion<FieldInsertion> =
  class
  (
    TStormFieldInsertion<FieldInsertion>,
    IStormIntegerFieldInsertion<FieldInsertion>,
    IStormIntegerNullableFieldInsertion<FieldInsertion>
  )
    Function SetValue(Const Value : Integer) : FieldInsertion; Reintroduce; Overload;
    Function SetValue( Value : Maybe<Integer>) : FieldInsertion; Reintroduce; Overload;
  end;


implementation

{ TStormFieldInsertion<FieldInsertion> }

function TStormFieldInsertion<FieldInsertion>.GetReturn: FieldInsertion;
begin
  Result := Self.GetReturnInstance<FieldInsertion>;
end;

function TStormFieldInsertion<FieldInsertion>.SetValue(
  const Value: variant): FieldInsertion;
begin
  self.ORM.AddInsertField(self.ColumnSchema.GetColumnName, self.AddParameter(Value));
  Result := self.GetReturn;
end;

{ TStormStringFieldInsertion<FieldInsertion> }

function TStormStringFieldInsertion<FieldInsertion>.SetValue(
  const Value: String): FieldInsertion;
begin
  Result := inherited SetValue(Value);
end;

function TStormStringFieldInsertion<FieldInsertion>.SetValue(
  Value: Maybe<String>): FieldInsertion;
begin

end;

{ TStormIntegerFieldInsertion<FieldInsertion> }

function TStormIntegerFieldInsertion<FieldInsertion>.SetValue(
  Value: Maybe<Integer>): FieldInsertion;
begin
  Value.BindTo<FieldInsertion>(SetValue, GetReturn);
end;

function TStormIntegerFieldInsertion<FieldInsertion>.SetValue(
  const Value: Integer): FieldInsertion;
begin
  Result := inherited SetValue(Value);
end;

end.
