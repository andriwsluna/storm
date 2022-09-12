unit storm.orm.where;

interface
Uses
  storm.orm.base,
  DFE.Maybe,
  storm.entity.interfaces,
  storm.orm.interfaces,
  DFE.Interfaces,
  storm.schema.interfaces,

  System.Sysutils, System.Generics.Collections,System.Classes;

Type


  TStormWhereCompositor<WhereSelector, Executor : IInterface> =
  class(TStormSqlPartition ,IStormWhereCompositor<WhereSelector, Executor>, IStormConditionner)
  protected
    Conditionner : IStormConditionner;
    Procedure AddSQL(const  content : string); Override;
  public

    Conditioned : Boolean;
    Condition : Boolean;
    Function And_()             : WhereSelector;
    Function Or_()              : WhereSelector;
    Function OpenParenthesis()  : WhereSelector;
    Function CloseParenthesis() : IStormWhereCompositor<WhereSelector, Executor>;
    Function Go()               : Executor;
    function IFTHEN(Condition : Boolean) : IStormWhereCompositor<WhereSelector, Executor>;
    function ENDIF : IStormWhereCompositor<WhereSelector, Executor>;
    Function GetCondition : Boolean;
    Function GetConditioned : Boolean;
    Procedure SetConditioned(Value : Boolean);
    Constructor Create(Const Owner : TStormSQLPartition ; Conditionner : IStormConditionner); Reintroduce;
  end;

  TStormGenericWhere<WhereSelector, Executor : IInterface> = class( TStormColumnSQLPartition)
  protected
    Conditionner : IStormConditionner;
    Function GetGroupString(values : TArray<variant>) : string;
    Function GetResult() : IStormWhereCompositor<WhereSelector, Executor>;
    Procedure AddOperation(op : String ; Value : Variant);
    Procedure AddSQL(const  content : string); Override;


  public
    Constructor Create(Owner : TStormSQLPartition ; Const ColumnSchema : IStormSchemaColumn); Reintroduce;
    Function IsEqualsTo(Const Value : variant) : IStormWhereCompositor<WhereSelector, Executor>; Virtual;
    Function IsNotEqualsTo(Const Value : variant) : IStormWhereCompositor<WhereSelector, Executor>; Virtual;
    Function IsIn(value : TArray<variant>) : IStormWhereCompositor<WhereSelector, Executor>; Virtual;
    Function IsNotIn(Value : TArray<variant>) : IStormWhereCompositor<WhereSelector, Executor>; Virtual;
    Function IsBetween(StartValue : Variant ; EndValue : Variant) : IStormWhereCompositor<WhereSelector, Executor>; Virtual;
    Function IsNotBetween(StartValue : Variant ; EndValue : Variant) : IStormWhereCompositor<WhereSelector, Executor>; Virtual;
    Function IsGreaterThan(Value : Variant) : IStormWhereCompositor<WhereSelector, Executor>;   Virtual;
    Function IsGreaterOrEqualTo(Value : Variant) : IStormWhereCompositor<WhereSelector, Executor>; Virtual;
    Function IsLessThan(Value : Variant) : IStormWhereCompositor<WhereSelector, Executor>; Virtual;
    Function IsLessOrEqualTo(Value : Variant) : IStormWhereCompositor<WhereSelector, Executor>; Virtual;
    Function IsNull : IStormWhereCompositor<WhereSelector, Executor>; Virtual;
    Function IsNotNull : IStormWhereCompositor<WhereSelector, Executor>; Virtual;
  end;



  TStormStringWhere<WhereSelector, Executor : IInterface>
  = class
  (
    TStormGenericWhere<WhereSelector, Executor>,
    IStormStringWhere<WhereSelector,Executor>,
    IStormStringNullableWhere<WhereSelector,Executor>
  )
  private
    Function AddBegins(Const Value : String) : String;
    Function AddContains(Const Value : String) : String;
    Function AddEnds(Const Value : String) : String;
    Function ConvertoToArrayOfVariant(values : TArray<string>) : TArray<variant>;
  public
    Function IsEqualsTo(Const Value : String) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsNotEqualsTo(Const Value : String) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function BeginsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function Contains(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function EndsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;  Reintroduce;
    Function NotBeginsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;  Reintroduce;
    Function NotContains(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function NotEndsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsNotEmpty() : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsEmpty() : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsIn(value : TArray<String>) : IStormWhereCompositor<WhereSelector, Executor>;  Reintroduce;
    Function IsNotIn(Value : TArray<String>) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsBetween(Const StartValue : String ; EndValue : String) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsNotBetween(Const StartValue : String ; EndValue : String) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;


  end;

  TStormIntegerWhere<WhereSelector, Executor : IInterface>
  = class
  (
    TStormGenericWhere<WhereSelector, Executor>,
    IStormIntegerWhere<WhereSelector,Executor>,
    IStormIntegerNullableWhere<WhereSelector,Executor>
  )
  private
    Function ConvertoToArrayOfVariant(values : TArray<integer>) : TArray<variant>;
  public
    Function IsEqualsTo(Const Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsNotEqualsTo(Const Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsIn(value : TArray<Integer>) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsNotIn(Value : TArray<Integer>) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsBetween(Const StartValue : Integer ; EndValue : Integer) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsNotBetween(Const StartValue : Integer ; EndValue : Integer) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsGreaterThan(Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsGreaterOrEqualTo(Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsLessThan(Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>;  Reintroduce;
    Function IsLessOrEqualTo(Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
  end;

  TStormFloatWhere<WhereSelector, Executor : IInterface>
  = class
  (
    TStormGenericWhere<WhereSelector, Executor>,
    IStormFloatWhere<WhereSelector,Executor>,
    IStormFloatNullableWhere<WhereSelector,Executor>
  )
  private
    Function ConvertoToArrayOfVariant(values : TArray<Extended>) : TArray<variant>;
  public
    Function IsEqualsTo(Const Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsNotEqualsTo(Const Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsIn(value : TArray<Extended>) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsNotIn(Value : TArray<Extended>) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsBetween(Const StartValue : Extended ; EndValue : Extended) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsNotBetween(Const StartValue : Extended ; EndValue : Extended) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsGreaterThan(Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsGreaterOrEqualTo(Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsLessThan(Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>;  Reintroduce;
    Function IsLessOrEqualTo(Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
  end;

  TStormBooleanWhere<WhereSelector, Executor : IInterface>
  = class
  (
    TStormGenericWhere<WhereSelector, Executor>,
    IStormBooleanWhere<WhereSelector,Executor>,
    IStormBooleanNullableWhere<WhereSelector,Executor>
  )
  public
    Function IsTrue : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsFalse : IStormWhereCompositor<WhereSelector, Executor>;
  end;

  TStormDateWhere<WhereSelector, Executor : IInterface>
  = class
  (
    TStormGenericWhere<WhereSelector, Executor>,
    IStormDateWhere<WhereSelector,Executor>,
    IStormDateNullableWhere<WhereSelector,Executor>
  )
  private
    Function ConvertoToArrayOfVariant(values : TArray<TDate>) : TArray<variant>;
  public
    Function IsEqualsTo(Const Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsNotEqualsTo(Const Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsIn(value : TArray<TDate>) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsNotIn(Value : TArray<TDate>) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsBetween(Const StartValue : TDate ; EndValue : TDate) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsNotBetween(Const StartValue : TDate ; EndValue : TDate) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsGreaterThan(Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsGreaterOrEqualTo(Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsLessThan(Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>;  Reintroduce;
    Function IsLessOrEqualTo(Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
  end;

  TStormDateTimeWhere<WhereSelector, Executor : IInterface>
  = class
  (
    TStormGenericWhere<WhereSelector, Executor>,
    IStormDateTimeWhere<WhereSelector,Executor>,
    IStormDateTimeNullableWhere<WhereSelector,Executor>
  )
  private
    Function ConvertoToArrayOfVariant(values : TArray<TDateTime>) : TArray<variant>;
  public
    Function IsEqualsTo(Const Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsNotEqualsTo(Const Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsIn(value : TArray<TDateTime>) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsNotIn(Value : TArray<TDateTime>) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsBetween(Const StartValue : TDateTime ; EndValue : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsNotBetween(Const StartValue : TDateTime ; EndValue : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsGreaterThan(Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsGreaterOrEqualTo(Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
    Function IsLessThan(Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;  Reintroduce;
    Function IsLessOrEqualTo(Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>; Reintroduce;
  end;



implementation


{ TStormStringWhere<WhereSelector, Executor> }

function TStormStringWhere<WhereSelector, Executor>.AddBegins(
  const Value: String): String;
begin
  Result := Value + '%';
end;

function TStormStringWhere<WhereSelector, Executor>.AddContains(
  const Value: String): String;
begin
   Result := '%' + Value + '%';
end;

function TStormStringWhere<WhereSelector, Executor>.AddEnds(
  const Value: String): String;
begin
   Result := '%' + Value;
end;

function TStormStringWhere<WhereSelector, Executor>.BeginsWith(
  const Value: string): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddOperation('LIKE', AddBegins(Value));
  Result := GetResult;
end;

function TStormStringWhere<WhereSelector, Executor>.Contains(
  const Value: string): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddOperation('LIKE', AddContains(Value));
  Result := GetResult;
end;

function TStormStringWhere<WhereSelector, Executor>.ConvertoToArrayOfVariant(
  values: TArray<string>): TArray<variant>;
VAR
  i : integer;
begin
  SetLength(result,length(values));

  for i := 0 to length(values)-1 do
  begin
    result[i] := values[i];
  end;
end;

function TStormStringWhere<WhereSelector, Executor>.EndsWith(
  const Value: string): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddOperation('LIKE', AddEnds(Value));
  Result := GetResult;
end;

function TStormStringWhere<WhereSelector, Executor>.IsBetween(
  const StartValue: String;
  EndValue: String): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsBetween(StartValue,EndValue);
end;

function TStormStringWhere<WhereSelector, Executor>.IsEmpty: IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := Self.IsEqualsTo('');
end;

function TStormStringWhere<WhereSelector, Executor>.IsEqualsTo(
  const Value: String): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsEqualsTo(Value);
end;

function TStormStringWhere<WhereSelector, Executor>.IsIn(
  value: TArray<String>): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsIn(ConvertoToArrayOfVariant(value));
end;

function TStormStringWhere<WhereSelector, Executor>.IsNotBetween(
  const StartValue: String;
  EndValue: String): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsNotBetween(StartValue,EndValue);
end;

function TStormStringWhere<WhereSelector, Executor>.IsNotEmpty: IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := Self.IsNotEqualsTo('');
end;

function TStormStringWhere<WhereSelector, Executor>.IsNotEqualsTo(
  const Value: String): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsNotEqualsTo(Value);
end;

function TStormStringWhere<WhereSelector, Executor>.IsNotIn(
  Value: TArray<String>): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsNotIn(ConvertoToArrayOfVariant(value));
end;

function TStormStringWhere<WhereSelector, Executor>.NotBeginsWith(
  const Value: string): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddOperation('NOT LIKE', AddBegins(Value));
  Result := GetResult;
end;

function TStormStringWhere<WhereSelector, Executor>.NotContains(
  const Value: string): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddOperation('NOT LIKE', AddContains(Value));
  Result := GetResult;
end;

function TStormStringWhere<WhereSelector, Executor>.NotEndsWith(
  const Value: string): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddOperation('NOT LIKE', AddEnds(Value));
  Result := GetResult;
end;

{ TStormGenericWhere<WhereSelector, Executor> }

function TStormGenericWhere<WhereSelector, Executor>.IsEqualsTo(
  const Value: variant): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddOperation('=', Value);
  Result := GetResult;
end;

function TStormGenericWhere<WhereSelector, Executor>.IsNotEqualsTo(
  const Value: variant): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddOperation('<>', Value);
  Result := GetResult;
end;

{ TStormWhereCompositor<WhereSelector, Executor> }

function TStormWhereCompositor<WhereSelector, Executor>.CloseParenthesis: IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddCloseParenthesis;
  Result := Self;
end;

constructor TStormWhereCompositor<WhereSelector, Executor>.Create(
  const Owner: TStormSQLPartition;
  Conditionner: IStormConditionner);
begin
  inherited create(Owner);
  Self.Conditionner := Conditionner;
end;

function TStormWhereCompositor<WhereSelector, Executor>.ENDIF(): IStormWhereCompositor<WhereSelector, Executor>;
begin
  SetConditioned(False);
  Result := self;
end;

function TStormWhereCompositor<WhereSelector, Executor>.GetCondition: Boolean;
begin
  Result :=((Not assigned(Conditionner))or (Not Conditionner.GetConditioned) or Conditionner.GetCondition) AND ((Not Conditioned) or Condition);
end;

function TStormWhereCompositor<WhereSelector, Executor>.GetConditioned: Boolean;
begin
  Result := ((Not assigned(Conditionner))or (Conditionner.GetConditioned)) or self.Conditioned;
end;

function TStormWhereCompositor<WhereSelector, Executor>.Go: Executor;
begin
  Result := self.GetReturnInstance<Executor>();
end;

function TStormWhereCompositor<WhereSelector, Executor>.IFTHEN(
  Condition: Boolean): IStormWhereCompositor<WhereSelector, Executor>;
begin
  SetConditioned(True);
  Self.Condition := Condition;
  Result := self;
end;

function TStormWhereCompositor<WhereSelector, Executor>.OpenParenthesis: WhereSelector;
begin
  AddOpenParenthesis;
  Result := self.GetReturnInstance2<WhereSelector, Executor>();
end;

procedure TStormWhereCompositor<WhereSelector, Executor>.AddSQL(
  const content: string);
begin
  if GetCondition then
  begin
    inherited;
  end;
end;

function TStormWhereCompositor<WhereSelector, Executor>.And_: WhereSelector;
begin
  AddAnd;
  Result := self.GetReturnInstance2<WhereSelector, Executor>();
end;

function TStormWhereCompositor<WhereSelector, Executor>.Or_: WhereSelector;
begin
  AddOr;
  Result := self.GetReturnInstance2<WhereSelector, Executor>();
end;

procedure TStormWhereCompositor<WhereSelector, Executor>.SetConditioned(
  Value: Boolean);
begin
  if (Not Value) then
  begin
    if self.Conditioned then
    begin
      self.Conditioned := False
    end
    else
    if Assigned(Conditionner) then
    begin
      Conditionner.SetConditioned(Value);
    end;
  end
  else
  begin
    if Not self.Conditioned then
    begin
      self.Conditioned := True
    end
    else
    if Assigned(Conditionner) then
    begin
      Conditionner.SetConditioned(Value);
    end;
  end;
end;

{ TStormGenericWhere<WhereSelector, Executor> }

function TStormGenericWhere<WhereSelector, Executor>.IsNotNull: IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(self.GetColumnName + ' IS NOT NULL');
  Result := GetResult;
end;

function TStormGenericWhere<WhereSelector, Executor>.IsNull: IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(self.GetColumnName + ' IS NULL');
  Result := GetResult;
end;

{ TStormGenericWhere<WhereSelector, Executor> }

procedure TStormGenericWhere<WhereSelector, Executor>.AddSQL(
  const content: string);
begin
  if (Not Assigned(Conditionner)) or (Conditionner.GetCondition) then
  begin
    inherited;
  end;
end;

constructor TStormGenericWhere<WhereSelector, Executor>.Create(
  Owner: TStormSQLPartition; const ColumnSchema: IStormSchemaColumn);
begin
  inherited;

  if Supports (Owner,IStormConditionner) then
  begin
    Self.Conditionner :=  Owner as IStormConditionner;
  end
  else
  if Supports (Owner.GetOwner,IStormConditionner) then
  begin
    Self.Conditionner :=  Owner.GetOwner as IStormConditionner;
  end

end;

function TStormGenericWhere<WhereSelector, Executor>.GetGroupString(
  values: TArray<variant>): string;
VAR
  value : variant;
begin
  Result := '';

  for value in values do
  begin
    result := Result + ', ' + AddParameter(value);
  end;

  result := '(' + Result.Substring(1) +')';

end;

function TStormGenericWhere<WhereSelector, Executor>.IsIn(
  value: TArray<variant>): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(GetColumnName + ' IN ' + GetGroupString(value));
  Result := GetResult;
end;

function TStormGenericWhere<WhereSelector, Executor>.IsNotIn(
  Value: TArray<variant>): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(GetColumnName + ' NOT IN ' + GetGroupString(value));
  Result := GetResult;
end;

{ TStormGenericWhere<WhereSelector, Executor> }

function TStormGenericWhere<WhereSelector, Executor>.IsBetween(StartValue,
  EndValue: Variant): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(self.GetColumnName + ' BETWEEN ' + AddParameter(StartValue) + ' AND ' +  AddParameter(EndValue));
  Result := GetResult;
end;

function TStormGenericWhere<WhereSelector, Executor>.IsNotBetween(StartValue,
  EndValue: Variant): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(self.GetColumnName + ' NOT BETWEEN ' + AddParameter(StartValue) + ' AND ' +  AddParameter(EndValue));
  Result := GetResult;
end;

{ TStormGenericWhere<WhereSelector, Executor> }

function TStormGenericWhere<WhereSelector, Executor>.IsGreaterOrEqualTo(
  Value: Variant): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddOperation('>=', Value);
  Result := GetResult;
end;

function TStormGenericWhere<WhereSelector, Executor>.IsGreaterThan(
  Value: Variant): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddOperation('<', Value);
  Result := GetResult;
end;

function TStormGenericWhere<WhereSelector, Executor>.IsLessOrEqualTo(
  Value: Variant): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddOperation('<=', Value);
  Result := GetResult();
end;

function TStormGenericWhere<WhereSelector, Executor>.IsLessThan(
  Value: Variant): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddOperation('<', Value);
  Result := GetResult();
end;

{ TStormGenericWhere<WhereSelector, Executor> }

procedure TStormGenericWhere<WhereSelector, Executor>.AddOperation(
  op: String; Value: Variant);
begin
  if (Not Assigned(Conditionner)) or (Conditionner.GetCondition) then
  begin
    AddSQL(self.GetColumnName + ' ' + op + ' '  + AddParameter(Value));
  end;

end;

function TStormGenericWhere<WhereSelector, Executor>.GetResult: IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := TStormWhereCompositor<WhereSelector, Executor>.create(self,Conditionner);
end;

{ TStormIntegerWhere<WhereSelector, Executor> }

function TStormIntegerWhere<WhereSelector, Executor>.ConvertoToArrayOfVariant(
  values: TArray<integer>): TArray<variant>;
VAR
  i : integer;
begin
  SetLength(result,length(values));

  for i := 0 to length(values)-1 do
  begin
    result[i] := values[i];
  end;
end;

function TStormIntegerWhere<WhereSelector, Executor>.IsBetween(
  const StartValue: Integer;
  EndValue: Integer): IStormWhereCompositor<WhereSelector, Executor>;
begin
  result := inherited  IsBetween(StartValue, EndValue);
end;

function TStormIntegerWhere<WhereSelector, Executor>.IsEqualsTo(
  const Value: Integer): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsEqualsTo(Value);
end;

function TStormIntegerWhere<WhereSelector, Executor>.IsGreaterOrEqualTo(
  Value: Integer): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsGreaterOrEqualTo(Value);
end;

function TStormIntegerWhere<WhereSelector, Executor>.IsGreaterThan(
  Value: Integer): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsGreaterThan(Value);
end;

function TStormIntegerWhere<WhereSelector, Executor>.IsIn(
  value: TArray<Integer>): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsIn(ConvertoToArrayOfVariant(value));
end;

function TStormIntegerWhere<WhereSelector, Executor>.IsLessOrEqualTo(
  Value: Integer): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsLessOrEqualTo(Value);
end;

function TStormIntegerWhere<WhereSelector, Executor>.IsLessThan(
  Value: Integer): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsLessThan(Value);
end;

function TStormIntegerWhere<WhereSelector, Executor>.IsNotBetween(
  const StartValue: Integer;
  EndValue: Integer): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsNotBetween(StartValue, EndValue);
end;

function TStormIntegerWhere<WhereSelector, Executor>.IsNotEqualsTo(
  const Value: Integer): IStormWhereCompositor<WhereSelector, Executor>;
begin
  result := inherited  IsNotEqualsTo(value);
end;

function TStormIntegerWhere<WhereSelector, Executor>.IsNotIn(
  Value: TArray<Integer>): IStormWhereCompositor<WhereSelector, Executor>;
begin
   result := inherited  IsNotIn(self.ConvertoToArrayOfVariant(value));
end;


{ TStormFloatWhere<WhereSelector, Executor> }

function TStormFloatWhere<WhereSelector, Executor>.ConvertoToArrayOfVariant(
  values: TArray<Extended>): TArray<variant>;
VAR
  i : integer;
begin
  SetLength(result,length(values));

  for i := 0 to length(values)-1 do
  begin
    result[i] := values[i];
  end;
end;

function TStormFloatWhere<WhereSelector, Executor>.IsBetween(
  const StartValue: Extended;
  EndValue: Extended): IStormWhereCompositor<WhereSelector, Executor>;
begin
  result := inherited  IsBetween(StartValue, EndValue);
end;

function TStormFloatWhere<WhereSelector, Executor>.IsEqualsTo(
  const Value: Extended): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsEqualsTo(Value);
end;

function TStormFloatWhere<WhereSelector, Executor>.IsGreaterOrEqualTo(
  Value: Extended): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsGreaterOrEqualTo(Value);
end;

function TStormFloatWhere<WhereSelector, Executor>.IsGreaterThan(
  Value: Extended): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsGreaterThan(Value);
end;

function TStormFloatWhere<WhereSelector, Executor>.IsIn(
  value: TArray<Extended>): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsIn(ConvertoToArrayOfVariant(value));
end;

function TStormFloatWhere<WhereSelector, Executor>.IsLessOrEqualTo(
  Value: Extended): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsLessOrEqualTo(Value);
end;

function TStormFloatWhere<WhereSelector, Executor>.IsLessThan(
  Value: Extended): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsLessThan(Value);
end;

function TStormFloatWhere<WhereSelector, Executor>.IsNotBetween(
  const StartValue: Extended;
  EndValue: Extended): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsNotBetween(StartValue, EndValue);
end;

function TStormFloatWhere<WhereSelector, Executor>.IsNotEqualsTo(
  const Value: Extended): IStormWhereCompositor<WhereSelector, Executor>;
begin
  result := inherited  IsNotEqualsTo(value);
end;

function TStormFloatWhere<WhereSelector, Executor>.IsNotIn(
  Value: TArray<Extended>): IStormWhereCompositor<WhereSelector, Executor>;
begin
   result := inherited  IsNotIn(self.ConvertoToArrayOfVariant(value));
end;

{ TStormBooleanWhere<WhereSelector, Executor> }


function TStormBooleanWhere<WhereSelector, Executor>.IsFalse: IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := self.IsEqualsTo(False);
end;



function TStormBooleanWhere<WhereSelector, Executor>.IsTrue: IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := self.IsEqualsTo(True);
end;

{ TStormDateWhere<WhereSelector, Executor> }

function TStormDateWhere<WhereSelector, Executor>.ConvertoToArrayOfVariant(
  values: TArray<TDate>): TArray<variant>;
VAR
  i : integer;
begin
  SetLength(result,length(values));

  for i := 0 to length(values)-1 do
  begin
    result[i] := values[i];
  end;
end;

function TStormDateWhere<WhereSelector, Executor>.IsBetween(
  const StartValue: TDate;
  EndValue: TDate): IStormWhereCompositor<WhereSelector, Executor>;
begin
  result := inherited  IsBetween(StartValue, EndValue);
end;

function TStormDateWhere<WhereSelector, Executor>.IsEqualsTo(
  const Value: TDate): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsEqualsTo(Value);
end;

function TStormDateWhere<WhereSelector, Executor>.IsGreaterOrEqualTo(
  Value: TDate): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsGreaterOrEqualTo(Value);
end;

function TStormDateWhere<WhereSelector, Executor>.IsGreaterThan(
  Value: TDate): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsGreaterThan(Value);
end;

function TStormDateWhere<WhereSelector, Executor>.IsIn(
  value: TArray<TDate>): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsIn(ConvertoToArrayOfVariant(value));
end;

function TStormDateWhere<WhereSelector, Executor>.IsLessOrEqualTo(
  Value: TDate): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsLessOrEqualTo(Value);
end;

function TStormDateWhere<WhereSelector, Executor>.IsLessThan(
  Value: TDate): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsLessThan(Value);
end;

function TStormDateWhere<WhereSelector, Executor>.IsNotBetween(
  const StartValue: TDate;
  EndValue: TDate): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsNotBetween(StartValue, EndValue);
end;

function TStormDateWhere<WhereSelector, Executor>.IsNotEqualsTo(
  const Value: TDate): IStormWhereCompositor<WhereSelector, Executor>;
begin
  result := inherited  IsNotEqualsTo(value);
end;

function TStormDateWhere<WhereSelector, Executor>.IsNotIn(
  Value: TArray<TDate>): IStormWhereCompositor<WhereSelector, Executor>;
begin
   result := inherited  IsNotIn(self.ConvertoToArrayOfVariant(value));
end;


{ TStormDateTimeWhere<WhereSelector, Executor> }

function TStormDateTimeWhere<WhereSelector, Executor>.ConvertoToArrayOfVariant(
  values: TArray<TDateTime>): TArray<variant>;
VAR
  i : integer;
begin
  SetLength(result,length(values));

  for i := 0 to length(values)-1 do
  begin
    result[i] := values[i];
  end;
end;

function TStormDateTimeWhere<WhereSelector, Executor>.IsBetween(
  const StartValue: TDateTime;
  EndValue: TDateTime): IStormWhereCompositor<WhereSelector, Executor>;
begin
  result := inherited  IsBetween(StartValue, EndValue);
end;

function TStormDateTimeWhere<WhereSelector, Executor>.IsEqualsTo(
  const Value: TDateTime): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsEqualsTo(Value);
end;

function TStormDateTimeWhere<WhereSelector, Executor>.IsGreaterOrEqualTo(
  Value: TDateTime): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsGreaterOrEqualTo(Value);
end;

function TStormDateTimeWhere<WhereSelector, Executor>.IsGreaterThan(
  Value: TDateTime): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsGreaterThan(Value);
end;

function TStormDateTimeWhere<WhereSelector, Executor>.IsIn(
  value: TArray<TDateTime>): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsIn(ConvertoToArrayOfVariant(value));
end;

function TStormDateTimeWhere<WhereSelector, Executor>.IsLessOrEqualTo(
  Value: TDateTime): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsLessOrEqualTo(Value);
end;

function TStormDateTimeWhere<WhereSelector, Executor>.IsLessThan(
  Value: TDateTime): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsLessThan(Value);
end;

function TStormDateTimeWhere<WhereSelector, Executor>.IsNotBetween(
  const StartValue: TDateTime;
  EndValue: TDateTime): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := inherited IsNotBetween(StartValue, EndValue);
end;

function TStormDateTimeWhere<WhereSelector, Executor>.IsNotEqualsTo(
  const Value: TDateTime): IStormWhereCompositor<WhereSelector, Executor>;
begin
  result := inherited  IsNotEqualsTo(value);
end;

function TStormDateTimeWhere<WhereSelector, Executor>.IsNotIn(
  Value: TArray<TDateTime>): IStormWhereCompositor<WhereSelector, Executor>;
begin
   result := inherited  IsNotIn(self.ConvertoToArrayOfVariant(value));
end;




end.
