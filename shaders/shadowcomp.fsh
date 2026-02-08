#version 150
#extension GL_ARB_explicit_attrib_location : enable

// Shadow composite shader
// Processes shadow map after generation

// Uniforms
uniform sampler2D shadowtex0;   // Shadow depth map
uniform sampler2D shadowtex1;   // Shadow depth map (alternative)
uniform sampler2D shadowcolor0; // Shadow color map
uniform sampler2D shadowcolor1; // Shadow color map (alternative)

// Inputs
in vec2 texcoord;               // Texture coordinates

// Output to shadow color buffer
/* DRAWBUFFERS:13 */
layout(location = 13) out vec4 shadowcolor0Out;

void main() {
    // Sample shadow depth maps
    vec4 depth0 = texture(shadowtex0, texcoord);
    vec4 depth1 = texture(shadowtex1, texcoord);
    
    // Sample shadow color maps
    vec4 color0 = texture(shadowcolor0, texcoord);
    vec4 color1 = texture(shadowcolor1, texcoord);
    
    // Basic shadow composite - combine depth and color information
    // In a real implementation, this would process shadow data
    vec4 finalColor = mix(color0, color1, 0.5);
    
    // Add depth-based effects
    float depthFactor = (depth0.r + depth1.r) * 0.5;
    finalColor.rgb *= depthFactor;
    
    // Output to shadow color buffer
    shadowcolor0Out = finalColor;
}