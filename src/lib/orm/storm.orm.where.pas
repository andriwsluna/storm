unit storm.orm.where;

interface
Uses
  storm.orm.base,
  storm.additional.maybe,
  storm.orm.interfaces,
  storm.schema.interfaces,

  System.Sysutils, System.Classes;

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
    Function OpenParentheses() : IStormWhereCompositor<T>;
    Function CloseParentheses() : IStormWhereCompositor<T>;
  end;

  TStormWhereBase = class abstract(TStormSQLPartition)
  private

  protected
    FTable : IStormTableSchema;
    FColumn : IStormSchemaColumn;
    Constructor create(owner : TStormSQLPartition; Table : IStormTableSchema ; column : IStormSchemaColumn); Reintroduce; Virtual;

    Function GetColumnName : string;
  public

  end;

  TWhereNode<T : TStormQueryPartition> = class(TStormQueryPartition, IWhereNode<T>)
  public
    Function Where : T;
  end;

  TStormFieldSelection<T : TStormQueryPartition> = class abstract(TStormWhereBase, IStormFieldSelection<T>)
  protected
    Function From() : IWhereNode<T>;
  public
    Function All() : IWhereNode<T>;
  end;

  TStringWhere<T : TStormQueryPartition> = class(TStormWhereBase, IStringWhere<T>)
  private

  public

  public
    Function EqualsTo(str : string) : IStormWhereCompositor<T>;
    Function NotEqualsTo(str : string) : IStormWhereCompositor<T>;
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

function TStormWhereCompositor<T>.OpenParentheses: IStormWhereCompositor<T>;
begin
  AddSQL(' (');
  Result := TStormWhereCompositor<T>.Create(self);
end;

function TStormWhereCompositor<T>.Or_: T;
begin
  AddSQL(' or');
  Result := T.Create(self);
end;

{ TStormWhereBase<T> }

constructor TStormWhereBase.create(owner : TStormSQLPartition; Table : IStormTableSchema ;column: IStormSchemaColumn);
begin
  inherited create(owner);
  FTable := Table;
  FColumn := column;
end;

{ TStringWhere<T> }

function TStringWhere<T>.EqualsTo(str: string): IStormWhereCompositor<T>;
begin
  AddSQL(' ' + GetColumnName + ' = ' + AddParameter(str));
  Result := TStormWhereCompositor<T>.Create(self);
end;

function TStringWhere<T>.NotEqualsTo(str: string): IStormWhereCompositor<T>;
begin
  AddSQL(' ' + GetColumnName + ' <> ' + AddParameter(str));
  Result := TStormWhereCompositor<T>.Create(self);
end;

{ TWhereNode<T> }

function TWhereNode<T>.Where: T;
begin
  AddSQL(' where');
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

function TStormWhereBase.GetColumnName: string;
begin
  Result := FTable.GetTableName + '.' + FColumn.GetColumnName;
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

end.
