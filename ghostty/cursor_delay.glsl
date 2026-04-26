const float DURATION = 0.10; // in seconds

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

    vec2 d = fragCoord.xy - iPreviousCursor.xy;

    float x = step(.0, d.x) * step(d.x, iPreviousCursor.z);
    float y = step(- iPreviousCursor.w, d.y) * step(d.y, .0);

    fragColor = mix(fragColor, iCurrentCursorColor, x * y * (1.0 - progress) * 0.5);
}
