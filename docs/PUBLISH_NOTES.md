# Publish Notes

## Repo

Expected public URL:

```text
https://github.com/woodie228/greg-jumbotron-flame
```

## Release Contents

- `README.md`
- `LICENSE`
- `docs/LINKEDIN_POST.md`
- `docs/PUBLISH_NOTES.md`
- `matchbox/README.txt`
- `matchbox/greg_jumbotron.glsl`
- `matchbox/greg_jumbotron.xml`
- `matchbox/greg_jumbotron.mx`

## Reflection Update

- Added optional fake glossy reflection controls.
- Added `Reflection Pass` output mode for rendering/checking the reflection layer alone.
- `Reflection Amount` controls on/off behavior; `0.0` disables the reflection.

## Validation

Built successfully in the Greg workspace with:

```text
/opt/Autodesk/flame_2026.2.2/bin/shader_builder -m -p dist/flame_jumbotron_matchbox/greg_jumbotron.glsl
/opt/Autodesk/flame_2025.2.2/bin/shader_builder -m -p dist/flame_jumbotron_matchbox/greg_jumbotron.glsl
```
