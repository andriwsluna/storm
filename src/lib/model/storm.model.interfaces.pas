unit storm.model.interfaces;

interface
USES
  storm.entity.interfaces,
  System.Generics.Collections;


Type

  IStormModel<EntityType : IStormEntity> = interface['{286874F3-641F-45BA-B1EE-62EA0A028F64}']
    Function Records() : TList<EntityType>;
  end;

implementation

end.
