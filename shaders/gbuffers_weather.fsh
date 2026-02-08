#version 120
// ============================================
// GBuffers Weather - Rain and Snow Fragment Shader
// ============================================
// Renders: Rain drops and snowflakes
// Fallback: gbuffers_textured_lit
// ============================================
// This shader handles the pixel output for weather particles.
// You can customize rain/snow appearance, add motion blur,
// or implement custom weather effects based on rainStrength.
// ============================================
/* DRAWBUFFERS:0 */

uniform sampler2D gtexture;
uniform sampler2D lightmap;
uniform float rainStrength;

varying vec2 texcoord;
varying vec4 glcolor;
varying vec2 lmcoord;

void main() {
    vec4 color = texture2D(gtexture, texcoord) * glcolor;
    color *= texture2D(lightmap, lmcoord);
    
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = color; // colortex0 (gcolor)
}
