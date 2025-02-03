unit Interfaces.ListaDadosCEP;

interface

uses
  Interfaces.Interfaces, System.Generics.Collections;

type
  TListaDadosCEP = class(TInterfacedObject, iListaDadosCEP)
    private
      FListaDadosCEP: TList<iDadosCEP>;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iListaDadosCEP;
      function GetItems: TList<iDadosCEP>;
  end;


implementation

{ TListaDadosCEP }

constructor TListaDadosCEP.Create;
begin
  FListaDadosCEP := TList<iDadosCEP>.Create;
end;

destructor TListaDadosCEP.Destroy;
begin
  FListaDadosCEP.Free;
  inherited;
end;

function TListaDadosCEP.GetItems: TList<iDadosCEP>;
begin
  Result := FListaDadosCEP;
end;

class function TListaDadosCEP.New: iListaDadosCEP;
begin
  Result := Self.Create;
end;

end.
