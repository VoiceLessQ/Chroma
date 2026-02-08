#version 120
// ============================================
// Deferred - Deferred Rendering Pass 0 Vertex Shader
// ============================================
// Stage: After gbuffer, before composite
// Purpose: Primary deferred rendering pass
// ============================================
// Deferred rendering separates geometry from lighting calculations.
// This is the primary deferred pass that processes gbuffer data to
// compute lighting, shadows, and other screen-space effects.
// ============================================

varying vec2 texcoord;

void main() {
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    gl_Position = ftransform();
}
