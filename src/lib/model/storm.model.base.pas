unit storm.model.base;

interface
USES
  storm.model.interfaces,
  storm.entity.interfaces,
  System.Generics.Collections;

Type
  TStormModel<EntityType : IStormEntity> = class(TInterfacedObject, IStormModel<EntityType>)
  private
    FRecords : TList<EntityType>;
  protected
    Procedure Initialize; Virtual;
  public
    Constructor Create(); Reintroduce;

    Procedure AddRecord(entity : EntityType);
    Function Records() : TList<EntityType>;

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
  _AddRef;
  Initialize();
end;

procedure TStormModel<EntityType>.Initialize;
begin
  FRecords := TList<EntityType>.Create;
end;

function TStormModel<EntityType>.Records: TList<EntityType>;
begin
  Result := FRecords;
end;

end.
