unit uMain;

interface

uses
  {$IFDEF MSWINDOWS}
  Winapi.Windows,
  Winapi.Messages,
  {$ENDIF}

  uClose,

  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts,

  System.Generics.Collections, FMX.Gestures, FMX.Controls.Presentation,
  FMX.StdCtrls;

type
  TMain = class(TForm)
    GameLayout: TLayout;
    Background: TRectangle;
    Ball: TCircle;
    GestureManager: TGestureManager;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Panel1Gesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
  private
    { Private declarations }
    Width : Double;
    Height : Double;
    MarginsThickness : Double;
    BordersThickness : Double;
    BallSize : Double;
    BackgroundColor : TAlphaColor;
    ElementsColor : TAlphaColor;
    TopBorder: TRectangle;
    BottomBorder: TRectangle;
    Rectangles: TObjectList<TRectangle>;
    procedure CreateNetRectangles;
    procedure CreateBorders;
    procedure ClearBorder;
    procedure ShowCloseForm;
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.fmx}

uses

Math;

{ TForm1 }

procedure TMain.FormCreate(Sender: TObject);
begin
  Width := Max(Background.Width, Background.Height);
  Height := Min(Background.Width, Background.Height);

  MarginsThickness := Min(Background.Width, Background.Height) * 1.25 / 100;
  BordersThickness := MarginsThickness;
  BallSize := MarginsThickness;

  BackgroundColor := TAlphaColor($FF0F0F0F);
  ElementsColor :=  TAlphaColor($FF00FF00);

  CreateBorders;
  CreateNetRectangles;
end;

procedure TMain.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  {$IFDEF MSWINDOWS}
  if Key = VK_ESCAPE then  // Sprawdza, czy został naciśnięty klawisz ESC
  begin
    if MessageDlg('Czy chcesz zamknąć aplikację?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes then
      Application.Terminate;  // Zamyka aplikację po potwierdzeniu
  end;
  {$ENDIF}
end;

procedure TMain.FormResize(Sender: TObject);
begin
  ClearBorder;

  Width := Max(Background.Width, Background.Height);
  Height := Min(Background.Width, Background.Height);

  MarginsThickness := Min(Background.Width, Background.Height) * 1.25 / 100;
  BordersThickness := MarginsThickness;
  BallSize := MarginsThickness;

  CreateBorders;
  CreateNetRectangles;

end;

procedure TMain.Panel1Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
   if (EventInfo.GestureID = sgiUp) then
  begin
//    if MessageDlg('Czy chcesz zamknąć aplikację?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes then
//      Application.Terminate;
//    Handled := True;
//    ShowMessage('gesture');
    ShowCloseForm;
  end;

end;

procedure TMain.ShowCloseForm;
var
  closeForm : TForm;
begin
  CloseForm := TClose.Create(Self, MarginsThickness, BackgroundColor, ElementsColor);
  try
    CloseForm.Show;
  finally
    CloseForm.Free;
  end;
end;

procedure TMain.ClearBorder;
begin
  if Assigned(Rectangles) then
  begin
    Rectangles.Free;
    Rectangles := nil;
  end;
  BottomBorder.Free;
  TopBorder.Free;
end;

procedure TMain.CreateBorders;
begin
  TopBorder := TRectangle.Create(Background);
  BottomBorder := TRectangle.Create(Background);

  Background.Fill.Color := BackgroundColor;

  TopBorder.Parent := Background;
  BottomBorder.Parent := Background;

  TopBorder.Fill.Color := ElementsColor;
  BottomBorder.Fill.Color := ElementsColor;

  TopBorder.Stroke.Kind := TBrushKind.None;
  BottomBorder.Stroke.Kind := TBrushKind.None;

  TopBorder.Height := BordersThickness;
  BottomBorder.Height := BordersThickness;

  TopBorder.Width := Width - 2 * MarginsThickness;
  BottomBorder.Width := Width - 2 * MarginsThickness;

  TopBorder.Position.X := MarginsThickness;
  TopBorder.Position.Y := MarginsThickness;
  BottomBorder.Position.X := MarginsThickness;

  BottomBorder.Position.Y := Height - MarginsThickness - BordersThickness;

end;

procedure TMain.CreateNetRectangles;
const
  NumberOfRectangles = 18;
var
  i: Integer;
  NewRectangle: TRectangle;
  PositionX : Double;
  PositionY : Double;
  NetRectangleWidth : Double;
  NetRectangleHeight : Double;
begin
  Rectangles := TObjectList<TRectangle>.Create;
  NetRectangleWidth := BordersThickness;
  NetRectangleHeight := (Height - 3 * MarginsThickness - 2 * BordersThickness) / NumberOfRectangles - MarginsThickness;
  PositionX := Width / 2 - NetRectangleWidth / 2;
  PositionY := 2 * MarginsThickness + BordersThickness;
  for i := 0 to NumberOfRectangles - 1 do
  begin
    NewRectangle := TRectangle.Create(Background);
    NewRectangle.Parent := Background;
    NewRectangle.Width := NetRectangleWidth;
    NewRectangle.Height := NetRectangleHeight;
    NewRectangle.Fill.Color := ElementsColor;
    NewRectangle.Stroke.Kind := TBrushKind.None;
    NewRectangle.Position.X := PositionX;
    NewRectangle.Position.Y := PositionY;
    PositionY := PositionY + MarginsThickness + NetRectangleHeight;
    Rectangles.Add(NewRectangle);
  end;
end;



end.
