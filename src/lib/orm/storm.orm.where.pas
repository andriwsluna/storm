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

type



  TStormWhereSelection<EntityType : IStormEntity; T : TStormQueryPartition<EntityType>>
  = class(TStormQueryPartition<EntityType>, IStormWhereSelection<EntityType,T>)
  public
    Function OpenParentheses() : T;
    Function CloseParentheses() : T;
  end;

  TStormWhereCompositor<EntityType : IStormEntity; T : TStormQueryPartition<EntityType>> = class(TStormQueryPartition<EntityType>, IStormWhereCompositor<EntityType,T>)
  public
    Function And_() : T;
    Function Or_()  : T;
    Function OpenParentheses() : T;
    Function CloseParentheses() : IStormWhereCompositor<EntityType, T>;
  end;

  TStormWhereBase<EntityType : IStormEntity; T : TStormQueryPartition<EntityType>> = class abstract(TStormSQLPartition)
  private

  protected
    FTable : IStormTableSchema;
    FColumn : IStormSchemaColumn;
    Constructor create(owner : TStormSQLPartition; Table : IStormTableSchema ; column : IStormSchemaColumn); Reintroduce; Virtual;

    Function GetColumnName : string;

    Function Return : IStormWhereCompositor<EntityType,T>;

  public

  end;

  TWhereNode<EntityType : IStormEntity ; T : IStormQueryPartition<EntityType>, TStormQueryPartition<EntityType>> = class(TStormQueryPartition<EntityType>, IWhereNode<EntityType, T>)
  public
    Function Where : T;
  end;

  TStormFieldSelection<EntityType : IStormEntity; T : TStormQueryPartition<EntityType>> = class abstract(TStormWhereBase<EntityType, T>, IStormFieldSelection<EntityType, T>)
  protected
    Function From() : IWhereNode<EntityType,T>;
  public
    Function All() : IWhereNode<EntityType, T>;
  end;

  TNullableWhere<EntityType : IStormEntity ; T : TStormQueryPartition<EntityType>> = class(TStormWhereBase<EntityType,T>)
  private

  public

  public
    Function IsNull : IStormWhereCompositor<EntityType,T>;
    Function IsNotNull : IStormWhereCompositor<EntityType,T>;
  end;

  TEqualWhere<EntityType : IStormEntity ;T : TStormQueryPartition<EntityType>> = class(TStormWhereBase<EntityType,T>)
    private

    public

    public
      Function IsEqualsTo(value : variant) : IStormWhereCompositor<EntityType,T>;
      Function NotIsEqualsTo(value : variant) : IStormWhereCompositor<EntityType,T>;
    end;

    TGroupWhere<EntityType : IStormEntity ; T : TStormQueryPartition<EntityType>> = class(TStormWhereBase<EntityType,T>)
    private
      Function GetGroupString(values : TArray<variant>) : string;
    public

    public
      Function IsIn(value : TArray<variant>) : IStormWhereCompositor<EntityType,T>;
      Function IsNotIn(value : TArray<variant>) : IStormWhereCompositor<EntityType,T>;
  end;


  TStringWhere<EntityType : IStormEntity ; T : TStormQueryPartition<EntityType>> = class(TStormWhereBase<EntityType,T>, IStringWhere<EntityType, T> )
  private
    Function ConvertoToArrayOfVariant(values : TArray<string>) : TArray<variant>;
  protected

  public
    Function IsEqualsTo(value : string) : IStormWhereCompositor<EntityType,T>;
    Function NotIsEqualsTo(value : string) : IStormWhereCompositor<EntityType,T>;

    Function BeginsWith(value : string) : IStormWhereCompositor<EntityType,T>;
    Function Contains(value : string) : IStormWhereCompositor<EntityType,T>;
    Function EndsWith(value : string) : IStormWhereCompositor<EntityType,T>;

    Function IsIn(value : TArray<String>) : IStormWhereCompositor<EntityType,T>;
    Function IsNotIn(value :TArray<String>) : IStormWhereCompositor<EntityType,T>;
  end;

  TNullableStringWhere<EntityType : IStormEntity ; T : TStormQueryPartition<EntityType>> = class(TStringWhere<EntityType,T>, INullableStringWhere<EntityType,T>)
  private

  protected

  public
    Function IsNull : IStormWhereCompositor<EntityType,T>;
    Function IsNotNull : IStormWhereCompositor<EntityType,T>;
  end;
















implementation



function TStormWhereCompositor<EntityType, T>.And_: T;
begin
  AddSQL(' and');
  Result := T.Create(self);
end;

function TStormWhereCompositor<EntityType, T>.CloseParentheses: IStormWhereCompositor<EntityType, T>;
begin
  AddSQL(' )');
  Result := TStormWhereCompositor<EntityType, T>.Create(self);
end;

function TStormWhereCompositor<EntityType, T>.OpenParentheses: T;
begin
  AddSQL(' (');
  Result := T.Create(self);
end;

function TStormWhereCompositor<EntityType, T>.Or_: T;
begin
  AddSQL(' or');
  Result := T.Create(self);
end;

{ TStormWhereBase<T> }

constructor TStormWhereBase<EntityType, T>.create(owner : TStormSQLPartition; Table : IStormTableSchema ;column: IStormSchemaColumn);
begin
  inherited create(owner);
  FTable := Table;
  FColumn := column;
end;



{ TWhereNode<T> }

function TWhereNode<EntityType, T>.Where: T;
VAR
  i : IInterface;
begin
  AddSQL(' where');
  Result := T.Create(self);
end;

{ TStormFieldSelection<T> }

function TStormFieldSelection<EntityType, T>.All: IWhereNode<EntityType, T>;
begin
  AddSQL(' *');
  result := From;
end;

function TStormFieldSelection<EntityType, T>.From: IWhereNode<EntityType, T>;
begin
  AddSQL(' from ' + SQLDriver.GetFullTableName(FTable));
  result := TWhereNode<EntityType, T>.Create(self);
end;

function TStormWhereBase<EntityType, T>.GetColumnName: string;
begin
  Result := FTable.GetTableName + '.' + FColumn.GetColumnName;
end;

function TStormWhereBase<EntityType, T>.Return: IStormWhereCompositor<EntityType, T>;
begin
  Result := TStormWhereCompositor<EntityType, T>.Create(self);
end;

{ TStormWhereSelection<T> }

function TStormWhereSelection<EntityType, T>.CloseParentheses: T;
begin
  AddSQL(' )');
  Result := T.Create(self);
end;

function TStormWhereSelection<EntityType, T>.OpenParentheses: T;
begin
  AddSQL(' (');
  Result := T.Create(self);
end;

{ TNullableWhere<T> }

function TNullableWhere<EntityType, T>.IsNotNull: IStormWhereCompositor<EntityType, T>;
begin
  AddSQL(' ' + GetColumnName + ' is not null');
  Result := Return;
end;

function TNullableWhere<EntityType, T>.IsNull: IStormWhereCompositor<EntityType, T>;
begin
  AddSQL(' ' + GetColumnName + ' is null');
  Result := Return;
end;

{ TEqualWhere<T> }

function TEqualWhere<EntityType, T>.IsEqualsTo(value : variant): IStormWhereCompositor<EntityType, T>;
begin
  AddSQL(' ' + GetColumnName + ' = ' + AddParameter(value));
  Result := Return;
end;

function TEqualWhere<EntityType, T>.NotIsEqualsTo(value : variant): IStormWhereCompositor<EntityType, T>;
begin
  AddSQL(' ' + GetColumnName + ' <> ' + AddParameter(value));
  Result := Return;
end;

{ TStringWhere<T> }

function TStringWhere<EntityType, T>.BeginsWith(value: string): IStormWhereCompositor<EntityType, T>;
begin
  AddSQL(' ' + GetColumnName + ' like ' + AddParameter(value + '%'));
  Result := Return;
end;

function TStringWhere<EntityType, T>.Contains(value: string): IStormWhereCompositor<EntityType, T>;
begin
  AddSQL(' ' + GetColumnName + ' like ' + AddParameter('%' + value + '%'));
  Result := Return;
end;

function TStringWhere<EntityType, T>.ConvertoToArrayOfVariant(
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

function TStringWhere<EntityType, T>.EndsWith(value: string): IStormWhereCompositor<EntityType, T>;
begin
  AddSQL(' ' + GetColumnName + ' like ' + AddParameter('%' + value));
  Result := Return;
end;

function TStringWhere<EntityType, T>.IsEqualsTo(value: string): IStormWhereCompositor<EntityType, T>;
begin
  Result := TEqualWhere<EntityType, T>.create(self, FTable, FColumn).IsEqualsTo(value);
end;


function TStringWhere<EntityType, T>.IsIn(value: TArray<String>): IStormWhereCompositor<EntityType, T>;
begin
  Result := TGroupWhere<EntityType, T>.create(self, FTable, FColumn).IsIn(ConvertoToArrayOfVariant(value));
end;

function TStringWhere<EntityType, T>.IsNotIn(
  value: TArray<String>): IStormWhereCompositor<EntityType, T>;
begin
   Result := TGroupWhere<EntityType, T>.create(self, FTable, FColumn).IsNotIn(ConvertoToArrayOfVariant(value));
end;

function TStringWhere<EntityType, T>.NotIsEqualsTo(value: string): IStormWhereCompositor<EntityType, T>;
begin
  Result := TEqualWhere<EntityType, T>.create(self, FTable, FColumn).NotIsEqualsTo(value);
end;

{ TNullableStringWhere<T> }

function TNullableStringWhere<EntityType, T>.IsNotNull: IStormWhereCompositor<EntityType, T>;
begin
  Result := TNullableWhere<EntityType, T>.create(self, FTable, FColumn).IsNotNull;
end;

function TNullableStringWhere<EntityType, T>.IsNull: IStormWhereCompositor<EntityType, T>;
begin
  Result := TNullableWhere<EntityType, T>.create(self, FTable, FColumn).IsNull;
end;

{ TGroupWhere<T> }

function TGroupWhere<EntityType, T>.GetGroupString(values: TArray<variant>): string;
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

function TGroupWhere<EntityType, T>.IsIn(value: TArray<variant>): IStormWhereCompositor<EntityType, T>;
begin
  AddSQL(' ' + GetColumnName + ' in ' + GetGroupString(value));
  Result := Return;
end;

function TGroupWhere<EntityType, T>.IsNotIn(
  value: TArray<variant>): IStormWhereCompositor<EntityType, T>;
begin
  AddSQL(' ' + GetColumnName + ' not in ' + GetGroupString(value));
  Result := Return;
end;

end.
