unit Interfaces.BuscaCepFactory;

interface

uses
  Interfaces.Interfaces, Utils.Types;

type
  TBuscaCepFactory = class(TInterfacedObject, iBuscaCepFactory)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iBuscaCepFactory;
      function CriarServicoBuscaCEP(AFormato: TTypeBusca): iBuscaCEPService;
  end;

implementation

uses
  System.SysUtils,
  Interfaces.BuscaCEPJsonService, Interfaces.BuscaCEPXmlService;

{ TBuscaCepFactory }

constructor TBuscaCepFactory.Create;
begin

end;

function TBuscaCepFactory.CriarServicoBuscaCEP(AFormato: TTypeBusca): iBuscaCEPService;
begin
  case AFormato of
    ttbJSON: Result := TBuscaCEPJsonService.New;
    ttbXML:  Result := TBuscaCEPXmlService.New;
    else raise Exception.Create('Tipo de Busca não implementado.');
  end;
end;

destructor TBuscaCepFactory.Destroy;
begin

  inherited;
end;

class function TBuscaCepFactory.New: iBuscaCepFactory;
begin
  Result := Self.Create;
end;

end.
