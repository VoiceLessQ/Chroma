# End Dimension Shaders

This folder contains shaders specific to the End dimension (dimension ID: 1).

## Usage

Place shader files here to override the default shaders when the player is in the End.
Files must match the names in the main shaders folder to override them.

## Examples

- `composite.fsh` - Override composite fragment shader for End
- `gbuffers_terrain.fsh` - Override terrain rendering for End blocks
- `final.fsh` - Override final output for End-specific effects

## Notes

- Only override files that need dimension-specific changes
- Missing files fall back to the main shaders folder
- Use `#include "/shaders/..."` to include shared code
