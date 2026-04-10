# Package icons

| File | Contents |
|------|-----------|
| `QRCodeGenLib4Pascal.ico` | Multi-size Windows icon (16, 32, 48, 256), generated from `../logo.svg`. |

## Using in Delphi (`.dproj`)

1. Open the project in the IDE.
2. **Project → Options → Application** (or **Icons** depending on version).
3. Set **Application icon** to `assets\branding\icons\QRCodeGenLib4Pascal.ico` (adjust path relative to the `.dproj`).

Alternatively, your `.dproj` may contain an `<Icon_MainIcon>` or similar property pointing at an `.ico` file; set it to a path **relative to the project file** (you may copy the icon next to the `.dproj` if the IDE resolves paths more reliably that way).

## Using in Lazarus (`.lpi`)

1. **Project → Project Options → Application** — set **Icon** to this `.ico`.
2. Or edit the `.lpi` XML: look for `IconPath` / `Icon` style keys and set the path (relative to `.lpi` is common).

## Regeneration

After changing `../logo.svg`, rebuild the ICO with the same raster workflow as in `../README.md` (Inkscape or ImageMagick, then combine sizes into a multi-resolution `.ico` if your tool does not do that in one step).
