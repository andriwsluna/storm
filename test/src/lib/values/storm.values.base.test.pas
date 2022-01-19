{$TYPEINFO ON}
unit storm.values.base.test;

interface

uses
  storm.values.base,
  storm.values.str,
  storm.values.interfaces,

  System.Classes, System.SysUtils,
  DUnitX.TestFramework;


Type
  TStormValue_Testable = class(TStormValue)

  end;

  [TestFixture]
  TStormValue_Test = class
  private
    FStormValue : TStormValue_Testable;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

  published
    Procedure IsAssigned_Check();
    Procedure LoadFromJSON_CheckWithString();
    Procedure LoadFromJSON_CheckWithNumber();
    Procedure LoadFromJSON_CheckWithTrue();
    Procedure LoadFromJSON_CheckWithFalse();
    procedure LoadFromJSON_CheckWithNull();
  end;


{$TYPEINFO OFF}
implementation
Uses
  System.Json;
{ TStormValue_Test }



{ TStormValue_Test }

procedure TStormValue_Test.IsAssigned_Check;
begin
  Assert.IsFalse(FStormValue.IsAssigned);
  FStormValue.FAssigned := true;
  Assert.IsTrue(FStormValue.IsAssigned);
  FStormValue.Clear;
  Assert.IsFalse(FStormValue.IsAssigned);
end;

procedure TStormValue_Test.LoadFromJSON_CheckWithFalse;
VAR
  v : IStormValue;
begin
  v := TStringValue.Create;
  assert.IsTrue(TStormValue_Testable.LoadFromJSON(v, TJSONFalse.Create));
  assert.IsTrue(v.IsAssigned);
end;

procedure TStormValue_Test.LoadFromJSON_CheckWithNull;
VAR
  v : IStormValue;
begin
  v := TStringValue.Create;
  assert.IsFalse(TStormValue_Testable.LoadFromJSON(v, TJSONNull.Create));
  assert.IsFalse(v.IsAssigned);
end;

procedure TStormValue_Test.LoadFromJSON_CheckWithNumber;
VAR
  v : IStormValue;
begin
  v := TStringValue.Create;
  assert.IsTrue(TStormValue_Testable.LoadFromJSON(v, TJSONNumber.Create(1.89)));
  assert.IsTrue(v.IsAssigned);
end;

procedure TStormValue_Test.LoadFromJSON_CheckWithString;
VAR
  v : IStormValue;
begin
  v := TStringValue.Create;
  assert.IsTrue(TStormValue_Testable.LoadFromJSON(v, TJSONString.Create('a')));
  assert.IsTrue(v.IsAssigned);
end;

procedure TStormValue_Test.LoadFromJSON_CheckWithTrue;
VAR
  v : IStormValue;
begin
  v := TStringValue.Create;
  assert.IsTrue(TStormValue_Testable.LoadFromJSON(v, TJSONTrue.Create));
  assert.IsTrue(v.IsAssigned);
end;

procedure TStormValue_Test.Setup;
begin
  FStormValue := TStormValue_Testable.Create;
end;

procedure TStormValue_Test.TearDown;
begin
  FStormValue.Free;
end;

end.
