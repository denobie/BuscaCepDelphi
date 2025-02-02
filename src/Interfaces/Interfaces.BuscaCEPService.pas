unit Interfaces.BuscaCEPService;

interface

uses
  Interfaces.Interfaces, Utils.BuscaCEPUtils;

const
  URL_VIACEP = 'https://viacep.com.br/ws/%s/%s/';

type
  TBuscaCEPService = class(TInterfacedObject, iBuscaCEPService)
    public
      FTipoBusca: TTypeBusca;
      constructor Create;
      destructor Destroy; override;
      class function New: iBuscaCEPService;
      function BuscarCEP(ACEP: String): iDadosCEP;

      function getDadosResponse(ABodyResponse: String) : iDadosCEP; virtual;
  end;


implementation

uses
  System.SysUtils, System.Net.HttpClient;

{ TBuscaCEPService }

function TBuscaCEPService.BuscarCEP(ACEP: String): iDadosCEP;
var
  vUrlRequest: String;
  vClient: THttpClient;
  vResponse: IHTTPResponse;
begin
  vUrlRequest := Format(URL_VIACEP, [ACEP, TTypeBuscaUtils.TypeBuscaToStr(FTipoBusca)]);

  vClient := THTTPClient.Create;
  try
    vResponse := vClient.Get(vUrlRequest);

    case vResponse.StatusCode of
      200 : Result := getDadosResponse(vResponse.ContentAsString);
      400 : raise Exception.Create('CEP inválido');
      else raise Exception.Create('Falha ao Consultar Cep no ViaCep via XML. Erro: ' + vResponse.StatusCode.ToString);
    end;

  finally
    vClient.Free;
  end;
end;

constructor TBuscaCEPService.Create;
begin

end;

destructor TBuscaCEPService.Destroy;
begin

  inherited;
end;

function TBuscaCEPService.getDadosResponse(ABodyResponse: String): iDadosCEP;
begin

end;

class function TBuscaCEPService.New: iBuscaCEPService;
begin
  Result := Self.Create;
end;

end.
