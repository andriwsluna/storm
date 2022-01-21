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



  TStormWhereSelection<WhereType : TStormSQLPartition>
  = class(TStormSQLPartition)
  public
    Function OpenParentheses() : WhereType;
    Function CloseParentheses() : WhereType;
  end;

  TStormWhereCompositor
  <
    WhereType : TStormSqlPartition;
    ExecutorType : TStormSqlPartition
  > = class
  (
    TStormSqlPartition,
    IStormWhereCompositor<WhereType,ExecutorType>
  )
  public
    Function And_() : WhereType;
    Function Or_()  : WhereType;
    Function OpenParentheses() : WhereType;
    Function Go : ExecutorType;
    Function CloseParentheses() : IStormWhereCompositor<WhereType, ExecutorType>;
  end;

  TStormWhereBase
  <
    WhereType : TStormSQLPartition;
    ExecutorType : TStormSQLPartition
  > = class abstract(TStormSQLPartition)
  private

  protected
    FTable : IStormTableSchema;
    FColumn : IStormSchemaColumn;
    Constructor create
    (
      owner : TStormSQLPartition;
      Table : IStormTableSchema ;
      column : IStormSchemaColumn
    ); Reintroduce; Virtual;

    Function GetColumnName : string;

    Function Return : IStormWhereCompositor<WhereType,ExecutorType>;

  public

  end;

  TWhereNode
  <
    WhereType : TStormSqlPartition
  > = class(TStormSqlPartition, IWhereNode<WhereType>)
  public
    Function Where : WhereType;
  end;

  TStormFieldSelection
  <
    WhereType : TStormSQLPartition;
    ExecutorType : TStormSQLPartition
  > = class abstract
  (
    TStormWhereBase<WhereType, ExecutorType>,
    IStormFieldSelection<WhereType>
  )
  protected
    Function From() : IWhereNode<WhereType>;
  public
    Function All() : IWhereNode<WhereType>;
  end;

  TNullableWhere
  <
    WhereType : TStormSQLPartition;
    ExecutorType : TStormSQLPartition
  > = class(TStormWhereBase<WhereType, ExecutorType>)
  private

  public

  public
    Function IsNull : IStormWhereCompositor<WhereType,ExecutorType>;
    Function IsNotNull : IStormWhereCompositor<WhereType,ExecutorType>;
  end;

  TEqualWhere
  <
    WhereType : TStormSQLPartition;
    ExecutorType : TStormSQLPartition
  > = class(TStormWhereBase<WhereType, ExecutorType>)
    private

    public

    public
      Function IsEqualsTo(value : variant) : IStormWhereCompositor<WhereType,ExecutorType>;
      Function NotIsEqualsTo(value : variant) : IStormWhereCompositor<WhereType,ExecutorType>;
  end;

  TGroupWhere
  <
  WhereType : TStormSQLPartition;
  ExecutorType : TStormSQLPartition
  > = class(TStormWhereBase<WhereType, ExecutorType>)
  private
    Function GetGroupString(values : TArray<variant>) : string;
  public

  public
    Function IsIn(value : TArray<variant>) : IStormWhereCompositor<WhereType,ExecutorType>;
    Function IsNotIn(value : TArray<variant>) : IStormWhereCompositor<WhereType,ExecutorType>;
  end;


  TStringWhere
  <
   WhereType : TStormSQLPartition;
   ExecutorType : TStormSQLPartition
  > = class
  (
    TStormWhereBase<WhereType,ExecutorType>,
    IStringWhere<IStormWhereCompositor<WhereType,ExecutorType>>
  )
  private
    Function ConvertoToArrayOfVariant(values : TArray<string>) : TArray<variant>;
  protected

  public
    Function IsEqualsTo(value : string) : IStormWhereCompositor<WhereType,ExecutorType>;
    Function NotIsEqualsTo(value : string) : IStormWhereCompositor<WhereType,ExecutorType>;

    Function BeginsWith(value : string) : IStormWhereCompositor<WhereType,ExecutorType>;
    Function Contains(value : string) : IStormWhereCompositor<WhereType,ExecutorType>;
    Function EndsWith(value : string) : IStormWhereCompositor<WhereType,ExecutorType>;

    Function IsIn(value : TArray<String>) : IStormWhereCompositor<WhereType,ExecutorType>;
    Function IsNotIn(value :TArray<String>) : IStormWhereCompositor<WhereType,ExecutorType>;
  end;

  TNullableStringWhere
  <
    WhereType : TStormSQLPartition;
    ExecutorType : TStormSQLPartition
  > = class
  (
    TStringWhere<WhereType,ExecutorType>,
    INullableStringWhere<IStormWhereCompositor<WhereType,ExecutorType>>
  )
  private

  protected

  public
    Function IsNull : IStormWhereCompositor<WhereType,ExecutorType>;
    Function IsNotNull : IStormWhereCompositor<WhereType,ExecutorType>;
  end;
















implementation



function TStormWhereCompositor<WhereType, ExecutorType>.And_: WhereType;
begin
  AddSQL(' and');
  Result := WhereType.Create(self);
end;

function TStormWhereCompositor<WhereType, ExecutorType>.CloseParentheses: IStormWhereCompositor<WhereType, ExecutorType>;
begin
  AddSQL(' )');
  Result := TStormWhereCompositor<WhereType, ExecutorType>.Create(self);
end;

function TStormWhereCompositor<WhereType, ExecutorType>.Go: ExecutorType;
begin
  Result := ExecutorType.Create(Self);
end;

function TStormWhereCompositor<WhereType, ExecutorType>.OpenParentheses: WhereType;
begin
  AddSQL(' (');
  Result := WhereType.Create(self);
end;

function TStormWhereCompositor<WhereType, ExecutorType>.Or_: WhereType;
begin
  AddSQL(' or');
  Result := WhereType.Create(self);
end;

{ TStormWhereBase<T> }

constructor TStormWhereBase<WhereType, ExecutorType>.create(owner : TStormSQLPartition; Table : IStormTableSchema ;column: IStormSchemaColumn);
begin
  inherited create(owner);
  FTable := Table;
  FColumn := column;
end;



{ TWhereNode<T> }

function TWhereNode<WhereType>.Where: WhereType;
VAR
  i : IInterface;
begin
  AddSQL(' where');
  Result := WhereType.Create(self);
end;

{ TStormFieldSelection<T> }

function TStormFieldSelection<WhereType, ExecutorType>.All: IWhereNode<WhereType>;
begin
  AddSQL(' *');
  result := From;
end;

function TStormFieldSelection<WhereType, ExecutorType>.From: IWhereNode<WhereType>;
begin
  AddSQL(' from ' + SQLDriver.GetFullTableName(FTable));
  result := TWhereNode<WhereType>.Create(self);
end;

function TStormWhereBase<WhereType, ExecutorType>.GetColumnName: string;
begin
  Result := FTable.GetTableName + '.' + FColumn.GetColumnName;
end;

function TStormWhereBase<WhereType, ExecutorType>.Return: IStormWhereCompositor<WhereType, ExecutorType>;
begin
  Result := TStormWhereCompositor<WhereType, ExecutorType>.Create(self);
end;

{ TStormWhereSelection<T> }

function TStormWhereSelection<WhereType>.CloseParentheses: WhereType;
begin
  AddSQL(' )');
  Result := WhereType.Create(self);
end;

function TStormWhereSelection<WhereType>.OpenParentheses: WhereType;
begin
  AddSQL(' (');
  Result := WhereType.Create(self);
end;

{ TNullableWhere<T> }

function TNullableWhere<WhereType, ExecutorType>.IsNotNull: IStormWhereCompositor<WhereType, ExecutorType>;
begin
  AddSQL(' ' + GetColumnName + ' is not null');
  Result := Return;
end;

function TNullableWhere<WhereType, ExecutorType>.IsNull: IStormWhereCompositor<WhereType, ExecutorType>;
begin
  AddSQL(' ' + GetColumnName + ' is null');
  Result := Return;
end;

{ TEqualWhere<T> }

function TEqualWhere<WhereType, ExecutorType>.IsEqualsTo(value : variant): IStormWhereCompositor<WhereType, ExecutorType>;
begin
  AddSQL(' ' + GetColumnName + ' = ' + AddParameter(value));
  Result := Return;
end;

function TEqualWhere<WhereType, ExecutorType>.NotIsEqualsTo(value : variant): IStormWhereCompositor<WhereType, ExecutorType>;
begin
  AddSQL(' ' + GetColumnName + ' <> ' + AddParameter(value));
  Result := Return;
end;

{ TStringWhere<T> }

function TStringWhere<WhereType, ExecutorType>.BeginsWith(value: string): IStormWhereCompositor<WhereType, ExecutorType>;
begin
  AddSQL(' ' + GetColumnName + ' like ' + AddParameter(value + '%'));
  Result := Return;
end;

function TStringWhere<WhereType, ExecutorType>.Contains(value: string): IStormWhereCompositor<WhereType, ExecutorType>;
begin
  AddSQL(' ' + GetColumnName + ' like ' + AddParameter('%' + value + '%'));
  Result := Return;
end;

function TStringWhere<WhereType, ExecutorType>.ConvertoToArrayOfVariant(
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

function TStringWhere<WhereType, ExecutorType>.EndsWith(value: string): IStormWhereCompositor<WhereType, ExecutorType>;
begin
  AddSQL(' ' + GetColumnName + ' like ' + AddParameter('%' + value));
  Result := Return;
end;

function TStringWhere<WhereType, ExecutorType>.IsEqualsTo(value: string): IStormWhereCompositor<WhereType, ExecutorType>;
begin
  Result := TEqualWhere<WhereType, ExecutorType>.create(self, FTable, FColumn).IsEqualsTo(value);
end;


function TStringWhere<WhereType, ExecutorType>.IsIn(value: TArray<String>): IStormWhereCompositor<WhereType, ExecutorType>;
begin
  Result := TGroupWhere<WhereType, ExecutorType>.create(self, FTable, FColumn).IsIn(ConvertoToArrayOfVariant(value));
end;

function TStringWhere<WhereType, ExecutorType>.IsNotIn(
  value: TArray<String>): IStormWhereCompositor<WhereType, ExecutorType>;
begin
   Result := TGroupWhere<WhereType, ExecutorType>.create(self, FTable, FColumn).IsNotIn(ConvertoToArrayOfVariant(value));
end;

function TStringWhere<WhereType, ExecutorType>.NotIsEqualsTo(value: string): IStormWhereCompositor<WhereType, ExecutorType>;
begin
  Result := TEqualWhere<WhereType, ExecutorType>.create(self, FTable, FColumn).NotIsEqualsTo(value);
end;

{ TNullableStringWhere<T> }

function TNullableStringWhere<WhereType, ExecutorType>.IsNotNull: IStormWhereCompositor<WhereType, ExecutorType>;
begin
  Result := TNullableWhere<WhereType, ExecutorType>.create(self, FTable, FColumn).IsNotNull;
end;

function TNullableStringWhere<WhereType, ExecutorType>.IsNull: IStormWhereCompositor<WhereType, ExecutorType>;
begin
  Result := TNullableWhere<WhereType, ExecutorType>.create(self, FTable, FColumn).IsNull;
end;

{ TGroupWhere<T> }

function TGroupWhere<WhereType, ExecutorType>.GetGroupString(values: TArray<variant>): string;
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

function TGroupWhere<WhereType, ExecutorType>.IsIn(value: TArray<variant>): IStormWhereCompositor<WhereType, ExecutorType>;
begin
  AddSQL(' ' + GetColumnName + ' in ' + GetGroupString(value));
  Result := Return;
end;

function TGroupWhere<WhereType, ExecutorType>.IsNotIn(
  value: TArray<variant>): IStormWhereCompositor<WhereType, ExecutorType>;
begin
  AddSQL(' ' + GetColumnName + ' not in ' + GetGroupString(value));
  Result := Return;
end;

end.
