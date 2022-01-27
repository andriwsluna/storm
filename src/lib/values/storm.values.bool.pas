unit storm.values.bool;

interface

Uses
  storm.values.base,
  DFE.Maybe,
  storm.values.interfaces,

  System.JSON,
  System.SysUtils;


type
  TBooleanValue
    = class
    (
       TStormValue
      ,IStormValue
      ,IBooleanValue
    )
    private

    protected
      FValue : boolean;
      Procedure Inititalize();  Override;
    public

      Function  SetValue(value : boolean) : Boolean;
      Function  GetValue() :  Maybe<boolean>;

      Function  Clone(target : IStormValue) : Boolean;

      Function  ToString : Maybe<String>; Reintroduce;
      Function  FromString(value : String) : Boolean;

      Function  ToInt : Maybe<Integer>;
      Function  FromInt(value : Integer) : Boolean;

      Function  ToFloat : Maybe<Extended>;
      Function  FromFloat(Value : Extended) : Boolean;

      Function  ToBool : Maybe<Boolean>;
      Function  FromBool(Value : Boolean) : Boolean;

      Function  ToDateTime : Maybe<TDateTime>;
      Function  FromDateTime(Value : TDateTime) : Boolean;

      Function  ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONValue>;
      Function  FromJSON(Value : TJSONValue) : Boolean;
  end;

implementation

{ TBooleanValue }



function TBooleanValue.Clone(target: IStormValue): Boolean;
begin
  if Assigned(target) then
  begin
    Result := target.ToBool.BindTo<Boolean>(SetValue, FalseByDEfault);
  end
  else
  begin
    Result := false;
  end;
end;

function TBooleanValue.FromBool(Value: Boolean): Boolean;
begin
  result := SetValue(Value);
end;

function TBooleanValue.FromDateTime(Value: TDateTime): Boolean;
begin
  Result := false;
end;

function TBooleanValue.FromFloat(Value: Extended): Boolean;
begin
  if Trunc(value) = 1 then
  begin
    result := SetValue(true);
  end
  else
  if Trunc(value) = 0 then
  begin
    result := SetValue(false);
  end
  else
  begin
    result := false;
  end;

end;

function TBooleanValue.FromInt(value: Integer): Boolean;
begin
  if value = 1 then
  begin
    result := SetValue(true);
  end
  else
  if value = 0 then
  begin
    result := SetValue(false);
  end
  else
  begin
    result := false;
  end;
end;

function TBooleanValue.FromJSON(Value: TJSONValue): Boolean;
begin
  result := LoadFromJSON(self,Value);
end;

function TBooleanValue.FromString(value: String): Boolean;
VAR
  b : boolean;
begin
  if TryStrToBool(Value, b) then
  begin
    Result := SetValue(b);
  end
  else
  begin
    result := false;
  end;

end;

function TBooleanValue.GetValue: Maybe<boolean>;
begin
  if IsAssigned() then
  BEGIN
    Result := FValue;
  END;
end;

procedure TBooleanValue.Inititalize;
begin
  inherited;
end;

function TBooleanValue.ToBool: Maybe<Boolean>;
begin
  Result := GetValue;
end;

function TBooleanValue.ToDateTime: Maybe<TDateTime>;
begin
end;

function TBooleanValue.ToFloat: Maybe<Extended>;
begin
  if self.IsAssigned then
  begin
    if FValue then
    begin
      result := 1.0;
    end
    else
    if not FValue then
    begin
      result := 0.0;
    end;
  end;
end;

function TBooleanValue.ToInt: Maybe<Integer>;
begin
  if self.IsAssigned then
  begin
    if FValue then
    begin
      result := 1;
    end
    else
    if not FValue then
    begin
      result := 0;
    end;
  end;
end;

function TBooleanValue.ToJSON(ConvertNulls : Boolean = false): Maybe<TJSONValue>;
begin
  if IsAssigned then
  begin
    if FValue then
    begin
      result := TJSONTrue.Create();
    end
    else
    begin
      result := TJSONFalse.Create();
    end;
  end
  else
  if ConvertNulls then
  begin
    result := TJSONNull.Create;
  end;
end;

function TBooleanValue.ToString: Maybe<String>;
begin
  if IsAssigned then
  begin
    Result := BoolToStr(Fvalue, true);
  end;
end;


function TBooleanValue.SetValue(value: boolean): Boolean;
begin
  FValue := value;
  FAssigned := true;
  result := FAssigned;
end;

end.
