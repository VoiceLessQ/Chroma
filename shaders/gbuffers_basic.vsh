#version 120
// ============================================
// GBuffers Basic - Basic Geometry Vertex Shader
// ============================================
// Renders: Leash lines, block selection box (no fallback)
// ============================================
// This is the most basic shader program. It renders simple
// geometry without textures or complex lighting. Used for
// leash lines (lead to mob) and the block selection highlight.
// ============================================

varying vec4 glcolor;

void main() {
    glcolor = gl_Color;
    
    gl_Position = ftransform();
}
