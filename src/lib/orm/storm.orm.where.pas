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
  TStormWhereCompositor<WhereSelector, Executor : IInterface> = class(TStormSqlPartition ,IStormWhereCompositor<WhereSelector, Executor>)
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

  TStormStringWhere<WhereSelector, Executor : IInterface>
  = class(TStormColumnSQLPartition, IStormStringWhere<WhereSelector,Executor>)
  public
    Function IsEqualsTo(Const Value : String) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEqualsTo(Const Value : String) : IStormWhereCompositor<WhereSelector, Executor>;
  end;


implementation


{ TStormStringWhere<WhereSelector, Executor> }

function TStormStringWhere<WhereSelector, Executor>.IsEqualsTo(
  const Value: String): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := TStormEqualsWhere<WhereSelector,Executor>.Create(Self, self.ColumnSchema).IsEqualsTo(Value);
end;

function TStormStringWhere<WhereSelector, Executor>.IsNotEqualsTo(
  const Value: String): IStormWhereCompositor<WhereSelector, Executor>;
begin
  Result := TStormEqualsWhere<WhereSelector,Executor>.Create(Self, self.ColumnSchema).IsNotEqualsTo(Value);
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
  AddAnd;
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

end.
