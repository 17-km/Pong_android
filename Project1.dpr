program Project1;



uses
  System.StartUpCopy,
  FMX.Forms,
  uClose in 'uClose.pas' {Close},
  uMain in 'uMain.pas' {Main};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Landscape];
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
