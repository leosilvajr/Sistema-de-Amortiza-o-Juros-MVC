unit unitSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.ComCtrls, Vcl.StdCtrls;

type
  TfrmSplash = class(TForm)
    pnlPrincipal: TPanel;
    imgLogo: TImage;
    lblStatus: TLabel;
    progressBar: TProgressBar;
    timer: TTimer;
    procedure timerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

uses unitPrincipal, unitViewSimulador;

procedure TfrmSplash.timerTimer(Sender: TObject);
begin
  if progressBar.Position <= 100 then
    Begin
      progressBar.StepIt;
      case progressBar.Position of
        8  :lblStatus.Caption := 'Carregando depend�ncias...';
        36 :lblStatus.Caption := 'Carregando configura��es...';
        72 :lblStatus.Caption := 'Iniciando o Sistema...';
      end;
    End;
  if progressBar.Position = 100 then
    Close;
end;

end.
