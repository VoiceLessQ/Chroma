#version 120
// ============================================
// GBuffers Textured Lit - Lit Particles Vertex Shader
// ============================================
// Renders: Lit particles, world border
// Fallback: gbuffers_textured
// ============================================
// This shader handles vertex transformation for lit particles
// and the world border. These objects receive lighting from
// the lightmap in addition to texture sampling.
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
