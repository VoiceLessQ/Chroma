#version 120
// ============================================
// GBuffers Weather - Rain and Snow Vertex Shader
// ============================================
// Renders: Rain drops and snowflakes
// Fallback: gbuffers_textured_lit
// ============================================
// This shader handles the vertex transformation for weather
// particles. Rain and snow are rendered as falling particles
// that respond to the weather strength (rainStrength uniform).
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
