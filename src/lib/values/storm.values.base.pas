unit storm.values.base;

interface

USES
  System.JSON,
  DFE.Maybe,
  storm.values.interfaces;

Type
  TStormValue = class abstract (TInterfacedObject)
    private

    protected
      FAssigned : Boolean;

      Procedure Inititalize();  Virtual;

      class function LoadFromJSON(Target : IStormValue ; Value: TJSONValue): Boolean;

    public


      Constructor Create(); Reintroduce;

      Function  IsAssigned() : Boolean;
      Procedure Clear();
  end;



implementation

{ TStormValue }

procedure TStormValue.Clear;
begin
  FAssigned := False;
end;

constructor TStormValue.Create;
begin
  inherited;
  Inititalize();
end;


procedure TStormValue.Inititalize;
begin
  FAssigned := False;
end;

function TStormValue.IsAssigned: Boolean;
begin
  Result := FAssigned;
end;



class function TStormValue.LoadFromJSON(Target: IStormValue;
  Value: TJSONValue): Boolean;
begin
  result := false;

  if Assigned(Target) and Assigned(Value) then
  BEGIN
    if Value is TJSONNumber then
    begin
      Result :=  Target.FromFloat(TJSONNumber(Value).AsDouble);
    end
    else if Value is TJSONString then
    BEGIN
      result :=  Target.FromString(TJSONString(Value).Value);
    END
    else if Value is TJSONBool then
    begin
      Result :=  Target.FromBool(TJSONBool(Value).AsBoolean);
    end
    else if Value is TJSONNull then
    begin
      Target.Clear();
    end;
  END;
end;


end.
