unit DFE.Iterator;

interface

uses
  System.Generics.Collections,
  storm.additional.maybe,
  DFE.Interfaces;

Type
  TIterator<ItemType :  IInterface ; SelfType : IIterator<ItemType>> =
  class(TinterfacedObject, IIterator<ItemType>)

  private

  protected
    FIndex : integer;
    FItems : Tlist<ItemType>;


    Procedure Initialize(); Virtual;
    Procedure Finalize(); Virtual;
    Function  NewIteratorConstructor : SelfType; Virtual;

  public
    Constructor Create(); Reintroduce; Virtual;
    Destructor  Destroy(); Override;
  public
    Function  IsEmpty : Boolean; Virtual;
    Function  IsNotEmpty : Boolean; Virtual;

    Function  Count() : integer; Virtual;
    Function  Current : Maybe<ItemType>; Virtual;

    function  Next(): Maybe<ItemType>; Virtual;
    function  Previous(): Maybe<ItemType>; Virtual;
    function  First(): Maybe<ItemType>; Virtual;
    function  Last(): Maybe<ItemType>; Virtual;
    procedure Reset(); Virtual;
    function  ForEach(proc : TForEachFunction<ItemType>) : IIterator<ItemType>;
    function  LocalForEach(proc : TForEachFunction<ItemType>) : SelfType;
    function  Map(func : TMapFunction<ItemType>) : IIterator<ItemType>;
    function  LocalMap(func : TMapFunction<ItemType>) : SelfType;
  end;

implementation

function TIterator<ItemType, SelfType>.Count: integer;
begin
   Result := FItems.Count;
end;

constructor TIterator<ItemType, SelfType>.Create;
begin
  inherited;
  Initialize();
end;



function TIterator<ItemType, SelfType>.Current: Maybe<ItemType>;
begin
  Result := nil;
  if IsNotEmpty then
  begin
    if (FIndex >= 0) and (FIndex < Fitems.Count) then
    begin
      Result := FItems.Items[FIndex];
    end
    else
    begin
      Result := nil;;
    end;
  end;
end;

destructor TIterator<ItemType, SelfType>.Destroy;
begin
  Finalize();
  inherited;
end;

procedure TIterator<ItemType, SelfType>.Finalize;
begin
  FItems.Free;
end;

function TIterator<ItemType, SelfType>.First: Maybe<ItemType>;
begin
  if IsNotEmpty then
  begin
    Reset;
    Result := Current;
  end;
end;

function TIterator<ItemType, SelfType>.ForEach(
  proc: TForEachFunction<ItemType>): IIterator<ItemType>;
var
  stop : boolean;
begin
  if IsNotEmpty then
  begin
    Reset;
    stop := false;
    repeat
      stop := next.bind
      (
        function(item : ItemType) : boolean
        begin
          proc(item);
          result := false;
        end,
        function() : boolean
        begin
          result := true;
        end
      );

    until stop;

  end;
  Result := Self;
end;

procedure TIterator<ItemType, SelfType>.Initialize;
begin
  FIndex := -1;
  FItems := Tlist<ItemType>.Create;
end;

function TIterator<ItemType, SelfType>.IsEmpty: Boolean;
begin
  Result := Count <= 0;
end;

function TIterator<ItemType, SelfType>.IsNotEmpty: Boolean;
begin
  Result:= not IsEmpty;
end;

function TIterator<ItemType, SelfType>.Last: Maybe<ItemType>;
begin
  if IsNotEmpty then
  begin
    FIndex := Count-1;
    Result := Current;
  end;
end;

function TIterator<ItemType, SelfType>.LocalForEach(
  proc: TForEachFunction<ItemType>): SelfType;
var
  stop : boolean;
  NewIterator : SelfType;
begin
  NewIterator := self.NewIteratorConstructor;
  if IsNotEmpty then
  begin
    Reset;
    stop := false;
    repeat
      stop := next.bind
      (
        function(item : ItemType) : boolean
        begin
          proc(item);
          TIterator<ItemType, SelfType>(NewIterator).FItems.Add(item);
          result := false;
        end,
        function() : boolean
        begin
          result := true;
        end
      );

    until stop;

  end;
  Result := NewIterator;
end;

function TIterator<ItemType, SelfType>.LocalMap(
  func: TMapFunction<ItemType>): SelfType;
var
  stop : boolean;
  NewIterator : SelfType;
begin
  NewIterator := self.NewIteratorConstructor;
  if IsNotEmpty then
  begin
    Reset;
    stop := false;
    repeat
      stop := next.bind
      (
        function(item : ItemType) : boolean
        begin
          func(item).OnSome
          (
            procedure(newItem : ItemType)
            begin
              TIterator<ItemType, SelfType>(NewIterator).FItems.Add(newItem)
            end
          );
          result := false;
        end,
        function() : boolean
        begin
          result := true;
        end
      );

    until stop;

  end;
  Result := NewIterator;
end;

function TIterator<ItemType, SelfType>.Map(
  func: TMapFunction<ItemType>): IIterator<ItemType>;
var
  stop : boolean;
  NewIterator : TIterator<ItemType, SelfType>;
begin
  NewIterator := TIterator<ItemType, SelfType>.Create;
  if IsNotEmpty then
  begin
    Reset;
    stop := false;
    repeat
      stop := next.bind
      (
        function(item : ItemType) : boolean
        begin
          func(item).OnSome
          (
            procedure(newItem : ItemType)
            begin
              NewIterator.FItems.Add(newItem)
            end
          );
          result := false;
        end,
        function() : boolean
        begin
          result := true;
        end
      );

    until stop;

  end;
  Result := NewIterator;
end;

function TIterator<ItemType, SelfType>.NewIteratorConstructor: SelfType;
begin
  result := nil;
end;

function TIterator<ItemType, SelfType>.Next: Maybe<ItemType>;
begin
  if IsNotEmpty then
  begin
    INC(FIndex);
    result := Current;
  end;
end;

function TIterator<ItemType, SelfType>.Previous: Maybe<ItemType>;
begin
  if IsNotEmpty then
  begin
    DEC(FIndex);
    Result := Current;
    if Not result.Any then
    begin
      INC(FIndex);
    end;
  end;
end;

procedure TIterator<ItemType, SelfType>.Reset;
begin
  FIndex := -1;
end;

end.
