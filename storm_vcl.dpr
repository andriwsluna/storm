program storm_vcl;

uses
  Vcl.Forms,
  uvcl_form in 'uvcl_form.pas' {vcl_form},
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
  //storm.schema.register in 'src\lib\schema\storm.schema.register.pas',
  uORMProduto in 'src\teste\uORMProduto.pas',
  storm.orm.base in 'src\lib\orm\storm.orm.base.pas',
  storm.orm.interfaces in 'src\lib\orm\storm.orm.interfaces.pas',
  storm.orm.where in 'src\lib\orm\storm.orm.where.pas',
  storm.orm.query in 'src\lib\orm\storm.orm.query.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := true;
  Application.MainFormOnTaskbar := True;
  //SchemaRegister.RegisterSchema(TProduto, TSchemaProduto.Create);
  Application.CreateForm(Tvcl_form, vcl_form);
  Application.Run;
end.