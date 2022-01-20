unit storm.fields.base.test;

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
  TStormField_Testable = class(TStormField)
    protected
      Procedure InitializeStormValue(); Override;
    public

  end;

  [TestFixture]
  TStormField_Test = class
  private
    Field : TStormField_Testable;


  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

  published
    Procedure IsAssigned_Check();
    Procedure Clear_Check();
    Procedure JSONName_check();
    Procedure FieldName_check();
    Procedure ToJSON_Check();
    Procedure FromJSON_Pair_Check();
    Procedure FromJSON_Object_Check();
    Procedure FromDataField_Check();
    Procedure FromDataSet_Check();
    Procedure Clone_check();
  end;
{$TYPEINFO OFF}
implementation

{ TStormField_Test }

procedure TStormField_Test.Clear_Check;
begin
  TStringValue(Field.StormValue).SetValue('1');
  Field.Clear;
  Assert.IsFalse(Field.IsAssigned());
  Assert.IsFalse(Field.FStormValue.IsAssigned());

end;

procedure TStormField_Test.Clone_check;
VAr
  sField : IStringField;
begin
  Assert.IsFalse(Field.Clone(nil));
  sField := storm.fields.str.TStringField.Create('aloha');
  Assert.IsFalse(Field.Clone(sField));
  sField.SetValue('1');
  Assert.Istrue(Field.Clone(sField));
end;

procedure TStormField_Test.FieldName_check;
begin
  Assert.AreEqual(My_Field_Name, field.FieldName);
end;

procedure TStormField_Test.FromDataField_Check;
begin
  Assert.IsFalse(field.FromDataField(TField.Create(nil)));
end;

procedure TStormField_Test.FromDataSet_Check;
begin
  Assert.IsFalse(field.FromDataSet(nil));
end;

procedure TStormField_Test.FromJSON_Object_Check;
var
  obj : TJSONObject;
begin
  {$WARN USE_BEFORE_DEF ON}
  Assert.IsFalse(field.FromJSON(obj));
  {$WARN USE_BEFORE_DEF OFF}
  obj := TJSONObject.Create;
  try
    Assert.IsFalse(field.FromJSON(obj));
    obj.AddPair(TJSONPair.Create('aloha','arola'));
    Assert.IsFalse(field.FromJSON(obj));
    obj.AddPair(TJSONPair.Create(My_Field_Name,'arola'));
    Assert.IsTrue(field.FromJSON(obj));
  finally
    obj.Free;
  end;
end;

procedure TStormField_Test.FromJSON_Pair_Check;
VAR
  pair : TJSONPair;
begin

  {$WARN USE_BEFORE_DEF ON}
  Assert.IsFalse(field.FromJSON(pair));
  {$WARN USE_BEFORE_DEF OFF}
  Assert.IsFalse(field.FromJSON(TJSONPair.Create('aloha','arola')));
  Assert.IsTrue(field.FromJSON(TJSONPair.Create(My_Field_Name,'arola')));
end;

procedure TStormField_Test.IsAssigned_Check;
begin
  Assert.IsFalse(Field.IsAssigned());
  Assert.IsFalse(Field.FStormValue.IsAssigned());
  TStringValue(Field.StormValue).SetValue('1');
  Assert.IsTrue(Field.IsAssigned());
  Assert.IsTrue(Field.FStormValue.IsAssigned());
end;

procedure TStormField_Test.JSONName_check;
begin
  Assert.AreEqual(My_Field_Name, field.JSONName);
end;

procedure TStormField_Test.Setup;
begin
  Field := TStormField_Testable.Create(My_Field_Name);
end;



procedure TStormField_Test.TearDown;
begin
  Field.Free;
end;

procedure TStormField_Test.ToJSON_Check;
begin
  Assert.IsFalse(Field.ToJSON(false).IsSome);
  Assert.IsTrue(Field.ToJSON(true).IsSome);
  Assert.AreEqual(TJsonString.create(field.JSONName).ToString,Field.ToJSON(true).GetValueOrDefault(TjsonPair.create).JsonString.ToString);
  Assert.IsTrue(Field.ToJSON(true).GetValueOrDefault(TjsonPair.create).JsonValue is TJSONNull);
  TStringValue(Field.StormValue).SetValue('aloha');
  Assert.IsTrue(Field.ToJSON(true).GetValueOrDefault(TjsonPair.create).JsonValue is TJSONString);
end;

{ TStormField_Testable }


procedure TStormField_Testable.InitializeStormValue;
begin
  inherited;
  FStormValue := TstringValue.Create;
end;

end.
