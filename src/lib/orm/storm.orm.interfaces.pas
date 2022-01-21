unit storm.orm.interfaces;

interface

uses
  System.Generics.Collections,
  storm.model.interfaces,
  storm.data.interfaces,
  storm.entity.interfaces,
  DFE.Result,
  Data.DB,
  DFE.Maybe,

  System.Sysutils, System.Classes;

Type
  TGetSqlCallback = reference to procedure(sql : string);

  {$region 'Select'}
  IStormSelectSuccessExecution<EntityType : IStormEntity> = interface['{A1E476AD-F4CA-45E6-942D-786DE12EEFB3}']
    Function GetDataset : TDataset;
    Function GetModel : IStormModel<EntityType>;
  end;

  IStormSelectFailExecution = interface['{D6B05C21-2F7B-452C-BE2B-9809A6439104}']
    Function GetErrorMessage() : String;
    Function GetSQL() : String;
  end;

  IStormSelectExecutorLimited<T : IStormEntity> = interface;

  IStormSelectExecutor<T : IStormEntity> = interface['{5F0A65E3-A0CC-4F68-9286-3931FA54C91C}']
    Function Limit(count : Integer) : IStormSelectExecutorLimited<T>;
    Function GetSQL(callback : TGetSqlCallback) : IStormSelectExecutor<T>;
    Function Open(connection : IStormSQLConnection) : TResult<IStormSelectSuccessExecution<T>,IStormSelectFailExecution>;
  end;

  IStormSelectExecutorLimited<T : IStormEntity> = interface['{D9DFC0F8-E5A4-4221-A106-0D59D25DECE6}']
    Function GetSQL(callback : TGetSqlCallback) : IStormSelectExecutor<T>;
    Function Open(connection : IStormSQLConnection) : TResult<IStormSelectSuccessExecution<T>,IStormSelectFailExecution>;
  end;

  {$endregion}

  {$region 'Update'}
  IStormUpdateSuccessExecution = interface['{A1E476AD-F4CA-45E6-942D-786DE12EEFB3}']
    Function GetUpdatedRowsCount : integer;
  end;

  IStormUpdateFailExecution = interface['{D6B05C21-2F7B-452C-BE2B-9809A6439104}']
    Function GetErrorMessage() : String;
    Function GetSQL() : String;
  end;

  IStormUpdateExecutor<T : IStormEntity> = interface['{5F0A65E3-A0CC-4F68-9286-3931FA54C91C}']
    Function GetSQL(callback : TGetSqlCallback) : IStormUpdateExecutor<T>;
    Function Execute(connection : IStormSQLConnection) : TResult<IStormUpdateSuccessExecution,IStormUpdateFailExecution>;
  end;

  IStormStringUpdater<UpdaterType> = interface['{218450AC-FA9F-405E-A790-40870AC86D40}']
    Function SetTo(value : string) : UpdaterType;
  end;

  IStormStringNullableUpdater<UpdaterType> = interface['{5079FF55-BCAB-4FDB-8D52-574FBFB91072}']
    Function SetTo(value : string) : UpdaterType;
    Function SetNull : UpdaterType;
  end;


  {$endregion}

  IWhereNode<WhereType> = interface['{A8E49DE9-6183-4464-881C-DF090693E627}']
      Function Where : WhereType;
  end;


  IStormWhereCompositor<WhereType, ExecutorType> = interface['{0FA8F62A-7548-48AB-B341-1015C4459A51}']
    Function And_() : WhereType;
    Function Or_()  : WhereType;
    Function Go() : ExecutorType;
    Function OpenParentheses() : WhereType;
    Function CloseParentheses() : IStormWhereCompositor<WhereType, ExecutorType>;
  end;


  IStringWhere<CompositorType>
  = interface['{B936FBBD-B8AF-426A-90C2-BC940414A1FC}']
    Function IsEqualsTo(value : string) : CompositorType;
    Function NotIsEqualsTo(value : string) : CompositorType;
    Function IsIn(value : TArray<String>) : CompositorType;
    Function IsNotIn(value :TArray<String>) : CompositorType;
    Function BeginsWith(value : string) : CompositorType;
    Function Contains(value : string) : CompositorType;
    Function EndsWith(value : string) : CompositorType;
  end;

  INullableStringWhere<CompositorType> =
  interface(IStringWhere<CompositorType>)['{B936FBBD-B8AF-426A-90C2-BC940414A1FC}']
    Function IsNull() : CompositorType;
    Function IsNotNull() : CompositorType;
  end;

  IStormFieldSelection<WhereType> = interface['{9AA32BD0-45FD-42D6-B88A-42570723FD21}']
    Function All() : IWhereNode<WhereType>;
  end;

  IStormQueryParameters = interface['{45188996-E885-495D-8CCB-B8894EDF2241}']
    function Add(value : variant) : string;
    function Items : TList<IQueryParameter>;
  end;


implementation

end.
