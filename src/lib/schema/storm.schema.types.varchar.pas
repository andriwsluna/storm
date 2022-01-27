unit storm.schema.types.varchar;

interface

Uses
  storm.schema.interfaces,

  System.Classes,
  System.Sysutils;

Type

  TStormVarchar = Class(TInterfacedObject, IStormSchemaType)
  private

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


implementation

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

end.
