#version 120
// ============================================
// Composite 3 - Post-Processing Pass 3 Fragment Shader
// ============================================
// Stage: After composite2, before composite4
// Purpose: Third pass of multi-stage post-processing
// ============================================
// Available inputs from previous passes:
// - colortex0: Main color from previous pass
// - colortex1-7: Auxiliary buffers (depth, normals, etc.)
// - depthtex0: Scene depth
// ============================================
/* DRAWBUFFERS:0 */

uniform sampler2D gtexture;
uniform sampler2D depthtex0;

varying vec2 texcoord;

void main() {
    vec4 color = texture2D(gtexture, texcoord);
    
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = color; // colortex0
}
