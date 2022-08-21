unit storm.values.date;

interface
Uses
  storm.values.base,
  storm.values.datetime,
  DFE.Maybe,
  storm.values.interfaces,

  System.JSON,
  System.SysUtils;

Type
  TDateValue = Class(TDateTimeValue, IStormValue, IDateValue)
  private

  protected

  public
    Function  SetValue(value : TDate) : Boolean; Reintroduce; Overload;
    Function  SetValue(value : Maybe<TDate>) : Boolean;  Overload;
    Function  GetValue() :  Maybe<TDate>; Reintroduce;
    Function  ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONValue>; Override;
    Function  ToString : Maybe<String>; Override;
  End;

implementation

{ TDateValue }

function TDateValue.GetValue: Maybe<TDate>;
begin
  if IsAssigned() then
  BEGIN
    Result := FValue;
  END;
end;

function TDateValue.SetValue(value: TDate): Boolean;
begin
  result := inherited SetValue(value);
end;

function TDateValue.SetValue(value: Maybe<TDate>): Boolean;
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

function TDateValue.ToJSON(ConvertNulls: Boolean): Maybe<TJSONValue>;
begin
  if IsAssigned then
  begin
    result := TJSONString.Create(formatDateTime('yyyy-mm-dd',FValue));
  end
  else
  if ConvertNulls then
  begin
    result := TJSONNull.Create;
  end;
end;

function TDateValue.ToString: Maybe<String>;
begin
  if IsAssigned then
  begin
    Result := DateToStr(Fvalue);
  end;
end;

end.
