object vcl_form: Tvcl_form
  Left = 0
  Top = 0
  Caption = 'p'
  ClientHeight = 661
  ClientWidth = 1100
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
  object Label2: TLabel
    Left = 152
    Top = 230
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object Label3: TLabel
    Left = 288
    Top = 230
    Width = 46
    Height = 13
    Caption = 'Descri'#231#227'o'
  end
  object Label4: TLabel
    Left = 433
    Top = 230
    Width = 29
    Height = 13
    Caption = 'Marca'
  end
  object Label5: TLabel
    Left = 608
    Top = 230
    Width = 27
    Height = 13
    Caption = 'Pre'#231'o'
  end
  object Button1: TButton
    Left = 8
    Top = 8
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
    Top = 473
    Width = 1100
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
    Left = 8
    Top = 39
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
    NumbersOnly = True
    TabOrder = 5
    Text = '0'
  end
  object EditDescricao: TEdit
    Left = 288
    Top = 248
    Width = 121
    Height = 21
    TabOrder = 6
  end
  object Button3: TButton
    Left = 8
    Top = 70
    Width = 75
    Height = 25
    Caption = 'Insert'
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 101
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
    Left = 8
    Top = 269
    Width = 121
    Height = 25
    Caption = 'Insert By Entity'
    TabOrder = 10
    OnClick = Button6Click
  end
  object RadioGroup: TRadioGroup
    Left = 144
    Top = 288
    Width = 97
    Height = 38
    Caption = 'ESt'#225' ativo ?'
    TabOrder = 11
  end
  object RadioButtonSim: TRadioButton
    Left = 152
    Top = 306
    Width = 41
    Height = 17
    Caption = 'Sim'
    TabOrder = 12
  end
  object RadioButtonNao: TRadioButton
    Left = 199
    Top = 306
    Width = 38
    Height = 17
    Caption = 'N'#227'o'
    TabOrder = 13
  end
  object EditDataCriacao: TMaskEdit
    Left = 288
    Top = 304
    Width = 121
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 14
    Text = '  /  /    '
  end
  object EditDataAlteracao: TMaskEdit
    Left = 427
    Top = 304
    Width = 118
    Height = 21
    EditMask = '!00/00/0000 00:00:00;1;_'
    MaxLength = 19
    TabOrder = 15
    Text = '  /  /       :  :  '
  end
  object Button7: TButton
    Left = 8
    Top = 238
    Width = 121
    Height = 25
    Caption = 'Update By Entity'
    TabOrder = 16
    OnClick = Button7Click
  end
  object ComboBoxMarca: TComboBox
    Left = 433
    Top = 248
    Width = 104
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 17
    Text = '1'
    Items.Strings = (
      '1'
      '2'
      '3'
      '4')
  end
  object EditPreco: TMaskEdit
    Left = 608
    Top = 249
    Width = 112
    Height = 21
    EditMask = '9,99;1; '
    MaxLength = 4
    TabOrder = 18
    Text = ' ,  '
  end
  object Button8: TButton
    Left = 8
    Top = 300
    Width = 121
    Height = 25
    Caption = 'Delete By Entity'
    TabOrder = 19
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 8
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Select Limit'
    TabOrder = 20
    OnClick = Button9Click
  end
  object EditLimit: TEdit
    Left = 8
    Top = 175
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 21
    Text = '2'
  end
  object Button10: TButton
    Left = 8
    Top = 344
    Width = 121
    Height = 25
    Caption = 'Select Order BY'
    TabOrder = 22
    OnClick = Button9Click
  end
  object CheckBoxEmpty: TCheckBox
    Left = 608
    Top = 288
    Width = 201
    Height = 17
    Caption = 'Retirar produtos com descri'#231#227'o vazia'
    TabOrder = 23
  end
  object CheckBoxA: TCheckBox
    Left = 608
    Top = 311
    Width = 201
    Height = 17
    Caption = 'Produtos que come'#231'am com A'
    TabOrder = 24
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=MSOLEDBSQL19.1;Password=S@geBr.2014;Persist Security In' +
      'fo=True;User ID=sa;Initial Catalog=BancoDeTestes;Data Source=mss' +
      'ql;Initial File Name="";Use Encryption for Data=Optional;Trust S' +
      'erver Certificate=True;Server SPN="";Authentication="";Access To' +
      'ken="";Host Name In Certificate=""'
    LoginPrompt = False
    Provider = 'MSOLEDBSQL19.1'
    Left = 536
    Top = 344
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    OnDataChange = DataSource1DataChange
    Left = 312
    Top = 416
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Password=S@geBr.2014'
      'Server=localhost'
      'User_Name=sa'
      'Port=5003'
      'Database=bancodetestes'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 544
    Top = 400
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = '.\libmysql.dll'
    Left = 736
    Top = 336
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 416
    Top = 408
  end
end
