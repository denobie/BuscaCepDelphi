unit Interfaces.DadosCEP;

interface

uses
  Interfaces.Interfaces;

{$M+}

type
  TDadosCEP = class(TInterfacedObject, iDadosCEP)
    private
      FCEP: String;
      FLogradouro: String;
      FComplemento: String;
      FUnidade: String;
      FBairro: String;
      FLocalidade: String;
      FUf: String;
      FEstado: String;
      FRegiao: String;
      FIBGE: Integer;
      FGia: String;
      FDDD: Integer;
      FSiafi: String;
      FErro: Boolean;
      FCodigo: Integer;

      function GetBairro: String;
      function GetCEP: String;
      function GetComplemento: String;
      function GetDDD: Integer;
      function GetEstado: String;
      function GetGia: String;
      function GetIBGE: Integer;
      function GetLocalidade: String;
      function GetLogradouro: String;
      function GetRegiao: String;
      function GetSiafi: String;
      function GetUf: String;
      function GetUnidade: String;
      function GetErro: Boolean;
      function GetCodigo: Integer;

      procedure SetBairro(const Value: String);
      procedure SetCEP(const Value: String);
      procedure SetComplemento(const Value: String);
      procedure SetDDD(const Value: Integer);
      procedure SetEstado(const Value: String);
      procedure SetGia(const Value: String);
      procedure SetIBGE(const Value: Integer);
      procedure SetLocalidade(const Value: String);
      procedure SetLogradouro(const Value: String);
      procedure SetRegiao(const Value: String);
      procedure SetSiafi(const Value: String);
      procedure SetUf(const Value: String);
      procedure SetUnidade(const Value: String);
      procedure SetErro(const Value: Boolean);
      procedure SetCodigo(const Value: Integer);

    public
      constructor Create;
      destructor Destroy; override;
      class function New: iDadosCEP;

    published
      property cep: String read GetCEP write SetCEP;
      property logradouro: String read GetLogradouro write SetLogradouro;
      property complemento: String read GetComplemento write SetComplemento;
      property unidade: String read GetUnidade write SetUnidade;
      property bairro: String read GetBairro write SetBairro;
      property localidade: String read GetLocalidade write SetLocalidade;
      property uf: String read GetUf write SetUf;
      property estado: String read GetEstado write SetEstado;
      property regiao: String read GetRegiao write SetRegiao;
      property ibge: Integer read GetIBGE write SetIBGE;
      property gia: String read GetGia write SetGia;
      property ddd: Integer read GetDDD write SetDDD;
      property siafi: String read GetSiafi write SetSiafi;
      property erro: Boolean read GetErro write SetErro;
      property codigo: Integer read GetCodigo write SetCodigo;
  end;


implementation

{ TDadosCEP }

constructor TDadosCEP.Create;
begin

end;

destructor TDadosCEP.Destroy;
begin

  inherited;
end;

class function TDadosCEP.New: iDadosCEP;
begin
  Result := Self.Create;
end;

function TDadosCEP.GetBairro: String;
begin
  Result := FBairro;
end;

function TDadosCEP.GetCEP: String;
begin
  Result := FCEP;
end;

function TDadosCEP.GetCodigo: Integer;
begin
  Result := FCodigo;
end;

function TDadosCEP.GetComplemento: String;
begin
  Result := FComplemento;
end;

function TDadosCEP.GetDDD: Integer;
begin
  Result := FDDD;
end;

function TDadosCEP.GetEstado: String;
begin
  Result := FEstado;
end;

function TDadosCEP.GetGia: String;
begin
  Result := FGia;
end;

function TDadosCEP.GetIBGE: Integer;
begin
  Result := FIBGE;
end;

function TDadosCEP.GetLocalidade: String;
begin
  Result := FLocalidade;
end;

function TDadosCEP.GetLogradouro: String;
begin
  Result := FLogradouro;
end;

function TDadosCEP.GetRegiao: String;
begin
  Result := FRegiao;
end;

function TDadosCEP.GetSiafi: String;
begin
  Result := FSiafi;
end;

function TDadosCEP.GetUf: String;
begin
  Result := FUf;
end;

function TDadosCEP.GetUnidade: String;
begin
  Result := FUnidade;
end;

function TDadosCEP.GetErro: Boolean;
begin
  Result := FErro;
end;

procedure TDadosCEP.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TDadosCEP.SetCEP(const Value: String);
begin
  FCEP := Value;
end;

procedure TDadosCEP.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TDadosCEP.SetComplemento(const Value: String);
begin
  FComplemento := Value;
end;

procedure TDadosCEP.SetDDD(const Value: Integer);
begin
  FDDD := Value;
end;

procedure TDadosCEP.SetEstado(const Value: String);
begin
  FEstado := Value;
end;

procedure TDadosCEP.SetGia(const Value: String);
begin
  FGia := Value;
end;

procedure TDadosCEP.SetIBGE(const Value: Integer);
begin
  FIBGE := Value;
end;

procedure TDadosCEP.SetLocalidade(const Value: String);
begin
  FLocalidade := Value;
end;

procedure TDadosCEP.SetLogradouro(const Value: String);
begin
  FLogradouro := Value;
end;

procedure TDadosCEP.SetRegiao(const Value: String);
begin
  FRegiao := Value;
end;

procedure TDadosCEP.SetSiafi(const Value: String);
begin
  FSiafi := Value;
end;

procedure TDadosCEP.SetUf(const Value: String);
begin
  FUf := Value;
end;

procedure TDadosCEP.SetUnidade(const Value: String);
begin
  FUnidade := Value;
end;

procedure TDadosCEP.SetErro(const Value: Boolean);
begin
  FErro := Value;
end;

end.
