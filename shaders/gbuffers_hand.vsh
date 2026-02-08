#version 120
// ============================================
// GBuffers Hand - Player Hand Vertex Shader
// ============================================
// Renders: First-person hand and opaque handheld objects
// Fallback: gbuffers_textured_lit
// ============================================
// This shader handles the vertex transformation for the player's
// hand in first-person view. It also renders opaque items being
// held. Use this for custom hand rendering or item effects.
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
