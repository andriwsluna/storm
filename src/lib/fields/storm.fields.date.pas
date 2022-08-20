unit storm.fields.date;

interface

uses
  storm.fields.base,
  storm.fields.interfaces,
  DFE.Maybe,
  storm.values.interfaces,
  storm.values.Date,


  Data.DB,
  System.JSON,
  System.Classes,
  System.SysUtils;

Type
  TStormDateField = Class(TStormField, IStormField,IDateField)
    private

    protected
      Procedure InitializeStormValue(); Override;

    public

    public
      function  Value : IDateValue;
      Function  SetValue(value : TDate) : Boolean;
      Function  GetValue() :  Maybe<TDate>;
      Function  GetValueOrDefault(default : TDate = 0.0) :  TDate;
      Function  FromDataField(field : TField) : boolean; Override;
      Function  PopulateDataField(field : TField) : boolean; Override;
  End;

implementation

{ TStormDateField }




function TStormDateField.FromDataField(field: TField): boolean;
begin
  Result := false;
  try
    if assigned(field) and (Not field.IsNull) then
    begin
      Result := Value.SetValue(field.AsDateTime);
    end
  except
  {TODO -oOwner -cGeneral : ActionItem}
  end;
end;




function TStormDateField.GetValue: Maybe<TDate>;
begin
  Result := value.GetValue();
end;

function TStormDateField.GetValueOrDefault(default: TDate): TDate;
begin
  result := GetValue.GetValueOrDefault(default);
end;

procedure TStormDateField.InitializeStormValue;
begin
  inherited;
  FStormValue := storm.values.Date.TDateValue.Create;
end;



function TStormDateField.PopulateDataField(field: TField): boolean;
begin
  Result := false;
  try
    if assigned(field) then
    begin
      Value.GetValue
      .OnSome
      (
        procedure(v : TDate)
        begin
          field.AsDateTime := v;
        end
      )
      .OnNone
      (
        procedure
        begin
          field.Value := varNull;
        end
      );
      Result := True;
    end
  except
    {TODO -oOwner -cGeneral : PopulateDataField}
  end;
end;

function TStormDateField.SetValue(value: TDate): Boolean;
begin
  Result := self.Value.SetValue(value);
end;

function TStormDateField.Value: IDateValue;
begin
  Result := FStormValue as IDateValue;
end;

end.
