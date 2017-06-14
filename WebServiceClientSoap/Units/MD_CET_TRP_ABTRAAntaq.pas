unit MD_CET_TRP_ABTRAAntaq;

interface

type
  {Classes de Envio}
  CET_TRP_NCM = class(TObject)
  private
    stCodigo: string;
    stDescricao: string;
    procedure  MAC_SetstCodigo(const Value: string);
    procedure  MAC_SetstDescricao(const Value: string);  public
    property Codigo: string read stCodigo write MAC_SetstCodigo;
    property Descricao: string read stDescricao write MAC_SetstDescricao;
    constructor Create(prstCodigo: string; prstDescricao: string);
    destructor Destroy; override;
  end;

  CET_TRP_CargaPerigosa = class(TObject)
  private
    stClassificacao: string;
    stDescricao: string;
    stEspecificacao: string;
    stONU: string;
    procedure MAC_SetstClassificacao(const Value: string);
    procedure MAC_SetstDescricao(const Value: string);    procedure MAC_SetstEspecificacao(const Value: string);    procedure MAC_SetstONU(const Value: string);  public
    property Classificacao: string read stClassificacao write MAC_SetstClassificacao;
    property Descricao: string read stDescricao write MAC_SetstDescricao;
    property Especificacao: string read stEspecificacao write MAC_SetstEspecificacao;
    property ONU: string read stONU write MAC_SetstONU;
    constructor Create(prstClassificacao: string; prstDescricao: string; prstEspecificacao: string; prstONU: string);
    destructor Destroy(); override;
  end;

  CET_TRP_ContainerCargaPerigosa = class(TObject)
  private
    stAltura: string;
    stBloco: string;
    stConteiner: string;
    stISOCode: string;
    stLastro: string;
    stPeso: string;
    stPilha: string;
    stQuadra: string;
    inSituacao: Integer;
    stTerminal: string;
    procedure MAC_SetstAltura(const Value: string);
    procedure MAC_SetstBloco(const Value: string);
    procedure MAC_SetstConteiner(const Value: string);
    procedure MAC_SetstISOCode(const Value: string);
    procedure MAC_SetstLastro(const Value: string);
    procedure MAC_SetstPeso(const Value: string);
    procedure MAC_SetstPilha(const Value: string);
    procedure MAC_SetstQuadra(const Value: string);
    procedure MAC_SetinSituacao(const Value: Integer);
    procedure MAC_SetstTerminal(const Value: string);
  public
    Cargas: array of CET_TRP_CargaPerigosa;
    ListaNCM: array of CET_TRP_NCM;
    property Altura: string read stAltura write MAC_SetstAltura;
    property Bloco: string read stBloco write MAC_SetstBloco;
    property Conteiner: string read stConteiner write MAC_SetstConteiner;
    property ISOCode: string read stISOCode write MAC_SetstISOCode;
    property Lastro: string read stLastro write MAC_SetstLastro;
    property Peso: string read stPeso write MAC_SetstPeso;
    property Pilha: string read stPilha write MAC_SetstPilha;
    property Quadra: string read stQuadra write MAC_SetstQuadra;
    property Situacao: Integer read inSituacao write MAC_SetinSituacao;
    property Terminal: string read stTerminal write MAC_SetstTerminal;
    function MSV_AddCargaPerigosa(Value: CET_TRP_CargaPerigosa): Integer;
    function MSV_AddNCM(Value: CET_TRP_NCM): Integer;
    constructor Create(prstAltura: string;
                       prstBloco: string;
                       prstConteiner: string;
                       prstISOCode: string;
                       prstLastro: string;
                       prstPeso: string;
                       prstPilha: string;
                       prstQuadra: string;
                       prinSituacao: Integer;
                       prstTerminal: string); overload;
    constructor Create; overload;
    destructor Destroy(); override;
  end;


  {Classes de Retorno}
  CET_TRP_CadastrarResult = class (TObject)
    stCodigo : string;
    stMensagem: string;
    constructor create(prstCodigo: string; prstMensagem: string);
    destructor destroy;  override;
  end;

  CET_TRP_Fault = class (TObject)
    stFaultCode : string;
    stFaultString: string;
    constructor create(prstFaultCode: string; prstFaultString: string);
    destructor destroy; override;
  end;

implementation

{ CET_TRP_ContainerCargaPerigosa }

constructor CET_TRP_ContainerCargaPerigosa.Create( prstAltura: string;
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
  inherited Create;
  stAltura := prstAltura;
  stBloco  := prstBloco;
  stConteiner := prstConteiner;
  stISOCode:= prstISOCode;
  stLastro := prstLastro;
  stPeso   := prstPeso;
  stPilha  := prstPilha;
  stQuadra := prstQuadra;
  inSituacao := prinSituacao;
  stTerminal := prstTerminal;
end;

constructor CET_TRP_ContainerCargaPerigosa.Create; 
begin
  inherited
end;

destructor CET_TRP_ContainerCargaPerigosa.Destroy;
var
  linIndex: Integer;
begin
  for linIndex := 0 to Length(Cargas) - 1 do
    (Cargas[linIndex] as CET_TRP_CargaPerigosa).Free;

  for linIndex := 0 to Length(ListaNCM) - 1 do
    (ListaNCM[linIndex] as CET_TRP_NCM).Free;


  inherited;
end;

procedure CET_TRP_ContainerCargaPerigosa.MAC_SetstAltura(const Value: string);
begin  stAltura := Value;end;

procedure CET_TRP_ContainerCargaPerigosa.MAC_SetstBloco(const Value: string);begin  stBloco := Value;end;

procedure CET_TRP_ContainerCargaPerigosa.MAC_SetstConteiner(const Value: string);begin  stConteiner := Value;end;

procedure CET_TRP_ContainerCargaPerigosa.MAC_SetstISOCode(const Value: string);begin  stISOCode := Value;end;

procedure CET_TRP_ContainerCargaPerigosa.MAC_SetstLastro(const Value: string);begin  stLastro := Value;end;

procedure CET_TRP_ContainerCargaPerigosa.MAC_SetstPeso(const Value: string);begin  stPeso := Value;end;

procedure CET_TRP_ContainerCargaPerigosa.MAC_SetstPilha(const Value: string);begin  stPilha := Value;end;

procedure CET_TRP_ContainerCargaPerigosa.MAC_SetstQuadra(const Value: string);begin  stQuadra := Value;end;

procedure CET_TRP_ContainerCargaPerigosa.MAC_SetinSituacao(const Value: Integer);begin  inSituacao := Value;end;

procedure CET_TRP_ContainerCargaPerigosa.MAC_SetstTerminal(const Value: string);begin  stTerminal := Value;end;

function CET_TRP_ContainerCargaPerigosa.MSV_AddCargaPerigosa(Value: CET_TRP_CargaPerigosa): Integer;
begin
  Result := Length(Cargas);
  SetLength(Cargas, Result + 1);
  Cargas[Result] := Value;
end;

function CET_TRP_ContainerCargaPerigosa.MSV_AddNCM(Value: CET_TRP_NCM): Integer;
begin
  Result := Length(ListaNCM);
  SetLength(ListaNCM, Result + 1);
  ListaNCM[Result] := Value;
end;

{ CET_TRP_NCM }

constructor CET_TRP_NCM.Create(prstCodigo: string; prstDescricao: string);
begin
  inherited Create;
  stCodigo := prstCodigo;
  stDescricao := prstDescricao;
end;

destructor CET_TRP_NCM.Destroy;
begin
  inherited;
end;

procedure CET_TRP_NCM.MAC_SetstCodigo(const Value: string);
begin  stCodigo := Value;end;

procedure CET_TRP_NCM.MAC_SetstDescricao(const Value: string);begin  stDescricao := Value;end;

{ CET_TRP_CargaPerigosa }

constructor CET_TRP_CargaPerigosa.Create(prstClassificacao: string;
                                         prstDescricao: string;
                                         prstEspecificacao: string;
                                         prstONU: string);
begin
  inherited Create;
  stClassificacao := prstClassificacao;
  stDescricao     := prstDescricao;
  stEspecificacao := prstEspecificacao;
  stONU           := prstONU;
end;

destructor CET_TRP_CargaPerigosa.Destroy;
begin
  inherited;
end;

procedure CET_TRP_CargaPerigosa.MAC_SetstClassificacao(const Value: string);
begin  stClassificacao := Value;end;

procedure CET_TRP_CargaPerigosa.MAC_SetstDescricao(const Value: string);begin  stDescricao := Value;end;

procedure CET_TRP_CargaPerigosa.MAC_SetstEspecificacao(const Value: string);begin  stEspecificacao := Value;end;

procedure CET_TRP_CargaPerigosa.MAC_SetstONU(const Value: string);begin  stONU := Value;end;

{ CET_TRP_Fault }

constructor CET_TRP_Fault.Create(prstFaultCode: string; prstFaultString: string);
begin
  inherited Create;
  stFaultCode   := prstFaultCode;
  stFaultString := prstFaultString;
end;

destructor CET_TRP_Fault.destroy;
begin
  inherited;
end;


{ CET_TRP_CadastrarResult }

constructor CET_TRP_CadastrarResult.Create(prstCodigo: string; prstMensagem: string);
begin
  inherited Create;
  stCodigo := prstCodigo;
  stMensagem := prstMensagem;
end;

destructor CET_TRP_CadastrarResult.destroy;
begin
  inherited;
end;

end.
