unit uORMProduto;

interface

uses
  storm.schema.interfaces,
  uSchemaProduto;

Type
  TStormPart = class abstract (TInterfacedObject)
  protected
    FSQL : String;

    Constructor Create(SQL : String = '');
  public
    property SQL: string read FSQL;
  end;
  TProdutoWhereSelection = class;
  TProdutoWhereCompositor = class(TStormPart)
  public
    Function And_() : TProdutoWhereSelection;
    Function Or_()  : TProdutoWhereSelection;
  end;
  TStringWhere = class
  private
    FSQL : String;
    FColumn : IStormSchemaColumn;
  public
    Constructor create(SQL : string ;column : IStormSchemaColumn); Reintroduce;
  public
    Function EqualsTo(str : string) : TProdutoWhereCompositor;
  end;

  TProdutoWhereSelection = class(TStormPart)
  public
    Function Codigo : TStringWhere;
  end;

  TProdutoWhere = class(TStormPart)
  public
    Function Where : TProdutoWhereSelection;
  end;

  TProdutoPossibleFields = (Codigo=0, Descricao=1);
  TProdutoSETFieldSelection = set of TProdutoPossibleFields;

  TProdutoFieldSelection = class(TStormPart)
  private
    Function From() : TProdutoWhere;
  public
    Function All() : TProdutoWhere;
    Function Only(fields : TProdutoSETFieldSelection) : TProdutoWhere;
  end;

  TORMProduto = class
  private

  protected


    Procedure Initialize();
    Procedure Finalize();
  public
    Constructor Create(); Reintroduce;
    Destructor  Destroy(); Override;
  public
    Function Select()  : TProdutoFieldSelection;
  end;

VAR
  FSchema : IStormTableSchema;


implementation

uses
  System.Sysutils;

{ TORMProduto }

constructor TORMProduto.Create;
begin
  inherited create();
  Initialize();
end;

destructor TORMProduto.Destroy;
begin
  Finalize();
  inherited;
end;

procedure TORMProduto.Finalize;
begin

end;

procedure TORMProduto.Initialize;
begin
  FSchema := TSchemaProduto.Create();
end;

function TORMProduto.Select: TProdutoFieldSelection;
begin
  result := TProdutoFieldSelection.Create('select ');
end;

{ TProdutoFieldSelection }

function TProdutoFieldSelection.All: TProdutoWhere;
begin
  FSQL := FSQL + ' *';
  result := From;
end;

function TProdutoFieldSelection.From: TProdutoWhere;
begin
  FSQL := FSQL + ' from ' + FSchema.GetSchemaName + '.' + FSchema.GetTableName;
  result := TProdutoWhere.Create(FSQL);
end;

function TProdutoFieldSelection.Only(fields : TProdutoSETFieldSelection): TProdutoWhere;
VAR
  s : string;
  field : TProdutoPossibleFields;
begin
  s := '';
  for field in fields do
  begin
    FSchema.ColumnById(integer(field)).Bind
    (
      procedure(colum : IStormSchemaColumn)
      begin
        s := s + ', ' + colum.GetColumnName;
      end
    );
  end;

  FSQL := FSQL + Copy(s,2, length(s));
  Result := from;

end;

{ TStormPart }

constructor TStormPart.Create(SQL: String);
begin
  FSQL := SQL;
end;

{ TStormWhereSelection }



{ TStringWhere }

constructor TStringWhere.create(SQL : string; column: IStormSchemaColumn);
begin
  inherited create();
  FSQL := sql;
  FColumn := column;
end;

function TStringWhere.EqualsTo(str: string): TProdutoWhereCompositor;
begin
  FSQL := Fsql  + ' ' + FColumn.GetColumnName + ' = ' + str;
  Result := TProdutoWhereCompositor.Create(FSQL);
end;

{ TProdutoWhereSelection }

function TProdutoWhereSelection.Codigo: TStringWhere;
begin
  result := TStringWhere.create(FSQL,TSchemaProduto(FSchema).Codigo);
end;

{ TProdutoWhere }

function TProdutoWhere.Where: TProdutoWhereSelection;
begin
  result :=  TProdutoWhereSelection.Create(FSQL + ' where');
end;

{ TProdutoWhereCompositor }

function TProdutoWhereCompositor.And_: TProdutoWhereSelection;
begin
  Result := TProdutoWhereSelection.Create(FSQL + ' and');
end;

function TProdutoWhereCompositor.Or_: TProdutoWhereSelection;
begin
  Result := TProdutoWhereSelection.Create(FSQL + ' or');
end;

end.
