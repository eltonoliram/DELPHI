unit MD_CET_TRP_ABTRAAntaq;

interface

type
  {Classes de Envio}
  CET_TRP_NCM = class(TObject)
    stCodigo: string;
    stDescricao: string;
    constructor Create(prstCodigo: string; prstDescricao: string);
    destructor Destroy; override;
  end;

  CET_TRP_CargaPerigosa = class(TObject)
    stClassificacao: string;
    stDescricao: string;
    stEspecificacao: string;
    stONU: string;
    constructor Create(prstClassificacao: string; prstDescricao: string; prstEspecificacao: string; prstONU: string);
    destructor Destroy(); override;
  end;

  CET_TRP_ContainerCargaPerigosa = class(TObject)
  public
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
    Cargas: array of CET_TRP_CargaPerigosa;
    ListaNCM: array of CET_TRP_NCM;
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
