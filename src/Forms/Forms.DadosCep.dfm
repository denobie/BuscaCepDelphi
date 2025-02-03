object FrmDadosCEP: TFrmDadosCEP
  Left = 0
  Top = 0
  Caption = 'Dados do CEP'
  ClientHeight = 306
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 538
    Height = 306
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 48
      Width = 39
      Height = 15
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 143
      Top = 48
      Width = 21
      Height = 15
      Caption = 'CEP'
    end
    object Label3: TLabel
      Left = 16
      Top = 98
      Width = 62
      Height = 15
      Caption = 'Logradouro'
    end
    object Label4: TLabel
      Left = 16
      Top = 248
      Width = 77
      Height = 15
      Caption = 'Complemento'
    end
    object Label5: TLabel
      Left = 16
      Top = 198
      Width = 44
      Height = 15
      Caption = 'Unidade'
    end
    object Label6: TLabel
      Left = 270
      Top = 98
      Width = 31
      Height = 15
      Caption = 'Bairro'
    end
    object Label7: TLabel
      Left = 270
      Top = 148
      Width = 14
      Height = 15
      Caption = 'UF'
    end
    object Label8: TLabel
      Left = 16
      Top = 148
      Width = 37
      Height = 15
      Caption = 'Cidade'
    end
    object Label9: TLabel
      Left = 400
      Top = 148
      Width = 36
      Height = 15
      Caption = 'Regi'#227'o'
    end
    object Label10: TLabel
      Left = 270
      Top = 48
      Width = 66
      Height = 15
      Caption = 'C'#243'digo IBGE'
    end
    object Label11: TLabel
      Left = 143
      Top = 198
      Width = 61
      Height = 15
      Caption = 'C'#243'digo GIA'
    end
    object Label12: TLabel
      Left = 270
      Top = 198
      Width = 24
      Height = 15
      Caption = 'DDD'
    end
    object Label13: TLabel
      Left = 397
      Top = 198
      Width = 68
      Height = 15
      Caption = 'C'#243'digo SIAFI'
    end
    object edtCodigo: TEdit
      Left = 16
      Top = 69
      Width = 121
      Height = 23
      ReadOnly = True
      TabOrder = 0
    end
    object edtCEP: TEdit
      Left = 143
      Top = 69
      Width = 121
      Height = 23
      ReadOnly = True
      TabOrder = 1
    end
    object edtLogradouro: TEdit
      Left = 16
      Top = 119
      Width = 248
      Height = 23
      ReadOnly = True
      TabOrder = 2
    end
    object edtComplemento: TEdit
      Left = 16
      Top = 269
      Width = 502
      Height = 23
      ReadOnly = True
      TabOrder = 3
    end
    object edtUnidade: TEdit
      Left = 16
      Top = 219
      Width = 121
      Height = 23
      ReadOnly = True
      TabOrder = 4
    end
    object edtBairro: TEdit
      Left = 270
      Top = 119
      Width = 248
      Height = 23
      ReadOnly = True
      TabOrder = 5
    end
    object edtUf: TEdit
      Left = 270
      Top = 169
      Width = 118
      Height = 23
      ReadOnly = True
      TabOrder = 6
    end
    object edtLocalidade: TEdit
      Left = 16
      Top = 169
      Width = 248
      Height = 23
      ReadOnly = True
      TabOrder = 7
    end
    object edtRegiao: TEdit
      Left = 400
      Top = 169
      Width = 118
      Height = 23
      ReadOnly = True
      TabOrder = 8
    end
    object edtCodIBGE: TEdit
      Left = 270
      Top = 69
      Width = 121
      Height = 23
      ReadOnly = True
      TabOrder = 9
    end
    object edtCodGIA: TEdit
      Left = 143
      Top = 219
      Width = 121
      Height = 23
      ReadOnly = True
      TabOrder = 10
    end
    object edtDDD: TEdit
      Left = 270
      Top = 219
      Width = 121
      Height = 23
      ReadOnly = True
      TabOrder = 11
    end
    object edtCodSIAFI: TEdit
      Left = 397
      Top = 219
      Width = 121
      Height = 23
      ReadOnly = True
      TabOrder = 12
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 536
      Height = 41
      Align = alTop
      BevelInner = bvLowered
      Caption = 'Dados do Endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
    end
  end
end
