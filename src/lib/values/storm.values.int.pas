unit storm.values.int;

interface

Uses
  storm.values.base,
  DFE.Maybe,
  storm.values.interfaces,

  System.JSON,
  System.SysUtils;


type
  TIntegerValue
    = class
    (
       TStormValue
      ,IStormValue
      ,IIntegerValue
    )
    private

    protected
      FValue : integer;
      Procedure Inititalize();  Override;
    public

      Function  SetValue(value : integer) : Boolean; Overload;
      Function  SetValue(value : Maybe<integer>) : Boolean;  Overload;
      Function  GetValue() :  Maybe<integer>;

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



function TIntegerValue.Clone(target: IStormValue): Boolean;
begin
  if Assigned(target) then
  begin
    Result := target.ToInt.BindTo<Boolean>(SetValue, Function() : Boolean
        begin
          result := false;
        end);
  end
  else
  begin
    Result := false;
  end;
end;

function TIntegerValue.FromBool(Value: Boolean): Boolean;
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

function TIntegerValue.FromDateTime(Value: TDateTime): Boolean;
begin
  result := FromFloat(Value);
end;

function TIntegerValue.FromFloat(Value: Extended): Boolean;
begin
  result := SetValue(Trunc(value));
end;

function TIntegerValue.FromInt(value: Integer): Boolean;
begin
  result := SetValue(value);
end;

function TIntegerValue.FromJSON(Value: TJSONValue): Boolean;
begin
  result := LoadFromJSON(self,Value);
end;

function TIntegerValue.FromString(value: String): Boolean;
VAR
  i : integer;
begin
  if TryStrToInt(Value, i) then
  begin
    Result := SetValue(i);
  end
  else
  begin
    result := false;
  end;
end;

function TIntegerValue.GetValue: Maybe<integer>;
begin
  if IsAssigned() then
  BEGIN
    Result := FValue;
  END;
end;

procedure TIntegerValue.Inititalize;
begin
  inherited;
end;

function TIntegerValue.SetValue(value: Maybe<integer>): Boolean;
begin
  Result := Value
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

function TIntegerValue.ToBool: Maybe<Boolean>;
begin
  if self.IsAssigned then
  begin
    if FValue = 1 then
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

function TIntegerValue.ToDateTime: Maybe<TDateTime>;
VAR
  return : TDateTime;
begin
  if IsAssigned then
  begin
    if TryFloatToDateTime(FValue,return) then
    begin
      result := return;
    end;
  end;

end;
function TIntegerValue.ToFloat: Maybe<Extended>;
begin
  if IsAssigned then
  begin
    result := FValue;
  end;
end;

function TIntegerValue.ToInt: Maybe<Integer>;
begin
  result := GetValue;
end;

function TIntegerValue.ToJSON(ConvertNulls : Boolean = false): Maybe<TJSONValue>;
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

function TIntegerValue.ToString: Maybe<String>;
begin
  if IsAssigned then
  begin
    Result := IntToStr(Fvalue);
  end;
end;


function TIntegerValue.SetValue(value: integer): Boolean;
begin
  FValue := value;
  FAssigned := true;
  result := FAssigned;
end;

end.
