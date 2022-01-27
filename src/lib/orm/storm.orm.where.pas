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
  class(TStormSqlPartition ,IStormWhereCompositor<WhereSelector, Executor>)
    Function _And()             : WhereSelector;
    Function _Or()              : WhereSelector;
    Function OpenParenthesis()  : WhereSelector;
    Function CloseParenthesis() : IStormWhereCompositor<WhereSelector, Executor>;
    Function Go()               : Executor;
  end;

  TStormGenericWhere<WhereSelector, Executor : IInterface> = class( TStormColumnSQLPartition)
  protected
    Function GetGroupString(values : TArray<variant>) : string;
    Function GetResult() : IStormWhereCompositor<WhereSelector, Executor>;
    Procedure AddOperation(op : String ; Value : Variant);


  public
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

function TStormWhereCompositor<WhereSelector, Executor>.Go: Executor;
begin
  Result := self.GetReturnInstance<Executor>();
end;

function TStormWhereCompositor<WhereSelector, Executor>.OpenParenthesis: WhereSelector;
begin
  AddOpenParenthesis;
  Result := self.GetReturnInstance2<WhereSelector, Executor>();
end;

function TStormWhereCompositor<WhereSelector, Executor>._And: WhereSelector;
begin
  AddAnd;
  Result := self.GetReturnInstance2<WhereSelector, Executor>();
end;

function TStormWhereCompositor<WhereSelector, Executor>._Or: WhereSelector;
begin
  AddOr;
  Result := self.GetReturnInstance2<WhereSelector, Executor>();
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
  AddSQL(self.GetColumnName + ' ' + op + ' '  + AddParameter(Value));
end;

function TStormGenericWhere<WhereSelector, Executor>.GetResult: IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := TStormWhereCompositor<WhereSelector, Executor>.create(self);
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

end.
