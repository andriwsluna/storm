unit storm.fields.int;

interface

uses
  storm.fields.base,
  storm.fields.interfaces,
  DFE.Maybe,
  storm.values.interfaces,
  storm.values.int,


  Data.DB,
  System.JSON,
  System.Classes,
  System.SysUtils;

Type
  TStormIntegerField = Class(TStormField, IStormField, IIntegerField)
    private

    protected
      Procedure InitializeStormValue(); Override;

    public

    public
      function  Value : IIntegerValue;
      Function  SetValue(value : integer) : Boolean;
      Function  GetValue() :  Maybe<integer>;
      Function  GetValueOrDefault(default : integer = 0) :  integer;
      Function  FromDataField(field : TField) : boolean; Override;
      Function  PopulateDataField(field : TField) : boolean; Override;
  End;

implementation

{ TStormIntegerField }




function TStormIntegerField.GetValue: Maybe<integer>;
begin
  Result := value.GetValue();
end;

function TStormIntegerField.FromDataField(field: TField): boolean;
begin
  Result := false;
  try
    if assigned(field) and (Not field.IsNull) then
    begin

      Result := Value.SetValue(field.AsInteger);
    end
  except
  {TODO -oOwner -cGeneral : ActionItem}
  end;
end;

function TStormIntegerField.GetValueOrDefault(default: integer): integer;
begin
  result := GetValue.GetValueOrDefault(default);
end;

procedure TStormIntegerField.InitializeStormValue;
begin
  inherited;
  FStormValue := TIntegerValue.Create;
end;

function TStormIntegerField.PopulateDataField(field: TField): boolean;
begin
  Result := false;
  try
    if assigned(field) then
    begin
      Value.GetValue
      .OnSome
      (
        procedure(v : Integer)
        begin
          field.AsInteger := v;
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

function TStormIntegerField.SetValue(value: integer): Boolean;
begin
  Result := self.Value.SetValue(value);
end;

function TStormIntegerField.Value: IIntegerValue;
begin
  Result := FStormValue as IIntegerValue;
end;

end.
