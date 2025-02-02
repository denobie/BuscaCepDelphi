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
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    btnListaEnderecos: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    tbEndereco: TFDTable;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Button1: TButton;
    btnBuscarCEP: TButton;
    mmResultados: TMemo;
    rgTipoRetorno: TRadioGroup;
    CEP: TLabel;
    edtCEP: TEdit;
    procedure btnListaEnderecosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnBuscarCEPClick(Sender: TObject);
  private
    { Private declarations }
    FConexao: iConexao;
    function getConexao: TFDConnection;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Interfaces.Interfaces, Interfaces.BuscaCepFactory, Utils.BuscaCEPUtils;

{$R *.dfm}
procedure TForm1.FormCreate(Sender: TObject);
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

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FConexao.Desconectar;
end;

function TForm1.getConexao: TFDConnection;
begin
  Result := (FConexao.EndConexao as TFDConnection);
end;

procedure TForm1.btnBuscarCEPClick(Sender: TObject);
var
  vDadosCEP: iDadosCEP;
begin

  try
    vDadosCEP := TBuscaCepFactory.New.CriarServico(TTypeBusca(rgTipoRetorno.ItemIndex)).BuscarCEP(edtCEP.Text);
  except
    on E: Exception do
    begin
      Application.MessageBox(PWideChar('Falha ao consulta CEP. Erro: ' + E.Message), 'Atenção', MB_ICONERROR);
      Abort;
    end;
  end;

  if vDadosCEP.Erro then
  begin
    Application.MessageBox('CEP Inexistente na Base de Dados do ViaCep ou Inválido.', 'Atenção', MB_ICONINFORMATION);
  end;

  mmResultados.Lines.Clear;
  mmResultados.Lines.Add('CEP: ' + vDadosCEP.CEP);
  mmResultados.Lines.Add('Logradouro: ' + vDadosCEP.Logradouro);
end;

procedure TForm1.btnListaEnderecosClick(Sender: TObject);
begin
  //Aqui o Ideal seria abstrair o TFDTable para um iTable
  //mas como o tempo é curto, abstraí somente a conexão
  tbEndereco.Close;
  tbEndereco.Connection := getConexao;
  tbEndereco.Open;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  vQry: TFDQuery;
begin
  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := getConexao;
    vQry.SQL.Text := 'insert into endereco (codigo, cep, logradouro) values (:codigo, :cep, :logradouro)';
    vQry.ParamByName('codigo').AsInteger := Random(99999);
    vQry.ParamByName('cep').AsString  := '2';
    vQry.ParamByName('logradouro').AsString := '2';
    vQry.ExecSQL;
  finally
    vQry.Free;
  end;
end;

end.
