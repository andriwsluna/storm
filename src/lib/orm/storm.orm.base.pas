unit storm.orm.base;

interface

Uses

  storm.additional.maybe,
  storm.orm.interfaces,
  storm.orm.query,
  System.Generics.Collections,
  System.Sysutils, System.Classes;

Type

  TStormSQLPartition = class abstract (TInterfacedObject)
  private
    Fowner : TStormSQLPartition;
    FSQL : String;
    FParameters : IStormQueryParameters;
  protected
    Procedure Initialize; Virtual;


    Procedure  AddSQL(sql : string);
    function   AddParameter(value : variant) : string;

    Function _GetSQL() : String;
  public
    Constructor Create(owner : TStormSQLPartition = nil); Reintroduce; Virtual;
    Destructor  Destroy(); Override;
  end;

  TStormQueryPartition = class abstract (TStormSQLPartition, IStormQueryPartition)
  private

  protected
  public


    Function GetSQL() : String;
    Function GetParameters : TList<IQueryParameter>;

  end;

implementation


function TStormSQLPartition.AddParameter(value: variant): string;
begin
  result := FParameters.Add(value);
end;

procedure TStormSQLPartition.AddSQL(sql: string);
begin
  FSQL := FSQL + sql;
end;



constructor TStormSQLPartition.Create(owner : TStormSQLPartition);
begin
  inherited create();
  Fowner := owner;
  Initialize;
end;


destructor TStormSQLPartition.Destroy;
begin
  if Assigned(Fowner) then
  BEGIN
    if Fowner.FRefCount = 0 then
    begin
      Fowner.Free;
    end;
  END;
  inherited;
end;

procedure TStormSQLPartition.Initialize;
begin
  if Assigned(Fowner) then
  begin
    FSQL := Fowner.FSQL;
    if assigned(Fowner.FParameters) then
    begin
      FParameters := Fowner.FParameters;
    end
    else
    begin
      FParameters := TStormQueryParameters.Create;
    end;


  end
  else
  begin
    FParameters := TStormQueryParameters.Create;
  end;
end;

function TStormSQLPartition._GetSQL: String;
begin
  Result := FSQL;
end;



{ TStormQueryPartition }


function TStormQueryPartition.GetParameters: TList<IQueryParameter>;
begin
  Result := TStormQueryParameters(FParameters).Items;
end;

function TStormQueryPartition.GetSQL: String;
begin
  result := _GetSQL;
end;


end.
