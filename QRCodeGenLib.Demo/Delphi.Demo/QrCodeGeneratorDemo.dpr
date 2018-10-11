program QrCodeGeneratorDemo;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  SysUtils,
  QlpArrayUtils in '..\..\QRCodeGenLib\src\Utils\QlpArrayUtils.pas',
  QlpQRCodeGenLibTypes in '..\..\QRCodeGenLib\src\Utils\QlpQRCodeGenLibTypes.pas',
  QlpBits in '..\..\QRCodeGenLib\src\Utils\QlpBits.pas',
  QlpBitBuffer in '..\..\QRCodeGenLib\src\QRCodeGen\QlpBitBuffer.pas',
  QlpQrSegment in '..\..\QRCodeGenLib\src\QRCodeGen\QlpQrSegment.pas',
  QlpIQrSegment in '..\..\QRCodeGenLib\src\Interfaces\QlpIQrSegment.pas',
  QlpQrSegmentMode in '..\..\QRCodeGenLib\src\QRCodeGen\QlpQrSegmentMode.pas',
  QlpGuard in '..\..\QRCodeGenLib\src\Utils\QlpGuard.pas',
  QlpReedSolomonGenerator in '..\..\QRCodeGenLib\src\QRCodeGen\QlpReedSolomonGenerator.pas',
  QlpIReedSolomonGenerator in '..\..\QRCodeGenLib\src\Interfaces\QlpIReedSolomonGenerator.pas',
  QlpQrTemplate in '..\..\QRCodeGenLib\src\QRCodeGen\QlpQrTemplate.pas',
  QlpIQrTemplate in '..\..\QRCodeGenLib\src\Interfaces\QlpIQrTemplate.pas',
  QlpQrCode in '..\..\QRCodeGenLib\src\QRCodeGen\QlpQrCode.pas',
  QlpIQrCode in '..\..\QRCodeGenLib\src\Interfaces\QlpIQrCode.pas',
  QlpQrCodeCommons in '..\..\QRCodeGenLib\src\QRCodeGen\QlpQrCodeCommons.pas',
  QlpConverters in '..\..\QRCodeGenLib\src\Utils\QlpConverters.pas',
  uQrCodeGeneratorDemo in '..\src\uQrCodeGeneratorDemo.pas';

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
