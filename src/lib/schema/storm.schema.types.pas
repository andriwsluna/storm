unit storm.schema.types;

interface

Uses
  storm.schema.interfaces,
  storm.data.interfaces,
  System.Classes,
  System.Sysutils;

Type

  TStormVarchar = Class(TInterfacedObject, IStormSchemaType)
  protected
    FLength : integer;
  public
    property Length : integer read FLength;

  public
    Constructor Create(Length : integer); Reintroduce;
    Function GetType() : String;
  End;

  TStormInt = Class(TInterfacedObject, IStormSchemaType)
    Function GetType() : String;
  End;

  TStormNumeric = Class(TInterfacedObject, IStormSchemaType)
  protected
    FScale: integer;
    FPrecision : integer;
  public
    property Scale : integer read FScale;
    property Precision : integer read FPrecision;

  public
    Constructor Create(Scale, Precision  : integer); Reintroduce;
    Function GetType() : String;
  End;

  TStormBoolean = Class(TInterfacedObject, IStormSchemaType)
    Function GetType() : String;
  End;

  TStormDate = Class(TInterfacedObject, IStormSchemaType)
    Function GetType() : String;
  End;

  TStormDateTime = Class(TInterfacedObject, IStormSchemaType)
    Function GetType() : String;
  End;


implementation

uses
  storm.dependency.register;

{ TStormVarchar }

constructor TStormVarchar.Create(Length: integer);
begin
  inherited Create();
  FLength := Length;
end;

function TStormVarchar.GetType: String;
begin
  Result := Format('VARCHAR(%d)', [FLength]);
end;

{ TStormInt }

function TStormInt.GetType: String;
begin
   Result := 'INT';
end;

{ TStormNumeric }

constructor TStormNumeric.Create(Scale, Precision: integer);
begin
  Self.FScale := Scale;
  Self.FPrecision := Precision;
  inherited create();
end;

function TStormNumeric.GetType: String;
begin
   Result := Format('VARCHAR(%d,%d)', [FScale, FPrecision]);
end;

{ TStormBoolean }

function TStormBoolean.GetType: String;
VAR
  tp : string;
begin
  DependencyRegister.GetSQLDriverInstance
  .OnSome
  (
    procedure(driver : IStormSQLDriver)
    begin
      tp := driver.GetBooleanType
    end
  )
  .OnNone
  (
    procedure()
    begin
      raise Exception.Create('No SQL Driver registered');
    end
  );

  result := tp;
end;

{ TStormDate }

function TStormDate.GetType: String;
begin
  Result := 'DATE';
end;

{ TStormDateTime }

function TStormDateTime.GetType: String;
begin
  Result := 'DATETIME';
end;

end.
