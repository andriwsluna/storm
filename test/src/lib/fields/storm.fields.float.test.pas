unit storm.fields.float.test;

interface
uses
  storm.fields.base,
  storm.fields.float,
  storm.fields.interfaces,
  storm.values.float,
  System.Json,
  DAta.DB,

  System.Classes, System.SysUtils,
  DUnitX.TestFramework;

Const
  My_Field_Name = 'my_field';
{$TYPEINFO ON}
Type
  TStormFloatField_Testable = class(TStormFloatField)

  end;

  [TestFixture]
  TStormFloatField_Test = class
  private
    Field : IFloatField;
    Function MyField : TStormFloatField_Testable;

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

{ TStormFloatField_Test }

procedure TStormFloatField_Test.FromDataField_Check;
Const
  value = 'aa';
VAR
  f : TFloatField;
begin
  {$WARN USE_BEFORE_DEF ON}
  assert.IsFalse(MyField.FromDataField(f));
  {$WARN USE_BEFORE_DEF OFF}
end;

procedure TStormFloatField_Test.GetValue_Check;
Const
  MyValue = 89.9;
begin
  Assert.IsFalse(MyField.GetValue.IsSome);
  MyField.SetValue(MyValue);
  Assert.IsTrue(MyField.GetValue.IsSome);
  Assert.AreEqual(MyValue,MyField.GetValueOrDefault(0.1));
end;

function TStormFloatField_Test.MyField: TStormFloatField_Testable;
begin
  Result := field as TStormFloatField_Testable;
end;

procedure TStormFloatField_Test.Setup;
begin
  Field := TStormFloatField_Testable.Create(My_Field_Name);
end;

procedure TStormFloatField_Test.SetValue_check;
Const
  EmptyValue = 0.0;
begin
  Assert.IsTrue(MyField.SetValue(EmptyValue));
  Assert.IsTrue(MyField.IsAssigned);
  Assert.AreEqual(EmptyValue,MyField.GetValueOrDefault(0.1));
end;

procedure TStormFloatField_Test.Value_check;
begin
  Assert.IsNotNull(MyField.Value);
end;

end.
