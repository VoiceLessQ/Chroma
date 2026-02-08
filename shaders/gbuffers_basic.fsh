#version 120
// ============================================
// GBuffers Basic - Basic Geometry Fragment Shader
// ============================================
// Renders: Leash lines, block selection box (no fallback)
// ============================================
// This is the most basic fragment shader. It outputs simple
// vertex colors without texture sampling. Used for rendering
// simple colored geometry like leash lines and selection boxes.
// ============================================
/* DRAWBUFFERS:0 */

varying vec4 glcolor;

void main() {
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = glcolor; // colortex0 (gcolor)
}
