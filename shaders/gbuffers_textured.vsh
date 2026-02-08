//===============================================================================
// Textured Vertex Shader (gbuffers_textured.vsh)
//
// This shader processes vertices for textured objects and prepares data for the
// fragment shader. It handles basic transformations for textured rendering.
//
// Primary Functions:
// - Vertex position transformation to clip space for textured rendering
// - Texture coordinate transformation for UV mapping
// - Lightmap coordinate processing
// - Color and tint passing
//
// Special considerations for textured objects:
// - Textured rendering often uses special UV mapping
// - Textured objects may have special transparency requirements
// - Textured rendering often uses special blending modes
// - This shader is used for particles and basic textured elements
//===============================================================================

#version 150

//===============================================
// UNIFORM VARIABLES
//===============================================
// These are provided by the shader program and remain constant for all vertices
uniform mat4 modelViewMatrix;    // Model-view matrix for 3D transformations
uniform mat4 projectionMatrix;   // Projection matrix for textured rendering
uniform mat4 textureMatrix = mat4(1.0);  // Texture transformation matrix for UV mapping

//===============================================
// INPUT ATTRIBUTES
//===============================================
// These are read from the vertex data provided by Minecraft
in ivec2 vaUV2;                  // Lightmap UV coordinates (integer format)
in vec2 vaUV0;                    // Texture UV coordinates (0-1 range)
in vec3 vaPosition;               // Vertex position in model space
in vec4 vaColor;                  // Vertex color/tint

//===============================================
// OUTPUT VARIABLES (VARYING)
//===============================================
// These are passed from vertex to fragment shader
out vec2 lmcoord;                 // Lightmap coordinates (0-1 range)
out vec2 texcoord;                // Texture coordinates (0-1 range)
out vec4 tint;                    // Vertex color/tint for tinting effects

//===============================================
// MAIN VERTEX SHADER FUNCTION
//===============================================
void main() {
    // Transform vertex position to clip space for textured rendering
    // Pipeline: model space -> model-view -> projection -> clip space
    gl_Position = projectionMatrix * (modelViewMatrix * vec4(vaPosition, 1.0));
    
    // Transform texture coordinates using texture matrix
    // This handles texture scaling, rotation, and translation
    texcoord = (textureMatrix * vec4(vaUV0, 0.0, 1.0)).xy;
    
    // Convert lightmap coordinates from integer format to 0-1 range
    // Minecraft uses 0-255 for lightmap values, so we divide by 256
    // The + (1.0 / 32.0) offset adjusts for the lightmap grid
    lmcoord = vaUV2 * (1.0 / 256.0) + (1.0 / 32.0);
    
    // Pass color tint to fragment shader
    // This can be used for tinting effects on textured objects
    tint = vaColor;
}