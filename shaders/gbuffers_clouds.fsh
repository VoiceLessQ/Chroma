#version 150
#extension GL_ARB_explicit_attrib_location : enable

// Cloud rendering fragment shader
// For cloud rendering with atmospheric effects

// Uniforms
uniform sampler2D gtexture;    // Main texture sampler
uniform float alphaTestRef;     // Alpha test threshold

// Inputs from vertex shader
in vec4 tint;                  // Color tint

// Output to color buffer
/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 colortex0Out;

void main() {
    // Cloud rendering typically uses a simple texture with alpha
    // The tint contains the cloud color and density information
    
    // Output cloud color with full opacity
    // Clouds are rendered as opaque white with varying density
    vec3 cloudColor = vec3(1.0); // Pure white clouds
    colortex0Out = vec4(cloudColor, 1.0);
}