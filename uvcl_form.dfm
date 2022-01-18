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
  object Button1: TButton
    Left = 40
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Button1'
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
  end
  object Button2: TButton
    Left = 128
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
  end
  object MemoJson: TMemo
    Left = 144
    Top = 119
    Width = 700
    Height = 105
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object Edit1: TEdit
    Left = 264
    Top = 248
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object Edit2: TEdit
    Left = 408
    Top = 248
    Width = 121
    Height = 21
    TabOrder = 6
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
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 800
    Top = 264
  end
  object FDMemTable2: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 568
    Top = 240
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
    VendorLib = 'R:\external\storm\dll\32\libmysql.dll'
    Left = 328
    Top = 296
  end
end
