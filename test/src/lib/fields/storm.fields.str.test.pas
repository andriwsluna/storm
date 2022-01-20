unit storm.fields.str.test;

interface
uses
  storm.fields.base,
  storm.fields.str,
  storm.fields.interfaces,
  storm.values.str,
  System.Json,
  DAta.DB,

  System.Classes, System.SysUtils,
  DUnitX.TestFramework;

Const
  My_Field_Name = 'my_field';
{$TYPEINFO ON}
Type
  TStormStringField_Testable = class(TStormStringField)

  end;

  [TestFixture]
  TStormStringField_Test = class
  private
    Field : IStringField;
    Function MyField : TStormStringField_Testable;

  public
    [Setup]
    procedure Setup;


  published
    Procedure Value_check();
    Procedure SetValue_check();
    Procedure GetValue_Check();
    Procedure FromDataField_Check();
  end;
{$TYPEINFO OFF}
implementation

{ TStormStringField_Test }

procedure TStormStringField_Test.FromDataField_Check;
Const
  value = 'aa';
VAR
  f : TStringField;
begin
  {$WARN USE_BEFORE_DEF ON}
  assert.IsFalse(MyField.FromDataField(f));
  {$WARN USE_BEFORE_DEF OFF}
end;

procedure TStormStringField_Test.GetValue_Check;
Const
  MyString = 'aaaa';
begin
  Assert.IsFalse(MyField.GetValue.IsSome);
  MyField.SetValue(MyString);
  Assert.IsTrue(MyField.GetValue.IsSome);
  Assert.AreEqual(MyString,MyField.GetValueOrDefault('x'));
end;

function TStormStringField_Test.MyField: TStormStringField_Testable;
begin
  Result := field as TStormStringField_Testable;
end;

procedure TStormStringField_Test.Setup;
begin
  Field := TStormStringField_Testable.Create(My_Field_Name);
end;

procedure TStormStringField_Test.SetValue_check;
Const
  EmptyString = '';
begin
  Assert.IsTrue(MyField.SetValue(EmptyString));
  Assert.IsTrue(MyField.IsAssigned);
  Assert.AreEqual(EmptyString,MyField.GetValueOrDefault('x'));
end;

procedure TStormStringField_Test.Value_check;
begin
  Assert.IsNotNull(MyField.Value);
end;

end.
