program tests;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  storm.values.base.test in 'src\lib\values\storm.values.base.test.pas',
  storm.data.interfaces in '..\src\lib\data\storm.data.interfaces.pas',
  storm.entity.base in '..\src\lib\entity\storm.entity.base.pas',
  storm.entity.interfaces in '..\src\lib\entity\storm.entity.interfaces.pas',
  storm.fields.base in '..\src\lib\fields\storm.fields.base.pas',
  storm.fields.interfaces in '..\src\lib\fields\storm.fields.interfaces.pas',
  storm.fields.str in '..\src\lib\fields\storm.fields.str.pas',
  storm.model.base in '..\src\lib\model\storm.model.base.pas',
  storm.model.interfaces in '..\src\lib\model\storm.model.interfaces.pas',
  storm.orm.base in '..\src\lib\orm\storm.orm.base.pas',
  storm.orm.interfaces in '..\src\lib\orm\storm.orm.interfaces.pas',
  storm.orm.query in '..\src\lib\orm\storm.orm.query.pas',
  storm.orm.where in '..\src\lib\orm\storm.orm.where.pas',
  storm.schema.column in '..\src\lib\schema\storm.schema.column.pas',
  storm.schema.interfaces in '..\src\lib\schema\storm.schema.interfaces.pas',
  storm.schema.table in '..\src\lib\schema\storm.schema.table.pas',
  storm.schema.types.base in '..\src\lib\schema\storm.schema.types.base.pas',
  storm.schema.types.varchar in '..\src\lib\schema\storm.schema.types.varchar.pas',
  storm.dependency.register in '..\src\lib\utils\storm.dependency.register.pas',
  storm.values.base in '..\src\lib\values\storm.values.base.pas',
  storm.values.interfaces in '..\src\lib\values\storm.values.interfaces.pas',
  storm.values.str in '..\src\lib\values\storm.values.str.pas';

var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  exit;
{$ENDIF}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //tell the runner how we will log things
    //Log to the console window
    logger := TDUnitXConsoleLogger.Create(true);
    runner.AddLogger(logger);
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);
    runner.FailsOnNoAsserts := False; //When true, Assertions must be made during tests;

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end.
