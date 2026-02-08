#version 150
#extension GL_ARB_explicit_attrib_location : enable

// Line rendering fragment shader
// For block selection boxes, fishing lines, and similar line elements

// Uniforms
uniform float alphaTestRef;     // Alpha test threshold

// Inputs from vertex shader
in vec4 tint;                  // Color tint

// Output to color buffer
/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 colortex0Out;

void main() {
    // Line rendering typically doesn't use alpha testing
    // Just output the color with full opacity
    colortex0Out = vec4(tint.rgb, 1.0);
}