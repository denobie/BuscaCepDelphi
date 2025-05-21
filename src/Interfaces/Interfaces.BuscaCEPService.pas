unit Interfaces.BuscaCEPService;

interface

uses
  Interfaces.Interfaces, Utils.Types;

const
  URL_VIACEP_POR_CEP = 'https://viacep.com.br/ws/%s/%s/';
  URL_VIACEP_POR_ENDERECO = 'https://viacep.com.br/ws/%s/%s/%s/%s/';

type
  TBuscaCEPService = class(TInterfacedObject, iBuscaCEPService)
    public
      FTipoBusca: TTypeBusca;
      constructor Create;
      destructor Destroy; override;
      class function New: iBuscaCEPService;
      function BuscarCEP(ACEP: String): iDadosCEP;
      function BuscarCEPPorEndereco(AEstado, ACidade, AEndereco: String): iListaDadosCEP;

      function getDadosResponse(ABodyResponse: String) : iDadosCEP; virtual;
      function getListDadosResponse(ABodyResponse: String) : iListaDadosCEP; virtual;
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
  vUrlRequest := Format(URL_VIACEP_POR_CEP, [ACEP, TTypeBuscaUtils.TypeBuscaToStr(FTipoBusca)]);

  vClient := THTTPClient.Create;
  try
    try
      vResponse := vClient.Get(vUrlRequest);

      case vResponse.StatusCode of
        200 : Result := getDadosResponse(vResponse.ContentAsString);
        400 : raise Exception.Create('CEP inválido');
        else raise Exception.Create('Falha ao Consultar Cep no ViaCep via XML. Erro: ' + vResponse.StatusCode.ToString);
      end;
    except
      on E: Exception do
      begin
        raise Exception.Create('Falha ao consulta CEP. Erro: ' + E.Message);
      end;
    end;

  finally
    vClient.Free;
  end;
end;

function TBuscaCEPService.BuscarCEPPorEndereco(AEstado, ACidade, AEndereco: String): iListaDadosCEP;
var
  vUrlRequest: String;
  vClient: THttpClient;
  vResponse: IHTTPResponse;
begin
  vUrlRequest := Format(URL_VIACEP_POR_ENDERECO, [AEstado,
                                                  ACidade,
                                                  AEndereco,
                                                  TTypeBuscaUtils.TypeBuscaToStr(FTipoBusca)]);

  vClient := THTTPClient.Create;
  try
    try
      vResponse := vClient.Get(vUrlRequest);

      case vResponse.StatusCode of
        200 : Result := getListDadosResponse(vResponse.ContentAsString);
        400 : raise Exception.Create('CEP inválido');
        else raise Exception.Create('Falha ao Consultar Cep no ViaCep via XML. Erro: ' + vResponse.StatusCode.ToString);
      end;
    except
      on E: Exception do
      begin
        raise Exception.Create('Falha ao consulta CEP. Erro: ' + E.Message);
      end;
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

function TBuscaCEPService.getListDadosResponse(ABodyResponse: String): iListaDadosCEP;
begin

end;

class function TBuscaCEPService.New: iBuscaCEPService;
begin
  Result := Self.Create;
end;

end.
