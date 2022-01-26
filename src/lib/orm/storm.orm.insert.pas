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
VAR
  return : FieldInsertion;
begin
  Value
  .OnSome
  (
    procedure(v : string)
    begin
      return := inherited SetValue(v);
    end
  )
  .OnNone
  (
    procedure()
    begin
      return := self.GetReturn;
    end
  );

  result := Return;


end;

end.
