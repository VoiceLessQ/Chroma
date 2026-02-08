//===============================================================================
// Shadow Composite Vertex Shader (shadowcomp.vsh)
//
// This shader processes vertices for shadow composite rendering and prepares data
// for the fragment shader. It handles basic transformations for shadow post-processing.
//
// Primary Functions:
// - Vertex position transformation to clip space for shadow composite rendering
// - Texture coordinate transformation for shadow post-processing
//
// Special considerations for shadow composite rendering:
// - Shadow composite is used for post-processing shadow maps
// - Often uses full-screen quad rendering
// - This shader uses legacy OpenGL functions for compatibility
//===============================================================================

#version 150

//===============================================
// OUTPUT VARIABLES (VARYING)
//===============================================
// These are passed from vertex to fragment shader
out vec2 texcoord;                // Texture coordinates for shadow post-processing

//===============================================
// MAIN VERTEX SHADER FUNCTION
//===============================================
void main() {
	// Transform vertex position to clip space for shadow composite rendering
	// Using legacy ftransform() function for compatibility
	gl_Position = ftransform();
	
	// Transform texture coordinates using legacy texture matrix
	// This is used for shadow post-processing effects and texture sampling
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}