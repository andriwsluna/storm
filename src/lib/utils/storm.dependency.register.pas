unit storm.dependency.register;

interface

USES
  storm.entity.base,
  storm.entity.interfaces,
  storm.data.interfaces,
  storm.additional.maybe,
  System.Generics.Collections,
  System.Classes,
  System.Sysutils;



Type
  TStormDependencyRegister = class(TObject)

  private
    FRegisteredSqlDriver : IStormSQLDriver;

    Constructor Create(); Reintroduce;
    Destructor Destroy(); Reintroduce;
  protected

  public
    Function RegisterSQLDriver(SQLDriverInstance : IStormSQLDriver) : Boolean;
    Function GetSQLDriverInstance : Maybe<IStormSQLDriver>;

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

end;

destructor TStormDependencyRegister.Destroy;
begin
  inherited;
end;

class procedure TStormDependencyRegister.Finalize;
begin
  if Assigned(DependencyRegister) then
  begin
    DependencyRegister.Destroy;
  end;
end;

class function TStormDependencyRegister.GetInstance: TStormDependencyRegister;
begin
  Initialize;
  Result := DependencyRegister;
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

function TStormDependencyRegister.RegisterSQLDriver(
  SQLDriverInstance: IStormSQLDriver): Boolean;
begin
  FRegisteredSqlDriver := SQLDriverInstance;
  Result := true;
end;

INITIALIZATION
  TStormDependencyRegister.Initialize();

FINALIZATION
  TStormDependencyRegister.Finalize();

end.
