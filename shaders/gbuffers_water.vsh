//===============================================================================
// Water Vertex Shader (gbuffers_water.vsh)
//
// This shader processes vertices for water blocks and prepares data for the
// fragment shader. It handles basic transformations and passes essential
// rendering information to the fragment stage.
//
// Primary Functions:
// - Vertex position transformation to clip space
// - Texture coordinate mapping for water animation
// - Lightmap coordinate processing
// - Color and tint passing
//
// Special considerations for water:
// - Water requires special transparency handling
// - Water has animated texture coordinates
// - Water may need special depth testing
//===============================================================================

#version 150

//===============================================
// UNIFORM VARIABLES
//===============================================
// These are provided by the shader program and remain constant for all vertices
uniform mat4 modelViewMatrix;    // Model-view matrix for 3D transformations
uniform mat4 projectionMatrix;   // Projection matrix for perspective/orthographic projection
uniform mat4 textureMatrix = mat4(1.0);  // Texture transformation matrix for UV mapping

//===============================================
// INPUT ATTRIBUTES
//===============================================
// These are read from the vertex data provided by Minecraft
in ivec2 vaUV2;                  // Lightmap texture coordinates (integer format)
in vec2 vaUV0;                    // Main texture coordinates (0-1 range)
in vec3 vaPosition;               // Vertex position in model space
in vec4 vaColor;                  // Vertex color/tint

//===============================================
// OUTPUT VARIABLES (VARYING)
//===============================================
// These are passed from vertex to fragment shader
out vec2 lmcoord;                 // Lightmap coordinates (0-1 range)
out vec2 texcoord;                // Main texture coordinates (0-1 range)
out vec4 tint;                    // Vertex color/tint for tinting effects

//===============================================
// MAIN VERTEX SHADER FUNCTION
//===============================================
void main() {
	// Transform vertex position to clip space for rendering
	// Pipeline: model space -> model-view -> projection -> clip space
	gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition, 1.0);
	
	// Transform main texture coordinates using texture matrix
	// This handles texture scaling, rotation, and translation
	// Water shaders often use these for animated effects
	texcoord = (textureMatrix * vec4(vaUV0, 0.0, 1.0)).xy;
	
	// Convert lightmap coordinates from integer format to 0-1 range
	// Minecraft uses 0-255 for lightmap values, so we divide by 256
	// The + (1.0 / 32.0) offset adjusts for the lightmap grid
	lmcoord = vaUV2 * (1.0 / 256.0) + (1.0 / 32.0);
	
	// Pass vertex color/tint to fragment shader
	// Water often uses this for tinting effects based on biome
	tint = vaColor;
}