unit storm.values.int.test;

interface
uses

  storm.values.int,
  storm.values.interfaces,

  System.Classes, System.SysUtils,
  DUnitX.TestFramework;

{$TYPEINFO ON}
Type
  TIntegerValue_Testable = class(TIntegerValue)

  end;

  [TestFixture]
  TIntegerValue_Test = class
  private
    FIntegerValue : IIntegerValue;
    Function myValue :TIntegerValue_Testable;
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
  end;


{$TYPEINFO OFF}
implementation

Uses
  System.JSON;

{ TIntegerValue_Test }

procedure TIntegerValue_Test.Clone_Check;
Const
  v = 1;
VAR
  Target : IIntegerValue;
begin
  Target := TIntegerValue.Create;
  Assert.IsFalse(FIntegerValue.Clone(nil));
  Assert.IsFalse(FIntegerValue.Clone(Target));
  Assert.IsFalse(FIntegerValue.IsAssigned);
  Target.SetValue(v);
  Assert.Istrue(FIntegerValue.Clone(Target));
  Assert.Istrue(FIntegerValue.IsAssigned);
  Assert.AreEqual(v, myValue.FValue);
end;

procedure TIntegerValue_Test.FromBool_Check;
begin
  Assert.IsTrue(FIntegerValue.FromBool(true));
  Assert.IsTrue(FIntegerValue.IsAssigned);
  Assert.AreEqual(1, myValue.FValue);
  Assert.IsTrue(FIntegerValue.FromBool(false));
  Assert.IsTrue(FIntegerValue.IsAssigned);
  Assert.AreEqual(0, myValue.FValue);
end;

procedure TIntegerValue_Test.FromFloat_Check;
Const
  number  = 1.5;
begin
  Assert.IsTrue(FIntegerValue.FromFloat(number));
  Assert.IsTrue(FIntegerValue.IsAssigned);
  Assert.AreEqual(Trunc(number), myValue.FValue);
end;

procedure TIntegerValue_Test.FromInt_Check;
Const
  number  = 1;
begin
  Assert.IsTrue(FIntegerValue.FromInt(number));
  Assert.IsTrue(FIntegerValue.IsAssigned);
  Assert.AreEqual((number), myValue.FValue);
end;

procedure TIntegerValue_Test.FromJson_Check;
begin
  Assert.IsFalse(FIntegerValue.FromJSON(nil));
  Assert.IsFalse(FIntegerValue.FromJSON(TJSONNull.Create));
end;

procedure TIntegerValue_Test.FromString_Check;
Const
  valid = '1';
  invalid = 'a';
begin
  Assert.IsTrue(FIntegerValue.FromString(valid));
  Assert.AreEqual(StrToInt(valid),myValue.FValue);
  Assert.IsFalse(FIntegerValue.FromString(invalid));
end;

procedure TIntegerValue_Test.GetValue_Check;
Const
  v  = 1;
var
  NewV : integer;
begin
  Assert.IsFalse(FIntegerValue.GetValue.IsSome);
  FIntegerValue.SetValue(v);
  Assert.IsTrue(FIntegerValue.GetValue.IsSome);
  FIntegerValue.GetValue.OnSome
  (
    procedure(i : integer)
    begin
      NewV := i;
    end
  );
  Assert.AreEqual(v,NewV);
  FIntegerValue.Clear;
  Assert.IsFalse(FIntegerValue.GetValue.IsSome);
end;

function TIntegerValue_Test.myValue: TIntegerValue_Testable;
begin
  Result := FIntegerValue as TIntegerValue_Testable;
end;

procedure TIntegerValue_Test.Setup;
begin
  FIntegerValue := TIntegerValue_Testable.Create;
end;

procedure TIntegerValue_Test.SetValue_Blank_Check;
Const
  v  = 0;
begin
  assert.IsTrue(FIntegerValue.SetValue(v));
  assert.IsTrue(myValue.FAssigned);
  assert.AreEqual(v, myValue.FValue);
end;

procedure TIntegerValue_Test.SetValue_Check;
Const
  v  = 8;
begin
  assert.IsTrue(FIntegerValue.SetValue(v));
  assert.IsTrue(myValue.FAssigned);
  assert.AreEqual(v, myValue.FValue);
end;


procedure TIntegerValue_Test.ToBool_Check;
Const
  Invalid = 8;
begin
  Assert.IsFalse(FIntegerValue.ToBool.IsSome);
  FIntegerValue.SetValue(1);
  Assert.IsTrue(FIntegerValue.ToBool.IsSome);
  Assert.AreEqual(Boolean(1),FIntegerValue.ToBool.GetValueOrDefault(false));
  FIntegerValue.SetValue(0);
  Assert.IsTrue(FIntegerValue.ToBool.IsSome);
  Assert.AreEqual(Boolean(0),FIntegerValue.ToBool.GetValueOrDefault(false));
  FIntegerValue.SetValue(Invalid);
  Assert.IsFalse(FIntegerValue.ToBool.IsSome);
end;

procedure TIntegerValue_Test.ToFloat_Check;
Const
  Valid = 1;
begin
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';
  Assert.IsFalse(FIntegerValue.ToFloat.IsSome);
  FIntegerValue.SetValue(Valid);
  Assert.IsTrue(FIntegerValue.ToFloat.IsSome);
end;

procedure TIntegerValue_Test.ToInt_Check;
Const
  Valid = 1;
begin
  Assert.IsFalse(FIntegerValue.ToInt.IsSome);
  FIntegerValue.SetValue(Valid);
  Assert.IsTrue(FIntegerValue.ToInt.IsSome);
  Assert.AreEqual((Valid),FIntegerValue.ToInt.GetValueOrDefault(0));
end;

procedure TIntegerValue_Test.ToJson_Check;
const
  v = 89;
begin
  Assert.IsTrue(FIntegerValue.ToJSON(true).IsSome);
  Assert.IsTrue(FIntegerValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create) is TJSONNull);
  Assert.IsFalse(FIntegerValue.ToJSON(false).IsSome);
  FIntegerValue.SetValue(v);
  Assert.IsTrue(FIntegerValue.ToJSON(true).IsSome);
  Assert.IsTrue(FIntegerValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create) is TJSONString);
  Assert.AreEqual(TJsonNumber.Create(v).ToString, FIntegerValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create).ToString);
  Assert.IsTrue(FIntegerValue.ToJSON(False).IsSome);
  Assert.IsTrue(FIntegerValue.ToJSON(False).GetValueOrDefault(TJSONTrue.Create) is TJSONString);
  Assert.AreEqual(TJsonNumber.Create(v).ToString, FIntegerValue.ToJSON(False).GetValueOrDefault(TJSONTrue.Create).ToString);
end;

procedure TIntegerValue_Test.ToString_check;
Const
  v  = 89;
begin
  assert.isFalse(FIntegerValue.ToString.IsSome);
  FIntegerValue.SetValue(v);
  assert.IsTrue(FIntegerValue.ToString.IsSome);
  assert.AreEqual(IntToStr(v),FIntegerValue.ToString.GetValueOrDefault(''));
end;

end.
