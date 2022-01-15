unit uEntityProduto;

interface
USES
  storm.fields.interfaces,
  storm.entity.interfaces,
  system.JSON,
  storm.additional.maybe,
  system.Generics.Collections,
  storm.fields.str,
  storm.entity.base;

Type
  IProduto = interface['{F266C56E-C11D-442F-8FAF-502E648431F7}']
    function Codigo: IStringField;
    function Descricao: IStringField;
    Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONObject>;
    Function FromJSON(Value : TJSONObject) : Boolean;
  end;

  Function NewProduto() : IProduto;




implementation


type
  TProduto = class(TStormEntity, IStormEntity, IProduto)
  private

  protected
    FCodigo     : IStringField;
    FDescricao  : IStringField;

    Procedure Initialize();  Override;
    procedure Finalize(); Override;
  public
    function Codigo: IStringField;
    function Descricao: IStringField;

  end;

{ TProduto }

function TProduto.Codigo: IStringField;
begin
  result := FCodigo;
end;

function TProduto.Descricao: IStringField;
begin
  result := FDescricao;
end;

procedure TProduto.Finalize;
begin
  inherited;
end;

procedure TProduto.Initialize;
begin
  inherited;
  FCodigo     := TStringField.Create('codigo');
  FDescricao  := TStringField.Create('descricao');

  AddStormField(FCodigo as IStormField);
  AddStormField(FDescricao as IStormField);
end;

Function NewProduto() : IProduto;
begin
  result := TProduto.Create;
end;

end.
