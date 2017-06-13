unit TesteWS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MD_CET_TRP_ABTRAAntaq, StdCtrls, MD_CSV_ABTRAAntaq;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  lCSV_ABTRAAntaq: CSV_ABTRAAntaq;
  lin: integer;

begin
  lCSV_ABTRAAntaq := CSV_ABTRAAntaq.Create();
  lCSV_ABTRAAntaq.MSV_limpar;
  lCSV_ABTRAAntaq.MSV_AddContainerCargaPerigosa('20','11','hv40','iso','20','40', 'A','60',2,'085');
  for lin := 0 to 2 do
  begin
     lCSV_ABTRAAntaq.MSV_AddNCM('TE','TESTE');
     lCSV_ABTRAAntaq.MSV_AddCargaPerigosa('3','IMO', 'UN', 'ONU')
  end;
                   
  memo1.Text := lCSV_ABTRAAntaq.MSV_GetXMLEnvio();

  lCSV_ABTRAAntaq.Free;
end;

end.
