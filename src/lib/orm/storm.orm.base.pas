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
    FSQL : String;
    FParameters : TStormQueryParameters;
  protected



    Procedure  AddSQL(sql : string);
    function   AddParameter(value : variant) : string;

    Function _GetSQL() : String;
  public
    Constructor Create(owner : TStormSQLPartition = nil); Reintroduce; Virtual;
  end;

  TStormQueryPartition = class abstract (TStormSQLPartition, IStormQueryPartition)
  private

  protected
  public


    Function GetSQL() : String;
    Function GetParameters : TList<TQueryParameter>;

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

  if Assigned(owner) then
  begin
    FSQL := owner.FSQL;
    if assigned(owner.FParameters) then
    begin
      FParameters := owner.FParameters;
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

  _AddRef;
end;


function TStormSQLPartition._GetSQL: String;
begin
  Result := FSQL;
end;



{ TStormQueryPartition }


function TStormQueryPartition.GetParameters: TList<TQueryParameter>;
begin
  Result := FParameters.Items;
end;

function TStormQueryPartition.GetSQL: String;
begin
  result := _GetSQL;
end;


end.
