#version 150
#extension GL_ARB_explicit_attrib_location : enable

// Lit textured fragment shader
// For lit textured rendering (lit particles, emissive elements)

// Uniforms
uniform sampler2D gtexture;    // Main texture sampler
uniform sampler2D lightmap;    // Lightmap sampler
uniform sampler2D normals;     // Normal map sampler
uniform sampler2D specular;   // Specular map sampler
uniform float alphaTestRef;     // Alpha test threshold

// Inputs from vertex shader
in vec2 lmcoord;               // Lightmap coordinates
in vec2 texcoord;              // Texture coordinates
in vec4 tint;                  // Color tint

// Output to color buffer
/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 colortex0Out;

void main() {
    // Sample main texture and apply tint
    vec4 color = texture(gtexture, texcoord) * tint;
    
    // Alpha test - discard transparent pixels below threshold
    if (color.a < alphaTestRef) discard;
    
    // Apply lighting from lightmap
    vec4 lightmapColor = texture(lightmap, lmcoord);
    color.rgb *= lightmapColor.rgb;
    
    // Sample normal and specular maps if available
    vec3 normal = texture(normals, texcoord).rgb * 2.0 - 1.0;
    float specular = texture(specular, texcoord).r;
    
    // Simple specular highlighting
    vec3 viewDir = vec3(0.0, 0.0, 1.0); // Simplified view direction
    vec3 lightDir = normalize(vec3(1.0, 1.0, 1.0)); // Simplified light direction
    
    // Basic diffuse lighting
    float diffuse = max(dot(normal, lightDir), 0.0);
    
    // Basic specular lighting (Phong model)
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32.0);
    vec3 specularHighlight = spec * specular * vec3(1.0);
    
    // Apply lighting
    color.rgb *= (0.3 + 0.7 * diffuse); // Ambient + diffuse
    color.rgb += specularHighlight * 0.5; // Specular
    
    // Output final color
    colortex0Out = color;
}