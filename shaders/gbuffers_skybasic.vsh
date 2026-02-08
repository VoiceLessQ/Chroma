//===============================================================================
// Sky Basic Vertex Shader (gbuffers_skybasic.vsh)
//
// This shader processes vertices for sky rendering and prepares data for the
// fragment shader. It handles basic transformations and passes essential
// rendering information to the fragment stage.
//
// Primary Functions:
// - Vertex position transformation to clip space
//
// Special considerations for sky:
// - Sky rendering doesn't need texture coordinates
// - Sky rendering doesn't need lightmap coordinates
// - Sky often uses special rendering techniques
// - This is a simplified version for basic sky rendering
//===============================================================================

#version 150

//===============================================
// UNIFORM VARIABLES
//===============================================
// These are provided by the shader program and remain constant for all vertices
uniform mat4 modelViewMatrix;    // Model-view matrix for 3D transformations
uniform mat4 projectionMatrix;   // Projection matrix for perspective/orthographic projection

//===============================================
// INPUT ATTRIBUTES
//===============================================
// These are read from the vertex data provided by Minecraft
in vec3 vaPosition;               // Vertex position in model space

//===============================================
// MAIN VERTEX SHADER FUNCTION
//===============================================
void main() {
	// Transform vertex position to clip space for rendering
	// Pipeline: model space -> model-view -> projection -> clip space
	gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition, 1.0);
}