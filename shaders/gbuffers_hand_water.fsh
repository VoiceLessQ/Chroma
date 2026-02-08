#version 120
// ============================================
// GBuffers Hand Water - Translucent Handheld Fragment Shader
// ============================================
// Renders: Translucent handheld objects (water buckets, potions, etc.)
// Fallback: gbuffers_hand
// ============================================
// This shader handles the pixel output for translucent handheld items.
// You can implement refraction, color tinting, or other transparent
// effects for items like water buckets and potions.
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
