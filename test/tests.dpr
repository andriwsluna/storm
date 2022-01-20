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
  storm.values.str.test in 'src\lib\values\storm.values.str.test.pas',
  storm.values.int.test in 'src\lib\values\storm.values.int.test.pas',
  storm.values.float.test in 'src\lib\values\storm.values.float.test.pas',
  storm.values.bool.test in 'src\lib\values\storm.values.bool.test.pas',
  storm.values.datetime.test in 'src\lib\values\storm.values.datetime.test.pas',
  storm.values.date.test in 'src\lib\values\storm.values.date.test.pas',
  storm.fields.base.test in 'src\lib\fields\storm.fields.base.test.pas',
  storm.fields.str.test in 'src\lib\fields\storm.fields.str.test.pas' {/storm.fields.int.test in 'src\lib\fields\storm.fields.int.test.pas';},
  storm.fields.int.test in 'src\lib\fields\storm.fields.int.test.pas',
  storm.fields.float.test in 'src\lib\fields\storm.fields.float.test.pas';

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
