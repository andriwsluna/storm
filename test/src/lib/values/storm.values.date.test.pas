unit storm.values.date.test;

interface
uses

  storm.values.float,
  storm.values.date,
  storm.values.interfaces,

  System.Classes, System.SysUtils,
  DUnitX.TestFramework;

{$TYPEINFO ON}
Type
  TDateValue_Testable = class(TDateValue)

  end;

  [TestFixture]
  TDateValue_Test = class
  private
    FDateValue : IDateValue;
    Function myValue :TDateValue_Testable;
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

{ TDateValue_Test }

procedure TDateValue_Test.Clone_Check;
VAR
  v : TDate;
  Target : IDateValue;
begin
  v := now;
  Target := TDateValue.Create;
  Assert.IsFalse(FDateValue.Clone(nil));
  Assert.IsFalse(FDateValue.Clone(Target));
  Assert.IsFalse(FDateValue.IsAssigned);
  Target.SetValue(v);
  Assert.Istrue(FDateValue.Clone(Target));
  Assert.Istrue(FDateValue.IsAssigned);
  Assert.AreEqual(v, myValue.FValue);
end;

procedure TDateValue_Test.FromBool_Check;
begin
  Assert.IsFalse(FDateValue.FromBool(true));
  Assert.IsFalse(FDateValue.FromBool(false));
end;

procedure TDateValue_Test.FromDateTime_Check;
VAR
  data  : TDate;
begin
  data := now;
  Assert.IsTrue(myValue.FromDateTime(data));
  Assert.IsTrue(myValue.IsAssigned);
  Assert.AreEqual(data, myValue.FValue);
end;

procedure TDateValue_Test.FromFloat_Check;
Const
  number  = 1.5989;
begin
  Assert.IsTrue(FDateValue.FromFloat(number));
  Assert.IsTrue(FDateValue.IsAssigned);
  Assert.AreEqual(TDate(number), myValue.FValue);
end;

procedure TDateValue_Test.FromInt_Check;
Const
  number  = 8989.15;
begin
  Assert.IsTrue(FDateValue.FromInt(trunc(number)));
  Assert.IsTrue(FDateValue.IsAssigned);
  Assert.AreEqual(TDate(trunc(number)), myValue.FValue);
end;

procedure TDateValue_Test.FromJson_Check;
begin
  Assert.IsFalse(FDateValue.FromJSON(nil));
  Assert.IsFalse(FDateValue.FromJSON(TJSONNull.Create));
end;

procedure TDateValue_Test.FromString_Check;
const
    invalid = 'a';
var
  valid : string;
begin
  valid := DateTimeToStr(now);
  Assert.IsTrue(FDateValue.FromString(valid));
  Assert.AreEqual(StrToDateTime(valid),myValue.FValue);
  Assert.IsFalse(FDateValue.FromString(invalid));
end;

procedure TDateValue_Test.GetValue_Check;
var
  v  : TDate;
  NewV : TDate;
begin
  v := now;
  Assert.IsFalse(FDateValue.GetValue.IsSome);
  FDateValue.SetValue(v);
  Assert.IsTrue(FDateValue.GetValue.IsSome);
  FDateValue.GetValue.OnSome
  (
    procedure(i : TDate)
    begin
      NewV := i;
    end
  );
  Assert.AreEqual(v,NewV);
  FDateValue.Clear;
  Assert.IsFalse(FDateValue.GetValue.IsSome);
end;

function TDateValue_Test.myValue: TDateValue_Testable;
begin
  Result := FDateValue as TDateValue_Testable;
end;

procedure TDateValue_Test.Setup;
begin
  FDateValue := TDateValue_Testable.Create;
end;

procedure TDateValue_Test.SetValue_Blank_Check;
Var
  v  : TDate;
begin
  v := now;
  assert.IsTrue(FDateValue.SetValue(v));
  assert.IsTrue(myValue.FAssigned);
  assert.AreEqual(v, myValue.FValue);
end;

procedure TDateValue_Test.SetValue_Check;
Var
  v  : TDate;
begin
  v := now;
  assert.IsTrue(FDateValue.SetValue(v));
  assert.IsTrue(myValue.FAssigned);
  assert.AreEqual(v, myValue.FValue);
end;


procedure TDateValue_Test.ToBool_Check;
begin
  Assert.IsFalse(FDateValue.ToBool.IsSome);
  FDateValue.SetValue(now);
  Assert.IsFalse(FDateValue.ToBool.IsSome);
end;

procedure TDateValue_Test.ToDateTime_Check;
Const
  Invalid = NullDate;
VAR
  Valid : TDate;
begin
  Valid := now;
  Assert.IsFalse(FDateValue.ToDateTime.IsSome);
  FDateValue.SetValue(Valid);
  Assert.IsTrue(FDateValue.ToDateTime.IsSome);
  Assert.AreEqual(TDate(Valid),FDateValue.ToDateTime.GetValueOrDefault(0.1));
  FDateValue.Clear;
  FDateValue.SetValue(Invalid);
  Assert.IsFalse(FDateValue.ToDateTime.IsSome);
end;

procedure TDateValue_Test.ToFloat_Check;
Const
  Valid = 1.8;
begin
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';
  Assert.IsFalse(FDateValue.ToFloat.IsSome);
  FDateValue.SetValue(Valid);
  Assert.IsTrue(FDateValue.ToFloat.IsSome);
end;

procedure TDateValue_Test.ToInt_Check;
Const
  Valid = 1.6;
begin
  Assert.IsFalse(FDateValue.ToInt.IsSome);
  FDateValue.SetValue(Valid);
  Assert.IsTrue(FDateValue.ToInt.IsSome);
  Assert.AreEqual(trunc(Valid),FDateValue.ToInt.GetValueOrDefault(0));
end;

procedure TDateValue_Test.ToJson_Check;
VAR
  v : TDate;
begin
  v := now;
  Assert.IsTrue(FDateValue.ToJSON(true).IsSome);
  Assert.IsTrue(FDateValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create) is TJSONNull);
  Assert.IsFalse(FDateValue.ToJSON(false).IsSome);
  FDateValue.SetValue(v);
  Assert.IsTrue(FDateValue.ToJSON(true).IsSome);
  Assert.IsTrue(FDateValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create) is TJSONString);
  Assert.AreEqual(TJSONString.Create(FormatDateTime('yyyy-mm-dd',v)).ToString, FDateValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create).ToString);
end;

procedure TDateValue_Test.ToString_check;
Const
  v  = 89.98;
begin
  assert.isFalse(FDateValue.ToString.IsSome);
  FDateValue.SetValue(v);
  assert.IsTrue(FDateValue.ToString.IsSome);
  assert.AreEqual(DateToStr(v),FDateValue.ToString.GetValueOrDefault(''));
end;

end.
