// ============================================
// Buffer Configuration Constants
// ============================================
// These constants configure the shader buffers.
// Uncomment and modify as needed for your shader pack.
// ============================================

// ============================================
// Shadow Map Settings
// ============================================

// Shadow map resolution (higher = better quality, more VRAM)
// const int shadowMapResolution = 1024;   // Low
// const int shadowMapResolution = 2048;   // Medium
// const int shadowMapResolution = 4096;   // High

// Shadow map field of view
// const float shadowMapFov = 90.0;

// Shadow render distance
// const float shadowDistance = 160.0;

// Shadow distance render multiplier (-1 = auto)
// const float shadowDistanceRenderMul = -1.0;

// Shadow interval size for cascaded shadows
// const float shadowIntervalSize = 2.0;

// ============================================
// Shadow Mipmap Settings
// ============================================

// Generate mipmaps for shadow depth
// const bool generateShadowMipmap = false;

// Generate mipmaps for shadow color
// const bool generateShadowColorMipmap = false;

// Hardware filtering for shadows
// const bool shadowHardwareFiltering = false;

// ============================================
// Wetness Settings
// ============================================

// Halflife for wetness accumulation (seconds)
// const float wetnessHalflife = 600.0;

// Halflife for drying (seconds)
// const float drynessHalflife = 200.0;

// Halflife for eye brightness smoothing
// const float eyeBrightnessHalflife = 10.0;

// Halflife for center depth smoothing
// const float centerDepthHalflife = 1.0;

// ============================================
// Environment Settings
// ============================================

// Sun path rotation (degrees, affects sun/moon angle)
// const float sunPathRotation = 0.0;

// Ambient occlusion level (0.0 = full AO, 1.0 = no AO)
// const float ambientOcclusionLevel = 1.0;

// Super sampling level (1 = none, 2 = 2x, 4 = 4x)
// const int superSamplingLevel = 1;

// Noise texture resolution
// const int noiseTextureResolution = 256;

// ============================================
// Color Buffer Formats
// ============================================
// Uncomment to change buffer formats from defaults

// Main color buffer (default: RGBA8)
// const int colortex0Format = RGBA8;

// Depth buffer (default: RGBA32F)
// const int colortex1Format = RGBA32F;

// Normal buffer (default: RGB10_A2)
// const int colortex2Format = RGB10_A2;

// Composite buffer (default: RGBA8)
// const int colortex3Format = RGBA8;

// Auxiliary buffers 1-4 (default: RGBA8)
// const int colortex4Format = RGBA8;
// const int colortex5Format = RGBA8;
// const int colortex6Format = RGBA8;
// const int colortex7Format = RGBA8;

// ============================================
// Buffer Clear Settings
// ============================================

// Whether to clear buffers each frame
// const bool colortex0Clear = true;
// const bool colortex1Clear = true;

// Clear color for buffers
// const vec4 colortex0ClearColor = vec4(0.0);

// ============================================
// Mipmap Settings
// ============================================

// Enable mipmaps for color buffers
// const bool colortex0MipmapEnabled = false;
// const bool colortex1MipmapEnabled = false;
