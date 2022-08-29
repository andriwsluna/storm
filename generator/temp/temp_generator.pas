unit temp_generator;

interface

uses
  System.Generics.Collections,
  storm.generator.sql,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  SynEditHighlighter, SynHighlighterPas, SynEdit, SynEditCodeFolding, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    ADOConnection1: TADOConnection;
    QyColumns: TADOQuery;
    Button1: TButton;
    SynEdit: TSynEdit;
    SynPasSyn1: TSynPasSyn;
    QyTable: TADOQuery;
    DataSource1: TDataSource;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
VAR
  col : IDBColumn;
  table : IDBTable;
begin
  table := newDbTable(QyTable);
  QyColumns.Parameters.ParamByName('schema').Value := QyTable.FieldByName('schema_name').value;
  QyColumns.Parameters.ParamByName('table').Value := QyTable.FieldByName('table_name').value;
  QyColumns.Open();



  while not QyColumns.Eof do
  begin
    table.AddColumn(NewDbColumn(QyColumns));
    QyColumns.Next;
  end;

  SynEdit.Text := table.GetSchemaFile();


  QyColumns.Close;


end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  QyTable.Open();
end;

end.
