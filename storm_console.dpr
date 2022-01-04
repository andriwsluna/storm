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
  uEntityProduto in 'src\teste\uEntityProduto.pas';

procedure PrintField(field : IStormField);
begin
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
end;

procedure testeEntity(entity : IStormEntity);
begin
  entity.ToJSON(true).Map
  (
    procedure(json : Tjsonobject)
    begin
      writeln(json.ToString);
    end
  );
end;

type TFunctPrintJson = reference to procedure(json : Tjsonobject);
VAR
  stop : string;
  produto : TProduto;
begin
  ReportMemoryLeaksOnShutdown := true;
  try
    produto := TProduto.Create;
    produto.Codigo.Value.SetValue('SKU0897');
    produto.Descricao.Value.SetValue('Farinha de mandioca');

    testeEntity(produto);

    Readln(stop);

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
