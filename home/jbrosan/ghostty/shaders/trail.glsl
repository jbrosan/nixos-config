void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // 1. Get the current terminal pixel color
    vec2 uv = fragCoord / iResolution.xy;
    vec4 terminalColor = texture(iChannel0, uv);

    // 2. Track the cursor (iCursor.xy provides the pixel coordinates)
    float dist = distance(fragCoord, iCursor.xy);

    // 3. Create the "Tail" logic
    // We use iTime to make it pulse or shimmer slightly
    float intensity = exp(-dist * 0.04); 
    
    // Arch Blue color scheme
    vec3 blueTrail = vec3(0.09, 0.57, 0.82) * intensity;

    // 4. Mix the trail with the text
    fragColor = terminalColor + vec4(blueTrail, 1.0);
}
