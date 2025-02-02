unit Interfaces.BuscaCEPJsonService;

interface

uses
  Interfaces.Interfaces, Interfaces.BuscaCEPService, Utils.BuscaCEPUtils;

type
  TBuscaCEPJsonService = class(TBuscaCEPService)
    private

    public
      constructor Create;
      destructor Destroy; override;
      class function New: iBuscaCEPService;
      function getDadosResponse(ABodyResponse: String) : iDadosCEP; override;
  end;


implementation

uses
  System.JSON, System.SysUtils, Interfaces.DadosCEP;

{ TBuscaCEPViaJsonService }

constructor TBuscaCEPJsonService.Create;
begin
  FTipoBusca := ttbJSON;
end;

destructor TBuscaCEPJsonService.Destroy;
begin

  inherited;
end;

class function TBuscaCEPJsonService.New: iBuscaCEPService;
begin
  Result := Self.Create;
end;

function TBuscaCEPJsonService.getDadosResponse(ABodyResponse: String): iDadosCEP;
var
  vBodyResponse: TJSONObject;
  vDadosCEP: iDadosCEP;
begin
  vBodyResponse := TJSONObject.Create;
  try
    vBodyResponse := (TJSONValue.ParseJSONValue(ABodyResponse) as TJSONObject);
    vDadosCEP := TDadosCEP.Create;

    vDadosCEP.CEP         := vBodyResponse.GetValue<string>('cep', '');
    vDadosCEP.Logradouro  := vBodyResponse.GetValue<string>('logradouro', '');
    vDadosCEP.Complemento := vBodyResponse.GetValue<string>('complemento', '');
    vDadosCEP.Unidade     := vBodyResponse.GetValue<string>('unidade', '');
    vDadosCEP.Bairro      := vBodyResponse.GetValue<string>('bairro', '');
    vDadosCEP.Localidade  := vBodyResponse.GetValue<string>('localidade', '');
    vDadosCEP.Uf          := vBodyResponse.GetValue<string>('uf', '');
    vDadosCEP.Estado      := vBodyResponse.GetValue<string>('estado', '');
    vDadosCEP.IBGE        := StrToIntDef(vBodyResponse.GetValue<string>('ibge', ''), 0);
    vDadosCEP.Gia         := vBodyResponse.GetValue<string>('gia', '');
    vDadosCEP.DDD         := StrToIntDef(vBodyResponse.GetValue<string>('ddd', ''), 0);
    vDadosCEP.Siafi       := vBodyResponse.GetValue<string>('siafi', '');
    vDadosCEP.Erro        := vBodyResponse.GetValue<string>('erro', '').Equals('true');

    Result := vDadosCEP;
  finally
    vBodyResponse.Free;
  end;
end;

end.
