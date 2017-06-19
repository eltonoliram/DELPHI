unit MD_CAT_AbtraAntaqConectorOut;

interface

uses 
  IdHttp, SysUtils, Classes, IdSSLOpenSSL;

type
  tyAmbiente = (amProducao, amHomologacao);

  CAT_AbtraAntaqConectorOut = class
  private
    ARL_idHTTP: TIdHTTP;
    ARL_URL: string;
    ARL_inHTTPCode: Integer;
    ARL_stResposta: string;
  public
    function MSV_enviar(prstXML: string): string;
    function MAC_GetResponse():string;
    constructor Create(ltyAmbiente: tyAmbiente = amHomologacao);
    destructor destroy; override;
  end;

implementation

{ CAT_AbtraAntaqConectorOut }

constructor CAT_AbtraAntaqConectorOut.Create(ltyAmbiente: tyAmbiente = amHomologacao);
begin
  inherited Create;

  ARL_idHTTP := TIdHTTP.Create;
  if ltyAmbiente = amHomologacao then
    ARL_URL := 'https://www.janelaunicaportuaria.org.br/ws_homologacao/cargasperigosas/CargaPerigosaService.svc'
  else;
    //ARL_URL := 'https://www.janelaunicaportuaria.org.br/ws/cargasperigosas/CargaPerigosaService.svc'

  ARL_idHTTP.Request.Connection := 'Keep-Alive';
  ARL_idHTTP.Request.ContentType := 'text/xml;charset=UTF-8';
  ARL_idHTTP.Request.CustomHeaders.Add('SOAPAction: "http://portodesantos.com.br/servicos/atracacao/cargaperigosa/Cadastrar"');
  ARL_idHTTP.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create;
  (ARL_idHTTP.IOHandler as TIdSSLIOHandlerSocketOpenSSL).SSLOptions.Method := sslvSSLv23;
end;

destructor CAT_AbtraAntaqConectorOut.destroy;
begin
  ARL_idHTTP.Free;
  inherited;
end;

function CAT_AbtraAntaqConectorOut.MAC_GetResponse: string;
begin
  Result := ARL_stResposta;
end;

function CAT_AbtraAntaqConectorOut.MSV_enviar(prstXML: string): string;
var
  lssRequest: TStringStream;
  lssResponse: TStringStream;
  lstErro: string;
begin
  lstErro := '';
  ARL_stResposta := '';
  ARL_inHTTPCode := 0;
  lssRequest := TStringStream.Create(prstXML);
  lssResponse := TStringStream.Create('');

  try
    ARL_idHTTP.Post(ARL_URL, lssRequest,lssResponse);
    ARL_stResposta := lssResponse.DataString;
    ARL_inHTTPCode := ARL_idHTTP.ResponseCode;
  except
    on e: Exception do
    begin
      if e is EIdHTTPProtocolException then
      begin
        ARL_stResposta := (e as EIdHTTPProtocolException).ErrorMessage;
        ARL_inHTTPCode := (e as EIdHTTPProtocolException).ErrorCode;
      end;
      lstErro := e.message;
    end;
  end;

  Result := lstErro;
end;

end.
