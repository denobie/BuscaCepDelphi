unit Interfaces.BuscaCepFactory;

interface

uses
  Interfaces.Interfaces;

type
  TBuscaCepFactory = class(TInterfacedObject, iBuscaCepFactory)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iBuscaCepFactory;
      function CriarServico(const AFormato: string): ICepService;
  end;

implementation

uses
  System.SysUtils, Interfaces.CEPViaJsonService;

{ TBuscaCepFactory }

constructor TBuscaCepFactory.Create;
begin

end;

function TBuscaCepFactory.CriarServico(const AFormato: string): ICepService;
begin
  if AFormato.ToUpper = 'JSON' then
  begin
    Result := TCEPViaJsonService.New;
  end
  else
  begin
    raise Exception.Create('Não Implementado');
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
