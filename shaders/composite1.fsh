#version 150
#extension GL_ARB_explicit_attrib_location : enable

// Additional composite shader for post-processing effects
// Runs after the main composite shader for additional effects

// Uniforms
uniform sampler2D colortex0;  // Main color buffer
uniform sampler2D colortex1;  // Depth buffer
uniform sampler2D colortex2;  // Normal buffer
uniform sampler2D colortex3;  // Composite buffer
uniform sampler2D colortex4;  // Custom buffer 1
uniform sampler2D colortex5;  // Custom buffer 2
uniform sampler2D colortex6;  // Custom buffer 3
uniform sampler2D colortex7;  // Custom buffer 4
uniform sampler2D noisetex;   // Noise texture

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
    vec4 noise = texture(noisetex, texcoord);
    
    // Additional post-processing effects
    // Example: Subtle color grading
    vec3 gradedColor = color.rgb;
    
    // Add slight blue tint for atmospheric effect
    gradedColor += vec3(0.02, 0.04, 0.06);
    
    // Add subtle contrast
    gradedColor = mix(gradedColor, vec3(0.5), dot(gradedColor, vec3(0.333)) - 0.5);
    
    // Apply noise for film grain effect
    float grain = (noise.r - 0.5) * 0.1;
    gradedColor += grain;
    
    // Clamp values
    gradedColor = clamp(gradedColor, 0.0, 1.0);
    
    // Output processed data
    colortex0Out = vec4(gradedColor, color.a);
    colortex1Out = depth;
    colortex2Out = normal;
    colortex3Out = composite;
}