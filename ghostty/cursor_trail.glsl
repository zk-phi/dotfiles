vec4 TRAIL_COLOR = iCurrentCursorColor;
const float DURATION = 0.04; // in seconds

// --- EASING FUNCTIONS ---
// Taken from https://github.com/sahaj-b/ghostty-cursor-shaders (MIT License)

// Linear
float ease (float x) {
    return x;
}

// // EaseOutQuad
// float ease (float x) {
//     return 1.0 - (1.0 - x) * (1.0 - x);
// }

// // EaseOutCubic
// float ease (float x) {
//     return 1.0 - pow(1.0 - x, 3.0);
// }

// // EaseOutQuart
// float ease (float x) {
//     return 1.0 - pow(1.0 - x, 4.0);
// }

// // EaseOutQuint
// float ease (float x) {
//     return 1.0 - pow(1.0 - x, 5.0);
// }

// // EaseOutSine
// float ease (float x) {
//     return sin((x * PI) / 2.0);
// }

// // EaseOutExpo
// float ease (float x) {
//     return x == 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * x);
// }

// // EaseOutCirc
// float ease (float x) {
//     return sqrt(1.0 - pow(x - 1.0, 2.0));
// }

// --- CORE ---

void mainImage (out vec4 fragColor, in vec2 fragCoord) {
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);

    float progress = clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0);
    progress = ease(progress);

    vec4 curr = iCurrentCursor;
    vec4 trail = mix(iPreviousCursor, iCurrentCursor, progress);

    // +---+ y-w
    // |   |
    // |   |
    // |   |
    // +---+ y
    // x   x+z

    // x <= fragCoord.x < x + z
    float x_trail_p = step(trail.x, fragCoord.x) * step(fragCoord.x, trail.x + trail.z);
    // y - w <= fragCoord.y < y
    float y_trail_p = step(trail.y - trail.w, fragCoord.y) * step(fragCoord.y, trail.y);
    float trail_p = x_trail_p * y_trail_p;

    float x_curr_p = step(curr.x, fragCoord.x) * step(fragCoord.x, curr.x + curr.z);
    float y_curr_p = step(curr.y - curr.w, fragCoord.y) * step(fragCoord.y, curr.y);
    float not_curr_p = abs(1.0 - x_curr_p * y_curr_p);

    fragColor = mix(fragColor, TRAIL_COLOR, trail_p * not_curr_p);
}
