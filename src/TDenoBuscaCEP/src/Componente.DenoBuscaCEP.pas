unit Componente.DenoBuscaCEP;

interface

uses System.Classes, Utils.Types, Interfaces.BuscaCepFactory,
     Interfaces.Interfaces;

type
  TDenoBuscaCEP = class(TComponent)
  private
    FTipoBusca: TTypeBusca;
    FExecute: Boolean;
    FCEP: String;
    FRetorno: iDadosCEP;

    procedure SetExecute(const Value: Boolean);
  published
    property CEP: String read FCEP write FCEP;
    property Execute: Boolean read FExecute write SetExecute;
    property TipoBusca: TTypeBusca read FTipoBusca write FTipoBusca;
    property Retorno: iDadosCEP read FRetorno write FRetorno;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('DenoBuscaCEP', [TDenoBuscaCEP])
end;

{ TDenoBuscaCEP }

procedure TDenoBuscaCEP.SetExecute(const Value: Boolean);
begin
  FExecute := Value;

  if FExecute then
  begin
    Self.Retorno := TBuscaCepFactory.New.CriarServicoBuscaCEP(Self.TipoBusca)
                      .BuscarCEP(Self.CEP);
  end;

  FExecute := False;
end;

end.
