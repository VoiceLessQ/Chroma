#version 120
// ============================================
// GBuffers Hand Water - Translucent Handheld Vertex Shader
// ============================================
// Renders: Translucent handheld objects (water buckets, potions, etc.)
// Fallback: gbuffers_hand
// ============================================
// This shader handles the vertex transformation for translucent
// items held by the player. This includes water buckets, potions,
// and any other transparent or semi-transparent held items.
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
