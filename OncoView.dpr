program OncoView;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  InfoDataUnit in 'InfoDataUnit.pas',
  RegKwadr in 'RegKwadr.pas',
  frameKalibrUnit in 'Frames\frameKalibrUnit.pas' {KalibrSheetFrame: TFrame},
  frameBaseChartUnit in 'Frames\frameBaseChartUnit.pas' {BaseChartFrame: TFrame},
  frameOsSwitch in 'Frames\frameOsSwitch.pas' {OsSwitchFrame: TFrame},
  framePomiarNewUnit in 'Frames\framePomiarNewUnit.pas' {PomiarNewSheetFrame: TFrame},
  Wykres3Unit in 'Wykres3\Wykres3Unit.pas',
  WykresEngUnit in 'Wykres3\WykresEngUnit.pas',
  frameMeasureUnit in 'Frames\frameMeasureUnit.pas' {FrameMeas: TFrame},
  framePomiarUnit in 'Frames\framePomiarUnit.pas' {PomiarSheetFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
