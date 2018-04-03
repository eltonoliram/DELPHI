unit Unit1;

interface

uses
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Windows,
  Dialogs, StdCtrls;
type


  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

  end;
  function echo: pchar; stdcall; external 'ClassLibrary1.dll';

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  label1.Caption := string(Echo);
end;

end.
