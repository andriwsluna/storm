unit uEntityProduto;

interface
USES
  DFE.Interfaces,

  storm.fields.interfaces,
  storm.dependency.register,
  storm.entity.interfaces,
  storm.fields.str,
  storm.fields.int,
  storm.fields.float,
  storm.fields.date,
  storm.fields.datetime,
  storm.fields.bool,
  storm.entity.base;

Type

  IProduto = interface(IStormEntity)['{F266C56E-C11D-442F-8FAF-502E648431F7}']
    Function CodigoProduto : IIntegerField;
    Function Descricao     : IStringField;
    Function CodigoMarca   : IIntegerField;
    Function Preco         : IFloatField;
    Function Ativo         : IBooleanField;
    Function DataCriacao   : IDateField;
    Function DataAlteracao : IDateTimeField;
    Function Clone( Target : Iproduto) : Boolean;
  end;

  Function NewProduto() : IProduto;
  Function NewEntity() : IStormEntity;

  Procedure RegisterEntityConstructor;

implementation

Uses
  uSchemaProduto;

Procedure RegisterEntityConstructor;
begin
  DependencyRegister.RegisterEntityDependency
  (
    IProduto,
    TStormEntityDependency<IProduto>.Create(NewProduto)
  );
end;

Type

  TProduto = class(TStormEntity, IStormEntity, IProduto, ICloneable<IProduto>)
  private

  protected
    FCodigoProduto : IIntegerField;
    FDescricao     : IStringField;
    FCodigoMarca   : IIntegerField;
    FPreco         : IFloatField;
    FAtivo         : IBooleanField;
    FDataCriacao   : IDateField;
    FDataAlteracao : IDateTimeField;

    procedure Initialize(); override;
    procedure Finalize(); Override;
  public
    Constructor Create(); Reintroduce;

    Function CodigoProduto : IIntegerField;
    Function Descricao     : IStringField;
    Function CodigoMarca   : IIntegerField;
    Function Preco         : IFloatField;
    Function Ativo         : IBooleanField;
    Function DataCriacao   : IDateField;
    Function DataAlteracao : IDateTimeField;


    Function Clone( Target : Iproduto) : Boolean;

  end;


{ TProduto }

function TProduto.Ativo: IBooleanField;
begin
  Result := self.FAtivo;
end;

function TProduto.Clone(Target: Iproduto): Boolean;
begin
  Result := TStormEntity(self).Clone(Target);
end;

function TProduto.CodigoProduto: IIntegerField;
begin
  result := FCodigoProduto;
end;

function TProduto.CodigoMarca: IIntegerField;
begin
  Result := FCodigoMarca;
end;

constructor TProduto.Create;
begin
  inherited Create(uSchemaProduto.TSchemaProduto.Create());
end;

function TProduto.DataAlteracao: IDateTimeField;
begin
  Result := self.FDataAlteracao
end;

function TProduto.DataCriacao: IDateField;
begin
  Result := self.FDataCriacao;
end;

function TProduto.Descricao: IStringField;
begin
  result := FDescricao;
end;

procedure TProduto.Finalize;
begin
  inherited;
end;

procedure TProduto.Initialize();
begin
  inherited;
  FCodigoProduto     := TStormIntegerField.Create('codigo_produto');
  FDescricao  := TStormStringField.Create('descricao');
  FCodigoMarca  := TStormIntegerField.Create('codigo_marca');
  FPreco  := TStormFloatField.Create('preco');
  FAtivo  := TStormBooleanField.Create('ativo');
  FDataCriacao  := TStormDateField.Create('data_criacao');
  FDataAlteracao  := TStormDateTimeField.Create('data_alteracao');

  AddStormField(FCodigoProduto as IStormField);
  AddStormField(FDescricao as IStormField);
  AddStormField(FCodigoMarca as IStormField);
  AddStormField(FPreco as IStormField);
  AddStormField(FAtivo as IStormField);
  AddStormField(FDataCriacao as IStormField);
  AddStormField(FDataAlteracao as IStormField);
end;


function TProduto.Preco: IFloatField;
begin
  Result := self.FPreco;
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
