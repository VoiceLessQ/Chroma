#version 120
// ============================================
// GBuffers Hand - Player Hand Fragment Shader
// ============================================
// Renders: First-person hand and opaque handheld objects
// Fallback: gbuffers_textured_lit
// ============================================
// This shader handles the pixel output for the player's hand.
// You can apply custom skin tones, lighting, or effects to
// the hand rendering here.
// ============================================
/* DRAWBUFFERS:0 */

uniform sampler2D gtexture;
uniform sampler2D lightmap;

varying vec2 texcoord;
varying vec4 glcolor;
varying vec2 lmcoord;

void main() {
    vec4 color = texture2D(gtexture, texcoord) * glcolor;
    color *= texture2D(lightmap, lmcoord);
    
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = color; // colortex0 (gcolor)
}
