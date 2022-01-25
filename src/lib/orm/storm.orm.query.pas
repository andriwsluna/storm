unit storm.orm.query;

interface

USES
  System.Sysutils,
  storm.orm.interfaces,
  storm.data.interfaces,
  System.Generics.Collections;

Type
  IStormQueryParameters = interface['{45188996-E885-495D-8CCB-B8894EDF2241}']
    function Add(value : variant) : string;
    function Items : TList<IQueryParameter>;
  end;


  TQueryParameter = class(TInterfacedObject, IQueryParameter)
  private
    FIndex : integer;
    FPlaceHolderName : String;
    FValue : variant;
  public
    Constructor Create(index : integer ; value : variant); Reintroduce;
  public
    property Index: integer read FIndex;
    property PlaceHolderName: string read FPlaceHolderName;
    property Value: variant read FValue;

    function getParamName() : string;
    function getPlaceHolderName() : string;
    Function getValue() : variant;
  end;


  TStormQueryParameters = class(TInterfacedObject, IStormQueryParameters)
  private
    FItems : TList<IQueryParameter>;
  public
    Constructor Create; Reintroduce;
    Destructor  Destroy(); Override;

  public
    function Add(value : variant) : string;
    function Items : TList<IQueryParameter>;
  end;

implementation

{ TQueryParameter }

constructor TQueryParameter.Create(index: integer ;value : variant);
begin
  inherited create();
  FIndex := index;
  FValue := value;
  FPlaceHolderName := ':p' + intToStr(index);
end;

function TQueryParameter.getParamName: string;
begin
  Result := PlaceHolderName.Substring(1);
end;

function TQueryParameter.getPlaceHolderName: string;
begin
  Result := PlaceHolderName;
end;

function TQueryParameter.getValue: variant;
begin
  Result := Value;
end;

{ TStormQueryParameters }

function TStormQueryParameters.Add(value: variant) : string;
var
  parameter : IQueryParameter;
begin
  parameter := TQueryParameter.Create(FItems.Count+1, value);
  FItems.Add(parameter);
  result := parameter.getPlaceHolderName;
end;

constructor TStormQueryParameters.Create;
begin
  inherited create();
  FItems := TList<IQueryParameter>.Create;
end;

destructor TStormQueryParameters.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TStormQueryParameters.Items: TList<IQueryParameter>;
begin
  result :=  FItems;
end;

end.
