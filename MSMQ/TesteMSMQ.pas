unit TesteMSMQ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActiveX, StdCtrls, MSMQ_TLB, ComObj;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
  queueinfo: IMSMQQueueInfo;
  queue: IMSMQQueue;
  msg: IMSMQMessage;
  tr, wdq, wb, rt: OLEVariant;
begin
    try
        queueinfo := CreateCOMObject(CLASS_MSMQQueueInfo) as IMSMQQueueInfo;
        queueinfo.PathName := PCHAR('.\PRIVATE$\IDG');
        queue := queueinfo.Open (MQ_RECEIVE_ACCESS, MQ_DENY_NONE);
        if queue.IsOpen=1  then
        begin
          try
            tr := MQ_SINGLE_MESSAGE;
            wdq := False;
            wb := True;
            rt := 1000;
            msg := queue.Receive (tr, wdq, wb, rt);
            if msg <> nil then
            begin
              Showmessage(msg.body);
              Showmessage(msg.label_);
            end;

          finally
            queue.close;
          end;
        end;
    except
      on e: exception do
        Showmessage(e.message) ;
    end;
end;


procedure TForm1.Button2Click(Sender: TObject);
var
  queueinfo: IMSMQQueueInfo;
  queue: IMSMQQueue;
  msg: IMSMQMessage;
  tr: OLEVariant;
begin
  try
    queueinfo := CreateCOMObject (CLASS_MSMQQueueInfo) as IMSMQQueueInfo;
    queueinfo.PathName := PCHAR('.\PRIVATE$\IDG');
    queue := queueinfo.Open (MQ_SEND_ACCESS, MQ_DENY_NONE);
    if queue.IsOpen = 1 then
    begin
      try
        msg := CreateCOMObject (CLASS_MSMQMessage) as IMSMQMessage;
        msg.label_ := 'Teste';
        msg.body := 'Isso é um teste';
        tr := MQ_NO_TRANSACTION;
        msg.Send (queue, tr);

      finally
        queue.close;
      end;
    end;
  except
    on e: exception do showmessage (e.message);
  end;
end;

end.
