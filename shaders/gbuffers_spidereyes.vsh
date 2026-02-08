#version 120
// ============================================
// GBuffers Spider Eyes - Mob Eyes Vertex Shader
// ============================================
// Renders: Eyes of spiders, endermen, and ender dragon
// Fallback: gbuffers_textured
// ============================================
// This shader handles the vertex transformation for mob eyes.
// These eyes are emissive and visible even in complete darkness,
// creating a spooky effect when mobs are lurking in shadows.
// ============================================

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    glcolor = gl_Color;
    
    gl_Position = ftransform();
}
