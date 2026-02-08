# Minecraft Shader Creation Fundamentals

## Table of Contents
1. [What Shaders Are in Minecraft and Their Purpose](#what-shaders-are-in-minecraft-and-their-purpose)
2. [Types of Shaders](#types-of-shaders)
3. [Shader Pipeline and Rendering Process](#shader-pipeline-and-rendering-process)
4. [Key Concepts](#key-concepts)
5. [Basic Shader Structure and Syntax](#basic-shader-structure-and-syntax)

---

## What Shaders Are in Minecraft and Their Purpose

### Definition
Shaders in Minecraft are small programs that run on the GPU (Graphics Processing Unit) to control how the game renders visual elements. They are written in GLSL (OpenGL Shading Language), a C-like language specifically designed for graphics programming.

### Purpose
Shaders serve several critical functions in Minecraft:

1. **Visual Enhancement**: Transform the game's appearance by adding realistic lighting, shadows, reflections, and other visual effects
2. **Performance Optimization**: Offload rendering calculations from the CPU to the GPU
3. **Customization**: Allow players and modders to create unique visual styles and effects
4. **Atmosphere Enhancement**: Create immersive environments with fog, weather effects, and lighting variations

### Shader Systems in Minecraft

There are three main shader systems available for Minecraft:

1. **Vanilla Shaders**: Built into Minecraft's resource pack system, limited in scope but don't require mods
2. **OptiFine Shaders**: The most popular shader system, extensive features and effects
3. **Iris Shaders**: Modern alternative to OptiFine with enhanced features and better performance

---

## Types of Shaders

### Vertex Shaders (`.vsh`)
**Purpose**: Process individual vertices in 3D space
**Key Functions**:
- Transform vertex positions from model space to screen space
- Calculate vertex lighting and color values
- Modify vertex properties like normal vectors
- Pass data to fragment shaders via `varying` variables

**Characteristics**:
- Process each vertex individually
- Cannot create or destroy vertices
- Essential for positioning geometry correctly
- Handle basic transformations and lighting calculations

### Fragment Shaders (`.fsh`)
**Purpose**: Calculate the color of individual pixels (fragments)
**Key Functions**:
- Determine final pixel colors based on lighting, textures, and materials
- Apply post-processing effects
- Handle transparency and blending
- Implement complex visual effects like reflections and refractions

**Characteristics**:
- Process each pixel that makes up a triangle
- Most commonly used shader type
- Can access textures and lighting information
- Responsible for final visual output

### Geometry Shaders (`.gsh`)
**Purpose**: Process entire primitives (triangles) and can modify geometry
**Key Functions**:
- Add detail to geometry (e.g., grass blades, tree leaves)
- Create particle effects
- Implement tessellation-like effects
- Transform geometry between vertex and fragment stages

**Characteristics**:
- Process 3 vertices at a time (forming a triangle)
- Can create new vertices and primitives
- More complex and computationally expensive
- Less commonly used in basic shader packs

### Compute Shaders (`.csh`)
**Purpose**: General-purpose GPU computing
**Key Functions**:
- Perform complex calculations independent of rendering pipeline
- Process large amounts of data in parallel
- Implement advanced effects like physics simulations
- Generate procedural content

**Characteristics**:
- Not tied to specific rendering stages
- Can read/write directly to memory buffers
- Most flexible but also most complex
- Available in newer shader systems (Iris/OptiFine 1.16.5+)

---

## Shader Pipeline and Rendering Process

### Minecraft's Rendering Pipeline

The OptiFine/Iris rendering pipeline follows this sequence:

#### 1. Setup Phase
- `setupsetup<1-99>`: Compute shaders for initialization (Iris only)

#### 2. Shadow Map Generation
- `shadow`: Renders scene from sun's perspective to create depth map
- `shadowcompshadowcomp<1-99>`: Composite operations for shadow map

#### 3. G-Buffer Phase
The G-buffer (Geometry Buffer) renders different elements of the world:

- `gbuffers_basic`: Basic geometry rendering
- `gbuffers_line`: Block selection, fishing lines
- `gbuffers_textured`: Particles and basic textures
- `gbuffers_textured_lit`: Lit particles and emissive elements
- `gbuffers_skybasic`: Sky, horizon, stars, void
- `gbuffers_skytextured`: Sun and moon
- `gbuffers_clouds`: Cloud rendering
- `gbuffers_terrain`: Opaque blocks and terrain
- `gbuffers_damagedblock`: Damage overlay
- `gbuffers_block`: Tile entities (chests, banners)
- `gbuffers_entities`: Entities (mobs, animals, players)
- `gbuffers_entities_glowing`: Glowing entities with spectral effects
- `gbuffers_armor_glint`: Armor enchantment effects
- `gbuffers_spidereyes`: Spider eyes, enderman eyes
- `gbuffers_hand`: Player hand and items
- `gbuffers_weather`: Rain and snow effects

#### 4. Deferred Phase
- `deferreddeferred<1-99>`: Full-screen passes after opaque rendering

#### 5. Translucent Phase
- `gbuffers_water`: Water and translucent blocks
- `gbuffers_hand_water`: Translucent items in hand

#### 6. Composite Phase
- `compositecomposite<1-99>`: Post-processing effects applied to entire scene
- `final`: Final pass, unaffected by render scale

### Framebuffer System
Framebuffers store intermediate render data:

#### Available Buffers
- `colortex0-colortex7`: Color buffers (RGBA format)
- `depthtex`: Depth buffer
- `shadowcolor`: Shadow color buffer

#### Buffer Formats
- **8-bit**: RGBA8, RGB8, RG8, R8
- **16-bit**: RGBA16F, RGB16F, RG16F, R16F
- **32-bit**: RGBA32F, RGB32F, RG32F, R32F
- **Special**: R11F_G11F_B10F (fast floating-point format)

#### Data Transfer
- `varying` variables (GLSL 1.2) or `in/out` variables (GLSL 1.3+) pass data between shader stages
- Data is interpolated across triangle surfaces
- Framebuffers allow data sharing between different rendering passes

---

## Key Concepts

### Lighting Systems

#### Minecraft's Lighting Model
- **Block Light**: Light from sources like torches, furnaces
- **Sky Light**: Light from the sun and moon
- **Light Levels**: Range from 0 (dark) to 15 (brightest)
- **Light Propagation**: Light spreads through air and transparent blocks

#### Advanced Lighting Techniques
- **Diffuse Lighting**: Basic surface lighting based on angle to light source
- **Specular Lighting**: Highlights from reflective surfaces
- **Ambient Occlusion**: Shadows in crevices and corners
- **Emissive Materials**: Blocks that emit light (glowstone, lava)

### Lighting Models

Several lighting models are commonly used in shader development:

#### Lambertian (Diffuse) Reflection
The simplest lighting model that calculates light reflection based on the angle between the surface normal and light direction. It's used for matte surfaces.

#### Phong Reflection Model
Developed by Bui Tuong Phong in 1975, this model combines ambient, diffuse, and specular reflection to create more realistic lighting effects. It's particularly effective for shiny surfaces.

The Phong reflection model calculates the total reflected light as the sum of three components:

**Ambient Component** (`kₐiₐ`):
- Represents the small amount of light scattered throughout the scene
- Provides base illumination to prevent completely dark areas
- `kₐ` is the ambient reflection constant (material property)
- `iₐ` is the ambient light intensity

**Diffuse Component** (`kₐ(L̂ₘ ⋅ N̂)iₘ,ₐ`):
- Models light scattering from rough surfaces
- Depends on the angle between the light direction (`L̂ₘ`) and surface normal (`N̂`)
- `kₐ` is the diffuse reflection constant (material property)
- `iₘ,ₐ` is the diffuse light intensity from light source m
- Uses Lambert's cosine law: intensity ∝ cos(θ) where θ is the angle between vectors

**Specular Component** (`kₛ(R̂ₘ ⋅ V̂)ᵅiₘ,ₛ`):
- Models mirror-like reflections from shiny surfaces
- Depends on the angle between the reflection direction (`R̂ₘ`) and view direction (`V̂`)
- `kₛ` is the specular reflection constant (material property)
- `iₘ,ₛ` is the specular light intensity from light source m
- `α` is the shininess exponent (higher values create smaller, sharper highlights)
- The reflection direction is calculated as: `R̂ₘ = 2(L̂ₘ ⋅ N̂)N̂ - L̂ₘ`

The complete Phong equation is:
```
Iₚ = kₐiₐ + Σₘ [kₐ(L̂ₘ ⋅ N̂)iₘ,ₐ + kₛ(R̂ₘ ⋅ V̂)ᵅiₘ,ₛ]
```

Where:
- `Iₚ` is the final illumination at point p
- `Σₘ` sums contributions from all light sources
- All vectors are normalized (unit length)

The model is typically implemented separately for RGB color channels, allowing different reflection constants for each color.

#### Blinn-Phong Reflection Model
An optimized variation of the Phong model that uses the half-angle vector between the light and view directions, making it more computationally efficient.

### BRDF (Bidirectional Reflectance Distribution Function)

A BRDF models how light reflects off a surface, providing a more physically accurate approach to lighting than traditional models. Here's an example implementation:

```glsl
vec3 brdf(vec3 lightDir, vec3 viewDir, float roughness, vec3 normal, vec3 albedo, float metallic, vec3 reflectance) {
    
    float alpha = pow(roughness,2);

    vec3 H = normalize(lightDir + viewDir);
    
    //dot products
    float NdotV = clamp(dot(normal, viewDir), 0.001,1.0);
    float NdotL = clamp(dot(normal, lightDir), 0.001,1.0);
    float NdotH = clamp(dot(normal,H), 0.001,1.0);
    float VdotH = clamp(dot(viewDir, H), 0.001,1.0);

    // Fresnel
    vec3 F0 = reflectance;
    vec3 fresnelReflectance = F0 + (1.0 - F0) * pow(1.0 - VdotH, 5.0); //Schlick's Approximation

    //phong diffuse
    vec3 rhoD = albedo;
    rhoD *= (vec3(1.0)- fresnelReflectance); //energy conservation - light that doesn't reflect adds to diffuse

    //rhoD *= (1-metallic); //diffuse is 0 for metals

    // Geometric attenuation
    float k = alpha/2;
    float geometry = (NdotL / (NdotL*(1-k)+k)) * (NdotV / ((NdotV*(1-k)+k)));

    // Distribution of Microfacets
    float lowerTerm = pow(NdotH,2) * (pow(alpha,2) - 1.0) + 1.0;
    float normalDistributionFunctionGGX = pow(alpha,2) / (3.14159 * pow(lowerTerm,2));

    vec3 phongDiffuse = rhoD; //
    vec3 cookTorrance = (fresnelReflectance*normalDistributionFunctionGGX*geometry)/(4*NdotL*NdotV);
    
    vec3 BRDF = (phongDiffuse+cookTorrance)*NdotL;
   
    vec3 diffFunction = BRDF;
    
    return BRDF;
}
```

This BRDF implementation combines several advanced lighting concepts:

1. **Fresnel Reflection**: Models how light reflection varies based on viewing angle
2. **Energy Conservation**: Ensures light that isn't reflected contributes to diffuse lighting
3. **Geometric Attenuation**: Models microfacet shadowing effects
4. **GGX Normal Distribution**: Models the distribution of microfacets on the surface

This approach provides more realistic lighting than traditional Phong models, especially for metallic surfaces and complex material interactions.

### Shadow Systems

#### Shadow Mapping
- Two-pass rendering: First from sun's perspective, then from player's perspective
- Depth comparison determines if fragments are in shadow
- Shadow map stores distance information from light source

#### Shadow Features
- **Shadow Bias**: Prevents shadow acne and peter panning artifacts
- **Shadow Distortion**: Improves shadow resolution near player
- **Colored Shadows**: Shadows from translucent blocks (stained glass)
- **Soft Shadows**: Blurred shadow edges for more realistic appearance

### Post-Processing Effects

#### Common Effects
- **Color Grading**: Adjusting color balance and saturation
- **Bloom**: Glowing effect from bright areas
- **Depth of Field**: Blurring distant objects
- **Motion Blur**: Blurring moving objects
- **Lens Effects**: Vignettes, lens flares, chromatic aberration
- **Tonemapping**: Converting HDR colors to display range

#### Implementation Methods
- **Composite Shaders**: Full-screen effects applied after main rendering
- **Deferred Shaders**: Effects applied during specific rendering phases
- **Screen Space Techniques**: Effects calculated based on screen-space data

### Coordinate Spaces

#### Common Coordinate Systems
- **Model Space**: Local coordinates of individual objects
- **World Space**: Global coordinates of the Minecraft world
- **View Space**: Coordinates relative to the camera
- **Clip Space: Normalized device coordinates after projection
- **Screen Space**: Final pixel coordinates on the display

#### Coordinate Transformations
- **Model Matrix**: Transforms from model to world space
- **View Matrix**: Transforms from world to view space
- **Projection Matrix**: Transforms from view to clip space
- **Model-View-Projection Matrix**: Combined transformation matrix

---

## Basic Shader Structure and Syntax

### GLSL Basics

#### Shader Structure
```glsl
#version version_number
in type in_variable_name;
out type out_variable_name;
uniform type uniform_name;

void main()
{
    // Processing logic
    out_variable_name = processed_value;
}
```

#### Version Declarations
- `#version 120`: Minecraft 1.16 and earlier
- `#version 150`: Modern baseline with good compatibility
- `#version 330`: Recommended for modern hardware
- `#version 410`: Maximum for macOS 1.17+

### Data Types

#### Basic Types
- `int`: Integer values
- `float`: Floating-point numbers
- `bool`: Boolean values (true/false)
- `sampler2D`: Texture samplers

#### Vector Types
- `vec2`, `vec3`, `vec4`: 2D, 3D, 4D float vectors
- `bvec2`, `bvec3`, `bvec4`: Boolean vectors
- `ivec2`, `ivec3`, `ivec4`: Integer vectors
- `uvec2`, `uvec3`, `uvec4`: Unsigned integer vectors

#### Matrix Types
- `mat2`, `mat3`, `mat4`: 2x2, 3x3, 4x4 matrices
- `mat2x3`, `mat3x4`, etc.: Non-square matrices

### Variable Qualifiers

#### Input/Output
- `in`: Input variable from previous stage
- `out`: Output variable to next stage
- `inout`: Input and output variable

#### Storage Qualifiers
- `uniform`: Global variables set from CPU
- `attribute` (GLSL 1.2): Vertex input data
- `varying` (GLSL 1.2): Interpolated data between stages
- `const`: Constant value that cannot be modified

#### Interpolation Qualifiers
- `flat`: No interpolation (discrete values)
- `smooth`: Perspective-correct interpolation (default)
- `noperspective`: Linear interpolation

### Built-in Variables

#### Vertex Shader Variables
- `gl_Position`: Final vertex position
- `gl_VertexID`: Current vertex index
- `gl_ModelViewMatrix`: Model-view matrix
- `gl_ProjectionMatrix`: Projection matrix

#### Fragment Shader Variables
- `gl_FragColor`: Final fragment color (GLSL 1.2)
- `gl_FragCoord`: Fragment screen coordinates
- `gl_FragDepth`: Fragment depth value

### Common Functions

#### Mathematical Functions
- `sin()`, `cos()`, `tan()`: Trigonometric functions
- `pow()`, `sqrt()`, `exp()`: Power and exponential functions
- `mix()`: Linear interpolation
- `clamp()`: Clamp value to range
- `step()`, `smoothstep()`: Step functions

#### Texture Functions
- `texture()`, `texture2D()`: Sample texture
- `texelFetch()`: Get exact texel value
- `textureLod()`: Sample with specific level of detail

### Shader File Structure

#### Basic Shader Pack Organization
```
shaderpack/
├── shaders/
│   ├── vertex/
│   │   ├── gbuffers_terrain.vsh
│   │   └── gbuffers_entities.vsh
│   ├── fragment/
│   │   ├── gbuffers_terrain.fsh
│   │   └── gbuffers_entities.fsh
│   ├── composite/
│   │   ├── composite1.fsh
│   │   └── final.fsh
│   └── geometry/
│       └── grass.gsh
├── assets/
│   └── minecraft/
│       └── textures/
└── mcmeta.json
```

#### Shader Program Naming
- `gbuffers_*`: G-buffer rendering programs
- `composite<N>`: Composite passes with number
- `final`: Final composite pass
- `shadow`: Shadow mapping program
- `deferred<N>`: Deferred rendering passes

### Uniform Variables

#### Common Uniforms in Minecraft Shaders
- `time`: Current time in seconds
- `frameTime`: Time since last frame
- `viewMatrix`: Current view matrix
- `projectionMatrix`: Current projection matrix
- `texture`: Texture sampler
- `lightmap`: Lightmap texture
- `shadowMap`: Shadow depth map

#### Setting Uniforms
```glsl
// Declaration
uniform vec4 color;
uniform float time;

// Usage
vec4 finalColor = vec4(1.0, 0.5, 0.2, 1.0) * color;
float pulse = sin(time) * 0.5 + 0.5;
```

### Example Shader Templates

#### Simple Vertex Shader
```glsl
#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aColor;

out vec3 vertexColor;

uniform mat4 modelViewProjection;

void main()
{
    gl_Position = modelViewProjection * vec4(aPos, 1.0);
    vertexColor = aColor;
}
```

#### Simple Fragment Shader
```glsl
#version 330 core
in vec3 vertexColor;
out vec4 FragColor;

uniform sampler2D texture;
uniform float time;

void main()
{
    vec4 texColor = texture2D(texture, gl_TexCoord[0].xy);
    vec3 finalColor = vertexColor * texColor.rgb;
    FragColor = vec4(finalColor, texColor.a);
}
```

---

## Iris-Specific Features and Enhancements

Iris is a modern shader mod that extends and improves upon OptiFine's shader system with several exclusive features and enhancements:

### New Shader Programs

Iris introduces additional shader programs for more granular control:

- **gbuffers_terrain_solid**: Renders solid terrain without transparency
- **gbuffers_terrain_cutout**: Renders terrain with cutouts
- **gbuffers_entities_translucent**: Renders translucent entities with blending
- **gbuffers_block_translucent**: Renders translucent block entities
- **gbuffers_particles**: Renders non-translucent particles
- **gbuffers_particles_translucent**: Renders translucent particles
- **begin**: Composite pass that runs before shadow pass
- **setup**: Compute pass for initialization

### Enhanced Custom Textures

Iris allows defining entirely custom textures without sacrificing color texture slots:

```properties
customTexture.name = <path> <type> <internalFormat> <dimensions> <pixelFormat> <pixelType>
```

### Feature Flags System

Iris provides a feature flag system for checking supported capabilities:

```properties
iris.features.required = FEATURE_FLAG_A FEATURE_FLAG_B
iris.features.optional = FEATURE_FLAG_C FEATURE_FLAG_D
```

Available flags include:
- `SEPARATE_HARDWARE_SAMPLERS`
- `PER_BUFFER_BLENDING`
- `COMPUTE_SHADERS`
- `ENTITY_TRANSLUCENT`
- `SSBO` (Shader Storage Buffer Objects)
- `CUSTOM_IMAGES`
- `HIGHER_SHADOWCOLOR`
- `REVERSED_CULLING`
- `BLOCK_EMISSION_ATTRIBUTE`

### Extended Uniforms

Iris provides additional uniforms not available in OptiFine:

```glsl
// Player and camera information
uniform bool firstPersonCamera;
uniform bool isSpectator;
uniform vec3 eyePosition;
uniform vec3 relativeEyePosition;
uniform vec3 playerLookVector;
uniform vec3 playerBodyVector;

// World information
uniform int bedrockLevel;
uniform int heightLimit;
uniform bool hasCeiling;
uniform bool hasSkylight;
uniform float ambientLight;
uniform int logicalHeightLimit;
uniform float cloudHeight;

// Player states
uniform bool is_sneaking;
uniform bool is_sprinting;
uniform bool is_hurt;
uniform bool is_invisible;
uniform bool is_burning;
uniform bool is_on_ground;

// Biome information
uniform int biome;
uniform int biome_category;
uniform int biome_precipitation;
uniform float rainfall;
uniform float temperature;

// System time
uniform ivec3 currentDate;
uniform ivec3 currentTime;
uniform ivec2 currentYearTime;

// Special effects
uniform vec4 lightningBoltPosition;
uniform float thunderStrength;
```

### Shader Properties Configuration

Iris supports additional configuration options in `shaders.properties`:

```properties
// Particle rendering order
particles.ordering = mixed|after|before

// Shadow pass control
shadow.enabled = true|false
shadowPlayer = true|false

// Compute shader concurrency
allowConcurrentCompute = true|false

// Entity rendering control
separateEntityDraws = true|false

// Dimension-specific shaders
dimension.<folderName> = <dimensionNamespace>:<dimensionPath>

// Voxelization settings
voxelizeLightBlocks = true|false
```

### Advanced Features

#### Shader Storage Buffer Objects (SSBOs)
SSBOs allow storing large amounts of data between shader invocations:

```properties
bufferObject.<index> = <byteSize> <isRelative> <scaleX> <scaleY>
```

```glsl
layout(std430, binding = index) buffer bufferName {
    vec4 someData;
    float someExtraData;
} bufferAccess;
```

#### Custom Images
Iris supports up to 8 custom full images for advanced effects:

```properties
image.cimage1 = samplerAccess format internalFormat pixelType <shouldClearOnNewFrame> <isRelative> <relativeX/absoluteX> <relativeY/absoluteY> <absoluteZ>
```

#### Color Spaces
Iris supports multiple color spaces beyond sRGB:
- DCI_P3
- Display P3
- REC2020
- Adobe RGB

### Custom Entity IDs

Iris provides hardcoded entity IDs for specific detection:
- `minecraft:entity_shadow`: Entity shadow circle
- `minecraft:entity_flame`: Fire effect on entities
- `minecraft:zombie_villager_converting`: Converting zombie villager
- `minecraft:player_cape`: Player cape
- `minecraft:elytra_with_cape`: Player cape with elytra

### Item and Armor Detection

Iris allows detecting items and armor during rendering:

```glsl
uniform int currentRenderedItemId;
uniform int trim_material; // For armor trims
```

## Conclusion

Minecraft shader programming combines artistic creativity with technical knowledge. Understanding these fundamentals provides a solid foundation for creating stunning visual effects, optimizing performance, and pushing the boundaries of what's possible in Minecraft's rendering system.

### Getting Started with Shader Development

1. **Learn GLSL Basics**: Start with resources like [The Book of Shaders](https://thebookofshaders.com/) and interactive tutorials
2. **Set Up Your Workspace**: Use an IDE like Visual Studio Code with GLSL syntax highlighting
3. **Begin with Basic Shaders**: Start by modifying existing shaders to understand the structure
4. **Use Debug Mode**: Enable debug mode in Iris (Ctrl+D) for better troubleshooting
5. **Study Existing Packs**: Learn from established shader packs to understand best practices

### Development Workflow

1. **Create Basic Structure**: Set up shader pack folder structure with `shaders/` directory
2. **Start Simple**: Begin with basic terrain shaders before moving to complex effects
3. **Test Incrementally**: Reload shaders frequently (press R) to test changes
4. **Use Properties Files**: Configure shader behavior through `shaders.properties`
5. **Leverage Iris Features**: Take advantage of Iris-specific features for advanced effects

### Key Resources

- **Iris Documentation**: [IrisShaders/ShaderDoc](https://github.com/IrisShaders/ShaderDoc)
- **GLSL Learning**: [The Book of Shaders](https://thebookofshaders.com/)
- **Interactive Tutorials**: [Fragment Foundry](https://hughsk.io/fragment-foundry/)
- **OpenGL Reference**: [LearnOpenGL](https://learnopengl.com/)

### Best Practices

1. **Performance Optimization**: Use appropriate texture formats and avoid unnecessary calculations
2. **Compatibility**: Test with different hardware and shader systems when possible
3. **Documentation**: Comment your code for future reference and sharing
4. **Version Control**: Use git to track changes and experiment safely
5. **Community**: Engage with shader development communities for support and inspiration

## Practical Shader Examples

Real shader implementations provide valuable insights into how theoretical concepts are applied in practice. Below are examples from the shaderLABS/Base-150 shader pack, demonstrating common patterns and techniques used in Minecraft shader development.

### Basic Terrain Shader

**Vertex Shader** (`gbuffers_terrain.vsh`):
```glsl
#version 150

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 textureMatrix = mat4(1.0);
uniform vec3 chunkOffset;

in ivec2 vaUV2;        // Lightmap UV coordinates
in vec2 vaUV0;         // Texture UV coordinates
in vec3 vaPosition;    // Vertex position
in vec4 vaColor;       // Vertex color/tint

out vec2 lmcoord;      // Output to fragment shader
out vec2 texcoord;
out vec4 tint;

void main() {
    // Transform vertex position with chunk offset
    gl_Position = projectionMatrix * (modelViewMatrix * vec4(vaPosition + chunkOffset, 1.0));
    
    // Transform texture coordinates
    texcoord = (textureMatrix * vec4(vaUV0, 0.0, 1.0)).xy;
    
    // Convert lightmap coordinates (0-255 range to 0-1 range)
    lmcoord = vaUV2 * (1.0 / 256.0) + (1.0 / 32.0);
    
    // Pass color tint to fragment shader
    tint = vaColor;
}
```

**Fragment Shader** (`gbuffers_terrain.fsh`):
```glsl
#version 150
#extension GL_ARB_explicit_attrib_location : enable

uniform float alphaTestRef;    // Alpha test threshold for transparency
uniform sampler2D gtexture;    // Main texture sampler
uniform sampler2D lightmap;    // Lightmap sampler

in vec2 lmcoord;               // Lightmap coordinates from vertex shader
in vec2 texcoord;              // Texture coordinates from vertex shader
in vec4 tint;                  // Color tint from vertex shader

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 colortex0Out;

void main() {
    // Sample main texture and apply tint
    vec4 color = texture(gtexture, texcoord) * tint;
    
    // Alpha test - discard transparent pixels below threshold
    if (color.a < alphaTestRef) discard;
    
    // Apply lighting from lightmap
    color *= texture(lightmap, lmcoord);
    
    // Output final color
    colortex0Out = color;
}
```

**Key Features**:
- **Chunk Offsets**: Handles world coordinates by adding chunk offsets to vertex positions
- **Alpha Testing**: Discards transparent pixels below a threshold for optimization
- **Lightmap Integration**: Combines texture color with baked lighting information
- **Explicit Buffer Layout**: Uses `DRAWBUFFERS` directive to specify output targets

### Sky Shader Implementation

**Fragment Shader** (`gbuffers_skybasic.fsh`):
```glsl
#version 150
#extension GL_ARB_explicit_attrib_location : enable

// Uniforms for sky rendering
uniform float viewHeight;
uniform float viewWidth;
uniform mat4 gbufferModelView;
uniform mat4 gbufferProjectionInverse;
uniform vec3 fogColor;
uniform vec3 skyColor;

in vec4 starData;  // RGB = star color, A = star flag

// Fog calculation function
float fogify(float x, float w) {
    return w / (x * x + w);
}

// Calculate sky color based on view direction
vec3 calcSkyColor(vec3 viewPosNorm) {
    float upDot = dot(viewPosNorm, gbufferModelView[1].xyz);
    return mix(skyColor, fogColor, fogify(max(upDot, 0.0), 0.25));
}

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 colortex0Out;

void main() {
    vec3 color;
    
    // Check if fragment is a star
    if (starData.a > 0.5) {
        color = starData.rgb;
    } else {
        // Calculate clip space position
        vec4 clipPos = vec4(gl_FragCoord.xy / vec2(viewWidth, viewHeight) * 2.0 - 1.0, 1.0, 1.0);
        
        // Convert to view space and calculate sky color
        vec4 tmp = gbufferProjectionInverse * clipPos;
        color = calcSkyColor(normalize(tmp.xyz));
    }
    
    colortex0Out = vec4(color, 1.0);
}
```

**Key Features**:
- **Atmospheric Scattering**: Implements fog effects based on view angle
- **Star Rendering**: Handles star particles separately from sky gradient
- **Coordinate Transformations**: Converts between clip space and view space
- **Gradient Blending**: Smoothly transitions between sky and fog colors

### Composite Shader (Post-processing)

**Fragment Shader** (`composite.fsh`):
```glsl
#version 150
#extension GL_ARB_explicit_attrib_location : enable

uniform sampler2D colortex0;  // Input texture from previous rendering pass

in vec2 texcoord;             // Texture coordinates

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 colortex0Out;

void main() {
    // Sample the input texture
    vec3 color = texture(colortex0, texcoord).rgb;
    
    // Output the color (can be modified for post-processing effects)
    colortex0Out = vec4(color, 1.0);
}
```

**Key Features**:
- **Full-screen Processing**: Operates on the entire rendered scene
- **Texture Sampling**: Accesses the output from previous rendering stages
- **Simple Pass-through**: Can be extended for complex post-processing effects

### Common Patterns in Real Shaders

1. **Uniform Management**:
   - Standard uniforms for matrices, textures, and time
   - Custom uniforms for specific rendering effects
   - Conditional compilation based on available features

2. **Coordinate Space Transformations**:
   - Model → World → View → Clip → Screen space conversions
   - Proper handling of projection and view matrices
   - Normalization of vectors for lighting calculations

3. **Alpha Handling**:
   - Alpha testing for transparency optimization
   - Alpha blending for translucent materials
   - Proper depth sorting for transparent objects

4. **Texture Integration**:
   - Multi-texture sampling for complex materials
   - UV coordinate transformations
   - Mipmap and LOD handling

5. **Performance Optimization**:
   - Early fragment discard for transparent pixels
   - Minimal branching in fragment shaders
   - Efficient mathematical operations

### Shader Development Best Practices from shaderLABS/Base-150

1. **Version Compatibility**:
   - Use `#version 150` for broad compatibility
   - Enable GLSL extensions explicitly
   - Test on different hardware configurations

2. **Buffer Management**:
   - Use explicit buffer locations with `layout(location = X)`
   - Specify `DRAWBUFFERS` for multi-target rendering
   - Understand the G-buffer structure and limitations

3. **Code Organization**:
   - Separate vertex and fragment shader logic
   - Use functions for complex calculations
   - Comment shader code for maintainability

4. **Error Handling**:
   - Implement alpha testing to avoid rendering transparent pixels
   - Check texture bounds and sampler validity
   - Handle edge cases in coordinate transformations

These practical examples demonstrate how theoretical shader concepts are implemented in real Minecraft shader packs. By studying these implementations, you can learn common patterns, optimization techniques, and best practices for shader development.

With this foundation and understanding of both traditional shader development and Iris-specific enhancements, you can begin exploring advanced topics like physically-based rendering, volumetric effects, and custom shader development that push the boundaries of Minecraft's visual capabilities.

---

## OptiFine Shader Documentation

### OptiFine Shader Pipeline Overview

OptiFine implements a deferred rendering pipeline that processes visual elements in distinct stages:

#### Pipeline Structure
1. **G-Buffer Stage**: Renders scene data to textures (gbuffer)
2. **Shadow Stage**: Renders shadows from light's perspective
3. **Composite Stage**: Applies post-processing effects
4. **Final Stage**: Renders directly to screen

#### Key Programs
- **Shadow Programs**: `shadow`, `shadow_solid`, `shadow_cutout`
- **Shadow Composite**: `shadowcomp`, `shadowcomp1-99`
- **Prepare Programs**: `prepare`, `prepare1-99`
- **G-Buffer Programs**: Various programs for different rendering types
- **Deferred Programs**: `deferred`, `deferred1-99`
- **Composite Programs**: `composite`, `composite1-99`
- **Final Program**: `final`

### Shader File Types and Naming

#### File Extensions
- `.vsh` - Vertex shader
- `.fsh` - Fragment shader
- `.gsh` - Geometry shader
- `.csh` - Compute shader

#### Shader Program Naming Convention
Shader files are named according to their program type:
- `gbuffers_terrain` - Terrain rendering
- `gbuffers_entities` - Entity rendering
- `gbuffers_skybasic` - Sky rendering
- `gbuffers_water` - Water rendering
- `composite` - Post-processing
- `final` - Final output

### Color Attachments and Buffer System

#### Available Buffers
OptiFine provides up to 16 color attachments:
- `colortex0-15` - Color buffers (0-15)
- `gcolor`, `gdepth`, `gnormal`, `composite`, `gaux1-4` - Legacy names

#### Buffer Characteristics
- **gcolor** (colortex0): Cleared to fog color
- **gdepth** (colortex1): Higher precision for depth values
- **Others**: Cleared to black with 0 alpha

#### Buffer Flipping System
Buffers use a ping-pong system with "main" and "alt" buffers:
- G-buffer programs read from "main" and write to "main"
- Deferred/composite programs read from "main" and write to "alt"
- After rendering, buffers are flipped for next program

#### Output Configuration
Fragment shaders specify output buffers with:
```glsl
/* DRAWBUFFERS:0257 */  // Outputs to buffers 0, 2, 5, 7
/* RENDERTARGETS: 0,2,11,15 */  // Modern syntax (GLSL 130+)
```

### Uniform Variables

#### Core Uniforms
```glsl
// Time and world information
uniform int worldTime;          // World ticks (0-23999)
uniform int worldDay;           // Day count
uniform int moonPhase;          // 0-7
uniform float frameTime;         // Last frame time (seconds)
uniform float frameTimeCounter;  // Run time (seconds)

// Camera and view
uniform vec3 cameraPosition;     // Camera position in world space
uniform mat4 gbufferModelView;   // Model-view matrix
uniform mat4 gbufferProjection;  // Projection matrix
uniform float near;             // Near plane distance
uniform float far;              // Far plane distance

// Lighting
uniform vec3 sunPosition;       // Sun position in eye space
uniform vec3 moonPosition;      // Moon position in eye space
uniform vec3 shadowLightPosition; // Shadow light position
uniform vec3 fogColor;          // Fog color
uniform vec3 skyColor;          // Sky color
uniform float rainStrength;     // Rain intensity (0.0-1.0)

// Rendering properties
uniform float aspectRatio;      // View width / height
uniform int fogMode;           // GL_LINEAR, GL_EXP, GL_EXP2
uniform float fogStart;         // Fog start distance
uniform float fogEnd;           // Fog end distance
uniform int isEyeInWater;       // 1=water, 2=lava, 3=powder snow
```

#### G-Buffer Specific Uniforms
```glsl
// Texture samplers
uniform sampler2D gtexture;     // Main texture (0)
uniform sampler2D lightmap;     // Lightmap (1)
uniform sampler2D normals;      // Normal map (2)
uniform sampler2D specular;     // Specular map (3)
uniform sampler2D shadowtex0;  // Shadow map (4)
uniform sampler2D shadowtex1;  // Shadow map (5)
uniform sampler2D depthtex0;    // Depth buffer (6)
uniform sampler2D gaux1;        // Custom buffer (7)
uniform sampler2D gaux2;        // Custom buffer (8)
uniform sampler2D gaux3;        // Custom buffer (9)
uniform sampler2D gaux4;        // Custom buffer (10)
uniform sampler2D noisetex;     // Noise texture (15)
```

### Vertex Shader Attributes

#### Available Attributes
```glsl
in vec3 vaPosition;     // Vertex position (1.17+)
in vec4 vaColor;        // Vertex color/tint (1.17+)
in vec2 vaUV0;          // Texture coordinates (1.17+)
in ivec2 vaUV1;         // Overlay coordinates (1.17+)
in ivec2 vaUV2;         // Lightmap coordinates (1.17+)
in vec3 vaNormal;       // Normal vector (1.17+)
in vec3 mc_Entity;      // Block/entity ID and render type
in vec2 mc_midTexCoord;  // Sprite middle UV coordinates
in vec4 at_tangent;      // Tangent vector and handedness
in vec3 at_velocity;     // Vertex offset to previous frame
in vec3 at_midBlock;     // Offset to block center
```

### Shader Configuration

#### Configuration Properties
Shader behavior can be configured through fragment shader directives:

```glsl
// Shadow settings
/* SHADOWRES:1024 */              // Shadow map resolution
const int shadowMapResolution = 1024;
/* SHADOWFOV:90.0 */              // Shadow field of view
const float shadowMapFov = 90.0;
/* SHADOWHPL:160.0 */             // Shadow render distance
const float shadowDistance = 160.0f;

// Buffer formats
/* GAUX4FORMAT:RGBA32F */          // Custom buffer format
const int gaux4Format = RGBA32F;

// Draw buffer configuration
/* DRAWBUFFERS:0257 */            // Output to buffers 0,2,5,7
/* RENDERTARGETS: 0,2,11,15 */    // Modern syntax

// Performance settings
const bool generateShadowMipmap = true;     // Shadow mipmaps
const bool shadowHardwareFiltering = true;  // Hardware filtering
const float wetnessHalflife = 600.0f;        // Wetness smoothing
```

#### Buffer Format Options
- **8-bit**: R8, RG8, RGB8, RGBA8
- **16-bit**: R16F, RG16F, RGB16F, RGBA16F
- **32-bit**: R32F, RG32F, RGB32F, RGBA32F
- **Special**: R11F_G11F_B10F (fast floating-point)

### Block, Item, and Entity Mapping

#### Block Properties
Create `shaders/block.properties` to customize block rendering:
```properties
# Block ID mapping
block.31=red_flower yellow_flower reeds

# Render layer assignment
layer.solid=stone dirt wood
layer.cutout=leaves glass
layer.translucent=water stained_glass
```

#### Item Properties
Create `shaders/item.properties` for item customization:
```properties
# Item ID mapping
item.5000=diamond_sword iron_pickaxe
```

#### Entity Properties
Create `shaders/entity.properties` for entity customization:
```properties
# Entity ID mapping
entity.1000=sheep cow pig
```

### Standard Macros and Preprocessor

#### Version and System Macros
```glsl
// Minecraft version
#define MC_VERSION 12004  // 1.20.4

// OpenGL version
#define MC_GL_VERSION 320  // OpenGL 3.2
#define MC_GLSL_VERSION 150  // GLSL 1.50

// Operating system
#define MC_OS_WINDOWS
#define MC_OS_LINUX
#define MC_OS_MAC

// GPU vendor
#define MC_GL_VENDOR_NVIDIA
#define MC_GL_VENDOR_AMD
#define MC_GL_VENDOR_INTEL
```

#### Feature Macros
```glsl
// Enabled features
#define MC_NORMAL_MAP        // Normal mapping enabled
#define MC_SPECULAR_MAP      // Specular mapping enabled
#define MC_FXAA_LEVEL 4      // FXAA quality level
#define MC_RENDER_QUALITY 1.0 // Render quality setting
```

#### Render Stage Constants
```glsl
// Render stage identifiers
#define MC_RENDER_STAGE_SKY 0
#define MC_RENDER_STAGE_TERRAIN_SOLID 1
#define MC_RENDER_STAGE_ENTITIES 2
#define MC_RENDER_STAGE_HAND_SOLID 3
#define MC_RENDER_STAGE_TERRAIN_TRANSLUCENT 4
```

### Compute Shaders

#### Compute Shader Setup
Compute shaders run before their corresponding rendering programs:
```glsl
#version 430
layout (local_size_x = 16, local_size_y = 16) in;

// Work group configuration
const vec2 workGroupsRender = vec2(1.0f, 1.0f);  // One per pixel
// or
const ivec3 workGroups = ivec3(50, 30, 1);      // Fixed size

// Image access
layout (rgba8) uniform image2D colorimg0;  // Access to colortex0
```

#### Compute Shader Naming
Compute shaders follow the naming pattern:
- `composite.csh` - Compute shader for composite pass
- `composite_a.csh` to `composite_z.csh` - Additional compute shaders

### Image Access and Buffer Manipulation

#### Direct Buffer Access
All programs can read and write to buffers using image operations:
```glsl
// Image declaration
layout (rgba8) uniform image2D colorimg0;  // colortex0
layout (rgba8) uniform image2D colorimg1;  // colortex1
layout (rgba8) uniform image2D shadowcolorimg0;  // shadowcolor0

// Image operations
vec4 color = imageLoad(colorimg0, ivec2(gl_FragCoord.xy));
imageStore(colorimg0, ivec2(gl_FragCoord.xy), finalColor);
```

### Shader Development Best Practices

#### Performance Optimization
1. **Minimize branching** in fragment shaders
2. **Use appropriate buffer formats** for your needs
3. **Implement early discard** for transparent pixels
4. **Reuse calculations** where possible
5. **Profile performance** with different hardware

#### Compatibility Considerations
1. **Test with different OpenGL versions**
2. **Use conditional compilation** for feature detection
3. **Provide fallbacks** for advanced features
4. **Consider macOS limitations** (8 color attachments max)
5. **Test with different shader systems** (OptiFine vs Iris)

#### Debugging Techniques
1. **Use color buffers** for debugging information
2. **Implement debug visualization** for complex effects
3. **Log shader compilation errors**
4. **Test incrementally** when adding new features
5. **Use the `/reloadShaders` command** to test changes

### Shader Reloading and Development

#### Reloading Shaders
- Press `F3+R` to reload shaders
- Use the command `/reloadShaders` in chat
- Changes take effect immediately without restarting the game

#### Development Workflow
1. **Start with basic shaders** (terrain, entities)
2. **Test frequently** during development
3. **Use properties files** for configuration
4. **Document your code** for maintainability
5. **Version control** your shader pack

This OptiFine-specific documentation complements the general shader fundamentals, providing detailed information about OptiFine's implementation, configuration options, and best practices for shader development within the OptiFine ecosystem.

---

## OptiFine Shader Development Checklist

This comprehensive checklist serves as a reference for all possible OptiFine shader files, configurations, and features. Use this when developing or auditing a shader pack.

### Shader Programs Checklist

#### Shadow Programs
| Status | File | Description |
|--------|------|-------------|
| [ ] | `shadow.vsh/fsh` | Main shadow pass - renders scene from sun's perspective |
| [ ] | `shadow_solid.vsh/fsh` | Solid geometry shadows (not used, fallback to shadow) |
| [ ] | `shadow_cutout.vsh/fsh` | Cutout geometry shadows (not used, fallback to shadow) |

#### Shadow Composite Programs (0-15)
| Status | File | Description |
|--------|------|-------------|
| [ ] | `shadowcomp.vsh/fsh/csh` | Shadow composite pass 0 |
| [ ] | `shadowcomp1.vsh/fsh/csh` | Shadow composite pass 1 |
| [ ] | `shadowcomp2.vsh/fsh/csh` | Shadow composite pass 2 |
| [ ] | `shadowcomp3-15.vsh/fsh/csh` | Additional shadow composite passes |

#### Prepare Programs (0-15)
| Status | File | Description |
|--------|------|-------------|
| [ ] | `prepare.vsh/fsh/csh` | Prepare pass 0 |
| [ ] | `prepare1.vsh/fsh/csh` | Prepare pass 1 |
| [ ] | `prepare2.vsh/fsh/csh` | Prepare pass 2 |
| [ ] | `prepare3-15.vsh/fsh/csh` | Additional prepare passes |

#### GBuffers Programs
| Status | File | Description |
|--------|------|-------------|
| [ ] | `gbuffers_basic.vsh/fsh` | Leash, block selection box |
| [ ] | `gbuffers_textured.vsh/fsh` | Particles |
| [ ] | `gbuffers_textured_lit.vsh/fsh` | Lit particles, world border |
| [ ] | `gbuffers_skybasic.vsh/fsh` | Sky, horizon, stars, void |
| [ ] | `gbuffers_skytextured.vsh/fsh` | Sun, moon |
| [ ] | `gbuffers_clouds.vsh/fsh` | Clouds |
| [ ] | `gbuffers_terrain.vsh/fsh` | Solid, cutout, cutout_mip blocks |
| [ ] | `gbuffers_terrain_solid.vsh/fsh` | Solid terrain (not used, fallback to terrain) |
| [ ] | `gbuffers_terrain_cutout_mip.vsh/fsh` | Cutout with mipmaps (not used) |
| [ ] | `gbuffers_terrain_cutout.vsh/fsh` | Cutout blocks (not used) |
| [ ] | `gbuffers_damagedblock.vsh/fsh` | Damaged block overlay |
| [ ] | `gbuffers_block.vsh/fsh` | Block entities (chests, signs, etc.) |
| [ ] | `gbuffers_beaconbeam.vsh/fsh` | Beacon beam effect |
| [ ] | `gbuffers_item.vsh/fsh` | Items (not used) |
| [ ] | `gbuffers_entities.vsh/fsh` | Entities (mobs, players, items) |
| [ ] | `gbuffers_entities_glowing.vsh/fsh` | Glowing entity effect |
| [ ] | `gbuffers_armor_glint.vsh/fsh` | Enchantment glint effect |
| [ ] | `gbuffers_spidereyes.vsh/fsh` | Spider/enderman/dragon eyes |
| [ ] | `gbuffers_hand.vsh/fsh` | Hand and opaque handheld items |
| [ ] | `gbuffers_weather.vsh/fsh` | Rain, snow particles |
| [ ] | `gbuffers_water.vsh/fsh` | Translucent blocks (water, stained glass) |
| [ ] | `gbuffers_hand_water.vsh/fsh` | Translucent handheld items |

#### Deferred Programs (0-15)
| Status | File | Description |
|--------|------|-------------|
| [ ] | `deferred.vsh/fsh` | Deferred pass 0 |
| [ ] | `deferred1.vsh/fsh` | Deferred pass 1 |
| [ ] | `deferred2.vsh/fsh` | Deferred pass 2 |
| [ ] | `deferred3-15.vsh/fsh` | Additional deferred passes |

#### Composite Programs (0-15)
| Status | File | Description |
|--------|------|-------------|
| [ ] | `composite.vsh/fsh` | Composite pass 0 |
| [ ] | `composite1.vsh/fsh` | Composite pass 1 |
| [ ] | `composite2.vsh/fsh` | Composite pass 2 |
| [ ] | `composite3-15.vsh/fsh` | Additional composite passes |

#### Final Program
| Status | File | Description |
|--------|------|-------------|
| [ ] | `final.vsh/fsh` | Final output to screen (unaffected by render scale) |

### Geometry Shaders Checklist

Geometry shaders require OpenGL 3.2 or `GL_ARB_geometry_shader4` extension.

| Status | File | Description |
|--------|------|-------------|
| [ ] | `grass.gsh` | Grass geometry generation |
| [ ] | `particles.gsh` | Particle geometry manipulation |
| [ ] | `leaves.gsh` | Leaf geometry generation |
| [ ] | `terrain.gsh` | General terrain geometry |

### Compute Shaders Checklist

Compute shaders require `#version 430` or higher.

| Status | File | Description |
|--------|------|-------------|
| [ ] | `composite.csh` | Compute shader for composite pass |
| [ ] | `composite_a.csh` - `composite_z.csh` | Additional composite compute shaders |
| [ ] | `shadowcomp.csh` | Shadow composite compute |
| [ ] | `prepare.csh` | Prepare pass compute |
| [ ] | `deferred.csh` | Deferred pass compute |
| [ ] | `final.csh` | Final pass compute |

### Property Files Checklist

| Status | File | Description |
|--------|------|-------------|
| [ ] | `shaders/block.properties` | Block ID mappings and render layers |
| [ ] | `shaders/entity.properties` | Entity ID mappings |
| [ ] | `shaders/item.properties` | Item ID mappings |

#### block.properties Format
```properties
# Block ID mapping (block.\<id\>=\<names\>)
block.31=red_flower yellow_flower reeds

# Render layer assignment
layer.solid=stone dirt ore_block
layer.cutout=leaves glass pane
layer.cutout_mip=leaves2
layer.translucent=water stained_glass ice
```

#### entity.properties Format
```properties
# Entity ID mapping (entity.\<id\>=\<names\>)
entity.1000=sheep cow pig chicken
entity.1001=zombie skeleton creeper
```

#### item.properties Format
```properties
# Item ID mapping (item.\<id\>=\<names\>)
item.5000=diamond_sword iron_pickaxe
```

### shaders.properties Configuration Checklist

#### General Settings
| Status | Property | Description |
|--------|----------|-------------|
| [ ] | `clouds=fast/fancy/off` | Cloud rendering mode |
| [ ] | `oldHandLight=true/false` | Use old hand light behavior |
| [ ] | `dynamicHandLight=true/false` | Enable dynamic hand lighting |
| [ ] | `oldLighting=true/false` | Use old lighting model |
| [ ] | `renderRegions=true/false` | Enable render regions |
| [ ] | `separateEntityDraws=true/false` | Separate opaque/translucent entities |
| [ ] | `particles.ordering=mixed/after/before` | Particle render order |

#### Shadow Settings
| Status | Property | Description |
|--------|----------|-------------|
| [ ] | `shadowTerrain=true/false` | Enable terrain shadows |
| [ ] | `shadowTranslucent=true/false` | Enable translucent shadows |
| [ ] | `shadowEntities=true/false` | Enable entity shadows |
| [ ] | `shadowPlayer=true/false` | Enable player shadows |
| [ ] | `shadow.enabled=true/false` | Master shadow toggle (Iris) |

#### Back-face Rendering
| Status | Property | Description |
|--------|----------|-------------|
| [ ] | `backFace.solid=true/false` | Render solid back-faces |
| [ ] | `backFace.cutout=true/false` | Render cutout back-faces |
| [ ] | `backFace.translucent=true/false` | Render translucent back-faces |

#### Depth Settings
| Status | Property | Description |
|--------|----------|-------------|
| [ ] | `rain.depth=true/false` | Rain depth buffer |
| [ ] | `beacon.beam.depth=true/false` | Beacon beam depth |
| [ ] | `separateAo=true/false` | Separate ambient occlusion |
| [ ] | `frustum.culling=true/false` | Frustum culling |

#### Buffer Settings
| Status | Property | Description |
|--------|----------|-------------|
| [ ] | `scale.<buffer>=<value>` | Buffer scale factor |
| [ ] | `flip.<buffer>=<true/false>` | Buffer flip setting |
| [ ] | `size.<buffer>=<width> <height>` | Buffer dimensions |

#### Blend Mode Settings
| Status | Property | Description |
|--------|----------|-------------|
| [ ] | `blend.<program>=<src> <dst>` | Blend mode for program |

#### Alpha Test Settings
| Status | Property | Description |
|--------|----------|-------------|
| [ ] | `alphaTest.<program>=<value>` | Alpha test reference |

#### Custom Textures
| Status | Property | Description |
|--------|----------|-------------|
| [ ] | `texture.<name>=<path>` | Custom texture definition |
| [ ] | `customTexture.<name>=<path> <type> ...` | Iris custom texture |

#### Profiles and Screens
| Status | Property | Description |
|--------|----------|-------------|
| [ ] | `profile.<name>=<options>` | Shader profile definition |
| [ ] | `screen.<name>=<options>` | Settings screen definition |

### Buffer System Reference

#### Color Attachments Table
| Buffer | Legacy Name | Default Format | Clear Color |
|--------|-------------|----------------|-------------|
| colortex0 | gcolor | RGBA8 | Fog color |
| colortex1 | gdepth | RGBA8 | Black, 0 alpha |
| colortex2 | gnormal | RGBA8 | Black, 0 alpha |
| colortex3 | composite | RGBA8 | Black, 0 alpha |
| colortex4 | gaux1 | RGBA8 | Black, 0 alpha |
| colortex5 | gaux2 | RGBA8 | Black, 0 alpha |
| colortex6 | gaux3 | RGBA8 | Black, 0 alpha |
| colortex7 | gaux4 | RGBA8 | Black, 0 alpha |
| colortex8-15 | - | RGBA8 | Black, 0 alpha |

#### Depth Buffers
| Buffer | Description |
|--------|-------------|
| depthtex0 | Primary depth buffer |
| depthtex1 | Depth buffer without translucent objects |
| depthtex2 | Depth buffer without hand |

#### Shadow Buffers
| Buffer | Description |
|--------|-------------|
| shadowtex0 | Shadow depth map |
| shadowtex1 | Shadow depth map (colored shadows) |
| shadowcolor0 | Shadow color buffer 0 |
| shadowcolor1 | Shadow color buffer 1 |

#### Texture Formats
| Format | Bits Per Component | Use Case |
|--------|-------------------|----------|
| R8, RG8, RGB8, RGBA8 | 8-bit | Standard color |
| R16, RG16, RGB16, RGBA16 | 16-bit integer | Higher precision |
| R16F, RG16F, RGB16F, RGBA16F | 16-bit float | HDR, performance |
| R32F, RG32F, RGB32F, RGBA32F | 32-bit float | High precision |
| R11F_G11F_B10F | Mixed float | HDR optimization |
| RGB10_A2 | 10+2 bit | Display output |

#### Buffer Configuration Constants
```glsl
// Buffer format constants
const int colortex0Format = RGBA16F;
const int colortex1Format = RGB16F;
const int gdepthFormat = RGBA16F;

// Buffer clear behavior
const bool colortex0Clear = true;
const bool gaux1Clear = false;

// Mipmap generation
const bool generateShadowMipmap = true;
const bool shadowHardwareFiltering = true;
```

### Uniform Variables Reference

#### General Uniforms
| Uniform | Type | Description |
|---------|------|-------------|
| `worldTime` | int | World ticks (0-23999) |
| `worldDay` | int | Day count |
| `moonPhase` | int | Moon phase (0-7) |
| `frameTime` | float | Last frame time (seconds) |
| `frameTimeCounter` | float | Total run time (seconds) |
| `sunAngle` | float | Sun angle (0.0-1.0) |
| `shadowAngle` | float | Shadow light angle |
| `rainStrength` | float | Rain intensity (0.0-1.0) |
| `wetness` | float | Accumulated wetness |
| `aspectRatio` | float | View width / height |
| `viewWidth` | float | Viewport width |
| `viewHeight` | float | Viewport height |
| `near` | float | Near plane distance |
| `far` | float | Far plane distance |
| `isEyeInWater` | int | 0=air, 1=water, 2=lava, 3=powder snow |
| `eyeAltitude` | float | Camera altitude |
| `fogMode` | int | Fog mode (GL_LINEAR, etc.) |
| `fogStart` | float | Fog start distance |
| `fogEnd` | float | Fog end distance |
| `fogDensity` | float | Fog density |

#### Matrix Uniforms
| Uniform | Type | Description |
|---------|------|-------------|
| `gbufferModelView` | mat4 | Model-view matrix |
| `gbufferModelViewInverse` | mat4 | Inverse model-view |
| `gbufferProjection` | mat4 | Projection matrix |
| `gbufferProjectionInverse` | mat4 | Inverse projection |
| `gbufferPreviousModelView` | mat4 | Previous frame model-view |
| `gbufferPreviousProjection` | mat4 | Previous frame projection |
| `shadowModelView` | mat4 | Shadow model-view matrix |
| `shadowModelViewInverse` | mat4 | Inverse shadow model-view |
| `shadowProjection` | mat4 | Shadow projection matrix |
| `shadowProjectionInverse` | mat4 | Inverse shadow projection |

#### Position Uniforms
| Uniform | Type | Description |
|---------|------|-------------|
| `cameraPosition` | vec3 | Camera world position |
| `previousCameraPosition` | vec3 | Previous frame camera position |
| `sunPosition` | vec3 | Sun position (eye space) |
| `moonPosition` | vec3 | Moon position (eye space) |
| `shadowLightPosition` | vec3 | Active shadow light position |
| `upPosition` | vec3 | Up vector (eye space) |
| `skyColor` | vec3 | Sky color |
| `fogColor` | vec3 | Fog color |

#### Sampler Uniforms (Texture Units)
| Unit | Sampler | Description |
|------|---------|-------------|
| 0 | `gtexture` | Main terrain texture |
| 1 | `lightmap` | Lightmap texture |
| 2 | `normals` | Normal map texture |
| 3 | `specular` | Specular map texture |
| 4 | `shadowtex0` | Shadow depth map |
| 5 | `shadowtex1` | Shadow depth map (colored) |
| 6 | `depthtex0` | Primary depth buffer |
| 7 | `gaux1` | Auxiliary buffer 1 |
| 8 | `gaux2` | Auxiliary buffer 2 |
| 9 | `gaux3` | Auxiliary buffer 3 |
| 10 | `gaux4` | Auxiliary buffer 4 |
| 11 | `colortex4` | Color buffer 4 |
| 12 | `colortex5` | Color buffer 5 |
| 13 | `colortex6` | Color buffer 6 |
| 14 | `colortex7` | Color buffer 7 |
| 15 | `noisetex` | Noise texture |

#### 1.17+ Additional Uniforms
| Uniform | Type | Description |
|---------|------|-------------|
| `atlasSize` | vec2 | Texture atlas dimensions |
| `centerDepthSmooth` | float | Smoothed center depth |
| `blindness` | float | Blindness effect strength |
| `nightVision` | float | Night vision strength |
| `screenBrightness` | float | Screen brightness setting |
| `hideGUI` | bool | GUI hidden flag |

### Vertex Attributes Reference

| Attribute | Type | Description |
|-----------|------|-------------|
| `vaPosition` | vec3 | Vertex position (1.17+) |
| `vaColor` | vec4 | Vertex color/tint (1.17+) |
| `vaUV0` | vec2 | Texture coordinates (1.17+) |
| `vaUV1` | ivec2 | Overlay coordinates (1.17+) |
| `vaUV2` | ivec2 | Lightmap coordinates (1.17+) |
| `vaNormal` | vec3 | Normal vector (1.17+) |
| `mc_Entity` | vec4 | Block/entity ID (x), render type (y) |
| `mc_midTexCoord` | vec2 | Sprite middle UV coordinates |
| `at_tangent` | vec4 | Tangent vector (xyz), handedness (w) |
| `at_velocity` | vec3 | Vertex offset to previous frame |
| `at_midBlock` | vec3 | Offset to block center |

### Preprocessor Directives Reference

#### Compilation Directives
```glsl
// Version declaration
#version 120    // Minecraft 1.16 and earlier
#version 150    // Modern baseline
#version 330    // Recommended for modern hardware
#version 430    // Required for compute shaders

// Extensions
#extension GL_ARB_explicit_attrib_location : enable
#extension GL_ARB_shader_image_load_store : enable
```

#### Automatic Macros - Version
| Macro | Example | Description |
|-------|---------|-------------|
| `MC_VERSION` | 12004 | Minecraft version (1.20.4) |
| `MC_GLSL_VERSION` | 150 | GLSL version |

#### Automatic Macros - OpenGL
| Macro | Example | Description |
|-------|---------|-------------|
| `MC_GL_VERSION` | 320 | OpenGL version |
| `MC_GL_MAX_TEXTURE_SIZE` | 8192 | Max texture size |

#### Automatic Macros - Operating System
| Macro | Description |
|-------|-------------|
| `MC_OS_WINDOWS` | Running on Windows |
| `MC_OS_LINUX` | Running on Linux |
| `MC_OS_MAC` | Running on macOS |

#### Automatic Macros - GPU Vendor
| Macro | Description |
|-------|-------------|
| `MC_GL_VENDOR_NVIDIA` | NVIDIA GPU |
| `MC_GL_VENDOR_AMD` | AMD GPU |
| `MC_GL_VENDOR_INTEL` | Intel GPU |
| `MC_GL_VENDOR_MESA` | Mesa driver |

#### Automatic Macros - Features
| Macro | Description |
|-------|-------------|
| `MC_NORMAL_MAP` | Normal mapping enabled |
| `MC_SPECULAR_MAP` | Specular mapping enabled |
| `MC_FXAA_LEVEL` | FXAA quality level |
| `MC_RENDER_QUALITY` | Render quality setting |
| `MC_SHADOW_QUALITY` | Shadow quality setting |

#### Render Stage Constants
| Constant | Value | Description |
|----------|-------|-------------|
| `MC_RENDER_STAGE_SKY` | 0 | Sky rendering |
| `MC_RENDER_STAGE_TERRAIN_SOLID` | 1 | Solid terrain |
| `MC_RENDER_STAGE_TERRAIN_CUTOUT` | 2 | Cutout terrain |
| `MC_RENDER_STAGE_TERRAIN_CUTOUT_MIP` | 3 | Cutout with mipmaps |
| `MC_RENDER_STAGE_ENTITIES` | 4 | Entity rendering |
| `MC_RENDER_STAGE_BLOCK_ENTITIES` | 5 | Block entity rendering |
| `MC_RENDER_STAGE_DESTROY_PROGRESS` | 6 | Block destroy overlay |
| `MC_RENDER_STAGE_HAND_SOLID` | 7 | Solid hand rendering |
| `MC_RENDER_STAGE_HAND_TRANSLUCENT` | 8 | Translucent hand |
| `MC_RENDER_STAGE_TERRAIN_TRANSLUCENT` | 9 | Translucent terrain |
| `MC_RENDER_STAGE_CLOUDS` | 10 | Cloud rendering |
| `MC_RENDER_STAGE_RAIN_SNOW` | 11 | Weather particles |
| `MC_RENDER_STAGE_WORLD_BORDER` | 12 | World border |

### Dimension-Specific Shaders

OptiFine supports dimension-specific shader files:

| Folder | Dimension |
|--------|-----------|
| `world-1/` | Nether |
| `world1/` | The End |
| `world<id>/` | Custom dimension by numeric ID |

#### Dimension Configuration (Iris)
```properties
# In shaders.properties
dimension.nether = minecraft:the_nether
dimension.end = minecraft:the_end
dimension.custom = namespace:dimension_name
```

### Current Project Status

Based on the current project structure:

#### Currently Implemented
**Property Files:**
- [x] `shaders.properties`
- [x] `shaders/block.properties`
- [x] `shaders/entity.properties`
- [x] `shaders/item.properties`

**Fragment Shaders:**
- [x] `composite.fsh`
- [x] `composite1.fsh`
- [x] `composite2.fsh`
- [x] `deferred.fsh`
- [x] `final.fsh`
- [x] `gbuffers_clouds.fsh`
- [x] `gbuffers_entities.fsh`
- [x] `gbuffers_line.fsh`
- [x] `gbuffers_skybasic.fsh`
- [x] `gbuffers_terrain.fsh`
- [x] `gbuffers_textured_lit.fsh`
- [x] `gbuffers_textured.fsh`
- [x] `gbuffers_water.fsh`
- [x] `prepare.fsh`
- [x] `shadow.fsh`
- [x] `shadowcomp.fsh`

**Vertex Shaders:**
- [x] `composite.vsh`
- [x] `gbuffers_clouds.vsh`
- [x] `gbuffers_entities.vsh`
- [x] `gbuffers_line.vsh`
- [x] `gbuffers_skybasic.vsh`
- [x] `gbuffers_terrain.vsh`
- [x] `gbuffers_textured.vsh`
- [x] `gbuffers_water.vsh`
- [x] `shadow.vsh`
- [x] `shadowcomp.vsh`

**Geometry Shaders:**
- [x] `grass.gsh`
- [x] `particles.gsh`

**Compute Shaders:**
- [x] `composite.csh`

#### Additional Shader Files
**GBuffers Programs (all exist):**
- [x] `gbuffers_skytextured.vsh/fsh` - Sun/moon rendering
- [x] `gbuffers_beaconbeam.vsh/fsh` - Beacon beam effect
- [x] `gbuffers_armor_glint.vsh/fsh` - Enchantment glint
- [x] `gbuffers_spidereyes.vsh/fsh` - Spider/enderman eyes
- [x] `gbuffers_damagedblock.vsh/fsh` - Block damage overlay
- [x] `gbuffers_hand.vsh/fsh` - Player hand rendering
- [x] `gbuffers_hand_water.vsh/fsh` - Translucent hand items
- [x] `gbuffers_weather.vsh/fsh` - Rain/snow effects
- [x] `gbuffers_block.vsh/fsh` - Block entities (chests, etc.)
- [x] `gbuffers_entities_glowing.vsh/fsh` - Glowing entity effect
- [x] `gbuffers_basic.vsh/fsh` - Basic geometry (leash, selection)

**Additional Passes (partial - we have composite3, deferred1, prepare1, shadowcomp1):**
- [x] `composite3.vsh/fsh` - Additional composite stage
- [x] `deferred1.vsh/fsh` - Additional deferred stage
- [x] `prepare1.vsh/fsh` - Additional prepare stage
- [x] `shadowcomp1.vsh/fsh` - Additional shadowcomp stage
- [ ] `composite4-15.vsh/fsh` - Extended composite stages (optional)
- [ ] `deferred2-15.vsh/fsh` - Extended deferred stages (optional)
- [ ] `prepare2-15.vsh/fsh` - Extended prepare stages (optional)
- [ ] `shadowcomp2-15.vsh/fsh` - Extended shadowcomp stages (optional)

**Language Files:**
- [x] `shaders/lang/en_us.lang` - English translations for shader settings

**Dimension-Specific:**
- [x] `world-1/` - Nether-specific shaders folder
- [x] `world1/` - End-specific shaders folder

### Quick Reference: Output Directives

```glsl
// Specify output buffers (GLSL 120)
/* DRAWBUFFERS:0257 */

// Specify output buffers (GLSL 130+)
/* RENDERTARGETS: 0,2,5,7 */

// Layout-based output (GLSL 150+)
layout(location = 0) out vec4 colortex0Out;
layout(location = 1) out vec4 colortex1Out;
```

### Quick Reference: Common Constants

```glsl
// Shadow settings
const int shadowMapResolution = 1024;
const float shadowDistance = 160.0f;
const float shadowMapFov = 90.0;
const float shadowIntervalSize = 2.0f;

// Wetness
const float wetnessHalflife = 600.0f;
const float drynessHalflife = 200.0f;

// Buffer formats
const int colortex0Format = RGBA16F;
const int colortex1Format = RGB16F;
const int gaux4Format = RGBA32F;

// Mipmaps
const bool generateShadowMipmap = true;
const bool shadowHardwareFiltering = true;
```

---

This checklist provides a comprehensive reference for OptiFine shader development. Use it to track implementation progress and ensure all necessary components are included in your shader pack.