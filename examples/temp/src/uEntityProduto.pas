unit uEntityProduto;

interface
USES
  storm.fields.interfaces,
  storm.dependency.register,
  storm.entity.interfaces,
  storm.model.base,
  system.JSON,
  Data.DB,
  DFE.Interfaces,
  DFE.Maybe,
  system.Generics.Collections,
  storm.fields.str,
  storm.entity.base;


Type

  IProduto = interface(IStormEntity)['{F266C56E-C11D-442F-8FAF-502E648431F7}']
    function Codigo: IStringField;
    function Descricao: IStringField;
    Function Clone( Target : Iproduto) : Boolean;
  end;


  Function NewProduto() : IProduto;
  Function NewEntity() : IStormEntity;



  Procedure RegisterEntityConstructor;



implementation




  type
  TProduto = class(TStormEntity, IStormEntity, IProduto, ICloneable<IProduto>)
  private

  protected
    FCodigo     : IStringField;
    FDescricao  : IStringField;

    Procedure Initialize();  Override;
    procedure Finalize(); Override;
  public
    function Codigo: IStringField;
    function Descricao: IStringField;
    Function Clone( Target : Iproduto) : Boolean;
  end;

Procedure RegisterEntityConstructor;
begin
  DependencyRegister.RegisterEntityDependency
  (
    IProduto,
    TStormEntityDependency<IProduto>.Create(NewProduto)
  );
end;

{ TProduto }

function TProduto.Clone(Target: Iproduto): Boolean;
begin
  Result := TStormEntity(self).Clone(Target);
end;

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
  FCodigo     := TStringField.Create('codigo_produto');
  FDescricao  := TStringField.Create('descricao');

  AddStormField(FCodigo as IStormField);
  AddStormField(FDescricao as IStormField);
end;


Function NewProduto() : IProduto;
begin
  result := TProduto.Create;
end;

Function NewEntity() : IStormEntity;
begin
  result := NewProduto;
end;

INITIALIZATION
  RegisterEntityConstructor();


end.
