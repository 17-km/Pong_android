unit uClose;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TClose = class(TForm)
    Border: TRectangle;
    Background: TRectangle;
    tText: TText;
    rYes: TRectangle;
    tYes: TText;
    rNo: TRectangle;
    tNo: TText;
    procedure FormShow(Sender: TObject);
    procedure tNoClick(Sender: TObject);
    procedure tYesClick(Sender: TObject);
    procedure tNoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure tYesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    BordersThickness : Double;
    BackgroundColor : TAlphaColor;
    ElementsColor : TAlphaColor;
  public
    constructor Create(AOwner: TComponent; ABordersThickness: Double;
      ABackgroundColor, AElementsColor: TAlphaColor); overload;
  end;

var
  Close: TClose;

implementation

{$R *.fmx}

constructor TClose.Create(AOwner: TComponent; ABordersThickness: Double;
  ABackgroundColor, AElementsColor: TAlphaColor);
begin
  inherited Create(AOwner);
  BordersThickness := ABordersThickness;
  BackgroundColor := ABackgroundColor;
  ElementsColor := AElementsColor;
  ShowMessage('create');
end;

procedure TClose.FormShow(Sender: TObject);
begin
  Self.Width := Screen.Width;
  Self.Height := Screen.Height;
  Self.Left := 0;
  Self.Top := 0;

  ShowMessage('form');

  Border.Width := Round(Screen.Width / 3);
  Border.Height := Round(Screen.Height / 3);
  Border.Position.X := Round((Screen.Width - Border.Width) / 2);
  Border.Position.Y := Round((Screen.Height - Border.Height) / 2);

  Border.Fill.Color := ElementsColor;
  Background.Width := Border.Width - 2 * BordersThickness;
  Background.Height := Border.Height - 2 * BordersThickness;
  Background.Position.X := BordersThickness;
  Background.Position.Y := BordersThickness;
  Background.Fill.Color := BackgroundColor;

  tText.Height := BordersThickness * 5;
  tText.Width := Background.Width;
  tText.Position.X := 0;
  tText.Position.Y := Round(Background.Height / 3 - tText.Height / 2);
  tText.TextSettings.Font.Size := BordersThickness * 3;
  tText.TextSettings.FontColor := ElementsColor;
  tText.TextSettings.Font.Style := tText.TextSettings.Font.Style + [TFontStyle.fsBold];

  rYes.Width := Round(Background.Width / 4);
  rYes.Height := BordersThickness * 5;
  rYes.Fill.Color := ElementsColor;
  tYes.TextSettings.Font.Size := BordersThickness * 3;
  tYes.TextSettings.FontColor := BackgroundColor;
  tYes.TextSettings.Font.Style := tYes.TextSettings.Font.Style + [TFontStyle.fsBold];
  rYes.Position.X := Round(Background.Width / 4 - rYes.Width / 2);
  rYes.Position.Y := Round(5 * Background.Height / 6 - rYes.Height / 2);

  rNo.Width := Round(Background.Width / 4);
  rNo.Height := BordersThickness * 5;
  rNo.Fill.Color := ElementsColor;
  tNo.TextSettings.Font.Size := BordersThickness * 3;
  tNo.TextSettings.FontColor := BackgroundColor;
  tNo.TextSettings.Font.Style := tYes.TextSettings.Font.Style + [TFontStyle.fsBold];
  rNo.Position.X := Round(3 * Background.Width / 4 - rYes.Width / 2);
  rNo.Position.Y := Round(5 * Background.Height / 6 - rYes.Height / 2);
end;

procedure TClose.tYesClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TClose.tYesMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  tYes.TextSettings.FontColor := ElementsColor;
end;

procedure TClose.tNoClick(Sender: TObject);
begin
  Close;
end;

procedure TClose.tNoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  tNo.TextSettings.FontColor := ElementsColor;
end;

end.
