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

    public
      function  Value : IStringValue;
      Function  SetValue(value : String) : Boolean;
      Function  GetValue() :  Maybe<String>;
      Function  GetValueOrDefault(default : string = '') :  string;
      Function  FromDataField(field : TField) : boolean; Override;


  End;

implementation

{ TStringField }




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




function TStringField.GetValue: Maybe<String>;
begin
  Result := value.GetValue();
end;

function TStringField.GetValueOrDefault(default: string): string;
begin
  result := GetValue.GetValueOrDefault(default);
end;

procedure TStringField.InitializeStormValue;
begin
  inherited;
  FStormValue := TStringValue.Create;
end;



function TStringField.SetValue(value: String): Boolean;
begin
  Result := self.Value.SetValue(value);
end;

function TStringField.Value: IStringValue;
begin
  Result := FStormValue as IStringValue;
end;

end.
