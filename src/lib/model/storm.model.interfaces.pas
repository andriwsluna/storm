unit storm.model.interfaces;

interface
USES
  storm.entity.interfaces,
  DFE.Maybe,
  DFE.Interfaces,
  system.json,
  System.Generics.Collections;


Type
  IStormModel<EntityType : IStormEntity> =
  interface(IIterator<EntityType>)
  ['{286874F3-641F-45BA-B1EE-62EA0A028F64}']
    Function  IsEmpty : Boolean;
    Function  IsNotEmpty : Boolean;
    Procedure AddRecord(entity : EntityType);
    Function Records() : TList<EntityType>;
    Function ToJSON(ConvertNulls : Boolean = false) : Maybe<TJSONArray>;
    function  ForEach(proc : TForEachFunction<EntityType>) : IStormModel<EntityType>;
    function  Map(func : TMapFunction<EntityType>) : IStormModel<EntityType>;
    function  Filter(func : TFilterFunction<EntityType>) : IStormModel<EntityType>;
  end;


implementation

end.
