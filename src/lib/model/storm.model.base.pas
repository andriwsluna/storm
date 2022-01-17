unit storm.model.base;

interface
USES
  storm.model.interfaces,
  storm.entity.interfaces,
  storm.additional.maybe,
  storm.entity.base,
  System.Classes,
  System.Json,
  System.Sysutils,
  Data.DB,
  System.Generics.Collections;

Type
  GetNewEntityFunction<EntityType : IStormEntity> = reference to function(): EntityType;
  TStormModel<EntityType : IStormEntity> = class(TInterfacedObject, IStormModel<EntityType>)
  private
    FRecords : Tlist<EntityType>;
  protected
    NewRecord : GetNewEntityFunction<EntityType>;

    Procedure Initialize; Virtual;
    Procedure Finalize; Virtual;


  public
    Constructor Create(); Reintroduce;
    Destructor Destroy(); Override;
    Constructor FromDataset(Dataset : TDataset ; NewEntityFunction : GetNewEntityFunction<EntityType>);

    Function  IsEmpty : Boolean;
    Function  IsNotEmpty : Boolean;
    Procedure AddRecord(entity : EntityType);
    Function Records() : TList<EntityType>;
    Function LoadFromDataset(Dataset : TDataset) : Boolean;
    Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONArray>;

  end;

implementation

{ TStormModel<EntityType> }

procedure TStormModel<EntityType>.AddRecord(entity: EntityType);
begin
  FRecords.Add(entity);
end;

constructor TStormModel<EntityType>.Create;
begin
  inherited;
  Initialize();
end;

destructor TStormModel<EntityType>.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TStormModel<EntityType>.Finalize;
begin
  FRecords.Free;
end;

constructor TStormModel<EntityType>.FromDataset(Dataset: TDataset ;  NewEntityFunction : GetNewEntityFunction<EntityType>);
begin
  Create;
  LoadFromDataset(Dataset);
end;

function TStormModel<EntityType>.LoadFromDataset(Dataset: TDataset): Boolean;
VAR
  rec : EntityType;
begin
  result := false;
  try

    if not Dataset.IsEmpty then
    begin
      Dataset.First;

      while not Dataset.Eof do
      begin

        rec := self.NewRecord();
        if rec.FromDataset(Dataset) then
        begin
          AddRecord(rec);
        end;

        Dataset.Next;
      end;

      result := FRecords.Count > 0;
    end;
  except
    on e : Exception do
    begin
      {TODO -oError -cGeneral : FromDataset}
    end;
  end;
end;



procedure TStormModel<EntityType>.Initialize;
begin
  FRecords := TList<EntityType>.Create();
end;


function TStormModel<EntityType>.IsEmpty: Boolean;
begin
  Result := FRecords.Count <= 0;
end;

function TStormModel<EntityType>.IsNotEmpty: Boolean;
begin
  Result := not IsEmpty;
end;

function TStormModel<EntityType>.Records: TList<EntityType>;
begin
  Result := FRecords;
end;

function TStormModel<EntityType>.ToJSON(
  ConvertNulls: Boolean): Maybe<TJSONArray>;
var
  recs : TJSONArray;
  rec : IStormEntity;

begin
  if IsNotEmpty then
  begin
    recs := TJSONArray.Create;

    for rec in Records do
    begin
      rec.ToJSON(ConvertNulls).OnSome
      (
        procedure(json : TJSONObject)
        begin
          recs.AddElement(json);
        end
      )
    end;

    if recs.Count > 0 then
    begin
      Result := recs;
    end;

  end;
end;

end.
