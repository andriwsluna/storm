object vcl_form: Tvcl_form
  Left = 0
  Top = 0
  Caption = 'vcl_form'
  ClientHeight = 548
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 768
    Top = 251
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object SpeedButton1: TSpeedButton
    Left = 247
    Top = 304
    Width = 23
    Height = 22
    Caption = 'x'
    OnClick = SpeedButton1Click
  end
  object Button1: TButton
    Left = 40
    Top = 41
    Width = 75
    Height = 25
    Caption = 'Select'
    TabOrder = 0
    OnClick = Button1Click
  end
  object memosql: TMemo
    Left = 144
    Top = 8
    Width = 700
    Height = 105
    Lines.Strings = (
      'memosql')
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 360
    Width = 852
    Height = 188
    Align = alBottom
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'codigo_produto'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Alignment = taCenter
        Title.Caption = 'Descri'#231#227'o'
        Width = 200
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'codigo_marca'
        Title.Alignment = taCenter
        Title.Caption = 'Marca'
        Width = 50
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'preco'
        Title.Alignment = taCenter
        Title.Caption = 'Pre'#231'o'
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ativo'
        Title.Alignment = taCenter
        Width = 60
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'data_criacao'
        Title.Alignment = taCenter
        Title.Caption = 'Cria'#231#227'o'
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'data_alteracao'
        Title.Alignment = taCenter
        Title.Caption = 'Altera'#231#227'o'
        Width = 100
        Visible = True
      end>
  end
  object Button2: TButton
    Left = 40
    Top = 97
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 3
    OnClick = Button2Click
  end
  object MemoJson: TMemo
    Left = 144
    Top = 119
    Width = 700
    Height = 105
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object EditCodigo: TEdit
    Left = 144
    Top = 248
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object EditDescricao: TEdit
    Left = 288
    Top = 248
    Width = 121
    Height = 21
    TabOrder = 6
  end
  object Button3: TButton
    Left = 40
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Insert'
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 40
    Top = 167
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 8
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 207
    Width = 121
    Height = 25
    Caption = 'Select By ID'
    TabOrder = 9
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 48
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Button6'
    TabOrder = 10
    OnClick = Button6Click
  end
  object EditCodigoMarca: TEdit
    Left = 424
    Top = 248
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 11
  end
  object EditPreco: TEdit
    Left = 584
    Top = 248
    Width = 121
    Height = 21
    TabOrder = 12
  end
  object RadioGroup: TRadioGroup
    Left = 144
    Top = 288
    Width = 97
    Height = 38
    Caption = 'ESt'#225' ativo ?'
    TabOrder = 13
  end
  object RadioButtonSim: TRadioButton
    Left = 152
    Top = 306
    Width = 41
    Height = 17
    Caption = 'Sim'
    TabOrder = 14
  end
  object RadioButtonNao: TRadioButton
    Left = 199
    Top = 306
    Width = 38
    Height = 17
    Caption = 'N'#227'o'
    TabOrder = 15
  end
  object EditDataCriacao: TMaskEdit
    Left = 288
    Top = 304
    Width = 121
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 16
    Text = '  /  /    '
  end
  object EditDataAlteracao: TMaskEdit
    Left = 427
    Top = 304
    Width = 118
    Height = 21
    EditMask = '!00/00/0000 00:00:00;1;_'
    MaxLength = 19
    TabOrder = 17
    Text = '  /  /       :  :  '
  end
  object Button7: TButton
    Left = 8
    Top = 238
    Width = 121
    Height = 25
    Caption = 'Update By Entity'
    TabOrder = 18
    OnClick = Button7Click
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=admserver01;Persist Security Info=T' +
      'rue;User ID=sa;Initial Catalog=banco_de_testes;Data Source=sql_s' +
      'erver'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 632
    Top = 304
  end
  object DataSource1: TDataSource
    Left = 304
    Top = 440
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=bancodetestes'
      'User_Name=sa'
      'Password=S@geBr.2014'
      'Port=5003'
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 480
    Top = 312
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = '.\libmysql.dll'
    Left = 328
    Top = 296
  end
end
