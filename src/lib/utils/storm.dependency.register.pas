unit storm.dependency.register;

interface

USES
  storm.entity.base,
  storm.entity.interfaces,
  storm.data.interfaces,
  DFE.Maybe,
  System.Generics.Collections,
  System.Classes,
  System.Sysutils;



Type

  TFuncEntityConstructor<EntityType : IStormEntity> = reference to function(): EntityType;
  TStormEntityDependency<EntityType : IStormEntity> = class

    private
      FConstructor : TFuncEntityConstructor<EntityType>;
    protected

    public
      Constructor Create(initializer : TFuncEntityConstructor<EntityType>); Reintroduce;
    public
      function GetConstructor : TFuncEntityConstructor<EntityType>;
  end;


  TStormDependencyRegister = class(TObject)

  private
    FRegisteredSqlDriver : IStormSQLDriver;
    FRegisteredEntityDependencies : TObjectDictionary<TGUID, Tobject>;
    FStormSQLConnection  : IStormSQLConnection;
    Constructor Create(); Reintroduce;
    Destructor  Destroy(); Reintroduce;
  protected

  public
    Function RegisterSQLDriver(SQLDriverInstance : IStormSQLDriver) : Boolean;
    Function GetSQLDriverInstance : Maybe<IStormSQLDriver>;

    Function RegisterSQLConnection(StormSQLConnection : IStormSQLConnection) : Boolean;
    Function GetSQLConnectionInstance : Maybe<IStormSQLConnection>;

    Function RegisterEntityDependency(entity : TGUID ; dependency : Tobject): boolean;
    Function GetEntityDependency(entity : TGUID): Maybe<Tobject>;





  public
    Class Procedure Initialize();
    Class Procedure Finalize();
    Class Function  GetInstance() : TStormDependencyRegister;
  end;




VAR
  DependencyRegister : TStormDependencyRegister;

Function RegisterSQLDriver(SQLDriverInstance : IStormSQLDriver) : Boolean;
Function GetSQLDriverInstance() : Maybe<IStormSQLDriver>;

implementation

Function RegisterSQLDriver(SQLDriverInstance : IStormSQLDriver) : Boolean;
Begin
  Result := DependencyRegister.RegisterSQLDriver(SQLDriverInstance);
End;
Function GetSQLDriverInstance() : Maybe<IStormSQLDriver>;
begin
  result := DependencyRegister.GetSQLDriverInstance();
end;

{ TStormDependencyRegister }

constructor TStormDependencyRegister.Create;
begin
  inherited;
  FRegisteredEntityDependencies := TObjectDictionary<TGUID, Tobject>.Create([doOwnsValues]);
end;

destructor TStormDependencyRegister.Destroy;
begin
  FRegisteredEntityDependencies.Free;
  inherited;
end;

class procedure TStormDependencyRegister.Finalize;
begin
  if Assigned(DependencyRegister) then
  begin
    DependencyRegister.Destroy;
  end;
end;

function TStormDependencyRegister.GetEntityDependency(
  entity: TGUID): Maybe<Tobject>;
begin
  if FRegisteredEntityDependencies.ContainsKey(entity) then
  begin
    result := FRegisteredEntityDependencies.Items[entity];
  end;

end;

class function TStormDependencyRegister.GetInstance: TStormDependencyRegister;
begin
  Initialize;
  Result := DependencyRegister;
end;

function TStormDependencyRegister.GetSQLConnectionInstance: Maybe<IStormSQLConnection>;
begin
  Result := FStormSQLConnection;
end;

function TStormDependencyRegister.GetSQLDriverInstance(
  ): Maybe<IStormSQLDriver>;
begin
  if Assigned(FRegisteredSqlDriver) then
  begin
    Result := FRegisteredSqlDriver;
  end;
end;


class procedure TStormDependencyRegister.Initialize;
begin
  if Not Assigned(DependencyRegister) then
  begin
    DependencyRegister := TStormDependencyRegister.Create;
  end;
end;

function TStormDependencyRegister.RegisterEntityDependency(entity: TGUID;
  dependency: Tobject): boolean;
begin
  FRegisteredEntityDependencies.Add(entity,dependency);
  result := true;
end;

function TStormDependencyRegister.RegisterSQLConnection(
  StormSQLConnection: IStormSQLConnection): Boolean;
begin
  FStormSQLConnection := StormSQLConnection;
  Result := true;
end;

function TStormDependencyRegister.RegisterSQLDriver(
  SQLDriverInstance: IStormSQLDriver): Boolean;
begin
  FRegisteredSqlDriver := SQLDriverInstance;
  Result := true;
end;


{ TStormEntityDependency<EntityType> }

constructor TStormEntityDependency<EntityType>.Create(
  initializer: TFuncEntityConstructor<EntityType>);
begin
  self.FConstructor := initializer;
end;

function TStormEntityDependency<EntityType>.GetConstructor: TFuncEntityConstructor<EntityType>;
begin
  Result := FConstructor;
end;

INITIALIZATION
  TStormDependencyRegister.Initialize();

FINALIZATION
  TStormDependencyRegister.Finalize();

end.
