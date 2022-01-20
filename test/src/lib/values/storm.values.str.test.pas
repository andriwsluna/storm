unit storm.values.str.test;

interface
uses

  storm.values.str,
  storm.values.interfaces,

  System.Classes, System.SysUtils,
  DUnitX.TestFramework;

{$TYPEINFO ON}
Type
  TStringValue_Testable = class(TStringValue)

  end;

  [TestFixture]
  TStringValue_Test = class
  private
    FStringValue : IStringValue;
    Function myValue :TStringValue_Testable;
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

{ TStringValue_Test }

procedure TStringValue_Test.Clone_Check;
Const
  Text = 'alohja!';
VAR
  Target : IStringValue;
begin
  Target := TStringValue.Create;
  Assert.IsFalse(FStringValue.Clone(nil));
  Assert.IsFalse(FStringValue.Clone(Target));
  Assert.IsFalse(FStringValue.IsAssigned);
  Target.SetValue(Text);
  Assert.Istrue(FStringValue.Clone(Target));
  Assert.Istrue(FStringValue.IsAssigned);
  Assert.AreEqual(Text, myValue.FValue);
end;

procedure TStringValue_Test.FromBool_Check;
Const
  bool  = True;
begin
  Assert.IsTrue(FStringValue.FromBool(bool));
  Assert.IsTrue(FStringValue.IsAssigned);
  Assert.AreEqual(BoolToStr(bool, true), myValue.FValue);
end;

procedure TStringValue_Test.FromDateTime_Check;
VAR
  data  : TDatetime;
begin
  data := now;
  Assert.IsTrue(FStringValue.FromDateTime(data));
  Assert.IsTrue(FStringValue.IsAssigned);
  Assert.AreEqual(DateTimeToStr(data), myValue.FValue);
end;

procedure TStringValue_Test.FromFloat_Check;
Const
  number  = 1.5;
begin
  Assert.IsTrue(FStringValue.FromFloat(number));
  Assert.IsTrue(FStringValue.IsAssigned);
  Assert.AreEqual(FloatToStr(number), myValue.FValue);
end;

procedure TStringValue_Test.FromInt_Check;
Const
  number  = 1;
begin
  Assert.IsTrue(FStringValue.FromInt(number));
  Assert.IsTrue(FStringValue.IsAssigned);
  Assert.AreEqual(IntToStr(number), myValue.FValue);
end;

procedure TStringValue_Test.FromJson_Check;
begin
  Assert.IsFalse(FStringValue.FromJSON(nil));
  Assert.IsFalse(FStringValue.FromJSON(TJSONNull.Create));
end;

procedure TStringValue_Test.FromString_Check;
Const
  Text = '1xxe';
begin
  Assert.IsTrue(FStringValue.FromString(Text));
  Assert.AreEqual(Text,myValue.FValue);
end;

procedure TStringValue_Test.GetValue_Check;
Const
  text  = '1';
var
  NewText : string;
begin
  Assert.IsFalse(FStringValue.GetValue.IsSome);
  FStringValue.SetValue(text);
  Assert.IsTrue(FStringValue.GetValue.IsSome);
  FStringValue.GetValue.OnSome
  (
    procedure(s : string)
    begin
      NewText := s;
    end
  );
  Assert.AreEqual(text,NewText);
  FStringValue.Clear;
  Assert.IsFalse(FStringValue.GetValue.IsSome);
end;

function TStringValue_Test.myValue: TStringValue_Testable;
begin
  Result := FStringValue as TStringValue_Testable;
end;

procedure TStringValue_Test.Setup;
begin
  FStringValue := TStringValue_Testable.Create;
end;

procedure TStringValue_Test.SetValue_Blank_Check;
Const
  text  = '';
begin
  assert.IsTrue(FStringValue.SetValue(text));
  assert.IsTrue(myValue.FAssigned);
  assert.AreEqual(text, myValue.FValue);
end;

procedure TStringValue_Test.SetValue_Check;
Const
  text  = 'absd';
begin
  assert.IsTrue(FStringValue.SetValue(text));
  assert.IsTrue(myValue.FAssigned);
  assert.AreEqual(text, myValue.FValue);
end;


procedure TStringValue_Test.ToBool_Check;
Const
  Valid = 'True';
  Invalid = 'a';
begin
  Assert.IsFalse(FStringValue.ToBool.IsSome);
  FStringValue.SetValue(Valid);
  Assert.IsTrue(FStringValue.ToBool.IsSome);
  Assert.AreEqual(StrToBool(Valid),FStringValue.ToBool.GetValueOrDefault(false));
  FStringValue.SetValue(Invalid);
  Assert.IsFalse(FStringValue.ToBool.IsSome);
end;

procedure TStringValue_Test.ToDateTime_Check;
Const
  Invalid = 'a';
VAR
  Valid : String;
begin
  Valid := DateTimeToStr(now);
  Assert.IsFalse(FStringValue.ToDateTime.IsSome);
  FStringValue.SetValue(Valid);
  Assert.IsTrue(FStringValue.ToDateTime.IsSome);
  Assert.AreEqual(StrToDateTime(Valid),FStringValue.ToDateTime.GetValueOrDefault(0.1));
  FStringValue.SetValue(Invalid);
  Assert.IsFalse(FStringValue.ToDateTime.IsSome);
end;

procedure TStringValue_Test.ToFloat_Check;
Const
  Valid = '1.0';
  Invalid = 'a';
begin
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';
  Assert.IsFalse(FStringValue.ToFloat.IsSome);
  FStringValue.SetValue(Valid);
  Assert.IsTrue(FStringValue.ToFloat.IsSome);
  Assert.AreEqual(StrToFloat(Valid),FStringValue.ToFloat.GetValueOrDefault(0.1));
  FStringValue.SetValue(Invalid);
  Assert.IsFalse(FStringValue.ToFloat.IsSome);
end;

procedure TStringValue_Test.ToInt_Check;
Const
  Valid = '1';
  Invalid = 'a';
begin
  Assert.IsFalse(FStringValue.ToInt.IsSome);
  FStringValue.SetValue(Valid);
  Assert.IsTrue(FStringValue.ToInt.IsSome);
  Assert.AreEqual(StrToInt(Valid),FStringValue.ToInt.GetValueOrDefault(0));
  FStringValue.SetValue(Invalid);
  Assert.IsFalse(FStringValue.ToInt.IsSome);
end;

procedure TStringValue_Test.ToJson_Check;
const
  Text = 'alooooo!';
begin
  Assert.IsTrue(FStringValue.ToJSON(true).IsSome);
  Assert.IsTrue(FStringValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create) is TJSONNull);
  Assert.IsFalse(FStringValue.ToJSON(false).IsSome);
  FStringValue.SetValue(Text);
  Assert.IsTrue(FStringValue.ToJSON(true).IsSome);
  Assert.IsTrue(FStringValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create) is TJSONString);
  Assert.AreEqual(TJSONString.Create(Text).ToString, FStringValue.ToJSON(true).GetValueOrDefault(TJSONTrue.Create).ToString);
  Assert.IsTrue(FStringValue.ToJSON(False).IsSome);
  Assert.IsTrue(FStringValue.ToJSON(False).GetValueOrDefault(TJSONTrue.Create) is TJSONString);
  Assert.AreEqual(TJSONString.Create(Text).ToString, FStringValue.ToJSON(False).GetValueOrDefault(TJSONTrue.Create).ToString);
end;

procedure TStringValue_Test.ToString_check;
Const
  text  = 'absd';
begin
  assert.isFalse(FStringValue.ToString.IsSome);
  FStringValue.SetValue(text);
  assert.IsTrue(FStringValue.ToString.IsSome);
  assert.AreEqual(text,FStringValue.ToString.GetValueOrDefault(''));
end;

end.
