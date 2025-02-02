unit Model.Conexoes.Interfaces;

interface

uses System.Classes;

type
  iConexaoParametros = interface;

  iConexao = interface
    ['{A4E3D663-9E01-49EE-BC21-69FD6C9FDFCE}']
    function Conectar: iConexao;
    procedure Desconectar;
    function EndConexao: TComponent;
    function Parametros: iConexaoParametros;
  end;

  iConexaoParametros = interface
    ['{4530C275-3AA4-4890-83DD-C85F24AE0B91}']
    function DriverName(Value: String) : iConexaoParametros;
    function Server(Value: String) : iConexaoParametros;
    function Database(Value: String) : iConexaoParametros;
    function User_Name(Value: String) : iConexaoParametros;
    function Password(Value: String) : iConexaoParametros;
    function Port(Value: String) : iConexaoParametros;
    function EndParametros: iConexao;
  end;

  iFactoryConexao = interface
    ['{DACD7342-849E-4252-8259-FDFF87B0162C}']
    function ConexaoFiredac: iConexao;
  end;

implementation

end.
