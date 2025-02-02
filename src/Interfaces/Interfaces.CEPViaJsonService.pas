unit Interfaces.CEPViaJsonService;

interface

uses
  Interfaces.Interfaces, System.Net.HttpClient;

const
  URL_VIACEP_JSON = 'https://viacep.com.br/ws/%s/json/';

type
  TCEPViaJsonService = class(TInterfacedObject, iCEPService)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iCEPService;
      function BuscarCEP(ACEP: String): iDadosCEP;
  end;


implementation

uses
  System.JSON, System.SysUtils, Interfaces.DadosCEP, System.RegularExpressions;

{ TCEPViaJsonService }

function TCEPViaJsonService.BuscarCEP(ACEP: String): iDadosCEP;
var
  vUrlRequest: String;
  vClient: THttpClient;
  vResponse: IHTTPResponse;
  vBodyResponse: TJSONObject;
  vDadosCEP: iDadosCEP;
begin
  Result := nil;

  vUrlRequest := Format(URL_VIACEP_JSON, [ACEP]);

  vClient := THTTPClient.Create;
  vBodyResponse := TJSONObject.Create;
  try
    vResponse := vClient.Get(vUrlRequest);

    //Refatorar para Case
    if vResponse.StatusCode = 200 then
    begin
      vBodyResponse := (TJSONValue.ParseJSONValue(vResponse.ContentAsString) as TJSONObject);
      if Assigned(vBodyResponse) then
      begin
        vDadosCEP := TDadosCEP.Create;

        vDadosCEP.CEP         := TRegEx.Replace(vBodyResponse.GetValue<string>('cep', ''), '-', '');
        vDadosCEP.Logradouro  := vBodyResponse.GetValue<string>('logradouro', '');
        vDadosCEP.Complemento := vBodyResponse.GetValue<string>('complemento', '');
        vDadosCEP.Unidade     := vBodyResponse.GetValue<string>('unidade', '');
        vDadosCEP.Bairro      := vBodyResponse.GetValue<string>('bairro', '');
        vDadosCEP.Localidade  := vBodyResponse.GetValue<string>('localidade', '');
        vDadosCEP.Uf          := vBodyResponse.GetValue<string>('uf', '');
        vDadosCEP.Estado      := vBodyResponse.GetValue<string>('estado', '');
        vDadosCEP.IBGE        := StrToInt(vBodyResponse.GetValue<string>('ibge', ''));
        vDadosCEP.Gia         := vBodyResponse.GetValue<string>('gia', '');
        vDadosCEP.DDD         := StrToInt(vBodyResponse.GetValue<string>('ddd', ''));
        vDadosCEP.Siafi       := vBodyResponse.GetValue<string>('siafi', '');

        Result := vDadosCEP;
      end;
    end;
  finally
    vBodyResponse.Free;
    vClient.Free;
  end;
end;

constructor TCEPViaJsonService.Create;
begin

end;

destructor TCEPViaJsonService.Destroy;
begin

  inherited;
end;

class function TCEPViaJsonService.New: iCEPService;
begin
  Result := Self.Create;
end;

end.
