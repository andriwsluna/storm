unit uEntityProduto;

interface
USES
  storm.fields.str,
  storm.entity.base;

Type
  TProduto = class(TStormEntity)
  private

  protected
    FCodigo     : TStringField;
    FDescricao  : TStringField;

    Procedure Initialize();  Override;
  public
    property Codigo: TStringField read FCodigo;
    property Descricao: TStringField read FDescricao;

  end;


implementation

{ TProduto }

procedure TProduto.Initialize;
begin
  inherited;
  FCodigo     := TStringField.Create('codigo');
  FDescricao  := TStringField.Create('descricao');

  AddStormField(FCodigo);
  AddStormField(FDescricao);
end;

end.
