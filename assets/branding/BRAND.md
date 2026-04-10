# QRCodeGenLib4Pascal — lightweight brand guide

## Primary mark

- **Default:** [`logo.svg`](logo.svg) — **scan frame** around a **white QR tile**: cyan **corner brackets** (viewfinder) and a **6×6 module** pattern (stylized, not a real payload). Reads as **QR generation / encoding**, not a scanner app icon alone.
- **Dark UI:** [`logo-dark.svg`](logo-dark.svg) — same layout on a **near-black** badge, **slate** inner tile, **light** modules, **bright cyan** frame.

**QR Code** is a registered trademark of **DENSO WAVE INCORPORATED**. This mark is an original graphic for the library project; it does not imply endorsement by Denso Wave.

## Palette (default logo)

| Role | Hex | Notes |
|------|-----|--------|
| Badge top | `#0c4a6e` | Gradient start (diagonal). |
| Badge bottom | `#0f172a` | Gradient end. |
| Inner tile | `#f8fafc` | “Paper” behind modules. |
| Scan frame | `#22d3ee` | 4 px stroke, rounded caps. |
| Modules | `#0f172a` | 5 px squares, 2 px gap; centered in bracket opening. |

Dark variant uses `#0f172a`–`#020617`, tile `#1e293b`, frame `#67e8f9`, modules `#e2e8f0`.

**Banner background** (flat fill behind the logo for wide social and Open Graph PNGs [here](export/)): RGB **13, 74, 110** (`#0d4a6e`) — aligned with the default badge teal; +1 red vs `#0c4a6e` so the squircle rim is visible on composites.

## Typography (pairing)

The logo has **no embedded wordmark**. When setting type next to the mark:

- Prefer **clean sans-serif** system or UI fonts (e.g. Segoe UI, Inter, Source Sans 3).
- **Do not** use Embarcadero’s proprietary Delphi logotype in a way that suggests a product bundle with this library.

## Clear space

Keep padding around the badge at least **1/4 of the mark’s width** (e.g. ~32 px clear space on a 128 px square canvas).

## Minimum size

- **Favicon / IDE:** readable at **16×16** when exported to ICO; prefer **32×32** or larger for clarity.
- **README / docs:** **128–200 px** wide for the SVG or equivalent raster is typical.

## Correct use

- Scale **uniformly** (preserve aspect ratio).
- Place on backgrounds with enough contrast (use `logo-dark.svg` on dark pages).
- Prefer **SVG** for web; use **PNG** where required (some social crawlers).

## Incorrect use

- Do not **stretch** or **skew** the badge.
- Do not **change hue** arbitrarily (keep palette cohesive with the table above or update this doc when rebranding).
- Do not **crop** away the rounded corners entirely.
- Do not imply **QR Code trademark** ownership; attribute the standard where appropriate in docs.

## Wordmark

“QRCodeGenLib4Pascal” in plain text beside or below the mark is sufficient.
