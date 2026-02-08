#version 120
// ============================================
// GBuffers Sky Textured - Sun and Moon Vertex Shader
// ============================================
// Renders: Sun and moon textures
// Fallback: gbuffers_textured
// ============================================
// This shader handles the vertex transformation for the sun and moon
// in the sky. Use sunPosition and moonPosition uniforms to determine
// which celestial body is being rendered.
// ============================================

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    glcolor = gl_Color;
    
    gl_Position = ftransform();
}
