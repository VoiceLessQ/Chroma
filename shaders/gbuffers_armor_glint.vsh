#version 120
// ============================================
// GBuffers Armor Glint - Enchantment Glint Vertex Shader
// ============================================
// Renders: Enchantment glint overlay on armor and handheld items
// Fallback: gbuffers_textured
// ============================================
// This shader handles the vertex transformation for the enchantment
// glint effect. The glint is an animated overlay that moves across
// enchanted items to show they have enchantments.
// ============================================

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    glcolor = gl_Color;
    
    gl_Position = ftransform();
}
