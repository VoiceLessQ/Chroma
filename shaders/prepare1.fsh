#version 120
// ============================================
// Prepare 1 - Pre-GBuffer Preparation Pass 1 Fragment Shader
// ============================================
// Stage: Before gbuffer passes
// Purpose: Pre-process data before main rendering
// ============================================
// Prepare stages can write to auxiliary buffers that will be
// read during gbuffer rendering. Useful for pre-computed data
// like ambient occlusion, volumetric lighting, or temporal data.
// ============================================
/* DRAWBUFFERS:0 */

uniform sampler2D gtexture;

varying vec2 texcoord;

void main() {
    vec4 color = texture2D(gtexture, texcoord);
    
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = color; // colortex0
}
