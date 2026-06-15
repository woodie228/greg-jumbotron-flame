Greg Jumbotron Matchbox

Files
- greg_jumbotron.glsl
- greg_jumbotron.xml
- greg_jumbotron.mx

What it does
- Turns an image into an animated Jumbotron / stadium video-board look.
- Adds LED cell quantization, dark gaps, RGB subpixel triads, scanlines, flicker, moire, a rolling refresh band, and subtle edge bloom.
- Animation Phase is the main control to keyframe for movement.

Suggested first use
1. Add Greg Jumbotron as a Matchbox shader.
2. Start with Output Mode set to Texture Preview to tune the screen pattern.
3. Switch back to Composite.
4. Animate Animation Phase from 0 upward over the shot.

Controls
- Pixel Pitch: LED grid size in pixels.
- LED Size: how much each LED fills its cell.
- Grid Darkness: darkness between LEDs.
- Scanlines / Scan Spacing: electronic horizontal lines.
- RGB Triads: red/green/blue subpixel striping.
- Flicker: animated per-cell brightness variation.
- Animation Phase: keyframe this for motion.
- Refresh Band / Band Width: rolling vertical screen refresh artifact.
- Moire: fine filmed-screen interference.
- Edge Bloom: subtle glow from bright screen detail.
- Contrast / Saturation / Brightness: source shaping before the LED texture.
- Mix: blend between the source and the processed look.

Install
1. Copy `greg_jumbotron.mx`, or copy `greg_jumbotron.glsl` and `greg_jumbotron.xml`, into a Flame Matchbox shader folder.
2. Autodesk's stock shader location is usually:
   `/opt/Autodesk/presets/<application version>/matchbox/shaders/`
3. A user shader location is usually:
   `/opt/Autodesk/user/<user_version>/matchbox/shaders/FILTERS/`

Notes
- Written to GLSL 120 for broad Flame compatibility.
- The filter is single-input and procedural; no extra texture map is required.
- For a giant stadium-board look, use Pixel Pitch around 10-18.
- For an extreme closeup filmed-screen look, use Pixel Pitch around 4-8 and raise RGB Triads/Moire.
