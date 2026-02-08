#version 150
#extension GL_ARB_geometry_shader4 : enable

// Grass geometry shader
// Expands simple quads into more detailed grass blades

// Configuration
const int maxVerticesOut = 6;  // Output up to 6 vertices per input quad

// Inputs from vertex shader
in vec3 vaPosition[];    // Array of vertex positions (4 vertices)
in vec4 vaColor[];       // Array of vertex colors (4 vertices)
in vec2 texcoord[];      // Array of texture coordinates (4 vertices)

// Outputs to fragment shader
out vec4 grassColor;      // Color for each grass blade
out vec2 grassTexCoord;  // Texture coordinates for each grass blade

void main() {
    // Process each input quad (4 vertices)
    for(int i = 0; i < 4; i++) {
        vec3 position = vaPosition[i];
        vec4 color = vaColor[i];
        vec2 tc = texcoord[i];
        
        // Create multiple grass blades from each quad
        for(int blade = 0; blade < 3; blade++) {
            // Add some randomness to grass blade positions
            float offsetX = (blade - 1) * 0.1 + sin(float(blade) * 2.0) * 0.05;
            float offsetZ = cos(float(blade) * 1.5) * 0.05;
            
            // Create slight curve in grass blades
            float curve = sin(float(blade) * 3.14) * 0.2;
            
            // Output grass blade vertices
            gl_Position = gl_ModelViewProjectionMatrix * vec4(
                position.x + offsetX,
                position.y + curve * 0.3,
                position.z + offsetZ,
                1.0
            );
            
            grassColor = color;
            grassTexCoord = tc;
            
            // Emit the vertex
            EmitVertex();
        }
    }
    
    // End the primitive
    EndPrimitive();
}