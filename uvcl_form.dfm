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
  Position = poDesktopCenter
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
    Height = 233
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
    Left = 64
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
    OnClick = Button2Click
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=S@geBr.2014;Persist Security Info=T' +
      'rue;User ID=sa;Initial Catalog=BancoDeTestes;Data Source=127.0.0' +
      '.1'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 696
    Top = 336
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 696
    Top = 384
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 304
    Top = 440
  end
end
