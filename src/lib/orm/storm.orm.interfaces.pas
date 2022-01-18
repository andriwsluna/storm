unit storm.orm.interfaces;

interface

uses
  System.Generics.Collections,
  storm.model.interfaces,
  storm.data.interfaces,
  storm.entity.interfaces,
  storm.additional.result,
  Data.DB,
  storm.additional.maybe,

  System.Sysutils, System.Classes;

Type

  IStormQuerySuccessExecution<EntityType : IStormEntity> = interface['{A1E476AD-F4CA-45E6-942D-786DE12EEFB3}']
    Function GetDataset : TDataset;
    Function GetModel : IStormModel<EntityType>;
  end;

  IStormQueryFailExecution = interface['{D6B05C21-2F7B-452C-BE2B-9809A6439104}']
    Function GetErrorMessage() : String;
    Function GetSQL() : String;
  end;


  TGetSqlCallback = reference to procedure(sql : string);

  IStormQueryExecutor<T : IStormEntity> = interface['{5F0A65E3-A0CC-4F68-9286-3931FA54C91C}']
    Function GetSQL(callback : TGetSqlCallback) : IStormQueryExecutor<T>;
    Function Open(connection : IStormSQLConnection) : TResult<IStormQuerySuccessExecution<T>,IStormQueryFailExecution>;
  end;

  IStormQueryPartition<T : IStormEntity>= interface['{1453EBB4-0723-418F-BA9F-16528086EFBD}']
    Function Go() : IStormQueryExecutor<T>;
  end;

  IWhereNode<EntityType : IStormEntity; T : IStormQueryPartition<EntityType>> = interface['{A8E49DE9-6183-4464-881C-DF090693E627}']
      Function Where : T;
  end;

  IStormWhereCompositor<G : IStormEntity ; T : IStormQueryPartition<G> > = interface['{0FA8F62A-7548-48AB-B341-1015C4459A51}']
    Function And_() : T;
    Function Or_()  : T;
    Function Go() : IStormQueryExecutor<G>;
    Function OpenParentheses() : T;
    Function CloseParentheses() : IStormWhereCompositor<G, T>;
  end;

  INullableWhere<EntityType : IStormEntity ; T : IStormQueryPartition<EntityType>> = interface['{6E0036F2-4A2D-43B2-8CB2-88945DDA3E5C}']
    Function IsNull() : IStormWhereCompositor<EntityType,T>;
    Function IsNotNull() : IStormWhereCompositor<EntityType, T>;
  end;

  IEqualWhere<EntityType : IStormEntity ; T : IStormQueryPartition<EntityType>> = interface['{6E0036F2-4A2D-43B2-8CB2-88945DDA3E5C}']
    Function IsEqualsTo(value : variant) : IStormWhereCompositor<EntityType,T>;
    Function NotIsEqualsTo(value : variant) : IStormWhereCompositor<EntityType,T>;
  end;


  IStringWhere<EntityType : IStormEntity ; T : IStormQueryPartition<EntityType>>
  = interface['{B936FBBD-B8AF-426A-90C2-BC940414A1FC}']
    Function IsEqualsTo(value : string) : IStormWhereCompositor<EntityType,T>;
    Function NotIsEqualsTo(value : string) : IStormWhereCompositor<EntityType,T>;
    Function IsIn(value : TArray<String>) : IStormWhereCompositor<EntityType,T>;
    Function IsNotIn(value :TArray<String>) : IStormWhereCompositor<EntityType,T>;
    Function BeginsWith(value : string) : IStormWhereCompositor<EntityType,T>;
    Function Contains(value : string) : IStormWhereCompositor<EntityType,T>;
    Function EndsWith(value : string) : IStormWhereCompositor<EntityType,T>;
  end;

  INullableStringWhere<EntityType : IStormEntity ;T : IStormQueryPartition<EntityType>> =
  interface(IStringWhere<EntityType, T>)['{B936FBBD-B8AF-426A-90C2-BC940414A1FC}']
    Function IsNull() : IStormWhereCompositor<EntityType, T>;
    Function IsNotNull() : IStormWhereCompositor<EntityType, T>;
  end;

  IStormFieldSelection<EntityType : IStormEntity ;T : IStormQueryPartition<EntityType>> = interface['{9AA32BD0-45FD-42D6-B88A-42570723FD21}']
    Function All() : IWhereNode<EntityType, T>;
  end;

  IStormWhereSelection<EntityType : IStormEntity ;T : IStormQueryPartition<EntityType>> = interface['{CF2E0AFD-4BEF-49B3-AF62-78E5FA6BDFCB}']
    Function OpenParentheses() : T;
  end;

  IStormQueryParameters = interface['{45188996-E885-495D-8CCB-B8894EDF2241}']
    function Add(value : variant) : string;
    function Items : TList<IQueryParameter>;
  end;

implementation

end.
