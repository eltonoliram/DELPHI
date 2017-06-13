unit MD_CSV_ABTRAAntaq;

interface

uses
  MD_CET_TRP_ABTRAAntaq, XMLDoc, XMLIntf, ActiveX, SysUtils, Contnrs, Classes, HTTPApp;

type
  CSV_ABTRAAntaq = class(TObject)
  private
    AIM_CET_TRP_ContainerCargaPerigosa : CET_TRP_ContainerCargaPerigosa;
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
    function MSV_GetXMLEnvio(): string;
    constructor create;
    destructor destroy; override;
  end;
implementation

{ CSV_ABTRAAntaq }

constructor CSV_ABTRAAntaq.create;
begin
  AIM_CET_TRP_ContainerCargaPerigosa := CET_TRP_ContainerCargaPerigosa.Create;
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
  AIM_CET_TRP_ContainerCargaPerigosa.Free;
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
  Result := -1;
  if Assigned(AIM_CET_TRP_ContainerCargaPerigosa) then
    Result := AIM_CET_TRP_ContainerCargaPerigosa.MSV_AddNCM(CET_TRP_NCM.Create(prstCodigo, prstDescricao));
end;

function CSV_ABTRAAntaq.MSV_AddCargaPerigosa(prstClassificacao: string;
                                             prstDescricao: string;
                                             prstEspecificacao: string;
                                             prstONU: string): Integer;
begin
  Result := -1;
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
end;

function CSV_ABTRAAntaq.MSV_GetXMLEnvio: string;
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
    lXMLDoc          := NewXMLDocument();
    lXMLDoc.Active   := True;
    lXMLDoc.Encoding := 'UTF-8';
    lNodeCadastrar   := lXMLDoc.CreateElement('Cadastrar', '');
    lXMLDoc.DocumentElement := lNodeCadastrar;

    lNodeConteinerCargaPerigosa := lNodeCadastrar.AddChild('conteinercargaperigosa');
    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Altura');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.stAltura;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Bloco');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.stBloco;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Conteiner');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.stConteiner; ;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('IsoCode');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.stISOCode;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Lastro');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.stLastro;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Peso');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.stPeso;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Pilha');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.stPilha;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Quadra');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.stQuadra;

    //TODO Cast
    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Situacao');
   // lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.inSituacao;

    lNodeAux := lNodeConteinerCargaPerigosa.AddChild('Terminal');
    lNodeAux.Text:= AIM_CET_TRP_ContainerCargaPerigosa.stTerminal;

    lNodeListaNCM := lNodeConteinerCargaPerigosa.AddChild('ListaNCM');
    for linContador := 0 to Length(AIM_CET_TRP_ContainerCargaPerigosa.ListaNCM)-1 do
    begin
      lNodeNCM := lNodeListaNCM.AddChild('ncm');
      lNodeAux := lNodeNCM.AddChild('Codigo');
      lNodeAux.Text := (AIM_CET_TRP_ContainerCargaPerigosa.ListaNCM[linContador] as CET_TRP_NCM).stCodigo;

      lNodeAux := lNodeNCM.AddChild('Descricao');
      lNodeAux.Text := (AIM_CET_TRP_ContainerCargaPerigosa.ListaNCM[linContador] as CET_TRP_NCM).stDescricao;
    end;

    lNodeCargas := lNodeConteinerCargaPerigosa.AddChild('Cargas');
    for linContador := 0 to Length(AIM_CET_TRP_ContainerCargaPerigosa.Cargas)-1 do
    begin
      lNodeCargaPerigosa := lNodeCargas.AddChild('cargaperigosa');
      lNodeAux := lNodeCargaPerigosa.AddChild('Classificacao');
      lNodeAux.Text := (AIM_CET_TRP_ContainerCargaPerigosa.Cargas[linContador] as CET_TRP_CargaPerigosa).stClassificacao;

      lNodeAux := lNodeCargaPerigosa.AddChild('Descricao');
      lNodeAux.Text := (AIM_CET_TRP_ContainerCargaPerigosa.Cargas[linContador] as CET_TRP_CargaPerigosa).stDescricao;

      lNodeAux := lNodeCargaPerigosa.AddChild('Especificacao');
      lNodeAux.Text := (AIM_CET_TRP_ContainerCargaPerigosa.Cargas[linContador] as CET_TRP_CargaPerigosa).stEspecificacao;

      lNodeAux := lNodeCargaPerigosa.AddChild('Onu');
      lNodeAux.Text := (AIM_CET_TRP_ContainerCargaPerigosa.Cargas[linContador] as CET_TRP_CargaPerigosa).stOnu;
    end;

    lXMLDoc.XML.Delete(0);

    Result := lXMLDoc.XML.Text;
    Result := MIM_XMLToSOAPEnv(Result);
  end;
end;

function CSV_ABTRAAntaq.MIM_XMLToSOAPEnv(prstXML: string): string;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">';
  Result := Result + '<soapenv:Header/>';
  Result := Result + '<soapenv:Body>';  Result := Result + HTMLEncode(prstXML);  Result := Result + '</soapenv:Body>';  Result := Result + '</soapenv:Envelope>';end;

end.
