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

end.
