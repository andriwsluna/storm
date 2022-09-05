unit storm.generator;


interface
USES
  System.Generics.Collections;

Type
  TDbType = (dbMSSQL);
  TDbConfig = record
    Server : String;
    UserName : String;
    Password : String;
    Database : String;
    PortNumber : integer;
    DatabaseType : TDbType;
  end;

Function GerateStormFilesFromModel
(
  DbConfig : TDbConfig;
  Dir : String ;
  TableNames : Array of String
) : Boolean; Overload;

Function GerateStormFilesFromModel
(
  DbConfig : TDbConfig;
  Dir : String
) : Boolean; Overload;

implementation

Uses
  System.Classes,
  System.Sysutils,
  Data.DB, Data.Win.ADODB,
  storm.generator.sql;

Function GetDbConnectionFromDbConfig(DbConfig : TDbConfig) : TADOConnection;
begin
  Result := TADOConnection.Create(nil);
  Result.LoginPrompt := False;
  if DbConfig.DatabaseType = dbMSSQL then
  begin

    Result.ConnectionString :=
    'Provider=SQLOLEDB.1;'+
    'Password='+DbConfig.Password+';'+
    'Persist Security Info=True;'+
    'User ID='+DbConfig.UserName+';'+
    'Initial Catalog='+DbConfig.Database+';'+
    'Data Source='+DbConfig.Server+';'+
    'Use Procedure for Prepare=1;'+
    'Auto Translate=True;'+
    'Packet Size=4096;'+
    'Use Encryption for Data=False;'+
    'Tag with column collation when possible=False';
  end;


end;

Function GetTablesDataset(DbConnection : TADOConnection ; TableNames : Array of String) : TDataset;
VAR
  qy : TADOQuery;
  tableName : string;
   i : integer;
begin
  qy := TADOQuery.Create(nil);

  result := qy;

  Qy.Connection := DbConnection;
  Qy.Sql.Add('SELECT');
  Qy.Sql.Add('s.name  as schema_name ,');
  Qy.Sql.Add('t.name as table_name');
  Qy.Sql.Add('FROM sys.tables t');
  Qy.Sql.Add('join sys.schemas s');
  Qy.Sql.Add('on t.schema_id = s.schema_id');
  qy.sql.add('WHERE');
  qy.sql.add('EXISTS');
  qy.sql.add('(');
  qy.sql.add('Select 1 from SYS.columns as c');
  qy.sql.add('');
  qy.sql.add('inner join INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc');
  qy.sql.add('on t.name = tc.TABLE_NAME');
  qy.sql.add('and tc.CONSTRAINT_TYPE = ''PRIMARY KEY''');
  qy.sql.add('inner JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS ku');
  qy.sql.add('ON');
  qy.sql.add('tc.CONSTRAINT_NAME = KU.CONSTRAINT_NAME');
  qy.sql.add('and ku.CONSTRAINT_SCHEMA = s.name');
  qy.sql.add('AND ku.table_name= t.name');
  qy.sql.add('and ku.COLUMN_NAME  = c.name');
  qy.sql.add('');
  qy.sql.add('WHERE');
  qy.sql.add('t.object_id = c.object_id');
  qy.sql.add(')');

  if Length(TableNames) > 0 then
  begin
    for i := 0 to Length(TableNames)-1 do
    begin
      tableName:= TableNames[i];
      qy.SQL.Add(' and t.name = ' + QuotedStr(tableName));
    end;
  end;

  Qy.Sql.Add('order by s.name, t.name');
  qy.Open;
end;

Function GetColumnsDataset(DbConnection : TADOConnection ; TableName,SchemaName :string) : TDataset;
VAR
  qy : TADOQuery;
begin
  qy := TADOQuery.Create(nil);

  result := qy;

  Qy.Connection := DbConnection;
  Qy.Sql.Add('SELECT');
  Qy.Sql.Add('s.name  as schema_name ,');
  Qy.Sql.Add('t.name as table_name,');
  Qy.Sql.Add('c.column_id,');
  Qy.Sql.Add('c.name  as column_name,');
  Qy.Sql.Add('c.system_type_id as type_id,');
  Qy.Sql.Add('c.max_length,');
  Qy.Sql.Add('c.[precision],');
  Qy.Sql.Add('c.[scale],');
  Qy.Sql.Add('c.is_nullable,');
  Qy.Sql.Add('c.is_identity,');
  Qy.Sql.Add('c.object_id,');
  Qy.Sql.Add('CAST(CASE');
  Qy.Sql.Add('when ku.TABLE_NAME = t.name then 1 else 0');
  Qy.Sql.Add('END as bit) as is_primarykey');
  Qy.Sql.Add('FROM sys.tables t');
  Qy.Sql.Add('join sys.schemas s');
  Qy.Sql.Add('on t.schema_id = s.schema_id');
  Qy.Sql.Add('JOIN SYS.columns c');
  Qy.Sql.Add('ON t.object_id = c.object_id');
  Qy.Sql.Add('left join INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc');
  Qy.Sql.Add('on t.name = tc.TABLE_NAME');
  qy.SQL.Add('and tc.CONSTRAINT_TYPE = ''PRIMARY KEY''');
  Qy.Sql.Add('left JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS ku');
  Qy.Sql.Add('ON tc.CONSTRAINT_NAME = KU.CONSTRAINT_NAME');
  Qy.Sql.Add('and ku.CONSTRAINT_SCHEMA = s.name');
  Qy.Sql.Add('AND ku.table_name= t.name');
  Qy.Sql.Add('and ku.COLUMN_NAME  = c.name');
  Qy.Sql.Add('WHERE');
  Qy.Sql.Add('s.name= :schema');
  Qy.Sql.Add('and');
  Qy.Sql.Add('t.name  = :table');
  Qy.Parameters.ParamByName('schema').Value := SchemaName;
  Qy.Parameters.ParamByName('table').Value := TableName;
  qy.Open;
end;

procedure ForcesDirectories(Dir : String);
begin
  System.Sysutils.ForceDirectories(Dir);
  System.Sysutils.ForceDirectories(Dir + '\entities');
  System.Sysutils.ForceDirectories(Dir + '\schemas');
  System.Sysutils.ForceDirectories(Dir + '\orms');

end;

Procedure GenerateTable(Table : IDBTable ; Dir : string);
VAR
  TargetFile : Tstringlist;
begin
  TargetFile := Tstringlist.Create;
  try
    TargetFile.Text := Table.GetEntityFile;
    TargetFile.SaveToFile(Dir + '\entities\' + Table.GetEntityUnitName + '.pas');
    TargetFile.Text := Table.GetSchemaFile;
    TargetFile.SaveToFile(Dir + '\schemas\' + Table.GetSchemaUnitName + '.pas');
    TargetFile.Text := Table.GetORMFile;
    TargetFile.SaveToFile(Dir + '\orms\' + Table.GetORMUnitName + '.pas');
  finally
    TargetFile.Free;
  end;
end;


Function GerateStormFilesFromModel
(
  DbConfig : TDbConfig;
  Dir : String ;
  TableNames : Array of String
) : Boolean;
VAR
  DbConnection : TADOConnection;
  DatasetTables : TDataset;
  DatasetColumns : TDataset;
  Table : IDBTable;
begin
  DbConnection := GetDbConnectionFromDbConfig(DbConfig);
  try
    DatasetTables := GetTablesDataset(DbConnection,TableNames);
    ForcesDirectories(Dir);

    while not DatasetTables.Eof do
    begin
      Table := NewDbTable(DatasetTables);
      DatasetColumns := GetColumnsDataset
      (
        DbConnection,
        DatasetTables.FieldByName('table_name').AsString,
        DatasetTables.FieldByName('schema_name').AsString
      );
      try
        Table.LoadColumsFromDataset(DatasetColumns);
        GenerateTable(Table,Dir);
      finally
        DatasetColumns.Free;
      end;

      DatasetTables.Next;
    end;
  finally
    DbConnection.Free;
  end;
end;

Function GerateStormFilesFromModel
(
  DbConfig : TDbConfig;
  Dir : String
) : Boolean;
begin
  Result := GerateStormFilesFromModel(DbConfig,Dir,[])
end;

end.
