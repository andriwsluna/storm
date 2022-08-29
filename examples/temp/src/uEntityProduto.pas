unit uEntityProduto;

interface

uses
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

  IProduto = interface(IStormEntity)['{0B875E78-7DEA-43DE-98DC-83B05F749788}']
    function CodigoProduto : IIntegerField;
    function Descricao     : IStringField;
    function CodigoMarca   : IIntegerField;
    function Preco         : IFloatField;
    function Ativo         : IBooleanField;
    function DataCriacao   : IDateField;
    function DataAlteracao : IDateTimeField;
    function Clone(Target : IProduto) : Boolean;
  end;

function  NewProduto() : IProduto;
function  NewEntity() : IStormEntity;
procedure RegisterEntityConstructor();

implementation

uses
  uSchemaProduto;

procedure RegisterEntityConstructor;
begin
  DependencyRegister.RegisterEntityDependency
  (
    IProduto,
    TStormEntityDependency<IProduto>.Create(NewProduto)
  );
end;

type

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
    procedure Finalize(); override;
  public
    constructor Create(); reintroduce;

    function CodigoProduto : IIntegerField;
    function Descricao     : IStringField;
    function CodigoMarca   : IIntegerField;
    function Preco         : IFloatField;
    function Ativo         : IBooleanField;
    function DataCriacao   : IDateField;
    function DataAlteracao : IDateTimeField;

    function Clone(Target : IProduto): Boolean;
  end;

function TProduto.CodigoProduto(): IIntegerField;
begin
  result := self.FCodigoProduto;
end;

function TProduto.Descricao(): IStringField;
begin
  result := self.FDescricao;
end;

function TProduto.CodigoMarca(): IIntegerField;
begin
  result := self.FCodigoMarca;
end;

function TProduto.Preco(): IFloatField;
begin
  result := self.FPreco;
end;

function TProduto.Ativo(): IBooleanField;
begin
  result := self.FAtivo;
end;

function TProduto.DataCriacao(): IDateField;
begin
  result := self.FDataCriacao;
end;

function TProduto.DataAlteracao(): IDateTimeField;
begin
  result := self.FDataAlteracao;
end;

function TProduto.Clone(Target: IProduto): Boolean;
begin
  result := TStormEntity(self).Clone(Target);
end;

constructor TProduto.Create();
begin
  inherited Create(uSchemaProduto.TSchemaProduto.Create());
end;

procedure TProduto.Finalize();
begin
  inherited;
end;

procedure TProduto.Initialize();
begin
  inherited;

  FCodigoProduto := TStormIntegerField.Create('codigo_produto');
  FDescricao     := TStormStringField.Create('descricao');
  FCodigoMarca   := TStormIntegerField.Create('codigo_marca');
  FPreco         := TStormFloatField.Create('preco');
  FAtivo         := TStormBooleanField.Create('ativo');
  FDataCriacao   := TStormDateField.Create('data_criacao');
  FDataAlteracao := TStormDateTimeField.Create('data_alteracao');

  AddStormField(FCodigoProduto as IStormField);
  AddStormField(FDescricao as IStormField);
  AddStormField(FCodigoMarca as IStormField);
  AddStormField(FPreco as IStormField);
  AddStormField(FAtivo as IStormField);
  AddStormField(FDataCriacao as IStormField);
  AddStormField(FDataAlteracao as IStormField);
end;

function NewProduto() : IProduto;
begin
  result := TProduto.Create;
end;

function NewEntity() : IStormEntity;
begin
  result := NewProduto;
end;

INITIALIZATION
  RegisterEntityConstructor();

end.

