program QrCodeGeneratorDemo;

{$mode objfpc}{$H+}

uses {$IFDEF UNIX} {$IFDEF UseCThreads}
  cthreads, {$ENDIF} {$ENDIF}
  SysUtils,
  consoletestrunner,
  uQrCodeGeneratorDemo;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    TQrCodeGeneratorDemo.RunAllDemos;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.






