unit storm.fields.bool.test;

interface
uses
  storm.fields.base,
  storm.fields.Bool,
  storm.fields.interfaces,
  storm.values.Bool,
  System.Json,
  DAta.DB,

  System.Classes, System.SysUtils,
  DUnitX.TestFramework;

Const
  My_Field_Name = 'my_field';
{$TYPEINFO ON}
Type
  TStormBooleanField_Testable = class(TStormBooleanField)

  end;

  [TestFixture]
  TStormBooleanField_Test = class
  private
    Field : IBooleanField;
    Function MyField : TStormBooleanField_Testable;

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

{ TStormBooleanField_Test }

procedure TStormBooleanField_Test.FromDataField_Check;
Const
  value = 'aa';
VAR
  f : TBooleanField;
begin
  {$WARN USE_BEFORE_DEF ON}
  assert.IsFalse(MyField.FromDataField(f));
  {$WARN USE_BEFORE_DEF OFF}
end;

procedure TStormBooleanField_Test.GetValue_Check;
Const
  MyValue = true;
begin
  Assert.IsFalse(MyField.GetValue.IsSome);
  MyField.SetValue(MyValue);
  Assert.IsTrue(MyField.GetValue.IsSome);
  Assert.AreEqual(MyValue,MyField.GetValueOrDefault(false));
end;

function TStormBooleanField_Test.MyField: TStormBooleanField_Testable;
begin
  Result := field as TStormBooleanField_Testable;
end;

procedure TStormBooleanField_Test.Setup;
begin
  Field := TStormBooleanField_Testable.Create(My_Field_Name);
end;

procedure TStormBooleanField_Test.SetValue_check;
Const
  EmptyValue = false;
begin
  Assert.IsTrue(MyField.SetValue(EmptyValue));
  Assert.IsTrue(MyField.IsAssigned);
  Assert.AreEqual(EmptyValue,MyField.GetValueOrDefault(true));
end;

procedure TStormBooleanField_Test.Value_check;
begin
  Assert.IsNotNull(MyField.Value);
end;

end.
