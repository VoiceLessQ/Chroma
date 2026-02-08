#version 120
// ============================================
// Composite 1 - Post-Processing Pass 1 Vertex Shader
// ============================================
// Stage: After composite, before composite2
// Purpose: First pass of multi-stage post-processing
// ============================================
// Composite stages are used for sequential post-processing effects.
// This is the second composite pass, typically used for effects
// that need a separate pass from the main composite shader.
// ============================================

varying vec2 texcoord;

void main() {
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    gl_Position = ftransform();
}
