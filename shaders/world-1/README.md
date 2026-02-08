# Nether Dimension Shaders

This folder contains shaders specific to the Nether dimension (dimension ID: -1).

## Usage

Place shader files here to override the default shaders when the player is in the Nether.
Files must match the names in the main shaders folder to override them.

## Examples

- `composite.fsh` - Override composite fragment shader for Nether
- `gbuffers_terrain.fsh` - Override terrain rendering for Nether blocks
- `shaders.properties` - Override shader properties for Nether

## Notes

- Only override files that need dimension-specific changes
- Missing files fall back to the main shaders folder
- Use `#include "/shaders/..."` to include shared code
