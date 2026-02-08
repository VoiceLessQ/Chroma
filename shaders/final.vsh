#version 120
// ============================================
// Final - Final Output Vertex Shader
// ============================================
// Stage: Last stage in pipeline
// Purpose: Final processing before screen output
// ============================================
// The final pass is the last stage in the shader pipeline.
// It receives all processed data and outputs directly to the
// screen. This is where you apply:
// - Tone mapping
// - Gamma correction
// - Color grading
// - Vignette
// - Final bloom/flare
// ============================================

varying vec2 texcoord;

void main() {
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    gl_Position = ftransform();
}
