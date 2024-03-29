unit storm.fields.bool;

interface
uses
  storm.fields.base,
  DFE.Maybe,
  storm.values.interfaces,
  storm.values.bool,
  DATA.DB,
  storm.fields.interfaces;


Type
  TStormBooleanField = class(TStormField, IStormField, IBooleanField)
  private

  protected
    Procedure InitializeStormValue(); Override;
  public
    Function  Value : IBooleanValue;
    Function  SetValue(value : Boolean) : Boolean;
    Function  GetValue() :  Maybe<Boolean>;
    Function  GetValueOrDefault(default : Boolean = false) :  Boolean;
    Function  FromDataField(field : TField) : boolean; Override;
    Function  PopulateDataField(field : TField) : boolean; Override;
  end;

implementation

Uses
  storm.fields.utils;

{ TStormBooleanField }

function TStormBooleanField.FromDataField(field: TField): boolean;
begin
  Result := false;
  try
    if assigned(field) and (Not field.IsNull) then
    begin
      Result := Value.SetValue(field.AsBoolean);
    end
  except
  {TODO -oOwner -cGeneral : ActionItem}
  end;
end;

function TStormBooleanField.GetValue: Maybe<Boolean>;
begin
  Result := self.Value.GetValue;
end;

function TStormBooleanField.GetValueOrDefault(default: Boolean): Boolean;
begin
  Result := self.Value.GetValue.GetValueOrDefault(default);
end;

procedure TStormBooleanField.InitializeStormValue;
begin
  inherited;
  FStormValue := TbooleanValue.Create;
end;

function TStormBooleanField.PopulateDataField(Field: TField): boolean;
begin
  Result := false;
  try
    if assigned(Field) then
    begin
      Value.GetValue
      .OnSome
      (
        procedure(v : boolean)
        begin
          Field.AsBoolean := v;
        end
      )
      .OnNone
      (
        procedure
        begin
          Field.Clear;
        end
      );
      Result := True;
    end
  except
    {TODO -oOwner -cGeneral : PopulateDataField}
  end;
end;

function TStormBooleanField.SetValue(value: Boolean): Boolean;
begin
  Result := Self.Value.SetValue(value);
end;

function TStormBooleanField.Value: IBooleanValue;
begin
  Result := Self.FStormValue as IBooleanValue;
end;

end.
