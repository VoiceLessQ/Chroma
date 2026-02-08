#version 150
#extension GL_ARB_explicit_attrib_location : enable

// Basic textured fragment shader
// For simple textured rendering (particles, basic elements)

// Uniforms
uniform sampler2D gtexture;    // Main texture sampler
uniform sampler2D lightmap;    // Lightmap sampler
uniform float alphaTestRef;     // Alpha test threshold

// Inputs from vertex shader
in vec2 lmcoord;               // Lightmap coordinates
in vec2 texcoord;              // Texture coordinates
in vec4 tint;                  // Color tint

// Output to color buffer
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