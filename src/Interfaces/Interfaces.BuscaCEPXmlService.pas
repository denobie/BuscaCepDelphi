unit Interfaces.BuscaCEPXmlService;

interface

uses
  Interfaces.Interfaces, Interfaces.BuscaCEPService, Utils.Types;

type
  TBuscaCEPXmlService = class(TBuscaCEPService)
    private

    public
      constructor Create;
      destructor Destroy; override;
      class function New: iBuscaCEPService;
      function getDadosResponse(ABodyResponse: String) : iDadosCEP;  override;
      function getListDadosResponse(ABodyResponse: String) : iListaDadosCEP; override;
  end;


implementation

uses
  Xml.XMLDoc, Xml.XMLIntf, System.SysUtils,
  Interfaces.DadosCEP, System.Variants, System.RegularExpressions,
  Interfaces.ListaDadosCEP;

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

  vDadosCEP.CEP         := TRegEx.Replace(VarToStr(vRootNode.ChildValues['cep']), '[-.]', '');
  vDadosCEP.Logradouro  := VarToStr(vRootNode.ChildValues['logradouro']);
  vDadosCEP.Complemento := VarToStr(vRootNode.ChildValues['complemento']);
  vDadosCEP.Unidade     := VarToStr(vRootNode.ChildValues['unidade']);
  vDadosCEP.Bairro      := VarToStr(vRootNode.ChildValues['bairro']);
  vDadosCEP.Localidade  := VarToStr(vRootNode.ChildValues['localidade']);
  vDadosCEP.Uf          := VarToStr(vRootNode.ChildValues['uf']);
  vDadosCEP.Regiao      := VarToStr(vRootNode.ChildValues['regiao']);
  vDadosCEP.Estado      := VarToStr(vRootNode.ChildValues['estado']);
  vDadosCEP.IBGE        := StrToIntDef(VarToStr(vRootNode.ChildValues['ibge']), 0);
  vDadosCEP.Gia         := VarToStr(vRootNode.ChildValues['gia']);
  vDadosCEP.DDD         := StrToIntDef(VarToStr(vRootNode.ChildValues['ddd']), 0);
  vDadosCEP.Siafi       := VarToStr(vRootNode.ChildValues['siafi']);
  vDadosCEP.Erro        := VarToStr(vRootNode.ChildValues['erro']).Equals('true');

  Result := vDadosCEP;
end;

function TBuscaCEPXmlService.getListDadosResponse(ABodyResponse: String): iListaDadosCEP;
var
  vXML: IXMLDocument;
  vRootNode, vEnderecos, vEndereco: IXMLNode;
  i: Integer;
  vDadosCEP: iDadosCEP;
  vListaDadosCEP: iListaDadosCEP;
begin
  vListaDadosCEP := TListaDadosCEP.Create;
  vXML := TXMLDocument.Create(nil);
  vRootNode := nil;
  vEnderecos:= nil;
  vEndereco := nil;

  vXML.LoadFromXML(ABodyResponse);
  vRootNode := vXML.DocumentElement;

  vEnderecos := vRootNode.ChildNodes.FindNode('enderecos');

  for i := 0 to Pred(vEnderecos.ChildNodes.Count) do
  begin
    vEndereco := vEnderecos.ChildNodes[i];

    vDadosCEP := TDadosCEP.Create;

    vDadosCEP.CEP         := TRegEx.Replace(VarToStr(vEndereco.ChildValues['cep']), '[-.]', '');
    vDadosCEP.Logradouro  := VarToStr(vEndereco.ChildValues['logradouro']);
    vDadosCEP.Complemento := VarToStr(vEndereco.ChildValues['complemento']);
    vDadosCEP.Unidade     := VarToStr(vEndereco.ChildValues['unidade']);
    vDadosCEP.Bairro      := VarToStr(vEndereco.ChildValues['bairro']);
    vDadosCEP.Localidade  := VarToStr(vEndereco.ChildValues['localidade']);
    vDadosCEP.Uf          := VarToStr(vEndereco.ChildValues['uf']);
    vDadosCEP.Regiao      := VarToStr(vEndereco.ChildValues['regiao']);
    vDadosCEP.Estado      := VarToStr(vEndereco.ChildValues['estado']);
    vDadosCEP.IBGE        := StrToIntDef(VarToStr(vEndereco.ChildValues['ibge']), 0);
    vDadosCEP.Gia         := VarToStr(vEndereco.ChildValues['gia']);
    vDadosCEP.DDD         := StrToIntDef(VarToStr(vEndereco.ChildValues['ddd']), 0);
    vDadosCEP.Siafi       := VarToStr(vEndereco.ChildValues['siafi']);
    vDadosCEP.Erro        := VarToStr(vEndereco.ChildValues['erro']).Equals('true');

    vListaDadosCEP.Items.Add(vDadosCEP);
  end;

  Result := vListaDadosCEP;
end;

end.
