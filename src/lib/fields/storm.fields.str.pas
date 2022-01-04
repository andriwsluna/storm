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
  TStringField = Class(TStormField, IStormField)
    private
      FValue : TStringValue;

    protected
      Procedure Initialize(); Override;
      Procedure InitializeStormValue(); Override;
    public
      property Value: TStringValue read FValue;
  End;

implementation

{ TStringField }


procedure TStringField.Initialize;
begin
  inherited;

end;

procedure TStringField.InitializeStormValue;
begin
  inherited;
  FValue := TStringValue.Create;
  FStormValue := FValue;
end;



end.
