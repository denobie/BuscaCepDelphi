unit Interfaces.EnderecoService;

interface

uses
  Interfaces.EnderecosInterfaces, Model.Conexoes.Interfaces, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Interfaces.Interfaces,
  System.Classes;

type
  TEnderecoService = class(TInterfacedObject, iEnderecoService)
    private
      FConexao: iConexao;
      FConexaoFiredac: TFDConnection;
    public
      constructor Create(AConexao: iConexao);
      destructor Destroy; override;
      class function New(AConexao: iConexao): iEnderecoService;

      function CEPJaCadastrado(ACEP: String; out ACodigoCEP: Integer): Boolean;
      function EnderecoJaCadastrado(AUf, ACidade, AEndereco: String; out ATotalRegistros: Integer): Boolean;
      function BuscarPorCEP(ACEP: String): iDadosCEP;
      function QryToDadosCEP(AQry: TComponent): iDadosCEP;
      function AtualizarEnderecos(AListaDadosCEP: iListaDadosCEP): iListaDadosCEP;
      function InserirLista(AListaDadosCEP: iListaDadosCEP): iListaDadosCEP;

      procedure Inserir(ADadosCEP: iDadosCEP);
      procedure Atualizar(ADadosCEP: iDadosCEP; ACodigoCEP: Integer);
      procedure Deletar(ACodigoCEP: Integer);
  end;


implementation

uses
  System.SysUtils, Utils.BuscaCEPUtils, Interfaces.DadosCEP,
  Interfaces.ListaDadosCEP;

{ TEnderecoService }

constructor TEnderecoService.Create(AConexao: iConexao);
begin
  FConexao := AConexao;
  FConexaoFiredac := (AConexao.EndConexao as TFDConnection);
end;

destructor TEnderecoService.Destroy;
begin

  inherited;
end;

class function TEnderecoService.New(AConexao: iConexao): iEnderecoService;
begin
  Result := Self.Create(AConexao);
end;

function TEnderecoService.QryToDadosCEP(AQry: TComponent): iDadosCEP;
var
  vQry: TFDQuery;
begin
   if not Assigned(AQry) then
   begin
     raise Exception.Create('Query não inicializada!');
   end;

  vQry := (AQry as TFDQuery);

  Result := TDadosCEP.Create;

  Result.CEP         := vQry.FieldByName('cep').AsString;
  Result.Logradouro  := vQry.FieldByName('logradouro').AsString;
  Result.Complemento := vQry.FieldByName('complemento').AsString;
  Result.Unidade     := vQry.FieldByName('unidade').AsString;
  Result.Bairro      := vQry.FieldByName('bairro').AsString;
  Result.Localidade  := vQry.FieldByName('localidade').AsString;
  Result.Uf          := vQry.FieldByName('uf').AsString;
  Result.Regiao      := vQry.FieldByName('regiao').AsString;
  Result.IBGE        := vQry.FieldByName('codigo_ibge').AsInteger;
  Result.Gia         := vQry.FieldByName('codigo_gia').AsString;
  Result.DDD         := vQry.FieldByName('ddd').AsInteger;
  Result.Siafi       := vQry.FieldByName('siafi').AsString;
  Result.Erro        := False;
  Result.Codigo      := vQry.FieldByName('codigo').AsInteger;
end;

function TEnderecoService.CEPJaCadastrado(ACEP: String; out ACodigoCEP: Integer): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := FConexaoFiredac;
    vQry.SQL.Text   := 'select codigo from endereco where cep = :cep';
    vQry.ParamByName('cep').AsString := ACEP;
    vQry.Open;

    ACodigoCEP := vQry.FieldByName('codigo').AsInteger;

    Result := not vQry.IsEmpty;
  finally
    vQry.Free;
  end;
end;

function TEnderecoService.EnderecoJaCadastrado(AUf, ACidade, AEndereco: String;
  out ATotalRegistros: Integer): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := FConexaoFiredac;
    vQry.SQL.Text   := 'select count(*) as total ' +
                     '  from endereco ' +
                     ' where unaccent(logradouro) ilike unaccent(:logradouro) ' +
                     '   and unaccent(localidade) ilike unaccent(:localidade) ' +
                     '   and uf ilike :uf';

    vQry.ParamByName('logradouro').AsString := Format(cCONTEM, [AEndereco]);
    vQry.ParamByName('localidade').AsString := Format(cCONTEM, [ACidade]);
    vQry.ParamByName('uf').AsString         := Format(cCONTEM, [AUf]);
    vQry.Open;

    ATotalRegistros := vQry.FieldByName('total').AsInteger;

    Result := vQry.FieldByName('total').AsInteger > 0;
  finally
    vQry.Free;
  end;
end;

function TEnderecoService.BuscarPorCEP(ACEP: String): iDadosCEP;
var
  vQry: TFDQuery;
begin
  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := FConexaoFiredac;
    vQry.SQL.Text   := 'select * from endereco where cep = :cep';
    vQry.ParamByName('cep').AsString := ACEP;
    vQry.Open;

    if vQry.IsEmpty then
    begin
      raise Exception.Create('CEP não encontrado na Base de Dados.');
    end;

    Result := TDadosCEP.Create;

    Result.CEP         := vQry.FieldByName('cep').AsString;
    Result.Logradouro  := vQry.FieldByName('logradouro').AsString;
    Result.Complemento := vQry.FieldByName('complemento').AsString;
    Result.Unidade     := vQry.FieldByName('unidade').AsString;
    Result.Bairro      := vQry.FieldByName('bairro').AsString;
    Result.Localidade  := vQry.FieldByName('localidade').AsString;
    Result.Uf          := vQry.FieldByName('uf').AsString;
    Result.Regiao      := vQry.FieldByName('regiao').AsString;
    Result.IBGE        := vQry.FieldByName('codigo_ibge').AsInteger;
    Result.Gia         := vQry.FieldByName('codigo_gia').AsString;
    Result.DDD         := vQry.FieldByName('ddd').AsInteger;
    Result.Siafi       := vQry.FieldByName('siafi').AsString;
    Result.Erro        := False;
    Result.Codigo      := vQry.FieldByName('codigo').AsInteger;
  finally
    vQry.Free;
  end;
end;

procedure TEnderecoService.Inserir(ADadosCEP: iDadosCEP);
var
  vQry: TFDQuery;
begin
  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := FConexaoFiredac;
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

procedure TEnderecoService.Atualizar(ADadosCEP: iDadosCEP;
  ACodigoCEP: Integer);
var
  vQry: TFDQuery;
begin
  ADadosCEP.Codigo := ACodigoCEP;

  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := FConexaoFiredac;
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
    vQry.ParamByName('logradouro').AsString := ADadosCEP.Logradouro;
    vQry.ParamByName('complemento').AsString := ADadosCEP.Complemento;
    vQry.ParamByName('unidade').AsString := ADadosCEP.unidade;
    vQry.ParamByName('bairro').AsString := ADadosCEP.bairro;
    vQry.ParamByName('localidade').AsString := ADadosCEP.Localidade;
    vQry.ParamByName('uf').AsString := ADadosCEP.uf;
    vQry.ParamByName('regiao').AsString := ADadosCEP.regiao;
    vQry.ParamByName('codigo_ibge').AsInteger := ADadosCEP.IBGE;
    vQry.ParamByName('codigo_gia').AsString := ADadosCEP.Gia;
    vQry.ParamByName('ddd').AsInteger := ADadosCEP.DDD;
    vQry.ParamByName('siafi').AsString := ADadosCEP.Siafi;
    vQry.ExecSQL;
  finally
    vQry.Free;
  end;
end;

procedure TEnderecoService.Deletar(ACodigoCEP: Integer);
var
  vQry: TFDQuery;
begin
  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := FConexaoFiredac;
    vQry.SQL.Text := 'delete from endereco where codigo = :codigo';

    vQry.ParamByName('codigo').AsInteger := ACodigoCEP;
    vQry.ExecSQL;
  finally
    vQry.Free;
  end;
end;

function TEnderecoService.AtualizarEnderecos(
  AListaDadosCEP: iListaDadosCEP): iListaDadosCEP;
var
  i, vCodigoCEP: Integer;
  vDadosCEP: iDadosCEP;
begin
  Result := TListaDadosCEP.Create;

  for i := 0 to Pred(AListaDadosCEP.Items.Count) do
  begin
    vDadosCEP := AListaDadosCEP.Items[i];

    if Self.CEPJaCadastrado(vDadosCEP.CEP, vCodigoCEP) then
    begin
      Self.Atualizar(vDadosCEP, vCodigoCEP);
    end
    else
    begin
      Self.Inserir(vDadosCEP);
    end;

    Result.Items.Add(vDadosCEP);
  end;
end;

function TEnderecoService.InserirLista(AListaDadosCEP: iListaDadosCEP): iListaDadosCEP;
var
  i: Integer;
  vDadosCEP: iDadosCEP;
begin
  Result := TListaDadosCEP.Create;

  for i := 0 to Pred(AListaDadosCEP.Items.Count) do
  begin
    vDadosCEP := AListaDadosCEP.Items[i];

    Self.Inserir(vDadosCEP);

    Result.Items.Add(vDadosCEP);
  end;
end;

end.
