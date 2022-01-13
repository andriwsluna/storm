unit storm.orm.interfaces;

interface

uses
  System.Generics.Collections,
  storm.additional.maybe,

  System.Sysutils, System.Classes;

Type
   IQueryParameter = interface['{710D25D7-939B-42BD-A446-1445A2832FC8}']
    function getParamName() : string;
    function getPlaceHolderName() : string;
    Function getValue() : variant;
  end;

  IStormQueryPartition = interface['{1453EBB4-0723-418F-BA9F-16528086EFBD}']
    Function GetSQL() : String;
    Function GetParameters : TList<IQueryParameter>;
  end;

  IWhereNode<T : IStormQueryPartition> = interface['{A8E49DE9-6183-4464-881C-DF090693E627}']
      Function Where : T;
  end;

  IStormWhereCompositor<T : IStormQueryPartition > = interface['{0FA8F62A-7548-48AB-B341-1015C4459A51}']
    Function And_() : T;
    Function Or_()  : T;
    Function GetSQL() : String;
    Function GetParameters : TList<IQueryParameter>;
    Function OpenParentheses() : IStormWhereCompositor<T>;
    Function CloseParentheses() : IStormWhereCompositor<T>;
  end;

  INullableWhere<T : IStormQueryPartition> = interface['{6E0036F2-4A2D-43B2-8CB2-88945DDA3E5C}']
    Function IsNull() : IStormWhereCompositor<T>;
    Function IsNotNull() : IStormWhereCompositor<T>;
  end;

  IEqualWhere<T : IStormQueryPartition> = interface['{6E0036F2-4A2D-43B2-8CB2-88945DDA3E5C}']
    Function IsEqualsTo(value : variant) : IStormWhereCompositor<T>;
    Function NotIsEqualsTo(value : variant) : IStormWhereCompositor<T>;
  end;


  IStringWhere<T : IStormQueryPartition> = interface['{B936FBBD-B8AF-426A-90C2-BC940414A1FC}']
    Function IsEqualsTo(value : string) : IStormWhereCompositor<T>;
    Function NotIsEqualsTo(value : string) : IStormWhereCompositor<T>;
    Function IsIn(value : TArray<String>) : IStormWhereCompositor<T>;
    Function IsNotIn(value :TArray<String>) : IStormWhereCompositor<T>;
    Function BeginsWith(value : string) : IStormWhereCompositor<T>;
    Function Contains(value : string) : IStormWhereCompositor<T>;
    Function EndsWith(value : string) : IStormWhereCompositor<T>;
  end;

  INullableStringWhere<T : IStormQueryPartition> = interface['{B936FBBD-B8AF-426A-90C2-BC940414A1FC}']
    Function IsNull() : IStormWhereCompositor<T>;
    Function IsNotNull() : IStormWhereCompositor<T>;
    Function IsEqualsTo(value : string) : IStormWhereCompositor<T>;
    Function NotIsEqualsTo(value : string) : IStormWhereCompositor<T>;
    Function IsIn(value : TArray<String>) : IStormWhereCompositor<T>;
    Function IsNotIn(value :TArray<String>) : IStormWhereCompositor<T>;
    Function BeginsWith(value : string) : IStormWhereCompositor<T>;
    Function Contains(value : string) : IStormWhereCompositor<T>;
    Function EndsWith(value : string) : IStormWhereCompositor<T>;
  end;

  IStormFieldSelection<T : IStormQueryPartition> = interface['{9AA32BD0-45FD-42D6-B88A-42570723FD21}']
    Function All() : IWhereNode<T>;
  end;

  IStormWhereSelection<T : IStormQueryPartition> = interface['{CF2E0AFD-4BEF-49B3-AF62-78E5FA6BDFCB}']
    Function OpenParentheses() : T;
    Function CloseParentheses() : T;
  end;

  IStormQueryParameters = interface['{45188996-E885-495D-8CCB-B8894EDF2241}']
    function Add(value : variant) : string;
  end;

implementation

end.
