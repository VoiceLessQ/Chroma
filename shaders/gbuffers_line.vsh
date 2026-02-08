//===============================================================================
// Line Vertex Shader (gbuffers_line.vsh)
//
// This shader processes vertices for line rendering and prepares data for the
// fragment shader. It handles basic transformations for line rendering.
//
// Primary Functions:
// - Vertex position transformation to clip space for line rendering
// - Color and tint passing for line elements
//
// Special considerations for line rendering:
// - Line rendering often uses special line width settings
// - Line rendering may have special depth testing requirements
// - Line rendering often uses special blending modes for anti-aliasing
// - This shader is used for block selection boxes, fishing lines, and similar line elements
//===============================================================================

#version 150

//===============================================
// UNIFORM VARIABLES
//===============================================
// These are provided by the shader program and remain constant for all vertices
uniform mat4 modelViewMatrix;    // Model-view matrix for 3D transformations
uniform mat4 projectionMatrix;   // Projection matrix for line rendering

//===============================================
// INPUT ATTRIBUTES
//===============================================
// These are read from the vertex data provided by Minecraft
in vec3 vaPosition;               // Vertex position in model space
in vec4 vaColor;                  // Vertex color/tint

//===============================================
// OUTPUT VARIABLES (VARYING)
//===============================================
// These are passed from vertex to fragment shader
out vec4 tint;                    // Vertex color/tint for line elements

//===============================================
// MAIN VERTEX SHADER FUNCTION
//===============================================
void main() {
    // Transform vertex position to clip space for line rendering
    // Pipeline: model space -> model-view -> projection -> clip space
    gl_Position = projectionMatrix * (modelViewMatrix * vec4(vaPosition, 1.0));
    
    // Pass color tint to fragment shader
    // This can be used for colored line effects like selection boxes
    tint = vaColor;
}