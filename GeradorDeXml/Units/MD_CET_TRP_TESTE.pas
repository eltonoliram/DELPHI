unit MD_CET_TRP_TESTE;

interface
 uses
  typInfo;

implementation

type
  CET_TRP_TESTE = class(TObject)
    st1: string;
    st2: string;
    in1: integer;
    procedure GetSt1(const Value: string);
    procedure GetSt2(const Value: string);
    procedure GetIn1(const Value: integer);
  private
  published
  public
    property Fst1: string read st1 write GetSt1;
    property Fst2: string read st2 write GetSt2;
    property Fin1: integer read in1 write GetIn1;
    constructor Create;
    destructor Destroy;
    function ToXml(): string;
  end;
  
{ CET_TRP_TESTE }

constructor CET_TRP_TESTE.Create;
begin
  inherited;
end;

destructor CET_TRP_TESTE.Destroy;
begin
  inherited;
end;

procedure CET_TRP_TESTE.GetIn1(const Value: integer);
begin
  in1 := Value;
end;

procedure CET_TRP_TESTE.GetSt1(const Value: string);
begin
  st1 := Value;
end;

procedure CET_TRP_TESTE.GetSt2(const Value: string);
begin
  st2 := Value;
end;

function CET_TRP_TESTE.ToXml: string;
var
  PropList: PPropList;
  PropCount, I: Integer;
begin
  result := '';
  PropCount := GetPropList(self, PropList);
  try
    for I := 0 to PropCount-1 do
    begin
      result := result + PropList[I].Name;
    end;
  finally
    FreeMem(PropList);
  end;
end;

end.
