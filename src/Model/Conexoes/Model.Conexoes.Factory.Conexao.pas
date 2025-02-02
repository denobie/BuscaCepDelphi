unit Model.Conexoes.Factory.Conexao;

interface

uses
  Model.Conexoes.Interfaces, Model.Conexoes.FireDac;

type
  TFactoryConexao = class(TInterfacedObject, iFactoryConexao)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iFactoryConexao;

      function ConexaoFiredac: iConexao;
  end;


implementation

{ TFactoryConexao }

function TFactoryConexao.ConexaoFiredac: iConexao;
begin
  Result := TConexadoFireDac.New;
end;

constructor TFactoryConexao.Create;
begin

end;

destructor TFactoryConexao.Destroy;
begin

  inherited;
end;

class function TFactoryConexao.New: iFactoryConexao;
begin
  Result := Self.Create;
end;

end.
