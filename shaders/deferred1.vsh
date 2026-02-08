#version 120
// ============================================
// Deferred 1 - Deferred Rendering Pass 1 Vertex Shader
// ============================================
// Stage: After gbuffer, before composite
// Purpose: First deferred rendering pass
// ============================================
// Deferred rendering separates geometry from lighting calculations.
// This pass processes the gbuffer data to compute lighting, shadows,
// and other screen-space effects before final composition.
// ============================================

varying vec2 texcoord;

void main() {
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    gl_Position = ftransform();
}
