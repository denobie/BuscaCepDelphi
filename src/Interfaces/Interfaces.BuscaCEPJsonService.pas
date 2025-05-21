unit Interfaces.BuscaCEPJsonService;

interface

uses
  Interfaces.Interfaces, Interfaces.BuscaCEPService, Utils.Types;

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
  REST.Json, System.RegularExpressions;

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
  vDadosCEP: iDadosCEP;
begin
  vDadosCEP := TJson.JsonToObject<TDadosCEP>(ABodyResponse);
  vDadosCEP.CEP := TRegEx.Replace(vDadosCEP.CEP, '[-.]', '');

  Result := vDadosCEP;
end;

function TBuscaCEPJsonService.getListDadosResponse(ABodyResponse: String): iListaDadosCEP;
var
  i: Integer;
  vJsonArray: TJSONArray;
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
        vDadosCEP := TJson.JsonToObject<TDadosCEP>(vJsonArray.Items[i].ToJSON);
        vDadosCEP.CEP := TRegEx.Replace(vDadosCEP.CEP, '[-.]', '');

        vListDadosCEP.Items.Add(vDadosCEP);
      end;
    end;

    Result := vListDadosCEP;
  finally
    vJsonArray.Free;
  end;
end;

end.
