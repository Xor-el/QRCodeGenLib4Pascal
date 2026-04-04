# QRCodeGenLib4Pascal

[![Build Status](https://github.com/Xor-el/QRCodeGenLib4Pascal/actions/workflows/make.yml/badge.svg)](https://github.com/Xor-el/QRCodeGenLib4Pascal/actions/workflows/make.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Xor-el/QRCodeGenLib4Pascal/blob/master/LICENSE)
[![Delphi](https://img.shields.io/badge/Delphi-XE3%2B-red.svg)](https://www.embarcadero.com/products/delphi)
[![FreePascal](https://img.shields.io/badge/FreePascal-3.0.0%2B-blue.svg)](https://www.freepascal.org/)

**QRCodeGenLib4Pascal** is a Delphi/FreePascal port of [Fast-QR-Code-generator](https://www.nayuki.io/page/fast-qr-code-generator-library) by [Nayuki](https://www.nayuki.io/), providing an easy-to-use interface for generating QR Codes, released under the permissive [MIT License](LICENSE).

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Quick Examples](#quick-examples)
- [Running Demos](#running-demos)
- [Contributing](#contributing)
- [Tip Jar](#tip-jar)
- [License](#license)

## Features

- **All QR versions and error correction levels** -- supports encoding all 40 versions (sizes) and all 4 error correction levels, as per the QR Code Model 2 standard
- **Multiple output formats** -- raw modules/pixels, SVG XML string/file, `ImageObject` (`bmp`, `jpg`, `png`) for VCL and LCL
- **Efficient encoding** -- numeric and special-alphanumeric text encoded in less space than general text
- **Customizable colors** -- configurable background and foreground colors for generated QR codes
- **Fine-grained control** -- specify version range, mask pattern, error correction level, or let the library choose optimal values automatically
- **ECI segments** -- manually create data segment lists and add ECI segments
- **Cross-framework** -- FCL, VCL (Delphi), LCL (Lazarus), and experimental FMX support

## Getting Started

### Prerequisites

| Compiler | Minimum Version |
|---|---|
| Delphi | XE3 or later |
| FreePascal | 3.0.0 or later |

### Supported Frameworks

| Framework | Notes |
|---|---|
| FCL | FreePascal |
| VCL | Delphi |
| LCL | Lazarus |
| FMX | Experimental -- enable `{.$DEFINE Framework_FMX}` in `QRCodeGenLib.inc` |

### Installation

**Method 1: Using Packages**

Use the provided packages in the `Packages` folder.

**Method 2: Search Path**

Add the library path and its subdirectories to your project's search path.

## Quick Examples

### Generate a Simple QR Code (SVG)

```pascal
uses
  SysUtils, QlpQRCodeGenLibTypes, QlpQRCode, QlpIQRCode;  

var
  LQR: IQRCode;
  LSVG: String;
begin
  LQR := TQRCode.EncodeText('Hello QRCodeGenLib4Pascal',
    TQrCode.TEcc.eccLow, TEncoding.UTF8);
  LSVG := LQR.ToSVGString(4);

  WriteLn(LSVG);   
end;
```

### Generate a QR Code with Custom Colors (BMP -- VCL/LCL)

```pascal
uses
  SysUtils, Graphics, QlpQRCodeGenLibTypes, QlpQRCode, QlpIQrCode;  

var
  LQR: IQRCode;
  LBmp: TQRCodeGenLibBitmap;
begin
  LQR := TQRCode.EncodeText('Custom colors!',
    TQRCode.TEcc.eccMedium, TEncoding.UTF8);

  LBmp := LQR.ToBitmapImage(10, 4); 
  try
    LBmp.SaveToFile('qrcode.bmp');
  finally
    LBmp.Free;
  end; 
end;
```

### Advanced: Manual Segment with Version Range

```pascal
uses
  SysUtils, QlpQRCodeGenLibTypes, QlpQRCode, QlpIQRCode, QlpQRSegment, QlpIQRSegment; 

var
  LSegments: TArray<IQrSegment>;
  LQR: IQRCode;  
begin
  LSegments := TQRSegment.MakeSegments('0123456789', TEncoding.UTF8);

  LQR := TQRCode.EncodeSegments(LSegments,
    TQRCode.TEcc.eccHigh,
    5,   // minimum version
    10,  // maximum version
    -1,  // auto mask
    True // boost ECC
  );

  WriteLn(LQR.ToSVGString(4));
end;
```

## Running Demos

Check out the `QRCodeGenLib.Demo` folder for complete working examples.

## Contributing

Contributions are welcome. Please open an [issue](https://github.com/Xor-el/QRCodeGenLib4Pascal/issues) for bug reports or feature requests, and submit pull requests.

## Tip Jar

If you find this library useful and would like to support its continued development, tips are greatly appreciated! 🙏

| Cryptocurrency | Wallet Address |
|---|---|
| <img src="https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/32/icon/btc.png" width="20" alt="Bitcoin" /> **Bitcoin (BTC)** | `bc1quqhe342vw4ml909g334w9ygade64szqupqulmu` |
| <img src="https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/32/icon/eth.png" width="20" alt="Ethereum" /> **Ethereum (ETH)** | `0x53651185b7467c27facab542da5868bfebe2bb69` |
| <img src="https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/32/icon/sol.png" width="20" alt="Solana" /> **Solana (SOL)** | `BPZHjY1eYCdQjLecumvrTJRi5TXj3Yz1vAWcmyEB9Miu` |

## License

QRCodeGenLib4Pascal is released under the [MIT License](LICENSE).