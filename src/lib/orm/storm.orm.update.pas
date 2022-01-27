unit storm.orm.update;

interface

uses
  storm.orm.base,
  System.SysUtils,
  DFE.Maybe,
  storm.schema.interfaces,
  storm.orm.interfaces;
Type

  TStormFieldAssignement<FieldAssignment> = Class(TStormColumnSqlPartition)
  protected
    Function GetPrefix() : String;
  public
    Function SetTo(Const Value : variant) : FieldAssignment;
    Function SetNull() : FieldAssignment;

  end;

  TStormStringFieldAssignement<FieldAssignment>
  = Class
  (
    TStormFieldAssignement<FieldAssignment> ,
    IStormStringFieldAssignement<FieldAssignment>,
    IStormStringNullableFieldAssignement<FieldAssignment>
  )
    Function SetTo(Const Value : String) : FieldAssignment; Reintroduce;
    Function SetThisOrNull(const value : Maybe<String>) : FieldAssignment;
  end;

  TStormIntegerFieldAssignement<FieldAssignment>
  = Class
  (
    TStormFieldAssignement<FieldAssignment> ,
    IStormIntegerFieldAssignement<FieldAssignment>,
    IStormIntegerNullableFieldAssignement<FieldAssignment>
  )
    Function SetTo(Const Value : Integer) : FieldAssignment; Reintroduce;
    Function SetThisOrNull(const value : Maybe<Integer>) : FieldAssignment;
  end;

  TStormFloatFieldAssignement<FieldAssignment>
  = Class
  (
    TStormFieldAssignement<FieldAssignment> ,
    IStormFloatFieldAssignement<FieldAssignment>,
    IStormFloatNullableFieldAssignement<FieldAssignment>
  )
    Function SetTo(Const Value : Extended) : FieldAssignment; Reintroduce;
    Function SetThisOrNull(const value : Maybe<Extended>) : FieldAssignment;
  end;

  TStormBooleanFieldAssignement<FieldAssignment>
  = Class
  (
    TStormFieldAssignement<FieldAssignment> ,
    IStormBooleanFieldAssignement<FieldAssignment>,
    IStormBooleanNullableFieldAssignement<FieldAssignment>
  )
    Function SetTo(Const Value : Boolean) : FieldAssignment; Reintroduce;
    Function SetThisOrNull(const value : Maybe<Boolean>) : FieldAssignment;
  end;


  TStormDateFieldAssignement<FieldAssignment>
  = Class
  (
    TStormFieldAssignement<FieldAssignment> ,
    IStormDateFieldAssignement<FieldAssignment>,
    IStormDateNullableFieldAssignement<FieldAssignment>
  )
    Function SetTo(Const Value : TDate) : FieldAssignment; Reintroduce;
    Function SetThisOrNull(const value : Maybe<TDate>) : FieldAssignment;
  end;

  TStormDateTimeFieldAssignement<FieldAssignment>
  = Class
  (
    TStormFieldAssignement<FieldAssignment> ,
    IStormDateTimeFieldAssignement<FieldAssignment>,
    IStormDateTimeNullableFieldAssignement<FieldAssignment>
  )
    Function SetTo(Const Value : TDateTime) : FieldAssignment; Reintroduce;
    Function SetThisOrNull(const value : Maybe<TDateTime>) : FieldAssignment;
  end;

implementation



{ TStormStringFieldAssignement<FieldAssignment> }

function TStormStringFieldAssignement<FieldAssignment>.SetThisOrNull(
  const value: Maybe<String>): FieldAssignment;
begin
  Result := value.BindTo<FieldAssignment>(SetTo,SetNull);
end;

function TStormStringFieldAssignement<FieldAssignment>.SetTo(
  const Value: String): FieldAssignment;
begin
  result := inherited SetTo(Value);
end;

{ TStormFieldAssignement<FieldAssignment> }

function TStormFieldAssignement<FieldAssignment>.GetPrefix: String;
begin
  Result := ', ' + self.GetColumnName;
end;

function TStormFieldAssignement<FieldAssignment>.SetNull: FieldAssignment;
begin
  AddSQL(GetPrefix + ' = NULL');
  Result := self.GetReturnInstance<FieldAssignment>();
end;

function TStormFieldAssignement<FieldAssignment>.SetTo(
  const Value: variant): FieldAssignment;
begin
  AddSQL(GetPrefix + ' = ' + self.AddParameter(Value));
  Result := self.GetReturnInstance<FieldAssignment>();
end;

{ TStormIntegerFieldAssignement<FieldAssignment> }

function TStormIntegerFieldAssignement<FieldAssignment>.SetThisOrNull(
  const value: Maybe<Integer>): FieldAssignment;
begin
  Result := value.BindTo<FieldAssignment>(SetTo,SetNull);
end;

function TStormIntegerFieldAssignement<FieldAssignment>.SetTo(
  const Value: Integer): FieldAssignment;
begin
     Result := inherited SetTo(Value);
end;

{ TStormFloatFieldAssignement<FieldAssignment> }

function TStormFloatFieldAssignement<FieldAssignment>.SetThisOrNull(
  const value: Maybe<Extended>): FieldAssignment;
begin
  Result := value.BindTo<FieldAssignment>(SetTo,SetNull);
end;

function TStormFloatFieldAssignement<FieldAssignment>.SetTo(
  const Value: Extended): FieldAssignment;
begin
     Result := inherited SetTo(Value);
end;

{ TStormBooleanFieldAssignement<FieldAssignment> }

function TStormBooleanFieldAssignement<FieldAssignment>.SetThisOrNull(
  const value: Maybe<Boolean>): FieldAssignment;
begin
  Result := value.BindTo<FieldAssignment>(SetTo,SetNull);
end;

function TStormBooleanFieldAssignement<FieldAssignment>.SetTo(
  const Value: Boolean): FieldAssignment;
begin
     Result := inherited SetTo(Value);
end;

{ TStormDateFieldAssignement<FieldAssignment> }

function TStormDateFieldAssignement<FieldAssignment>.SetThisOrNull(
  const value: Maybe<TDate>): FieldAssignment;
begin
  Result := value.BindTo<FieldAssignment>(SetTo,SetNull);
end;

function TStormDateFieldAssignement<FieldAssignment>.SetTo(
  const Value: TDate): FieldAssignment;
begin
     Result := inherited SetTo(TDateTime(Value));
end;


{ TStormDateTimeFieldAssignement<FieldAssignment> }

function TStormDateTimeFieldAssignement<FieldAssignment>.SetThisOrNull(
  const value: Maybe<TDateTime>): FieldAssignment;
begin
  Result := value.BindTo<FieldAssignment>(SetTo,SetNull);
end;

function TStormDateTimeFieldAssignement<FieldAssignment>.SetTo(
  const Value: TDateTime): FieldAssignment;
begin
     Result := inherited SetTo(Value);
end;

end.
