unit storm.orm.query;

interface

USES
  System.Sysutils,
  System.Generics.Collections;

Type
  TQueryParameter = class
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
  end;


  TStormQueryParameters = class
  private
    FItems : TList<TQueryParameter>;
  public
    Constructor Create; Reintroduce;
  public
    property Items: TList<TQueryParameter> read FItems;
    function Add(value : variant) : string;
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

{ TStormQueryParameters }

function TStormQueryParameters.Add(value: variant) : string;
var
  parameter : TQueryParameter;
begin
  parameter := TQueryParameter.Create(FItems.Count+1, value);
  FItems.Add(parameter);
  result := parameter.PlaceHolderName;
end;

constructor TStormQueryParameters.Create;
begin
  inherited create();
  FItems := TList<TQueryParameter>.Create;
end;

end.
