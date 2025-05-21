program BuscaCepDelphi;

uses
  Vcl.Forms,
  Forms.Main in 'src\Forms\Forms.Main.pas' {FrmMain},
  Model.Conexoes.Interfaces in 'src\Model\Conexoes\Model.Conexoes.Interfaces.pas',
  Model.Conexoes.FireDac in 'src\Model\Conexoes\Model.Conexoes.FireDac.pas',
  Model.Conexoes.Factory.Conexao in 'src\Model\Conexoes\Model.Conexoes.Factory.Conexao.pas',
  Interfaces.Interfaces in 'src\Interfaces\Interfaces.Interfaces.pas',
  Interfaces.DadosCEP in 'src\Interfaces\Interfaces.DadosCEP.pas',
  Interfaces.BuscaCEPJsonService in 'src\Interfaces\Interfaces.BuscaCEPJsonService.pas',
  Interfaces.BuscaCepFactory in 'src\Interfaces\Interfaces.BuscaCepFactory.pas',
  Interfaces.BuscaCEPXmlService in 'src\Interfaces\Interfaces.BuscaCEPXmlService.pas',
  Interfaces.BuscaCEPService in 'src\Interfaces\Interfaces.BuscaCEPService.pas',
  Utils.BuscaCEPUtils in 'src\Utils\Utils.BuscaCEPUtils.pas',
  Forms.DadosCep in 'src\Forms\Forms.DadosCep.pas' {FrmDadosCEP},
  Interfaces.ListaDadosCEP in 'src\Interfaces\Interfaces.ListaDadosCEP.pas',
  Interfaces.EnderecosInterfaces in 'src\Interfaces\Interfaces.EnderecosInterfaces.pas',
  Interfaces.EnderecoService in 'src\Interfaces\Interfaces.EnderecoService.pas',
  Interfaces.EnderecoFactory in 'src\Interfaces\Interfaces.EnderecoFactory.pas',
  Utils.Types in 'src\Utils\Utils.Types.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmDadosCEP, FrmDadosCEP);
  Application.Run;
end.
