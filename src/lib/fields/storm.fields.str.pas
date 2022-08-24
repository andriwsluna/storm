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
  TStormStringField = Class(TStormField, IStormField,IStringField)
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
      Function  PopulateDataField(field : TField) : boolean; Override;
  End;

implementation

{ TStormStringField }




function TStormStringField.FromDataField(field: TField): boolean;
begin
  Result := false;
  try
    if assigned(field) and (Not field.IsNull) then
    begin
      Result := Value.SetValue(field.AsString);
    end
  except
  {TODO -oOwner -cGeneral : ActionItem}
  end;
end;




function TStormStringField.GetValue: Maybe<String>;
begin
  Result := value.GetValue();
end;

function TStormStringField.GetValueOrDefault(default: string): string;
begin
  result := GetValue.GetValueOrDefault(default);
end;

procedure TStormStringField.InitializeStormValue;
begin
  inherited;
  FStormValue := TStringValue.Create;
end;



function TStormStringField.PopulateDataField(field: TField): boolean;
begin
  Result := false;
  try
    if assigned(field) then
    begin
      Value.GetValue
      .OnSome
      (
        procedure(v : string)
        begin
          field.AsString := v;
        end
      )
      .OnNone
      (
        procedure
        begin
          Field.Clear();
        end
      );
      Result := True;
    end
  except
    {TODO -oOwner -cGeneral : PopulateDataField}
  end;
end;


function TStormStringField.SetValue(value: String): Boolean;
begin
  Result := self.Value.SetValue(value);
end;

function TStormStringField.Value: IStringValue;
begin
  Result := FStormValue as IStringValue;
end;

end.
