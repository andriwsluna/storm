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
  storm.fields.int,
  storm.entity.base;


Type

  IProduto = interface(IStormEntity)['{F266C56E-C11D-442F-8FAF-502E648431F7}']
    function Codigo: IStringField;
    function Descricao: IStringField;
    function CodigoMarca : IIntegerField;
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
    FCodigoMarca  : IIntegerField;

    Procedure Initialize();  Override;
    procedure Finalize(); Override;
  public
    function Codigo: IStringField;
    function Descricao: IStringField;
    function CodigoMarca : IIntegerField;
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

function TProduto.CodigoMarca: IIntegerField;
begin
  Result := FCodigoMarca;
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
  FCodigo     := TStormStringField.Create('codigo_produto');
  FDescricao  := TStormStringField.Create('descricao');
  FCodigoMarca  := TStormIntegerField.Create('codigo_marca');

  AddStormField(FCodigo as IStormField);
  AddStormField(FDescricao as IStormField);
  AddStormField(FCodigoMarca as IStormField);
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
