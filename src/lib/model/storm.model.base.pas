unit storm.model.base;

interface
USES
  storm.model.interfaces,
  storm.entity.interfaces,
  DFE.Maybe,
  storm.entity.base,
  storm.dependency.register,
  DFE.Iterator,
  DFE.Interfaces,
  System.Classes,
  System.Json,
  System.Sysutils,
  Data.DB,

  System.Generics.Collections;

Type

  TStormModel<EntityType : IStormEntity> =
  class(TIterator<EntityType, IStormModel<EntityType>>, IStormModel<EntityType>)
  private


    Procedure SolverEntityDependecy(dependecy : TObject);
  protected

    NewRecord : TFuncEntityConstructor<EntityType>;

    Procedure Initialize; Override;
    Procedure Finalize; Override;
    Function  NewIteratorConstructor : IStormModel<EntityType>; Override;

  public
    Constructor FromDataset(Dataset : TDataset);
    Procedure AddRecord(entity : EntityType);
    Function Records() : TList<EntityType>;
    Function LoadFromDataset(Dataset : TDataset) : Boolean;
    Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONArray>;
    function  ForEach(proc : TForEachFunction<EntityType>) : IStormModel<EntityType>;
    function  Map(func : TMapFunction<EntityType>) : IStormModel<EntityType>;
    function  Filter(func : TFilterFunction<EntityType>) : IStormModel<EntityType>;
  end;

implementation

uses
  System.TypInfo;

{ TStormModel<EntityType> }



procedure TStormModel<EntityType>.AddRecord(entity: EntityType);
begin
  Fitems.Add(entity);
end;


function TStormModel<EntityType>.Filter(
  func: TFilterFunction<EntityType>): IStormModel<EntityType>;
begin
  Result := self.LocalFilter(func);
end;

procedure TStormModel<EntityType>.Finalize;
begin
  inherited;
end;

function TStormModel<EntityType>.ForEach(
  proc: TForEachFunction<EntityType>): IStormModel<EntityType>;
begin
  Result := self.LocalForEach(proc);
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

      result := Fitems.Count > 0;
    end;
  except
    on e : Exception do
    begin
      {TODO -oError -cGeneral : FromDataset}
    end;
  end;
end;



function TStormModel<EntityType>.Map(
  func: TMapFunction<EntityType>): IStormModel<EntityType>;
begin
  Result := self.LocalMap(func);
end;

function TStormModel<EntityType>.NewIteratorConstructor: IStormModel<EntityType>;
begin
  Result := TStormModel<EntityType>.Create;
end;

procedure TStormModel<EntityType>.Initialize;
begin
  inherited;
  DependencyRegister.GetEntityDependency(GetTypeData(TypeInfo(EntityType)).GUID)
  .OnSome(SolverEntityDependecy);
end;



function TStormModel<EntityType>.Records: TList<EntityType>;
begin
  Result := Fitems;
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
