unit storm.fields.str;

interface

uses
  storm.fields.base,
  storm.fields.interfaces,
  DFE.Maybe,
  storm.values.interfaces,
  storm.values.str,


  Data.DB,
  System.JSON,
  System.Classes,
  System.SysUtils;

Type
  TStringField = Class(TStormField, IStormField,IStringField)
    private


    protected
      Procedure InitializeStormValue(); Override;


    public
      function  Value : IStringValue;
      Function  FromDataField(field : TField) : boolean; Override;
  End;

implementation

{ TStringField }


function TStringField.Value: IStringValue;
begin
  Result := FStormValue as IStringValue;
end;



function TStringField.FromDataField(field: TField): boolean;
begin
  if assigned(field) then
  begin
    Result := Value.SetValue(field.AsString);
  end
  else
  begin
    Result := false;
  end;

end;

procedure TStringField.InitializeStormValue;
begin
  inherited;
  FStormValue := TStringValue.Create;
end;



end.
