#version 120
// ============================================
// Prepare - Pre-GBuffer Preparation Pass 0 Vertex Shader
// ============================================
// Stage: Before gbuffer passes
// Purpose: Primary pre-process data pass
// ============================================
// Prepare stages run before gbuffer passes and can be used to:
// - Pre-compute shadow maps
// - Generate ambient occlusion data
// - Prepare volumetric effects
// - Set up temporal data for motion vectors
// ============================================

varying vec2 texcoord;

void main() {
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    gl_Position = ftransform();
}
