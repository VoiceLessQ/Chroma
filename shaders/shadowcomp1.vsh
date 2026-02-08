#version 120
// ============================================
// Shadow Composite 1 - Shadow Post-Processing Pass 1 Vertex Shader
// ============================================
// Stage: After shadow pass, before gbuffer
// Purpose: Process shadow map data
// ============================================
// Shadow composite stages run after the shadow map is rendered but
// before the main gbuffer passes. They can be used to:
// - Apply PCF (Percentage Closer Filtering) to shadows
// - Generate shadow mipmaps
// - Compute soft shadow penumbra
// - Apply shadow denoising
// ============================================

varying vec2 texcoord;

void main() {
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    gl_Position = ftransform();
}
