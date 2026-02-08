#version 120
// ============================================
// GBuffers Spider Eyes - Mob Eyes Fragment Shader
// ============================================
// Renders: Eyes of spiders, endermen, and ender dragon
// Fallback: gbuffers_textured
// ============================================
// This shader handles the pixel output for mob eyes.
// Eyes are typically rendered with full brightness regardless
// of ambient lighting, making them visible in the dark.
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
