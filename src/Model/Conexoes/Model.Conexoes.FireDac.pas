unit Model.Conexoes.FireDac;

interface

uses Model.Conexoes.Interfaces, FireDAC.Comp.Client, System.Classes,
     FireDAC.Comp.UI, FireDAC.Phys.PG, FireDAC.Stan.Def;

type
  TConexadoFireDac = class(TInterfacedObject, iConexao, iConexaoParametros)
    private
      FConexao: TFDConnection;
      FDPhysPgDriverLink: TFDPhysPgDriverLink;
      FDriverName: String;
      FServer: String;
      FDatabase: String;
      FUser_Name: String;
      FPassword: String;
      FPort: String;
    procedure SetParametrosConexao;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iConexao;
      function EndConexao: TComponent;
      function Parametros: iConexaoParametros;

      function DriverName(Value: String) : iConexaoParametros;
      function Server(Value: String) : iConexaoParametros;
      function Database(Value: String) : iConexaoParametros;
      function User_Name(Value: String) : iConexaoParametros;
      function Password(Value: String) : iConexaoParametros;
      function Port(Value: String) : iConexaoParametros;
      function EndParametros: iConexao;
      function Conectar: iConexao;
      procedure Desconectar;
  end;

implementation

uses
  System.SysUtils, FireDAC.Stan.Intf;

{ TConexadoFireDac }

function TConexadoFireDac.Conectar: iConexao;
begin
  Result := Self;
  SetParametrosConexao;

  try
    FConexao.Connected := True;
  except
    on E: Exception do
    begin
      raise Exception.CreateFmt('Erro ao Conectar no Banco de Dados. Erro: %s', [e.Message]);
    end;
  end;
end;

constructor TConexadoFireDac.Create;
begin
  FConexao           := TFDConnection.Create(nil);
  FDPhysPgDriverLink := TFDPhysPgDriverLink.Create(nil);
end;

procedure TConexadoFireDac.Desconectar;
begin
  FDPhysPgDriverLink.Free;
  FConexao.Free;
end;

destructor TConexadoFireDac.Destroy;
begin

  inherited;
end;

class function TConexadoFireDac.New: iConexao;
begin
  Result := Self.Create;
end;

function TConexadoFireDac.EndConexao: TComponent;
begin
  Result := FConexao;
end;

function TConexadoFireDac.Database(Value: String): iConexaoParametros;
begin
  Result := Self;
  FDatabase := Value;
end;

function TConexadoFireDac.EndParametros: iConexao;
begin
  Result := Self;
end;

procedure TConexadoFireDac.SetParametrosConexao;
begin
  FConexao.FormatOptions.OwnMapRules := True;
  FConexao.FormatOptions.MapRules.Add(dtWideString, dtAnsiString);

  FConexao.DriverName := 'PG';
  FConexao.Params.Add(Format('Server=%s', [FServer]));
  FConexao.Params.Add(Format('Database=%s', [FDatabase]));
  FConexao.Params.Add(Format('User_name=%s', [FUser_Name]));
  FConexao.Params.Add(Format('Password=%s', [FPassword]));
  FConexao.Params.Add(Format('Port=%s', [FPort]));

  FDPhysPgDriverLink.VendorLib := 'E:\dev\github\BuscaCepDelphi\bin\libpq.dll';
end;

function TConexadoFireDac.Parametros: iConexaoParametros;
begin
  Result := Self;
end;

function TConexadoFireDac.DriverName(Value: String): iConexaoParametros;
begin
  Result      := Self;
  FDriverName := Value;
end;

function TConexadoFireDac.Password(Value: String): iConexaoParametros;
begin
  Result    := Self;
  FPassword := Value;
end;

function TConexadoFireDac.Port(Value: String): iConexaoParametros;
begin
  Result    := Self;
  FPort := Value;
end;

function TConexadoFireDac.Server(Value: String): iConexaoParametros;
begin
  Result    := Self;
  FServer := Value;
end;

function TConexadoFireDac.User_Name(Value: String): iConexaoParametros;
begin
  Result    := Self;
  FUser_Name := Value;
end;

end.
