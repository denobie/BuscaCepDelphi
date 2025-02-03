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
      function getListDadosResponse(ABodyResponse: String) : iListaDadosCEP; override;
  end;


implementation

uses
  System.JSON, System.SysUtils, Interfaces.DadosCEP, System.Classes,
  System.Generics.Collections, Interfaces.ListaDadosCEP,
  System.RegularExpressions;

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
  vBodyResponse := nil;
  try
    vBodyResponse := (TJSONValue.ParseJSONValue(ABodyResponse) as TJSONObject);
    vDadosCEP := TDadosCEP.Create;

    vDadosCEP.CEP         := TRegEx.Replace(vBodyResponse.GetValue<string>('cep', ''), '[-.]', '');
    vDadosCEP.Logradouro  := vBodyResponse.GetValue<string>('logradouro', '');
    vDadosCEP.Complemento := vBodyResponse.GetValue<string>('complemento', '');
    vDadosCEP.Unidade     := vBodyResponse.GetValue<string>('unidade', '');
    vDadosCEP.Bairro      := vBodyResponse.GetValue<string>('bairro', '');
    vDadosCEP.Localidade  := vBodyResponse.GetValue<string>('localidade', '');
    vDadosCEP.Uf          := vBodyResponse.GetValue<string>('uf', '');
    vDadosCEP.Regiao      := vBodyResponse.GetValue<string>('regiao', '');
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

function TBuscaCEPJsonService.getListDadosResponse(ABodyResponse: String): iListaDadosCEP;
var
  i: Integer;
  vJsonArray: TJSONArray;
  vJsonValue: TJSONValue;
  vListDadosCEP: iListaDadosCEP;
  vDadosCEP: iDadosCEP;
begin
  vListDadosCEP := TListaDadosCEP.Create;
  vJsonArray := nil;
  try
    vJsonArray := TJSONObject.ParseJSONValue(ABodyResponse) as TJSONArray;

    if vJsonArray.Count > 0 then
    begin

      for i := 0 to Pred(vJsonArray.Count) do
      begin
        vJsonValue := vJsonArray.Items[i];

        vDadosCEP := TDadosCEP.Create;
        vDadosCEP.CEP         := TRegEx.Replace(vJsonValue.GetValue<string>('cep', ''), '[-.]', '');
        vDadosCEP.Logradouro  := vJsonValue.GetValue<string>('logradouro', '');
        vDadosCEP.Complemento := vJsonValue.GetValue<string>('complemento', '');
        vDadosCEP.Unidade     := vJsonValue.GetValue<string>('unidade', '');
        vDadosCEP.Bairro      := vJsonValue.GetValue<string>('bairro', '');
        vDadosCEP.Localidade  := vJsonValue.GetValue<string>('localidade', '');
        vDadosCEP.Uf          := vJsonValue.GetValue<string>('uf', '');
        vDadosCEP.Regiao      := vJsonValue.GetValue<string>('regiao', '');
        vDadosCEP.Estado      := vJsonValue.GetValue<string>('estado', '');
        vDadosCEP.IBGE        := StrToIntDef(vJsonValue.GetValue<string>('ibge', ''), 0);
        vDadosCEP.Gia         := vJsonValue.GetValue<string>('gia', '');
        vDadosCEP.DDD         := StrToIntDef(vJsonValue.GetValue<string>('ddd', ''), 0);
        vDadosCEP.Siafi       := vJsonValue.GetValue<string>('siafi', '');
        vDadosCEP.Erro        := vJsonValue.GetValue<string>('erro', '').Equals('true');

        vListDadosCEP.Items.Add(vDadosCEP);
      end;
    end;

    Result := vListDadosCEP;
  finally
    vJsonArray.Free;
  end;
end;

end.
