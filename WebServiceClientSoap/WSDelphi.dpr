program WSDelphi;

uses
  Forms,
  TesteWS in 'Units\TesteWS.pas' {Form1},
  MD_CET_TRP_ABTRAAntaq in 'Units\MD_CET_TRP_ABTRAAntaq.pas',
  MD_CSV_ABTRAAntaq in 'Units\MD_CSV_ABTRAAntaq.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
