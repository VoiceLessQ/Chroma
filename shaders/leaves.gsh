#version 120
// ============================================
// Leaves Geometry Shader
// ============================================
// Purpose: Generate waving leaf geometry
// Requires: OpenGL 3.2 or GL_ARB_geometry_shader4
// ============================================
// This geometry shader can be used to add wind animation
// to leaves by modifying vertex positions based on time
// and world position for natural-looking movement.
// ============================================
#extension GL_ARB_geometry_shader4 : enable

uniform float frameTimeCounter;

varying in vec2 texcoord_v[];
varying in vec4 glcolor_v[];
varying out vec2 texcoord_g;
varying out vec4 glcolor_g;

void main() {
    // Pass through each vertex with optional modification
    for (int i = 0; i < gl_VerticesIn; i++) {
        texcoord_g = texcoord_v[i];
        glcolor_g = glcolor_v[i];
        gl_Position = gl_PositionIn[i];
        EmitVertex();
    }
    EndPrimitive();
}
