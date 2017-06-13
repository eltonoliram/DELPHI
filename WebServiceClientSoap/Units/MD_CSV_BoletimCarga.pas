unit MD_CSV_BoletimCarga;

interface

  uses
    MD_CET_CargaDescargaWSVO, XMLDoc, XMLIntf, ActiveX, MD_CSV_DefinicaoConstante, SysUtils,
    Contnrs, MD_CET_TRP_ItemBoletimCD, MD_CSV_String, MD_CET_ItemBoletimCD, MD_CET_BoletimCD, Classes;

type

  CSV_BoletimCarga = class
  private
    FCargaDescargaWSVO: CET_CargaDescargaWSVO;
    AIM_tsObjref_ItemBoletimCD: TStringList;
    ARL_CSV_String : CSV_String;

    function MIM_AddChild(prXMLNodeParent: IXMLNode; prstNodeName: string; prstNodeValue: string; prstNodeNameSpace: string = cNULL_STRING): IXMLNode;
  protected
    AIM_RootNode: IXMLNode;
    AIM_XMLDoc: IXMLDocument;
    AIM_stID: string;
    procedure MIM_AdicionarAssinatura;
    procedure MIM_AdicionarOperacao(prXMLNode: IXMLNode; prCET_operacaoCargaDescargaWSVO: CET_operacaoCargaDescargaWSVO);
    procedure MIM_AdicionarItemCargaDescarga(prXMLNode: IXMLNode; prCET_itemCargaDescargaWSVO: CET_itemCargaDescargaWSVO);
  public
    constructor Create(prstID: string = cNULL_STRING);
    destructor Destroy;
    property CargaDescargaWSVO: CET_CargaDescargaWSVO read FCargaDescargaWSVO;
    function MSV_GetTipoItem(prtyTipoItemBoletim: tyTipoItemBoletim): string;
    function MSV_GetTipoMovimentacao(prtyTipoMovimentacao: tyTipoMovimentacao): string;
    function MSV_GetTipoOperacao(prtyOperacao: tyOperacao): string;
    function MSV_GetTipoAvariaOcorrencia(prtyAvaria: tyAvaria): string;
    function MSV_FormataNroItem(prstNroItem: string): string;
    function MSV_AdicionarConteiner(prtyObjRef_ItemBoletimCD: tyObjRef): CET_ConteinerWSVO;
    function MSV_AdicionarCargaSolta(prtyObjRef_ItemBoletimCD: tyObjRef): CET_CargaSoltaWSVO;
    function MSV_AdicionarVeiculo(prtyObjRef_ItemBoletimCD: tyObjRef): CET_veiculoWSVO;
    function MSV_AdicionarSobressalente(prtyObjRef_ItemBoletimCD: tyObjRef): CET_SobressalenteWSVO;
    function MSV_AdicionarGranel(prtyObjRef_ItemBoletimCD: tyObjRef): CET_GranelWSVO;
    function MSV_GetXML: string;
    function MSV_OrdemRetorno: string;
end;

implementation

var
  gstTipoMovimentacao: array[Low(tyTipoMovimentacao)..High(tyTipoMovimentacao)] of string = ('00', '01', '02', '03');
  gstTipoOperacao: array[Low(tyOperacao)..High(tyOperacao)] of string = ('C', 'D');
  gstTipoAvariaOcorrencia: array[Low(tyAvaria)..High(tyAvaria)] of string = ('N', 'S');

const
  CS_ROOTNAME = 'cargaDescargaWSVO';

{ CSV_BoletimCarga }

constructor CSV_BoletimCarga.Create;
begin
  CoInitialize(nil);
  AIM_stID                   := prstID;
  FCargaDescargaWSVO         := CET_CargaDescargaWSVO.Create;
  AIM_XMLDoc                 := NewXMLDocument();
  AIM_XMLDoc.Active          := True;
  AIM_XMLDoc.Encoding        := 'UTF-8';
  AIM_XMLDoc.Options         := AIM_XMLDoc.Options;
  AIM_RootNode               := AIM_XMLDoc.CreateElement(CS_ROOTNAME, cNULL_STRING);
  AIM_XMLDoc.DocumentElement := AIM_RootNode;
  AIM_RootNode.SetAttributeNS('xmlns', cNULL_STRING, 'http://cargadescarga.webservice.carga.siscomex.serpro.gov.br/');
  AIM_tsObjref_ItemBoletimCD := TStringList.Create;
  ARL_CSV_String             := CSV_String.Create;
end;

destructor CSV_BoletimCarga.Destroy;
begin
  FCargaDescargaWSVO.Free;
  AIM_tsObjref_ItemBoletimCD.Free;
  ARL_CSV_String.Free;
  CoUninitialize;
end;

function CSV_BoletimCarga.MIM_AddChild(prXMLNodeParent: IXMLNode;
  prstNodeName: string; prstNodeValue: string; prstNodeNameSpace: string): IXMLNode;
begin
  if prstNodeNameSpace <> cNULL_STRING then
    Result := prXMLNodeParent.AddChild(prstNodeName, prstNodeNameSpace)
  else
    Result := prXMLNodeParent.AddChild(prstNodeName);

  Result.Text := prstNodeValue;
end;

procedure CSV_BoletimCarga.MIM_AdicionarAssinatura;
var
  Signature: IXMLNode;
  SignedInfo: IXMLNode;
  CanonicalizationMethod: IXMLNode;
  SignatureMethod: IXMLNode;
  Reference: IXMLNode;
  Transforms: IXMLNode;
  Transform: IXMLNode;
  DigestMethod: IXMLNode;
  DigestValue: IXMLNode;
  SignatureValue: IXMLNode;
  KeyInfo: IXMLNode;
begin
    Signature := AIM_RootNode.AddChild('Signature', 'http://www.w3.org/2000/09/xmldsig#');
    if AIM_stID <> cNULL_STRING then
      Signature.Attributes['Id'] := AIM_stID;
    SignedInfo := Signature.AddChild('SignedInfo');

    CanonicalizationMethod := SignedInfo.AddChild('CanonicalizationMethod');
    CanonicalizationMethod.Attributes['Algorithm'] := 'http://www.w3.org/TR/2001/REC-xml-c14n-20010315';

    SignatureMethod := SignedInfo.AddChild('SignatureMethod');
    SignatureMethod.Attributes['Algorithm'] := 'http://www.w3.org/2000/09/xmldsig#rsa-sha1';

    Reference := SignedInfo.AddChild('Reference');
    Reference.Attributes['URI'] := '#' + AIM_stID;

    Transforms := Reference.AddChild('Transforms');
    Transform := Transforms.AddChild('Transform');
    Transform.Attributes['Algorithm'] := 'http://www.w3.org/2000/09/xmldsig#enveloped-signature';
    Transform := Transforms.AddChild('Transform');
    Transform.Attributes['Algorithm'] := 'http://www.w3.org/TR/2001/REC-xml-c14n-20010315';

    DigestMethod := Reference.AddChild('DigestMethod');
    DigestMethod.Attributes['Algorithm'] := 'http://www.w3.org/2000/09/xmldsig#sha1';

    DigestValue := Reference.AddChild('DigestValue');

    SignatureValue := Signature.AddChild('SignatureValue');

    KeyInfo := Signature.AddChild('KeyInfo');
end;

procedure CSV_BoletimCarga.MIM_AdicionarItemCargaDescarga(prXMLNode: IXMLNode;
  prCET_itemCargaDescargaWSVO: CET_itemCargaDescargaWSVO);
var
  lXMLNode       : IXMLNode;
  lXMLNodeLacres : IXMLNode;
  linContador    : Integer;
begin
  lXMLNode := MIM_AddChild(prXMLNode, 'inAvariaOcorrencia', prCET_itemCargaDescargaWSVO.inAvariaOcorrencia);

  if prCET_itemCargaDescargaWSVO.nrManifesto <> cNULL_STRING then
    lXMLNode := MIM_AddChild(prXMLNode, 'nrManifesto', prCET_itemCargaDescargaWSVO.nrManifesto);
  
  if prCET_itemCargaDescargaWSVO.nrConhecimento <> cNULL_STRING then
    lXMLNode := MIM_AddChild(prXMLNode, 'nrConhecimento', prCET_itemCargaDescargaWSVO.nrConhecimento);

  if (prCET_itemCargaDescargaWSVO.nrItem <> cNULL_STRING) and
    (MSV_StringToInteger(prCET_itemCargaDescargaWSVO.nrItem) <> 0) then
    lXMLNode := MIM_AddChild(prXMLNode, 'nrItem', prCET_itemCargaDescargaWSVO.nrItem);

  if prCET_itemCargaDescargaWSVO is CET_ConteinerWSVO then
  begin
    //Container
    lXMLNode := MIM_AddChild(prXMLNode, 'nrConteiner', (prCET_itemCargaDescargaWSVO as CET_ConteinerWSVO).nrConteiner);

    //Lacres
    if ((prCET_itemCargaDescargaWSVO as CET_ConteinerWSVO).Lacres) then
    begin
      lXMLNode := prXMLNode.AddChild('nusLacresConteiner');
      for linContador := 0 to 3 do
      begin
        if (prCET_itemCargaDescargaWSVO as CET_ConteinerWSVO).nusLacresConteiner[linContador] <> cNULL_STRING then
          lXMLNodeLacres := MIM_AddChild(lXMLNode, 'nuLacreConteiner', (prCET_itemCargaDescargaWSVO as CET_ConteinerWSVO).nusLacresConteiner[linContador]);
      end;
    end;
  end;

  //Veiculo
  if prCET_itemCargaDescargaWSVO is CET_veiculoWSVO then
  begin
    lXMLNode := MIM_AddChild(prXMLNode, 'nrChassiVeiculo', (prCET_itemCargaDescargaWSVO as CET_veiculoWSVO).nrChassiVeiculo);
  end;

  //Carga Solta
  if prCET_itemCargaDescargaWSVO is CET_cargasoltaWSVO then
  begin
    lXMLNode := MIM_AddChild(prXMLNode, 'qtOperacao', (prCET_itemCargaDescargaWSVO as CET_cargasoltaWSVO).qtOperacao);
  end;

end;

procedure CSV_BoletimCarga.MIM_AdicionarOperacao(prXMLNode: IXMLNode; prCET_operacaoCargaDescargaWSVO: CET_operacaoCargaDescargaWSVO);
var
  lXMLNode: IXMLNode;
begin
  lXMLNode := MIM_AddChild(prXMLNode, 'cdOperacao', prCET_operacaoCargaDescargaWSVO.cdOperacao);
  lXMLNode := MIM_AddChild(prXMLNode, 'cdTipoMovimentacao', prCET_operacaoCargaDescargaWSVO.cdTipoMovimentacao);
end;

function CSV_BoletimCarga.MSV_AdicionarConteiner(prtyObjRef_ItemBoletimCD: tyObjRef): CET_ConteinerWSVO;
var
  linIndex: Integer;
begin
  AIM_tsObjref_ItemBoletimCD.Add(MSV_ObjRefToString(prtyObjRef_ItemBoletimCD) + '=');

  linIndex := FCargaDescargaWSVO.Conteineres.Add(CET_ConteinerWSVO.Create);
  Result   := FCargaDescargaWSVO.Conteineres[linIndex] as CET_ConteinerWSVO;
end;

function CSV_BoletimCarga.MSV_AdicionarCargaSolta(prtyObjRef_ItemBoletimCD: tyObjRef): CET_CargaSoltaWSVO;
var
  linIndex: Integer;
begin
  AIM_tsObjref_ItemBoletimCD.Add(MSV_ObjRefToString(prtyObjRef_ItemBoletimCD) + '=');

  linIndex := FCargaDescargaWSVO.CargasSoltas.Add(CET_CargaSoltaWSVO.Create);
  Result   := FCargaDescargaWSVO.CargasSoltas[linIndex] as CET_CargaSoltaWSVO;
end;

function CSV_BoletimCarga.MSV_AdicionarSobressalente(prtyObjRef_ItemBoletimCD: tyObjRef): CET_sobressalenteWSVO;
var
  linIndex: Integer;
begin
  AIM_tsObjref_ItemBoletimCD.Add(MSV_ObjRefToString(prtyObjRef_ItemBoletimCD) + '=');

  linIndex := FCargaDescargaWSVO.Sobressalentes.Add(CET_sobressalenteWSVO.Create);
  Result   := FCargaDescargaWSVO.Sobressalentes[linIndex] as CET_sobressalenteWSVO;
end;

function CSV_BoletimCarga.MSV_AdicionarGranel(prtyObjRef_ItemBoletimCD: tyObjRef): CET_GranelWSVO;
var
  linIndex: Integer;
begin
  AIM_tsObjref_ItemBoletimCD.Add(MSV_ObjRefToString(prtyObjRef_ItemBoletimCD) + '=');

  linIndex := FCargaDescargaWSVO.Graneis.Add(CET_GranelWSVO.Create);
  Result   := FCargaDescargaWSVO.Graneis[linIndex] as CET_GranelWSVO;
end;

function CSV_BoletimCarga.MSV_AdicionarVeiculo(prtyObjRef_ItemBoletimCD: tyObjRef): CET_veiculoWSVO;
var
  linIndex: Integer;
begin
  AIM_tsObjref_ItemBoletimCD.Add(MSV_ObjRefToString(prtyObjRef_ItemBoletimCD) + '=');

  linIndex := FCargaDescargaWSVO.Veiculos.Add(CET_veiculoWSVO.Create);
  Result   := FCargaDescargaWSVO.Veiculos[linIndex] as CET_veiculoWSVO;
end;

function CSV_BoletimCarga.MSV_GetTipoItem(prtyTipoItemBoletim: tyTipoItemBoletim): string;
begin
  Result := Trim(MSV_IntegerToString(Ord(prtyTipoItemBoletim)));
end;

function CSV_BoletimCarga.MSV_GetTipoMovimentacao(prtyTipoMovimentacao: tyTipoMovimentacao): string;
begin
  Result := gstTipoMovimentacao[prtyTipoMovimentacao];
end;

function CSV_BoletimCarga.MSV_GetTipoOperacao(prtyOperacao: tyOperacao): string;
begin
  Result := gstTipoOperacao[prtyOperacao];
end;

function CSV_BoletimCarga.MSV_GetTipoAvariaOcorrencia(prtyAvaria: tyAvaria): string;
begin
  Result := gstTipoAvariaOcorrencia[prtyAvaria];
end;

function CSV_BoletimCarga.MSV_FormataNroItem(prstNroItem: string): string;
begin
  Result := cNULL_STRING;
  if prstNroItem <> cNULL_STRING then
    Result := ARL_CSV_String.MSV_PadR(prstNroItem,'0', 4);
end;

function CSV_BoletimCarga.MSV_GetXML: string;
var
 lXMLNode       : IXMLNode;
 lXMLNodeAux    : IXMLNode;
 lXMLNodeTemp   : IXMLNode;
 linContador    : Integer;
begin
  lXMLNodeTemp := MIM_AddChild(AIM_RootNode, 'nrEscala', CargaDescargaWSVO.nrEscala);
  lXMLNodeTemp := MIM_AddChild(AIM_RootNode, 'cdTerminalOperacao', CargaDescargaWSVO.cdTerminalOperacao);
  lXMLNodeTemp := MIM_AddChild(AIM_RootNode, 'cdTipoItem', CargaDescargaWSVO.cdTipoItem);
  if CargaDescargaWSVO.Conteineres.Count > 0 then
  begin
    lXMLNode := AIM_RootNode.AddChild('conteineres');
    for linContador := 0 to CargaDescargaWSVO.Conteineres.Count - 1 do
    begin
      lXMLNodeAux := lXMLNode.AddChild('conteiner');
      MIM_AdicionarOperacao(lXMLNodeAux, CargaDescargaWSVO.Conteineres[linContador] as CET_operacaoCargaDescargaWSVO);
      MIM_AdicionarItemCargaDescarga(lXMLNodeAux, CargaDescargaWSVO.Conteineres[linContador] as CET_itemCargaDescargaWSVO);
    end;
  end;
  if CargaDescargaWSVO.CargasSoltas.Count > 0 then
  begin
    lXMLNode := AIM_RootNode.AddChild('cargassoltas');
    for linContador := 0 to CargaDescargaWSVO.CargasSoltas.Count - 1 do
    begin
      lXMLNodeAux := lXMLNode.AddChild('cargasolta');
      MIM_AdicionarOperacao(lXMLNodeAux, CargaDescargaWSVO.CargasSoltas[linContador] as CET_operacaoCargaDescargaWSVO);
      MIM_AdicionarItemCargaDescarga(lXMLNodeAux, CargaDescargaWSVO.CargasSoltas[linContador] as CET_itemCargaDescargaWSVO);
    end;
  end;
  if CargaDescargaWSVO.Veiculos.Count > 0 then
  begin
    lXMLNode := AIM_RootNode.AddChild('veiculos');
    for linContador := 0 to CargaDescargaWSVO.Veiculos.Count - 1 do
    begin
      lXMLNodeAux := lXMLNode.AddChild('veiculo');
      MIM_AdicionarOperacao(lXMLNodeAux, CargaDescargaWSVO.Veiculos[linContador] as CET_operacaoCargaDescargaWSVO);
      MIM_AdicionarItemCargaDescarga(lXMLNodeAux, CargaDescargaWSVO.Veiculos[linContador] as CET_itemCargaDescargaWSVO);
    end;
  end;
  if CargaDescargaWSVO.Sobressalentes.Count > 0 then
  begin
    lXMLNode := AIM_RootNode.AddChild('sobressalentes');
    for linContador := 0 to CargaDescargaWSVO.Sobressalentes.Count - 1 do
    begin
      lXMLNodeAux := lXMLNode.AddChild('sobressalente');
      MIM_AdicionarOperacao(lXMLNodeAux, CargaDescargaWSVO.Sobressalentes[linContador] as CET_operacaoCargaDescargaWSVO);
    end;
  end;
  if CargaDescargaWSVO.Graneis.Count > 0 then
  begin
    lXMLNode := AIM_RootNode.AddChild('graneis');
    for linContador := 0 to CargaDescargaWSVO.Graneis.Count - 1 do
    begin
      lXMLNodeAux := lXMLNode.AddChild('granel');
      MIM_AdicionarOperacao(lXMLNodeAux, CargaDescargaWSVO.Graneis[linContador] as CET_operacaoCargaDescargaWSVO);
    end;
  end;

  MIM_AdicionarAssinatura;
  Result := AIM_XMLDoc.XML.Text;
end;

function CSV_BoletimCarga.MSV_OrdemRetorno: string;
begin
  Result := AIM_tsObjref_ItemBoletimCD.DelimitedText;
end;

end.
