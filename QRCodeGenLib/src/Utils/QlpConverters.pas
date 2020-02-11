unit QlpConverters;

{$I ..\Include\QRCodeGenLib.inc}

interface

uses
{$IF DEFINED(VCL)}
  Vcl.Graphics,
{$ELSEIF DEFINED(FMX)}
  FMX.Graphics,
  UIConsts,
  UITypes,
{$ELSEIF DEFINED(LCL)}
  Graphics,
  Interfaces, // Added so that the LCL will Initialize the WidgetSet
{$IFEND}
  SysUtils,
  QlpGuard,
  QlpQRCodeGenLibTypes;

resourcestring
  SEncodingInstanceNil = 'Encoding instance cannot be nil';

type
  TConverters = class sealed(TObject)

  strict private
{$IFNDEF FMX}
    /// <summary>
    /// Convert a Delphi/Lazarus <c>TColor</c> to <c>HTML</c> Color code in
    /// Hex <c>.</c>
    /// </summary>
    /// <param name="AColor">
    /// the <c>TColor</c> to convert
    /// </param>
    /// <returns>
    /// returns a string containing the <c>HTML</c> Color code representation
    /// of the <c>TColor</c> parameter in Hex
    /// </returns>
    class function TColorToHTMLColorHex(const AColor: TQRCodeGenLibColor)
      : String; inline;

{$ELSE}
    /// <summary>
    /// Convert a Delphi FireMonkey <c>TAlphaColor</c> to <c>HTML</c> Color code in
    /// Hex <c>.</c>
    /// </summary>
    /// <param name="AColor">
    /// the <c>TAlphaColor</c> to convert
    /// </param>
    /// <returns>
    /// returns a string containing the <c>HTML</c> Color code representation
    /// of the <c>TAlphaColor</c> parameter in Hex
    /// </returns>
    class function TAlphaColorToHTMLColorHex(const AColor: TQRCodeGenLibColor)
      : String; inline;

{$ENDIF FMX}
  public

{$IFNDEF FMX}
    class function GetRValue(Argb: UInt32): Byte; static; inline;
    class function GetGValue(Argb: UInt32): Byte; static; inline;
    class function GetBValue(Argb: UInt32): Byte; static; inline;
{$ENDIF FMX}
    class function ConvertStringToBytes(const AInput: String;
      const AEncoding: TEncoding): TQRCodeGenLibByteArray; static;

    class function ConvertBytesToString(const AInput: TQRCodeGenLibByteArray;
      const AEncoding: TEncoding): String; static;

    class function ColorToHTMLColorHex(const AColor: TQRCodeGenLibColor)
      : String; inline;
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

{$IFNDEF FMX}

class function TConverters.GetRValue(Argb: UInt32): Byte;
begin
  result := Byte(Argb);
end;

class function TConverters.GetGValue(Argb: UInt32): Byte;
begin
  result := Byte(Argb shr 8);
end;

class function TConverters.GetBValue(Argb: UInt32): Byte;
begin
  result := Byte(Argb shr 16);
end;

class function TConverters.TColorToHTMLColorHex(const AColor
  : TQRCodeGenLibColor): String;
begin
  result := Format('%.2x%.2x%.2x', [GetRValue(ColorToRGB(AColor)),
    GetGValue(ColorToRGB(AColor)), GetBValue(ColorToRGB(AColor))]);
end;

{$ELSE}

class function TConverters.TAlphaColorToHTMLColorHex(const AColor
  : TQRCodeGenLibColor): String;
begin
  result := Format('%.2x%.2x%.2x', [TAlphaColorRec(AColor).R,
    TAlphaColorRec(AColor).G, TAlphaColorRec(AColor).B]);
end;

{$ENDIF FMX}

class function TConverters.ColorToHTMLColorHex(const AColor
  : TQRCodeGenLibColor): String;
begin
{$IFNDEF FMX}
  result := TConverters.TColorToHTMLColorHex(AColor);
{$ELSE}
  result := TConverters.TAlphaColorToHTMLColorHex(AColor);
{$ENDIF FMX}
end;

end.
