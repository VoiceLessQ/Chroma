#version 430

// Compute shader for composite pass
// Runs before composite rendering for pre-processing

// Work group configuration
layout (local_size_x = 16, local_size_y = 16) in;

// Work group size (one per pixel)
const vec2 workGroupsRender = vec2(1.0f, 1.0f);

// Image access - can read/write to color buffers
layout (rgba8) uniform image2D colorimg0;  // colortex0 / gcolor
layout (rgba8) uniform image2D colorimg1;  // colortex1 / gdepth
layout (rgba8) uniform image2D colorimg2;  // colortex2 / gnormal
layout (rgba8) uniform image2D colorimg3;  // colortex3 / composite
layout (rgba8) uniform image2D colorimg4;  // colortex4 / gaux1
layout (rgba8) uniform image2D colorimg5;  // colortex5 / gaux2

// Noise texture for procedural effects
uniform sampler2D noisetex;

// Compute shader main function
void main() {
    // Get pixel coordinates
    ivec2 pixelCoord = ivec2(gl_GlobalInvocationID.xy);
    
    // Get screen dimensions
    ivec2 screenSize = imageSize(colorimg0);
    
    // Ensure we're within screen bounds
    if (pixelCoord.x >= screenSize.x || pixelCoord.y >= screenSize.y) {
        return;
    }
    
    // Sample input data
    vec4 color = imageLoad(colorimg0, pixelCoord);
    vec4 depth = imageLoad(colorimg1, pixelCoord);
    vec4 normal = imageLoad(colorimg2, pixelCoord);
    vec4 composite = imageLoad(colorimg3, pixelCoord);
    vec4 aux1 = imageLoad(colorimg4, pixelCoord);
    vec4 aux2 = imageLoad(colorimg5, pixelCoord);
    
    // Sample noise for procedural effects
    vec2 noiseCoord = vec2(pixelCoord) / vec2(screenSize);
    vec4 noise = texture(noisetex, noiseCoord);
    
    // Compute shader operations
    // Example: Simple color grading based on depth
    float depthFactor = depth.r;
    vec3 gradedColor = color.rgb;
    
    // Add subtle color variation based on noise
    gradedColor += noise.rgb * 0.02;
    
    // Apply depth-based vignette
    vec2 center = vec2(0.5);
    float dist = distance(noiseCoord, center);
    float vignette = 1.0 - smoothstep(0.3, 0.8, dist);
    gradedColor *= vignette;
    
    // Store processed data back to buffers
    imageStore(colorimg0, pixelCoord, vec4(gradedColor, color.a));
    imageStore(colorimg1, pixelCoord, depth);
    imageStore(colorimg2, pixelCoord, normal);
    imageStore(colorimg3, pixelCoord, composite);
    imageStore(colorimg4, pixelCoord, aux1);
    imageStore(colorimg5, pixelCoord, aux2);
}