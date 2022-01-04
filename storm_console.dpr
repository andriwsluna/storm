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
  storm.model.base in 'src\lib\model\storm.model.base.pas';

procedure PrintField(field : IStormField);
begin
  field.ToJSON(true).Bind
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

procedure WriteJson(obj : TJSONObject);
begin
  writeln(obj.ToString);
end;

procedure WriteJsonValue(obj : TJSONValue);
begin
  writeln(obj.ToString);
end;

procedure EntityToJson(entity : IStormEntity);
begin
  entity
    .ToJSON(false)
      .Bind(WriteJson);
end;



type TFunctPrintJson = reference to procedure(json : Tjsonobject);
VAR
  stop : string;
  produto : TProduto;
  produto2 : TProduto;
  model : TStormModel<TProduto>;
  p: TProduto;
begin
  ReportMemoryLeaksOnShutdown := true;
  try
    produto := TProduto.Create;

    produto.Codigo.Value.SetValue('SKU0897');
    produto.Descricao.value.SetValue('Mamadeira de negação');

    produto2 := TProduto.Create;
    produto2.Clone(produto);

    model := TStormModel<TProduto>.Create;
    model.AddRecord(produto);
    model.AddRecord(produto2);


    for p in  model.Records do
    begin
      p
        .ToJSON(true)
          .Bind(WriteJson);
    end;

    Readln(stop);

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
