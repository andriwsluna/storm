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
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
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
    Font.Quality = fqClearTypeNatural
    TabOrder = 0
    CodeFolding.ShowCollapsedLine = True
    UseCodeFolding = False
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.Font.Quality = fqClearTypeNatural
    Gutter.Bands = <
      item
        Kind = gbkMarks
        Width = 13
      end
      item
        Kind = gbkLineNumbers
      end
      item
        Kind = gbkFold
      end
      item
        Kind = gbkTrackChanges
      end
      item
        Kind = gbkMargin
        Width = 3
      end>
    Highlighter = SynPasSyn1
    ReadOnly = True
    SelectedColor.Alpha = 0.400000005960464500
  end
  object Panel1: TPanel
    Left = 977
    Top = 0
    Width = 370
    Height = 662
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
    object Button1: TButton
      Left = 224
      Top = 48
      Width = 106
      Height = 25
      Caption = 'GenerateEntity'
      TabOrder = 0
      OnClick = Button1Click
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 104
      Width = 368
      Height = 557
      Align = alBottom
      DataSource = DataSource1
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'schema_name'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'table_name'
          Width = 200
          Visible = True
        end>
    end
    object Button2: TButton
      Left = 24
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Get Tables'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 56
      Top = 72
      Width = 75
      Height = 25
      Caption = 'Button3'
      TabOrder = 3
      OnClick = Button3Click
    end
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=S@geBr.2014;Persist Security Info=T' +
      'rue;User ID=sa;Initial Catalog=Minha_Gestao_Contabil;Data Source' +
      '=mssql;Use Procedure for Prepare=1;Auto Translate=True;Packet Si' +
      'ze=4096;Workstation ID=LO-0197-NB;Use Encryption for Data=False;' +
      'Tag with column collation when possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 1168
    Top = 160
  end
  object QyColumns: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'schema'
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 128
        Value = Null
      end
      item
        Name = 'table'
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 128
        Value = Null
      end>
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
      's.name= :schema'
      'and'
      't.name  = :table')
    Left = 1240
    Top = 280
  end
  object SynPasSyn1: TSynPasSyn
    IdentifierAttri.Foreground = clBlack
    KeyAttri.Foreground = clHotLight
    SymbolAttri.Foreground = clHotLight
    Left = 736
    Top = 184
  end
  object QyTable: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      's.name  as schema_name ,'
      't.name as table_name'
      'FROM sys.tables t '
      'join sys.schemas s '
      'on t.schema_id = s.schema_id '
      'order by s.name, t.name '
      '')
    Left = 1112
    Top = 280
  end
  object DataSource1: TDataSource
    DataSet = QyTable
    Left = 1048
    Top = 352
  end
end
