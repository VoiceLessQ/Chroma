#version 120
// ============================================
// GBuffers Block - Block Entities Vertex Shader
// ============================================
// Renders: Block entities (chests, signs, banners, beds, etc.)
// Fallback: gbuffers_terrain
// ============================================
// This shader handles the vertex transformation for block entities.
// Block entities are special blocks with additional data or complex
// rendering, such as chests, signs, banners, beds, and shulker boxes.
// ============================================

varying vec2 texcoord;
varying vec4 glcolor;
varying vec2 lmcoord;

void main() {
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    glcolor = gl_Color;
    
    gl_Position = ftransform();
}
