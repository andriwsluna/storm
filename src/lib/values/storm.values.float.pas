unit storm.values.float;

interface

Uses
  storm.values.base,
  DFE.Maybe,
  storm.values.interfaces,

  System.JSON,
  System.SysUtils;

Const NullDate = -700000;
type
  TFloatValue
    = class
    (
       TStormValue
      ,IStormValue
      ,IFloatValue
    )
    private

    protected
      FValue : Extended;
      Procedure Inititalize();  Override;
    public

      Function  SetValue(value : Extended) : Boolean;
      Function  SetThisOrClear(value : Maybe<Extended>) : Boolean;
      Function  GetValue() :  Maybe<Extended>;

      Function  Clone(target : IStormValue) : Boolean;

      Function  ToString : Maybe<String>; Reintroduce;
      Function  FromString(value : String) : Boolean;

      Function  ToInt : Maybe<integer>;
      Function  FromInt(value : integer) : Boolean;

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

{ TFloatValue }



function TFloatValue.Clone(target: IStormValue): Boolean;
begin
  if Assigned(target) then
  begin
    Result := target.ToFloat.BindTo<Boolean>(SetValue,FalseByDefault);
  end
  else
  begin
    Result := false;
  end;
end;

function TFloatValue.FromBool(Value: Boolean): Boolean;
begin
  if Value then
  begin
    result := SetValue(1);
  end
  else
  begin
    result := SetValue(0);
  end;
end;

function TFloatValue.FromDateTime(Value: TDateTime): Boolean;
begin
  result := FromFloat(Value);
end;

function TFloatValue.FromFloat(Value: Extended): Boolean;
begin
  result := SetValue(value);
end;

function TFloatValue.FromInt(value: integer): Boolean;
begin
  result := SetValue(value);
end;

function TFloatValue.FromJSON(Value: TJSONValue): Boolean;
begin
  result := LoadFromJSON(self,Value);
end;

function TFloatValue.FromString(value: String): Boolean;
VAR
  i : Extended;
begin
  if TryStrToFloat(Value, i) then
  begin
    Result := SetValue(i);
  end
  else
  begin
    result := false;
  end;

end;

function TFloatValue.GetValue: Maybe<Extended>;
begin
  if IsAssigned() then
  BEGIN
    Result := FValue;
  END;
end;

procedure TFloatValue.Inititalize;
begin
  inherited;
end;

function TFloatValue.ToBool: Maybe<Boolean>;
begin
  if self.IsAssigned then
  begin
    if FValue = 1.0 then
    begin
      result := true;
    end
    else
    if FValue = 0 then
    begin
      result := false;
    end;
  end;
end;

function TFloatValue.ToDateTime: Maybe<TDateTime>;
begin
  if IsAssigned then
  begin
    if FValue > NullDate then
    begin
      result := TDateTime(FValue);
    end;
  end;
end;

function TFloatValue.ToFloat: Maybe<Extended>;
begin
  result := GetValue;

end;

function TFloatValue.ToInt: Maybe<integer>;
begin
  if IsAssigned then
  begin
    result := Trunc(FValue);
  end;
end;

function TFloatValue.ToJSON(ConvertNulls : Boolean = false): Maybe<TJSONValue>;
begin
  if IsAssigned then
  begin
    result := TJSONNumber.Create(FValue);
  end
  else
  if ConvertNulls then
  begin
    result := TJSONNull.Create;
  end;
end;

function TFloatValue.ToString: Maybe<String>;
begin
  if IsAssigned then
  begin
    Result := FloatToStr(Fvalue);
  end;
end;


function TFloatValue.SetThisOrClear(value: Maybe<Extended>): Boolean;
begin
  Result := value
  .BindTo<Boolean>
  (
    self.SetValue,
    function : boolean
    begin
      self.Clear;
      result := true;
    end
  ) ;

end;

function TFloatValue.SetValue(value: Extended): Boolean;
begin
  FValue := value;
  FAssigned := true;
  result := FAssigned;
end;

end.
