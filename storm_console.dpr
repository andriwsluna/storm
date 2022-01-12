program storm_console;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  storm.values.interfaces,
  storm.values.str,
  storm.additional.maybe,
  storm.fields.str,
  System.JSON,
  System.SysUtils,
  storm.fields.interfaces,
  storm.fields.base,
  storm.entity.interfaces in 'src\lib\entity\storm.entity.interfaces.pas',
  storm.entity.base in 'src\lib\entity\storm.entity.base.pas',
  uEntityProduto in 'src\teste\uEntityProduto.pas',
  storm.model.interfaces in 'src\lib\model\storm.model.interfaces.pas',
  storm.model.base in 'src\lib\model\storm.model.base.pas',
  storm.schema.table in 'src\lib\schema\storm.schema.table.pas',
  storm.schema.column in 'src\lib\schema\storm.schema.column.pas',
  storm.schema.types.base in 'src\lib\schema\storm.schema.types.base.pas',
  storm.schema.types.varchar in 'src\lib\schema\storm.schema.types.varchar.pas',
  storm.schema.interfaces in 'src\lib\schema\storm.schema.interfaces.pas',
  uSchemaProduto in 'src\teste\uSchemaProduto.pas',
  storm.schema.register in 'src\lib\schema\storm.schema.register.pas',
  storm.query.interfaces in 'src\lib\query\storm.query.interfaces.pas',
  storm.query in 'src\lib\query\storm.query.pas',
  uORMProduto in 'src\teste\uORMProduto.pas';

procedure WriteJson(obj : TJSONObject);
begin
  writeln(obj.ToString);
end;

procedure WriteJsonValue(obj : TJSONValue);
begin
  writeln(obj.ToString);
end;


VAR
  query : TORMProduto;
  stop : string;
  sql : string;
begin
  ReportMemoryLeaksOnShutdown := true;
  try
    SchemaRegister.RegisterSchema(TProduto, TSchemaProduto.Create);

    query := TORMProduto.Create;

    sql :=
    query
      .Select
      .Only([Codigo, Descricao])
      .Where
      .Codigo.EqualsTo('1')
      .Or_
      .Codigo.EqualsTo('2')
      .SQL;


    writeln(sql);

    Readln(stop);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
