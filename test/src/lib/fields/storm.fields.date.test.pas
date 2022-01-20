unit storm.fields.date.test;

interface
uses
  storm.fields.base,
  storm.fields.Date,
  storm.fields.interfaces,
  storm.values.Date,
  System.Json,
  DAta.DB,

  System.Classes, System.SysUtils,
  DUnitX.TestFramework;

Const
  My_Field_Name = 'my_field';
{$TYPEINFO ON}
Type
  TStormDateField_Testable = class(TStormDateField)

  end;

  [TestFixture]
  TStormDateField_Test = class
  private
    Field : IDateField;
    Function MyField : TStormDateField_Testable;

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

{ TStormDateField_Test }

procedure TStormDateField_Test.FromDataField_Check;
Const
  value = 'aa';
VAR
  f : TDateField;
begin
  {$WARN USE_BEFORE_DEF ON}
  assert.IsFalse(MyField.FromDataField(f));
  {$WARN USE_BEFORE_DEF OFF}
end;

procedure TStormDateField_Test.GetValue_Check;
Const
  MyValue = 89.9;
begin
  Assert.IsFalse(MyField.GetValue.IsSome);
  MyField.SetValue(MyValue);
  Assert.IsTrue(MyField.GetValue.IsSome);
  Assert.AreEqual(TDate(MyValue),MyField.GetValueOrDefault(0.1));
end;

function TStormDateField_Test.MyField: TStormDateField_Testable;
begin
  Result := field as TStormDateField_Testable;
end;

procedure TStormDateField_Test.Setup;
begin
  Field := TStormDateField_Testable.Create(My_Field_Name);
end;

procedure TStormDateField_Test.SetValue_check;
Const
  EmptyValue = 0.0;
begin
  Assert.IsTrue(MyField.SetValue(EmptyValue));
  Assert.IsTrue(MyField.IsAssigned);
  Assert.AreEqual(TDate(EmptyValue),MyField.GetValueOrDefault(0.1));
end;

procedure TStormDateField_Test.Value_check;
begin
  Assert.IsNotNull(MyField.Value);
end;

end.
