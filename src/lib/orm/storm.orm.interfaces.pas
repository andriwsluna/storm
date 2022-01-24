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
  IStormStringFieldAssignment<ReturnType> = interface['{4423B331-DFF9-493A-8A19-29DFC74BCECF}']
    Function SetTo(Const Value : string) : ReturnType;
  end;




  IStormQueryParameters = interface['{45188996-E885-495D-8CCB-B8894EDF2241}']
    function Add(value : variant) : string;
    function Items : TList<IQueryParameter>;
  end;


implementation

end.
