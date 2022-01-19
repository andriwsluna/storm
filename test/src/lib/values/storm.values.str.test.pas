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
  TStormValue_Test = class
  private
    FStringValue : TStringValue_Testable;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

  published
    Procedure SetValue_Check();
    Procedure SetValue_Blank_Check();

    Procedure GetValue_Check();
  end;


{$TYPEINFO OFF}
implementation

{ TStormValue_Test }

procedure TStormValue_Test.GetValue_Check;
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

procedure TStormValue_Test.Setup;
begin
  FStringValue := TStringValue_Testable.Create;
end;

procedure TStormValue_Test.SetValue_Blank_Check;
Const
  text  = '';
begin
  assert.IsTrue(FStringValue.SetValue(text));
  assert.IsTrue(FStringValue.FAssigned);
  assert.AreEqual(text, FStringValue.FValue);
end;

procedure TStormValue_Test.SetValue_Check;
Const
  text  = 'absd';
begin
  assert.IsTrue(FStringValue.SetValue(text));
  assert.IsTrue(FStringValue.FAssigned);
  assert.AreEqual(text, FStringValue.FValue);
end;

procedure TStormValue_Test.TearDown;
begin
  FStringValue.Free;
end;

end.
