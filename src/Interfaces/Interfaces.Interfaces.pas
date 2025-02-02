unit Interfaces.Interfaces;

interface

uses System.JSON;

type
  iDadosCEP = interface
    ['{F7D5A0DA-79B0-4361-ABA1-819C04B19E7D}']

    function GetCEP: String;
    function GetLogradouro: String;
    function GetComplemento: String;
    function GetUnidade: String;
    function GetBairro: String;
    function GetLocalidade: String;
    function GetUf: String;
    function GetEstado: String;
    function GetRegiao: String;
    function GetIBGE: Integer;
    function GetGia: String;
    function GetDDD: Integer;
    function GetSiafi: String;

    procedure SetCEP(const Value: String);
    procedure SetLogradouro(const Value: String);
    procedure SetComplemento(const Value: String);
    procedure SetUnidade(const Value: String);
    procedure SetBairro(const Value: String);
    procedure SetLocalidade(const Value: String);
    procedure SetUf(const Value: String);
    procedure SetEstado(const Value: String);
    procedure SetRegiao(const Value: String);
    procedure SetIBGE(const Value: Integer);
    procedure SetGia(const Value: String);
    procedure SetDDD(const Value: Integer);
    procedure SetSiafi(const Value: String);

    property CEP: String read GetCEP write SetCEP;
    property Logradouro: String read GetLogradouro write SetLogradouro;
    property Complemento: String read GetComplemento write SetComplemento;
    property Unidade: String read GetUnidade write SetUnidade;
    property Bairro: String read GetBairro write SetBairro;
    property Localidade: String read GetLocalidade write SetLocalidade;
    property Uf: String read GetUf write SetUf;
    property Estado: String read GetEstado write SetEstado;
    property Regiao: String read GetRegiao write SetRegiao;
    property IBGE: Integer read GetIBGE write SetIBGE;
    property Gia: String read GetGia write SetGia;
    property DDD: Integer read GetDDD write SetDDD;
    property Siafi: String read GetSiafi write SetSiafi;
  end;

  iCEPService = interface
    ['{F172ECDA-2DE7-437C-B1E2-776DF5C6F16A}']
    function BuscarCEP(ACEP: String): iDadosCEP;
  end;

  iBuscaCepFactory = interface
    ['{C6E4A3FA-5F76-4A1F-B8A7-8AC2E16C7E3D}']
    function CriarServico(const AFormato: string): ICepService;
  end;

implementation

end.
