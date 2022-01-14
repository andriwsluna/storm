unit storm.data.interfaces;

interface

USES
  Data.DB,
  System.Generics.Collections;



type
  IQueryParameter = interface['{710D25D7-939B-42BD-A446-1445A2832FC8}']
    function getParamName() : string;
    function getPlaceHolderName() : string;
    Function getValue() : variant;
  end;

  IStormSQLQuery = interface['{4464B702-43D2-4D74-B032-1CF1A09DB471}']
    Procedure SetSQL(sql : string);
    Procedure LoadParameters(parameters : TList<IQueryParameter>);
    Function  Execute() : Boolean;
    Function  Open() : Boolean;
    Function  Dataset : Tdataset;
  end;


implementation

end.
