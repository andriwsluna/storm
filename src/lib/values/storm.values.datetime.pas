unit storm.values.datetime;

interface

Uses
  storm.values.base,
  storm.values.float,
  DFE.Maybe,
  storm.values.interfaces,

  System.JSON,
  System.SysUtils;


type
  TDateTimeValue
    = class
    (
       TStormValue
      ,IStormValue
      ,IDateTimeValue
    )
    private

    protected
      FValue : TDateTime;
      Procedure Inititalize();  Override;
    public

      Function  SetValue(value : TDateTime) : Boolean;
      Function  GetValue() :  Maybe<TDateTime>;

      Function  Clone(target : IStormValue) : Boolean;

      Function  ToString : Maybe<String>; Reintroduce; Virtual;
      Function  FromString(value : String) : Boolean;

      Function  ToInt : Maybe<integer>;
      Function  FromInt(value : integer) : Boolean;

      Function  ToFloat : Maybe<Extended>;
      Function  FromFloat(Value : Extended) : Boolean;

      Function  ToBool : Maybe<Boolean>;
      Function  FromBool(Value : Boolean) : Boolean;

      Function  ToDateTime : Maybe<TDateTime>;
      Function  FromDateTime(Value : TDateTime) : Boolean;

      Function  ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONValue>; Virtual;
      Function  FromJSON(Value : TJSONValue) : Boolean;
  end;

implementation

{ TDateTimeValue }



function TDateTimeValue.Clone(target: IStormValue): Boolean;
begin
  if Assigned(target) then
  begin
    Result := target.ToDateTime.BindTo<Boolean>(SetValue, FalseByDEfault);
  end
  else
  begin
    Result := false;
  end;
end;

function TDateTimeValue.FromBool(Value: Boolean): Boolean;
begin
  result := false;
end;

function TDateTimeValue.FromDateTime(Value: TDateTime): Boolean;
begin
  Result := SetValue(Value);
end;

function TDateTimeValue.FromFloat(Value: Extended): Boolean;
begin
  result := SetValue(value);
end;

function TDateTimeValue.FromInt(value: integer): Boolean;
begin
  result := SetValue(value);
end;

function TDateTimeValue.FromJSON(Value: TJSONValue): Boolean;
begin
  result := LoadFromJSON(self,Value);
end;

function TDateTimeValue.FromString(value: String): Boolean;
VAR
  i : TDateTime;
begin
  if TryStrToDateTime(Value, i) then
  begin
    Result := SetValue(i);
  end
  else
  begin
    result := false;
  end;

end;

function TDateTimeValue.GetValue: Maybe<TDateTime>;
begin
  if IsAssigned() then
  BEGIN
    Result := FValue;
  END;
end;

procedure TDateTimeValue.Inititalize;
begin
  inherited;
end;

function TDateTimeValue.ToBool: Maybe<Boolean>;
begin
  
end;

function TDateTimeValue.ToDateTime: Maybe<TDateTime>;
begin
  Result := GetValue;
end;

function TDateTimeValue.ToFloat: Maybe<Extended>;
begin
  if IsAssigned then
  begin
    result := FValue;
  end;
end;

function TDateTimeValue.ToInt: Maybe<integer>;
begin
  if IsAssigned then
  begin
    result := Trunc(FValue);
  end;
end;

function TDateTimeValue.ToJSON(ConvertNulls : Boolean = false): Maybe<TJSONValue>;
begin
  if IsAssigned then
  begin
    result := TJSONString.Create(formatDateTime('yyyy-mm-dd hh:nn:ss',FValue));
  end
  else
  if ConvertNulls then
  begin
    result := TJSONNull.Create;
  end;
end;

function TDateTimeValue.ToString: Maybe<String>;
begin
  if IsAssigned then
  begin
    Result := DateTimeToStr(Fvalue);
  end;
end;


function TDateTimeValue.SetValue(value: TDateTime): Boolean;
begin
  if value > NullDate then
  begin
    FValue := value;
    FAssigned := true;
    result := FAssigned;
  end
  else
  begin
    result := false;
  end;

end;

end.
