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

  TStormFloatFieldInsertion<FieldInsertion> =
  class
  (
    TStormFieldInsertion<FieldInsertion>,
    IStormFloatFieldInsertion<FieldInsertion>,
    IStormFloatNullableFieldInsertion<FieldInsertion>
  )
    Function SetValue(Const Value : Extended) : FieldInsertion; Reintroduce; Overload;
    Function SetValue( Value : Maybe<Extended>) : FieldInsertion; Reintroduce; Overload;
  end;

  TStormBooleanFieldInsertion<FieldInsertion> =
  class
  (
    TStormFieldInsertion<FieldInsertion>,
    IStormBooleanFieldInsertion<FieldInsertion>,
    IStormBooleanNullableFieldInsertion<FieldInsertion>
  )
    Function SetValue(Const Value : Boolean) : FieldInsertion; Reintroduce; Overload;
    Function SetValue( Value : Maybe<Boolean>) : FieldInsertion; Reintroduce; Overload;
  end;

  TStormDateFieldInsertion<FieldInsertion> =
  class
  (
    TStormFieldInsertion<FieldInsertion>,
    IStormDateFieldInsertion<FieldInsertion>,
    IStormDateNullableFieldInsertion<FieldInsertion>
  )
    Function SetValue(Const Value : TDate) : FieldInsertion; Reintroduce; Overload;
    Function SetValue( Value : Maybe<TDate>) : FieldInsertion; Reintroduce; Overload;
  end;

  TStormDateTimeFieldInsertion<FieldInsertion> =
  class
  (
    TStormFieldInsertion<FieldInsertion>,
    IStormDateTimeFieldInsertion<FieldInsertion>,
    IStormDateTimeNullableFieldInsertion<FieldInsertion>
  )
    Function SetValue(Const Value : TDateTime) : FieldInsertion; Reintroduce; Overload;
    Function SetValue( Value : Maybe<TDateTime>) : FieldInsertion; Reintroduce; Overload;
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
  Result := Value.BindTo<FieldInsertion>(SetValue, GetReturn);
end;

{ TStormIntegerFieldInsertion<FieldInsertion> }

function TStormIntegerFieldInsertion<FieldInsertion>.SetValue(
  Value: Maybe<Integer>): FieldInsertion;
begin
  Result := Value.BindTo<FieldInsertion>(SetValue, GetReturn);
end;

function TStormIntegerFieldInsertion<FieldInsertion>.SetValue(
  const Value: Integer): FieldInsertion;
begin
  Result := inherited SetValue(Value);
end;


{ TStormFloatFieldInsertion<FieldInsertion> }

function TStormFloatFieldInsertion<FieldInsertion>.SetValue(
  Value: Maybe<Extended>): FieldInsertion;
begin
  Result := Value.BindTo<FieldInsertion>(SetValue, GetReturn);
end;

function TStormFloatFieldInsertion<FieldInsertion>.SetValue(
  const Value: Extended): FieldInsertion;
begin
  Result := inherited SetValue(Value);
end;

{ TStormBooleanFieldInsertion<FieldInsertion> }

function TStormBooleanFieldInsertion<FieldInsertion>.SetValue(
  Value: Maybe<Boolean>): FieldInsertion;
begin
  Result := Value.BindTo<FieldInsertion>(SetValue, GetReturn);
end;

function TStormBooleanFieldInsertion<FieldInsertion>.SetValue(
  const Value: Boolean): FieldInsertion;
begin
  Result := inherited SetValue(Value);
end;

{ TStormDateFieldInsertion<FieldInsertion> }

function TStormDateFieldInsertion<FieldInsertion>.SetValue(
  Value: Maybe<TDate>): FieldInsertion;
begin
  Result := Value.BindTo<FieldInsertion>(SetValue, GetReturn);
end;

function TStormDateFieldInsertion<FieldInsertion>.SetValue(
  const Value: TDate): FieldInsertion;
begin
  Result := inherited SetValue(Value);
end;

{ TStormDateTimeFieldInsertion<FieldInsertion> }

function TStormDateTimeFieldInsertion<FieldInsertion>.SetValue(
  Value: Maybe<TDateTime>): FieldInsertion;
begin
  Result := Value.BindTo<FieldInsertion>(SetValue, GetReturn);
end;

function TStormDateTimeFieldInsertion<FieldInsertion>.SetValue(
  const Value: TDateTime): FieldInsertion;
begin
  Result := inherited SetValue(Value);
end;


end.
