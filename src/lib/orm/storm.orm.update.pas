unit storm.orm.update;

interface

uses
  storm.orm.base,
  System.SysUtils,
  storm.schema.interfaces,
  storm.orm.interfaces;

type
  IStormGenericReturn<ReturnType> = interface['{0E863C1A-53DB-4F54-8A94-BE8F89D9982C}']
    Function GetGenericInstance(Owner : TStormSQLPartition) : ReturnType;
  end;

  TStormGenericReturn<ReturnType> = class(TStormSQLPartition)
    Function GetReturnInstance(Target : TStormSQLPartition) : ReturnType;
  end;

  TStormGenericColumnSQLPartition<ReturnType> = Class(TStormGenericReturn<ReturnType>)
  protected
    ColumnSchema : IStormSchemaColumn;

    Function GetColumnName : String;
  public
    Constructor Create(Owner : TStormSQLPartition ; Const ColumnSchema : IStormSchemaColumn); Reintroduce;
  End;

  TStormStringFieldAssignment<ReturnType> =
  class(TStormGenericColumnSQLPartition<ReturnType>, IStormStringFieldAssignment<ReturnType>)
    Function SetTo(Const Value : string) : ReturnType;
  end;
implementation



{ TStormGenericReturn<ReturnType> }

function TStormGenericReturn<ReturnType>.GetReturnInstance(
  Target: TStormSQLPartition): ReturnType;
VAR
  provider : IStormGenericReturn<ReturnType>;
begin
  if assigned(Owner) then
  BEGIN
    if Supports(Target, IStormGenericReturn<ReturnType>, Provider) then
    begin
      Result := Provider.GetGenericInstance(Self);
    end
    else
    begin
      Result  := GetReturnInstance(target.Owner);
    end;
  END;
end;

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

{ TStormStringFieldAssignment<ReturnType> }

function TStormStringFieldAssignment<ReturnType>.SetTo(
  const Value: string): ReturnType;
begin
  AddSQL(self.GetColumnName + ' = ' + self.AddParameter(Value));
  Result := self.GetReturnInstance(self.Owner);
end;

end.
