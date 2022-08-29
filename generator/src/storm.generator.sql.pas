unit storm.generator.sql;

interface

USes
  Data.DB,
  System.Generics.Collections,
  DFE.Maybe,
  DFE.Iterator,
  System.Sysutils,
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

    Function GetEntityFile() : String;
    Function GetSchemaFile() : String;
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
    procedure GenerateEntityProtectedFieldDeclaration();
    procedure GenerateEntityFieldImplementation();
    procedure GenerateEntityFieldCreation();
    Procedure GenerateEntityAddStormField();

    Procedure GenerateSchemaFieldDeclaration();
    procedure GenerateSchemaPropertyDeclaration();
    procedure GenerateSchemaFieldCreation();
    procedure GenerateSchemaAddField();

    Function GetFieldType() : String;
  end;

Function NewDbColumn(Dataset : TDataset) : IDBColumn;
Function NewDbTable(Dataset : TDataset) : IDBTable;

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
    Procedure BreakLine();
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
    FSchema : String;
    FTableName : string;
    FName : String;


    function GetIdentyLevel: Integer;Override;
    procedure SetIdentyLevel(const Value: Integer); Override;

    Procedure GenerateEntityUnit();
    Procedure GenerateEntityUnit_Interface();
    Procedure GenerateEntityUnit_TypeDeclaration();
    Procedure GenerateEntityUnit_Implementation();
    Procedure GenerateEntityUnit_TypeImplementation();
    Procedure GenerateEntityUnit_OtherMethodsImplementation();


    Procedure GenerateSchemaUnit();
    Procedure GenerateSchemaUnit_Interface();
    Procedure GenerateSchemaUnit_Implementation();
  public




    Constructor Create(); Reintroduce;
    cONSTRUCTOR FromDataset(Dataset : TDataset);

    Function Schema: String;
    Function TableName: String;
    Procedure AddColumn(Col : IDBColumn);
    Function GetMaxLengthOfcolumns() : Integer;
    Function Getcolumns : TList<IDBColumn>;
    Function EntityName() : String;
    Function EntityType() : String;
    Function EntityInterface() : String;
    Function EntitySchemaUnitName() : String;
    Function EntitySchemaTypeName() : String;



    Function GetEntityFile() : String;
    Function GetSchemaFile() : String;

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
    Function GetFieldConcreteType() : String; Virtual; Abstract;
    Function GetSchemaType() : String; Virtual; Abstract;
    Function GetSchemaFieldCreation() : String; Virtual;
    Function GetSchemaAttributes(): String; Virtual;

    Procedure GenerateEntityFieldDeclaration(); Virtual;
    Procedure GenerateEntityProtectedFieldDeclaration(); Virtual;
    Procedure GenerateEntityFieldImplementation();
    Procedure GenerateEntityFieldCreation();
    Procedure GenerateEntityAddStormField();

    Procedure GenerateSchemaFieldDeclaration();
    Procedure GenerateSchemaPropertyDeclaration();
    Procedure GenerateSchemaFieldCreation();
    Procedure GenerateSchemaAddField();
  end;

  TVarcharColumn = Class(TDBColumn)
  protected
    FMaxLength : Integer;
  public


    Constructor FromDataset(Dataset : TDataset); Override;
    Function GetFieldType() : String; Override;
    Function GetFieldConcreteType() : String; Override;
    Function GetSchemaType() : String; Override;
    Function GetSchemaFieldCreation() : String; Override;
  end;

  TIntegerColumn = Class(TDBColumn)
  public
    Function GetFieldType() : String; Override;
    Function GetFieldConcreteType() : String; Override;
    Function GetSchemaType() : String; Override;
  end;

  TNumericColumn = Class(TDBColumn)
  protected
    FScale : Integer;
    FPrecision : Integer;
  public
    Constructor FromDataset(Dataset : TDataset); Override;
    Function GetFieldType() : String; Override;
    Function GetFieldConcreteType() : String; Override;
    Function GetSchemaType() : String; Override;
    Function GetSchemaFieldCreation() : String; Override;
  end;

  TBooleanColumn = Class(TDBColumn)
  public
    Function GetFieldType() : String; Override;
    Function GetFieldConcreteType() : String; Override;
    Function GetSchemaType() : String; Override;
  end;

  TDateColumn = Class(TDBColumn)
  public
    Function GetFieldType() : String; Override;
    Function GetFieldConcreteType() : String; Override;
    Function GetSchemaType() : String; Override;
  end;

  TDateTimeColumn = Class(TDBColumn)
  public
    Function GetFieldType() : String; Override;
    Function GetFieldConcreteType() : String; Override;
    Function GetSchemaType() : String; Override;
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



procedure TDBColumn.GenerateEntityProtectedFieldDeclaration;
begin
  AddSql(
  'F' +
  CompleteWithBlanks(FieldName,fdbtable.GetMaxLengthOfcolumns) +
  ' : ' + GetFieldType() + ';');

end;

procedure TDBColumn.GenerateSchemaAddField;
begin
  AddSql('AddColumn('+FieldName+');');
end;

procedure TDBColumn.GenerateSchemaFieldCreation;
begin
  AddSql('F'+FieldName+' := TStormColumnSchema.Create');
  AddSql('(');
  self.FDBTable.IncIdentyLevel();
  AddSql(QuotedStr(Name)+',');
  AddSql(QuotedStr(FieldName)+',');
  AddSql(GetSchemaFieldCreation()+',');
  AddSql(GetSchemaAttributes());
  self.FDBTable.DecIdentyLevel();
  AddSql(');');

end;

procedure TDBColumn.GenerateSchemaFieldDeclaration;
begin
  AddSql(
  'F' +
  CompleteWithBlanks(FieldName,fdbtable.GetMaxLengthOfcolumns) +
  ' : IStormSchemaColumn;');
end;

procedure TDBColumn.GenerateSchemaPropertyDeclaration;
begin
  AddSql(KEYWORD_PROPERTY+ ' ' +
  CompleteWithBlanks(FieldName,fdbtable.GetMaxLengthOfcolumns) +
  ' : IStormSchemaColumn read F'+FieldName+';');
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

procedure TDBColumn.GenerateEntityAddStormField;
begin
  AddSql('AddStormField(F'+Self.FFieldName+' as IStormField);');
end;

procedure TDBColumn.GenerateEntityFieldCreation;
begin
  AddSql(
  'F' +
  CompleteWithBlanks(FieldName,fdbtable.GetMaxLengthOfcolumns) +
  ' := ' + GetFieldConcreteType() + '.Create('+QuotedStr(Self.FName)+');');
end;

Procedure TDBColumn.GenerateEntityFieldDeclaration;
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

function TDBColumn.GetSchemaAttributes: String;
VAR
  att : String;
begin
  att := '[';
  if self.IsPrimaryKey then
  begin
    att:= att +',' + 'PrimaryKey';
  end;
  if self.IsIdentity then
  begin
    att:= att +',' + 'AutoIncrement';
  end;
  if Not self.IsNulable then
  begin
    att:= att +',' + 'NotNull';
  end;

  att := att.Replace(',','',[]);
  att := att + ']';
  Result := att;
end;

function TDBColumn.GetSchemaFieldCreation: String;
begin
  Result := GetSchemaType + '.Create()';
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

function TVarcharColumn.GetFieldConcreteType: String;
begin
  Result := 'TStormStringField';
end;

function TVarcharColumn.GetFieldType: String;
begin
  Result := 'IStringField';
end;

function TVarcharColumn.GetSchemaFieldCreation: String;
begin
  Result := self.GetSchemaType + '.Create(' +self.FMaxLength.ToString +')';
end;

function TVarcharColumn.GetSchemaType: String;
begin
  Result := 'TStormVarchar';
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

function TNumericColumn.GetFieldConcreteType: String;
begin
  Result := 'TStormFloatField';
end;

function TNumericColumn.GetFieldType: String;
begin
  Result := 'IFloatField';
end;

function TNumericColumn.GetSchemaFieldCreation: String;
begin
  Result := GetSchemaType + '.Create('+self.FPrecision.ToString+', '+ self.FScale.ToString+')';
end;

function TNumericColumn.GetSchemaType: String;
begin
  Result := 'TStormNumeric';
end;

{ TIntegerColumn }

function TIntegerColumn.GetFieldConcreteType: String;
begin
  Result := 'TStormIntegerField';
end;

function TIntegerColumn.GetFieldType: String;
begin
  Result := 'IIntegerField';
end;


function TIntegerColumn.GetSchemaType: String;
begin
  Result := 'TStormInt';
end;

{ TBooleanColumn }

function TBooleanColumn.GetFieldConcreteType: String;
begin
  Result := 'TStormBooleanField';
end;

function TBooleanColumn.GetFieldType: String;
begin
  Result := 'IBooleanField';
end;


function TBooleanColumn.GetSchemaType: String;
begin
  Result := 'TStormBoolean';
end;

{ TDateColumn }

function TDateColumn.GetFieldConcreteType: String;
begin
  Result := 'TStormDateField';
end;

function TDateColumn.GetFieldType: String;
begin
  Result := 'IDateField';
end;

function TDateColumn.GetSchemaType: String;
begin
  Result := 'TStormDate';
end;

{ TDateTimeColumn }

function TDateTimeColumn.GetFieldConcreteType: String;
begin
  Result := 'TStormDateTimeField';
end;

function TDateTimeColumn.GetFieldType: String;
begin
  Result := 'IDateTimeField';
end;


function TDateTimeColumn.GetSchemaType: String;
begin
  Result := 'TStormDateTime';
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
  Result := FName;
end;

function TDBTable.EntitySchemaTypeName: String;
begin
  Result := 'TSchema' + EntityName;
end;

function TDBTable.EntitySchemaUnitName: String;
begin
  Result := 'uSchema' + EntityName;
end;

function TDBTable.EntityType: String;
begin
   Result := 'T' + self.EntityName;
end;

constructor TDBTable.FromDataset(Dataset: TDataset);
begin
  Create();
  if Assigned(Dataset) then
  begin
    Self.FSchema := Dataset.FieldByName('schema_name').AsString;
    Self.FTableName := Dataset.FieldByName('table_name').AsString;
    Self.FName :=  Capitalize(FTableName);
  end;
end;

procedure TDBTable.GenerateEntityUnit;
begin
  FIdentyLevel := 0;

  GenerateEntityUnit_Interface();
  GenerateEntityUnit_TypeDeclaration();
  GenerateEntityUnit_Implementation();
  GenerateEntityUnit_TypeImplementation();
  GenerateEntityUnit_OtherMethodsImplementation();
end;

procedure TDBTable.GenerateEntityUnit_Implementation;
begin
  AddSQL(KEYWORD_IMPLEMENTATION);
  BreakLine();
  AddSQL(KEYWORD_USES);
  IncIdentyLevel();
  AddSql(EntitySchemaUnitName + ';');
  DecIdentyLevel();
  BreakLine();
  AddSql(KEYWORD_PROCEDURE +' RegisterEntityConstructor;');
  AddSql(KEYWORD_BEGIN);
  IncIdentyLevel();
  AddSql('DependencyRegister.RegisterEntityDependency');
  AddSql('(');
  IncIdentyLevel();
  AddSql(EntityInterface + ',');
  AddSql('TStormEntityDependency<'+EntityInterface+'>.Create(New'+EntityName+')');
  DecIdentyLevel();
  AddSql(');');
  DecIdentyLevel();
  AddSql(KEYWORD_END+ ';');
  BreakLine();

end;

procedure TDBTable.GenerateEntityUnit_Interface;
begin
  AddSQL(KEYWORD_Unit + ' uEntity'+ self.EntityName +';');
  BreakLine;
  AddSQL(KEYWORD_INTERFACE);
  BreakLine;
  AddSQL(KEYWORD_USES);
  IncIdentyLevel();
  AddSql('DFE.Interfaces,');
  AddSql('storm.fields.interfaces,');
  AddSql('storm.dependency.register,');
  AddSql('storm.entity.interfaces,');
  AddSql('storm.fields.str,');
  AddSql('storm.fields.int,');
  AddSql('storm.fields.float,');
  AddSql('storm.fields.date,');
  AddSql('storm.fields.datetime,');
  AddSql('storm.fields.bool,');
  AddSql('storm.entity.base;');
  BreakLine;
  DecIdentyLevel();
end;

procedure TDBTable.GenerateEntityUnit_OtherMethodsImplementation;
VAR
  col : IDBColumn;
begin
  AddSql(KEYWORD_FUNCTION +' '+EntityType+'.Clone(Target: '+EntityInterface+'): Boolean;');
  AddSql(KEYWORD_BEGIN);
  IncIdentyLevel();
  AddSql(KEYWORD_RESULT+' := TStormEntity(self).Clone(Target);');
  DecIdentyLevel();
  AddSql(KEYWORD_END+';');
  BreakLine;

  AddSql(KEYWORD_CONSTRUCTOR+' '+EntityType+'.Create();');
  AddSql(KEYWORD_BEGIN);
  IncIdentyLevel();
  AddSql('inherited Create('+EntitySchemaUnitName+'.' + EntitySchemaTypeName +'.Create());');
  DecIdentyLevel();
  AddSql(KEYWORD_END+';');
  BreakLine;

  AddSql(KEYWORD_PROCEDURE+' '+EntityType+'.Finalize();');
  AddSql(KEYWORD_BEGIN);
  IncIdentyLevel();
  AddSql('inherited;');
  DecIdentyLevel();
  AddSql(KEYWORD_END+';');
  BreakLine;

  AddSql(KEYWORD_PROCEDURE+' '+EntityType+'.Initialize();');
  AddSql(KEYWORD_BEGIN);
  IncIdentyLevel();
  AddSql('inherited;');
  BreakLine;

  for col in FColumns do
  begin
    col.GenerateEntityFieldCreation();
  end;

  BreakLine;

  for col in FColumns do
  begin
    col.GenerateEntityAddStormField();
  end;

  DecIdentyLevel();
  AddSql(KEYWORD_END+';');
  BreakLine;

  AddSql(KEYWORD_FUNCTION +' New'+EntityName+'() : '+EntityInterface+';');
  AddSql(KEYWORD_BEGIN);
  IncIdentyLevel();
  AddSql('result := '+EntityType+'.Create;');
  DecIdentyLevel();
  AddSql(KEYWORD_END+';');
  BreakLine;

  AddSql(KEYWORD_FUNCTION+' NewEntity() : IStormEntity;');
  AddSql(KEYWORD_BEGIN);
  IncIdentyLevel();
  AddSql(KEYWORD_RESULT+' := New'+EntityName+';');
  DecIdentyLevel();
  AddSql(KEYWORD_END+';');
  BreakLine;

  AddSql(KEYWORD_INITIALIZATION);
  incIdentyLevel();
  AddSql('RegisterEntityConstructor();');
  DecIdentyLevel();
  BreakLine;
  AddSql(KEYWORD_END+'.');


end;

procedure TDBTable.GenerateEntityUnit_TypeDeclaration;
VAR
  col : IDBColumn;
begin
  AddSql('Type');
  BreakLine;
  IncIdentyLevel();
  AddSql(EntityInterface + ' = interface(IStormEntity)' + NewInterfaceGUID);
  IncIdentyLevel();
  for col in FColumns  do
  begin
    col.GenerateEntityFieldDeclaration();
  end;

  AddSql(KEYWORD_FUNCTION + ' Clone(Target : '+ Self.EntityInterface +') : Boolean;');
  DecIdentyLevel();
  AddSql(KEYWORD_END + ';');
  DecIdentyLevel();
  BreakLine;

  AddSql(KEYWORD_FUNCTION + '  New'+ EntityName +'() : '+EntityInterface+';');
  AddSql(KEYWORD_FUNCTION + '  NewEntity() : IStormEntity;');
  AddSql(KEYWORD_PROCEDURE+' RegisterEntityConstructor();');
  BreakLine();
end;

procedure TDBTable.GenerateEntityUnit_TypeImplementation;
VAR
  col : IDbcolumn;
begin
  AddSql(KEYWORD_TYPE);
  BreakLine;
  IncIdentyLevel();
  AddSQL(EntityType + ' = class(TStormEntity, IStormEntity, '+ EntityInterface +
  ', ICloneable<'+EntityInterface+'>)');
  AddSql(KEYWORD_PRIVATE);
  BreakLine;
  AddSql(KEYWORD_PROTECTED);
  IncIdentyLevel();
  for col in FColumns do
  begin
    col.GenerateEntityProtectedFieldDeclaration();
  end;
  BreakLine;
  AddSql(KEYWORD_PROCEDURE+' Initialize(); '+KEYWORD_override+';');
  AddSql(KEYWORD_PROCEDURE+' Finalize(); '+KEYWORD_override+';');
  DecIdentyLevel();
  AddSql(KEYWORD_PUBLIC);
  IncIdentyLevel();
  AddSql(KEYWORD_CONSTRUCTOR + ' Create(); '+KEYWORD_REINTRODUCE+';');
  BreakLine;
  for col in FColumns do
  begin
    col.GenerateEntityFieldDeclaration();
  end;
  BreakLine;
  AddSql(KEYWORD_FUNCTION+' Clone(Target : '+EntityInterface+'): Boolean;');
  DecIdentyLevel();
  AddSql(KEYWORD_END + ';');
  BreakLine;
  DecIdentyLevel();
  for col in FColumns do
  begin
    col.GenerateEntityFieldImplementation();
    BreakLine;
  end;

end;

procedure TDBTable.GenerateSchemaUnit;
begin
  FIdentyLevel := 0;

  GenerateSchemaUnit_Interface();
  GenerateSchemaUnit_Implementation();
end;

procedure TDBTable.GenerateSchemaUnit_Implementation;
VAR
  col : IDBColumn;
begin
  IdentyLevel := 0;
  AddSQL(KEYWORD_IMPLEMENTATION);
  BreakLine;
  AddSql(KEYWORD_CONSTRUCTOR+' '+EntitySchemaTypeName+'.Create;');
  AddSql(KEYWORD_BEGIN);
  IncIdentyLevel();
  AddSql('inherited Create('+QuotedStr(self.FSchema)+', '+
  QuotedStr(Self.FTableName)+', '+QuotedStr(self.EntityName)+');');
  DecIdentyLevel();
  AddSql(KEYWORD_END+';');
  BreakLine;
  AddSql(KEYWORD_DESTRUCTOR+' '+EntitySchemaTypeName+'.Destroy;');
  AddSql(KEYWORD_BEGIN);
  IncIdentyLevel();
  AddSql('inherited;');
  DecIdentyLevel();
  AddSql(KEYWORD_END+';');
  BreakLine;

  AddSql(KEYWORD_PROCEDURE+' '+EntitySchemaTypeName+'.Initialize;');
  AddSql(KEYWORD_BEGIN);
  IncIdentyLevel();
  AddSql('inherited;');

  for col in FColumns do
  begin
    col.GenerateSchemaFieldCreation();
    BreakLine;
  end;

  for col in FColumns do
  begin
    col.GenerateSchemaAddField();

  end;

  DecIdentyLevel();
  AddSql(KEYWORD_END+';');
  BreakLine;
  AddSql(KEYWORD_END+'.');




end;

procedure TDBTable.GenerateSchemaUnit_Interface;
VAR
  col : IDBColumn;
begin
  AddSQL(KEYWORD_UNIT + ' ' + EntitySchemaUnitName + ';');
  BreakLine;
  AddSQL(KEYWORD_INTERFACE);
  BreakLine;
  AddSQL(KEYWORD_USES);
  IncIdentyLevel();
  AddSql('storm.schema.table,');
  AddSql('storm.schema.column,');
  AddSql('storm.schema.interfaces,');
  AddSql('storm.schema.types,');
  BreakLine;
  AddSql('System.Classes,');
  AddSql('System.Sysutils;');
  BreakLine;
  DecIdentyLevel();
  AddSQl(KEYWORD_TYPE);
  IncIdentyLevel();
  BreakLine;
  AddSql(EntitySchemaTypeName+' = class(TStormTableSchema)');
  addSql(KEYWORD_PRIVATE);
  IncIdentyLevel();

  for col in FColumns do
  begin
    col.GenerateSchemaFieldDeclaration();
  end;

  BreakLine;
  DecIdentyLevel();
  addSql(KEYWORD_PROTECTED);
  IncIdentyLevel();
  AddSql(KEYWORD_PROCEDURE+' Initialize(); '+KEYWORD_OVERRIDE+';');
  BreakLine;
  DecIdentyLevel();
  addSql(KEYWORD_PUBLIC);
  IncIdentyLevel();

  for col in FColumns do
  begin
    col.GenerateSchemaPropertyDeclaration();
  end;

  BreakLine;
  AddSql(KEYWORD_CONSTRUCTOR +' Create(); '+KEYWORD_REINTRODUCE+';');
  AddSql(KEYWORD_DESTRUCTOR  +' Destroy(); '+KEYWORD_OVERRIDE+';');
  DecIdentyLevel();
  AddSql(KEYWORD_END + ';');
  BreakLine;

end;

function TDBTable.Getcolumns: TList<IDBColumn>;
begin
  Result := Self.FColumns;
end;

function TDBTable.GetEntityFile: String;
begin
  GenerateEntityUnit();
  Result := getSQL();
end;

function TDBTable.GetIdentyLevel: Integer;
begin
  Result := self.FIdentyLevel;
end;

function TDBTable.GetMaxLengthOfcolumns: Integer;
begin
  Result := FMaxLengthOfcolumns;
end;

function TDBTable.GetSchemaFile: String;
begin
  GenerateSchemaUnit();
  Result := getSQL();
end;

function TDBTable.Schema: String;
begin
  Result := Fschema;
end;

procedure TDBTable.SetIdentyLevel(const Value: Integer);
begin
   Self.FIdentyLevel := Value;
end;

function TDBTable.TableName: String;
begin
  Result := FTableName;
end;

Function NewDbTable(Dataset : TDataset) : IDBTable;
begin
  Result := TDBTable.FromDataset(Dataset);
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

procedure TSQLGenerator.BreakLine;
begin
  AddSql('');
end;

end.
