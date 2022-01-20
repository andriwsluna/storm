unit storm.values.datetime.test;

interface
uses

  storm.values.float,
  storm.values.datetime,
  storm.values.interfaces,

  System.Classes, System.SysUtils,
  DUnitX.TestFramework;

{$TYPEINFO ON}
Type
  TDateTimeValue_Testable = class(TDateTimeValue)

  end;

  [TestFixture]
  TDateTimeValue_Test = class
  private
    FDateTimeValue : IDateTimeValue;
    Function myValue :TDateTimeValue_Testable;
  public
    [Setup]
    procedure Setup;


  published
    Procedure SetValue_Check();
    Procedure SetValue_Blank_Check();

    Procedure GetValue_Check();
    Procedure Clone_Check();
    Procedure ToString_check();
    Procedure FromString_Check();
    Procedure ToInt_Check();
    Procedure FromInt_Check();
    Procedure ToFloat_Check();
    Procedure FromFloat_Check();
    Procedure ToBool_Check();
    Procedure FromBool_Check();
    Procedure ToJson_Check();
    Procedure FromJson_Check();
    Procedure ToDateTime_Check();
    Procedure FromDateTime_Check();
  end;


{$TYPEINFO OFF}
implementation

Uses
  System.JSON;

{ TDateTimeValue_Test }

procedure TDateTimeValue_Test.Clone_Check;
VAR
  v : tdatetime;
  Target : IDateTimeValue;
begin
  v := now;
  Target := TDateTimeValue.Create;
  Assert.IsFalse(FDateTimeValue.Clone(nil));
  Assert.IsFalse(FDateTimeValue.Clone(Target));
  Assert.IsFalse(FDateTimeValue.IsAssigned);
  Target.SetValue(v);
  Assert.Istrue(FDateTimeValue.Clone(Target));
  Assert.Istrue(FDateTimeValue.IsAssigned);
  Assert.AreEqual(v, myValue.FValue);
end;

procedure TDateTimeValue_Test.FromBool_Check;
begin
  Assert.IsFalse(FDateTimeValue.FromBool(true));
  Assert.IsFalse(FDateTimeValue.FromBool(false));
end;

procedure TDateTimeValue_Test.FromDateTime_Check;
VAR
  data  : TDatetime;
begin
  data := now;
  Assert.IsTrue(myValue.FromDateTime(data));
  Assert.IsTrue(myValue.IsAssigned);
  Assert.AreEqual(data, myValue.FValue);
end;

procedure TDateTimeValue_Test.FromFloat_Check;
Const
  number  = 1.5989;
begin
  Assert.IsTrue(FDateTimeValue.FromFloat(number));
  Assert.IsTrue(FDateTimeValue.IsAssigned);
  Assert.AreEqual(TDateTime(number), myValue.FValue);
end;

procedure TDateTimeValue_Test.FromInt_Check;
Const
  number  = 8989.15;
begin
  Assert.IsTrue(FDateTimeValue.FromInt(trunc(number)));
  Assert.IsTrue(FDateTimeValue.IsAssigned);
  Assert.AreEqual(TDateTime(trunc(number)), myValue.FValue);
end;

procedure TDateTimeValue_Test.FromJson_Check;
begin
  Assert.IsFalse(FDateTimeValue.FromJSON(nil));
  Assert.IsFalse(FDateTimeValue.FromJSON(TJSONNull.Create));
end;

procedure TDateTimeValue_Test.FromString_Check;
const
    invalid = 'a';
var
  valid : string;
begin
  valid := DateTimeToStr(now);
  Assert.IsTrue(FDateTimeValue.FromString(valid));
  Assert.AreEqual(StrToDateTime(valid),myValue.FValue);
  Assert.IsFalse(FDateTimeValue.FromString(invalid));
end;

procedure TDateTimeValue_Test.GetValue_Check;
var
  v  : TDateTime;
  NewV : TDateTime;
begin
  v := now;
  Assert.IsFalse(FDateTimeValue.GetValue.IsSome);
  FDateTimeValue.SetValue(v);
  Assert.IsTrue(FDateTimeValue.GetValue.IsSome);
  FDateTimeValue.GetValue.OnSome
  (
    procedure(i : TDateTime)
    begin
      NewV := i;
    end
  );
  Assert.AreEqual(v,NewV);
  FDateTimeValue.Clear;
  Assert.IsFalse(FDateTimeValue.GetValue.IsSome);
end;

function TDateTimeValue_Test.myValue: TDateTimeValue_Testable;
begin
  Result := FDateTimeValue as TDateTimeValue_Testable;
end;

procedure TDateTimeValue_Test.Setup;
begin
  FDateTimeValue := TDateTimeValue_Testable.Create;
end;

procedure TDateTimeValue_Test.SetValue_Blank_Check;
Var
  v  : TDateTime;
begin
  v := now;
  assert.IsTrue(FDateTimeValue.SetValue(v));
  assert.IsTrue(myValue.FAssigned);
  assert.AreEqual(v, myValue.FValue);
end;

procedure TDateTimeValue_Test.SetValue_Check;
Var
  v  : TDateTime;
begin
  v := now;
  assert.IsTrue(FDateTimeValue.SetValue(v));
  assert.IsTrue(myValue.FAssigned);
  assert.AreEqual(v, myValue.FValue);
end;


procedure TDateTimeValue_Test.ToBool_Check;
begin
  Assert.IsFalse(FDateTimeValue.ToBool.IsSome);
  FDateTimeValue.SetValue(now);
  Assert.IsFalse(FDateTimeValue.ToBool.IsSome);
end;

procedure TDateTimeValue_Test.ToDateTime_Check;
Const
  Invalid = NullDate;
VAR
  Valid : TDateTime;
begin
  Valid := now;
  Assert.IsFalse(FDateTimeValue.ToDateTime.IsSome);
  FDateTimeValue.SetValue(Valid);
  Assert.IsTrue(FDateTimeValue.ToDateTime.IsSome);
  Assert.AreEqual(TDatetime(Valid),FDateTimeValue.ToDateTime.GetValueOrDefault(0.1));
  FDateTimeValue.Clear;
  FDateTimeValue.SetValue(Invalid);
  Assert.IsFalse(FDateTimeValue.ToDateTime.IsSome);
end;

procedure TDateTimeValue_Test.ToFloat_Check;
Const
  Valid = 1.8;
begin
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';
  Assert.IsFalse(FDateTimeValue.ToFloat.IsSome);
  FDateTimeValue.SetValue(Valid);
  Assert.IsTrue(FDateTimeValue.ToFloat.IsSome);
end;

procedure TDateTimeValue_Test.ToInt_Check;
Const
  Valid = 1.6;
begin
  Assert.IsFalse(FDateTimeValue.ToInt.IsSome);
  FDateTimeValue.SetValue(Valid);
  Assert.IsTrue(FDateTimeValue.ToInt.IsSome);
  Assert.AreEqual(trunc(Valid),FDateTimeValue.ToInt.GetValueOrDefault(0));
end;

procedure TDateTimeValue_Test.ToJson_Check;
VAR
  v : TDatetime;
begin
  v := now;
  Assert.IsTrue(FDateTimeValue.ToJSON(true).IsSome);
  Assert.IsTrue(FDateTimeValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create) is TJSONNull);
  Assert.IsFalse(FDateTimeValue.ToJSON(false).IsSome);
  FDateTimeValue.SetValue(v);
  Assert.IsTrue(FDateTimeValue.ToJSON(true).IsSome);
  Assert.IsTrue(FDateTimeValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create) is TJSONString);
  Assert.AreEqual(TJSONString.Create(FormatDateTime('yyyy-mm-dd hh:nn:ss',v)).ToString, FDateTimeValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create).ToString);
end;

procedure TDateTimeValue_Test.ToString_check;
Const
  v  = 89.98;
begin
  assert.isFalse(FDateTimeValue.ToString.IsSome);
  FDateTimeValue.SetValue(v);
  assert.IsTrue(FDateTimeValue.ToString.IsSome);
  assert.AreEqual(DateTimeToStr(v),FDateTimeValue.ToString.GetValueOrDefault(''));
end;

end.
