#version 120
// ============================================
// Composite 3 - Post-Processing Pass 3 Vertex Shader
// ============================================
// Stage: After composite2, before composite4
// Purpose: Third pass of multi-stage post-processing
// ============================================
// Composite stages are used for sequential post-processing effects.
// Each stage can read from previous stage outputs and write to
// color buffers for the next stage to process.
// ============================================

varying vec2 texcoord;

void main() {
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    gl_Position = ftransform();
}
