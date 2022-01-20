unit storm.fields.datetime.test;

interface
uses
  storm.fields.base,
  storm.fields.datetime,
  storm.fields.interfaces,
  storm.values.datetime,
  System.Json,
  DAta.DB,

  System.Classes, System.SysUtils,
  DUnitX.TestFramework;

Const
  My_Field_Name = 'my_field';
{$TYPEINFO ON}
Type
  TStormDateTimeField_Testable = class(TStormDateTimeField)

  end;

  [TestFixture]
  TStormDateTimeField_Test = class
  private
    Field : IDateTimeField;
    Function MyField : TStormDateTimeField_Testable;

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

{ TStormDateTimeField_Test }

procedure TStormDateTimeField_Test.FromDataField_Check;
Const
  value = 'aa';
VAR
  f : TDateTimeField;
begin
  {$WARN USE_BEFORE_DEF ON}
  assert.IsFalse(MyField.FromDataField(f));
  {$WARN USE_BEFORE_DEF OFF}
end;

procedure TStormDateTimeField_Test.GetValue_Check;
Const
  MyValue = 89.9;
begin
  Assert.IsFalse(MyField.GetValue.IsSome);
  MyField.SetValue(MyValue);
  Assert.IsTrue(MyField.GetValue.IsSome);
  Assert.AreEqual(TDatetime(MyValue),MyField.GetValueOrDefault(0.1));
end;

function TStormDateTimeField_Test.MyField: TStormDateTimeField_Testable;
begin
  Result := field as TStormDateTimeField_Testable;
end;

procedure TStormDateTimeField_Test.Setup;
begin
  Field := TStormDateTimeField_Testable.Create(My_Field_Name);
end;

procedure TStormDateTimeField_Test.SetValue_check;
Const
  EmptyValue = 0.0;
begin
  Assert.IsTrue(MyField.SetValue(EmptyValue));
  Assert.IsTrue(MyField.IsAssigned);
  Assert.AreEqual(TDateTime(EmptyValue),MyField.GetValueOrDefault(0.1));
end;

procedure TStormDateTimeField_Test.Value_check;
begin
  Assert.IsNotNull(MyField.Value);
end;

end.
