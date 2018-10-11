unit QlpConverters;

{$I ..\Include\QRCodeGenLib.inc}

interface

uses
  SysUtils,
  QlpGuard,
  QlpQRCodeGenLibTypes;

resourcestring
  SEncodingInstanceNil = 'Encoding instance cannot be nil';

type
  TConverters = class sealed(TObject)

  public

    class function ConvertStringToBytes(const AInput: String;
      const AEncoding: TEncoding): TQRCodeGenLibByteArray; overload; static;

    class function ConvertBytesToString(const AInput: TQRCodeGenLibByteArray;
      const AEncoding: TEncoding): String; overload; static;
  end;

implementation

{ TConverters }

class function TConverters.ConvertStringToBytes(const AInput: String;
  const AEncoding: TEncoding): TQRCodeGenLibByteArray;
begin
  TGuard.RequireNotNull(AEncoding, SEncodingInstanceNil);
{$IFDEF FPC}
  result := AEncoding.GetBytes(UnicodeString(AInput));
{$ELSE}
  result := AEncoding.GetBytes(AInput);
{$ENDIF FPC}
end;

class function TConverters.ConvertBytesToString(const AInput
  : TQRCodeGenLibByteArray; const AEncoding: TEncoding): String;
begin
  TGuard.RequireNotNull(AEncoding, SEncodingInstanceNil);
{$IFDEF FPC}
  result := String(AEncoding.GetString(AInput));
{$ELSE}
  result := AEncoding.GetString(AInput);
{$ENDIF FPC}
end;

end.
