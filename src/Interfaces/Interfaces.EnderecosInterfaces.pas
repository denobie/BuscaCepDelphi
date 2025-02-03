unit Interfaces.EnderecosInterfaces;

interface

uses
  Interfaces.Interfaces, System.Classes;

type
  iEnderecoService = interface
    ['{80CEC8A4-2B75-4CC8-A7C8-FFD49EC6C7D7}']
    function CEPJaCadastrado(ACEP: String; out ACodigoCEP: Integer): Boolean;
    function EnderecoJaCadastrado(AUf, ACidade, AEndereco: String; out ATotalRegistros: Integer): Boolean;

    function BuscarPorCEP(ACEP: String): iDadosCEP;
    //O certo aqui era um iQry
    //Como o tempo é curto, só abstraí a conexão ;)
    //mas depois é só trocar de TComponent para iQry
    function QryToDadosCEP(AQry: TComponent): iDadosCEP;
    function AtualizarEnderecos(AListaDadosCEP: iListaDadosCEP): iListaDadosCEP;
    function InserirLista(AListaDadosCEP: iListaDadosCEP): iListaDadosCEP;

    procedure Inserir(ADadosCEP: iDadosCEP);
    procedure Atualizar(ADadosCEP: iDadosCEP; ACodigoCEP: Integer);
    procedure Deletar(ACodigoCEP: Integer);
  end;

  iEnderecoFactory = interface
    ['{0AC6C96B-09CC-4519-89CE-2C2F1394319D}']
    function CriarEnderecoService: iEnderecoService;
  end;

implementation

end.
