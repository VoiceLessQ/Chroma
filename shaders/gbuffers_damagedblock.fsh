#version 120
// ============================================
// GBuffers Damaged Block - Block Breaking Overlay Fragment Shader
// ============================================
// Renders: Block breaking progress overlay (cracking texture)
// Fallback: gbuffers_terrain
// ============================================
// This shader handles the pixel output for the block breaking
// overlay. The cracking texture has 10 stages (0-9) that show
// progressive damage as the block is mined.
// ============================================
/* DRAWBUFFERS:0 */

uniform sampler2D gtexture;

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
    vec4 color = texture2D(gtexture, texcoord) * glcolor;
    
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = color; // colortex0 (gcolor)
}
