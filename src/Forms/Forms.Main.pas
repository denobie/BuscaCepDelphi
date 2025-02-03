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
  Forms.DadosCep, Vcl.ComCtrls;

type
  TOperacao = (toListar, toAtualizar);

type
  TFrmMain = class(TForm)
    DataSource1: TDataSource;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    pgControl: TPageControl;
    tsBuscarCEP: TTabSheet;
    tsCEPs: TTabSheet;
    DBGrid1: TDBGrid;
    CEP: TLabel;
    btnBuscarCEP: TButton;
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
    btnBuscarEndereco: TButton;
    cbUf: TComboBox;
    rgTipoRetorno2: TRadioGroup;
    qryDados: TFDQuery;
    Panel4: TPanel;
    btnListaEnderecos: TButton;
    btnListarPorEndereco: TButton;
    procedure btnListaEnderecosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnBuscarCEPClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnBuscarEnderecoClick(Sender: TObject);
    procedure btnListarPorEnderecoClick(Sender: TObject);
  private
    { Private declarations }
    FConexao: iConexao;
    function getConexao: TFDConnection;
    function CEPJaCadastrado(ACEP: String; out ACodigoCEP: Integer): Boolean;
    function EnderecoJaCadastrado(AEstado, ACidade, AEndereco: String; out ATotalRegistros: Integer): Boolean;
    function VerificarSeListaOuAtualizaCEP(ATitle: String): TOperacao;
    function GetCEP(ACEP: String): iDadosCEP;
    function ExcutarBuscaCEPFactory(ACEP: String): iDadosCEP;

    procedure BuscarCEP;
    procedure BuscarEndereco;
    procedure InserirCEP(ADadosCEP: iDadosCEP);
    procedure AtualizarCEP(ACEP:String; ACodigoCEP: Integer);
    procedure AtualizarEnderecos(AEstado, ACidade, AEndereco: String);
    procedure ListarEnderecos;
    procedure MostrarDadosCEP(ADadoCEP: iDadosCEP);
    procedure MostrarEnderecos(AEstado, ACidade, AEndereco: String);
    procedure ValidarCEP(ACEP: String);
    procedure ValidarEndereco(vUf, vCidade, vEndereco: String);
    procedure UpdateCEP(vDadosCEP: iDadosCEP; ACodigoCEP: Integer);
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
  FConexao :=  TFactoryConexao.New
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

procedure TFrmMain.FormShow(Sender: TObject);
begin
  pgControl.ActivePage := tsBuscarCEP;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if getConexao.Connected then
  begin
    FConexao.Desconectar;
  end;
end;

function TFrmMain.getConexao: TFDConnection;
begin
  Result := (FConexao.EndConexao as TFDConnection);
end;

procedure TFrmMain.BuscarCEP;
var
  vDadosCEP: iDadosCEP;
  vCodigoCEP: Integer;
begin
  ValidarCEP(edtCEP.Text);

  if CEPJaCadastrado(edtCEP.Text, vCodigoCEP) then
  begin
    case VerificarSeListaOuAtualizaCEP('CEP Já Cadastrado no Sistema. Deseja Atualizar ou Listar?') of
      toListar: MostrarDadosCEP(GetCEP(edtCEP.Text));
      toAtualizar: AtualizarCEP(edtCEP.Text, vCodigoCEP);
    end;
  end
  else
  begin
    vDadosCEP := ExcutarBuscaCEPFactory(edtCEP.Text);
    InserirCEP(vDadosCEP);
    MostrarDadosCEP(GetCEP(vDadosCEP.CEP));
  end;
end;

procedure TFrmMain.BuscarEndereco;
var
  vListaDadosCEP: iListaDadosCEP;
  vDadosCEP: iDadosCEP;
  i, vQtdeCadatros: Integer;
  vUf, vCidade, vEndereco: String;
begin
  vUf := copy(cbUf.Items[cbUf.ItemIndex], 1, 2).Trim;
  vCidade := Trim(edtCidade.Text);
  vEndereco := Trim(edtEndereco.Text);

  validarEndereco(vUf, vCidade, vEndereco);

  if EnderecoJaCadastrado(vUf, vCidade, vEndereco, vQtdeCadatros) then
  begin
    case VerificarSeListaOuAtualizaCEP('Endereço Já Cadastrado no Sistema. Deseja Atualizar ou Listar?') of
      toListar: MostrarEnderecos(vUf, vCidade, vEndereco);
      toAtualizar: AtualizarEnderecos(vUf, vCidade, vEndereco);
    end;
  end
  else
  begin
    vListaDadosCEP := TBuscaCepFactory.New
                        .CriarServicoBuscaCEP(TTypeBusca(rgTipoRetorno2.ItemIndex))
                        .BuscarCEPPorEndereco(vUf, vCidade, vEndereco);

    if vListaDadosCEP.Items.Count = 0 then
    begin
      Application.MessageBox('Endereço Inexistente na Base de Dados e no ViaCep.', 'Atenção', MB_ICONWARNING);
      Abort;
    end;

    for i := 0 to Pred(vListaDadosCEP.Items.Count) do
    begin
      vDadosCEP := vListaDadosCEP.Items[i] as iDadosCEP;

      InserirCEP(vDadosCEP);
    end;

    if vListaDadosCEP.Items.Count = 1 then
    begin
      MostrarDadosCEP(GetCEP(vDadosCEP.CEP));
    end
    else
    begin
      MostrarEnderecos(vUf, vCidade, vEndereco);
    end;
  end;
end;

procedure TFrmMain.btnBuscarCEPClick(Sender: TObject);
begin
  BuscarCEP;
end;

procedure TFrmMain.btnBuscarEnderecoClick(Sender: TObject);
begin
  BuscarEndereco;
end;

procedure TFrmMain.btnListaEnderecosClick(Sender: TObject);
begin
  ListarEnderecos;
end;

procedure TFrmMain.btnListarPorEnderecoClick(Sender: TObject);
var
  vUf, vCidade, vEndereco: String;
begin
  vUf := copy(cbUf.Items[cbUf.ItemIndex], 1, 2).Trim;
  vCidade := Trim(edtCidade.Text);
  vEndereco := Trim(edtEndereco.Text);

  ValidarEndereco(vUf, vCidade, vEndereco);
  MostrarEnderecos(vUf, vCidade, vEndereco);
end;

function TFrmMain.CEPJaCadastrado(ACEP: String; out ACodigoCEP: Integer): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := getConexao;
    vQry.SQL.Text   := 'select codigo from endereco where cep = :cep';
    vQry.ParamByName('cep').AsString := ACEP;
    vQry.Open;

    ACodigoCEP := vQry.FieldByName('codigo').AsInteger;

    Result := not vQry.IsEmpty;
  finally
    vQry.Free;
  end;
end;

function TFrmMain.EnderecoJaCadastrado(AEstado, ACidade, AEndereco: String; out ATotalRegistros: Integer): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := getConexao;
    vQry.SQL.Text   := 'select count(*) as total ' +
                     '  from endereco ' +
                     ' where unaccent(logradouro) ilike unaccent(:logradouro) ' +
                     '   and unaccent(localidade) ilike unaccent(:localidade) ' +
                     '   and uf ilike :uf';

    vQry.ParamByName('logradouro').AsString := Format(cCONTEM, [AEndereco]);
    vQry.ParamByName('localidade').AsString := Format(cCONTEM, [ACidade]);
    vQry.ParamByName('uf').AsString         := Format(cCONTEM, [AEstado]);
    vQry.Open;

    ATotalRegistros := vQry.FieldByName('total').AsInteger;

    Result := vQry.FieldByName('total').AsInteger > 0;
  finally
    vQry.Free;
  end;
end;


function TFrmMain.GetCEP(ACEP: String): iDadosCEP;
var
  vQry: TFDQuery;
  vDadosCEP: iDadosCEP;
begin
  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := getConexao;
    vQry.SQL.Text   := 'select * from endereco where cep = :cep';
    vQry.ParamByName('cep').AsString := ACEP;
    vQry.Open;

    if vQry.IsEmpty then
    begin
      Application.MessageBox('CEP não encontrado na Base de Dados.', 'Atenção', MB_ICONINFORMATION);
      Abort;
    end;

    vDadosCEP := TDadosCEP.Create;
    vDadosCEP.CEP         := vQry.FieldByName('cep').AsString;
    vDadosCEP.Logradouro  := vQry.FieldByName('logradouro').AsString;
    vDadosCEP.Complemento := vQry.FieldByName('complemento').AsString;
    vDadosCEP.Unidade     := vQry.FieldByName('unidade').AsString;
    vDadosCEP.Bairro      := vQry.FieldByName('bairro').AsString;
    vDadosCEP.Localidade  := vQry.FieldByName('localidade').AsString;
    vDadosCEP.Uf          := vQry.FieldByName('uf').AsString;
    vDadosCEP.Regiao      := vQry.FieldByName('regiao').AsString;
    vDadosCEP.IBGE        := vQry.FieldByName('codigo_ibge').AsInteger;
    vDadosCEP.Gia         := vQry.FieldByName('codigo_gia').AsString;
    vDadosCEP.DDD         := vQry.FieldByName('ddd').AsInteger;
    vDadosCEP.Siafi       := vQry.FieldByName('siafi').AsString;
    vDadosCEP.Erro        := False;
    vDadosCEP.Codigo      := vQry.FieldByName('codigo').AsInteger;

    Result := vDadosCEP;
  finally
    vQry.Free;
  end;
end;

procedure TFrmMain.InserirCEP(ADadosCEP: iDadosCEP);
var
  vQry: TFDQuery;
begin
  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := getConexao;
    vQry.SQL.Text := 'insert into endereco ' +
                     '       (codigo, cep, logradouro, complemento, unidade, bairro, localidade, uf, regiao, codigo_ibge, codigo_gia, ddd, siafi) ' +
                     'values (:codigo, :cep, :logradouro, :complemento, :unidade, :bairro, :localidade, :uf, :regiao, :codigo_ibge, :codigo_gia, :ddd, :siafi)';

    vQry.ParamByName('codigo').AsInteger      := TSequenceUtils.getNextValue('seqCodEndereco', FConexao);
    vQry.ParamByName('cep').AsString          := ADadosCEP.CEP;
    vQry.ParamByName('logradouro').AsString   := ADadosCEP.Logradouro;
    vQry.ParamByName('complemento').AsString  := ADadosCEP.Complemento;
    vQry.ParamByName('unidade').AsString      := ADadosCEP.unidade;
    vQry.ParamByName('bairro').AsString       := ADadosCEP.bairro;
    vQry.ParamByName('localidade').AsString   := ADadosCEP.Localidade;
    vQry.ParamByName('uf').AsString           := ADadosCEP.uf;
    vQry.ParamByName('regiao').AsString       := ADadosCEP.regiao;
    vQry.ParamByName('codigo_ibge').AsInteger := ADadosCEP.IBGE;
    vQry.ParamByName('codigo_gia').AsString   := ADadosCEP.Gia;
    vQry.ParamByName('ddd').AsInteger         := ADadosCEP.DDD;
    vQry.ParamByName('siafi').AsString        := ADadosCEP.Siafi;

    ADadosCEP.Codigo := vQry.ParamByName('codigo').AsInteger;

    vQry.ExecSQL;
  finally
    vQry.Free;
  end;
end;

procedure TFrmMain.AtualizarCEP(ACEP:String; ACodigoCEP: Integer);
var
  vDadosCEP: iDadosCEP;
begin
  vDadosCEP := ExcutarBuscaCEPFactory(ACEP);
  vDadosCEP.Codigo := ACodigoCEP;

  UpdateCEP(vDadosCEP, ACodigoCEP);

  MostrarDadosCEP(GetCEP(vDadosCEP.CEP));
end;

procedure TFrmMain.AtualizarEnderecos(AEstado, ACidade, AEndereco: String);
var
  vListaDadosCEP: iListaDadosCEP;
  vDadosCEP: iDadosCEP;
  i, vCodigoCEP: Integer;
begin
  vListaDadosCEP := TBuscaCepFactory.New
                      .CriarServicoBuscaCEP(TTypeBusca(rgTipoRetorno2.ItemIndex))
                      .BuscarCEPPorEndereco(AEstado, ACidade, AEndereco);

  for i := 0 to Pred(vListaDadosCEP.Items.Count) do
  begin
    vDadosCEP := vListaDadosCEP.Items[i] as iDadosCEP;

    if CEPJaCadastrado(vDadosCEP.CEP, vCodigoCEP) then
    begin
      UpdateCEP(vDadosCEP, vCodigoCEP)
    end
    else
    begin
      InserirCEP(vDadosCEP);
    end;
  end;

  if vListaDadosCEP.Items.Count = 1 then
  begin
    MostrarDadosCEP(GetCEP(vDadosCEP.CEP));
  end
  else
  begin
    MostrarEnderecos(AEstado, ACidade, AEndereco);
  end;
end;

procedure TFrmMain.ValidarCEP(ACEP: String);
begin
  if ACEP.Trim.Length <> 8 then
  begin
    raise Exception.Create('O CEP informado é inválido');
  end;
end;

procedure TFrmMain.ValidarEndereco(vUf, vCidade, vEndereco: String);
begin
  if vUf.Length < 2 then
  begin
    raise Exception.Create('Estado inválido');
  end;

  if vCidade.Length < 3 then
  begin
    raise Exception.Create('Cidade inválida. Por favor, digite mais informações.');
  end;

  if vEndereco.Length < 3 then
  begin
    raise Exception.Create('Endereço inválido. Por favor, digite mais informações.');
  end;
end;

procedure TFrmMain.UpdateCEP(vDadosCEP: iDadosCEP; ACodigoCEP: Integer);
var
  vQry: TFDQuery;
begin
  vDadosCEP.Codigo := ACodigoCEP;

  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := getConexao;
    vQry.SQL.Text := 'update endereco ' +
                     '   set logradouro  = :logradouro, ' +
                     '       complemento = :complemento, ' +
                     '       unidade     = :unidade, ' +
                     '       bairro      = :bairro, ' +
                     '       localidade  = :localidade, ' +
                     '       uf          = :uf, ' +
                     '       regiao      = :regiao, ' +
                     '       codigo_ibge = :codigo_ibge, ' +
                     '       codigo_gia  = :codigo_gia, ' +
                     '       ddd         = :ddd, ' +
                     '       siafi       = :siafi ' +
                     ' where codigo = :codigo';
    vQry.ParamByName('codigo').AsInteger := ACodigoCEP;
    vQry.ParamByName('logradouro').AsString := vDadosCEP.Logradouro;
    vQry.ParamByName('complemento').AsString := vDadosCEP.Complemento;
    vQry.ParamByName('unidade').AsString := vDadosCEP.unidade;
    vQry.ParamByName('bairro').AsString := vDadosCEP.bairro;
    vQry.ParamByName('localidade').AsString := vDadosCEP.Localidade;
    vQry.ParamByName('uf').AsString := vDadosCEP.uf;
    vQry.ParamByName('regiao').AsString := vDadosCEP.regiao;
    vQry.ParamByName('codigo_ibge').AsInteger := vDadosCEP.IBGE;
    vQry.ParamByName('codigo_gia').AsString := vDadosCEP.Gia;
    vQry.ParamByName('ddd').AsInteger := vDadosCEP.DDD;
    vQry.ParamByName('siafi').AsString := vDadosCEP.Siafi;
    vQry.ExecSQL;
  finally
    vQry.Free;
  end;
end;

function TFrmMain.ExcutarBuscaCEPFactory(ACEP: String): iDadosCEP;
var
  vDadosCEP: iDadosCEP;
begin
  Result := nil;

  vDadosCEP := TDadosCEP.Create;
  vDadosCEP := TBuscaCepFactory.New.CriarServicoBuscaCEP(TTypeBusca(rgTipoRetorno.ItemIndex)).BuscarCEP(ACEP);

  if vDadosCEP.Erro then
  begin
    Application.MessageBox('CEP Inexistente na Base de Dados e no ViaCep.', 'Atenção', MB_ICONWARNING);
    Abort;
  end;

  Result := vDadosCEP;
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
  //Aqui o Ideal seria abstrair a TFDQuery para um iQuery
  //mas como o tempo é curto, abstraí somente a conexão
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

procedure TFrmMain.MostrarEnderecos(AEstado, ACidade, AEndereco: String);
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
  qryDados.ParamByName('uf').AsString         := Format(cCONTEM, [AEstado]);
  qryDados.Open;

  pgControl.ActivePage := tsCEPs;
end;

end.
