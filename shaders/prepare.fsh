#version 150
#extension GL_ARB_explicit_attrib_location : enable

// Prepare shader
// Runs before terrain rendering for setup operations

// Uniforms
uniform sampler2D gcolor;       // Color buffer from previous pass
uniform sampler2D gdepth;       // Depth buffer
uniform sampler2D gnormal;      // Normal buffer
uniform sampler2D composite;    // Composite buffer

// Inputs
in vec2 texcoord;               // Texture coordinates

// Outputs to multiple buffers
/* DRAWBUFFERS:0,1,2,3 */
layout(location = 0) out vec4 colortex0Out;  // gcolor
layout(location = 1) out vec4 colortex1Out;  // gdepth
layout(location = 2) out vec4 colortex2Out;  // gnormal
layout(location = 3) out vec4 colortex3Out;  // composite

void main() {
    // Sample input buffers
    vec4 color = texture(gcolor, texcoord);
    vec4 depth = texture(gdepth, texcoord);
    vec4 normal = texture(gnormal, texcoord);
    vec4 comp = texture(composite, texcoord);
    
    // Basic prepare pass - just pass through data
    // In a real implementation, this would prepare buffers for terrain rendering
    colortex0Out = color;
    colortex1Out = depth;
    colortex2Out = normal;
    colortex3Out = comp;
    
    // Could add preparation effects here:
    // - Buffer clearing
    // - Setup for terrain-specific effects
    // - Pre-calculations for lighting
}