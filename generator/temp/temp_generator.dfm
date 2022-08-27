object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 662
  ClientWidth = 1347
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 1144
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object SynEdit: TSynEdit
    Left = 0
    Top = 0
    Width = 977
    Height = 662
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 1
    CodeFolding.CollapsedLineColor = clGrayText
    CodeFolding.FolderBarLinesColor = clGrayText
    CodeFolding.ShowCollapsedLine = True
    CodeFolding.IndentGuidesColor = clGray
    CodeFolding.IndentGuides = True
    UseCodeFolding = False
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Highlighter = SynPasSyn1
    ReadOnly = True
    FontSmoothing = fsmNone
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=S@geBr.2014;Persist Security Info=T' +
      'rue;User ID=sa;Initial Catalog=BancoDeTestes;Data Source=mssql'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 1168
    Top = 160
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      's.name  as schema_name ,'
      't.name as table_name,'
      'c.column_id,'
      'c.name  as column_name,'
      'c.system_type_id as type_id,'
      'c.max_length,'
      'c.[precision], '
      'c.[scale],'
      'c.is_nullable,'
      'c.is_identity,'
      'c.object_id,'
      'CAST(CASE  '
      #9'when ku.TABLE_NAME = t.name then 1 else 0'
      'END as bit) as is_primarykey'
      'FROM sys.tables t '
      'join sys.schemas s '
      'on t.schema_id = s.schema_id '
      'JOIN SYS.columns c '
      'ON t.object_id = c.object_id '
      'left join INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc'
      'on t.name = tc.TABLE_NAME'
      'left JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS ku'
      'ON tc.CONSTRAINT_TYPE = '#39'PRIMARY KEY'#39' '
      'AND tc.CONSTRAINT_NAME = KU.CONSTRAINT_NAME '
      'and ku.CONSTRAINT_SCHEMA = s.name '
      'AND ku.table_name= t.name'
      'and ku.COLUMN_NAME  = c.name '
      'WHERE '
      't.name  = '#39'produto'#39)
    Left = 1240
    Top = 280
  end
  object SynPasSyn1: TSynPasSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    IdentifierAttri.Foreground = clBlack
    KeyAttri.Foreground = clHotLight
    SymbolAttri.Foreground = clHotLight
    Left = 736
    Top = 184
  end
end
