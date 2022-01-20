unit storm.values.str;

interface

Uses
  storm.values.base,
  DFE.Maybe,
  storm.values.interfaces,

  System.JSON,
  System.SysUtils;


type
  TStringValue
    = class
    (
      TStormValue,
      IStormValue,
      IStringValue
    )
    private

    protected
      FValue : String;
      Procedure Inititalize();  Override;
    public

      Function  SetValue(value : String) : Boolean;
      Function  GetValue() :  Maybe<String>;

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

{ TIntegerValue }



function TStringValue.Clone(target: IStormValue): Boolean;
begin
  if Assigned(target) then
  begin
    Result := target.ToString.Bind(SetValue);
  end
  else
  begin
    Result := false;
  end;
end;

function TStringValue.FromBool(Value: Boolean): Boolean;
begin
  result := SetValue(BoolToStr(value, true));
end;

function TStringValue.FromDateTime(Value: TDateTime): Boolean;
begin
  result := SetValue(DateTimeToStr(value));
end;

function TStringValue.FromFloat(Value: Extended): Boolean;
begin
  result := SetValue(FloatToStr(value));
end;

function TStringValue.FromInt(value: Integer): Boolean;
begin
  result := SetValue(IntToStr(value));
end;

function TStringValue.FromJSON(Value: TJSONValue): Boolean;
begin
  if assigned(Value) then
  begin
    result := LoadFromJSON(self,Value);
  end
  else
  begin
    result := false;
  end;


end;

function TStringValue.FromString(value: String): Boolean;
begin
  Result := SetValue(value);
end;

function TStringValue.GetValue: Maybe<String>;
begin
  if IsAssigned() then
  BEGIN
    Result := FValue;
  END;
end;

procedure TStringValue.Inititalize;
begin
  inherited;
end;

function TStringValue.ToBool: Maybe<Boolean>;
VAR
  return : Boolean;
begin
  if IsAssigned then
  begin
    if TryStrToBool(FValue,return) then
    begin
      result := return;
    end;
  end;
end;

function TStringValue.ToDateTime: Maybe<TDateTime>;
VAR
  return : TDateTime;
begin
  if IsAssigned then
  begin
    if TryStrToDateTime(FValue,return) then
    begin
      result := return;
    end;
  end;

end;

function TStringValue.ToFloat: Maybe<Extended>;
VAR
  return : Extended;
begin
  if IsAssigned then
  begin
    if TryStrToFloat(FValue,return) then
    begin
      result := return;
    end;
  end;

end;

function TStringValue.ToInt: Maybe<Integer>;
VAR
  return : integer;
begin
  if IsAssigned then
  begin
    if TryStrToInt(FValue,return) then
    begin
      result := return;
    end;
  end;
end;

function TStringValue.ToJSON(ConvertNulls : Boolean = false): Maybe<TJSONValue>;
begin
  if IsAssigned then
  begin
    result := TJSONString.Create(FValue);
  end
  else
  if ConvertNulls then
  begin
    result := TJSONNull.Create;
  end;
end;

function TStringValue.ToString: Maybe<String>;
begin
  result := GetValue();
end;


function TStringValue.SetValue(value: String): Boolean;
begin
  FValue := value;
  FAssigned := true;
  result := FAssigned;
end;

end.
