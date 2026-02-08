#version 150
#extension GL_ARB_geometry_shader4 : enable

// Particle geometry shader
// Expands particles into more complex shapes with rotation and scaling

// Configuration
const int maxVerticesOut = 4;  // Output 4 vertices per input point (quad)

// Inputs from vertex shader
in vec3 vaPosition[];    // Array of vertex positions (1 vertex per particle)
in vec4 vaColor[];       // Array of vertex colors (1 vertex per particle)
in vec2 texcoord[];      // Array of texture coordinates (1 vertex per particle)
in vec3 at_velocity[];   // Velocity information for animation

// Outputs to fragment shader
out vec4 particleColor;  // Color for each particle vertex
out vec2 particleTexCoord;  // Texture coordinates for each particle vertex

void main() {
    // Get particle data (single vertex input)
    vec3 position = vaPosition[0];
    vec4 color = vaColor[0];
    vec2 tc = texcoord[0];
    vec3 velocity = at_velocity[0];
    
    // Calculate particle size based on velocity
    float size = 0.1 + length(velocity) * 0.05;
    
    // Create rotation matrix based on velocity direction
    float angle = atan(velocity.z, velocity.x);
    mat2 rotation = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
    
    // Create quad vertices around the particle center
    vec2 corners[4];
    corners[0] = vec2(-size, -size);
    corners[1] = vec2(size, -size);
    corners[2] = vec2(size, size);
    corners[3] = vec2(-size, size);
    
    // Output rotated and positioned quad vertices
    for(int i = 0; i < 4; i++) {
        // Apply rotation
        vec2 rotatedCorner = rotation * corners[i];
        
        // Calculate final position
        vec3 finalPosition = position + vec3(rotatedCorner.x, 0.0, rotatedCorner.y);
        
        // Set position
        gl_Position = gl_ModelViewProjectionMatrix * vec4(finalPosition, 1.0);
        
        // Pass color and texture coordinates
        particleColor = color;
        particleTexCoord = tc;
        
        // Emit the vertex
        EmitVertex();
    }
    
    // End the primitive (creates a quad)
    EndPrimitive();
}