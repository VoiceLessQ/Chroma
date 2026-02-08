#version 120
// ============================================
// GBuffers Beacon Beam - Beacon Beam Vertex Shader
// ============================================
// Renders: Beacon light beam
// Fallback: gbuffers_textured
// ============================================
// This shader handles the vertex transformation for beacon beams.
// Beacon beams are vertical light columns that extend from the
// beacon block up to the sky (or build limit).
// ============================================

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    glcolor = gl_Color;
    
    gl_Position = ftransform();
}
