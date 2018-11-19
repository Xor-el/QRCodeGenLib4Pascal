unit QlpQRCodeGenLibTypes;

{$I ..\Include\QRCodeGenLib.inc}

interface

uses
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

implementation

{$IFDEF FPC}

initialization

// Set UTF-8 in AnsiStrings, just like Lazarus
SetMultiByteConversionCodePage(CP_UTF8);
// SetMultiByteFileSystemCodePage(CP_UTF8); not needed, this is the default under Windows
SetMultiByteRTLFileSystemCodePage(CP_UTF8);
{$ENDIF FPC}

end.
