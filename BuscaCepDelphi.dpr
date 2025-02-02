program BuscaCepDelphi;

uses
  Vcl.Forms,
  Forms.Main in 'src\Forms\Forms.Main.pas' {Form1},
  Model.Conexoes.Interfaces in 'src\Model\Conexoes\Model.Conexoes.Interfaces.pas',
  Model.Conexoes.FireDac in 'src\Model\Conexoes\Model.Conexoes.FireDac.pas',
  Model.Conexoes.Factory.Conexao in 'src\Model\Conexoes\Model.Conexoes.Factory.Conexao.pas',
  Interfaces.Interfaces in 'src\Interfaces\Interfaces.Interfaces.pas',
  Interfaces.DadosCEP in 'src\Interfaces\Interfaces.DadosCEP.pas',
  Interfaces.CEPViaJsonService in 'src\Interfaces\Interfaces.CEPViaJsonService.pas',
  Interfaces.BuscaCepFactory in 'src\Interfaces\Interfaces.BuscaCepFactory.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
