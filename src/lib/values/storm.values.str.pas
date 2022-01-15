unit storm.values.str;

interface

Uses
  storm.values.base,
  storm.additional.maybe,
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
      FValue : String;
    protected
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
  result := LoadFromJSON(self,Value);
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
  if TryStrToBool(FValue,return) then
  begin
    result := return;
  end;
end;

function TStringValue.ToFloat: Maybe<Extended>;
VAR
  return : Extended;
begin
  if TryStrToFloat(FValue,return) then
  begin
    result := return;
  end;
end;

function TStringValue.ToInt: Maybe<Integer>;
VAR
  return : integer;
begin
  if TryStrToInt(FValue,return) then
  begin
    result := return;
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
