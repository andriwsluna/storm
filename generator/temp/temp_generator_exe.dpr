program temp_generator_exe;

uses
  Vcl.Forms,
  temp_generator in 'temp_generator.pas' {Form2},
  storm.generator in '..\src\storm.generator.pas',
  storm.generator.sql in '..\src\storm.generator.sql.pas',
  storm.generator.consts in '..\src\storm.generator.consts.pas',
  storm.generator.utils in '..\src\storm.generator.utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
