#version 120
// ============================================
// GBuffers Entities Glowing - Glowing Effect Fragment Shader
// ============================================
// Renders: Glowing entities (entities with glowing effect, spectral arrows)
// Fallback: gbuffers_entities
// ============================================
// This shader handles the pixel output for the glowing effect.
// The glowing outline is typically rendered with a team-colored
// overlay that remains visible even through solid objects.
// ============================================
/* DRAWBUFFERS:0 */

uniform sampler2D gtexture;
uniform sampler2D lightmap;
uniform vec4 entityColor;

varying vec2 texcoord;
varying vec4 glcolor;
varying vec2 lmcoord;

void main() {
    vec4 color = texture2D(gtexture, texcoord) * glcolor;
    color *= texture2D(lightmap, lmcoord);
    
    // entityColor contains the glow color (team color)
    
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = color; // colortex0 (gcolor)
}
