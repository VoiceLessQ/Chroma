#version 120
// ============================================
// Terrain Geometry Shader
// ============================================
// Purpose: Generate terrain geometry effects
// Requires: OpenGL 3.2 or GL_ARB_geometry_shader4
// ============================================
// This geometry shader can be used for:
// - Wind animation on grass and plants
// - Vertex displacement for terrain deformation
// - Procedural geometry generation
// ============================================
#extension GL_ARB_geometry_shader4 : enable

uniform float frameTimeCounter;

varying in vec2 texcoord_v[];
varying in vec4 glcolor_v[];
varying in vec2 lmcoord_v[];
varying out vec2 texcoord_g;
varying out vec4 glcolor_g;
varying out vec2 lmcoord_g;

void main() {
    // Pass through each vertex with optional modification
    for (int i = 0; i < gl_VerticesIn; i++) {
        texcoord_g = texcoord_v[i];
        glcolor_g = glcolor_v[i];
        lmcoord_g = lmcoord_v[i];
        gl_Position = gl_PositionIn[i];
        EmitVertex();
    }
    EndPrimitive();
}
