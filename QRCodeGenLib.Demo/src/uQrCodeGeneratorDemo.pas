unit uQrCodeGeneratorDemo;

{$IFNDEF FPC}
{$DEFINE DELPHI}
{$ELSE}
{$MODE DELPHI}
{$ENDIF FPC}

interface

uses
  SysUtils,
  Graphics,
{$IFDEF DELPHI}
  Imaging.jpeg, // for Delphi JPEG Support
  Imaging.pngimage, // for Delphi PNG Support
{$ENDIF DELPHI}
  QlpIQrCode,
  QlpQrCode,
  QlpIQrSegment,
  QlpQrSegment,
  QlpQrSegmentMode,
  QlpBitBuffer,
  QlpConverters,
  QlpQRCodeGenLibTypes;

type
  TQrCodeGeneratorDemo = class sealed(TObject)
  strict private
    class function RGB(Ar, Ag, Ab: Byte): TColor; inline;
    class function HTMLColorToTColor(const AHTMLColorHex: String)
      : TColor; inline;
    class procedure WriteQrCodeToFile(const AQrCode: IQrCode;
      AScale, ABorder: Int32; const AFileName: String);

    // Creates a single QR Code, then writes it to supported image formats and an SVG file.
    class procedure DoBasicDemo();
    // Creates a single QR Code, changes the colors (background and foreground) then writes it to supported image formats and an SVG file.
    class procedure DoBasicDemoAndChangeColor();
    // Creates a variety of QR Codes that exercise different features of the library, then writes each one to supported image formats and an SVG file.
    class procedure DoVarietyDemo();
    // Creates QR Codes with manually specified segments for better compactness, then writes each one to supported image formats and an SVG file.
    class procedure DoSegmentDemo();
    // Creates QR Codes with the same size and contents but different mask patterns, then writes each one to supported image formats and an SVG file.
    class procedure DoMaskDemo();

  public
    class procedure RunAllDemos();
  end;

implementation

{ TQrCodeGeneratorDemo }

class function TQrCodeGeneratorDemo.RGB(Ar, Ag, Ab: Byte): TColor;
begin
  Result := (Ar or (Ag shl 8) or (Ab shl 16));
end;

class function TQrCodeGeneratorDemo.HTMLColorToTColor(const AHTMLColorHex
  : String): TColor;
var
  Lr, Lg, Lb: Byte;
begin
{$IFDEF DEBUG}
  System.Assert(System.Length(AHTMLColorHex) = 6);
{$ENDIF DEBUG}
  Lr := StrToInt('$' + System.Copy(AHTMLColorHex, 1, 2));
  Lg := StrToInt('$' + System.Copy(AHTMLColorHex, 3, 2));
  Lb := StrToInt('$' + System.Copy(AHTMLColorHex, 5, 2));
  Result := TColor(RGB(Lr, Lg, Lb));
end;

class procedure TQrCodeGeneratorDemo.DoBasicDemo;
var
  LText: String;
  LErrCorLvl: TQrCode.TEcc;
  LQrCode: IQrCode;
  LEncoding: TEncoding;
begin
  LEncoding := TEncoding.UTF8;
  LText := 'Hello, world!'; // User-supplied Unicode text
  LErrCorLvl := TQrCode.TEcc.eccLow; // Error correction level
  // Make the QR Code symbol
  LQrCode := TQrCode.EncodeText(LText, LErrCorLvl, LEncoding);
  WriteQrCodeToFile(LQrCode, 10, 4, 'hello-world-QR');
end;

class procedure TQrCodeGeneratorDemo.DoBasicDemoAndChangeColor;
var
  LText: String;
  LErrCorLvl: TQrCode.TEcc;
  LQrCode: IQrCode;
  LEncoding: TEncoding;
begin
  LEncoding := TEncoding.UTF8;
  LText := 'Hello, world!'; // User-supplied Unicode text
  LErrCorLvl := TQrCode.TEcc.eccLow; // Error correction level
  // Make the QR Code symbol
  LQrCode := TQrCode.EncodeText(LText, LErrCorLvl, LEncoding);
  LQrCode.BackgroundColor := HTMLColorToTColor('FFA500');
  LQrCode.ForegroundColor := HTMLColorToTColor('000000');
  WriteQrCodeToFile(LQrCode, 10, 4, 'hello-world-orange-background-QR');
end;

class procedure TQrCodeGeneratorDemo.DoSegmentDemo;
const
  // Kanji mode encoding (13 bits per character)
  kanjiChars: array [0 .. 28] of Int32 = ($0035, $1002, $0FC0, $0AED, $0AD7,
    $015C, $0147, $0129, $0059, $01BD, $018D, $018A, $0036, $0141, $0144, $0001,
    $0000, $0249, $0240, $0249, $0000, $0104, $0105, $0113, $0115, $0000, $0208,
    $01FF, $0008);
var
  LSilver0, LSilver1, LGolden0, LGolden1, LGolden2, LMadoka: String;
  LBitBuffer: TBitBuffer;
  LEncoding: TEncoding;
  LQrCode: IQrCode;
  LSegs: TQRCodeGenLibGenericArray<IQrSegment>;
  LCIdx: Int32;
begin
  LEncoding := TEncoding.UTF8;
  // Illustration "silver"
  LSilver0 := 'THE SQUARE ROOT OF 2 IS 1.';
  LSilver1 :=
    '41421356237309504880168872420969807856967187537694807317667973799';
  LQrCode := TQrCode.EncodeText(LSilver0 + LSilver1, TQrCode.TEcc.eccLow,
    LEncoding);
  WriteQrCodeToFile(LQrCode, 10, 3, 'sqrt2-monolithic-QR');

  LSegs := TQRCodeGenLibGenericArray<IQrSegment>.Create
    (TQrSegment.MakeAlphanumeric(LSilver0), TQrSegment.MakeNumeric(LSilver1));
  LQrCode := TQrCode.EncodeSegments(LSegs, TQrCode.TEcc.eccLow);
  WriteQrCodeToFile(LQrCode, 10, 3, 'sqrt2-segmented-QR');

  // Illustration "golden"
  LGolden0 := 'Golden ratio φ = 1.';
  LGolden1 :=
    '6180339887498948482045868343656381177203091798057628621354486227052604628189024497072072041893911374';
  LGolden2 := '......';
  LQrCode := TQrCode.EncodeText(LGolden0 + LGolden1 + LGolden2,
    TQrCode.TEcc.eccLow, LEncoding);
  WriteQrCodeToFile(LQrCode, 8, 5, 'phi-monolithic-QR.png');

  LSegs := TQRCodeGenLibGenericArray<IQrSegment>.Create
    (TQrSegment.MakeBytes(TConverters.ConvertStringToBytes(LGolden0, LEncoding)
    ), TQrSegment.MakeNumeric(LGolden1), TQrSegment.MakeAlphanumeric(LGolden2));
  LQrCode := TQrCode.EncodeSegments(LSegs, TQrCode.TEcc.eccLow);
  WriteQrCodeToFile(LQrCode, 8, 5, 'phi-segmented-QR');

  // Illustration "Madoka": kanji, kana, Cyrillic, full-width Latin, Greek characters
  LMadoka := '「魔法少女まどか☆マギカ」って、　ИАИ　ｄｅｓｕ　κα？';
  LQrCode := TQrCode.EncodeText(LMadoka, TQrCode.TEcc.eccLow, LEncoding);
  WriteQrCodeToFile(LQrCode, 9, 4, 'madoka-utf8-QR');

  LBitBuffer := TBitBuffer.Create();
  for LCIdx in kanjiChars do
  begin
    LBitBuffer.AppendBits(LCIdx, 13);
  end;
  LSegs := TQRCodeGenLibGenericArray<IQrSegment>.Create
    (TQrSegment.Create(TQrSegmentMode.qsmKanji, System.Length(kanjiChars),
    LBitBuffer.Data, LBitBuffer.bitLength) as IQrSegment);
  LQrCode := TQrCode.EncodeSegments(LSegs, TQrCode.TEcc.eccLow);
  WriteQrCodeToFile(LQrCode, 9, 4, 'madoka-kanji-QR');
end;

class procedure TQrCodeGeneratorDemo.DoMaskDemo;
var
  LQrCode: IQrCode;
  LSegs: TQRCodeGenLibGenericArray<IQrSegment>;
  LEncoding: TEncoding;
begin
  LEncoding := TEncoding.UTF8;
  // Project Nayuki URL
  LSegs := TQrSegment.MakeSegments('https://www.nayuki.io/', LEncoding);
  // Automatic mask
  LQrCode := TQrCode.EncodeSegments(LSegs, TQrCode.TEcc.eccHigh,
    TQrCode.MIN_VERSION, TQrCode.MAX_VERSION, -1, true);
  WriteQrCodeToFile(LQrCode, 8, 6, 'project-nayuki-automask-QR');
  // Force mask 3
  LQrCode := TQrCode.EncodeSegments(LSegs, TQrCode.TEcc.eccHigh,
    TQrCode.MIN_VERSION, TQrCode.MAX_VERSION, 3, true);
  WriteQrCodeToFile(LQrCode, 8, 6, 'project-nayuki-mask3-QR');

  // Chinese text as UTF-8
  LSegs := TQrSegment.MakeSegments
    ('維基百科（Wikipedia，聆聽i/ˌwɪkᵻˈpiːdi.ə/）是一個自由內容、公開編輯且多語言的網路百科全書協作計畫',
    LEncoding);
  // Force mask 0
  LQrCode := TQrCode.EncodeSegments(LSegs, TQrCode.TEcc.eccMedium,
    TQrCode.MIN_VERSION, TQrCode.MAX_VERSION, 0, true);
  WriteQrCodeToFile(LQrCode, 10, 3, 'unicode-mask0-QR');
  // Force mask 1
  LQrCode := TQrCode.EncodeSegments(LSegs, TQrCode.TEcc.eccMedium,
    TQrCode.MIN_VERSION, TQrCode.MAX_VERSION, 1, true);
  WriteQrCodeToFile(LQrCode, 10, 3, 'unicode-mask1-QR');
  // Force mask 5
  LQrCode := TQrCode.EncodeSegments(LSegs, TQrCode.TEcc.eccMedium,
    TQrCode.MIN_VERSION, TQrCode.MAX_VERSION, 5, true);
  WriteQrCodeToFile(LQrCode, 10, 3, 'unicode-mask5-QR');
  // Force mask 7
  LQrCode := TQrCode.EncodeSegments(LSegs, TQrCode.TEcc.eccMedium,
    TQrCode.MIN_VERSION, TQrCode.MAX_VERSION, 7, true);
  WriteQrCodeToFile(LQrCode, 10, 3, 'unicode-mask7-QR');
end;

class procedure TQrCodeGeneratorDemo.DoVarietyDemo;
var
  LQrCode: IQrCode;
  LEncoding: TEncoding;
begin
  LEncoding := TEncoding.UTF8;
  // Numeric mode encoding (3.33 bits per digit)
  LQrCode := TQrCode.EncodeText
    ('314159265358979323846264338327950288419716939937510',
    TQrCode.TEcc.eccMedium, LEncoding);
  WriteQrCodeToFile(LQrCode, 13, 1, 'pi-digits-QR');

  // Alphanumeric mode encoding (5.5 bits per character)
  LQrCode := TQrCode.EncodeText
    ('DOLLAR-AMOUNT:$39.87 PERCENTAGE:100.00% OPERATIONS:+-*/',
    TQrCode.TEcc.eccHigh, LEncoding);
  WriteQrCodeToFile(LQrCode, 10, 2, 'alphanumeric-QR');

  // Unicode text as UTF-8
  LQrCode := TQrCode.EncodeText('こんにちwa、世界！ αβγδ', TQrCode.TEcc.eccQuartile,
    LEncoding);
  WriteQrCodeToFile(LQrCode, 10, 3, 'unicode-QR');

  // Moderately large QR Code using longer text (from Lewis Carroll's Alice in Wonderland)

  LQrCode := TQrCode.EncodeText
    ('Alice was beginning to get very tired of sitting by her sister on the bank, '
    + 'and of having nothing to do: once or twice she had peeped into the book her sister was reading, '
    + 'but it had no pictures or conversations in it, ''and what is the use of a book,'' thought Alice '
    + '''without pictures or conversations?'' So she was considering in her own mind (as well as she could, '
    + 'for the hot day made her feel very sleepy and stupid), whether the pleasure of making a '
    + 'daisy-chain would be worth the trouble of getting up and picking the daisies, when suddenly '
    + 'a White Rabbit with pink eyes ran close by her.',
    TQrCode.TEcc.eccQuartile, LEncoding);
  WriteQrCodeToFile(LQrCode, 6, 10, 'alice-wonderland-QR');

end;

class procedure TQrCodeGeneratorDemo.RunAllDemos;
begin
  WriteLn('Started "DoBasicDemo"');
  DoBasicDemo();
  WriteLn('Finished "DoBasicDemo"');
  WriteLn('Started "DoBasicDemoAndChangeColor"');
  DoBasicDemoAndChangeColor();
  WriteLn('Finished "DoBasicDemoAndChangeColor"');
  WriteLn('Started "DoVarietyDemo"');
  DoVarietyDemo();
  WriteLn('Finished "DoVarietyDemo"');
  WriteLn('Started "DoSegmentDemo"');
  DoSegmentDemo();
  WriteLn('Finished "DoSegmentDemo"');
  WriteLn('Started "DoMaskDemo"');
  DoMaskDemo();
  WriteLn('Finished "DoMaskDemo"');

  WriteLn(sLineBreak);
  WriteLn('Finished Executing All Demos');
end;

class procedure TQrCodeGeneratorDemo.WriteQrCodeToFile(const AQrCode: IQrCode;
  AScale, ABorder: Int32; const AFileName: String);
const
  FolderName: String = 'Assets';
var
  LFilePath: String;
  LBitmap: TBitmap;
  LJpeg: TJPEGImage;
  LPng: {$IFDEF FPC}TPortableNetworkGraphic{$ELSE}TPngImage{$ENDIF FPC};
begin
  LFilePath := ExtractFilePath(ParamStr(0));
  LFilePath := IncludeTrailingPathDelimiter(LFilePath);
  LFilePath := IncludeTrailingPathDelimiter(LFilePath) + FolderName;
  LFilePath := IncludeTrailingPathDelimiter(LFilePath);

  if not DirectoryExists(LFilePath) then
  begin
    if not ForceDirectories(LFilePath) then
    begin
      // break out since we cannot create our "Assets" directory.
      WriteLn(Format('Error creating our "%s" directory.', [LFilePath]));
      Exit;
    end;
  end;
  LFilePath := LFilePath + AFileName;
  // save bmp
  LBitmap := AQrCode.ToBmpImage(AScale, ABorder);
  // save jpeg
  LJpeg := AQrCode.ToJpegImage(AScale, ABorder);
  // save png
  LPng := AQrCode.ToPngImage(AScale, ABorder);
  try
    try
      LBitmap.SaveToFile(LFilePath + '.bmp');
      LJpeg.SaveToFile(LFilePath + '.jpg');
      LPng.SaveToFile(LFilePath + '.png');
      AQrCode.ToSvgFile(ABorder, LFilePath + '.svg');
    except
      raise;
    end;
  finally
    LBitmap.Free;
    LJpeg.Free;
    LPng.Free;
  end;
end;

end.
