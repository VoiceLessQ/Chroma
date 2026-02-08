#version 150
#extension GL_ARB_explicit_attrib_location : enable

// Second additional composite shader for advanced post-processing
// Runs after composite1 for more complex effects

// Uniforms
uniform sampler2D colortex0;  // Main color buffer
uniform sampler2D colortex1;  // Depth buffer
uniform sampler2D colortex2;  // Normal buffer
uniform sampler2D colortex3;  // Composite buffer
uniform sampler2D colortex4;  // Custom buffer 1
uniform sampler2D colortex5;  // Custom buffer 2
uniform sampler2D colortex6;  // Custom buffer 3
uniform sampler2D colortex7;  // Custom buffer 4
uniform sampler2D depthtex0;  // Depth texture
uniform sampler2D shadowtex0; // Shadow map

// Inputs
in vec2 texcoord;             // Texture coordinates

// Outputs to multiple buffers
/* DRAWBUFFERS:0,1,2,3 */
layout(location = 0) out vec4 colortex0Out;  // Main color
layout(location = 1) out vec4 colortex1Out;  // Depth
layout(location = 2) out vec4 colortex2Out;  // Normals
layout(location = 3) out vec4 colortex3Out;  // Composite

void main() {
    // Sample input buffers
    vec4 color = texture(colortex0, texcoord);
    vec4 depth = texture(colortex1, texcoord);
    vec4 normal = texture(colortex2, texcoord);
    vec4 composite = texture(colortex3, texcoord);
    vec4 custom1 = texture(colortex4, texcoord);
    vec4 custom2 = texture(colortex5, texcoord);
    
    // Sample depth and shadow information
    float depthValue = texture(depthtex0, texcoord).r;
    vec4 shadow = texture(shadowtex0, texcoord);
    
    // Advanced post-processing effects
    vec3 finalColor = color.rgb;
    
    // Depth-based atmospheric scattering
    float fogFactor = smoothstep(0.5, 1.0, depthValue);
    vec3 fogColor = vec3(0.7, 0.8, 0.9); // Light blue fog
    finalColor = mix(finalColor, fogColor, fogFactor * 0.3);
    
    // Simple shadow softening
    float shadowFactor = shadow.r;
    finalColor *= (0.3 + 0.7 * shadowFactor);
    
    // Add subtle bloom effect from bright areas
    float brightness = dot(finalColor, vec3(0.299, 0.587, 0.114));
    if (brightness > 0.8) {
        finalColor += vec3(0.1, 0.1, 0.05); // Warm bloom
    }
    
    // Apply vignette effect
    vec2 center = vec2(0.5);
    float dist = distance(texcoord, center);
    float vignette = 1.0 - smoothstep(0.3, 0.8, dist);
    finalColor *= vignette;
    
    // Output processed data
    colortex0Out = vec4(finalColor, color.a);
    colortex1Out = depth;
    colortex2Out = normal;
    colortex3Out = composite;
}