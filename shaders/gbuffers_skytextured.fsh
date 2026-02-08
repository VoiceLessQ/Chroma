#version 120
// ============================================
// GBuffers Sky Textured - Sun and Moon Fragment Shader
// ============================================
// Renders: Sun and moon textures
// Fallback: gbuffers_textured
// ============================================
// This shader handles the pixel output for the sun and moon.
// You can apply custom colors, gradients, or effects to the
// celestial bodies here.
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
