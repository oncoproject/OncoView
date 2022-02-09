program OncoView;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  InfoDataUnit in 'InfoDataUnit.pas',
  RegKwadr in 'RegKwadr.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
