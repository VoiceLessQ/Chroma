#version 120
// ============================================
// Composite 2 - Post-Processing Pass 2 Vertex Shader
// ============================================
// Stage: After composite1, before composite3
// Purpose: Second pass of multi-stage post-processing
// ============================================
// Composite stages are used for sequential post-processing effects.
// This is the third composite pass, useful for complex multi-pass
// effects like temporal anti-aliasing or multi-pass bloom.
// ============================================

varying vec2 texcoord;

void main() {
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    gl_Position = ftransform();
}
