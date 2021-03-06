unit unitViewSimulador; //Unit responsável pela Interface com o Usuário

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Samples.Spin, Vcl.ComCtrls, Math, Vcl.Mask;

type

  TfrmViewSimulador = class(TForm)
    pnlTopo: TPanel;
    lblCapital: TLabel;
    lblJuros: TLabel;
    lblPeriodos: TLabel;
    editTaxa: TEdit;
    btnSimular: TBitBtn;
    lvDetalles: TListView;
    editCapital: TEdit;
    editPeriodo: TEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnSimularClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EnterKeyPress(Sender: TObject; var Key: Char);
    procedure MudancaDeFoco(Sender:TObject);

  private

  public

  end;

var
  frmViewSimulador: TfrmViewSimulador;

implementation

{$R *.dfm}

uses unitPrincipal, unitControllerSimulador;

{ TfrmSimulador }

procedure TfrmViewSimulador.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmViewSimulador.btnSimularClick(Sender: TObject);
var
  I: Integer;
  Capital, Taxa : real;
  Periodos : integer;

  ListaRegistros : TListaRegistros;

  Function formatavalor(valor: real):string;
  begin
    Result := FormatFloat('###,###,###,###,##0.00', valor);
  end;

begin
  Capital  := StrToFloatDef(editCapital.Text, 0);
  Taxa     := StrToFloatDef(editTaxa.Text, 0) / 100;
  Periodos := StrToIntDef(editPeriodo.Text, 0);

  ListaRegistros := TControllerSimulador.SimularAmortizacao(Capital,Taxa,Periodos);

  lvDetalles.Items.Clear;


  for I := 0 to Length(ListaRegistros)-1 do
  begin
    if I = 0 then
    begin
      with lvDetalles.Items.Add() do
      begin
        GroupID := 0;

        Caption := inttostr(0);
        SubItems.Add(formatavalor(ListaRegistros[I].Juros));
        SubItems.Add(formatavalor(ListaRegistros[I].Amort));
        SubItems.Add(formatavalor(ListaRegistros[I].Pag));
        SubItems.Add(formatavalor(ListaRegistros[I].Saldo));
      end;
    end
    else if I < Length(ListaRegistros)-1 then
    begin
      with lvDetalles.Items.Add() do
      begin
        GroupID := 1;
        Caption := inttostr(I);
        SubItems.Add(formatavalor(ListaRegistros[I].Juros));
        SubItems.Add(formatavalor(ListaRegistros[I].Amort));
        SubItems.Add(formatavalor(ListaRegistros[I].Pag));
        SubItems.Add(formatavalor(ListaRegistros[I].Saldo));
      end;
    end
    else
    begin
      with lvDetalles.Items.Add() do
      begin
        GroupID := 2;
        Caption := 'Totais';
        SubItems.Add(formatavalor(ListaRegistros[I].Juros));
        SubItems.Add(formatavalor(ListaRegistros[I].Amort));
        SubItems.Add(formatavalor(ListaRegistros[I].Pag));
        SubItems.Add(formatavalor(ListaRegistros[I].Saldo));
      end;
    end;
  end;

end;

procedure TfrmViewSimulador.EnterKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
  end;
end;

procedure TfrmViewSimulador.FormActivate(Sender: TObject);
begin
  MudancaDeFoco(nil);
end;


procedure TfrmViewSimulador.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TfrmViewSimulador.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;
end;

procedure TfrmViewSimulador.FormCreate(Sender: TObject);
var
  I: Integer;

begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 7;
  Top := (GetSystemMetrics(SM_CYSCREEN) -  Height) div 10;

  for I := 0 to ComponentCount-1 do
    if Components[I] iS TEdit then
      (Components[I] as TEdit).OnEnter := MudancaDeFoco;
end;

procedure TfrmViewSimulador.MudancaDeFoco(Sender: TObject);
var
  I:Integer;
  Ed: TEdit;
begin
  for I := 0 to ComponentCount-1 do
  begin
    if Components[I] iS TEdit then
    Begin
      Ed:= Components[I] as TEdit;
      if Ed.Focused then
        Ed.Color := clYellow
      else
        Ed.Color :=clWhite;
    End;
  end;
end;

end.
