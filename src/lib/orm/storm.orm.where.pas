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
  TStormNullWhere<ReturnType, SubReturnType: IInterface> = class(TStormGeneric2ColumnSQLPartition<ReturnType, SubReturnType>)
  protected
    Function IsNull : ReturnType;
    Function IsNotNull : ReturnType;
  end;

  TStormEqualWhere<ReturnType, SubReturnType: IInterface> = class(TStormGeneric2ColumnSQLPartition<ReturnType, SubReturnType>)
  protected
    Function IsEqualsTo(Const Value : variant) : ReturnType;
    Function IsNotEqualsTo(Const Value : variant) : ReturnType;
  end;


  TStormStringWhere<ReturnType, SubReturnType: IInterface>
  = class
  (
    TStormGeneric2ColumnSQLPartition<ReturnType, SubReturnType>,
    IStormStringWhere<ReturnType, SubReturnType>
  )
  public
    Function IsEqualsTo(Const Value : string) : ReturnType;
    Function IsNotEqualsTo(Const Value : string) : ReturnType;
  end;

  TStormStringNullableWhere<ReturnType, SubReturnType: IInterface> = class(TStormStringWhere<ReturnType, SubReturnType>)
  public
    Function IsNull : ReturnType;
    Function IsNotNull : ReturnType;
  end;



implementation

{ TNullableWhere }


{ TEqualWhere }


{ TStormStringWhere<ReturnType> }

function TStormStringWhere<ReturnType, SubReturnType>.IsEqualsTo(
  const Value: string): ReturnType;
begin
  result := TStormEqualWhere<ReturnType, SubReturnType>
  .Create(self,self.ColumnSchema).IsEqualsTo(Value);
end;

function TStormStringWhere<ReturnType, SubReturnType>.IsNotEqualsTo(
  const Value: string): ReturnType;
begin
  result := TStormEqualWhere<ReturnType, SubReturnType>
  .Create(self,self.ColumnSchema).IsNotEqualsTo(Value);
end;

{ TStormEqualWhere<ReturnType, SubReturnType> }

function TStormEqualWhere<ReturnType, SubReturnType>.IsEqualsTo(
  const Value: variant): ReturnType;
begin
  AddSQL(self.GetColumnName + ' = ' + self.AddParameter(Value));
  Result := self.GetReturn;
end;

function TStormEqualWhere<ReturnType, SubReturnType>.IsNotEqualsTo(
  const Value: variant): ReturnType;
begin
  AddSQL(self.GetColumnName + ' <> ' + self.AddParameter(Value));
  Result := self.GetReturn;
end;

{ TStormNullWhere<ReturnType, SubReturnType> }

function TStormNullWhere<ReturnType, SubReturnType>.IsNotNull: ReturnType;
begin
  AddSQL(self.GetColumnName + ' IS NOT NULL');
  Result := self.GetReturn;
end;

function TStormNullWhere<ReturnType, SubReturnType>.IsNull: ReturnType;
begin
  AddSQL(self.GetColumnName + ' IS NULL');
  Result := self.GetReturn;
end;

{ TStormStringNullableWhere<ReturnType, SubReturnType> }

function TStormStringNullableWhere<ReturnType, SubReturnType>.IsNotNull: ReturnType;
begin
  Result := TStormNullWhere<ReturnType, SubReturnType>.Create(self,self.ColumnSchema).IsNotNull;
end;

function TStormStringNullableWhere<ReturnType, SubReturnType>.IsNull: ReturnType;
begin
  Result := TStormNullWhere<ReturnType, SubReturnType>.Create(self,self.ColumnSchema).IsNull;
end;

end.
