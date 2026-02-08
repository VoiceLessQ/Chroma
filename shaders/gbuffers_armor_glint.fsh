#version 120
// ============================================
// GBuffers Armor Glint - Enchantment Glint Fragment Shader
// ============================================
// Renders: Enchantment glint overlay on armor and handheld items
// Fallback: gbuffers_textured
// ============================================
// This shader handles the pixel output for the enchantment glint.
// The glint is typically an animated purple/blue overlay that
// shimmers across enchanted items.
// ============================================
/* DRAWBUFFERS:0 */

uniform sampler2D gtexture;
uniform float frameTimeCounter;

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
    vec4 color = texture2D(gtexture, texcoord) * glcolor;
    
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = color; // colortex0 (gcolor)
}
