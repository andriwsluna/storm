unit storm.fields.float;

interface

uses
  storm.fields.base,
  storm.fields.interfaces,
  DFE.Maybe,
  storm.values.interfaces,
  storm.values.float,


  Data.DB,
  System.JSON,
  System.Classes,
  System.SysUtils;

Type
  TStormFloatField = Class(TStormField, IStormField,IFloatField)
    private

    protected
      Procedure InitializeStormValue(); Override;

    public

    public
      function  Value : IFloatValue;
      Function  SetValue(value : extended) : Boolean;
      Function  GetValue() :  Maybe<extended>;
      Function  GetValueOrDefault(default : extended = 0.0) :  extended;
      Function  FromDataField(field : TField) : boolean; Override;
  End;

implementation

{ TStormFloatField }




function TStormFloatField.FromDataField(field: TField): boolean;
begin
  Result := false;
  try
    if assigned(field) and (Not field.IsNull) then
    begin
      Result := Value.SetValue(field.AsExtended);
    end
  except
  {TODO -oOwner -cGeneral : ActionItem}
  end;
end;




function TStormFloatField.GetValue: Maybe<extended>;
begin
  Result := value.GetValue();
end;

function TStormFloatField.GetValueOrDefault(default: extended): extended;
begin
  result := GetValue.GetValueOrDefault(default);
end;

procedure TStormFloatField.InitializeStormValue;
begin
  inherited;
  FStormValue := storm.values.float.TFloatValue.Create;
end;



function TStormFloatField.SetValue(value: extended): Boolean;
begin
  Result := self.Value.SetValue(value);
end;

function TStormFloatField.Value: IFloatValue;
begin
  Result := FStormValue as IFloatValue;
end;

end.
