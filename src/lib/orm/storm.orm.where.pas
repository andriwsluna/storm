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

  TStormEqualsWhere<WhereSelector, Executor : IInterface> = class(TStormColumnSQLPartition)
  public
    Function IsEqualsTo(Const Value : variant) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEqualsTo(Const Value : variant) : IStormWhereCompositor<WhereSelector, Executor>;
  end;

  TStormGroupWhere<WhereSelector, Executor : IInterface> = class(TStormColumnSQLPartition)
  private
    Function GetGroupString(values : TArray<variant>) : string;
  public
    Function IsIn(value : TArray<variant>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotIn(Value : TArray<variant>) : IStormWhereCompositor<WhereSelector, Executor>;
  end;


  TStormNullWhere<WhereSelector, Executor : IInterface> = class(TStormColumnSQLPartition)
  public
    Function IsNull : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotNull : IStormWhereCompositor<WhereSelector, Executor>;
  end;

  TStormStringWhere<WhereSelector, Executor : IInterface>
  = class
  (
    TStormNullWhere<WhereSelector, Executor>,
    IStormStringWhere<WhereSelector,Executor>,
    IStormStringNullableWhere<WhereSelector,Executor>
    )
  private
    Function AddBegins(Const Value : String) : String;
    Function AddContains(Const Value : String) : String;
    Function AddEnds(Const Value : String) : String;

    Function ConvertoToArrayOfVariant(values : TArray<string>) : TArray<variant>;
  public
    Function IsEqualsTo(Const Value : String) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEqualsTo(Const Value : String) : IStormWhereCompositor<WhereSelector, Executor>;

    Function BeginsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function Contains(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function EndsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function NotBeginsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function NotContains(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function NotEndsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEmpty() : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsEmpty() : IStormWhereCompositor<WhereSelector, Executor>;

    Function IsIn(value : TArray<String>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotIn(Value : TArray<String>) : IStormWhereCompositor<WhereSelector, Executor>;


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
  AddSQL(self.GetColumnName + ' LIKE ' + AddParameter(AddBegins(Value)) );
  Result := TStormWhereCompositor<WhereSelector, Executor>.create(self);
end;

function TStormStringWhere<WhereSelector, Executor>.Contains(
  const Value: string): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(self.GetColumnName + ' LIKE ' + AddParameter(AddContains(Value)));
  Result := TStormWhereCompositor<WhereSelector, Executor>.create(self);
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
  AddSQL(self.GetColumnName + ' LIKE' + AddParameter(AddEnds(Value)));
  Result := TStormWhereCompositor<WhereSelector, Executor>.create(self);
end;

function TStormStringWhere<WhereSelector, Executor>.IsEmpty: IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := Self.IsEqualsTo('');
end;

function TStormStringWhere<WhereSelector, Executor>.IsEqualsTo(
  const Value: String): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := TStormEqualsWhere<WhereSelector,Executor>.Create(Self, self.ColumnSchema).IsEqualsTo(Value);
end;

function TStormStringWhere<WhereSelector, Executor>.IsIn(
  value: TArray<String>): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := TStormGroupWhere<WhereSelector, Executor>.create(self, self.ColumnSchema).IsIn(ConvertoToArrayOfVariant(value));
end;

function TStormStringWhere<WhereSelector, Executor>.IsNotEmpty: IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := Self.IsNotEqualsTo('');
end;

function TStormStringWhere<WhereSelector, Executor>.IsNotEqualsTo(
  const Value: String): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := TStormEqualsWhere<WhereSelector,Executor>.Create(Self, self.ColumnSchema).IsNotEqualsTo(Value);
end;

function TStormStringWhere<WhereSelector, Executor>.IsNotIn(
  Value: TArray<String>): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := TStormGroupWhere<WhereSelector, Executor>.create(self, self.ColumnSchema).IsNotIn(ConvertoToArrayOfVariant(value));
end;

function TStormStringWhere<WhereSelector, Executor>.NotBeginsWith(
  const Value: string): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(self.GetColumnName + ' NOT LIKE ' + AddParameter(AddBegins(Value)));
  Result := TStormWhereCompositor<WhereSelector, Executor>.create(self);
end;

function TStormStringWhere<WhereSelector, Executor>.NotContains(
  const Value: string): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(self.GetColumnName + ' NOT LIKE ' + AddParameter(AddContains(Value)));
  Result := TStormWhereCompositor<WhereSelector, Executor>.create(self);
end;

function TStormStringWhere<WhereSelector, Executor>.NotEndsWith(
  const Value: string): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(self.GetColumnName + ' NOT LIKE ' + AddParameter(AddEnds(Value)));
  Result := TStormWhereCompositor<WhereSelector, Executor>.create(self);
end;

{ TStormEqualsWhere<WhereSelector, Executor> }

function TStormEqualsWhere<WhereSelector, Executor>.IsEqualsTo(
  const Value: variant): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(self.GetColumnName + ' = ' + AddParameter(Value));
  Result := TStormWhereCompositor<WhereSelector, Executor>.create(self);
end;

function TStormEqualsWhere<WhereSelector, Executor>.IsNotEqualsTo(
  const Value: variant): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(self.GetColumnName + ' <> ' + AddParameter(Value));
  Result := TStormWhereCompositor<WhereSelector, Executor>.create(self);
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

{ TStormNullWhere<WhereSelector, Executor> }

function TStormNullWhere<WhereSelector, Executor>.IsNotNull: IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(self.GetColumnName + ' IS NOT NULL');
  Result := TStormWhereCompositor<WhereSelector, Executor>.create(self);
end;

function TStormNullWhere<WhereSelector, Executor>.IsNull: IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(self.GetColumnName + ' IS NULL');
  Result := TStormWhereCompositor<WhereSelector, Executor>.create(self);
end;

{ TStormGroupWhere<WhereSelector, Executor> }

function TStormGroupWhere<WhereSelector, Executor>.GetGroupString(
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

function TStormGroupWhere<WhereSelector, Executor>.IsIn(
  value: TArray<variant>): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(GetColumnName + ' IN ' + GetGroupString(value));
  Result := TStormWhereCompositor<WhereSelector, Executor>.create(self);
end;

function TStormGroupWhere<WhereSelector, Executor>.IsNotIn(
  Value: TArray<variant>): IStormWhereCompositor<WhereSelector, Executor>;
begin
  AddSQL(GetColumnName + ' NOT IN ' + GetGroupString(value));
  Result := TStormWhereCompositor<WhereSelector, Executor>.create(self);
end;

end.
