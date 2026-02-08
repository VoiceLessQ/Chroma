//===============================================================================
// Shadow Vertex Shader (shadow.vsh)
//
// This shader processes vertices for shadow rendering and prepares data for the
// fragment shader. It handles basic transformations for shadow mapping.
//
// Primary Functions:
// - Vertex position transformation to clip space for shadow mapping
// - Texture coordinate transformation for shadow rendering
// - Lightmap coordinate processing
// - Color and tint passing
//
// Special considerations for shadows:
// - Shadow mapping uses special shadowModelView and shadowProjection matrices
// - Shadow rendering renders from the light's perspective
// - Shadow coordinates need special transformation for shadow comparison
//===============================================================================

#version 150

//===============================================
// UNIFORM VARIABLES
//===============================================
// These are provided by the shader program and remain constant for all vertices
uniform mat4 shadowModelView;     // Model-view matrix from light's perspective
uniform mat4 shadowProjection;    // Projection matrix for shadow mapping
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
    // Transform vertex position for shadow rendering
    // This uses the light's perspective matrices to render from the sun's viewpoint
    gl_Position = shadowProjection * (shadowModelView * vec4(vaPosition, 1.0));
    
    // Transform texture coordinates using texture matrix
    // This handles texture scaling, rotation, and translation
    texcoord = (textureMatrix * vec4(vaUV0, 0.0, 1.0)).xy;
    
    // Convert lightmap coordinates from integer format to 0-1 range
    // Minecraft uses 0-255 for lightmap values, so we divide by 256
    // The + (1.0 / 32.0) offset adjusts for the lightmap grid
    lmcoord = vaUV2 * (1.0 / 256.0) + (1.0 / 32.0);
    
    // Pass color tint to fragment shader
    // This can be used for shadow tinting effects
    tint = vaColor;
}