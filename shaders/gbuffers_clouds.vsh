//===============================================================================
// Clouds Vertex Shader (gbuffers_clouds.vsh)
//
// This shader processes vertices for cloud rendering and prepares data for the
// fragment shader. It handles basic transformations for cloud rendering.
//
// Primary Functions:
// - Vertex position transformation to clip space for cloud rendering
// - Color and tint passing for atmospheric effects
//
// Special considerations for clouds:
// - Cloud rendering often uses special transparency handling
// - Clouds may have special depth testing requirements
// - Cloud rendering often uses special blending modes
// - Clouds often have atmospheric effects and color variations
//===============================================================================

#version 150

//===============================================
// UNIFORM VARIABLES
//===============================================
// These are provided by the shader program and remain constant for all vertices
uniform mat4 modelViewMatrix;    // Model-view matrix for 3D transformations
uniform mat4 projectionMatrix;   // Projection matrix for cloud rendering

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
out vec4 tint;                    // Vertex color/tint for atmospheric effects

//===============================================
// MAIN VERTEX SHADER FUNCTION
//===============================================
void main() {
    // Transform vertex position to clip space for cloud rendering
    // Pipeline: model space -> model-view -> projection -> clip space
    gl_Position = projectionMatrix * (modelViewMatrix * vec4(vaPosition, 1.0));
    
    // Pass color tint to fragment shader
    // This can be used for atmospheric effects and color variations
    tint = vaColor;
}