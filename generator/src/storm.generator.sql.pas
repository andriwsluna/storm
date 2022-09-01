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
    Function GetWhereSelectorInterface(): String;
    Function GetOrderBySelected(): String;
    Function GetFieldSelection(): String;
    Function GetFieldsAssignment(): String;
    Function GetFieldsInsertion(): String;




    procedure IncIdentyLevel(value : integer = 1);
    procedure DecIdentyLevel(value : integer = 1);

    Function GetEntityFile() : String;
    Function GetSchemaFile() : String;
    Function GetORMFile() : String;
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

    Procedure GenerateORMWhereSelector();
    Procedure GenerateORMOrderBySelector();
    Procedure GenerateORMFieldSelection();
    Procedure GenerateORMFieldAssignment();
    Procedure GenerateORMFieldInsertion();


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

    Procedure GenerateORMUnit();
    Procedure GenerateORMUnit_Interface();
    Procedure GenerateORMUnit_Interface_EnumPossibleFields();
    Procedure GenerateORMUnit_Interface_IWhereSelector();
    Procedure GenerateORMUnit_Interface_OrderBySelection();
    Procedure GenerateORMUnit_Interface_FieldSelection();
    Procedure GenerateORMUnit_Interface_FieldAssignment();
    Procedure GenerateORMUnit_Interface_FieldInsertion();

    Procedure GenerateORMUnit_Implementation();
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


    //ORM
    Function EntityORMUnitName() : String;
    Function EntityORMTypeName() : String;
    Function EntityORMEnum() : String;
    Function EntityORMEnumSET() : String;
    Function GetWhereSelectorInterface(): String;
    Function GetOrderBySelection(): String;
    Function GetOrderBySelected(): String;
    Function GetFieldSelection(): String;
    Function GetFieldSelectionWithLimit(): String;
    Function GetFieldsAssignment(): String;
    Function GetFieldsInsertion(): String;



    Function GetEntityFile() : String;
    Function GetSchemaFile() : String;
    Function GetORMFile() : String;

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
    Function GetStormPrimitiveType() : String; Virtual; Abstract;
    Function GetWhereInterface() : String; Virtual;
    Function GetFieldAssignment() : String; Virtual;
    Function GetFieldInsertion() : String; Virtual;

    Procedure GenerateEntityFieldDeclaration(); Virtual;
    Procedure GenerateEntityProtectedFieldDeclaration(); Virtual;
    Procedure GenerateEntityFieldImplementation();
    Procedure GenerateEntityFieldCreation();
    Procedure GenerateEntityAddStormField();

    Procedure GenerateSchemaFieldDeclaration();
    Procedure GenerateSchemaPropertyDeclaration();
    Procedure GenerateSchemaFieldCreation();
    Procedure GenerateSchemaAddField();


    Procedure GenerateORMWhereSelector();
    Procedure GenerateORMOrderBySelector();
    Procedure GenerateORMFieldSelection();
    Procedure GenerateORMFieldAssignment();
    Procedure GenerateORMFieldInsertion();
  end;

  TVarcharColumn = Class(TDBColumn)
  private
  protected
    FMaxLength : Integer;
  public


    Constructor FromDataset(Dataset : TDataset); Override;
    Function GetFieldType() : String; Override;
    Function GetFieldConcreteType() : String; Override;
    Function GetSchemaType() : String; Override;
    Function GetSchemaFieldCreation() : String; Override;
    Function GetStormPrimitiveType() : String; Override;
  end;

  TIntegerColumn = Class(TDBColumn)
  private

  public
    Function GetFieldType() : String; Override;
    Function GetFieldConcreteType() : String; Override;
    Function GetSchemaType() : String; Override;
    Function GetStormPrimitiveType() : String; Override;
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
    Function GetStormPrimitiveType() : String; Override;
  end;

  TBooleanColumn = Class(TDBColumn)
  public
    Function GetFieldType() : String; Override;
    Function GetFieldConcreteType() : String; Override;
    Function GetSchemaType() : String; Override;
    Function GetStormPrimitiveType() : String; Override;
  end;

  TDateColumn = Class(TDBColumn)
  public
    Function GetFieldType() : String; Override;
    Function GetFieldConcreteType() : String; Override;
    Function GetSchemaType() : String; Override;
    Function GetStormPrimitiveType() : String; Override;
  end;

  TDateTimeColumn = Class(TDBColumn)
  public
    Function GetFieldType() : String; Override;
    Function GetFieldConcreteType() : String; Override;
    Function GetSchemaType() : String; Override;
    Function GetStormPrimitiveType() : String; Override;
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

procedure TDBColumn.GenerateORMFieldAssignment;
begin
  AddSql(KEYWORD_FUNCTION+' ' + CompleteWithBlanks(Self.FieldName,self.FDBTable.GetMaxLengthOfcolumns)+
  ' : '+Self.GetFieldAssignment()+'<'+self.FDBTable.GetFieldsAssignment+'WithWhere>;');
end;

procedure TDBColumn.GenerateORMFieldInsertion;
begin
  AddSql(KEYWORD_FUNCTION+' ' + CompleteWithBlanks(Self.FieldName,self.FDBTable.GetMaxLengthOfcolumns)+
  ' : '+Self.GetFieldInsertion()+'<'+self.FDBTable.GetFieldsInsertion+'WithGo>;');
end;

procedure TDBColumn.GenerateORMFieldSelection;
begin
  AddSql(KEYWORD_FUNCTION + ' ' +CompleteWithBlanks(Self.FieldName,self.FDBTable.GetMaxLengthOfcolumns)+
  ' : '+self.FDBTable.GetFieldSelection+';');
end;

procedure TDBColumn.GenerateORMOrderBySelector;
begin
  AddSql(KEYWORD_FUNCTION + ' ' +CompleteWithBlanks(Self.FieldName,self.FDBTable.GetMaxLengthOfcolumns)+
  ' : IStormOrderBySelector'+'<'+FDBTable.GetOrderBySelected+'>;');
end;

procedure TDBColumn.GenerateORMWhereSelector;
begin
  AddSql(KEYWORD_FUNCTION + ' ' +CompleteWithBlanks(Self.FieldName,self.FDBTable.GetMaxLengthOfcolumns)+
  ' : '+GetWhereInterface()+'<'+FDBTable.GetWhereSelectorInterface+
  '<Executor>, Executor>;');
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

function TDBColumn.GetFieldAssignment: String;
begin
  if self.IsNulable then
  begin
    Result := 'IStorm'+GetStormPrimitiveType()+'NullableFieldAssignement';
  end
  else
  begin
    Result := 'IStorm'+GetStormPrimitiveType()+'FieldAssignement';
  end;
end;

function TDBColumn.GetFieldInsertion: String;
begin
  if self.IsNulable then
  begin
    Result := 'IStorm'+GetStormPrimitiveType()+'NullableFieldInsertion';
  end
  else
  begin
    Result := 'IStorm'+GetStormPrimitiveType()+'FieldInsertion';
  end;
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

function TDBColumn.GetWhereInterface: String;
begin
  if self.IsNulable then
  begin
    Result := 'IStorm'+GetStormPrimitiveType()+'NullableWhere';
  end
  else
  begin
    Result := 'IStorm'+GetStormPrimitiveType()+'Where';
  end;
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

function TVarcharColumn.GetStormPrimitiveType: String;
begin
  Result := 'String';
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

function TNumericColumn.GetStormPrimitiveType: String;
begin
  Result := 'Float';
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

function TIntegerColumn.GetStormPrimitiveType: String;
begin
  Result := 'Integer';
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

function TBooleanColumn.GetStormPrimitiveType: String;
begin
  Result := 'Boolean';
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

function TDateColumn.GetStormPrimitiveType: String;
begin
  Result := 'Date';
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

function TDateTimeColumn.GetStormPrimitiveType: String;
begin
  Result := 'DateTime';
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

function TDBTable.EntityORMEnum: String;
begin
  Result := 'T'+Self.FName+'PossibleFields'
end;


function TDBTable.EntityORMEnumSET: String;
begin
  Result := 'T'+self.FName+'SETFieldSelection = set of '+self.EntityORMEnum+';';
end;

function TDBTable.EntityORMTypeName: String;
begin
  //Result := 'uORM'+Self.FName;
end;

function TDBTable.EntityORMUnitName: String;
begin
  Result := 'uORM'+Self.FName;
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

procedure TDBTable.GenerateORMUnit;
begin
  self.IdentyLevel := 0;
  GenerateORMUnit_Interface();
  GenerateORMUnit_Implementation();

end;

procedure TDBTable.GenerateORMUnit_Implementation;
begin

end;

procedure TDBTable.GenerateORMUnit_Interface;
begin
  AddSQL(KEYWORD_UNIT + ' ' + EntityORMUnitName + ';');
  BreakLine;
  AddSql(KEYWORD_INTERFACE);
  BreakLine;
  AddSql(KEYWORD_USES);
  IncIdentyLevel();
  AddSql('DFE.Result,');
  AddSql('DFE.Maybe,');
  AddSql('storm.data.interfaces,');
  AddSql('storm.orm.interfaces,');
  AddSql('storm.entity.interfaces,');
  AddSql('uEntityProduto;');
  BreakLine;
  DecIdentyLevel();
  AddSQL(KEYWORD_TYPE);
  IncIdentyLevel();
  BreakLine;
  GenerateORMUnit_Interface_EnumPossibleFields();
  BreakLine;
  AddSql('ISelectByIDResult   = TResult<'+EntityInterface+', IStormExecutionFail>;');
  AddSql('IUpdateEntityResult = TResult<'+EntityInterface+', IStormExecutionFail>;');
  AddSql('IInsertEntityResult = TResult<'+EntityInterface+', IStormExecutionFail>;');
  AddSql('IDeleteEntityResult = TResult<'+EntityInterface+', IStormExecutionFail>;');
  BreakLine;
  GenerateORMUnit_Interface_IWhereSelector();
  BreakLine;
  AddSql(self.GetOrderBySelected() +' = interface;');
  BreakLine;
  GenerateORMUnit_Interface_OrderBySelection();
  BreakLine;
  GenerateORMUnit_Interface_FieldSelection();
  BreakLine;
  GenerateORMUnit_Interface_FieldAssignment();
  BreakLine;
  GenerateORMUnit_Interface_FieldInsertion();
  BreakLine;

end;

procedure TDBTable.GenerateORMUnit_Interface_EnumPossibleFields;
VAR
  i : integer;
  s : string;
begin
  AddSQL(self.EntityORMEnum + ' = ');
  Addsql('(');
  IncIdentyLevel();

  for I := 0 to self.FColumns.Count-1 do
  begin
    if i > 0 then
    begin
      s := ',';
    end
    else
    begin
      s := ' ';
    end;
    s := s + (CompleteWithBlanks(self.FColumns[i].FieldName,self.FMaxLengthOfcolumns) + ' = ' + i.ToString);
    AddSql(s);
  end;
  DecIdentyLevel();
  Addsql(');');
  BreakLine;
  AddSql(EntityORMEnumSET());
end;

procedure TDBTable.GenerateORMUnit_Interface_FieldAssignment;
VAR
  col : IDBColumn;
begin
  AddSQL(self.GetFieldsAssignment+'WithWhere = interface;');
  BreakLine;
  AddSQL(self.GetFieldsAssignment+'Base = interface' + NewInterfaceGUID());

  IncIdentyLevel();

  for col in FColumns do
  begin
    col.GenerateORMFieldAssignment;
  end;
  DecIdentyLevel();
  AddSQL(KEYWORD_END + ';');
  BreakLine;
  AddSql(self.GetFieldsAssignment+'WithWhere = interface('+GetFieldsAssignment+'Base)' + NewInterfaceGUID());
  IncIdentyLevel();
  AddSql(KEYWORD_FUNCTION+' Where : '+Self.GetWhereSelectorInterface+'<IStormUpdateExecutor>'+';');
  DecIdentyLevel();
  AddSQL(KEYWORD_END + ';');
  BreakLine;
  AddSql(self.GetFieldsAssignment+' = interface('+GetFieldsAssignment+'Base)' + NewInterfaceGUID());
  IncIdentyLevel();
  AddSql(KEYWORD_FUNCTION+' FromEntyity(Entity : '+Self.EntityInterface+
  ') : IStormWherePoint<'+GetWhereSelectorInterface+'<IStormUpdateExecutor>>;');
  DecIdentyLevel();
  AddSQL(KEYWORD_END + ';');


end;

procedure TDBTable.GenerateORMUnit_Interface_FieldInsertion;
VAR
  col : IDBColumn;
begin
  AddSQL(self.GetFieldsInsertion+'WithGo = interface;');
  BreakLine;
  AddSQL(self.GetFieldsInsertion+'Base = interface' + NewInterfaceGUID());

  IncIdentyLevel();

  for col in FColumns do
  begin
    col.GenerateORMFieldInsertion;
  end;
  DecIdentyLevel();
  AddSQL(KEYWORD_END + ';');
  BreakLine;
  AddSql(self.GetFieldsInsertion+'WithGo = interface('+GetFieldsInsertion+'Base)' + NewInterfaceGUID());
  IncIdentyLevel();
  AddSql(KEYWORD_FUNCTION+' Go : IStormInsertExecutor<'+EntityInterface+'>;');
  DecIdentyLevel();
  AddSQL(KEYWORD_END + ';');
  BreakLine;
  AddSql(self.GetFieldsInsertion+' = interface('+GetFieldsInsertion+'Base)' + NewInterfaceGUID());
  IncIdentyLevel();
  AddSql(KEYWORD_FUNCTION+' FromEntyity(Entity : '+Self.EntityInterface+
  ') : IStormInsertExecutor<'+EntityInterface+'>');
  DecIdentyLevel();
  AddSQL(KEYWORD_END + ';');


end;

procedure TDBTable.GenerateORMUnit_Interface_FieldSelection;
VAR
  col : IDBColumn;
begin
  AddSQL(self.GetFieldSelection+' = interface' + NewInterfaceGUID());
  IncIdentyLevel();

  for col in FColumns do
  begin
    col.GenerateORMFieldSelection;
  end;
  AddSQL(KEYWORD_FUNCTION+' AllColumns() : IStormWherePoint<'
  +Self.GetWhereSelectorInterface+'<IStormSelectExecutor<'
  +Self.EntityInterface+','+Self.GetOrderBySelection+'>>>;');
  AddSql(KEYWORD_FUNCTION+' From : IStormWherePoint<'+GetWhereSelectorInterface
  +'<IStormSelectExecutor<'+EntityInterface+','+GetOrderBySelection+'>>>;');
  DecIdentyLevel();
  AddSQL(KEYWORD_END + ';');
  BreakLine;
  AddSql(self.GetFieldSelectionWithLimit+' = interface('+GetFieldSelection+')' + NewInterfaceGUID());
  IncIdentyLevel();
  AddSql(KEYWORD_FUNCTION+' Limit(Const Count : Integer) : '+GetFieldSelection+';');
  DecIdentyLevel();
  AddSQL(KEYWORD_END + ';');


end;

procedure TDBTable.GenerateORMUnit_Interface_IWhereSelector;
Var
  col : IDBColumn;
begin
  AddSql(GetWhereSelectorInterface+'<Executor : IInterface> = interface' + NewInterfaceGUID);
  IncIdentyLevel();
  for col in FColumns do
  begin
    Col.GenerateORMWhereSelector();
  end;
  BreakLine;
  AddSql(KEYWORD_FUNCTION+' OpenParenthesis : '+GetWhereSelectorInterface+'<Executor>;');
  DecIdentyLevel();
  AddSql(KEYWORD_END + ';');
end;

procedure TDBTable.GenerateORMUnit_Interface_OrderBySelection;
VAR
  col : IDBColumn;
begin
  AddSQL(self.GetOrderBySelection+' = interface' + NewInterfaceGUID());
  IncIdentyLevel();

  for col in FColumns do
  begin
    col.GenerateORMOrderBySelector;
  end;
  DecIdentyLevel();
  AddSQL(KEYWORD_END + ';');
  BreakLine;
  AddSql(self.GetOrderBySelected+' = interface('+GetOrderBySelection+')' + NewInterfaceGUID());
  IncIdentyLevel();
  AddSql(KEYWORD_FUNCTION+' Open() : TResult<IStormSelectSuccess<'+EntityInterface+'>,IStormExecutionFail>;');
  DecIdentyLevel();
  AddSQL(KEYWORD_END + ';');


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

function TDBTable.GetFieldSelection: String;
begin
  Result := 'I'+self.FName+'FieldsSelection';
end;

function TDBTable.GetFieldSelectionWithLimit: String;
begin
  Result := GetFieldSelection + 'WithLimit';
end;

function TDBTable.GetFieldsInsertion: String;
begin
  Result := 'I'+FName+'FieldsInsertion';
end;

function TDBTable.GetIdentyLevel: Integer;
begin
  Result := self.FIdentyLevel;
end;

function TDBTable.GetFieldsAssignment: String;
begin
  Result := 'I'+FName+'FieldsAssignment';
end;

function TDBTable.GetMaxLengthOfcolumns: Integer;
begin
  Result := FMaxLengthOfcolumns;
end;

function TDBTable.GetOrderBySelected: String;
begin
  Result := 'I'+self.FName+'OrderBySelected';
end;

function TDBTable.GetOrderBySelection: String;
begin
  Result := 'I'+self.FName+'OrderBySelection';
end;

function TDBTable.GetORMFile: String;
begin
  GenerateORMUnit();
  Result := getSQL();
end;

function TDBTable.GetSchemaFile: String;
begin
  GenerateSchemaUnit();
  Result := getSQL();
end;

function TDBTable.GetWhereSelectorInterface: String;
begin
  Result := 'I'+Self.FName+'WhereSelector';
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
