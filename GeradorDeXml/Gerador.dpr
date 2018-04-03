program Gerador;

uses
  Forms,
  Unit1 in 'Units\Unit1.pas' {Form1},
  MD_CET_TRP_TESTE in 'Units\MD_CET_TRP_TESTE.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
