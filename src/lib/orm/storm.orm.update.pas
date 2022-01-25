unit storm.orm.update;

interface

uses
  storm.orm.base,
  System.SysUtils,
  storm.schema.interfaces,
  storm.orm.interfaces;

type



  TStormStringFieldAssignment<ReturnType> =
  class(TStormGenericColumnSQLPartition<ReturnType>, IStormStringFieldAssignment<ReturnType>)
    Function SetTo(Const Value : string) : ReturnType;
  end;
implementation




{ TStormStringFieldAssignment<ReturnType> }

function TStormStringFieldAssignment<ReturnType>.SetTo(
  const Value: string): ReturnType;
begin
  AddSQL(self.GetColumnName + ' = ' + self.AddParameter(Value));
  Result := self.GetReturn;
end;

end.
