unit unitModelSimulador;

interface

uses
  unitControllerSimulador;

type
  TSimulador = class
  private
    FListaRegistros: TListaRegistros;
    FTaxa: real;
    FNumPeriodos: integer;
    FCapital: real;

    procedure SetCapital(const Value: real);
    procedure SetListaRegistros(const Value: TListaRegistros);
    procedure SetNumPeriodos(const Value: integer);
    procedure SetTaxa(const Value: real);
  published

     property Capital : real read FCapital write SetCapital;
     property Taxa : real read FTaxa write SetTaxa;
     property NumPeriodos : integer read FNumPeriodos write SetNumPeriodos;

     property ListaRegistros : TListaRegistros read FListaRegistros write SetListaRegistros;


     function SimularAmortizacao(): TListaRegistros;
   end;

implementation

uses math, SysUtils;

{ TSimulador }

procedure TSimulador.SetCapital(const Value: real);
begin
  FCapital := Value;
end;

procedure TSimulador.SetListaRegistros(const Value: TListaRegistros);
begin
  FListaRegistros := Value;
end;

procedure TSimulador.SetNumPeriodos(const Value: integer);
begin
  FNumPeriodos := Value;
end;

procedure TSimulador.SetTaxa(const Value: real);
begin
  FTaxa := Value;
end;

function TSimulador.SimularAmortizacao(): TListaRegistros;
var

  I: Integer;
  JurosAcum, CapitalAtualizado, JurosAtualizado : real;
begin

  SetLength(FListaRegistros, 0);

  JurosAcum := 0;
  CapitalAtualizado := FCapital;


  SetLength(FListaRegistros, 1);
  with FListaRegistros[0] do
  begin
    Periodo  := '0';
    Juros    := 0;
    Amort    := 0;
    Pag      := 0;
    Saldo    := CapitalAtualizado;
  end;

  for I := 1 to FNumPeriodos do
  begin

    SetLength(FListaRegistros, length(FListaRegistros)+1);
    with FListaRegistros[length(FListaRegistros)-1] do
    begin
      Amort := 0;
      Pag   := 0;

      JurosAtualizado := RoundTo(CapitalAtualizado * FTaxa, -2);
      JurosAcum := JurosAcum + JurosAtualizado;
      if I = FNumPeriodos then
      begin
        Pag := RoundTo(CapitalAtualizado + JurosAtualizado, -2);
        CapitalAtualizado := 0;
        Amort := FCapital;
      end
      else
      begin
        CapitalAtualizado := RoundTo(CapitalAtualizado + JurosAtualizado, -2);
      end;

      Periodo := IntToStr(I);
      Juros := JurosAtualizado;
      Saldo := CapitalAtualizado;
    end;
  end;


  SetLength(FListaRegistros, length(FListaRegistros)+1);
  with FListaRegistros[length(FListaRegistros)-1] do
  begin
    Periodo := 'Totais';
    Amort := 0;
    Pag   := 0;
    Juros := JurosAcum;
    Saldo := CapitalAtualizado;
  end;

  Result := FListaRegistros;
end;

end.
