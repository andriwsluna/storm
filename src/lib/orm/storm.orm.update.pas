unit storm.orm.update;

interface

uses
  storm.orm.base,
  System.SysUtils,
  storm.schema.interfaces,
  storm.orm.interfaces;

type
  



  TStormGenericColumnSQLPartition<ReturnType> = Class(TStormSqlPartition)
  protected

    ColumnSchema : IStormSchemaColumn;

    Function GetColumnName : String;
    Function GetReturn : ReturnType;
  public
    Constructor Create(Owner : TStormSQLPartition ; Const ColumnSchema : IStormSchemaColumn); Reintroduce;
  End;

  TStormStringFieldAssignment<ReturnType> =
  class(TStormGenericColumnSQLPartition<ReturnType>, IStormStringFieldAssignment<ReturnType>)
    Function SetTo(Const Value : string) : ReturnType;
  end;
implementation


{ TStormGenericColumnSQLPartition<ReturnType> }

constructor TStormGenericColumnSQLPartition<ReturnType>.Create(
  Owner: TStormSQLPartition; const ColumnSchema: IStormSchemaColumn);
begin
  inherited create(Owner);
  self.ColumnSchema := ColumnSchema;
end;

function TStormGenericColumnSQLPartition<ReturnType>.GetColumnName: String;
begin
  Result := TableSchema.GetTableName + '.' + ColumnSchema.GetColumnName;
end;

function TStormGenericColumnSQLPartition<ReturnType>.GetReturn: ReturnType;
var
  provider : TStormGenericReturn;
begin
  provider := TStormGenericReturn.Create;
  try
    Result := (provider.GetReturnInstance<ReturnType>(self) as IStormGenericReturn<ReturnType>).GetGenericInstance(self);
  finally
    provider.Free;
  end;

end;

{ TStormStringFieldAssignment<ReturnType> }

function TStormStringFieldAssignment<ReturnType>.SetTo(
  const Value: string): ReturnType;
begin
  AddSQL(self.GetColumnName + ' = ' + self.AddParameter(Value));
  Result := self.GetReturn;
end;

end.
