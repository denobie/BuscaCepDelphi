object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'BuscaCep - by Guilherme Denobie'
  ClientHeight = 583
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object CEP: TLabel
    Left = 176
    Top = 48
    Width = 21
    Height = 15
    Caption = 'CEP'
  end
  object btnListaEnderecos: TButton
    Left = 120
    Top = 185
    Width = 105
    Height = 25
    Caption = 'Listar Endere'#231'os'
    TabOrder = 0
    OnClick = btnListaEnderecosClick
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 406
    Width = 624
    Height = 177
    Align = alBottom
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'codigo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cep'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'logradouro'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'complemento'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'unidade'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'bairro'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'localidade'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'uf'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'regiao'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'codigo_ibge'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'codigo_gia'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ddd'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'siafi'
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 231
    Top = 185
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object btnBuscarCEP: TButton
    Left = 312
    Top = 185
    Width = 75
    Height = 25
    Caption = 'Buscar CEP'
    TabOrder = 3
    OnClick = btnBuscarCEPClick
  end
  object mmResultados: TMemo
    Left = 0
    Top = 248
    Width = 624
    Height = 158
    Align = alBottom
    TabOrder = 4
  end
  object rgTipoRetorno: TRadioGroup
    Left = 176
    Top = 112
    Width = 185
    Height = 49
    Caption = 'Tipo Retorno: '
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'JSON'
      'XML')
    TabOrder = 5
  end
  object edtCEP: TEdit
    Left = 176
    Top = 69
    Width = 121
    Height = 23
    NumbersOnly = True
    TabOrder = 6
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = tbEndereco
    Left = 496
    Top = 464
  end
  object tbEndereco: TFDTable
    IndexFieldNames = 'codigo'
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'endereco'
    Left = 432
    Top = 456
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 8
    Top = 8
  end
end
