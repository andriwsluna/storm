program storm_vcl;

uses
  Vcl.Forms,
  uvcl_form in 'uvcl_form.pas' {vcl_form},
  storm.schema.table in '..\..\src\lib\schema\storm.schema.table.pas',
  storm.schema.column in '..\..\src\lib\schema\storm.schema.column.pas',
  storm.schema.types in '..\..\src\lib\schema\storm.schema.types.pas',
  storm.schema.interfaces in '..\..\src\lib\schema\storm.schema.interfaces.pas',
  storm.data.driver.ado in '..\..\src\drivers\storm.data.driver.ado.pas',
  storm.data.driver.firedac in '..\..\src\drivers\storm.data.driver.firedac.pas',
  storm.data.driver.mysql in '..\..\src\drivers\storm.data.driver.mysql.pas',
  storm.data.driver.mssql in '..\..\src\drivers\storm.data.driver.mssql.pas',
  DFE.Interfaces in '..\..\..\Delphi-Functional-Extensions\src\DFE.Interfaces.pas',
  DFE.Iterator in '..\..\..\Delphi-Functional-Extensions\src\DFE.Iterator.pas',
  DFE.Maybe in '..\..\..\Delphi-Functional-Extensions\src\DFE.Maybe.pas',
  DFE.Result in '..\..\..\Delphi-Functional-Extensions\src\DFE.Result.pas',
  storm.values.base in '..\..\src\lib\values\storm.values.base.pas',
  storm.values.bool in '..\..\src\lib\values\storm.values.bool.pas',
  storm.values.date in '..\..\src\lib\values\storm.values.date.pas',
  storm.values.datetime in '..\..\src\lib\values\storm.values.datetime.pas',
  storm.values.float in '..\..\src\lib\values\storm.values.float.pas',
  storm.values.int in '..\..\src\lib\values\storm.values.int.pas',
  storm.values.interfaces in '..\..\src\lib\values\storm.values.interfaces.pas',
  storm.values.str in '..\..\src\lib\values\storm.values.str.pas',
  storm.orm.base in '..\..\src\lib\orm\storm.orm.base.pas',
  storm.orm.insert in '..\..\src\lib\orm\storm.orm.insert.pas',
  storm.orm.interfaces in '..\..\src\lib\orm\storm.orm.interfaces.pas',
  storm.orm.query in '..\..\src\lib\orm\storm.orm.query.pas',
  storm.orm.update in '..\..\src\lib\orm\storm.orm.update.pas',
  storm.orm.where in '..\..\src\lib\orm\storm.orm.where.pas',
  storm.model.base in '..\..\src\lib\model\storm.model.base.pas',
  storm.model.interfaces in '..\..\src\lib\model\storm.model.interfaces.pas',
  storm.fields.base in '..\..\src\lib\fields\storm.fields.base.pas',
  storm.fields.bool in '..\..\src\lib\fields\storm.fields.bool.pas',
  storm.fields.date in '..\..\src\lib\fields\storm.fields.date.pas',
  storm.fields.datetime in '..\..\src\lib\fields\storm.fields.datetime.pas',
  storm.fields.float in '..\..\src\lib\fields\storm.fields.float.pas',
  storm.fields.int in '..\..\src\lib\fields\storm.fields.int.pas',
  storm.fields.interfaces in '..\..\src\lib\fields\storm.fields.interfaces.pas',
  storm.fields.str in '..\..\src\lib\fields\storm.fields.str.pas',
  storm.fields.utils in '..\..\src\lib\fields\storm.fields.utils.pas',
  storm.entity.base in '..\..\src\lib\entity\storm.entity.base.pas',
  storm.entity.interfaces in '..\..\src\lib\entity\storm.entity.interfaces.pas',
  storm.data.interfaces in '..\..\src\lib\data\storm.data.interfaces.pas',
  storm.dependency.register in '..\..\src\lib\utils\storm.dependency.register.pas',
  uEntityProduto in 'src\storm\entities\uEntityProduto.pas',
  uORMProduto in 'src\storm\orms\uORMProduto.pas',
  uSchemaProduto in 'src\storm\schemas\uSchemaProduto.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := true;
  Application.MainFormOnTaskbar := True;
  //SchemaRegister.RegisterSchema(TProduto, TSchemaProduto.Create);
  Application.CreateForm(Tvcl_form, vcl_form);
  Application.Run;
end.
