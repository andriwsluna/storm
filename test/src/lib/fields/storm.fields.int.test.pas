{$TYPEINFO ON}
unit storm.fields.int.test;

interface
uses
  storm.fields.base,
  storm.fields.int,
  storm.fields.interfaces,
  System.Json,
  DAta.DB,

  System.Classes, System.SysUtils,
  DUnitX.TestFramework;

Const
  My_Field_Name = 'my_field';

Type
  TStormIntegerField_Testable = class(TStormIntegerField)

  end;

  [TestFixture]
  TStormIntegerField_Test = class
  private
    Field : IIntegerField;
    Function MyField : TStormIntegerField_Testable;

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

{ TStormIntegerField_Test }

procedure TStormIntegerField_Test.FromDataField_Check;
Const
  value = 'aa';
VAR
  f : TStringField;
begin
  {$WARN USE_BEFORE_DEF ON}
  assert.IsFalse(MyField.FromDataField(f));
  {$WARN USE_BEFORE_DEF OFF}
end;

procedure TStormIntegerField_Test.GetValue_Check;
Const
  MyInt = 895;
begin
  Assert.IsFalse(MyField.GetValue.IsSome);
  MyField.SetValue(MyInt);
  Assert.IsTrue(MyField.GetValue.IsSome);
  Assert.AreEqual(MyInt,MyField.GetValueOrDefault(0));
end;

function TStormIntegerField_Test.MyField: TStormIntegerField_Testable;
begin
  Result := field as TStormIntegerField_Testable;
end;

procedure TStormIntegerField_Test.Setup;
begin
  Field := TStormIntegerField_Testable.Create(My_Field_Name);
end;

procedure TStormIntegerField_Test.SetValue_check;
Const
  ZeroValue = 0;
begin
  Assert.IsTrue(MyField.SetValue(ZeroValue));
  Assert.IsTrue(MyField.IsAssigned);
  Assert.AreEqual(ZeroValue,MyField.GetValueOrDefault(1));
end;

procedure TStormIntegerField_Test.Value_check;
begin
  Assert.IsNotNull(MyField.Value);
end;

end.

