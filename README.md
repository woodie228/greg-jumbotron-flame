# Greg Jumbotron for Autodesk Flame

Greg Jumbotron is a Matchbox shader for Autodesk Flame that gives footage an animated LED screen / stadium video-board texture.

It is built for finishing work where you need something to feel like it is playing on a screen, board, wall, phone, monitor, or display surface without rebuilding the same scanline and pixel-grid setup every time.

## Download

Use the compiled Matchbox:

- `matchbox/greg_jumbotron.mx`

Source files are included too:

- `matchbox/greg_jumbotron.glsl`
- `matchbox/greg_jumbotron.xml`

## What It Does

- Adds LED cell quantization.
- Adds dark gaps between LED cells.
- Adds RGB subpixel / triad striping.
- Adds animated scanlines and per-cell flicker.
- Adds fine moire and a rolling refresh band.
- Adds subtle edge bloom from bright screen detail.
- Adds an optional fake glossy reflection pass for shiny screens.
- Includes output modes for texture preview, LED matte, pixel source, reflection pass, and final composite.

## Install

Copy `greg_jumbotron.mx` into a Flame Matchbox shader folder.

Suggested folder:

```text
/opt/Autodesk/user/<user_version>/matchbox/shaders/FILTERS
```

Restart Flame or rescan Matchbox shaders if needed.

If you prefer to compile locally, keep `greg_jumbotron.glsl` and `greg_jumbotron.xml` together and build with Autodesk's `shader_builder`.

## Basic Flame Workflow

1. Add `Greg Jumbotron` as a Matchbox shader.
2. Connect your plate to `Front`.
3. Set `Output Mode` to `Texture Preview` to tune the screen texture.
4. Switch `Output Mode` back to `Composite`.
5. Animate `Animation Phase` upward over the shot.
6. Use `Mix` to blend the processed look back over the original.
7. Use `Reflection Amount` to add or remove the glossy reflection layer.

## Controls

- `Output Mode`: Composite, Jumbotron Only, Texture Preview, LED Matte, Pixel Source, Reflection Pass.
- `Pixel Pitch`: distance between LED cells in pixels.
- `LED Size`: how much each LED fills its cell.
- `Grid Darkness`: darkness of the gaps between LEDs.
- `Scanlines`: strength of horizontal electronic scanlines.
- `Scan Spacing`: spacing of the scanlines in pixels.
- `RGB Triads`: amount of red/green/blue subpixel striping.
- `Flicker`: animated per-cell brightness variation.
- `Animation Phase`: main keyframable animation control.
- `Refresh Band`: strength of the rolling screen refresh artifact.
- `Band Width`: width of the rolling refresh band.
- `Moire`: fine filmed-screen interference pattern.
- `Edge Bloom`: subtle glow from bright screen detail.
- `Contrast`, `Saturation`, `Brightness`: source shaping before the LED texture.
- `Mix`: blends between the source and the processed result.
- `Preserve Alpha`: keeps source alpha unchanged.
- `Reflection Amount`: amount of fake glossy reflection; set to `0.0` to turn it off.
- `Reflection Position`: vertical placement of the main reflection band before angle is applied.
- `Reflection Width`: width and softness of the main reflection band.
- `Reflection Angle`: diagonal angle of the reflection.
- `Reflection Streaks`: fine streak and glint detail inside the reflection.
- `Reflection Tint`: cool tint amount for the reflection.

## Suggested Starting Points

### Stadium Board / Jumbotron

- `Pixel Pitch`: `12.0` to `18.0`
- `LED Size`: `0.70`
- `Grid Darkness`: `0.70`
- `RGB Triads`: `0.60` to `0.80`
- `Scanlines`: `0.35` to `0.55`
- `Flicker`: `0.10` to `0.20`
- `Refresh Band`: `0.15` to `0.30`
- `Moire`: `0.15` to `0.30`
- `Reflection Amount`: `0.15` to `0.35`
- `Mix`: `1.0`

### Close Filmed Screen

- `Pixel Pitch`: `4.0` to `8.0`
- `LED Size`: `0.60`
- `Grid Darkness`: `0.80`
- `RGB Triads`: `0.85` to `1.0`
- `Scanlines`: `0.45` to `0.70`
- `Flicker`: `0.15` to `0.30`
- `Refresh Band`: `0.20` to `0.40`
- `Moire`: `0.30` to `0.60`
- `Reflection Amount`: `0.25` to `0.60`
- `Mix`: `0.70` to `1.0`

### Reflection Pass Only

- `Output Mode`: `Reflection Pass`
- `Reflection Amount`: `0.4` to `1.0`
- `Reflection Position`: adjust to place the main glossy band.
- `Reflection Width`: `0.06` to `0.18`
- `Reflection Angle`: `-0.12` to `0.12`
- `Reflection Streaks`: `0.35` to `0.85`

## Notes

- Written for GLSL 120 for broad Flame compatibility.
- Single-input and procedural; no extra texture map is required.
- Commercial use is permitted.
- This shader is original work by Ryan Wood and is not a port of third-party shader code.
- Contact: ryan@truenorthcreativetech.com

## License

Greg Jumbotron is released under the MIT License. See [LICENSE](LICENSE).

Commercial use, modification, distribution, and derivative works are permitted under the terms of the MIT License.
