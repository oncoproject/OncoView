unit RegKwadr;

interface

type

  TRegresjaKwadr = class(TObject)

  public type
    TMPoint = record
      x, y: double;
      np: double; // niepewnoœæ pomiaru
    end;

    TWspol = record
      a, b: double;
    end;
  public
    tab: array of TMPoint;
    constructor Create(cnt: integer);
    function getWspol(var wsp: TWspol): boolean;
    procedure ShrinkTab(n: integer);
  end;

implementation

constructor TRegresjaKwadr.Create(cnt: integer);
var
  i: integer;
begin
  inherited Create;
  setlength(tab, cnt);
  // zak³adam, ¿e niepewnoœæ ka¿dego punktu jest taka sama
  for i := 0 to cnt - 1 do
    tab[i].np := 1;
end;

procedure TRegresjaKwadr.ShrinkTab(n: integer);
begin
  if n < length(tab) then
    setlength(tab, n);
end;

// https://pl.wikipedia.org/wiki/Metoda_najmniejszych_kwadrat%C3%B3w
function TRegresjaKwadr.getWspol(var wsp: TWspol): boolean;
var
  S, Sx, Sy, Sxx, Sxy, Syy: double;
  D: double;
  i, n: integer;
begin
  wsp.a := 0;
  wsp.b := 0;
  Result := false;

  n := length(tab);
  if n >= 2 then
  begin
    S := 0;
    Sx := 0;
    Sy := 0;
    Sxx := 0;
    Sxy := 0;
    Syy := 0;

    for i := 0 to n - 1 do
    begin
      S := S + tab[i].np;
      Sx := Sx + tab[i].x;
      Sy := Sy + tab[i].y;
      Sxx := Sxx + tab[i].x * tab[i].x;
      Syy := Syy + tab[i].y * tab[i].y;
      Sxy := Sxy + tab[i].x * tab[i].y;
    end;
    D := S * Sxx - Sx * Sx;
    if D <> 0 then
    begin
      wsp.a := (S * Sxy - Sx * Sy) / D;
      wsp.b := (Sxx * Sy - Sx * Sxy) / D;
      Result := true;
    end;
  end
end;

end.
