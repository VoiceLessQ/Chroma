#version 120
// ============================================
// Shadow Composite 1 - Shadow Post-Processing Pass 1 Fragment Shader
// ============================================
// Stage: After shadow pass, before gbuffer
// Purpose: Process shadow map data
// ============================================
// Available shadow inputs:
// - shadowtex0: Shadow depth (all objects)
// - shadowtex1: Shadow depth (no translucent)
// - shadowcolor0: Shadow color buffer 0
// - shadowcolor1: Shadow color buffer 1
// ============================================
/* DRAWBUFFERS:0 */

uniform sampler2D gtexture;
uniform sampler2D shadowtex0;

varying vec2 texcoord;

void main() {
    vec4 color = texture2D(gtexture, texcoord);
    
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = color; // colortex0
}
