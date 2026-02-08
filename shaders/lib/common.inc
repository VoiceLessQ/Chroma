// ============================================
// Common Shader Include File
// ============================================
// This file contains common definitions, macros, and utilities
// shared across all shader programs.
// 
// Include in your shaders with:
// #include "lib/common.inc"
// ============================================

// ============================================
// Platform Detection
// ============================================
// Detect which shader loader is being used

#ifdef IS_IRIS
    // Running on Iris (Fabric/Quilt)
    #define PLATFORM_IRIS 1
    #define PLATFORM_OPTIFINE 0
    
    // Iris-specific features available
    // - SSBOs (Shader Storage Buffer Objects)
    // - Custom compute passes (setup, begin)
    // - Tessellation shaders (.tcs, .tes)
#else
    // Running on OptiFine (Forge/Standalone)
    #define PLATFORM_IRIS 0
    #define PLATFORM_OPTIFINE 1
#endif

// ============================================
// Version Compatibility
// ============================================
// GLSL version helpers

#if __VERSION__ >= 330
    #define VERSION_MODERN 1
#else
    #define VERSION_MODERN 0
#endif

// ============================================
// Common Constants
// ============================================

const float PI = 3.14159265359;
const float TAU = 6.28318530718;
const float GOLDEN_RATIO = 1.61803398875;
const float EPSILON = 0.0001;

// ============================================
// Utility Functions
// ============================================

// Linear to sRGB conversion
vec3 linearToSRGB(vec3 color) {
    return pow(color, vec3(1.0 / 2.2));
}

// sRGB to Linear conversion
vec3 srgbToLinear(vec3 color) {
    return pow(color, vec3(2.2));
}

// Luminance calculation
float luminance(vec3 color) {
    return dot(color, vec3(0.2126, 0.7152, 0.0722));
}

// Clamp between 0 and 1
float saturate(float x) {
    return clamp(x, 0.0, 1.0);
}

vec3 saturate(vec3 x) {
    return clamp(x, 0.0, 1.0);
}

// ============================================
// Platform-Specific Code Helpers
// ============================================

// Use these macros to write platform-specific code
/*
#ifdef IS_IRIS
    // Iris-only code here
#else
    // OptiFine-only code here
#endif
*/

// Example: Feature detection for Iris-exclusive features
/*
#ifdef IS_IRIS
    #ifdef IRIS_HAS_TRANSLUCENCY_SORTING
        // Use advanced translucency sorting
    #endif
#endif
*/
