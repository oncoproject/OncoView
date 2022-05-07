unit frameBaseChartUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  VclTee.Chart,
  InfoDataUnit;

type

  TKalibrChartDt = record
    mouse_x: Integer;
    mouse_y: Integer;
    valX: double;
    valY_L: double;
    valY_R: double;
    procedure setPos(Chart: TChart; X, Y: Integer);
  end;

  TBaseChartFrame = class;
  TOnGetViewData = function(Sender: TBaseChartFrame): TOncoObject of object;

  TBaseChartFrame = class(TFrame)
  private
    FOnGetViewData: TOnGetViewData;
  protected

    function FGetViewData: TOncoObject;
    property mViewData: TOncoObject read FGetViewData;

  public
    class procedure DrawChartCursor(Chart: TChart; const dt: TKalibrChartDt; color: TColor);
    class function getChartWorkRect(Chart: TChart): TRect;
    property OnGetViewData: TOnGetViewData read FOnGetViewData write FOnGetViewData;
  end;

implementation

{$R *.dfm}

function TBaseChartFrame.FGetViewData: TOncoObject;
begin
  if Assigned(FOnGetViewData) then
    Result := FOnGetViewData(self)
  else
    raise Exception.Create('No access do viewData');
end;

procedure TKalibrChartDt.setPos(Chart: TChart; X, Y: Integer);
begin
  if (mouse_x <> X) or (mouse_y <> Y) then
  begin
    valX := Chart.BottomAxis.CalcPosPoint(X);
    valY_L := Chart.LeftAxis.CalcPosPoint(Y);
    valY_R := Chart.RightAxis.CalcPosPoint(Y);
    mouse_x := X;
    mouse_y := Y;
    Chart.Invalidate;
  end;

end;

class function TBaseChartFrame.getChartWorkRect(Chart: TChart): TRect;
begin
  Result.Left := Chart.BottomAxis.CalcXPosValue(Chart.BottomAxis.Minimum);
  Result.Right := Chart.BottomAxis.CalcXPosValue(Chart.BottomAxis.Maximum);
  Result.Top := Chart.LeftAxis.CalcYPosValue(Chart.LeftAxis.Maximum);
  Result.Bottom := Chart.LeftAxis.CalcYPosValue(Chart.LeftAxis.Minimum);
end;

class procedure TBaseChartFrame.DrawChartCursor(Chart: TChart; const dt: TKalibrChartDt; color: TColor);
var
  cv: TCanvas;
  R: TRect;
  RW: TRect;
  X, Y: Integer;

begin
  cv := Chart.Canvas.ReferenceCanvas;
  RW := getChartWorkRect(Chart);

  X := Chart.BottomAxis.CalcXPosValue(dt.valX);
  Y := Chart.LeftAxis.CalcYPosValue(dt.valY_L);

  if RW.Contains(Point(X, Y)) then
  begin

    cv.Pen.Width := 1;
    cv.Pen.Style := psSolid;
    cv.Pen.color := color;

    R := Chart.GetRectangle;

    cv.MoveTo(R.Left, Y);
    cv.LineTo(R.Right, Y);

    cv.MoveTo(X, R.Top);
    cv.LineTo(X, R.Bottom);
  end;

end;

end.
