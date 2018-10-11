program QrCodeGeneratorDemo;

{$mode objfpc}{$H+}

uses {$IFDEF UNIX} {$IFDEF UseCThreads}
  cthreads, {$ENDIF} {$ENDIF}
  SysUtils,
  uQrCodeGeneratorDemo;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    TQrCodeGeneratorDemo.RunAllDemos;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.






