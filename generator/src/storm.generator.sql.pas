unit storm.generator.sql;

interface

USes
  Data.DB,
  System.Generics.Collections,
  DFE.Maybe,
  DFE.Iterator,
  storm.generator.utils,
  storm.generator.consts,
  DFe.Result,

  System.Classes;

Type
  IDBColumn =  interface;

  IDBTable = interface['{FD1C6BCC-F346-4138-9B55-9310274762F8}']
    Procedure AddColumn(Col : IDBColumn);
    Function GetMaxLengthOfcolumns() : Integer;
    Function Getcolumns : TList<IDBColumn>;
    Function EntityName() : String;
    Function EntityType() : String;
    Function EntityInterface() : String;
    Function GetSQL() : String;


    procedure IncIdentyLevel(value : integer = 1);
    procedure DecIdentyLevel(value : integer = 1);
  end;

  IDBColumn =  interface['{6E5D6CAF-369D-41D3-B4BB-7315A6DDD156}']
    Function FieldName: String;
    Function Schema: String;
    Function TableName: String;
    Function Name: String;
    Function ID: integer;
    Function TypeID: integer;
    Function IsPrimaryKey: Boolean;
    Function IsIdentity: Boolean;
    Function IsNulable: Boolean;

    procedure GenerateEntityFieldDeclaration();
    procedure GenrateEntityProtectedFieldDeclaration();
    procedure GenerateEntityFieldImplementation();
    Function GetFieldType() : String;
  end;

Function NewDbColumn(Dataset : TDataset) : IDBColumn;
Function NewDbTable() : IDBTable;

implementation



Type

  TSQLGenerator = class(TInterfacedObject)
  strict private
    SQL : TStringList;
  private

  protected
    function GetIdentyLevel: Integer;Virtual; Abstract;
    procedure SetIdentyLevel(const Value: Integer); Virtual; Abstract;
    procedure IncIdentyLevel(value : integer = 1);
    procedure DecIdentyLevel(value : integer = 1);

    property IdentyLevel: Integer read GetIdentyLevel write SetIdentyLevel;
    Procedure AddSQL(Const Text : String);
    Function GetSQL() : String;
  public
    Constructor Create(); Reintroduce; Virtual;
    Destructor  Destroy();Override;
  end;

  TDBTable = class(TSQLGenerator,IDBTable)
  private

  protected
    FColumns : TList<IDBColumn>;
    FMaxLengthOfcolumns : Integer;
    FIdentyLevel : Integer;

    function GetIdentyLevel: Integer;Override;
    procedure SetIdentyLevel(const Value: Integer); Override;
  public




    Constructor Create(); Reintroduce;

    Procedure AddColumn(Col : IDBColumn);
    Function GetMaxLengthOfcolumns() : Integer;
    Function Getcolumns : TList<IDBColumn>;
    Function EntityName() : String;
    Function EntityType() : String;
    Function EntityInterface() : String;

  end;



  TDBColumn = Class(TInterfacedObject,IDBColumn)
  private
    function GetIdentyLevel: Integer;
    procedure SetIdentyLevel(const Value: Integer);

  protected
    FDBTable          : IDBTable;
    FFieldName        : String;
    FSchema           : String;
    FTableName        : String;
    FName             : String;
    FID               : Integer;
    FTypeID           : Integer;
    FIsPrimaryKey     : Boolean;
    FIsIdentity       : Boolean;
    FIsNulable        : Boolean;


    Procedure AddSql(const text : String);


  public
    Function FieldName: String;
    Function Schema: String;
    Function TableName: String;
    Function Name: String;
    Function ID: integer;
    Function TypeID: integer;
    Function IsPrimaryKey: Boolean;
    Function IsIdentity: Boolean;
    Function IsNulable: Boolean;

    Constructor FromDataset(Dataset : TDataset); Virtual;

    Function GetFieldType() : String; Virtual; Abstract;
    Procedure GenerateEntityFieldDeclaration(); Virtual;
    Procedure GenrateEntityProtectedFieldDeclaration(); Virtual;
    Procedure GenerateEntityFieldImplementation();
  end;

  TVarcharColumn = Class(TDBColumn)
  protected
    FMaxLength : Integer;
  public


    Constructor FromDataset(Dataset : TDataset); Override;
    Function GetFieldType() : String; Override;
  end;

  TIntegerColumn = Class(TDBColumn)
  public
    Function GetFieldType() : String; Override;
  end;

  TNumericColumn = Class(TDBColumn)
  protected
    FScale : Integer;
    FPrecision : Integer;
  public
    Constructor FromDataset(Dataset : TDataset); Override;
    Function GetFieldType() : String; Override;
  end;

  TBooleanColumn = Class(TDBColumn)
  public
    Function GetFieldType() : String; Override;
  end;

  TDateColumn = Class(TDBColumn)
  public
    Function GetFieldType() : String; Override;
  end;

  TDateTimeColumn = Class(TDBColumn)
  public
    Function GetFieldType() : String; Override;
  end;






{ TDBColumn }

procedure TDBColumn.AddSql(const text: String);
begin
  TDBTable(Self.FDBTable).AddSQL(Text);
end;

function TDBColumn.FieldName: String;
begin
  Result := Self.FFieldName;
end;



procedure TDBColumn.GenerateEntityFieldDeclaration;
begin
  AddSql(
  'F' +
  CompleteWithBlanks(FieldName,fdbtable.GetMaxLengthOfcolumns) +
  ' : ' + GetFieldType() + ';');

end;

Procedure TDBColumn.GenerateEntityFieldImplementation;
begin

  AddSql(KEYWORD_FUNCTION + ' ' + FDBTable.EntityType +'.' + Self.FieldName + '(): '+Self.GetFieldType +';');
  AddSql(KEYWORD_BEGIN);
  FDBTable.IncIdentyLevel();
  AddSql(KEYWORD_RESULT+' := '+KEYWORD_SELF+'.F'+ Self.FieldName +';');
  FDBTable.DecIdentyLevel();
  AddSql(KEYWORD_END + ';');


end;

Procedure TDBColumn.GenrateEntityProtectedFieldDeclaration;
begin
  AddSQL(
  KEYWORD_FUNCTION + ' ' +
  CompleteWithBlanks(FieldName,fdbtable.GetMaxLengthOfcolumns) +
  ' : ' + GetFieldType() + ';'
  );
end;

function TDBColumn.GetIdentyLevel: Integer;
begin
  Result := TDBTable(Self.FDBTable).GetIdentyLevel;
end;

function TDBColumn.ID: integer;
begin
  Result := Self.FID;
end;

function TDBColumn.IsIdentity: Boolean;
begin
  Result := Self.FIsIdentity;
end;

function TDBColumn.IsNulable: Boolean;
begin
  Result := Self.FIsNulable;
end;

function TDBColumn.IsPrimaryKey: Boolean;
begin
  Result := Self.FIsPrimaryKey;
end;

Constructor TDBColumn.FromDataset(Dataset: TDataset);
begin
  inherited create;
  if Assigned(Dataset) then
  begin
    Self.FSchema := Dataset.FieldByName('schema_name').AsString;
    Self.FTableName := Dataset.FieldByName('table_name').AsString;
    Self.FID     := Dataset.FieldByName('column_id').AsInteger;
    Self.FName := Dataset.FieldByName('column_name').AsString;
    Self.FTypeID := Dataset.FieldByName('type_id').AsInteger;
    Self.FIsPrimaryKey := Dataset.FieldByName('is_primarykey').AsBoolean;
    Self.FIsIdentity := Dataset.FieldByName('is_identity').AsBoolean;
    Self.FIsNulable := Dataset.FieldByName('is_nullable').AsBoolean;
    Self.FFieldName := storm.generator.utils.Capitalize(Self.Name);
  end;
end;

function TDBColumn.Name: String;
begin
  Result := Self.FName;
end;

function TDBColumn.Schema: String;
begin
  Result := Self.FSchema;
end;

procedure TDBColumn.SetIdentyLevel(const Value: Integer);
begin
 TDBColumn(Self.FDBTable).SetIdentyLevel(Value);
end;

function TDBColumn.TableName: String;
begin
  Result := Self.FTableName;
end;

function TDBColumn.TypeID: integer;
begin
  Result := Self.FTypeID;
end;

{ TVarcharColumn }

Constructor TVarcharColumn.FromDataset(Dataset: TDataset);
begin
  inherited;
  Self.FMaxLength := Dataset.FieldByName('max_length').AsInteger;
end;

function TVarcharColumn.GetFieldType: String;
begin
  Result := 'IStringField';
end;

{ TNumericColumn }

Constructor TNumericColumn.FromDataset(Dataset: TDataset);
begin
  inherited;

  Self.FScale := Dataset.FieldByName('scale').AsInteger;
  Self.FPrecision := Dataset.FieldByName('precision').AsInteger;

end;

Function NewDbColumn(Dataset : TDataset) : IDBColumn;
VAR
  typID : integer;
begin
  typID := Dataset.FieldByName('type_id').AsInteger;

  CASE typID of
    56  : Result := TIntegerColumn.FromDataset(Dataset);
    167 : Result := TVarCharColumn.FromDataset(Dataset);
    108 : Result := TNumericColumn.FromDataset(Dataset);
    104 : Result := TBooleanColumn.FromDataset(Dataset);
    40  : Result := TDateColumn.FromDataset(Dataset);
    61  : Result := TDAteTimeColumn.FromDataset(Dataset);
    Else  Result := TVarCharColumn.FromDataset(Dataset);
  END;
end;

function TNumericColumn.GetFieldType: String;
begin
  Result := 'IFloatField';
end;

{ TIntegerColumn }

function TIntegerColumn.GetFieldType: String;
begin
  Result := 'IIntegerField';
end;

{ TBooleanColumn }

function TBooleanColumn.GetFieldType: String;
begin
  Result := 'IBooleanField';
end;

{ TDateColumn }

function TDateColumn.GetFieldType: String;
begin
  Result := 'IDateField';
end;

{ TDateTimeColumn }

function TDateTimeColumn.GetFieldType: String;
begin
  Result := 'IDateTimeField';
end;

{ TDBTable }

procedure TDBTable.AddColumn(Col : IDBColumn);
begin
  FColumns.Add(Col);
  TDBColumn(Col).FDBTable := Self;

  if Length(col.Name) >  self.FMaxLengthOfcolumns then
  begin
    self.FMaxLengthOfcolumns := Length(col.Name);
  end;
end;

constructor TDBTable.Create;
begin
  inherited;
  FColumns := Tlist<IDBColumn>.create;
  FMaxLengthOfcolumns := 0;
end;

function TDBTable.EntityInterface: String;
begin
  Result := 'I' + self.EntityName;
end;

function TDBTable.EntityName: String;
begin
  Result := 'Produto';
end;

function TDBTable.EntityType: String;
begin
   Result := 'T' + self.EntityName;
end;

function TDBTable.Getcolumns: TList<IDBColumn>;
begin
  Result := Self.FColumns;
end;

function TDBTable.GetIdentyLevel: Integer;
begin
  Result := self.FIdentyLevel;
end;

function TDBTable.GetMaxLengthOfcolumns: Integer;
begin
  Result := FMaxLengthOfcolumns;
end;

procedure TDBTable.SetIdentyLevel(const Value: Integer);
begin
   Self.FIdentyLevel := Value;
end;

Function NewDbTable() : IDBTable;
begin
  Result := TDBTable.Create;
end;

{ TSQLGenerator }

procedure TSQLGenerator.AddSQL(const Text: String);
begin
  Self.SQL.Add( StringOfChar(' ',2 * IdentyLevel) + Text);
end;

constructor TSQLGenerator.Create;
begin
  Self.SQL := TStringList.Create();
  inherited;

end;

procedure TSQLGenerator.DecIdentyLevel(value: integer);
VAR
  i : integer;
begin
  i := IdentyLevel;
  DEC(i,value);
  IdentyLevel := i;
end;

destructor TSQLGenerator.Destroy;
begin
  sql.Free;
  inherited;
end;



function TSQLGenerator.GetSQL: String;
begin
  Result := SQL.Text;
  SQL.Clear();
end;



procedure TSQLGenerator.IncIdentyLevel(value: integer);
VAR
  i : integer;
begin
  i := IdentyLevel;
  INC(i,value);
  IdentyLevel := i;
end;

end.
