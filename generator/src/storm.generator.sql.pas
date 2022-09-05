unit storm.generator.sql;

interface

USes
  Data.DB,
  System.Generics.Collections,
  DFE.Maybe,
  DFE.Interfaces,
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
    Procedure LoadColumsFromDataset(Dataset : TDataset);
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

    Function GetEntityUnitName() : String;
    Function GetSchemaUnitName() : String;
    Function GetORMUnitName() : String;
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

    Procedure GenerateOnInsertedSetValue();


    Function GetFieldType() : String;
    Function GetStormPrimitiveType() : String;
    Function GetPrimitiveType() : String;
    Function GetValueOrDefault() : String;
    Function GetPrimtiveDefaultValue() : String;
    Function GetWhereInterface() : String;
    Function GetFieldAssignment() : String;
    Function GetFieldInsertion() : String;

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
    Procedure AddBegin();
    Procedure AddOpenParentesis();
    Procedure AddCloseParentesis(PostSymbol : String = ';');
    Procedure AddEnd(PostSymbol : string = ';');
    Procedure AddPublic();
    Procedure BreakLine();
    Function GetSQL() : String;
  public
    Constructor Create(); Reintroduce; Virtual;
    Destructor  Destroy();Override;
  end;

  TDBTable = class(TSQLGenerator,IDBTable)
  private
    Function FilterPrimaryKeys(col : IDBColumn) : Boolean;
    Function FilterNotPrimaryKeys(col : IDBColumn) : Boolean;
    Function FilterNullableColumn(col : IDBColumn) : Boolean;
    Function FilterNotNullableColumn(col : IDBColumn) : Boolean;
  protected
    FColumns : IIterator<IDBColumn>;
    FPrimaryKeyColumns : TList<IDBColumn>;
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
    Procedure GenerateORMUnit_Interface_ORMDEclaration();
    Procedure GenerateORMUnit_Implementation();
    Procedure GenerateORMUnit_Implementation_ORMClass();
    Procedure GenerateORMUnit_Implementation_FieldsSelection();
    Procedure GenerateORMUnit_Implementation_OrderBySelection();
    Procedure GenerateORMUnit_Implementation_WhereSelector();
    Procedure GenerateORMUnit_Implementation_FieldsAssignment();
    Procedure GenerateORMUnit_Implementation_FieldsInsertion();
    Procedure GenerateORMUnit_Implementation_Constructors();

    Procedure GenerateORMUnit_CodeImplementation();
    Procedure GenerateORMUnit_CodeImplementation_ORMGetter();
    Procedure GenerateORMUnit_CodeImplementation_ORMClass();
    Procedure GenerateORMUnit_CodeImplementation_ORMClass_SimpleMethods();
    Procedure GenerateORMUnit_CodeImplementation_ORMClass_DeleteEntity();
    Procedure GenerateORMUnit_CodeImplementation_ORMClass_Initialize();
    Procedure GenerateORMUnit_CodeImplementation_ORMClass_InsertEntity();
    Procedure GenerateORMUnit_CodeImplementation_ORMClass_InsertedSetValueTo();
    Procedure GenerateORMUnit_CodeImplementation_ORMClass_ProccessSelectSuccess();
    Procedure GenerateORMUnit_CodeImplementation_ORMClass_SelectByID();
    Procedure GenerateORMUnit_CodeImplementation_ORMClass_UpdateEntity();
    Procedure GenerateORMUnit_CodeImplementation_FieldsSelection();
    Procedure GenerateORMUnit_CodeImplementation_WhereSelector();
    Procedure GenerateORMUnit_CodeImplementation_FieldsAssignment();
    Procedure GenerateORMUnit_CodeImplementation_FieldsInsertion();
    Procedure GenerateORMUnit_CodeImplementation_OrderBySelection();
    Procedure GenerateORMUnit_CodeImplementation_Contructors();
  public


    Constructor Create(); Reintroduce;
    cONSTRUCTOR FromDataset(Dataset : TDataset);
    Procedure LoadColumsFromDataset(Dataset : TDataset);

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
    Function EntityORMInterface() : String;
    Function EntityORMEnum() : String;
    Function EntityORMEnumSET() : String;
    Function GetWhereSelectorInterface(): String;
    Function GetWhereSelectorType(): String;
    Function GetOrderBySelection(): String;
    Function GetOrderBySelectionType(): String;
    Function GetOrderBySelected(): String;
    Function GetOrderBySelectedType(): String;
    Function GetFieldSelection(): String;
    Function GetFieldSelectionType(): String;
    Function GetFieldSelectionWithLimit(): String;
    Function GetFieldsAssignment(): String;
    Function GetFieldsAssignmentType(): String;
    Function GetFieldsInsertion(): String;
    Function GetFieldsInsertionType(): String;
    Function GetORMInterface() : String;
    Function GetORMType() : String;
    Procedure GenerateSelectByID(typ : String = '');
    Procedure GenerateWherePrimaryKeyIsEquals(EqualsToPrimitive : Boolean = False);



    Function GetEntityFile() : String;
    Function GetSchemaFile() : String;
    Function GetORMFile() : String;

    Function GetEntityUnitName() : String;
    Function GetSchemaUnitName() : String;
    Function GetORMUnitName() : String;

  end;



  TDBColumn = Class(TInterfacedObject,IDBColumn)
  private
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
    Function GetPrimitiveType() : String; Virtual; Abstract;
    Function GetWhereInterface() : String; Virtual;
    Function GetFieldAssignment() : String; Virtual;
    Function GetFieldInsertion() : String; Virtual;
    Function GetPrimtiveDefaultValue() : String; Virtual; Abstract;
    Function GetValueOrDefault() : String;

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

    Procedure GenerateOnInsertedSetValue();
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
    Function GetPrimitiveType() : String; Override;
    Function GetPrimtiveDefaultValue() : String; Override;
  end;

  TIntegerColumn = Class(TDBColumn)
  private

  public
    Function GetFieldType() : String; Override;
    Function GetFieldConcreteType() : String; Override;
    Function GetSchemaType() : String; Override;
    Function GetStormPrimitiveType() : String; Override;
    Function GetPrimitiveType() : String; Override;
    Function GetPrimtiveDefaultValue() : String; Override;
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
    Function GetPrimitiveType() : String; Override;
    Function GetPrimtiveDefaultValue() : String; Override;
  end;

  TBooleanColumn = Class(TDBColumn)
  public
    Function GetFieldType() : String; Override;
    Function GetFieldConcreteType() : String; Override;
    Function GetSchemaType() : String; Override;
    Function GetStormPrimitiveType() : String; Override;
    Function GetPrimitiveType() : String; Override;
    Function GetPrimtiveDefaultValue() : String; Override;
  end;

  TDateColumn = Class(TDBColumn)
  public
    Function GetFieldType() : String; Override;
    Function GetFieldConcreteType() : String; Override;
    Function GetSchemaType() : String; Override;
    Function GetStormPrimitiveType() : String; Override;
    Function GetPrimitiveType() : String; Override;
    Function GetPrimtiveDefaultValue() : String; Override;
  end;

  TDateTimeColumn = Class(TDBColumn)
  public
    Function GetFieldType() : String; Override;
    Function GetFieldConcreteType() : String; Override;
    Function GetSchemaType() : String; Override;
    Function GetStormPrimitiveType() : String; Override;
    Function GetPrimitiveType() : String; Override;
    Function GetPrimtiveDefaultValue() : String; Override;
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

procedure TDBColumn.GenerateOnInsertedSetValue;
begin
  AddSql(KEYWORD_FUNCTION+' OnInsertedSetValueTo'+Self.FieldName+'(value : Maybe<'+Self.GetPrimitiveType+'>) : Boolean;');
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

function TDBColumn.GetValueOrDefault: String;
begin
  Result := FieldName+'.GetValueOrDefault('+GetPrimtiveDefaultValue()+')';
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

function TVarcharColumn.GetPrimitiveType: String;
begin
  Result := 'String';
end;

function TVarcharColumn.GetPrimtiveDefaultValue: String;
begin
  Result := QuotedStr('');
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

function TNumericColumn.GetPrimitiveType: String;
begin
  Result := 'Extended';
end;

function TNumericColumn.GetPrimtiveDefaultValue: String;
begin
  Result := '0.0';
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


function TIntegerColumn.GetPrimitiveType: String;
begin
  Result := 'Integer';
end;

function TIntegerColumn.GetPrimtiveDefaultValue: String;
begin
  Result := '0';
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


function TBooleanColumn.GetPrimitiveType: String;
begin
  Result := 'Boolean';
end;

function TBooleanColumn.GetPrimtiveDefaultValue: String;
begin
  Result := 'False';
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

function TDateColumn.GetPrimitiveType: String;
begin
  Result := 'TDate';
end;

function TDateColumn.GetPrimtiveDefaultValue: String;
begin
  Result := '0';
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


function TDateTimeColumn.GetPrimitiveType: String;
begin
  Result := 'TDateTime';
end;

function TDateTimeColumn.GetPrimtiveDefaultValue: String;
begin
  Result := '0.0';
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
  FColumns := Titerator<IDBColumn>.create;
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

function TDBTable.EntityORMInterface: String;
begin
  Result := 'I'+Self.FName+'ORM';
end;

function TDBTable.EntityORMTypeName: String;
begin
  Result := 'T'+Self.FName+'ORM';
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

function TDBTable.FilterNotNullableColumn(col: IDBColumn): Boolean;
begin
  Result := Not Col.IsNulable;
end;

function TDBTable.FilterNotPrimaryKeys(col: IDBColumn): Boolean;
begin
  Result := Not col.IsPrimaryKey;
end;

function TDBTable.FilterNullableColumn(col: IDBColumn): Boolean;
begin
  Result := col.IsNulable;
end;

function TDBTable.FilterPrimaryKeys(col: IDBColumn): Boolean;
begin
  Result := col.IsPrimaryKey;
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

  for col in Getcolumns do
  begin
    col.GenerateEntityFieldCreation();
  end;

  BreakLine;

  for col in Getcolumns do
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
  for col in Getcolumns  do
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
  for col in Getcolumns do
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
  for col in Getcolumns do
  begin
    col.GenerateEntityFieldDeclaration();
  end;
  BreakLine;
  AddSql(KEYWORD_FUNCTION+' Clone(Target : '+EntityInterface+'): Boolean;');
  DecIdentyLevel();
  AddSql(KEYWORD_END + ';');
  BreakLine;
  DecIdentyLevel();
  for col in Getcolumns do
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
  GenerateORMUnit_CodeImplementation();

end;

procedure TDBTable.GenerateORMUnit_CodeImplementation;
begin
  IdentyLevel := 0;
  GenerateORMUnit_CodeImplementation_ORMGetter();
  BreakLine;
  GenerateORMUnit_CodeImplementation_ORMClass();
  BreakLine;
  GenerateORMUnit_CodeImplementation_FieldsSelection();
  BreakLine;
  GenerateORMUnit_CodeImplementation_WhereSelector();
  BreakLine;
  GenerateORMUnit_CodeImplementation_FieldsAssignment();
  BreakLine;
  GenerateORMUnit_CodeImplementation_FieldsInsertion();
  BreakLine;
  GenerateORMUnit_CodeImplementation_OrderBySelection();
  BreakLine;
  GenerateORMUnit_CodeImplementation_Contructors();
  BreakLine;
  AddEnd('.');
end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_Contructors;
begin
  AddSql('{ T'+EntityName+'Constructors }');
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' T'+EntityName+'OrderBySelectionConstructor.GetGenericInstance(');
  AddSql('Owner: TStormSQLPartition): '+Self.GetOrderBySelection+';');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := T'+EntityName+'OrderBySelection.Create(Owner);');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' T'+EntityName+'OrderBySelectedConstructor.GetGenericInstance(');
  AddSql('Owner: TStormSQLPartition): I'+EntityName+'OrderBySelected;');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := T'+EntityName+'OrderBySelection.Create(Owner);');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' T'+EntityName+'WhereSelectorSelectConstructor.GetGenericInstance(');
  AddSql('Owner: TStormSQLPartition): I'+EntityName+'WhereSelector<IStormSelectExecutor<I'+EntityName+',I'+EntityName+'OrderBySelection>>;');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := T'+EntityName+'WhereSelector<IStormSelectExecutor<I'+EntityName+',I'+EntityName+'OrderBySelection>>.Create(Owner);');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' TSelectExecutorConstructor.GetGenericInstance(');
  AddSql('Owner: TStormSQLPartition): IStormSelectExecutor<I'+EntityName+',I'+EntityName+'OrderBySelection>;');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := TStormSelectExecutor<I'+EntityName+',I'+EntityName+'OrderBySelection>.Create(Owner);');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' T'+EntityName+'FieldsAssignmentWithWhereConstructor.GetGenericInstance(');
  AddSql('Owner: TStormSQLPartition): I'+EntityName+'FieldsAssignmentWithWhere;');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := T'+EntityName+'FieldsAssignment.Create(Owner);');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' T'+EntityName+'WhereSelectorUpdateConstructor.GetGenericInstance(');
  AddSql('Owner: TStormSQLPartition): I'+EntityName+'WhereSelector<IStormUpdateExecutor>;');
  AddBegin;
  AddSql(KEYWORD_RESULT+' :=  T'+EntityName+'WhereSelector<IStormUpdateExecutor>.Create(owner);');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' T'+EntityName+'FieldsInsertionWithGoConstructor.GetGenericInstance(');
  AddSql('Owner: TStormSQLPartition): I'+EntityName+'FieldsInsertionWithGo;');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := T'+EntityName+'FieldsInsertion.Create(Owner);');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' T'+EntityName+'EntityConstructor.GetGenericInstance(');
  AddSql('Owner: TStormSQLPartition): I'+EntityName+';');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := New'+EntityName+'();');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' T'+EntityName+'WhereSelectorDeleteConstructor.GetGenericInstance(');
  AddSql('Owner: TStormSQLPartition): I'+EntityName+'WhereSelector<IStormDeleteExecutor>;');
  AddBegin;
  AddSql(KEYWORD_RESULT+' :=  T'+EntityName+'WhereSelector<IStormDeleteExecutor>.Create(owner);');
  AddEnd();

end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_FieldsAssignment;
begin
  AddSql('{ '+GetFieldsAssignmentType+' }');
  BreakLine;
  FColumns.ForEach
  (
    procedure(col : IDBColumn)
    begin
      AddSql(KEYWORD_FUNCTION+' '+GetFieldsAssignmentType+'.'+Col.FieldName+
      ': '+Col.GetFieldAssignment+'<'+GetFieldsAssignment+'WithWhere>;');
      AddBegin;
      AddSql(KEYWORD_RESULT+' := TStorm'+Col.GetStormPrimitiveType+
      'FieldAssignement<'+Self.GetFieldsAssignment+'WithWhere>.Create'+
      '(Self, '+Self.GetORMType+'(self.ORM).Schema'+Self.EntityName+'.'+Col.FieldName+');');
      AddEnd();
      BreakLine;
    end
  );

  AddSql(KEYWORD_FUNCTION+' '+GetFieldsAssignmentType+'.FromEntyity(');
  AddSql('Entity: '+EntityInterface+'): IStormWherePoint<'+Self.GetWhereSelectorInterface+'<IStormUpdateExecutor>>;');
  AddSql('VAR');
  IncIdentyLevel();
  AddSql('FieldAssignment : '+GetFieldsAssignment+'WithWhere;');
  DecIdentyLevel();
  AddBegin;
  AddSql('FieldAssignment := self;');
  FColumns.Filter(FilterNotPrimaryKeys).ForEach
  (
    procedure(col : IDBColumn)
    begin
      if col.IsNulable then
      begin
        AddSql('FieldAssignment := FieldAssignment.'+Col.FieldName+'.SetThisOrNull(Entity.'+Col.FieldName+'.GetValue());');
      end
      else
      begin
        AddSql('FieldAssignment := FieldAssignment.'+Col.FieldName+'.SetTo(Entity.'+Col.FieldName+'.GetValueOrDefault());');
      end;
    end
  );
  AddSql(KEYWORD_RESULT+' := TStormWherePoint<'+Self.GetWhereSelectorInterface+'<IStormUpdateExecutor>,IStormUpdateExecutor>.Create');
  AddOpenParentesis;
  AddSql('FieldAssignment as TStormSqlPartition');
  AddCloseParentesis();
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_PROCEDURE+' '+Self.GetFieldsAssignmentType+'.initialize;');
  AddBegin;
  AddSql('inherited;');
  AddSql('if Protected_SQL.IsEmpty then');
  AddBegin;
  AddSql('AddUpdate();');
  AddEnd();
  AddEnd();

end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_FieldsInsertion;
begin
  AddSql('{ '+GetFieldsInsertionType+' }');
  BreakLine;
  FColumns.ForEach
  (
    procedure(col : IDbColumn)
    begin
      AddSql(KEYWORD_FUNCTION+' '+GetFieldsInsertionType+'.'+Col.FieldName+': '+
      Col.GetFieldInsertion+'<'+GetFieldsInsertion+'WithGo>;');
      AddBegin();
      AddSql(KEYWORD_RESULT+' := TStorm'+Col.GetStormPrimitiveType+'FieldInsertion<'+
      GetFieldsInsertion+'WithGo>.Create');
      AddOpenParentesis;
      AddSql('Self,');
      AddSql('TSchema'+EntityName+'(Self.TableSchema).'+Col.FieldName+',');
      AddSql(Self.GetORMType+'(self.ORM).OnInsertedSetValueTo'+Col.FieldName+'');
      AddCloseParentesis();
      AddEnd();

      BreakLine;
    end
  );



  AddSql(KEYWORD_FUNCTION+' '+GetFieldsInsertionType+'.Go: IStormInsertExecutor<'+EntityInterface+'>;');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := TStormInsertExecutor<'+EntityInterface+'>.Create(Self, '+GetORMType+'(self.ORM).InsertedEntity);');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' '+GetFieldsInsertionType+'.FromEntyity(');
  AddSql('Entity: '+EntityInterface+'): IStormInsertExecutor<'+EntityInterface+'>;');
  AddSql('var');
  IncIdentyLevel();
  AddSql('Insertions : '+GetFieldsInsertion+'WithGo;');
  DecIdentyLevel();
  AddBegin;
  AddSql('Insertions := Self;');

  FColumns.Filter(Self.FilterNotNullableColumn).ForEach
  (
    procedure(col : IDbColumn)
    begin
      AddSql('Insertions := (Insertions.'+Col.FieldName+' as TStorm'+Col.GetStormPrimitiveType
      +'FieldInsertion<'+GetFieldsInsertion+'WithGo>)');
      AddSql('.SetValue(Entity.'+Col.FieldName+'.GetValue());');
      BreakLine;
    end
  );

  FColumns.Filter(Self.FilterNullableColumn).ForEach
  (
    procedure(col : IDbColumn)
    begin
      AddSql('Insertions := Insertions.'+Col.FieldName+'.SetValue(Entity.'+Col.FieldName+'.GetValue());');
      BreakLine;
    end
  );

  AddSql(KEYWORD_RESULT+' := TStormInsertExecutor<'+EntityInterface+'>.Create');
  AddOpenParentesis;
  AddSql('Insertions as TStormSqlPartition,');
  AddSql(Self.GetORMType+'(self.ORM).InsertedEntity');
  AddCloseParentesis();
  AddEnd();

end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_FieldsSelection;
begin
  AddSql('{ '+GetFieldSelectionType+' }');
  AddSql('');
  FColumns.ForEach
  (
    procedure(col : IDBColumn)
    begin
      AddSql(KEYWORD_FUNCTION+' '+GetFieldSelectionType+'.'+Col.FieldName+': I'+EntityName+'FieldsSelection;');
      AddBegin;
      AddSql('AddColumn(Integer(T'+EntityName+'PossibleFields.'+Col.FieldName+'));');
      AddSql(KEYWORD_RESULT+' := Self;');
      addEnd();
      breakline();
    end
  );
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' '+GetFieldSelectionType+'.Limit(');
  AddSql('Const Count: Integer): '+GetFieldSelection+';');
  AddBegin;
  AddSql('AddLimit(Count);');
  AddSql(KEYWORD_RESULT+' := Self;');
  AddEnd();
end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_OrderBySelection;
begin
  AddSQL('{ '+Self.GetOrderBySelectionType+' }');
  BreakLine;
  FColumns.ForEach
  (
    procedure(col : IDBColumn)
    begin
      AddSql(KEYWORD_FUNCTION+' '+GetOrderBySelectionType+'.'+Col.FieldName+
      ': IStormOrderBySelector<'+Self.GetOrderBySelected+'>;');
      AddBegin;
      AddSql(KEYWORD_RESULT+' := TStormOrderBySelector<'+GetOrderBySelected+
      '>.Create(Integer(T'+EntityName+'PossibleFields.'+Col.FieldName+'),Self);');
      addEnd();
      breakline();
    end
  );

  AddSql(KEYWORD_FUNCTION+' '+GetOrderBySelectionType+'.Open: TResult<IStormSelectSuccess<I'+EntityName+'>, IStormExecutionFail>;');
  AddBegin;
  AddSql('RemoveLastSqlCharacter();');
  AddSql(KEYWORD_RESULT+' := TStormSelectExecutor<'+EntityInterface+
  ','+Self.GetOrderBySelection+'>.Create(Self).Open();');
  addEnd();

end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_ORMClass;
begin
  GenerateORMUnit_CodeImplementation_ORMClass_SimpleMethods();
  BreakLine;
  GenerateORMUnit_CodeImplementation_ORMClass_DeleteEntity();
  BreakLine;
  GenerateORMUnit_CodeImplementation_ORMClass_Initialize();
  BreakLine;
  GenerateORMUnit_CodeImplementation_ORMClass_InsertEntity();
  BreakLine;
  GenerateORMUnit_CodeImplementation_ORMClass_InsertedSetValueTo();
  BreakLine;
  GenerateORMUnit_CodeImplementation_ORMClass_ProccessSelectSuccess();
  BreakLine;
  GenerateORMUnit_CodeImplementation_ORMClass_SelectByID();
  BreakLine;
  GenerateORMUnit_CodeImplementation_ORMClass_UpdateEntity();
  BreakLine;
end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_ORMClass_DeleteEntity;
begin
  AddSql(KEYWORD_FUNCTION+' '+GetORMType+'.DeleteEntity(Entity: '+EntityInterface+'): IDeleteEntityResult;');
  AddBegin;
  AddSql('if VerifyPrimaryKeyFields(Entity) then');
  AddBegin;
  AddSql('Result := Delete()');
  AddSql('.Where');
  GenerateWherePrimaryKeyIsEquals();
  AddSql('.Go');
  AddSql('.Execute');
  AddSql('.BindTo<IDeleteEntityResult>');
  AddSql('(');
  IncIdentyLevel();
  AddSql(KEYWORD_FUNCTION+'(res : IStormDeleteSuccess) : IDeleteEntityResult');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := Entity;');
  AddEnd(',');
  AddSql(KEYWORD_FUNCTION+'(res : IStormExecutionFail) : IDeleteEntityResult');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := res;');
  AddEnd('');
  DecIdentyLevel();
  AddSql(');');
  AddEnd('');
  AddSql('else');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := TStormExecutionFail.Create(TStormSqlPartition.Create(Self),''All Primary key fields must be assigned.'');');
  AddEnd();
  AddEnd();

end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_ORMClass_Initialize;
begin
  AddSql(KEYWORD_PROCEDURE+' '+GetORMType+'.Initialize();');
  AddBegin;
  AddSql('inherited;');
  AddSql('FClassConstructor.Add');
  AddOpenParentesis;
  AddSql('TGUID('+GetWhereSelectorInterface+'<IStormSelectExecutor<'+EntityInterface+','+GetOrderBySelection+'>>).ToString +');
  AddSql('TGUID(IStormSelectExecutor<'+EntityInterface+','+Self.GetOrderBySelection+'>).ToString,');
  AddSql(GetWhereSelectorType+'SelectConstructor.Create');
  AddCloseParentesis();
  AddSql('');
  AddSql('FClassConstructor.Add');
  AddOpenParentesis;
  AddSql('TGUID('+GetWhereSelectorInterface+'<IStormUpdateExecutor>).ToString +');
  AddSql('TGUID(IStormUpdateExecutor).ToString,');
  AddSql(GetWhereSelectorType+'UpdateConstructor.Create');
  AddCloseParentesis();
  AddSql('');
  AddSql('FClassConstructor.Add');
  AddOpenParentesis;
  AddSql('TGUID('+GetWhereSelectorInterface+'<IStormDeleteExecutor>).ToString +');
  AddSql('TGUID(IStormDeleteExecutor).ToString,');
  AddSql(GetWhereSelectorType+'DeleteConstructor.Create');
  AddCloseParentesis();
  AddSql('');
  AddSql('');
  AddSql('FClassConstructor.Add');
  AddOpenParentesis;
  AddSql('TGUID(IStormSelectExecutor<'+EntityInterface+','+GetOrderBySelection+'>).ToString,');
  AddSql('TSelectExecutorConstructor.Create');
  AddCloseParentesis();
  AddSql('');
  AddSql('FClassConstructor.Add');
  AddOpenParentesis;
  AddSql('TGUID('+GetFieldsAssignment+').ToString,');
  AddSql(GetFieldsAssignmentType+'WithWhereConstructor.Create');
  AddCloseParentesis();
  AddSql('');
  AddSql('FClassConstructor.Add');
  AddOpenParentesis;
  AddSql('TGUID('+GetFieldsAssignment+'WithWhere).ToString,');
  AddSql(GetFieldsAssignmentType+'WithWhereConstructor.Create');
  AddCloseParentesis();
  AddSql('');
  AddSql('FClassConstructor.Add');
  AddOpenParentesis;
  AddSql('TGUID('+GetFieldsInsertion+'WithGo).ToString,');
  AddSql(GetFieldsInsertionType+'WithGoConstructor.Create');
  AddCloseParentesis();
  AddSql('');
  AddSql('FClassConstructor.Add');
  AddOpenParentesis;
  AddSql('TGUID('+EntityInterface+').ToString,');
  AddSql('T'+FName+'EntityConstructor.Create');
  AddCloseParentesis();
  AddSql('');
  AddSql('FClassConstructor.Add');
  AddOpenParentesis;
  AddSql('TGUID('+GetOrderBySelection+').ToString,');
  AddSql(GetOrderBySelectionType+'Constructor.Create');
  AddCloseParentesis();
  AddSql('');
  AddSql('FClassConstructor.Add');
  AddOpenParentesis;
  AddSql('TGUID('+GetOrderBySelected+').ToString,');
  AddSql(GetOrderBySelectedType+'Constructor.Create');
  AddCloseParentesis();
  AddEnd();

end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_ORMClass_InsertedSetValueTo;
begin
  FColumns.ForEach
  (
    procedure(Col : IDBColumn)
    begin
      AddSql(KEYWORD_FUNCTION+' '+GetORMType+'.OnInsertedSetValueTo'+Col.FieldName+'(value: Maybe<'+Col.GetPrimitiveType+'>): Boolean;');
      AddBegin;
      AddSql(KEYWORD_RESULT+' := InsertedEntity.'+Col.FieldName+'.Value.SetValue(value);');
      AddEnd;
      BreakLine;
    end
  );
end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_ORMClass_InsertEntity;
begin
  AddSql(KEYWORD_FUNCTION+' '+GetORMType+'.InsertEntity(Entity: '+EntityInterface+'): IInsertEntityResult;');
  AddBegin;
  AddSql('if VerifyPrimaryKeyFields(Entity,True) then');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := Insert()');
  AddSql('.FromEntyity(Entity)');
  AddSql('.Execute');
  AddSql('.BindTo<IInsertEntityResult>');
  AddSql('(');
  AddSql(KEYWORD_FUNCTION+'(res : IStormInsertSuccess<'+EntityInterface+'>) : IInsertEntityResult');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := res.GetInserted;');
  AddEnd(',');
  AddSql(KEYWORD_FUNCTION+'(res : IStormExecutionFail) : IInsertEntityResult');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := res;');
  AddEnd('');
  AddSql(');');
  AddEnd('');
  AddSql('else');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := TStormExecutionFail.Create(TStormSqlPartition.Create(Self),''All Primary key fields must be assigned.'');');
  AddEnd();
  AddEnd();

end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_ORMClass_ProccessSelectSuccess;
begin
  AddSql(KEYWORD_FUNCTION+' '+GetORMType+'.ProccessSelectSuccess(');
  AddSql('Res: IStormSelectSuccess<'+EntityInterface+'>): ISelectByIDResult;');
  AddBegin;
  AddSql('if not res.IsEmpty then');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := res.GetModel.Records[0]');
  AddEnd('');
  AddSql('else');
  AddBegin;
  AddSql('result := TStormExecutionFail.Create');
  AddOpenParentesis;
  AddSql('TStormSelectSuccess<'+EntityInterface+'>(res) , ''Record not found''');
  AddCloseParentesis();
  AddEnd();
  AddEnd();

end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_ORMClass_SelectByID;
begin

  GenerateSelectByID(GetORMType + '.');
  AddBegin;
  AddSql(KEYWORD_RESULT+' :=');
  AddSql('Self');
  AddSql('.Select');
  AddSql('.AllColumns');
  AddSql('.Where');
  GenerateWherePrimaryKeyIsEquals(True);
  AddSql('.Go');
  AddSql('.Open');
  AddSql('.BindTo<ISelectByIDResult>');
  AddSql('(ProccessSelectSuccess,ProccessSelectFail);');
  AddSql('');
  AddEnd();

end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_ORMClass_SimpleMethods;
begin
  AddSql(KEYWORD_CONSTRUCTOR+' '+GetORMType+'.Create(DbSQLConnecton: IStormSQLConnection);');
  AddBegin;
  AddSql('inherited create(DbSQLConnecton, '+Self.EntitySchemaTypeName+'.Create);');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' '+GetORMType+'.Delete: IStormWherePoint<'+GetWhereSelectorInterface+'<IStormDeleteExecutor>>;');
  AddBegin;
  AddSql('Result := TStormWherePoint<'+Self.GetWhereSelectorInterface+'<IStormDeleteExecutor>,IStormDeleteExecutor>.Create(self);');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' '+GetORMType+'.GetInsertedEntity<'+EntityInterface+'>: uEntity'+EntityName+'.'+EntityInterface+';');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := self.InsertedEntity;');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' '+GetORMType+'.Insert: '+GetFieldsInsertion+';');
  AddBegin;
  AddSql('InsertedEntity := new'+EntityName+'();');
  AddSql(KEYWORD_RESULT+' := '+Self.GetFieldsInsertionType+'.Create(self);');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' '+GetORMType+'.ProccessSelectFail(');
  AddSql('Res: IStormExecutionFail): ISelectByIDResult;');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := res;');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' '+GetORMType+'.Select: '+GetFieldSelection+'WithLimit;');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := '+GetFieldSelectionType+'.Create(self);');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' '+GetORMType+'.Schema'+EntityName+': '+EntitySchemaTypeName+';');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := '+KEYWORD_SELF+'.TableSchema as '+EntitySchemaTypeName+';');
  AddEnd();
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' '+GetORMType+'.Update: '+GetFieldsAssignment+';');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := '+GetFieldsAssignmentType+'.Create(self);');
  AddEnd();

end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_ORMClass_UpdateEntity;
begin
  AddSql(KEYWORD_FUNCTION+' '+GetORMType+'.UpdateEntity(Entity: '+EntityInterface+'): IUpdateEntityResult;');
  AddBegin;
  AddSql('if VerifyPrimaryKeyFields(Entity) then');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := Update()');
  AddSql('.FromEntyity(Entity)');
  AddSql('.Where');
  GenerateWherePrimaryKeyIsEquals();
  AddSql('.Go');
  AddSql('.Execute');
  AddSql('.BindTo<IUpdateEntityResult>');
  AddOpenParentesis;
  AddSql(KEYWORD_FUNCTION+'(res : IStormUpdateSuccess) : IUpdateEntityResult');
  AddBegin;
  AddSql('if res.RowsUpdated >= 1 then');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := Entity;');
  AddEnd('');
  AddSql('else');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := TStormExecutionFail.Create(TStormSqlPartition(res),''Record not found'');');
  AddEnd();
  AddEnd(',');
  AddSql(KEYWORD_FUNCTION+'(res : IStormExecutionFail) : IUpdateEntityResult');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := res;');
  AddEnd('');
  AddCloseParentesis();
  AddEnd('');
  AddSql('else');
  AddBegin;
  AddSql('Result := TStormExecutionFail.Create(TStormSqlPartition.Create(Self),''All Primary key fields must be assigned.'');');
  AddEnd();
  AddEnd();

end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_ORMGetter;
begin
  AddSql(KEYWORD_FUNCTION+' '+EntityName+'_ORM(DbSQLConnecton: IStormSQLConnection) : '+GetORMInterface+';');
  AddBegin;
  AddSql(KEYWORD_RESULT+' := '+Self.GetORMType+'.Create(DbSQLConnecton);');
  AddEnd;
  AddSql('');
  AddSql(KEYWORD_FUNCTION+' '+EntityName+'_ORM() : '+GetORMInterface+';');
  AddBegin;
  AddSql('Result :=');
  AddSql('storm.dependency.register.DependencyRegister.GetSQLConnectionInstance.');
  AddSql('BindTo<'+Self.EntityORMInterface+'>');
  AddSql('(');
  IncIdentyLevel();
  AddSql(EntityName+'_ORM,');
  AddSql('Function : '+GetORMInterface+'');
  AddBegin;
  AddSql('Result := nil;');
  AddEnd('');
  DecIdentyLevel();
  AddSql(');');
  AddEnd;

end;

procedure TDBTable.GenerateORMUnit_CodeImplementation_WhereSelector;
begin
  AddSql('{ '+Self.GetWhereSelectorType+'<Executor> }');
  FColumns.ForEach
  (
    procedure(col : IDBColumn)
    begin
      AddSql(KEYWORD_FUNCTION+' '+GetWhereSelectorType+'<Executor>.'+Col.FieldName+
      ': '+Col.GetWhereInterface+'<'+GetWhereSelectorInterface+'<Executor>, Executor>;');
      AddBegin;
      AddSql(KEYWORD_RESULT+' := TStorm'+Col.GetStormPrimitiveType+'Where<'+
      Self.GetWhereSelectorInterface+'<Executor>, Executor>.Create(self, '+
      Self.GetORMType+'(self.ORM).Schema'+EntityName+'.'+Col.FieldName+');');
      AddEnd();
      BreakLine();

    end
  );

  AddSql(KEYWORD_FUNCTION+' '+GetWhereSelectorType+'<Executor>.OpenParenthesis: '+
  GetWhereSelectorInterface+'<Executor>;');
  AddBegin;
  AddSql('AddOpenParenthesis;');
  AddSql(KEYWORD_RESULT+' := Self;');
  AddEnd();


end;

procedure TDBTable.GenerateORMUnit_Implementation;
begin
  AddSQL(KEYWORD_IMPLEMENTATION);
  BreakLine;
  AddSql(KEYWORD_USES);
  IncIdentyLevel();
  AddSql('storm.schema.interfaces,');
  AddSql('storm.dependency.register,');
  AddSql('storm.orm.update,');
  AddSql(Self.EntitySchemaUnitName+',');
  AddSql('System.Sysutils,');
  AddSql('storm.orm.where,');
  AddSql('storm.orm.insert,');
  AddSql('storm.orm.base;');
  BreakLine;
  DecIdentyLevel();
  AddSQL(KEYWORD_TYPE);
  IncIdentyLevel();
  GenerateORMUnit_Implementation_ORMClass();
  BreakLine;
  GenerateORMUnit_Implementation_FieldsSelection();
  BreakLine;
  GenerateORMUnit_Implementation_OrderBySelection();
  BreakLine;
  GenerateORMUnit_Implementation_WhereSelector();
  BreakLine;
  GenerateORMUnit_Implementation_FieldsAssignment();
  BreakLine;
  GenerateORMUnit_Implementation_FieldsInsertion();
  BreakLine;
  GenerateORMUnit_Implementation_Constructors();
  BreakLine;

end;

procedure TDBTable.GenerateORMUnit_Implementation_Constructors;
begin
  AddSql(Self.GetWhereSelectorType+'SelectConstructor');
  AddSql('= Class(TInterfacedObject, IStormGenericReturn<'+GetWhereSelectorInterface
  +'<IStormSelectExecutor<'+EntityInterface+','+GetOrderBySelection+'>>>)');
  AddPublic;
  AddSql(KEYWORD_FUNCTION+' GetGenericInstance(Owner : TStormSQLPartition) : '+GetWhereSelectorInterface
  +'<IStormSelectExecutor<'+EntityInterface+','+GetOrderBySelection+'>>;');
  AddEnd;
  AddSql('');
  AddSql(GetWhereSelectorType+'UpdateConstructor');
  AddSql('= Class(TInterfacedObject, IStormGenericReturn<'+GetWhereSelectorInterface+'<IStormUpdateExecutor>>)');
  AddPublic;
  AddSql(KEYWORD_FUNCTION+' GetGenericInstance(Owner : TStormSQLPartition) : '+
  GetWhereSelectorInterface+'<IStormUpdateExecutor>;');
  AddEnd;
  AddSql('');
  AddSql(GetWhereSelectorType+'DeleteConstructor');
  AddSql('= Class(TInterfacedObject, IStormGenericReturn<'+GetWhereSelectorInterface+'<IStormDeleteExecutor>>)');
  AddPublic;
  AddSql(KEYWORD_FUNCTION+' GetGenericInstance(Owner : TStormSQLPartition) : '+
  GetWhereSelectorInterface+'<IStormDeleteExecutor>;');
  AddEnd;
  AddSql('');
  AddSql('TSelectExecutorConstructor');
  AddSql('= Class(TInterfacedObject, IStormGenericReturn<IStormSelectExecutor<'+
  EntityInterface+', '+GetOrderBySelection+'>>)');
  AddPublic;
  AddSql(KEYWORD_FUNCTION+' GetGenericInstance(Owner : TStormSQLPartition) : '+
  'IStormSelectExecutor<'+EntityInterface+', '+GetOrderBySelection+'>;');
  AddEnd;
  AddSql('');
  AddSql(Self.GetFieldsAssignmentType+'WithWhereConstructor');
  AddSql('= Class(TInterfacedObject, IStormGenericReturn<'+GetFieldsAssignment+'WithWhere>)');
  AddPublic;
  AddSql(KEYWORD_FUNCTION+' GetGenericInstance(Owner : TStormSQLPartition) : '+
  GetFieldsAssignment+'WithWhere;');
  AddEnd;
  AddSql('');
  AddSql(Self.GetFieldsInsertionType+'WithGoConstructor');
  AddSql('= Class(TInterfacedObject, IStormGenericReturn<'+GetFieldsInsertion+'WithGo>)');
  AddPublic;
  AddSql(KEYWORD_FUNCTION+' GetGenericInstance(Owner : TStormSQLPartition) : '+GetFieldsInsertion+'WithGo;');
  AddEnd;
  AddSql('');
  AddSql('T'+EntityName+'EntityConstructor');
  AddSql('= Class(TInterfacedObject, IStormGenericReturn<'+EntityInterface+'>)');
  AddPublic;
  AddSql(KEYWORD_FUNCTION+' GetGenericInstance(Owner : TStormSQLPartition) : '+EntityInterface+';');
  AddEnd;
  AddSql('');
  AddSql(Self.GetOrderBySelectionType+'Constructor');
  AddSql('= Class(TInterfacedObject, IStormGenericReturn<'+GetOrderBySelection+'>)');
  AddPublic;
  AddSql(KEYWORD_FUNCTION+' GetGenericInstance(Owner : TStormSQLPartition) : '+GetOrderBySelection+';');
  AddEnd;
  AddSql('');
  AddSql(GetOrderBySelectedType+'Constructor');
  AddSql('= Class(TInterfacedObject, IStormGenericReturn<'+GetOrderBySelected+'>)');
  AddPublic;
  AddSql(KEYWORD_FUNCTION+' GetGenericInstance(Owner : TStormSQLPartition) : '+GetOrderBySelected+';');
  AddEnd;

end;

procedure TDBTable.GenerateORMUnit_Implementation_FieldsAssignment;
begin
  AddSql(GetFieldsAssignmentType+' = Class');
  AddSql('(');
  IncIdentyLevel();
  AddSql('TStormWherePoint<'+GetWhereSelectorInterface+'<IStormUpdateExecutor>,');
  AddSql('IStormUpdateExecutor>,');
  AddSql(GetFieldsAssignment+',');
  AddSql(GetFieldsAssignment+'WithWhere');
  DecIdentyLevel();
  AddSql(')');
  AddSql('protected');
  IncIdentyLevel();
  AddSql('procedure Initialize; Override;');
  DecIdentyLevel();
  AddSql('public');
  IncIdentyLevel();

  FColumns.ForEach
  (
    procedure(col : IDbColumn)
    begin
      col.GenerateORMFieldAssignment();
    end
  );

  AddSql(KEYWORD_FUNCTION+' FromEntyity(Entity : '+EntityInterface+
  ') : IStormWherePoint<'+GetWhereSelectorInterface+'<IStormUpdateExecutor>>;');
  DecIdentyLevel();
  AddSql(KEYWORD_END + ';');


end;

procedure TDBTable.GenerateORMUnit_Implementation_FieldsInsertion;
begin
  AddSql(GetFieldsInsertionType+' = class');
  AddSql('(');
  IncIdentyLevel();
  AddSql('TStormSqlPartition,');
  AddSql(GetFieldsInsertion+',');
  AddSql(GetFieldsInsertion+'WithGo');
  DecIdentyLevel();
  AddSql(')');
  AddSql('Public');
  IncIdentyLevel();

  FColumns.ForEach
  (
    procedure(col : IDbColumn)
    begin
      col.GenerateORMFieldInsertion();
    end
  );

  AddSql(KEYWORD_FUNCTION+' Go : IStormInsertExecutor<'+EntityInterface+'>;');
  AddSql(KEYWORD_FUNCTION+' FromEntyity(Entity : '+EntityInterface
  +') : IStormInsertExecutor<'+EntityInterface+'>;');
  DecIdentyLevel();
  AddSql(KEYWORD_END + ';');

end;

procedure TDBTable.GenerateORMUnit_Implementation_FieldsSelection;
begin
  AddSql(Self.GetFieldSelectionType+' = Class');
  AddSql('(');
  IncIdentyLevel();
  AddSql('TStormFieldsSelection<'+Self.GetWhereSelectorInterface
  +'<IStormSelectExecutor<'+EntityInterface+', '+EntityInterface
  +'OrderBySelection>>, IStormSelectExecutor<'+EntityInterface+','+EntityInterface+'OrderBySelection>>,');
  AddSql(GetFieldSelection+',');
  AddSql(GetFieldSelection+ 'WithLimit');
  DecIdentyLevel();
  AddSql(')');
  IncIdentyLevel();
  AddSql(KEYWORD_FUNCTION+' Limit(Const Count : Integer) : '+Self.GetFieldSelection+';');
  FColumns.ForEach
  (
    procedure(col : IDbColumn)
    begin
      col.GenerateORMFieldSelection();
    end
  );
  DecIdentyLevel();
  AddSql(KEYWORD_END + ';');

end;

procedure TDBTable.GenerateORMUnit_Implementation_OrderBySelection;
begin
  AddSql(GetOrderBySelectionType+' = Class(TStormSqlPartition,'+GetOrderBySelection+','+GetOrderBySelected+')');
  AddSql(KEYWORD_PUBLIC);
  IncIdentyLevel();
  FColumns.ForEach
  (
    procedure(col : IDbColumn)
    begin
      col.GenerateORMOrderBySelector();
    end
  );
  AddSql(KEYWORD_FUNCTION+' Open() : TResult<IStormSelectSuccess<'+EntityInterface+'>,IStormExecutionFail>;');
  DecIdentyLevel();
  AddSql(KEYWORD_END + ';');
end;

procedure TDBTable.GenerateORMUnit_Implementation_ORMClass;
begin
  AddSql(Self.EntityORMTypeName+' = Class(TStormORM, '+Self.EntityORMInterface+')');
  AddSql(KEYWORD_PRIVATE);
  IncIdentyLevel();
  AddSql(KEYWORD_FUNCTION+' Schema'+EntityName+' : '+Self.EntitySchemaTypeName+';');
  BreakLine;
  AddSql(KEYWORD_FUNCTION+' ProccessSelectSuccess(Res : IStormSelectSuccess<'+EntityInterface+'>) : ISelectByIDResult;');
  AddSql(KEYWORD_FUNCTION+' ProccessSelectFail(Res : IStormExecutionFail) : ISelectByIDResult;');
  DecIdentyLevel();
  AddSql(KEYWORD_PROTECTED);
  IncIdentyLevel();
  AddSql('InsertedEntity : '+EntityInterface+';');
  BreakLine;
  AddSql('procedure Initialize; override;');
  AddSql('Function GetInsertedEntity<'+EntityInterface+'>() : uEntity'+FName+'.'+EntityInterface+'; Reintroduce;');
  BreakLine;
  FColumns.ForEach
  (
    procedure(col : IDBColumn)
    begin
      col.GenerateOnInsertedSetValue();
    end
  );
  DecIdentyLevel();
  AddSQL(KEYWORD_PUBLIC);
  IncIdentyLevel();
  AddSql(KEYWORD_CONSTRUCTOR+' Create(DbSQLConnecton : IStormSQLConnection);');
  BreakLine;
  AddSql(KEYWORD_FUNCTION+' Select() : '+Self.GetFieldSelection+'WithLimit;');
  AddSql(KEYWORD_FUNCTION+' Update() : '+Self.GetFieldsAssignment+';');
  AddSql(KEYWORD_FUNCTION+' Insert() : '+Self.GetFieldsInsertion+';');
  AddSql(KEYWORD_FUNCTION+' Delete() : IStormWherePoint<'+Self.GetWhereSelectorInterface+'<IStormDeleteExecutor>>;');
  BreakLine;
  GenerateSelectByID();
  AddSql(KEYWORD_FUNCTION+' UpdateEntity(Entity : '+EntityInterface+') : IUpdateEntityResult;');
  AddSql(KEYWORD_FUNCTION+' InsertEntity(Entity : '+EntityInterface+') : IInsertEntityResult;');
  AddSql(KEYWORD_FUNCTION+' DeleteEntity(Entity : '+EntityInterface+') : IDeleteEntityResult;');
  DecIdentyLevel();
  AddSql(KEYWORD_END+';')

end;

procedure TDBTable.GenerateORMUnit_Implementation_WhereSelector;
begin
  AddSql(Self.GetWhereSelectorType+'<Executor : IInterface> = class(TStormSqlPartition, '+
  GetWhereSelectorInterface +'<Executor>)');
  AddSql(KEYWORD_PUBLIC);
  IncIdentyLevel();
  FColumns.ForEach
  (
    procedure(col : IDBColumn)
    begin
      col.GenerateORMWhereSelector;
    end
  );
  AddSql('Function OpenParenthesis : '+GetWhereSelectorInterface+'<Executor>;');
  DecIdentyLevel();
  AddSql('end;');
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
  AddSql('uEntity'+EntityName+';');
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
  GenerateORMUnit_Interface_ORMDEclaration();
  BreakLine;
  DecIdentyLevel();

end;

procedure TDBTable.GenerateORMUnit_Interface_EnumPossibleFields;
VAR
  i : integer;
  s : string;
begin
  AddSQL(self.EntityORMEnum + ' = ');
  Addsql('(');
  IncIdentyLevel();

  for I := 0 to self.Getcolumns.Count-1 do
  begin
    if i > 0 then
    begin
      s := ',';
    end
    else
    begin
      s := ' ';
    end;
    s := s + (CompleteWithBlanks(self.Getcolumns[i].FieldName,self.FMaxLengthOfcolumns) + ' = ' + i.ToString);
    AddSql(s);
  end;
  DecIdentyLevel();
  Addsql(');');
  BreakLine;
  //AddSql(EntityORMEnumSET());
end;

procedure TDBTable.GenerateORMUnit_Interface_FieldAssignment;
VAR
  col : IDBColumn;
begin
  AddSQL(self.GetFieldsAssignment+'WithWhere = interface;');
  BreakLine;
  AddSQL(self.GetFieldsAssignment+'Base = interface' + NewInterfaceGUID());

  IncIdentyLevel();

  for col in Getcolumns do
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

  for col in Getcolumns do
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
  ') : IStormInsertExecutor<'+EntityInterface+'>;');
  DecIdentyLevel();
  AddSQL(KEYWORD_END + ';');


end;

procedure TDBTable.GenerateORMUnit_Interface_FieldSelection;
VAR
  col : IDBColumn;
begin
  AddSQL(self.GetFieldSelection+' = interface' + NewInterfaceGUID());
  IncIdentyLevel();

  for col in Getcolumns do
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
  for col in Getcolumns do
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

  for col in GetColumns do
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

procedure TDBTable.GenerateORMUnit_Interface_ORMDEclaration;
begin
  AddSql(GetORMInterface+' = interface(IStormORM)' + NewInterfaceGUID);
  IncIdentyLevel();

  AddSql(KEYWORD_FUNCTION+' Select() : '+GetFieldSelectionWithLimit+';');
  AddSql(KEYWORD_FUNCTION+' Update() : '+GetFieldsAssignment+';');
  AddSql(KEYWORD_FUNCTION+' Insert() : '+GetFieldsInsertion+';');
  AddSql(KEYWORD_FUNCTION+' Delete() : IStormWherePoint<'+Self.GetWhereSelectorInterface+'<IStormDeleteExecutor>>;');
  BreakLine;
  GenerateSelectByID();
  AddSql(KEYWORD_FUNCTION+' UpdateEntity(Entity : '+EntityInterface+') : IUpdateEntityResult;');
  AddSql(KEYWORD_FUNCTION+' InsertEntity(Entity : '+EntityInterface+') : IInsertEntityResult;');
  AddSql(KEYWORD_FUNCTION+' DeleteEntity(Entity : '+EntityInterface+') : IDeleteEntityResult;');
  DecIdentyLevel();
  AddSql(KEYWORD_END+';');
  BreakLine;
  AddSql(KEYWORD_FUNCTION+' '+EntityName+'_ORM(DbSQLConnecton: IStormSQLConnection): '+EntityORMInterface+';  '+KEYWORD_OVERLOAD+';');
  AddSql(KEYWORD_FUNCTION+' '+EntityName+'_ORM() : '+EntityORMInterface+'; '+KEYWORD_OVERLOAD+';');

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

  for col in GetColumns do
  begin
    col.GenerateSchemaFieldCreation();
    BreakLine;
  end;

  for col in GetColumns do
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

  for col in GetColumns do
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

  for col in GetColumns do
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
  Result := Self.FColumns.Items;
end;

function TDBTable.GetEntityFile: String;
begin
  GenerateEntityUnit();
  Result := getSQL();
end;

function TDBTable.GetEntityUnitName: String;
begin
  Result := 'uEntity' + entityName;

end;

function TDBTable.GetFieldSelection: String;
begin
  Result := 'I'+self.FName+'FieldsSelection';
end;

function TDBTable.GetFieldSelectionType: String;
begin
  Result := 'T'+self.FName+'FieldsSelection';
end;

function TDBTable.GetFieldSelectionWithLimit: String;
begin
  Result := GetFieldSelection + 'WithLimit';
end;

function TDBTable.GetFieldsInsertion: String;
begin
  Result := 'I'+FName+'FieldsInsertion';
end;

function TDBTable.GetFieldsInsertionType: String;
begin
  Result := 'T'+FName+'FieldsInsertion';
end;

function TDBTable.GetIdentyLevel: Integer;
begin
  Result := self.FIdentyLevel;
end;

function TDBTable.GetFieldsAssignment: String;
begin
  Result := 'I'+FName+'FieldsAssignment';
end;

function TDBTable.GetFieldsAssignmentType: String;
begin
  Result := 'T'+FName+'FieldsAssignment';
end;

function TDBTable.GetMaxLengthOfcolumns: Integer;
begin
  Result := FMaxLengthOfcolumns;
end;

function TDBTable.GetOrderBySelected: String;
begin
  Result := 'I'+self.FName+'OrderBySelected';
end;

function TDBTable.GetOrderBySelectedType: String;
begin
  Result := 'T'+self.FName+'OrderBySelected';
end;

function TDBTable.GetOrderBySelection: String;
begin
  Result := 'I'+self.FName+'OrderBySelection';
end;

function TDBTable.GetOrderBySelectionType: String;
begin
  Result := 'T'+self.FName+'OrderBySelection';
end;

function TDBTable.GetORMFile: String;
begin
  GenerateORMUnit();
  Result := getSQL();
end;

function TDBTable.GetORMInterface: String;
begin
  Result := 'I'+Self.FName+'ORM';
end;

function TDBTable.GetORMType: String;
begin
  Result := 'T'+Self.FName+'ORM';
end;

function TDBTable.GetORMUnitName: String;
begin
  Result := self.EntityORMUnitName
end;

function TDBTable.GetSchemaFile: String;
begin
  GenerateSchemaUnit();
  Result := getSQL();
end;

function TDBTable.GetSchemaUnitName: String;
begin
  Result := self.EntitySchemaUnitName;
end;

procedure TDBTable.GenerateSelectByID(typ : String);
var
  col : IDBColumn;
  s : string;
  i : Integer;
  list : TList<IDBColumn>;
begin
  list := FColumns.Filter(FilterPrimaryKeys).Items;


  AddSql(KEYWORD_FUNCTION+' '+typ+'SelectByID');
  AddOpenParentesis;
  i := 1;
  for col in  list do
  begin
    s := 'Const ' + col.FieldName + ' : ' + col.GetPrimitiveType();

    if i < list.Count then
    begin
      s := s + ';';
    end;

    AddSQL(s);

    inc(i);
  end;
  AddCloseParentesis(': ISelectByIDResult;');


end;

procedure TDBTable.GenerateWherePrimaryKeyIsEquals(EqualsToPrimitive : Boolean);
VAR
  Added : Boolean;
begin
  Added := False;
  FColumns.Filter(FilterPrimaryKeys).ForEach
  (
    procedure(col : IDBColumn)
    begin
      if Added then
      begin
        AddSql('.And_');
      end;
      if EqualsToPrimitive then
      begin
        AddSql('.'+col.FieldName+'.IsEqualsTo('+col.FieldName+')');
      end
      else
      begin
        AddSql('.'+col.FieldName+'.IsEqualsTo(Entity.'+col.FieldName+'.GetValueOrDefault())');
      end;
      Added := True;
    end
  )
end;

function TDBTable.GetWhereSelectorInterface: String;
begin
  Result := 'I'+Self.FName+'WhereSelector';
end;

function TDBTable.GetWhereSelectorType: String;
begin
  Result := 'T'+Self.FName+'WhereSelector';
end;

procedure TDBTable.LoadColumsFromDataset(Dataset: TDataset);
begin
  Dataset.First;
  while not Dataset.Eof do
  begin
    Self.AddColumn(NewDbColumn(Dataset));
    Dataset.Next;
  end;
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

procedure TSQLGenerator.AddBegin;
begin
  AddSql(KEYWORD_BEGIN);
  IncIdentyLevel();
end;

procedure TSQLGenerator.AddCloseParentesis(PostSymbol : String);
begin
  DecIdentyLevel();
  AddSql(')' + PostSymbol);
end;

procedure TSQLGenerator.AddEnd(PostSymbol : String);
begin
  DecIdentyLevel();
  AddSql(KEYWORD_END + PostSymbol);
end;

procedure TSQLGenerator.AddOpenParentesis;
begin
  AddSql('(');
  IncIdentyLevel();
end;

procedure TSQLGenerator.AddPublic;
begin
  AddSql(KEYWORD_PUBLIC);
  IncIdentyLevel();
end;

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
