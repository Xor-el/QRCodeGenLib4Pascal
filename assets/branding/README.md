# QRCodeGenLib4Pascal branding

This folder holds the **project logo** and derivative assets for README, social previews, and optional IDE package icons.

## Meaning

The mark is a **rounded badge** with a **scan-style frame** (corner brackets) around **QR modules** on a light tile. It suggests:

- **QR symbol generation** — encoding data into a QR matrix (library focus).
- **Clarity** — readable at small sizes (favicon / package icon).

It is **not** the official QR Code logo and is **not** affiliated with Denso Wave. **QR Code** is a registered trademark of **DENSO WAVE INCORPORATED**.

## Files

| File | Use |
|------|-----|
| [`logo.svg`](logo.svg) | **Source of truth** (light UI / default README). |
| [`logo-dark.svg`](logo-dark.svg) | Dark backgrounds (docs, dark-themed pages). |
| [`BRAND.md`](BRAND.md) | Colors, clear space, minimum size, do / don’t. |
| [`export/`](export/) (`*.png`) | Raster exports (GitHub social 2:1, Open Graph, social header, square avatar). |
| [`icons/QRCodeGenLib4Pascal.ico`](icons/QRCodeGenLib4Pascal.ico) | Multi-resolution Windows icon for `.dproj` / `.lpi`. |

## License

The **library source code** is under the project [MIT License](../../LICENSE). The **logo files in this directory** are also released under the **MIT License** unless the repository maintainers specify otherwise; you may use them to refer to QRCodeGenLib4Pascal. Do not use them to misrepresent authorship or to imply certification by Denso Wave or Embarcadero.

## Regenerating PNG and ICO

If you change the SVG, regenerate rasters using one of:

- **Inkscape** (CLI): export PNG at the sizes [listed here](export/README.md).
- **ImageMagick** 7+: `magick logo.svg -resize 512x512 export/logo-512.png`.
