unit Interfaces.BuscaCEPXmlService;

interface

uses
  Interfaces.Interfaces, Interfaces.BuscaCEPService, Utils.BuscaCEPUtils;

type
  TBuscaCEPXmlService = class(TBuscaCEPService)
    private

    public
      constructor Create;
      destructor Destroy; override;
      class function New: iBuscaCEPService;
      function getDadosResponse(ABodyResponse: String) : iDadosCEP;  override;
  end;


implementation

uses
  Xml.XMLDoc, Xml.XMLIntf, System.SysUtils,
  Interfaces.DadosCEP, System.Variants;

{ TBuscaCEPViaXmlService }

constructor TBuscaCEPXmlService.Create;
begin
  FTipoBusca := ttbXML;
end;

destructor TBuscaCEPXmlService.Destroy;
begin

  inherited;
end;

class function TBuscaCEPXmlService.New: iBuscaCEPService;
begin
  Result := Self.Create;
end;

function TBuscaCEPXmlService.getDadosResponse(ABodyResponse: String): iDadosCEP;
var
  vXML: IXMLDocument;
  vRootNode: IXMLNode;
  vDadosCEP: iDadosCEP;
begin
  vXML := TXMLDocument.Create(nil);
  vXML.LoadFromXML(ABodyResponse);
  vRootNode := vXML.DocumentElement;

  vDadosCEP := TDadosCEP.Create;

  vDadosCEP.CEP         := VarToStr(vRootNode.ChildValues['cep']);
  vDadosCEP.Logradouro  := VarToStr(vRootNode.ChildValues['logradouro']);
  vDadosCEP.Complemento := VarToStr(vRootNode.ChildValues['complemento']);
  vDadosCEP.Unidade     := VarToStr(vRootNode.ChildValues['unidade']);
  vDadosCEP.Bairro      := VarToStr(vRootNode.ChildValues['bairro']);
  vDadosCEP.Localidade  := VarToStr(vRootNode.ChildValues['localidade']);
  vDadosCEP.Uf          := VarToStr(vRootNode.ChildValues['uf']);
  vDadosCEP.Estado      := VarToStr(vRootNode.ChildValues['estado']);
  vDadosCEP.IBGE        := StrToIntDef(VarToStr(vRootNode.ChildValues['ibge']), 0);
  vDadosCEP.Gia         := VarToStr(vRootNode.ChildValues['gia']);
  vDadosCEP.DDD         := StrToIntDef(VarToStr(vRootNode.ChildValues['ddd']), 0);
  vDadosCEP.Siafi       := VarToStr(vRootNode.ChildValues['siafi']);
  vDadosCEP.Erro        := VarToStr(vRootNode.ChildValues['erro']).Equals('true');

  Result := vDadosCEP;
end;

end.
