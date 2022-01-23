unit storm.orm.where;

interface
Uses
  storm.orm.base,
  DFE.Maybe,
  storm.entity.interfaces,
  storm.orm.interfaces,
  DFE.Interfaces,
  storm.schema.interfaces,

  System.Sysutils, System.Generics.Collections,System.Classes;

Type
  TNullableWhere = class(TStormColumnPartition)
  protected
    Procedure AddIsNull;
    Procedure AddIsNotNull;
  end;

  TEqualWhere = class(TStormColumnPartition)
  protected
    Procedure AddIsEqualTo(const value : variant);
    Procedure AddIsNotEqualTo(const value : variant);
  end;


  TStormWhereColumns = Class(TStormSQLPartition)
  protected
    ColumnSchema : IStormSchemaColumn;
  public
    Constructor Create(Owner : TStormSQLPartition ; Const ColumnSchema : IStormSchemaColumn); Reintroduce;
  End;

  TStormStringWhere = class(TStormWhereColumns)
  protected
    Procedure AddIsEqualTo(const value : string);
    Procedure AddIsNotEqualTo(const value : string);
  end;



implementation

{ TNullableWhere }

procedure TNullableWhere.AddIsNotNull;
begin
  AddSQL(GetColumnName + ' is not null');
end;

procedure TNullableWhere.AddIsNull;
begin
  AddSQL(GetColumnName + ' is null');
end;

{ TEqualWhere }

procedure TEqualWhere.AddIsEqualTo(const value: variant);
begin
  AddSQL(GetColumnName + ' = ' + AddParameter(value));
end;

procedure TEqualWhere.AddIsNotEqualTo(const value: variant);
begin
  AddSQL(GetColumnName + ' <> ' + AddParameter(value));
end;

{ TStormWhereColumn }


{ TStormWhereColumn }


{ TStormWhereColumn }



{ TStormWhereColumns }

constructor TStormWhereColumns.Create(Owner: TStormSQLPartition;
  const ColumnSchema: IStormSchemaColumn);
begin
  inherited create(Owner);

  if assigned(ColumnSchema) then
  begin
    self.ColumnSchema := ColumnSchema;
  end
  else
  begin
    raise Exception.Create('The parameter ColumnSchema must be assigned');
  end;
end;

{ TStormStringWhere }

procedure TStormStringWhere.AddIsEqualTo(const value: string);
var
  Where : TEqualWhere;
begin
  Where := TEqualWhere.Create(self, self.ColumnSchema);
  Where.AddIsEqualTo(value);
  Where.Free;
end;

procedure TStormStringWhere.AddIsNotEqualTo(const value: string);
var
  Where : TEqualWhere;
begin
  Where := TEqualWhere.Create(self, self.ColumnSchema);
  Where.AddIsNotEqualTo(value);
  Where.Free;
end;

end.
