unit storm.fields.datetime;

interface

uses
  storm.fields.base,
  storm.fields.interfaces,
  DFE.Maybe,
  storm.values.interfaces,
  storm.values.DateTime,


  Data.DB,
  System.JSON,
  System.Classes,
  System.SysUtils;

Type
  TStormDateTimeField = Class(TStormField, IStormField,IDateTimeField)
    private

    protected
      Procedure InitializeStormValue(); Override;

    public

    public
      function  Value : IDateTimeValue;
      Function  SetValue(value : TDateTime) : Boolean;
      Function  GetValue() :  Maybe<TDateTime>;
      Function  GetValueOrDefault(default : TDateTime = 0.0) :  TDateTime;
      Function  FromDataField(field : TField) : boolean; Override;
      Function  PopulateDataField(field : TField) : boolean; Override;
  End;

implementation

{ TStormDateTimeField }




function TStormDateTimeField.FromDataField(field: TField): boolean;
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




function TStormDateTimeField.GetValue: Maybe<TDateTime>;
begin
  Result := value.GetValue();
end;

function TStormDateTimeField.GetValueOrDefault(default: TDateTime): TDateTime;
begin
  result := GetValue.GetValueOrDefault(default);
end;

procedure TStormDateTimeField.InitializeStormValue;
begin
  inherited;
  FStormValue := storm.values.DateTime.TDateTimeValue.Create;
end;



function TStormDateTimeField.PopulateDataField(field: TField): boolean;
begin
  Result := false;
  try
    if assigned(field) then
    begin
      Value.GetValue
      .OnSome
      (
        procedure(v : TDateTime)
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

function TStormDateTimeField.SetValue(value: TDateTime): Boolean;
begin
  Result := self.Value.SetValue(value);
end;

function TStormDateTimeField.Value: IDateTimeValue;
begin
  Result := FStormValue as IDateTimeValue;
end;

end.
