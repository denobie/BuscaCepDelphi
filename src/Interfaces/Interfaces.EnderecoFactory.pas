unit Interfaces.EnderecoFactory;

interface

uses
  Interfaces.EnderecosInterfaces, Model.Conexoes.Interfaces;

type
  TEnderecoFactory = class(TInterfacedObject, iEnderecoFactory)
    private
      FConexao: iConexao;
    public
      constructor Create(AConexao: iConexao);
      destructor Destroy; override;
      class function New(AConexao: iConexao): iEnderecoFactory;

      function CriarEnderecoService: iEnderecoService;
  end;


implementation

uses
  Interfaces.EnderecoService;

{ TEnderecoFactory }

constructor TEnderecoFactory.Create(AConexao: iConexao);
begin
  FConexao := AConexao;
end;

function TEnderecoFactory.CriarEnderecoService: iEnderecoService;
begin
  Result := TEnderecoService.New(FConexao);
end;

destructor TEnderecoFactory.Destroy;
begin

  inherited;
end;

class function TEnderecoFactory.New(AConexao: iConexao): iEnderecoFactory;
begin
  Result := Self.Create(AConexao);
end;

end.
