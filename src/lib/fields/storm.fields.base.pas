unit storm.fields.base;

interface


USES
  storm.values.interfaces,
  storm.fields.interfaces,
  DFE.Maybe,
  Data.DB,
  System.Classes,
  System.JSON,
  System.SysUtils;


Type
  TStormField = Class Abstract(TInterfacedObject)
    private

    protected
      FFieldName : String;
      FJSONName : String;
      FStormValue : IStormValue;
      Procedure Initialize();  Virtual;
      Procedure InitializeStormValue(); Virtual; Abstract;

    public


      Constructor Create(name : String); Reintroduce;

      Function  IsAssigned() : Boolean;
      Procedure Clear();
      Function  StormValue() : IStormValue;
      Function  JSONName() : String;
      Function  FieldName() : String;

      Function  ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONPair>;
      Function  FromJSON(Value : TJSONPair) : Boolean; Overload;
      Function  FromJSON(Value : TJSONObject) : Boolean; Overload;
      Function  FromDataField(field : TField) : boolean; Virtual;
      Function  FromDataSet(dataset : TDataset) : boolean;
      Function  PopulateDataset(dataset : TDataset) : boolean;
      Function  PopulateDataField(field : TField) : boolean; Virtual;

      Function  Clone(Target : IStormField) : Boolean;


  End;

implementation

{ TStormField }

procedure TStormField.Clear;
begin
  FStormValue.Clear();
end;



function TStormField.Clone(Target: IStormField): Boolean;
begin
  if Assigned(Target) then
  BEGIN
    Result := StormValue.Clone(Target.StormValue);
  END
  else
  begin
    Result := False;
  end;
end;

constructor TStormField.Create(name: String);
begin
  inherited Create();
  FFieldName := name;
  FJSONName := name;
  Initialize();
end;

function TStormField.FieldName: String;
begin
  Result:= FFieldName;
end;

function TStormField.FromDataField(field: TField): boolean;
begin
  Result := False;
end;

function TStormField.FromDataSet(dataset: TDataset): boolean;
begin
  Result := false;
  try
    Result := FromDataField(dataset.FieldByName(self.FFieldName));
  except
    on e : Exception do
    begin
      {TODO -oError -cGeneral : FromDataSet}
    end;
  end;

end;

function TStormField.FromJSON(Value: TJSONObject): Boolean;
begin
  Result := false;
  try
    if assigned(Value) and assigned(value.Get(self.FJSONName)) then
    begin
      result := FromJSON(value.Get(self.FJSONName));
    end;
  except
    on e:exception do
    begin
      {TODO -oOwner -cGeneral : ActionItem}
    end;

  end;
end;

function TStormField.FromJSON(Value: TJSONPair): Boolean;
begin
  result := false;
  if assigned(Value) and assigned(Value.JsonString) then
  begin
    if Value.JsonString.Value = FJSONName then
    begin
      Result := StormValue.FromJSON(Value.JsonValue);
    end;
  end;
end;

procedure TStormField.Initialize;
begin
  InitializeStormValue();
end;

function TStormField.IsAssigned: Boolean;
begin
  Result := FStormValue.IsAssigned();
end;






function TStormField.JSONName: String;
begin
  Result := FJSONName;
end;

function TStormField.PopulateDataField(field: TField): boolean;
begin
  Result := false;
end;

function TStormField.PopulateDataset(dataset: TDataset): boolean;
begin
  Result := false;
  try
    if Self.IsAssigned then
    begin
       Result := PopulateDataField(dataset.FieldByName(self.FFieldName));
    end
    else
    begin
      dataset.FieldByName(self.FFieldName).Clear;
      Result := true;
    end;
  except
    on e : Exception do
    begin
      {TODO -oError -cGeneral : PopulateDataset}
    end;
  end;
end;

function TStormField.StormValue: IStormValue;
begin
  Result := FStormValue;
end;

function TStormField.ToJSON(ConvertNulls: Boolean): Maybe<TJSONPair>;
VAR
  pair : TJSONPair;
begin
  StormValue.ToJSON(ConvertNulls).Bind
  (
    procedure(val : TJSONValue)
    begin
      pair := TJSONPair.Create(FJSONName,val);
    end
  );

  if assigned(pair) then
  begin
    result := pair;
  end;
end;

end.
