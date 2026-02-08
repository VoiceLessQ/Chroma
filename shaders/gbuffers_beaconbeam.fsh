#version 120
// ============================================
// GBuffers Beacon Beam - Beacon Beam Fragment Shader
// ============================================
// Renders: Beacon light beam
// Fallback: gbuffers_textured
// ============================================
// This shader handles the pixel output for beacon beams.
// You can add glow effects, animated textures, or color
// modifications based on the beacon's tier/mineral.
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
