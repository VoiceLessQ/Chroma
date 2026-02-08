#version 120
// ============================================
// Deferred 1 - Deferred Rendering Pass 1 Fragment Shader
// ============================================
// Stage: After gbuffer, before composite
// Purpose: First deferred rendering pass
// ============================================
// Available gbuffer inputs:
// - colortex0: Albedo/diffuse color
// - colortex1: Depth/position data
// - colortex2: World normals
// - colortex3-7: Custom data buffers
// - depthtex0: Scene depth
// ============================================
/* DRAWBUFFERS:0 */

uniform sampler2D gtexture;
uniform sampler2D depthtex0;

varying vec2 texcoord;

void main() {
    vec4 color = texture2D(gtexture, texcoord);
    
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = color; // colortex0
}
