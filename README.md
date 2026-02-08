# Chroma - OptiFine/Iris Shader Pack

[![Minecraft](https://img.shields.io/badge/Minecraft-1.12.2%2B-green.svg)](https://www.minecraft.net/)
[![OptiFine](https://img.shields.io/badge/OptiFine-HD%20U%20G5%2B-orange.svg)](https://optifine.net/)
[![Iris](https://img.shields.io/badge/Loader-Iris-8b5cf6)](https://irisshaders.net/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![OpenGL](https://img.shields.io/badge/OpenGL-3.3%2B-purple.svg)](https://www.opengl.org/)

A comprehensive Minecraft shader pack focused on realistic fog and atmospheric effects, featuring a full deferred rendering pipeline with volumetric lighting, soft shadows, and customizable post-processing. Compatible with both OptiFine and Iris shader loaders.

## Disclaimer

This shader pack is a work in progress and may contain errors or inaccuracies. 

- Some shader files may have been misunderstood or incorrectly implemented
- The code is provided as a template/blank slate for learning and development
- Not all features have been thoroughly tested
- Contributions and corrections are welcome

If you encounter any issues or have suggestions for improvements, please open an issue on the repository.

## Features

### Core Features

- **Realistic Volumetric Fog** - Atmospheric fog rendering with dynamic density
- **Atmospheric Scattering** - Natural light scattering effects
- **Weather-Based Fog** - Dynamic fog density changes based on weather conditions
- **Customizable Fog Colors** - Multiple fog color modes (Atmospheric, Sky Color, Custom)
- **Water Effects** - Reflections, refraction, and animated waves

### Shader Pipeline

- **Full GBuffers Support** - Complete 22-program geometry buffer rendering
- **Deferred Rendering** - Multi-pass deferred lighting pipeline
- **Composite Processing** - Advanced post-processing effects
- **Soft Shadow Mapping** - High-quality filtered shadows with mipmap support
- **Screen Space Ambient Occlusion** - Realistic contact shadows

### Post-Processing Effects

- **Bloom** - Glow effects on bright areas
- **Tone Mapping** - HDR simulation and color grading
- **Color Adjustment** - Saturation, contrast, and brightness controls
- **Super Sampling** - Anti-aliasing through supersampling

## Requirements

| Requirement | Minimum          | Recommended       |
| ----------- | ---------------- | ----------------- |
| Minecraft   | 1.12.2           | 1.16.5+           |
| OptiFine    | HD U G5          | HD U G8+          |
| OR Iris     | 1.5+             | Latest            |
| OpenGL      | 3.3              | 4.5+              |
| GPU Memory  | 2GB              | 4GB+              |
| GPU         | GTX 750 / R7 260 | GTX 1060 / RX 580 |

## Compatibility

This shader pack is compatible with both OptiFine and Iris shader loaders.

### Supported Platforms

| Platform | Support | Notes |
|----------|---------|-------|
| OptiFine | Full | All features supported |
| Iris | Full | All features supported |
| Vanilla | No | Requires shader loader |

### Platform Comparison

| Feature | OptiFine | Iris |
|---------|----------|------|
| Mod Loader | Forge/Standalone | Fabric/Quilt |
| Performance | Standard | Enhanced (with Sodium) |
| Open Source | No | Yes |
| Update Speed | Slower | Faster |

### Known Limitations

**Iris:**
- macOS not fully supported
- Requires OpenGL 4.3 for compute shaders
- Some older Intel GPUs not supported

**OptiFine:**
- Incompatible with Sodium
- Slower update cycle for new MC versions

## Installation

### OptiFine Installation

1. Install OptiFine for your Minecraft version from [optifine.net](https://optifine.net/)
2. Download the shader pack
3. Place the `.zip` file in your `minecraft/shaderpacks/` folder
4. Launch Minecraft and go to **Video Settings > Shaders**
5. Select "Chroma" from the shader packs list
6. Configure options via **Shader Options** button

### Iris Installation

1. Install Fabric Loader for your Minecraft version from [fabricmc.net](https://fabricmc.net/)
2. Install Iris and Sodium mods from [irisshaders.net](https://irisshaders.net/)
3. Download the shader pack
4. Place the `.zip` file in your `minecraft/shaderpacks/` folder
5. Launch Minecraft and go to **Video Settings > Shader Packs**
6. Select "Chroma" from the shader packs list

## Configuration

### In-Game Options

Access all settings via **Video Settings > Shaders > Shader Options** (OptiFine) or **Video Settings > Shader Packs > Options** (Iris)

### Available Settings

#### Profiles

| Profile           | Description                          |
| ----------------- | ------------------------------------ |
| **Default** | Balanced settings for most systems   |
| **Low**     | Optimized for performance            |
| **Medium**  | Balanced quality and performance     |
| **High**    | Quality-focused settings             |
| **Ultra**   | Maximum quality for high-end systems |

#### Shadow Settings

| Option            | Description                    | Values         |
| ----------------- | ------------------------------ | -------------- |
| Shadow Resolution | Shadow map quality             | 512px - 4096px |
| Shadow Distance   | Maximum shadow render distance | Configurable   |
| Shadow Filter     | Edge softening                 | On/Off         |

#### Lighting Settings

| Option       | Description                      |
| ------------ | -------------------------------- |
| Hand Light   | Dynamic lighting from held items |
| Old Lighting | Vanilla lighting model toggle    |
| SSAO         | Screen Space Ambient Occlusion   |
| AO Strength  | Ambient occlusion intensity      |
| AO Radius    | Sample radius for AO             |

#### Post Processing

| Option       | Description                 |
| ------------ | --------------------------- |
| Bloom        | Glow effect on bright areas |
| Tone Mapping | HDR color grading           |
| Saturation   | Color intensity             |
| Contrast     | Light/dark difference       |
| Brightness   | Overall brightness          |

#### Fog Settings

| Option         | Description                    | Values                           |
| -------------- | ------------------------------ | -------------------------------- |
| Fog            | Enable/disable atmospheric fog | On/Off                           |
| Fog Density    | Thickness of fog               | Slider                           |
| Fog Color Mode | Color calculation method       | Atmospheric / Sky Color / Custom |

#### Water Settings

| Option            | Description            |
| ----------------- | ---------------------- |
| Water Reflections | Surface reflections    |
| Water Refraction  | Light bending effect   |
| Water Waves       | Animated surface waves |

## File Structure

```
Chroma/
├── mcmeta.json                       # Pack metadata
├── Minecraft_Shader_Fundamentals.md  # Development documentation
├── README.md                         # This file
├── shaders.properties                # Main shader configuration
└── shaders/
    ├── block.properties              # Block ID mappings
    ├── entity.properties             # Entity ID mappings
    ├── item.properties               # Item ID mappings
    ├── composite.csh                 # Composite compute shader
    ├── composite.fsh                 # Composite fragment shader
    ├── composite.vsh                 # Composite vertex shader
    ├── composite1.fsh                # Composite pass 1 fragment
    ├── composite1.vsh                # Composite pass 1 vertex
    ├── composite2.fsh                # Composite pass 2 fragment
    ├── composite2.vsh                # Composite pass 2 vertex
    ├── composite3.fsh                # Composite pass 3 fragment
    ├── composite3.vsh                # Composite pass 3 vertex
    ├── deferred.csh                  # Deferred compute shader
    ├── deferred.fsh                  # Deferred fragment shader
    ├── deferred.vsh                  # Deferred vertex shader
    ├── deferred1.fsh                 # Deferred pass 1 fragment
    ├── deferred1.vsh                 # Deferred pass 1 vertex
    ├── final.csh                     # Final compute shader
    ├── final.fsh                     # Final fragment shader
    ├── final.vsh                     # Final vertex shader
    ├── prepare.csh                   # Prepare compute shader
    ├── prepare.fsh                   # Prepare fragment shader
    ├── prepare.vsh                   # Prepare vertex shader
    ├── prepare1.fsh                  # Prepare pass 1 fragment
    ├── prepare1.vsh                  # Prepare pass 1 vertex
    ├── shadow.fsh                    # Shadow fragment shader
    ├── shadow.vsh                    # Shadow vertex shader
    ├── shadowcomp.csh                # Shadow compute shader
    ├── shadowcomp.fsh                # Shadow composite fragment
    ├── shadowcomp.vsh                # Shadow composite vertex
    ├── shadowcomp1.fsh               # Shadow composite pass 1 fragment
    ├── shadowcomp1.vsh               # Shadow composite pass 1 vertex
    ├── gbuffers_armor_glint.fsh      # Enchantment glint fragment
    ├── gbuffers_armor_glint.vsh      # Enchantment glint vertex
    ├── gbuffers_basic.fsh            # Basic geometry fragment
    ├── gbuffers_basic.vsh            # Basic geometry vertex
    ├── gbuffers_beaconbeam.fsh       # Beacon beam fragment
    ├── gbuffers_beaconbeam.vsh       # Beacon beam vertex
    ├── gbuffers_block.fsh            # Block entities fragment
    ├── gbuffers_block.vsh            # Block entities vertex
    ├── gbuffers_clouds.fsh           # Clouds fragment
    ├── gbuffers_clouds.vsh           # Clouds vertex
    ├── gbuffers_damagedblock.fsh     # Block break animation fragment
    ├── gbuffers_damagedblock.vsh     # Block break animation vertex
    ├── gbuffers_entities.fsh         # Entities fragment
    ├── gbuffers_entities.vsh         # Entities vertex
    ├── gbuffers_entities_glowing.fsh # Glowing entities fragment
    ├── gbuffers_entities_glowing.vsh # Glowing entities vertex
    ├── gbuffers_hand.fsh             # Player hand fragment
    ├── gbuffers_hand.vsh             # Player hand vertex
    ├── gbuffers_hand_water.fsh       # Hand in water fragment
    ├── gbuffers_hand_water.vsh       # Hand in water vertex
    ├── gbuffers_line.fsh             # Line rendering fragment
    ├── gbuffers_line.vsh             # Line rendering vertex
    ├── gbuffers_skybasic.fsh         # Sky dome fragment
    ├── gbuffers_skybasic.vsh         # Sky dome vertex
    ├── gbuffers_skytextured.fsh      # Sun/moon fragment
    ├── gbuffers_skytextured.vsh      # Sun/moon vertex
    ├── gbuffers_spidereyes.fsh       # Spider eyes fragment
    ├── gbuffers_spidereyes.vsh       # Spider eyes vertex
    ├── gbuffers_terrain.fsh          # Terrain blocks fragment
    ├── gbuffers_terrain.vsh          # Terrain blocks vertex
    ├── gbuffers_textured.fsh         # Textured surfaces fragment
    ├── gbuffers_textured.vsh         # Textured surfaces vertex
    ├── gbuffers_textured_lit.fsh     # Lit textured surfaces fragment
    ├── gbuffers_textured_lit.vsh     # Lit textured surfaces vertex
    ├── gbuffers_water.fsh            # Water surfaces fragment
    ├── gbuffers_water.vsh            # Water surfaces vertex
    ├── gbuffers_weather.fsh          # Rain/snow fragment
    ├── gbuffers_weather.vsh          # Rain/snow vertex
    ├── grass.gsh                     # Grass geometry shader
    ├── leaves.gsh                    # Leaves geometry shader
    ├── particles.gsh                 # Particle geometry shader
    ├── terrain.gsh                   # Terrain geometry shader
    ├── lang/
    │   └── en_us.lang                # English translations
    ├── lib/
    │   ├── common.inc                # Common functions library
    │   └── const.inc                 # Constants library
    ├── world-1/
    │   └── README.md                 # Nether dimension shaders
    └── world1/
        └── README.md                 # End dimension shaders
```

### Shader Programs Reference

#### GBuffers Programs (22 programs)

| Program                       | Purpose                  |
| ----------------------------- | ------------------------ |
| `gbuffers_basic`            | Basic geometry rendering |
| `gbuffers_textured`         | Textured surfaces        |
| `gbuffers_textured_lit`     | Lit textured surfaces    |
| `gbuffers_skybasic`         | Sky dome and stars       |
| `gbuffers_skytextured`      | Sun and moon             |
| `gbuffers_clouds`           | Cloud rendering          |
| `gbuffers_terrain`          | Solid terrain blocks     |
| `gbuffers_block`            | Block entities           |
| `gbuffers_entities`         | Mobs and players         |
| `gbuffers_entities_glowing` | Glowing entities         |
| `gbuffers_armor_glint`      | Enchantment glint        |
| `gbuffers_spidereyes`       | Spider eyes effect       |
| `gbuffers_hand`             | Player hand              |
| `gbuffers_hand_water`       | Hand in water            |
| `gbuffers_water`            | Water surfaces           |
| `gbuffers_beaconbeam`       | Beacon light beams       |
| `gbuffers_damagedblock`     | Block break animation    |
| `gbuffers_line`             | Line rendering           |
| `gbuffers_weather`          | Rain and snow            |

#### Rendering Pipeline

| Stage               | Programs                        | Purpose                        |
| ------------------- | ------------------------------- | ------------------------------ |
| **Shadow**    | shadow, shadowcomp, shadowcomp1 | Shadow map generation          |
| **Prepare**   | prepare, prepare1               | G-buffer preparation           |
| **Deferred**  | deferred, deferred1             | Deferred lighting calculations |
| **Composite** | composite, composite1-3         | Post-processing effects        |
| **Final**     | final                           | Screen output composition      |

### Configuration Files

| File                                            | Purpose                                               |
| ----------------------------------------------- | ----------------------------------------------------- |
| [`shaders.properties`](shaders.properties)       | Main shader configuration (buffers, shadows, quality) |
| [`block.properties`](shaders/block.properties)   | Block ID to shader mappings                           |
| [`entity.properties`](shaders/entity.properties) | Entity ID to shader mappings                          |
| [`item.properties`](shaders/item.properties)     | Item ID to shader mappings                            |
| [`en_us.lang`](shaders/lang/en_us.lang)          | English UI translations                               |

## Development

### Building the Shader Pack

```bash
# Create a zip of the shader pack
zip -r Chroma_v1.0.zip mcmeta.json shaders.properties shaders/
```

### Platform Detection

The shader pack supports both platforms through compile-time detection:

```glsl
#ifdef IS_IRIS
    // Iris-specific code
#else
    // OptiFine code
#endif
```

### Key Configuration Areas

#### Shadow Settings ([`shaders.properties:169-188`](shaders.properties#L169))

```properties
shadowMapResolution=1024
shadowDistance=160.0
shadowBias=0.00085
```

#### Buffer Formats ([`shaders.properties:192-199`](shaders.properties#L192))

```properties
colortex4Format=RGBA32F
colortex5Format=RGB32F
```

### Customization Guide

1. **Modify fog density**: Edit the fog calculation in [`composite.fsh`](shaders/composite.fsh)
2. **Adjust shadow quality**: Change `shadowMapResolution` in [`shaders.properties`](shaders.properties)
3. **Add new post-processing**: Create additional composite passes
4. **Custom colors**: Modify fog color modes in the fragment shaders

### Debug Options

Enable debug view in shader options to see:

- Depth Buffer
- Normal Buffer
- Shadow Map

## Resources

- [Minecraft Shader Fundamentals](Minecraft_Shader_Fundamentals.md) - Comprehensive development guide
- [OptiFine Documentation](https://optifine.readthedocs.io/) - Official OptiFine shader docs
- [Iris GitHub](https://github.com/IrisShaders/Iris) - Iris source code and issues
- [Iris Website](https://irisshaders.net/) - Official Iris downloads
- [ShaderLabs Wiki](https://shaderlabs.org/wiki/Main_Page) - Community shader documentation
- [Iris ShaderDoc](https://github.com/IrisShaders/ShaderDoc) - Advanced shader features

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-effect`)
3. Commit your changes (`git commit -m 'Add amazing effect'`)
4. Push to the branch (`git push origin feature/amazing-effect`)
5. Open a Pull Request

## Credits & License

- Based on OptiFine and Iris shader specifications
- Inspired by community shader packs
- Documentation references: [OptiFine](https://optifine.net/), [Iris](https://irisshaders.net/), [ShaderLabs](https://shaderlabs.org/)

This shader pack is released under the MIT License. Feel free to use, modify, and distribute.

<p align="center">
  <i>Made for the Minecraft shader community</i>
</p>
