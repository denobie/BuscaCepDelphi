unit Forms.DadosCep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Interfaces.Interfaces, FireDAC.Comp.Client;

type
  TFrmDadosCEP = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    edtCodigo: TEdit;
    Label2: TLabel;
    edtCEP: TEdit;
    Label3: TLabel;
    edtLogradouro: TEdit;
    Label4: TLabel;
    edtComplemento: TEdit;
    Label5: TLabel;
    edtUnidade: TEdit;
    Label6: TLabel;
    edtBairro: TEdit;
    Label7: TLabel;
    edtUf: TEdit;
    Label8: TLabel;
    edtLocalidade: TEdit;
    Label9: TLabel;
    edtRegiao: TEdit;
    Label10: TLabel;
    edtCodIBGE: TEdit;
    Label11: TLabel;
    edtCodGIA: TEdit;
    Label12: TLabel;
    edtDDD: TEdit;
    Label13: TLabel;
    edtCodSIAFI: TEdit;
    Panel2: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetDadosCEP(ADadosCEP: iDadosCEP);
  end;

var
  FrmDadosCEP: TFrmDadosCEP;

implementation

{$R *.dfm}

{ TFrmDadosCEP }

procedure TFrmDadosCEP.SetDadosCEP(ADadosCEP: iDadosCEP);
begin
  edtCodigo.Text      := ADadosCEP.Codigo.ToString;
  edtCEP.Text         := ADadosCEP.CEP;
  edtLogradouro.Text  := ADadosCEP.Logradouro;
  edtComplemento.Text := ADadosCEP.Complemento;
  edtUnidade.Text     := ADadosCEP.Unidade;
  edtBairro.Text      := ADadosCEP.Bairro;
  edtUf.Text          := ADadosCEP.Uf;
  edtLocalidade.Text  := ADadosCEP.Localidade;
  edtRegiao.Text      := ADadosCEP.Regiao;
  edtCodIBGE.Text     := ADadosCEP.IBGE.ToString;
  edtCodGIA.Text      := ADadosCEP.Gia;
  edtDDD.Text         := ADadosCEP.DDD.ToString;
  edtCodSIAFI.Text    := ADadosCEP.Siafi;
end;

end.
