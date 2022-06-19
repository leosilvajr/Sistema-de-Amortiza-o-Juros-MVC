program AmortizacaoJuros;

uses
  Vcl.Forms,
  unitPrincipal in 'unitPrincipal.pas' {frmPrincipal},
  unitViewSimulador in 'View\unitViewSimulador.pas' {frmViewSimulador},
  unitSplash in 'unitSplash.pas' {frmSplash},
  unitControllerSimulador in 'Controller\unitControllerSimulador.pas',
  unitModelSimulador in 'Model\unitModelSimulador.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
