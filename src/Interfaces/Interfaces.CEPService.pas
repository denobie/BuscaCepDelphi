unit Interfaces.CEPService;

interface

uses
  Interfaces.Interfaces;

type
  TCEPService = class(TInterfacedObject, iCEPViaJsonService)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iCEPViaJsonService;
      function BuscarCEP(ACEP: String): iDadosCEP;
  end;


implementation

{ TCEPService }

function TCEPService.BuscarCEP(ACEP: String): iDadosCEP;
begin
//
end;

constructor TCEPService.Create;
begin

end;

destructor TCEPService.Destroy;
begin

  inherited;
end;

class function TCEPService.New: iCEPViaJsonService;
begin
  Result := Self.Create;
end;

end.
