program storm_console;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  storm.values.interfaces,
  storm.values.str,
  storm.fields.str,
  System.JSON,
  System.SysUtils,
  storm.fields.interfaces,
  storm.fields.base;



VAR
  stop : string;
  field : TStringField;
begin
  ReportMemoryLeaksOnShutdown := true;
  try
    field := TStringField.Create('codigo_produto');
    field.Value.SetValue('aloha');

    field.ToJSON(true).Map
    (
      procedure(json : TJSONPair)
      begin
        writeln(json.ToString);
      end,
      procedure
      begin
        writeln('no json');
      end
    );


    Readln(stop);

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
