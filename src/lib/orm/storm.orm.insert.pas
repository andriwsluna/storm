unit storm.orm.insert;

interface
uses
  storm.orm.interfaces,
  storm.orm.base,
  storm.schema.interfaces,
  DFE.Maybe,
  DFE.Result,
  System.Classes,
  System.SysUtils ,
  System.Generics.Collections;

Type

  TSetStringValueEvent = function(value : Maybe<String>) : Boolean of object;
  TSetIntegerValueEvent = function(value : Maybe<Integer>) : Boolean of object;
  TSetFloatValueEvent = function(value : Maybe<Extended>) : Boolean of object;
  TSetBooleanValueEvent = function(value : Maybe<Boolean>) : Boolean of object;
  TSetDateValueEvent = function(value : Maybe<TDate>) : Boolean of object;
  TSetDateTimeValueEvent = function(value : Maybe<TDateTime>) : Boolean of object;

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
  protected
    FOnSetValue : TSetStringValueEvent;

    Procedure CallBack(Value : Maybe<String>);
  public
    Function SetValue(Const Value : String) : FieldInsertion; Reintroduce; Overload;
    Function SetValue( Value : Maybe<String>) : FieldInsertion; Reintroduce; Overload;

    Constructor Create
    (
      Owner : TStormSQLPartition ;
      Const ColumnSchema : IStormSchemaColumn;
      Const OnSetValue : TSetStringValueEvent
    ); Reintroduce;
  end;

  TStormIntegerFieldInsertion<FieldInsertion> =
  class
  (
    TStormFieldInsertion<FieldInsertion>,
    IStormIntegerFieldInsertion<FieldInsertion>,
    IStormIntegerNullableFieldInsertion<FieldInsertion>
  )
  private
    FOnSetValue : TSetIntegerValueEvent;

    Procedure CallBack(Value : Maybe<Integer>);
  public
    Function SetValue(Const Value : Integer) : FieldInsertion; Reintroduce; Overload;
    Function SetValue( Value : Maybe<Integer>) : FieldInsertion; Reintroduce; Overload;

    Constructor Create
    (
      Owner : TStormSQLPartition ;
      Const ColumnSchema : IStormSchemaColumn;
      Const OnSetValue : TSetIntegerValueEvent
    ); Reintroduce;
  end;

  TStormFloatFieldInsertion<FieldInsertion> =
  class
  (
    TStormFieldInsertion<FieldInsertion>,
    IStormFloatFieldInsertion<FieldInsertion>,
    IStormFloatNullableFieldInsertion<FieldInsertion>
  )
  private
    FOnSetValue : TSetFloatValueEvent;
    Procedure CallBack(Value : Maybe<Extended>);
  public
    Function SetValue(Const Value : Extended) : FieldInsertion; Reintroduce; Overload;
    Function SetValue( Value : Maybe<Extended>) : FieldInsertion; Reintroduce; Overload;

    Constructor Create
    (
      Owner : TStormSQLPartition ;
      Const ColumnSchema : IStormSchemaColumn;
      Const OnSetValue : TSetFloatValueEvent
    ); Reintroduce;
  end;

  TStormBooleanFieldInsertion<FieldInsertion> =
  class
  (
    TStormFieldInsertion<FieldInsertion>,
    IStormBooleanFieldInsertion<FieldInsertion>,
    IStormBooleanNullableFieldInsertion<FieldInsertion>
  )
  private
    FOnSetValue : TSetBooleanValueEvent;
    Procedure CallBack(Value : Maybe<Boolean>);
  public
    Function SetValue(Const Value : Boolean) : FieldInsertion; Reintroduce; Overload;
    Function SetValue( Value : Maybe<Boolean>) : FieldInsertion; Reintroduce; Overload;

    Constructor Create
    (
      Owner : TStormSQLPartition ;
      Const ColumnSchema : IStormSchemaColumn;
      Const OnSetValue : TSetBooleanValueEvent
    ); Reintroduce;
  end;

  TStormDateFieldInsertion<FieldInsertion> =
  class
  (
    TStormFieldInsertion<FieldInsertion>,
    IStormDateFieldInsertion<FieldInsertion>,
    IStormDateNullableFieldInsertion<FieldInsertion>
  )
  private
    FOnSetValue : TSetDateValueEvent;
    Procedure CallBack(Value : Maybe<TDate>);
  public
    Function SetValue(Const Value : TDate) : FieldInsertion; Reintroduce; Overload;
    Function SetValue( Value : Maybe<TDate>) : FieldInsertion; Reintroduce; Overload;
    Constructor Create
    (
      Owner : TStormSQLPartition ;
      Const ColumnSchema : IStormSchemaColumn;
      Const OnSetValue : TSetDateValueEvent
    ); Reintroduce;
  end;

  TStormDateTimeFieldInsertion<FieldInsertion> =
  class
  (
    TStormFieldInsertion<FieldInsertion>,
    IStormDateTimeFieldInsertion<FieldInsertion>,
    IStormDateTimeNullableFieldInsertion<FieldInsertion>
  )
  private
    FOnSetValue : TSetDateTimeValueEvent;
    Procedure CallBack(Value : Maybe<TDateTime>);
  public
    Function SetValue(Const Value : TDateTime) : FieldInsertion; Reintroduce; Overload;
    Function SetValue( Value : Maybe<TDateTime>) : FieldInsertion; Reintroduce; Overload;
    Constructor Create
    (
      Owner : TStormSQLPartition ;
      Const ColumnSchema : IStormSchemaColumn;
      Const OnSetValue : TSetDateTimeValueEvent
    ); Reintroduce;
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
  CallBack(Value);
end;

procedure TStormStringFieldInsertion<FieldInsertion>.CallBack(Value : Maybe<String>);
begin
  if Assigned(FOnSetValue) then
  begin
    FOnSetValue(Value);
  end;
end;

constructor TStormStringFieldInsertion<FieldInsertion>.Create(
  Owner: TStormSQLPartition; const ColumnSchema: IStormSchemaColumn;
  const OnSetValue: TSetStringValueEvent);
begin
  inherited Create(Owner,ColumnSchema);
  FOnSetValue := OnSetValue;
end;

function TStormStringFieldInsertion<FieldInsertion>.SetValue(
  Value: Maybe<String>): FieldInsertion;
begin
  Result := Value.BindTo<FieldInsertion>(SetValue, GetReturn);
end;

{ TStormIntegerFieldInsertion<FieldInsertion> }

procedure TStormIntegerFieldInsertion<FieldInsertion>.CallBack(
  Value: Maybe<Integer>);
begin
  if Assigned(FOnSetValue) then
  begin
    FOnSetValue(Value);
  end;
end;

constructor TStormIntegerFieldInsertion<FieldInsertion>.Create(
  Owner: TStormSQLPartition; const ColumnSchema: IStormSchemaColumn;
  const OnSetValue: TSetIntegerValueEvent);
begin
  inherited Create(Owner,ColumnSchema);
  FOnSetValue := OnSetValue;
end;

function TStormIntegerFieldInsertion<FieldInsertion>.SetValue(
  Value: Maybe<Integer>): FieldInsertion;
begin
  Result := Value.BindTo<FieldInsertion>(SetValue, GetReturn);
end;

function TStormIntegerFieldInsertion<FieldInsertion>.SetValue(
  const Value: Integer): FieldInsertion;
begin
  Result := inherited SetValue(Value);
  CallBack(Value);
end;


{ TStormFloatFieldInsertion<FieldInsertion> }

procedure TStormFloatFieldInsertion<FieldInsertion>.CallBack(
  Value: Maybe<Extended>);
begin
  if Assigned(FOnSetValue) then
  begin
    FOnSetValue(Value);
  end;
end;

constructor TStormFloatFieldInsertion<FieldInsertion>.Create(
  Owner: TStormSQLPartition; const ColumnSchema: IStormSchemaColumn;
  const OnSetValue: TSetFloatValueEvent);
begin
  inherited Create(Owner,ColumnSchema);
  FOnSetValue := OnSetValue;
end;

function TStormFloatFieldInsertion<FieldInsertion>.SetValue(
  Value: Maybe<Extended>): FieldInsertion;
begin
  Result := Value.BindTo<FieldInsertion>(SetValue, GetReturn);
end;

function TStormFloatFieldInsertion<FieldInsertion>.SetValue(
  const Value: Extended): FieldInsertion;
begin
  Result := inherited SetValue(Value);
  CallBack(Value);
end;

{ TStormBooleanFieldInsertion<FieldInsertion> }

procedure TStormBooleanFieldInsertion<FieldInsertion>.CallBack(
  Value: Maybe<Boolean>);
begin
  if Assigned(FOnSetValue) then
  begin
    FOnSetValue(Value);
  end;
end;

constructor TStormBooleanFieldInsertion<FieldInsertion>.Create(
  Owner: TStormSQLPartition; const ColumnSchema: IStormSchemaColumn;
  const OnSetValue: TSetBooleanValueEvent);
begin
  inherited Create(Owner,ColumnSchema);
  FOnSetValue := OnSetValue;
end;

function TStormBooleanFieldInsertion<FieldInsertion>.SetValue(
  Value: Maybe<Boolean>): FieldInsertion;
begin
  Result := Value.BindTo<FieldInsertion>(SetValue, GetReturn);
end;

function TStormBooleanFieldInsertion<FieldInsertion>.SetValue(
  const Value: Boolean): FieldInsertion;
begin
  Result := inherited SetValue(Value);
  CallBack(Value);
end;

{ TStormDateFieldInsertion<FieldInsertion> }

procedure TStormDateFieldInsertion<FieldInsertion>.CallBack(
  Value: Maybe<TDate>);
begin
  if Assigned(FOnSetValue) then
  begin
    FOnSetValue(Value);
  end;
end;

constructor TStormDateFieldInsertion<FieldInsertion>.Create(
  Owner: TStormSQLPartition; const ColumnSchema: IStormSchemaColumn;
  const OnSetValue: TSetDateValueEvent);
begin
  inherited Create(Owner,ColumnSchema);
  FOnSetValue := OnSetValue;
end;

function TStormDateFieldInsertion<FieldInsertion>.SetValue(
  Value: Maybe<TDate>): FieldInsertion;
begin
  Result := Value.BindTo<FieldInsertion>(SetValue, GetReturn);
end;

function TStormDateFieldInsertion<FieldInsertion>.SetValue(
  const Value: TDate): FieldInsertion;
begin
  Result := inherited SetValue(TDateTime(Value));
  CallBack(Value);
end;

{ TStormDateTimeFieldInsertion<FieldInsertion> }

procedure TStormDateTimeFieldInsertion<FieldInsertion>.CallBack(
  Value: Maybe<TDateTime>);
begin
  if Assigned(FOnSetValue) then
  begin
    FOnSetValue(Value);
  end;
end;

constructor TStormDateTimeFieldInsertion<FieldInsertion>.Create(
  Owner: TStormSQLPartition; const ColumnSchema: IStormSchemaColumn;
  const OnSetValue: TSetDateTimeValueEvent);
begin
  inherited Create(Owner,ColumnSchema);
  FOnSetValue := OnSetValue;
end;

function TStormDateTimeFieldInsertion<FieldInsertion>.SetValue(
  Value: Maybe<TDateTime>): FieldInsertion;
begin
  Result := Value.BindTo<FieldInsertion>(SetValue, GetReturn);
end;

function TStormDateTimeFieldInsertion<FieldInsertion>.SetValue(
  const Value: TDateTime): FieldInsertion;
begin
  Result := inherited SetValue(Value);
  CallBack(Value);
end;


end.
