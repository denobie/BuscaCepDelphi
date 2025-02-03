unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Model.Conexoes.Interfaces, Model.Conexoes.Factory.Conexao, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Interfaces.Interfaces, Interfaces.BuscaCepFactory, Utils.BuscaCEPUtils,
  Forms.DadosCep, Vcl.ComCtrls, Interfaces.EnderecoFactory,
  Interfaces.EnderecosInterfaces, Vcl.Menus, System.Actions, Vcl.ActnList;

type
  TOperacao = (toListar, toAtualizar);

type
  TFrmMain = class(TForm)
    ds1: TDataSource;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    pgControl: TPageControl;
    tsConsultarCEP: TTabSheet;
    tsCEPs: TTabSheet;
    dgDados: TDBGrid;
    CEP: TLabel;
    btnConsultarCEP: TButton;
    rgTipoRetorno: TRadioGroup;
    edtCEP: TEdit;
    Panel2: TPanel;
    Panel1: TPanel;
    tsEndereco: TTabSheet;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCidade: TEdit;
    Label3: TLabel;
    edtEndereco: TEdit;
    btnConsultarEndereco: TButton;
    cbUf: TComboBox;
    rgTipoRetorno2: TRadioGroup;
    qryDados: TFDQuery;
    Panel4: TPanel;
    btnListaEnderecos: TButton;
    btnListarPorEndereco: TButton;
    Label4: TLabel;
    PopupMenu1: TPopupMenu;
    miExcluirEndereco: TMenuItem;
    ActionList1: TActionList;
    acExcluirEndereco: TAction;
    Label5: TLabel;
    btnListarCEP: TButton;
    procedure btnListaEnderecosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnConsultarCEPClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConsultarEnderecoClick(Sender: TObject);
    procedure btnListarPorEnderecoClick(Sender: TObject);
    procedure acExcluirEnderecoExecute(Sender: TObject);
    procedure dgDadosDblClick(Sender: TObject);
    procedure btnListarCEPClick(Sender: TObject);
  private
    { Private declarations }
    FConexao: iConexao;
    FEnderecoService: iEnderecoService;
    function getConexao: TFDConnection;
    function VerificarSeListaOuAtualizaCEP(ATitle: String): TOperacao;

    function ExecutarBuscaCEPFactory(ACEP: String): iDadosCEP;
    function ExecutarBuscaEnderecoFactory(AUf, ACidade, AEndereco: String): iListaDadosCEP;

    procedure ConsultarCEP;
    procedure ConsultarEndereco;
    procedure AtualizarCEP(ACEP:String; ACodigoCEP: Integer);
    procedure AtualizarEnderecos(AUf, ACidade, AEndereco: String);
    procedure ListarEnderecos;
    procedure MostrarDadosCEP(ADadoCEP: iDadosCEP);
    procedure MostrarEnderecos(AUf, ACidade, AEndereco: String);
    procedure IniciarConexaoBD;
    procedure FinalizarConexaoBD;
    procedure ExcluirCEP(ACodigoCEP: Integer);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  Interfaces.DadosCEP, Interfaces.ListaDadosCEP;


{$R *.dfm}
procedure TFrmMain.FormCreate(Sender: TObject);
begin
  IniciarConexaoBD;
  FEnderecoService := TEnderecoFactory.New(FConexao).CriarEnderecoService;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  pgControl.ActivePage := tsConsultarCEP;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FinalizarConexaoBD;
end;

function TFrmMain.getConexao: TFDConnection;
begin
  Result := (FConexao.EndConexao as TFDConnection);
end;

procedure TFrmMain.ConsultarCEP;
var
  vDadosCEP: iDadosCEP;
  vCodigoCEP: Integer;
begin
  TValidacoes.ValidarCEP(edtCEP.Text);

  if FEnderecoService.CEPJaCadastrado(edtCep.Text, vCodigoCEP) then
  begin
    case VerificarSeListaOuAtualizaCEP('CEP Já Cadastrado no Sistema. Deseja Atualizar ou Listar?') of
      toListar: MostrarDadosCEP(FEnderecoService.BuscarPorCEP(edtCEP.Text));
      toAtualizar: AtualizarCEP(edtCEP.Text, vCodigoCEP);
    end;
  end
  else
  begin
    vDadosCEP := ExecutarBuscaCEPFactory(edtCEP.Text);
    FEnderecoService.Inserir(vDadosCEP);
    MostrarDadosCEP(FEnderecoService.BuscarPorCEP(vDadosCEP.CEP));
  end;
end;

procedure TFrmMain.ConsultarEndereco;
var
  vListaDadosCEP: iListaDadosCEP;
  vQtdeCadatros: Integer;
  vUf, vCidade, vEndereco: String;
begin
  vUf := copy(cbUf.Items[cbUf.ItemIndex], 1, 2).Trim;
  vCidade := Trim(edtCidade.Text);
  vEndereco := Trim(edtEndereco.Text);

  TValidacoes.ValidarEndereco(vUf, vCidade, vEndereco);

  if FEnderecoService.EnderecoJaCadastrado(vUf, vCidade, vEndereco, vQtdeCadatros) then
  begin
    case VerificarSeListaOuAtualizaCEP('Endereço Já Cadastrado no Sistema. Deseja Atualizar ou Listar?') of
      toListar: MostrarEnderecos(vUf, vCidade, vEndereco);
      toAtualizar: AtualizarEnderecos(vUf, vCidade, vEndereco);
    end;
  end
  else
  begin
    vListaDadosCEP := FEnderecoService.InserirLista(ExecutarBuscaEnderecoFactory(vUf, vCidade, vEndereco));

    case vListaDadosCEP.Items.Count of
      0 :  MostrarDadosCEP(FEnderecoService.BuscarPorCEP(vListaDadosCEP.Items[0].CEP));
      else MostrarEnderecos(vUf, vCidade, vEndereco);
    end;
  end;
end;

procedure TFrmMain.dgDadosDblClick(Sender: TObject);
begin
  MostrarDadosCEP(FEnderecoService.QryToDadosCEP(qryDados));
end;

procedure TFrmMain.btnConsultarCEPClick(Sender: TObject);
begin
  ConsultarCEP;
end;

procedure TFrmMain.btnConsultarEnderecoClick(Sender: TObject);
begin
  ConsultarEndereco;
end;

procedure TFrmMain.btnListaEnderecosClick(Sender: TObject);
begin
  ListarEnderecos;
end;

procedure TFrmMain.btnListarCEPClick(Sender: TObject);
begin
  TValidacoes.ValidarCEP(edtCEP.Text);

  MostrarDadosCEP(FEnderecoService.BuscarPorCEP(edtCEP.Text));
end;

procedure TFrmMain.btnListarPorEnderecoClick(Sender: TObject);
var
  vUf, vCidade, vEndereco: String;
begin
  vUf := copy(cbUf.Items[cbUf.ItemIndex], 1, 2).Trim;
  vCidade := Trim(edtCidade.Text);
  vEndereco := Trim(edtEndereco.Text);

  TValidacoes.ValidarEndereco(vUf, vCidade, vEndereco);
  MostrarEnderecos(vUf, vCidade, vEndereco);
end;

procedure TFrmMain.acExcluirEnderecoExecute(Sender: TObject);
begin
  ExcluirCEP(qryDados.FieldByName('codigo').AsInteger);
end;

procedure TFrmMain.AtualizarCEP(ACEP:String; ACodigoCEP: Integer);
var
  vDadosCEP: iDadosCEP;
begin
  vDadosCEP := ExecutarBuscaCEPFactory(ACEP);
  vDadosCEP.Codigo := ACodigoCEP;

  FEnderecoService.Atualizar(vDadosCEP, ACodigoCEP);

  MostrarDadosCEP(FEnderecoService.BuscarPorCEP(vDadosCEP.CEP));
end;

procedure TFrmMain.AtualizarEnderecos(AUf, ACidade, AEndereco: String);
var
  vListaDadosCEP: iListaDadosCEP;
begin
  vListaDadosCEP := FEnderecoService.AtualizarEnderecos(ExecutarBuscaEnderecoFactory(AUf, ACidade, AEndereco));

  case vListaDadosCEP.Items.Count of
    0 :  MostrarDadosCEP(vListaDadosCEP.Items[0]);
    else MostrarEnderecos(AUf, ACidade, AEndereco);
  end;
end;

procedure TFrmMain.IniciarConexaoBD;
begin
  FConexao := TFactoryConexao.New
                .ConexaoFiredac
                .Parametros
                 .DriverName('PG')
                 .Server('127.0.0.1')
                 .Database('buscaCep')
                 .User_Name('postgres')
                 .Password('deno')
                 .Port('5432')
                .EndParametros
                .Conectar;
end;

procedure TFrmMain.FinalizarConexaoBD;
begin
  if getConexao.Connected then
  begin
    FConexao.Desconectar;
  end;
end;

procedure TFrmMain.ExcluirCEP(ACodigoCEP: Integer);
begin
  if Application.MessageBox('Deseja Realmente excluir este endereço?', 'Atenção', MB_YESNO + MB_ICONQUESTION) = mrYes then
  begin
    FEnderecoService.Deletar(ACodigoCEP);
    qryDados.Refresh;
  end;
end;

function TFrmMain.ExecutarBuscaCEPFactory(ACEP: String): iDadosCEP;
begin
  Result := TBuscaCepFactory.New.CriarServicoBuscaCEP(TTypeBusca(rgTipoRetorno.ItemIndex)).BuscarCEP(ACEP);

  if Result.Erro then
  begin
    Application.MessageBox('CEP Inexistente na Base de Dados e no ViaCep.', 'Atenção', MB_ICONWARNING);
    Abort;
  end;
end;

function TFrmMain.ExecutarBuscaEnderecoFactory(AUf, ACidade, AEndereco: String): iListaDadosCEP;
begin
  Result := TBuscaCepFactory.New
                      .CriarServicoBuscaCEP(TTypeBusca(rgTipoRetorno2.ItemIndex))
                      .BuscarCEPPorEndereco(AUf, ACidade, AEndereco);

  if Result.Items.Count = 0 then
  begin
    Application.MessageBox('Endereço Inexistente na Base de Dados e no ViaCep.', 'Atenção', MB_ICONWARNING);
    Abort;
  end;
end;

function TFrmMain.VerificarSeListaOuAtualizaCEP(ATitle: String): TOperacao;
var
  vTaskDialog: TTaskDialog;
  vButton: TTaskDialogBaseButtonItem;
begin
  Result := toListar;

  vTaskDialog := TTaskDialog.Create(Self);
  try
    vTaskDialog.Caption := 'Atenção';
    vTaskDialog.Title   := ATitle;
    vTaskDialog.CommonButtons := [];

    vButton := vTaskDialog.Buttons.Add;
    vButton.Caption := 'Listar';
    vButton.ModalResult := 101;

    vButton := vTaskDialog.Buttons.Add;
    vButton.Caption := 'Atualizar';
    vButton.ModalResult := 100;

    vTaskDialog.Execute;

    case vTaskDialog.ModalResult of
      100: Result := toAtualizar;
      101: Result := toListar;
    end;
  finally
    vTaskDialog.Free;
  end;
end;

procedure TFrmMain.ListarEnderecos;
begin
  qryDados.Connection := getConexao;
  qryDados.SQL.Clear;
  qryDados.SQL.Text := 'select * from endereco order by codigo';
  qryDados.Open;

  pgControl.ActivePage := tsCEPs;
end;

procedure TFrmMain.MostrarDadosCEP(ADadoCEP: iDadosCEP);
begin
  FrmDadosCEP := TFrmDadosCEP.Create(nil);
  try
    FrmDadosCEP.SetDadosCEP(ADadoCEP);
    FrmDadosCEP.ShowModal;
  finally
    FrmDadosCEP.Free;
  end;
end;

procedure TFrmMain.MostrarEnderecos(AUf, ACidade, AEndereco: String);
begin
  qryDados.Connection := getConexao;
  qryDados.SQL.Clear;
  qryDados.SQL.Text := 'select * ' +
                       '  from endereco ' +
                       ' where unaccent(logradouro) ilike unaccent(:logradouro) ' +
                       '   and unaccent(localidade) ilike unaccent(:localidade) ' +
                       '   and uf ilike :uf ' +
                       ' order by codigo';

  qryDados.ParamByName('logradouro').AsString := Format(cCONTEM, [AEndereco]);
  qryDados.ParamByName('localidade').AsString := Format(cCONTEM, [ACidade]);
  qryDados.ParamByName('uf').AsString         := Format(cCONTEM, [AUf]);
  qryDados.Open;

  pgControl.ActivePage := tsCEPs;
end;

end.
