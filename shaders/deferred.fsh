#version 150
#extension GL_ARB_explicit_attrib_location : enable

// Deferred shader
// Full-screen pass after opaque rendering

// Uniforms
uniform sampler2D gcolor;       // Color buffer
uniform sampler2D gdepth;       // Depth buffer
uniform sampler2D gnormal;      // Normal buffer
uniform sampler2D composite;    // Composite buffer
uniform sampler2D shadowtex0;   // Shadow map
uniform sampler2D shadowtex1;   // Shadow map (alternative)
uniform sampler2D depthtex0;     // Depth buffer
uniform sampler2D depthtex1;     // Depth buffer (alternative)
uniform sampler2D noisetex;     // Noise texture

// Inputs
in vec2 texcoord;               // Texture coordinates

// Outputs to multiple buffers
/* DRAWBUFFERS:7,8,9,10 */
layout(location = 7) out vec4 colortex4Out;  // gaux1
layout(location = 8) out vec4 colortex5Out;  // gaux2
layout(location = 9) out vec4 colortex6Out;  // gaux3
layout(location = 10) out vec4 colortex7Out; // gaux4

void main() {
    // Sample input buffers
    vec4 color = texture(gcolor, texcoord);
    vec4 depth = texture(gdepth, texcoord);
    vec4 normal = texture(gnormal, texcoord);
    vec4 comp = texture(composite, texcoord);
    
    // Sample shadow and depth information
    vec4 shadow0 = texture(shadowtex0, texcoord);
    vec4 shadow1 = texture(shadowtex1, texcoord);
    vec4 depth0 = texture(depthtex0, texcoord);
    vec4 depth1 = texture(depthtex1, texcoord);
    
    // Sample noise for effects
    vec4 noise = texture(noisetex, texcoord);
    
    // Basic deferred pass - process scene data
    // In a real implementation, this would calculate:
    // - Ambient occlusion
    // - Screen-space reflections
    // - Depth-based effects
    // - Global illumination
    
    // Example: Simple depth-based fog effect
    float depthFactor = depth.r;
    vec3 fogColor = vec3(0.7, 0.8, 0.9); // Light blue fog
    vec3 finalColor = mix(color.rgb, fogColor, depthFactor * 0.3);
    
    // Example: Simple shadow effect
    float shadowFactor = (shadow0.r + shadow1.r) * 0.5;
    finalColor *= shadowFactor;
    
    // Output to custom buffers for later use
    colortex4Out = vec4(finalColor, color.a);      // gaux1 - processed color
    colortex5Out = vec4(normal.rgb, 1.0);          // gaux2 - normals
    colortex6Out = vec4(depth0.rgb, 1.0);         // gaux3 - depth
    colortex7Out = vec4(noise.rgb, 1.0);          // gaux4 - noise
}