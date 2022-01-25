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
  IStormSQLPartition = interface['{33498F09-501C-47E4-91D6-809FE2E87005}']
  end;

  IStormStringWhere<ReturnType, SubReturnType: IInterface> = interface['{B357CB7F-BFC1-4173-B973-6A4D03DF865F}']
    Function IsEqualsTo(Const Value : string) : ReturnType;
    Function IsNotEqualsTo(Const Value : string) : ReturnType;
  end;

  IStormStringNullableWhere<ReturnType, SubReturnType: IInterface>
  = interface(IStormStringWhere<ReturnType,SubReturnType>)['{7968FF81-EA7E-4AAF-9A32-FC8F53919071}']
    Function IsNull : ReturnType;
    Function IsNotNull : ReturnType;
  end;


  IStormStringFieldAssignment<ReturnType> = interface['{4423B331-DFF9-493A-8A19-29DFC74BCECF}']
    Function SetTo(Const Value : string) : ReturnType;
  end;




  IStormQueryParameters = interface['{45188996-E885-495D-8CCB-B8894EDF2241}']
    function Add(value : variant) : string;
    function Items : TList<IQueryParameter>;
  end;


implementation

end.
