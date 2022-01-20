unit storm.values.bool.test;

interface
uses

  storm.values.bool,
  storm.values.interfaces,

  System.Classes, System.SysUtils,
  DUnitX.TestFramework;

{$TYPEINFO ON}
Type
  TBooleanValue_Testable = class(TBooleanValue)

  end;

  [TestFixture]
  TBooleanValue_Test = class
  private
    FBooleanValue : IBooleanValue;
    Function myValue :TBooleanValue_Testable;
  public
    [Setup]
    procedure Setup;


  published
    Procedure SetValue_Check();

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

{ TBooleanValue_Test }

procedure TBooleanValue_Test.Clone_Check;
Const
  v = true;
VAR
  Target : IBooleanValue;
begin
  Target := TBooleanValue.Create;
  Assert.IsFalse(FBooleanValue.Clone(nil));
  Assert.IsFalse(FBooleanValue.Clone(Target));
  Assert.IsFalse(FBooleanValue.IsAssigned);
  Target.SetValue(v);
  Assert.Istrue(FBooleanValue.Clone(Target));
  Assert.Istrue(FBooleanValue.IsAssigned);
  Assert.AreEqual(v, myValue.FValue);
end;

procedure TBooleanValue_Test.FromBool_Check;
begin
  Assert.IsTrue(FBooleanValue.FromBool(true));
  Assert.IsTrue(FBooleanValue.IsAssigned);
  Assert.AreEqual(true, myValue.FValue);
  Assert.IsTrue(FBooleanValue.FromBool(false));
  Assert.IsTrue(FBooleanValue.IsAssigned);
  Assert.AreEqual(false, myValue.FValue);
end;

procedure TBooleanValue_Test.FromDateTime_Check;
begin
  Assert.IsFalse(FBooleanValue.FromDateTime(Now));
end;

procedure TBooleanValue_Test.FromFloat_Check;
Const
  t  = 1.5;
  f = 0.8;
  invalid = 8.5;
begin
  Assert.IsTrue(FBooleanValue.FromFloat(t));
  Assert.IsTrue(FBooleanValue.IsAssigned);
  Assert.AreEqual(true, myValue.FValue);

  Assert.IsTrue(FBooleanValue.FromFloat(f));
  Assert.IsTrue(FBooleanValue.IsAssigned);
  Assert.AreEqual(false, myValue.FValue);

  Assert.IsFalse(FBooleanValue.FromFloat(invalid));

end;

procedure TBooleanValue_Test.FromInt_Check;
Const
  t  = 1;
  f = 0;
  invalid = 8;
begin
  Assert.IsTrue(FBooleanValue.FromInt(t));
  Assert.IsTrue(FBooleanValue.IsAssigned);
  Assert.AreEqual(true, myValue.FValue);

  Assert.IsTrue(FBooleanValue.FromInt(f));
  Assert.IsTrue(FBooleanValue.IsAssigned);
  Assert.AreEqual(false, myValue.FValue);

  Assert.IsFalse(FBooleanValue.FromInt(invalid));

end;

procedure TBooleanValue_Test.FromJson_Check;
begin
  Assert.IsFalse(FBooleanValue.FromJSON(nil));
  Assert.IsFalse(FBooleanValue.FromJSON(TJSONNull.Create));
end;

procedure TBooleanValue_Test.FromString_Check;
Const
  t = 'True';
  f = 'False';
  invalid = 'a';
begin
  Assert.IsTrue(FBooleanValue.FromString(t));
  Assert.AreEqual(StrTobool(t),myValue.FValue);
  Assert.IsTrue(FBooleanValue.FromString(f));
  Assert.AreEqual(StrTobool(f),myValue.FValue);
  Assert.IsFalse(FBooleanValue.FromString(invalid));
end;

procedure TBooleanValue_Test.GetValue_Check;
Const
  v  = true;
var
  NewV : boolean;
begin
  Assert.IsFalse(FBooleanValue.GetValue.IsSome);
  FBooleanValue.SetValue(v);
  Assert.IsTrue(FBooleanValue.GetValue.IsSome);
  FBooleanValue.GetValue.OnSome
  (
    procedure(b : boolean)
    begin
      NewV := b;
    end
  );
  Assert.AreEqual(v,NewV);
  FBooleanValue.Clear;
  Assert.IsFalse(FBooleanValue.GetValue.IsSome);
end;

function TBooleanValue_Test.myValue: TBooleanValue_Testable;
begin
  Result := FBooleanValue as TBooleanValue_Testable;
end;

procedure TBooleanValue_Test.Setup;
begin
  FBooleanValue := TBooleanValue_Testable.Create;
end;


procedure TBooleanValue_Test.SetValue_Check;
begin
  assert.IsTrue(FBooleanValue.SetValue(true));
  assert.IsTrue(myValue.IsAssigned);
  assert.AreEqual(true, myValue.FValue);

  assert.IsTrue(FBooleanValue.SetValue(false));
  assert.IsTrue(myValue.IsAssigned);
  assert.AreEqual(false, myValue.FValue);
end;


procedure TBooleanValue_Test.ToBool_Check;

begin
  Assert.IsFalse(FBooleanValue.ToBool.IsSome);
  FBooleanValue.SetValue(true);
  Assert.IsTrue(FBooleanValue.ToBool.IsSome);
  Assert.AreEqual(true,FBooleanValue.ToBool.GetValueOrDefault(false));
  FBooleanValue.SetValue(false);
  Assert.IsTrue(FBooleanValue.ToBool.IsSome);
  Assert.AreEqual(false,FBooleanValue.ToBool.GetValueOrDefault(true));
end;

procedure TBooleanValue_Test.ToDateTime_Check;
begin
  Assert.IsFalse(FBooleanValue.ToDateTime.IsSome);
  FBooleanValue.SetValue(true);
  Assert.IsFalse(FBooleanValue.ToDateTime.IsSome);
  FBooleanValue.SetValue(false);
  Assert.IsFalse(FBooleanValue.ToDateTime.IsSome);
end;

procedure TBooleanValue_Test.ToFloat_Check;
begin
//  FormatSettings.DecimalSeparator := '.';
//  FormatSettings.ThousandSeparator := ',';
  Assert.IsFalse(FBooleanValue.ToFloat.IsSome);
  FBooleanValue.SetValue(true);
  Assert.IsTrue(FBooleanValue.ToFloat.IsSome);
  FBooleanValue.SetValue(false);
  Assert.IsTrue(FBooleanValue.ToFloat.IsSome);
end;

procedure TBooleanValue_Test.ToInt_Check;
begin
  Assert.IsFalse(FBooleanValue.ToInt.IsSome);
  FBooleanValue.SetValue(true);
  Assert.IsTrue(FBooleanValue.ToInt.IsSome);
  Assert.AreEqual(1,FBooleanValue.ToInt.GetValueOrDefault(0));
  FBooleanValue.SetValue(false);
  Assert.IsTrue(FBooleanValue.ToInt.IsSome);
  Assert.AreEqual(0,FBooleanValue.ToInt.GetValueOrDefault(-1));
end;

procedure TBooleanValue_Test.ToJson_Check;
begin
  Assert.IsTrue(FBooleanValue.ToJSON(true).IsSome);
  Assert.IsTrue(FBooleanValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create) is TJSONNull);
  Assert.IsFalse(FBooleanValue.ToJSON(false).IsSome);
  FBooleanValue.SetValue(true);
  Assert.IsTrue(FBooleanValue.ToJSON(true).IsSome);
  Assert.IsTrue(FBooleanValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create) is TJSONTrue);
  Assert.AreEqual(TJSONTrue.Create.ToString, FBooleanValue.ToJSON(true).GetValueOrDefault(TJSONFalse.Create).ToString);
  FBooleanValue.SetValue(false);
  Assert.IsTrue(FBooleanValue.ToJSON(False).IsSome);
  Assert.IsTrue(FBooleanValue.ToJSON(False).GetValueOrDefault(TJSONTrue.Create) is TJSONFalse);
  Assert.AreEqual(TJSONFalse.Create.ToString, FBooleanValue.ToJSON(False).GetValueOrDefault(TJSONTrue.Create).ToString);
end;

procedure TBooleanValue_Test.ToString_check;
begin
  assert.isFalse(FBooleanValue.ToString.IsSome);
  FBooleanValue.SetValue(true);
  assert.IsTrue(FBooleanValue.ToString.IsSome);
  assert.AreEqual(BoolToStr(true, true),FBooleanValue.ToString.GetValueOrDefault(''));
  FBooleanValue.SetValue(false);
  assert.IsTrue(FBooleanValue.ToString.IsSome);
  assert.AreEqual(BoolToStr(false, true),FBooleanValue.ToString.GetValueOrDefault(''));
end;

end.
