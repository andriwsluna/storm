unit temp_generator;

interface

uses
  System.Generics.Collections,
  storm.generator.sql,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  SynEditHighlighter, SynHighlighterPas, SynEdit;

type
  TForm2 = class(TForm)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    Button1: TButton;
    SynEdit: TSynEdit;
    SynPasSyn1: TSynPasSyn;
    procedure Button1Click(Sender: TObject);
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
  table := newDbTable;
  ADOQuery1.Open();

  while not ADOQuery1.Eof do
  begin
    table.AddColumn(NewDbColumn(ADOQuery1));
    ADOQuery1.Next;
  end;

  for col in  table.Getcolumns do
  begin
    SynEdit.Lines.Add(col.GetEntityFieldDeclaration());
  end;

  SynEdit.Lines.Add('');

  for col in  table.Getcolumns do
  begin
    SynEdit.Lines.Add(col.GetEntityProtectedFieldDeclaration());
  end;





  ADOQuery1.Close;


end;

end.
