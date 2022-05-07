unit frameOsSwitch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TOsSwitchFrame = class(TFrame)
    PasButton: TRadioButton;
    LaserButton: TRadioButton;
    OffButton: TRadioButton;
    AddPasOblBox: TCheckBox;
    AddErrorBox: TCheckBox;
    Panel1: TPanel;
    OsLabel: TLabel;
    LaserPomocButton: TRadioButton;
    LaserPomocBtn: TRadioButton;
    procedure OffButtonClick(Sender: TObject);
    procedure LaserPomocButtonClick(Sender: TObject);
  private
    FOnOsChanged: TNotifyEvent;
  public
    procedure setAllDisable;
    procedure setEnab(pasDt, laserDt, laserPomDt: boolean);

  published
    property OnOsChanged: TNotifyEvent read FOnOsChanged write FOnOsChanged;
  end;

implementation

{$R *.dfm}

procedure TOsSwitchFrame.LaserPomocButtonClick(Sender: TObject);
begin
  OffButtonClick(Sender);
end;

procedure TOsSwitchFrame.OffButtonClick(Sender: TObject);
var
  q : boolean;
begin
  q := PasButton.Checked;
  AddPasOblBox.Enabled := q;
  AddErrorBox.Enabled := q;

  if assigned(FOnOsChanged) then
    FOnOsChanged(self);
end;

procedure TOsSwitchFrame.setAllDisable;
begin
  OffButton.Enabled := true;
  OffButton.Checked := true;
  PasButton.Enabled := false;
  LaserButton.Enabled := false;
  LaserPomocBtn.Enabled := false;
  LaserPomocButton.Enabled := false;
  AddPasOblBox.Enabled := false;
  AddErrorBox.Enabled := false;
end;

procedure TOsSwitchFrame.setEnab(pasDt, laserDt, laserPomDt: boolean);
  function checkBtn(btn: TRadioButton): boolean;
  begin
    Result := not(btn.Enabled) and btn.Checked
  end;

begin
  OffButton.Enabled := true;
  PasButton.Enabled := pasDt;
  LaserButton.Enabled := laserDt;
  LaserPomocBtn.Enabled := laserPomDt;
  AddPasOblBox.Enabled := false;
  AddErrorBox.Enabled := false;

  if checkBtn(PasButton) then
    OffButton.Checked := true;
  if checkBtn(LaserButton) then
    OffButton.Checked := true;
  if checkBtn(LaserPomocBtn) then
    OffButton.Checked := true;

end;

end.
