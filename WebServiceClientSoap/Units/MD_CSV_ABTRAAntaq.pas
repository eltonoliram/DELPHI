unit MD_CSV_ABTRAAntaq;

interface

uses
  MD_CET_TRP_ABTRAAntaq, XMLDoc, XMLIntf, ActiveX, SysUtils, Contnrs, Classes, HTTPApp;

type
  CSV_ABTRAAntaq = class(TObject)
  private
    AIM_CET_TRP_ContainerCargaPerigosa : CET_TRP_ContainerCargaPerigosa;
    AIM_CodigoRetorno: string;
    AIM_MensagemRetorno: string;
    function MIM_XMLToSOAPEnv(prstXML: string): string;
  public
    procedure MSV_AddContainerCargaPerigosa(prstAltura: string;
                                            prstBloco: string;
                                            prstConteiner: string;
                                            prstISOCode: string;
                                            prstLastro: string;
                                            prstPeso: string;
                                            prstPilha: string;
                                            prstQuadra: string;
                                            prinSituacao: Integer;
                                            prstTerminal: string);
    function MSV_AddNCM(prstCodigo: string; prstDescricao: string): Integer;
    function MSV_AddCargaPerigosa(prstClassificacao: string;
                                  prstDescricao: string;
                                  prstEspecificacao: string;
                                  prstONU: string): Integer;
    procedure MSV_Limpar();
    function MAC_SetXMLRetorno(prstXML: string): string;
    function MAC_GetXMLEnvio(): string;
    function MAC_GetCodigoRetorno():string;
    function MAC_GetMensagemRetorno():string;
    constructor create;
    destructor destroy; override;
  end;
implementation

{ CSV_ABTRAAntaq }

constructor CSV_ABTRAAntaq.create;
begin
  AIM_CET_TRP_ContainerCargaPerigosa := nil;
  AIM_CodigoRetorno := '';
  AIM_MensagemRetorno := '';
end;

destructor CSV_ABTRAAntaq.destroy;
begin
  AIM_CET_TRP_ContainerCargaPerigosa.Free;
  inherited;
end;

procedure CSV_ABTRAAntaq.MSV_AddContainerCargaPerigosa(prstAltura: string;
                                                       prstBloco: string;
                                                       prstConteiner: string;
                                                       prstISOCode: string;
                                                       prstLastro: string;
                                                       prstPeso: string;
                                                       prstPilha: string;
                                                       prstQuadra: string;
                                                       prinSituacao: Integer;
                                                       prstTerminal: string);
begin
  AIM_CET_TRP_ContainerCargaPerigosa := CET_TRP_ContainerCargaPerigosa.Create(prstAltura,
                                                                              prstBloco,
                                                                              prstConteiner,
                                                                              prstISOCode,
                                                                              prstLastro,
                                                                              prstPeso,
                                                                              prstPilha,
                                                                              prstQuadra,
                                                                              prinSituacao,
                                                                              prstTerminal);
end;

function CSV_ABTRAAntaq.MSV_AddNCM(prstCodigo, prstDescricao: string): Integer;
begin
  Result := -1; //TO DO cNULL_INTEGER
  if Assigned(AIM_CET_TRP_ContainerCargaPerigosa) then
    Result := AIM_CET_TRP_ContainerCargaPerigosa.MSV_AddNCM(CET_TRP_NCM.Create(prstCodigo, prstDescricao));
end;

function CSV_ABTRAAntaq.MSV_AddCargaPerigosa(prstClassificacao: string;
                                             prstDescricao: string;
                                             prstEspecificacao: string;
                                             prstONU: string): Integer;
begin
  Result := -1; //TO DO cNULL_INTEGER
  if Assigned(AIM_CET_TRP_ContainerCargaPerigosa) then
    Result := AIM_CET_TRP_ContainerCargaPerigosa.MSV_AddCargaPerigosa(CET_TRP_CargaPerigosa.Create(prstClassificacao,
                                                                                                   prstDescricao,
                                                                                                   prstEspecificacao,
                                                                                                   prstONU));
end;
 
procedure CSV_ABTRAAntaq.MSV_Limpar;
begin
  if Assigned(AIM_CET_TRP_ContainerCargaPerigosa) then
    AIM_CET_TRP_ContainerCargaPerigosa.Free;
  AIM_CET_TRP_ContainerCargaPerigosa := nil;
  AIM_CodigoRetorno := '';
  AIM_MensagemRetorno := '';
end;

function CSV_ABTRAAntaq.MAC_GetXMLEnvio: string;
var
  lXMLDoc : IXMLDocument;
  lNodeCadastrar: IXMLNode;
  lNodeConteinerCargaPerigosa: IXMLNode;
  lNodeCargas: IXMLNode;
  lNodeCargaPerigosa: IXMLNode;
  lNodeListaNCM: IXMLNode;
  lNodeNCM: IXMLNode;
  lNodeAux: IXMLNode;
  linContador : Integer;
begin
  Result := '';
  if Assigned(AIM_CET_TRP_ContainerCargaPerigosa) then
  begin
    lXMLDoc          := NewXMLDocument('');
    lXMLDoc.Active   := True;
    lXMLDoc.Encoding := 'UTF-8';
    lNodeCadastrar   := lXMLDoc.CreateElement('Cadastrar', '');
    lXMLDoc.DocumentElement := lNodeCadastrar;

    lNodeConteinerCargaPerigosa := lNodeCadastrar.AddChild('conteinercargaperigosa');
    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Altura');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.Altura;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Bloco');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.Bloco;

    lNodeCargas := lNodeConteinerCargaPerigosa.AddChild('Cargas');
    for linContador := 0 to Length(AIM_CET_TRP_ContainerCargaPerigosa.Cargas)-1 do
    begin
      lNodeCargaPerigosa := lNodeCargas.AddChild('cargaperigosa');
      lNodeAux := lNodeCargaPerigosa.AddChild('Classificacao');
      lNodeAux.Text := (AIM_CET_TRP_ContainerCargaPerigosa.Cargas[linContador] as CET_TRP_CargaPerigosa).Classificacao;

      lNodeAux := lNodeCargaPerigosa.AddChild('Descricao');
      lNodeAux.Text := (AIM_CET_TRP_ContainerCargaPerigosa.Cargas[linContador] as CET_TRP_CargaPerigosa).Descricao;

      lNodeAux := lNodeCargaPerigosa.AddChild('Especificacao');
      lNodeAux.Text := (AIM_CET_TRP_ContainerCargaPerigosa.Cargas[linContador] as CET_TRP_CargaPerigosa).Especificacao;

      lNodeAux := lNodeCargaPerigosa.AddChild('Onu');
      lNodeAux.Text := (AIM_CET_TRP_ContainerCargaPerigosa.Cargas[linContador] as CET_TRP_CargaPerigosa).Onu;
    end;   

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Conteiner');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.Conteiner; ;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('IsoCode');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.ISOCode;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Lastro');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.Lastro;


    lNodeListaNCM := lNodeConteinerCargaPerigosa.AddChild('ListaNCM');
    for linContador := 0 to Length(AIM_CET_TRP_ContainerCargaPerigosa.ListaNCM)-1 do
    begin
      lNodeNCM := lNodeListaNCM.AddChild('ncm');
      lNodeAux := lNodeNCM.AddChild('Codigo');
      lNodeAux.Text := (AIM_CET_TRP_ContainerCargaPerigosa.ListaNCM[linContador] as CET_TRP_NCM).Codigo;

      lNodeAux := lNodeNCM.AddChild('Descricao');
      lNodeAux.Text := (AIM_CET_TRP_ContainerCargaPerigosa.ListaNCM[linContador] as CET_TRP_NCM).Descricao;
    end;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Peso');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.Peso;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Pilha');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.Pilha;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Quadra');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.Quadra;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Situacao'); //
    lNodeAux.Text:= '0';//TO DO AIM_CET_TRP_ContainerCargaPerigosa.inSituacao;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Terminal');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.Terminal;
         

    Result :=lXMLDoc.XML.Text;
    Result := MIM_XMLToSOAPEnv(Result);
  end;
end;

function CSV_ABTRAAntaq.MAC_SetXMLRetorno(prstXML: string): string;
var
  lXMLDoc : IXMLDocument;
  lXMLNodeEnvelope : IXMLNode;
  lXMLNodeBody : IXMLNode;
  lXMLNodeResponse : IXMLNode;
  lXMLNodeCadastrarResult : IXMLNode;
  lXMLNodeAux: IXMLNode;
  lXMLNodeFault: IXMLNode;
  lstCodigo: string;
  lstMensagem: string;
  lstErro: string;
begin
  lstErro := '';
  lstCodigo := '';
  lstMensagem := '';

  if prstXML <> '' then
  begin
    try
      lXMLDoc := LoadXMLData(prstXML);
    except
      on E: Exception do
        lstErro := E.Message;
    end;
  end;

  if lstErro = '' then
  begin
    lXMLNodeEnvelope := lXMLDoc.DocumentElement;
    lXMLNodeBody := lXMLNodeEnvelope.ChildNodes.Get(0);
    lXMLNodeResponse := lXMLNodeBody.ChildNodes.Get(0);
    lXMLNodeAux := lXMLNodeResponse.ChildNodes.Get(0);
    if lXMLNodeAux.NodeName = 'CadastrarResult' then
    begin
      lXMLNodeCadastrarResult := lXMLNodeAux.ChildNodes.Get(0);
      lstCodigo := lXMLNodeCadastrarResult.Text;

      lXMLNodeCadastrarResult := lXMLNodeAux.ChildNodes.Get(1);
      lstMensagem := lXMLNodeCadastrarResult.Text;
    end
    else
    begin
      lXMLNodeFault := lXMLNodeResponse.ChildNodes.Get(0);;
      lstCodigo := lXMLNodeFault.Text;

      lXMLNodeFault := lXMLNodeResponse.ChildNodes.Get(1);
      lstMensagem := lXMLNodeFault.Text;
    end;
  end;
  AIM_CodigoRetorno := lstCodigo;
  AIM_MensagemRetorno := lstMensagem;

  Result := lstErro;
end;

function CSV_ABTRAAntaq.MIM_XMLToSOAPEnv(prstXML: string): string;
var
  ltsAux: TStringList;
begin
  ltsAux := TStringList.Create();
  ltsAux.Text := prstXML;

  ltsAux.Delete(0);
  prstXML := ltsAux.Text;
  ltsAux.Free;

  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">';
  Result := Result + '<soapenv:Header/>';
  Result := Result + '<soapenv:Body>';  Result := Result + prstXML;  Result := Result + '</soapenv:Body>';  Result := Result + '</soapenv:Envelope>';end;

function CSV_ABTRAAntaq.MAC_GetCodigoRetorno: string;
begin
  Result := AIM_CodigoRetorno;
end;

function CSV_ABTRAAntaq.MAC_GetMensagemRetorno: string;
begin
  Result := AIM_MensagemRetorno;
end;

end.
