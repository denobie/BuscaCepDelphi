object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'BuscaCep - by Guilherme Denobie'
  ClientHeight = 325
  ClientWidth = 844
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pgControl: TPageControl
    Left = 0
    Top = 0
    Width = 844
    Height = 325
    ActivePage = tsConsultarCEP
    Align = alClient
    TabOrder = 0
    object tsConsultarCEP: TTabSheet
      Caption = 'Buscar CEP'
      object CEP: TLabel
        Left = 294
        Top = 110
        Width = 21
        Height = 15
        Caption = 'CEP'
      end
      object btnConsultarCEP: TButton
        Left = 299
        Top = 160
        Width = 116
        Height = 25
        Hint = 'Consultar CEP na api do ViaCep.com.br'
        Caption = 'Consultar CEP'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnConsultarCEPClick
      end
      object rgTipoRetorno: TRadioGroup
        Left = 421
        Top = 119
        Width = 121
        Height = 35
        Caption = 'Tipo Retorno: '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'JSON'
          'XML')
        TabOrder = 1
      end
      object edtCEP: TEdit
        Left = 294
        Top = 131
        Width = 121
        Height = 23
        NumbersOnly = True
        TabOrder = 2
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 836
        Height = 41
        Align = alTop
        BevelInner = bvLowered
        Caption = 'Consultar CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object btnListarCEP: TButton
        Left = 421
        Top = 160
        Width = 105
        Height = 25
        Hint = 'Listar os Dados do CEP j'#225' Cadastrado no Sistema.'
        Caption = 'Listar CEP'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = btnListarCEPClick
      end
    end
    object tsEndereco: TTabSheet
      Caption = 'Buscar Endere'#231'o'
      ImageIndex = 2
      object Label1: TLabel
        Left = 245
        Top = 60
        Width = 14
        Height = 15
        Caption = 'UF'
      end
      object Label2: TLabel
        Left = 245
        Top = 110
        Width = 37
        Height = 15
        Caption = 'Cidade'
      end
      object Label3: TLabel
        Left = 245
        Top = 160
        Width = 49
        Height = 15
        Caption = 'Endere'#231'o'
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 836
        Height = 41
        Align = alTop
        BevelInner = bvLowered
        Caption = 'Consultar CEP por Endere'#231'o Completo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edtCidade: TEdit
        Left = 245
        Top = 131
        Width = 345
        Height = 23
        TabOrder = 1
      end
      object edtEndereco: TEdit
        Left = 245
        Top = 181
        Width = 345
        Height = 23
        TabOrder = 2
      end
      object btnConsultarEndereco: TButton
        Left = 301
        Top = 210
        Width = 105
        Height = 25
        Hint = 'Consultar Endere'#231'o na api do ViaCep.com.br'
        Caption = 'Consultar CEPs'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = btnConsultarEnderecoClick
      end
      object cbUf: TComboBox
        Left = 245
        Top = 81
        Width = 169
        Height = 23
        ItemIndex = 17
        TabOrder = 4
        Text = 'PR '#8211' Paran'#225
        Items.Strings = (
          'AC '#8211' Acre'
          'AL '#8211' Alagoas'
          'AM '#8211' Amazonas'
          'AP '#8211' Amap'#225
          'BA '#8211' Bahia'
          'CE '#8211' Cear'#225
          'DF '#8211' Distrito Federal'
          'ES '#8211' Esp'#237'rito Santo'
          'GO '#8211' Goi'#225's'
          'MA '#8211' Maranh'#227'o'
          'MG '#8211' Minas Gerais'
          'MS '#8211' Mato Grosso do Sul'
          'MT '#8211' Mato Grosso'
          'PA '#8211' Par'#225
          'PB '#8211' Para'#237'ba'
          'PE '#8211' Pernambuco'
          'PI '#8211' Piau'#237
          'PR '#8211' Paran'#225
          'RJ '#8211' Rio de Janeiro'
          'RN '#8211' Rio Grande do Norte'
          'RO '#8211' Rond'#244'nia'
          'RR '#8211' Roraima'
          'RS '#8211' Rio Grande do Sul'
          'SC '#8211' Santa Catarina'
          'SE '#8211' Sergipe'
          'SP '#8211' S'#227'o Paulo'
          'TO '#8211' Tocantins')
      end
      object rgTipoRetorno2: TRadioGroup
        Left = 420
        Top = 69
        Width = 169
        Height = 35
        Caption = 'Tipo Retorno: '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'JSON'
          'XML')
        TabOrder = 5
      end
      object btnListarPorEndereco: TButton
        Left = 412
        Top = 210
        Width = 105
        Height = 25
        Hint = 
          'Listar os Dados do Endere'#231'os, de Acordo com o Filtro, j'#225' Cadastr' +
          'ados no Sistema.'
        Caption = 'Listar Endere'#231'os'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = btnListarPorEnderecoClick
      end
    end
    object tsCEPs: TTabSheet
      Caption = 'CEPs Cadastrados'
      ImageIndex = 1
      object dgDados: TDBGrid
        Left = 0
        Top = 41
        Width = 836
        Height = 213
        Align = alClient
        DataSource = ds1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        PopupMenu = PopupMenu1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDblClick = dgDadosDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'codigo'
            Title.Caption = 'C'#243'd.'
            Width = 36
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cep'
            Title.Caption = 'CEP'
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'logradouro'
            Title.Caption = 'Logradouro'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'bairro'
            Title.Caption = 'Bairro'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'localidade'
            Title.Caption = 'Cidade'
            Width = 130
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'uf'
            Title.Caption = 'UF'
            Width = 36
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'complemento'
            Title.Caption = 'Complemento'
            Width = 130
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'regiao'
            Title.Caption = 'Regi'#227'o'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'codigo_ibge'
            Title.Caption = 'C'#243'd. IBGE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'codigo_gia'
            Title.Caption = 'C'#243'd. GIA'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ddd'
            Title.Caption = 'DDD'
            Width = 36
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'siafi'
            Title.Caption = 'C'#243'd. Siafi'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'unidade'
            Title.Caption = 'Unidade'
            Visible = True
          end>
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 836
        Height = 41
        Align = alTop
        BevelInner = bvLowered
        Caption = 'Endere'#231'os Cadastrados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object Panel4: TPanel
        Left = 0
        Top = 254
        Width = 836
        Height = 41
        Align = alBottom
        TabOrder = 2
        object Label4: TLabel
          Left = 8
          Top = 5
          Width = 232
          Height = 15
          Caption = 'Duplo Clique para Abrir Dados do Endere'#231'o.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBrown
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 8
          Top = 22
          Width = 272
          Height = 15
          Caption = 'Clique com Bot'#227'o Direito para Excluir um Endere'#231'o.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBrown
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object btnListaEnderecos: TButton
          Left = 314
          Top = 8
          Width = 156
          Height = 25
          Caption = 'Listar Todos Endere'#231'os'
          TabOrder = 0
          OnClick = btnListaEnderecosClick
        end
      end
    end
  end
  object ds1: TDataSource
    AutoEdit = False
    DataSet = qryDados
    Left = 64
    Top = 64
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 64
    Top = 176
  end
  object qryDados: TFDQuery
    Left = 68
    Top = 114
  end
  object PopupMenu1: TPopupMenu
    Left = 804
    Top = 34
    object miExcluirEndereco: TMenuItem
      Action = acExcluirEndereco
    end
  end
  object ActionList1: TActionList
    Left = 716
    Top = 34
    object acExcluirEndereco: TAction
      Caption = 'Excluir Endere'#231'o'
      OnExecute = acExcluirEnderecoExecute
    end
  end
end
