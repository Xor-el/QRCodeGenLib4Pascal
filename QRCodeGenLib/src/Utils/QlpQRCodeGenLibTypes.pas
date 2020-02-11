unit QlpQRCodeGenLibTypes;

{$I ..\Include\QRCodeGenLib.inc}

interface

uses
{$IF DEFINED(VCL)}
  Vcl.Graphics,
  Vcl.Imaging.jpeg, // for VCL JPEG Support
  Vcl.Imaging.pngimage, // for VCL PNG Support
{$ELSEIF DEFINED(FMX)}
  FMX.Graphics,
  UIConsts,
  UITypes,
{$ELSEIF DEFINED(LCL)}
  Graphics,
  Interfaces, // Added so that the LCL will Initialize the WidgetSet
{$IFEND}
  SysUtils;

type
  EQRCodeGenLibException = class(Exception);
  EDataTooLongQRCodeGenLibException = class(EQRCodeGenLibException);
  EInvalidOperationQRCodeGenLibException = class(EQRCodeGenLibException);
  EIndexOutOfRangeQRCodeGenLibException = class(EQRCodeGenLibException);
  EArgumentQRCodeGenLibException = class(EQRCodeGenLibException);
  EArgumentInvalidQRCodeGenLibException = class(EQRCodeGenLibException);
  EArgumentNilQRCodeGenLibException = class(EQRCodeGenLibException);
  EArgumentOutOfRangeQRCodeGenLibException = class(EQRCodeGenLibException);
  EUnsupportedTypeQRCodeGenLibException = class(EQRCodeGenLibException);
  ENullReferenceQRCodeGenLibException = class(EQRCodeGenLibException);

  /// <summary>
  /// Represents a dynamic array of Byte.
  /// </summary>
  TQRCodeGenLibByteArray = TBytes;

  /// <summary>
  /// Represents a dynamic generic array of Type T.
  /// </summary>
  TQRCodeGenLibGenericArray<T> = array of T;

{$IFDEF DELPHIXE_UP}
  /// <summary>
  /// Represents a dynamic array of Int32.
  /// </summary>
  TQRCodeGenLibInt32Array = TArray<Int32>;

  /// <summary>
  /// Represents a dynamic array of Boolean.
  /// </summary>
  TQRCodeGenLibBooleanArray = TArray<Boolean>;

  /// <summary>
  /// Represents a dynamic array of String.
  /// </summary>
  TQRCodeGenLibStringArray = TArray<String>;

  /// <summary>
  /// Represents a dynamic array of array of Byte.
  /// </summary>
  TQRCodeGenLibMatrixByteArray = TArray<TQRCodeGenLibByteArray>;

  /// <summary>
  /// Represents a dynamic array of array of Int32.
  /// </summary>
  TQRCodeGenLibMatrixInt32Array = TArray<TQRCodeGenLibInt32Array>;

{$ELSE}
  /// <summary>
  /// Represents a dynamic array of Int32.
  /// </summary>
  TQRCodeGenLibInt32Array = array of Int32;

  /// <summary>
  /// Represents a dynamic array of Boolean.
  /// </summary>
  TQRCodeGenLibBooleanArray = array of Boolean;

  /// <summary>
  /// Represents a dynamic array of String.
  /// </summary>
  TQRCodeGenLibStringArray = array of String;

  /// <summary>
  /// Represents a dynamic array of array of Byte.
  /// </summary>
  TQRCodeGenLibMatrixByteArray = array of TQRCodeGenLibByteArray;

  /// <summary>
  /// Represents a dynamic array of array of Int32.
  /// </summary>
  TQRCodeGenLibMatrixInt32Array = array of TQRCodeGenLibInt32Array;

{$ENDIF DELPHIXE_UP}
  TQRCodeGenLibColor = {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF FMX};
  TQRCodeGenLibBitmap = TBitmap;
{$IFNDEF FMX}
  TQRCodeGenLibPNGImage =
{$IFDEF FPC}TPortableNetworkGraphic{$ELSE}TPngImage{$ENDIF FPC};
  TQRCodeGenLibJPEGImage = TJPEGImage;
{$ELSE}
  TQRCodeGenLibBitmapData = TBitmapData;
  TQRCodeGenLibMapAccess = TMapAccess;
{$ENDIF FMX}

const
  QRCodeGenLibWhiteColor = {$IFNDEF FMX}clWhite{$ELSE}claWhite{$ENDIF FMX};
  QRCodeGenLibBlackColor = {$IFNDEF FMX}clBlack{$ELSE}claBlack{$ENDIF FMX};

{$IFDEF VCL}
  TwentyFourBitPixelFormat = pf24bit;
{$ENDIF VCL}

implementation

{$IFDEF FPC}

initialization

// Set UTF-8 in AnsiStrings, just like Lazarus
SetMultiByteConversionCodePage(CP_UTF8);
// SetMultiByteFileSystemCodePage(CP_UTF8); not needed, this is the default under Windows
SetMultiByteRTLFileSystemCodePage(CP_UTF8);
{$ENDIF FPC}

end.
