unit storm.fields.str;

interface

uses
  storm.fields.base,
  storm.fields.interfaces,
  storm.additional.maybe,
  storm.values.interfaces,
  storm.values.str,


  System.JSON,
  System.Classes,
  System.SysUtils;

Type
  TStringField = Class(TStormField, IStormField,IStringField)
    private


    protected
      Procedure InitializeStormValue(); Override;


    public
      function Value : IStringValue;
  End;

implementation

{ TStringField }


function TStringField.Value: IStringValue;
begin
  Result := FStormValue as IStringValue;
end;



procedure TStringField.InitializeStormValue;
begin
  inherited;
  FStormValue := TStringValue.Create;
end;



end.
