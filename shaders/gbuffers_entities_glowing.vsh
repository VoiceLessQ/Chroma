#version 120
// ============================================
// GBuffers Entities Glowing - Glowing Effect Vertex Shader
// ============================================
// Renders: Glowing entities (entities with glowing effect, spectral arrows)
// Fallback: gbuffers_entities
// ============================================
// This shader handles the vertex transformation for entities with
// the glowing effect. The glowing effect creates an outline that
// is visible through walls, used by spectral arrows and commands.
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
