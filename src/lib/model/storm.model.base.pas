unit storm.model.base;

interface
USES
  storm.model.interfaces,
  storm.entity.interfaces,
  storm.additional.maybe,
  storm.entity.base,
  storm.dependency.register,
  System.Classes,
  System.Json,
  System.Sysutils,
  Data.DB,

  System.Generics.Collections;

Type

  TStormModel<EntityType : IStormEntity> = class(TInterfacedObject, IStormModel<EntityType>)
  private
    FRecords : Tlist<EntityType>;

    Procedure SolverEntityDependecy(dependecy : TObject);
  protected
    NewRecord : TFuncEntityConstructor<EntityType>;

    Procedure Initialize; Virtual;
    Procedure Finalize; Virtual;


  public
    Constructor Create(); Reintroduce;
    Destructor Destroy(); Override;
    Constructor FromDataset(Dataset : TDataset);

    Function  IsEmpty : Boolean;
    Function  IsNotEmpty : Boolean;
    Procedure AddRecord(entity : EntityType);
    Function Records() : TList<EntityType>;
    Function LoadFromDataset(Dataset : TDataset) : Boolean;
    Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONArray>;

  end;

implementation

uses
  System.TypInfo;

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

constructor TStormModel<EntityType>.FromDataset(Dataset: TDataset);
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

  DependencyRegister.GetEntityDependency(GetTypeData(TypeInfo(EntityType)).GUID)
  .OnSome(SolverEntityDependecy);
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

procedure TStormModel<EntityType>.SolverEntityDependecy(dependecy: TObject);
begin
  NewRecord := TStormEntityDependency<EntityType>(dependecy).GetConstructor();
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
