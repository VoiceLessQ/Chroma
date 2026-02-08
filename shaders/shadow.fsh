#version 150
#extension GL_ARB_explicit_attrib_location : enable

// Shadow mapping fragment shader
// Renders depth information from sun's perspective

// Uniforms
uniform sampler2D gtexture;    // Main texture sampler
uniform sampler2D lightmap;    // Lightmap sampler
uniform float alphaTestRef;     // Alpha test threshold

// Inputs from vertex shader
in vec2 lmcoord;               // Lightmap coordinates
in vec2 texcoord;              // Texture coordinates
in vec4 tint;                  // Color tint

// Output to shadow depth buffer
/* DRAWBUFFERS:4 */
layout(location = 4) out vec4 shadowtex0Out;

void main() {
    // Sample main texture and apply tint
    vec4 color = texture(gtexture, texcoord) * tint;
    
    // Alpha test - discard transparent pixels below threshold
    if (color.a < alphaTestRef) discard;
    
    // Apply lighting from lightmap
    color *= texture(lightmap, lmcoord);
    
    // Output depth information for shadow mapping
    // In a real shadow shader, this would calculate depth values
    // For now, just output the color (will be overridden by depth)
    shadowtex0Out = color;
}