#version 120
// ============================================
// GBuffers Block - Block Entities Fragment Shader
// ============================================
// Renders: Block entities (chests, signs, banners, beds, etc.)
// Fallback: gbuffers_terrain
// ============================================
// This shader handles the pixel output for block entities.
// You can apply custom lighting, reflections, or effects to
// specific block entity types using blockEntityId uniform.
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
