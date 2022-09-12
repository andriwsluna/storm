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

  IProduto = interface(IStormEntity)['{3F351D3B-1071-4B6E-810C-396909CD585F}']
    function Codigo_produto : IIntegerField;
    function Descricao     : IStringField;
    function Codigo_marca  : IIntegerField;
    function Preco         : IFloatField;
    function Ativo         : IBooleanField;
    function Data_criacao  : IDateField;
    function Data_alteracao : IDateTimeField;
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
    FCodigo_produto : IIntegerField;
    FDescricao     : IStringField;
    FCodigo_marca  : IIntegerField;
    FPreco         : IFloatField;
    FAtivo         : IBooleanField;
    FData_criacao  : IDateField;
    FData_alteracao : IDateTimeField;
    
    procedure Initialize(); override;
    procedure Finalize(); override;
  public
    constructor Create(); reintroduce;
    
    function Codigo_produto : IIntegerField;
    function Descricao     : IStringField;
    function Codigo_marca  : IIntegerField;
    function Preco         : IFloatField;
    function Ativo         : IBooleanField;
    function Data_criacao  : IDateField;
    function Data_alteracao : IDateTimeField;
    
    function Clone(Target : IProduto): Boolean;
  end;
  
function TProduto.Codigo_produto(): IIntegerField;
begin
  result := self.FCodigo_produto;
end;

function TProduto.Descricao(): IStringField;
begin
  result := self.FDescricao;
end;

function TProduto.Codigo_marca(): IIntegerField;
begin
  result := self.FCodigo_marca;
end;

function TProduto.Preco(): IFloatField;
begin
  result := self.FPreco;
end;

function TProduto.Ativo(): IBooleanField;
begin
  result := self.FAtivo;
end;

function TProduto.Data_criacao(): IDateField;
begin
  result := self.FData_criacao;
end;

function TProduto.Data_alteracao(): IDateTimeField;
begin
  result := self.FData_alteracao;
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
  
  FCodigo_produto := TStormIntegerField.Create('codigo_produto');
  FDescricao     := TStormStringField.Create('descricao');
  FCodigo_marca  := TStormIntegerField.Create('codigo_marca');
  FPreco         := TStormFloatField.Create('preco');
  FAtivo         := TStormBooleanField.Create('ativo');
  FData_criacao  := TStormDateField.Create('data_criacao');
  FData_alteracao := TStormDateTimeField.Create('data_alteracao');
  
  AddStormField(FCodigo_produto as IStormField);
  AddStormField(FDescricao as IStormField);
  AddStormField(FCodigo_marca as IStormField);
  AddStormField(FPreco as IStormField);
  AddStormField(FAtivo as IStormField);
  AddStormField(FData_criacao as IStormField);
  AddStormField(FData_alteracao as IStormField);
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
