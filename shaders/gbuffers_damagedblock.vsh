#version 120
// ============================================
// GBuffers Damaged Block - Block Breaking Overlay Vertex Shader
// ============================================
// Renders: Block breaking progress overlay (cracking texture)
// Fallback: gbuffers_terrain
// ============================================
// This shader handles the vertex transformation for the block
// breaking overlay. As the player breaks a block, a progressive
// cracking texture is rendered over the block being broken.
// ============================================

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    glcolor = gl_Color;
    
    gl_Position = ftransform();
}
