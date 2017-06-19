unit TesteWS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MD_CET_TRP_ABTRAAntaq, StdCtrls, MD_CSV_ABTRAAntaq, MD_CAT_AbtraAntaqConectorOut;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Memo2: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    lbCod: TLabel;
    lbMsg: TLabel;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  lCSV_ABTRAAntaq: CSV_ABTRAAntaq;
  i: integer;
begin
  //Montando o XML
  lCSV_ABTRAAntaq := CSV_ABTRAAntaq.Create();
  lCSV_ABTRAAntaq.MSV_limpar;
  lCSV_ABTRAAntaq.MSV_AddContainerCargaPerigosa('20','A','ELTO1000000','HV','1','12500', '2','5',0,'84');
  for i := 0 to 2 do
  begin
    lCSV_ABTRAAntaq.MSV_AddNCM('23','Vinte e tres');
    lCSV_ABTRAAntaq.MSV_AddCargaPerigosa('3.3','Carga', '8', '8');
  end;

  memo1.Text := lCSV_ABTRAAntaq.MAC_GetXMLEnvio();

  lCSV_ABTRAAntaq.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  lCAT_AbtraAntaqConectorOut : CAT_AbtraAntaqConectorOut;
  lCSV_ABTRAAntaq: CSV_ABTRAAntaq;
begin
  //Envio do XML gerado
  lCAT_AbtraAntaqConectorOut := CAT_AbtraAntaqConectorOut.Create;
  memo2.Text := lCAT_AbtraAntaqConectorOut.MSV_Enviar(memo1.Text);

  //Parse da resposta
  lCSV_ABTRAAntaq := CSV_ABTRAAntaq.Create();
  lCSV_ABTRAAntaq.MAC_SetXMLRetorno(memo2.Text);
  lbCod.Caption := lCSV_ABTRAAntaq.MAC_GetCodigoRetorno;
  lbMsg.Caption := lCSV_ABTRAAntaq.MAC_GetMensagemRetorno;

  lCAT_AbtraAntaqConectorOut.Free;
end;

end.
