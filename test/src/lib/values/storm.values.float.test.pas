unit storm.values.float.test;

interface
uses

  storm.values.float,
  storm.values.interfaces,

  System.Classes, System.SysUtils,
  DUnitX.TestFramework;

{$TYPEINFO ON}
Type
  TFloatValue_Testable = class(storm.values.float.TFloatValue)

  end;

  [TestFixture]
  TFloatValue_Test = class
  private
    FFloatValue : IFloatValue;
    Function myValue :TFloatValue_Testable;
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

{ TFloatValue_Test }

procedure TFloatValue_Test.Clone_Check;
Const
  v = 1.89;
VAR
  Target : IFloatValue;
begin
  Target := storm.values.float.TFloatValue.Create;
  Assert.IsFalse(FFloatValue.Clone(nil));
  Assert.IsFalse(FFloatValue.Clone(Target));
  Assert.IsFalse(FFloatValue.IsAssigned);
  Target.SetValue(v);
  Assert.Istrue(FFloatValue.Clone(Target));
  Assert.Istrue(FFloatValue.IsAssigned);
  Assert.AreEqual(v, myValue.FValue);
end;

procedure TFloatValue_Test.FromBool_Check;
begin
  Assert.IsTrue(FFloatValue.FromBool(true));
  Assert.IsTrue(FFloatValue.IsAssigned);
  Assert.AreEqual(1.0, myValue.FValue);
  Assert.IsTrue(FFloatValue.FromBool(false));
  Assert.IsTrue(FFloatValue.IsAssigned);
  Assert.AreEqual(0.0, myValue.FValue);
end;

procedure TFloatValue_Test.FromDateTime_Check;
VAR
  data  : TDatetime;
begin
  data := now;
  Assert.IsTrue(myValue.FromDateTime(data));
  Assert.IsTrue(myValue.IsAssigned);
  Assert.AreEqual(Extended(data), myValue.FValue);
end;

procedure TFloatValue_Test.FromFloat_Check;
Const
  number  = 1.5989;
begin
  Assert.IsTrue(FFloatValue.FromFloat(number));
  Assert.IsTrue(FFloatValue.IsAssigned);
  Assert.AreEqual(number, myValue.FValue);
end;

procedure TFloatValue_Test.FromInt_Check;
Const
  number  = 1.0;
begin
  Assert.IsTrue(FFloatValue.FromInt(trunc(number)));
  Assert.IsTrue(FFloatValue.IsAssigned);
  Assert.AreEqual(number, myValue.FValue);
end;

procedure TFloatValue_Test.FromJson_Check;
begin
  Assert.IsFalse(FFloatValue.FromJSON(nil));
  Assert.IsFalse(FFloatValue.FromJSON(TJSONNull.Create));
end;

procedure TFloatValue_Test.FromString_Check;
Const
  valid = '1.98';
  invalid = 'a';
begin
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';
  Assert.IsTrue(FFloatValue.FromString(valid));
  Assert.AreEqual(StrToFloat(valid),myValue.FValue);
  Assert.IsFalse(FFloatValue.FromString(invalid));
end;

procedure TFloatValue_Test.GetValue_Check;
Const
  v  = 1.89;
var
  NewV : extended;
begin
  Assert.IsFalse(FFloatValue.GetValue.IsSome);
  FFloatValue.SetValue(v);
  Assert.IsTrue(FFloatValue.GetValue.IsSome);
  FFloatValue.GetValue.OnSome
  (
    procedure(i : extended)
    begin
      NewV := i;
    end
  );
  Assert.AreEqual(v,NewV);
  FFloatValue.Clear;
  Assert.IsFalse(FFloatValue.GetValue.IsSome);
end;

function TFloatValue_Test.myValue: TFloatValue_Testable;
begin
  Result := FFloatValue as TFloatValue_Testable;
end;

procedure TFloatValue_Test.Setup;
begin
  FFloatValue := TFloatValue_Testable.Create;
end;

procedure TFloatValue_Test.SetValue_Blank_Check;
Const
  v  = 0.0;
begin
  assert.IsTrue(FFloatValue.SetValue(v));
  assert.IsTrue(myValue.FAssigned);
  assert.AreEqual(v, myValue.FValue);
end;

procedure TFloatValue_Test.SetValue_Check;
Const
  v  = 8.9;
begin
  assert.IsTrue(FFloatValue.SetValue(v));
  assert.IsTrue(myValue.FAssigned);
  assert.AreEqual(v, myValue.FValue);
end;


procedure TFloatValue_Test.ToBool_Check;
Const
  Invalid = 8.9;
begin
  Assert.IsFalse(FFloatValue.ToBool.IsSome);
  FFloatValue.SetValue(1);
  Assert.IsTrue(FFloatValue.ToBool.IsSome);
  Assert.AreEqual(Boolean(1),FFloatValue.ToBool.GetValueOrDefault(false));
  FFloatValue.SetValue(0);
  Assert.IsTrue(FFloatValue.ToBool.IsSome);
  Assert.AreEqual(Boolean(0),FFloatValue.ToBool.GetValueOrDefault(false));
  FFloatValue.SetValue(Invalid);
  Assert.IsFalse(FFloatValue.ToBool.IsSome);
end;

procedure TFloatValue_Test.ToDateTime_Check;
Const
  Invalid = NullDate;
VAR
  Valid : Extended;
begin
  Valid := now;
  Assert.IsFalse(FFloatValue.ToDateTime.IsSome);
  FFloatValue.SetValue(Valid);
  Assert.IsTrue(FFloatValue.ToDateTime.IsSome);
  Assert.AreEqual(TDatetime(Valid),FFloatValue.ToDateTime.GetValueOrDefault(0.1));
  FFloatValue.SetValue(Invalid);
  Assert.IsFalse(FFloatValue.ToDateTime.IsSome);
end;

procedure TFloatValue_Test.ToFloat_Check;
Const
  Valid = 1.8;
begin
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';
  Assert.IsFalse(FFloatValue.ToFloat.IsSome);
  FFloatValue.SetValue(Valid);
  Assert.IsTrue(FFloatValue.ToFloat.IsSome);
end;

procedure TFloatValue_Test.ToInt_Check;
Const
  Valid = 1.6;
begin
  Assert.IsFalse(FFloatValue.ToInt.IsSome);
  FFloatValue.SetValue(Valid);
  Assert.IsTrue(FFloatValue.ToInt.IsSome);
  Assert.AreEqual(trunc(Valid),FFloatValue.ToInt.GetValueOrDefault(0));
end;

procedure TFloatValue_Test.ToJson_Check;
const
  v = 89.98;
begin
  Assert.IsTrue(FFloatValue.ToJSON(true).IsSome);
  Assert.IsTrue(FFloatValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create) is TJSONNull);
  Assert.IsFalse(FFloatValue.ToJSON(false).IsSome);
  FFloatValue.SetValue(v);
  Assert.IsTrue(FFloatValue.ToJSON(true).IsSome);
  Assert.IsTrue(FFloatValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create) is TJSONString);
  Assert.AreEqual(TJsonNumber.Create(v).ToString, FFloatValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create).ToString);
  Assert.IsTrue(FFloatValue.ToJSON(False).IsSome);
  Assert.IsTrue(FFloatValue.ToJSON(False).GetValueOrDefault(TJSONTrue.Create) is TJSONString);
  Assert.AreEqual(TJsonNumber.Create(v).ToString, FFloatValue.ToJSON(False).GetValueOrDefault(TJSONTrue.Create).ToString);
end;

procedure TFloatValue_Test.ToString_check;
Const
  v  = 89.98;
begin
  assert.isFalse(FFloatValue.ToString.IsSome);
  FFloatValue.SetValue(v);
  assert.IsTrue(FFloatValue.ToString.IsSome);
  assert.AreEqual(FloatToStr(v),FFloatValue.ToString.GetValueOrDefault(''));
end;

end.
