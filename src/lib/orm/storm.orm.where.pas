unit storm.orm.where;

interface
Uses
  storm.orm.base,
  storm.additional.maybe,
  storm.orm.interfaces,
  storm.schema.interfaces,

  System.Sysutils, System.Generics.Collections,System.Classes;

type



  TStormWhereSelection<T : TStormQueryPartition> = class(TStormQueryPartition, IStormWhereSelection<T>)
  public
    Function OpenParentheses() : T;
    Function CloseParentheses() : T;
  end;

  TStormWhereCompositor<T : TStormQueryPartition> = class(TStormQueryPartition, IStormWhereCompositor<T>)
  public
    Function And_() : T;
    Function Or_()  : T;
    Function OpenParentheses() : T;
    Function CloseParentheses() : IStormWhereCompositor<T>;
  end;

  TWhereNode<T : IStormQueryPartition, TStormQueryPartition> = class(TStormQueryPartition, IWhereNode<T>)
  public
    Function Where : T;
  end;

  TStormWhereBase<T : TStormQueryPartition> = class abstract(TStormSQLPartition)
  private

  protected
    FTable : IStormTableSchema;
    FColumn : IStormSchemaColumn;
    Constructor create(owner : TStormSQLPartition; Table : IStormTableSchema ; column : IStormSchemaColumn); Reintroduce; Virtual;

    Function GetColumnName : string;

    Function Return : IStormWhereCompositor<T>;

  public

  end;


  TStormFieldSelection<T : TStormQueryPartition> = class abstract(TStormWhereBase<T>, IStormFieldSelection<T>)
  protected
    Function From() : IWhereNode<T>;
  public
    Function All() : IWhereNode<T>;
  end;

  TNullableWhere<T : TStormQueryPartition> = class(TStormWhereBase<T>, INullableWhere<T>)
  private

  public

  public
    Function IsNull : IStormWhereCompositor<T>;
    Function IsNotNull : IStormWhereCompositor<T>;
  end;

  TEqualWhere<T : TStormQueryPartition> = class(TStormWhereBase<T>, IEqualWhere<T>)
  private

  public

  public
    Function IsEqualsTo(value : variant) : IStormWhereCompositor<T>;
    Function NotIsEqualsTo(value : variant) : IStormWhereCompositor<T>;
  end;

  TGroupWhere<T : TStormQueryPartition> = class(TStormWhereBase<T>)
  private
    Function GetGroupString(values : TArray<variant>) : string;
  public

  public
    Function IsIn(value : TArray<variant>) : IStormWhereCompositor<T>;
    Function IsNotIn(value : TArray<variant>) : IStormWhereCompositor<T>;
  end;


  TStringWhere<T : TStormQueryPartition> = class(TStormWhereBase<T>, IStringWhere<T> )
  private
    Function ConvertoToArrayOfVariant(values : TArray<string>) : TArray<variant>;
  protected

  public
    Function IsEqualsTo(value : string) : IStormWhereCompositor<T>;
    Function NotIsEqualsTo(value : string) : IStormWhereCompositor<T>;

    Function BeginsWith(value : string) : IStormWhereCompositor<T>;
    Function Contains(value : string) : IStormWhereCompositor<T>;
    Function EndsWith(value : string) : IStormWhereCompositor<T>;

    Function IsIn(value : TArray<String>) : IStormWhereCompositor<T>;
    Function IsNotIn(value :TArray<String>) : IStormWhereCompositor<T>;
  end;

  TNullableStringWhere<T : TStormQueryPartition> = class(TStringWhere<T>, INullableStringWhere<T>)
  private

  protected

  public
    Function IsNull : IStormWhereCompositor<T>;
    Function IsNotNull : IStormWhereCompositor<T>;
  end;
implementation



function TStormWhereCompositor<T>.And_: T;
begin
  AddSQL(' and');
  Result := T.Create(self);
end;

function TStormWhereCompositor<T>.CloseParentheses: IStormWhereCompositor<T>;
begin
  AddSQL(' )');
  Result := TStormWhereCompositor<T>.Create(self);
end;

function TStormWhereCompositor<T>.OpenParentheses: T;
begin
  AddSQL(' (');
  Result := T.Create(self);
end;

function TStormWhereCompositor<T>.Or_: T;
begin
  AddSQL(' or');
  Result := T.Create(self);
end;

{ TStormWhereBase<T> }

constructor TStormWhereBase<T>.create(owner : TStormSQLPartition; Table : IStormTableSchema ;column: IStormSchemaColumn);
begin
  inherited create(owner);
  FTable := Table;
  FColumn := column;
end;



{ TWhereNode<T> }

function TWhereNode<T>.Where: T;
VAR
  i : IInterface;
begin
  AddSQL(' where');
  //i := T.Create(self);
  Result := T.Create(self);
end;

{ TStormFieldSelection<T> }

function TStormFieldSelection<T>.All: IWhereNode<T>;
begin
  AddSQL(' *');
  result := From;
end;

function TStormFieldSelection<T>.From: IWhereNode<T>;
begin
  AddSQL(' from ' + FTable.GetSchemaName + '.' + FTable.GetTableName);
  result := TWhereNode<T>.Create(self);
end;

function TStormWhereBase<T>.GetColumnName: string;
begin
  Result := FTable.GetTableName + '.' + FColumn.GetColumnName;
end;

function TStormWhereBase<T>.Return: IStormWhereCompositor<T>;
begin
  Result := TStormWhereCompositor<T>.Create(self);
end;

{ TStormWhereSelection<T> }

function TStormWhereSelection<T>.CloseParentheses: T;
begin
  AddSQL(' )');
  Result := T.Create(self);
end;

function TStormWhereSelection<T>.OpenParentheses: T;
begin
  AddSQL(' (');
  Result := T.Create(self);
end;

{ TNullableWhere<T> }

function TNullableWhere<T>.IsNotNull: IStormWhereCompositor<T>;
begin
  AddSQL(' ' + GetColumnName + ' is not null');
  Result := Return;
end;

function TNullableWhere<T>.IsNull: IStormWhereCompositor<T>;
begin
  AddSQL(' ' + GetColumnName + ' is null');
  Result := Return;
end;

{ TEqualWhere<T> }

function TEqualWhere<T>.IsEqualsTo(value : variant): IStormWhereCompositor<T>;
begin
  AddSQL(' ' + GetColumnName + ' = ' + AddParameter(value));
  Result := Return;
end;

function TEqualWhere<T>.NotIsEqualsTo(value : variant): IStormWhereCompositor<T>;
begin
  AddSQL(' ' + GetColumnName + ' <> ' + AddParameter(value));
  Result := Return;
end;

{ TStringWhere<T> }

function TStringWhere<T>.BeginsWith(value: string): IStormWhereCompositor<T>;
begin
  AddSQL(' ' + GetColumnName + ' like ' + AddParameter(value + '%'));
  Result := Return;
end;

function TStringWhere<T>.Contains(value: string): IStormWhereCompositor<T>;
begin
  AddSQL(' ' + GetColumnName + ' like ' + AddParameter('%' + value + '%'));
  Result := Return;
end;

function TStringWhere<T>.ConvertoToArrayOfVariant(
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

function TStringWhere<T>.EndsWith(value: string): IStormWhereCompositor<T>;
begin
  AddSQL(' ' + GetColumnName + ' like ' + AddParameter('%' + value));
  Result := Return;
end;

function TStringWhere<T>.IsEqualsTo(value: string): IStormWhereCompositor<T>;
begin
  Result := TEqualWhere<T>.create(self, FTable, FColumn).IsEqualsTo(value);
end;


function TStringWhere<T>.IsIn(value: TArray<String>): IStormWhereCompositor<T>;
begin
  Result := TGroupWhere<T>.create(self, FTable, FColumn).IsIn(ConvertoToArrayOfVariant(value));
end;

function TStringWhere<T>.IsNotIn(
  value: TArray<String>): IStormWhereCompositor<T>;
begin
   Result := TGroupWhere<T>.create(self, FTable, FColumn).IsNotIn(ConvertoToArrayOfVariant(value));
end;

function TStringWhere<T>.NotIsEqualsTo(value: string): IStormWhereCompositor<T>;
begin
  Result := TEqualWhere<T>.create(self, FTable, FColumn).NotIsEqualsTo(value);
end;

{ TNullableStringWhere<T> }

function TNullableStringWhere<T>.IsNotNull: IStormWhereCompositor<T>;
begin
  Result := TNullableWhere<T>.create(self, FTable, FColumn).IsNotNull;
end;

function TNullableStringWhere<T>.IsNull: IStormWhereCompositor<T>;
begin
  Result := TNullableWhere<T>.create(self, FTable, FColumn).IsNull;
end;

{ TGroupWhere<T> }

function TGroupWhere<T>.GetGroupString(values: TArray<variant>): string;
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

function TGroupWhere<T>.IsIn(value: TArray<variant>): IStormWhereCompositor<T>;
begin
  AddSQL(' ' + GetColumnName + ' in ' + GetGroupString(value));
  Result := Return;
end;

function TGroupWhere<T>.IsNotIn(
  value: TArray<variant>): IStormWhereCompositor<T>;
begin
  AddSQL(' ' + GetColumnName + ' not in ' + GetGroupString(value));
  Result := Return;
end;

end.
