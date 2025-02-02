unit Interfaces.DadosCEP;

interface

uses
  Interfaces.Interfaces;

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

      property CEP: String read GetCEP write SetCEP;
      property Logradouro: String read GetLogradouro write SetLogradouro;
      property Complemento: String read GetComplemento write SetComplemento;
      property Unidade: String read GetUnidade write SetUnidade;
      property Bairro: String read GetBairro write SetBairro;
      property Localidade: String read GetLocalidade write SetLocalidade;
      property Uf: String read GetUf write SetUf;
      property Estado: String read GetEstado write SetEstado;
      property Regiao: String read GetRegiao write SetRegiao;
      property IBGE: Integer read GetIBGE write SetIBGE;
      property Gia: String read GetGia write SetGia;
      property DDD: Integer read GetDDD write SetDDD;
      property Siafi: String read GetSiafi write SetSiafi;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iDadosCEP;
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

function TDadosCEP.GetBairro: String;
begin
  Result := FBairro;
end;

function TDadosCEP.GetCEP: String;
begin
  Result := FCEP;
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

class function TDadosCEP.New: iDadosCEP;
begin
  Result := Self.Create;
end;

procedure TDadosCEP.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TDadosCEP.SetCEP(const Value: String);
begin
  FCEP := Value;
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

end.
