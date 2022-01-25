unit uORMProduto;

interface

uses
  DFE.Result,
  storm.model.interfaces,
  Data.DB,
  storm.data.interfaces,
  storm.orm.interfaces,
  System.TypInfo,
  uEntityProduto;

Type
  TProdutoPossibleFields = (Codigo=0, Descricao=1);
  TProdutoSETFieldSelection = set of TProdutoPossibleFields;

  IProdutoSelectByIDSuccess = interface['{EA9B3145-5974-4DF0-9DA5-97B42BEE876D}']
    Function GetEntity : IProduto;
  end;

  IProdutoSelectByIDFail = interface['{BD9D3FEA-76BB-4C46-9E36-BCDC4AD7CD4F}']
    Function GetErrorMessage()    : String;
    Function GetExecutedCommand() : String;
  end;

  IProdutoSelectByIDResult = DFE.Result.TResult<IProdutoSelectByIDSuccess, IProdutoSelectByIDFail>;

  IProdutoDeleteSuccess = interface['{13CCB0EA-3F5F-4253-B82C-D12BC5AB28B0}']
    Function GetRowsDeleted : Integer;
  end;

  IProdutoDeleteFail = interface['{3825050D-7EE6-4A63-93B4-1F6B5DCC0CD5}']
    Function GetErrorMessage()    : String;
    Function GetExecutedCommand() : String;
  end;

  IProdutoExecuteDeleteResult = DFE.Result.TResult<IProdutoDeleteSuccess, IProdutoDeleteFail>;

  IProdutoDeleteExecutor = interface['{78896797-B60F-410B-9149-8110C6341E3E}']
    Function Execute() : IProdutoExecuteDeleteResult;
  end;


  IProdutoInsertSuccess = interface['{F43BC981-65B3-4AED-A87C-47668FAFFB24}']
    Function GetInserted : IProduto;
  end;

  IProdutoInsertFail = interface['{F71F683C-6B68-42C2-9F1B-472CE007D78F}']
    Function GetErrorMessage()    : String;
    Function GetExecutedCommand() : String;
  end;

  IProdutoExecuteInsertResult = DFE.Result.TResult<IProdutoInsertSuccess, IProdutoInsertFail>;

  IProdutoInsertExecutor = interface['{D18196B3-C10E-4502-9540-DD410988446E}']
    Function Execute() : IProdutoExecuteInsertResult;
  end;

  IProdutoUpdateSuccess = interface['{388A529E-AE19-468F-BA91-09A37C2524F5}']
    Function GetRowsUpdated : integer;
  end;

  IProdutoUpdateFail = interface['{9E0EE68B-7846-457B-89E0-F02FA8E956B6}']
    Function GetErrorMessage()    : String;
    Function GetExecutedCommand() : String;
  end;

  IProdutoExecuteUpdateResult = DFE.Result.TResult<IProdutoUpdateSuccess, IProdutoUpdateFail>;

  IProdutoUpdateExecutor = interface['{350CC46D-3CC6-41FC-8899-7804FDD48D2A}']
    Function Execute() : IProdutoExecuteUpdateResult;
  end;

  IProdutoSelectSuccess = interface['{23FCA183-991E-48C0-A472-3620F0C9C524}']
    Function GetDataset : TDataset;
    Function GetModel   : IStormModel<IProduto>;
  end;

  IProdutoSelectFail = interface['{2F52D965-EA31-415E-90CF-7785412FE80E}']
    Function GetErrorMessage()    : String;
    Function GetExecutedCommand() : String;
  end;

  IProdutoOpenSelectResult = DFE.Result.TResult<IProdutoSelectSuccess, IProdutoSelectFail>;

  IProdutoSelectExecutor = interface['{6EE28899-6AE6-417B-AF6F-22BD5246F095}']
    Function Open() : IProdutoOpenSelectResult;
  end;

  IProdutoWherePartition<IExecutorType : IInterface> = interface;

  IProdutoWhereCompositor<IExecutorType : IInterface> = interface['{C3169555-2341-42BF-8D9F-154595F4224E}']
    Function _And()             : IProdutoWherePartition<IExecutorType>;
    Function _Or()              : IProdutoWherePartition<IExecutorType>;
    Function OpenParenthesis()  : IProdutoWherePartition<IExecutorType>;
    Function CloseParenthesis() : IProdutoWhereCompositor<IExecutorType>;
    Function Go()               : IExecutorType;
  end;


  IProdutoWherePartition<IExecutorType : IInterface> = interface['{FF54F2B9-9BF1-4B0E-B318-62C65A693098}']
    Function Codigo()           : IStormStringWhere<IProdutoWhereCompositor<IExecutorType>, IExecutorType>;
    Function OpenParenthesis()  : IProdutoWherePartition<IExecutorType>;
  end;

  IProdutoSelectWhere= interface['{748B71BC-FBF0-4330-A7EF-DCA221B24B81}']
    Function Where() : IProdutoWherePartition<IProdutoSelectExecutor>;
  end;

  IProdutoFieldAssignmentWithWhere = interface;

  IProdutoFieldAssignmentWithWhere = interface['{5FA6BB69-C0C5-4FD4-BCE9-DF97F0D5FF72}']
    Function Codigo   : IStormStringFieldAssignment<IProdutoFieldAssignmentWithWhere>;
    Function Where()  : IProdutoWherePartition<IProdutoUpdateExecutor>;
  end;

  IProdutoFieldAssignment = interface['{5246E7C8-F87C-4B39-A26A-AFD8304963C4}']
    Function Codigo : IStormStringFieldAssignment<IProdutoFieldAssignmentWithWhere>;
  end;

  IProdutoFieldSelection = interface['{F165348C-AC5D-47C9-A538-A419ECBB02AC}']
    Function All()  : IProdutoSelectWhere;
    Function Only(fields : TProdutoSETFieldSelection) : IProdutoSelectWhere;
  end;

  IProdutoFieldsInsertionWithGo = interface;

  IProdutoStringFieldInsertion = interface['{FF0C363B-373A-4845-A124-630B170D82E0}']
    Function Insert(Const Value : string) : IProdutoFieldsInsertionWithGo;
  end;

  IProdutoFieldsInsertionWithGo = interface['{AF81639F-578F-4045-81A0-9289F855024A}']
    Function Codigo : IProdutoStringFieldInsertion;
    Function Go     : IProdutoInsertExecutor;
  end;

  IProdutoFieldsInsertion = interface['{2882508E-A523-415F-82AE-3FA84C5A720A}']
    Function Codigo : IProdutoStringFieldInsertion;
  end;

  IProdutoInsertValues = interface['{CA07FE1E-231D-459C-8EE1-250DD1E4A733}']
    Function Values() : IProdutoFieldsInsertion;
  end;

  IProdutoDeleteValues = interface['{5CB2A15B-AF15-48EE-8161-D1C14D8D798B}']
    Function Where() : IProdutoWherePartition<IProdutoDeleteExecutor>;
  end;

  IProdutoORM = interface['{E6255D1D-30FE-400A-8355-DD8CC1E62CB4}']
    Function Select() : IProdutoFieldSelection;
    Function Update() : IProdutoFieldAssignment;
    Function Insert() : IProdutoInsertValues;
    Function Delete() : IProdutoDeleteValues;


    Function SelectByID(Const Codigo : String) : IProdutoSelectByIDResult;
  end;


  Function NewProdutoORM(DbSQLConnecton: IStormSQLConnection) : IProdutoORM;

implementation

Uses
  storm.schema.interfaces,
  storm.dependency.register,storm.orm.update,
  uSchemaProduto,
  System.Sysutils,
  storm.orm.where,
  storm.orm.base;

Type



  TProdutoORM = Class;
  IExecutorProvider<IExecutorType : IInterface> = interface['{F10E3AE5-9BE3-4E70-A42B-C87E7B1E4CB9}']
    Function GetExecutorInstance(owner : TStormSqlPartition) : IExecutorType;
  end;



  TProdutoUpdateSuccess = class(TStormUpdateSuccess, IProdutoUpdateSuccess)end;
  TProdutoUpdateFail = class(TStormExecutionFail, IProdutoUpdateFail)end;

  TProdutoUpdateExecutor = class(TStormUpdateExecutor, IProdutoUpdateExecutor)
    Function Execute() : IProdutoExecuteUpdateResult;
  end;

  TProdutoFieldAssignment
  = Class
  (
    TStormFieldAssignment,
    IProdutoFieldAssignment,
    IProdutoFieldAssignmentWithWhere
  )
  public
    Function Codigo : IStormStringFieldAssignment<IProdutoFieldAssignmentWithWhere>;
    Function Where()  : IProdutoWherePartition<IProdutoUpdateExecutor>;
  end;

  TProdutoSelectSuccess = class(TStormSelectSuccess<IProduto>, IProdutoSelectSuccess)

  end;

  TProdutoSelectFail = class(TStormExecutionFail, IProdutoSelectFail)
  public

  end;

  TProdutoSelectExecutor = class(TStormSelectExecutor, IProdutoSelectExecutor)
    Function Open() : IProdutoOpenSelectResult;
  end;




  TProdutoWhereCompositor<IExecutorType : IInterface> = class(TStormSqlPartition, IProdutoWhereCompositor<IExecutorType>)
  protected
    Function GetProvider(target : TStormSqlPartition) : IExecutorProvider<IExecutorType>;
  public
    Function _And()             : IProdutoWherePartition<IExecutorType>;
    Function _Or()              : IProdutoWherePartition<IExecutorType>;
    Function OpenParenthesis()  : IProdutoWherePartition<IExecutorType>;
    Function CloseParenthesis() : IProdutoWhereCompositor<IExecutorType>;
    Function Go()               : IExecutorType;
  end;

  TProdutoWherePartition<IExecutorType : IInterface> = class(TStormWherePartition, IProdutoWherePartition<IExecutorType>)
  public
    Function Codigo()           : IStormStringWhere<IProdutoWhereCompositor<IExecutorType>, IExecutorType>;
    Function OpenParenthesis()  : IProdutoWherePartition<IExecutorType>;
  end;

  TProdutoSelectWhere = class(TStormWhere, IProdutoSelectWhere)
  public
    Function Where() : IProdutoWherePartition<IProdutoSelectExecutor>;

  end;

  TProdutoFieldSelection = class(TStormFieldSelection, IProdutoFieldSelection)
  public
    Function All()  : IProdutoSelectWhere;
    Function Only(fields : TProdutoSETFieldSelection) : IProdutoSelectWhere;
  end;


  TProdutoSelectExecutorConstructor = class(TInterfacedObject, IStormGenericReturn<IProdutoSelectExecutor>)
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoSelectExecutor;
  end;

  TProdutoUpdateExecutorConstructor = class(TInterfacedObject, IStormGenericReturn<IProdutoUpdateExecutor>)
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoUpdateExecutor;
  end;

  TProdutoFieldAssignmentConstructor = class(TInterfacedObject, IStormGenericReturn<IProdutoFieldAssignment>)
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoFieldAssignment;
  end;

  TProdutoFieldAssignmentWithWhereConstructor = class(TInterfacedObject, IStormGenericReturn<IProdutoFieldAssignmentWithwhere>)
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoFieldAssignmentWithwhere;
  end;

  TProdutoWhereCompositorSelectConstructor = class(TInterfacedObject,
  IStormGenericReturn<IProdutoWhereCompositor<IProdutoSelectExecutor>>)
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoWhereCompositor<IProdutoSelectExecutor>;
  end;

  TProdutoWhereCompositorUpdateConstructor = class(TInterfacedObject,
  IStormGenericReturn<IProdutoWhereCompositor<IProdutoUpdateExecutor>>)
    Function GetGenericInstance(Owner : TStormSQLPartition) : IProdutoWhereCompositor<IProdutoUpdateExecutor>;
  end;


  TProdutoORM = Class(TStormORM, IProdutoORM)
  private
    Function SchemaProduto : TSchemaProduto;
  protected
    function NewProdutoUpdateExecutor(owner : TStormSqlPartition) : TInterfacedObject;
    procedure Initialize; override;

  public
    Constructor Create(DbSQLConnecton : IStormSQLConnection);
  public
    Function Select() : IProdutoFieldSelection;
    Function Update() : IProdutoFieldAssignment;
    Function Insert() : IProdutoInsertValues;
    Function Delete() : IProdutoDeleteValues;


    Function SelectByID(Const Codigo : String) : IProdutoSelectByIDResult;
  End;

Function TProdutoORM.NewProdutoUpdateExecutor(owner : TStormSqlPartition) : TInterfacedObject;
begin
  Result := TProdutoUpdateExecutor.Create(owner);
end;

Function NewProdutoORM(DbSQLConnecton: IStormSQLConnection) : IProdutoORM;
begin
  Result := TProdutoORM.Create(DbSQLConnecton);
end;



{ TProdutoORM }

constructor TProdutoORM.Create(DbSQLConnecton: IStormSQLConnection);
begin
  inherited create(DbSQLConnecton, TSchemaProduto.Create);
end;

function TProdutoORM.Delete: IProdutoDeleteValues;
begin

end;

procedure TProdutoORM.Initialize;
begin
  inherited;
  FClassConstructor.Add(TGUID(IProdutoSelectExecutor).ToString, TProdutoSelectExecutorConstructor.Create);
  FClassConstructor.Add(TGUID(IProdutoUpdateExecutor).ToString, TProdutoUpdateExecutorConstructor.Create);
  FClassConstructor.Add(TGUID(IProdutoFieldAssignment).ToString, TProdutoFieldAssignmentConstructor.Create);
  FClassConstructor.Add(TGUID(IProdutoFieldAssignmentWithWhere).ToString, TProdutoFieldAssignmentWithWhereConstructor.Create);

  FClassConstructor.Add
  (
    TGUID(IProdutoWhereCompositor<IProdutoSelectExecutor>).ToString +
    TGUID(IProdutoSelectExecutor).ToString,
    TProdutoWhereCompositorSelectConstructor.Create
  );

  FClassConstructor.Add
  (
    TGUID(IProdutoWhereCompositor<IProdutoUpdateExecutor>).ToString +
    TGUID(IProdutoUpdateExecutor).ToString,
    TProdutoWhereCompositorUpdateConstructor.Create
  );




end;

function TProdutoORM.Insert: IProdutoInsertValues;
begin

end;

function TProdutoORM.SchemaProduto: TSchemaProduto;
begin
  Result := self.TableSchema as TSchemaProduto;
end;

function TProdutoORM.Select: IProdutoFieldSelection;
begin
  Result := TProdutoFieldSelection.Create(self,nil);
end;

function TProdutoORM.SelectByID(const Codigo: String): IProdutoSelectByIDResult;
begin

end;

function TProdutoORM.Update: IProdutoFieldAssignment;
begin

  Result := TProdutoFieldAssignment.Create(self);
end;

{ TProdutoFieldSelection }

function TProdutoFieldSelection.All: IProdutoSelectWhere;
begin
  SelectAll;
  Result := TProdutoSelectWhere.Create(self);
end;



function TProdutoFieldSelection.Only(fields : TProdutoSETFieldSelection): IProdutoSelectWhere;
VAR
  s : string;
  field : TProdutoPossibleFields;
begin
  s := '';

  for field in fields do
  begin
    TableSchema.ColumnById(integer(field)).Onsome
    (
      procedure(colum : IStormSchemaColumn)
      begin
        s := s + ', ' + TableSchema.GetTableName + '.' + colum.GetColumnName;
      end
    );
  end;

  AddSQL(Copy(s,2, length(s)));
  from;
  Result := TProdutoSelectWhere.Create(self);
end;

{ TProdutoSelectWhere }


function TProdutoSelectWhere.Where: IProdutoWherePartition<IProdutoSelectExecutor>;
begin
  AddWhere;
  Result :=  TProdutoWherePartition<IProdutoSelectExecutor>.Create(self);
end;

{ TProdutoWherePartition<IExecutorType> }


function TProdutoWherePartition<IExecutorType>.Codigo: IStormStringWhere<IProdutoWhereCompositor<IExecutorType>, IExecutorType>;
begin
  Result := TStormStringWhere<IProdutoWhereCompositor<IExecutorType>, IExecutorType>.Create(self, TProdutoORM(self.ORM).SchemaProduto.Codigo);
end;

function TProdutoWherePartition<IExecutorType>.OpenParenthesis: IProdutoWherePartition<IExecutorType>;
begin
  Self.AddOpenParenthesis;
  Result := Self;
end;

{ TProdutoWhereCompositor<IExecutorType> }

function TProdutoWhereCompositor<IExecutorType>.CloseParenthesis: IProdutoWhereCompositor<IExecutorType>;
begin
  AddCloseParenthesis;
  Result := Self;
end;

function TProdutoWhereCompositor<IExecutorType>.GetProvider(target : TStormSqlPartition): IExecutorProvider<IExecutorType>;
VAR
  Provider : IExecutorProvider<IExecutorType>;
begin
  if assigned(target) then
  BEGIN
    if Supports(target, IExecutorProvider<IExecutorType>, Provider) then
    begin
      Result := Provider;
    end
    else
    begin
      Result  := GetProvider(target.GetOwner);
    end;
  END
  else
  begin
    result := nil;
  end;

end;

function TProdutoWhereCompositor<IExecutorType>.Go: IExecutorType;
VAR
  Provider : IStormGenericReturn<IExecutorType>;
  obj : TInterfacedObject;
begin
  Provider := TProdutoORM(self.ORM).FClassConstructor.Items[GetTypeData(TypeInfo(IExecutorType)).GUID.ToString]  as IStormGenericReturn<IExecutorType>;

  Result := provider.GetGenericInstance(self);
end;

function TProdutoWhereCompositor<IExecutorType>.OpenParenthesis: IProdutoWherePartition<IExecutorType>;
begin
  AddOpenParenthesis;
  Result := TProdutoWherePartition<IExecutorType>.Create(self);
end;

function TProdutoWhereCompositor<IExecutorType>._And: IProdutoWherePartition<IExecutorType>;
begin
  AddAnd();
  Result := TProdutoWherePartition<IExecutorType>.Create(self);
end;

function TProdutoWhereCompositor<IExecutorType>._Or: IProdutoWherePartition<IExecutorType>;
begin
  AddOr();
  Result := TProdutoWherePartition<IExecutorType>.Create(self);
end;

{ TProdutoSelectExecutor }

function TProdutoSelectExecutor.Open: IProdutoOpenSelectResult;
var
  Return : IProdutoOpenSelectResult;
begin
  OpenSQL
    .OnSuccess
    (
      procedure(Dataset : Tdataset)
      begin
        Return := TProdutoSelectSuccess.Create(Dataset)
      end
    )
    .OnFail
    (
      procedure(ErrorMessage : String)
      begin
        Return := TProdutoSelectFail.Create(ErrorMessage,sql)
      end
    );
  Result := Return;
end;

{ TProdutoFieldAssignment }



function TProdutoFieldAssignment.Codigo: IStormStringFieldAssignment<IProdutoFieldAssignmentWithWhere>;
begin
  Result := TStormStringFieldAssignment<IProdutoFieldAssignmentWithWhere>
    .Create(self,TSchemaProduto(self.TableSchema).Codigo);
end;


function TProdutoFieldAssignment.Where: IProdutoWherePartition<IProdutoUpdateExecutor>;
begin
  AddWhere;
  Result := TProdutoWherePartition<IProdutoUpdateExecutor>.Create(Self);
end;

{ TProdutoUpdateExecutor }

function TProdutoUpdateExecutor.Execute: IProdutoExecuteUpdateResult;
var
  Return : IProdutoExecuteUpdateResult;
begin
  ExecuteSQL
    .OnSuccess
    (
      procedure(rows : integer)
      begin
        Return := TProdutoUpdateSuccess.Create(rows)
      end
    )
    .OnFail
    (
      procedure(ErrorMessage : String)
      begin
        Return := TProdutoUpdateFail.Create(ErrorMessage,sql)
      end
    );
  Result := Return;
end;

{ TProdutoSelectExecutorConstructor }

function TProdutoSelectExecutorConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoSelectExecutor;
begin
  Result := TProdutoSelectExecutor.Create(Owner);
end;



{ TProdutoUpdateExecutorConstructor }

function TProdutoUpdateExecutorConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoUpdateExecutor;
begin
  Result := TProdutoUpdateExecutor.Create(Owner);
end;

{ TProdutoFieldAssignmentConstructor }

function TProdutoFieldAssignmentConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoFieldAssignment;
begin
  Result := TProdutoFieldAssignment.Create(owner);
end;

{ TProdutoFieldAssignmentWithWhereConstructor }

function TProdutoFieldAssignmentWithWhereConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoFieldAssignmentWithwhere;
begin
  Result := TProdutoFieldAssignment.Create(owner);
end;

{ TProdutoWhereCompositorSelectConstructor }

function TProdutoWhereCompositorSelectConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoWhereCompositor<IProdutoSelectExecutor>;
begin
  Result := TProdutoWhereCompositor<IProdutoSelectExecutor>.Create(owner);
end;

{ TProdutoWhereCompositorUpdateConstructor }

function TProdutoWhereCompositorUpdateConstructor.GetGenericInstance(
  Owner: TStormSQLPartition): IProdutoWhereCompositor<IProdutoUpdateExecutor>;
begin
  Result := TProdutoWhereCompositor<IProdutoUpdateExecutor>.Create(owner);
end;

end.
