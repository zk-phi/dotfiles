// Faded cursor tail for Ghostty v3

// refs:
// - Original: https://github.com/KroneCorylus/ghostty-shader-playground
// - Faded tails: https://gist.github.com/reshen/991d19f9f8c8fedf64ff726f05f05f44
// - Fix for straight moves: https://github.com/sahaj-b/ghostty-cursor-shaders/blob/main/cursor_tail.glsl

const float DURATION = 0.06; // IN SECONDS
const float TRAIL_MAX_OPACITY = 0.5;

// ---- Easing functions

// Linear
float ease(float x) {
    return x;
}

// // EaseOutQuad
// float ease(float x) {
//     return 1.0 - (1.0 - x) * (1.0 - x);
// }

// // EaseOutCubic
// float ease(float x) {
//     return 1.0 - pow(1.0 - x, 3.0);
// }


// // EaseOutQuart
// float ease(float x) {
//     return 1.0 - pow(1.0 - x, 4.0);
// }

// // EaseOutQuint
// float ease(float x) {
//     return 1.0 - pow(1.0 - x, 5.0);
// }

// // EaseOutSine
// float ease(float x) {
//     return sin((x * PI) / 2.0);
// }

// // EaseOutExpo
// float ease(float x) {
//     return x == 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * x);
// }

// // EaseOutCirc
// float ease(float x) {
//     return sqrt(1.0 - pow(x - 1.0, 2.0));
// }

// ---- SDFs ----

float getSdfRectangle(in vec2 p, in vec2 xy, in vec2 b) {
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

// Based on Inigo Quilez's 2D distance functions article: https://iquilezles.org/articles/distfunctions2d/
// Potencially optimized by eliminating conditionals and loops to enhance performance and reduce branching

float seg(in vec2 p, in vec2 a, in vec2 b, inout float s, float d) {
    vec2 e = b - a;
    vec2 w = p - a;
    vec2 proj = a + e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
    float segd = dot(p - proj, p - proj);
    d = min(d, segd);

    float c0 = step(0.0, p.y - a.y);
    float c1 = 1.0 - step(0.0, p.y - b.y);
    float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
    float allCond = c0 * c1 * c2;
    float noneCond = (1.0 - c0) * (1.0 - c1) * (1.0 - c2);
    float flip = mix(1.0, -1.0, step(0.5, allCond + noneCond));
    s *= flip;
    return d;
}

float getSdfParallelogram(in vec2 p, in vec2 v0, in vec2 v1, in vec2 v2, in vec2 v3) {
    float s = 1.0;
    float d = dot(p - v0, p - v0);

    d = seg(p, v0, v3, s, d);
    d = seg(p, v1, v0, s, d);
    d = seg(p, v2, v1, s, d);
    d = seg(p, v3, v2, s, d);

    return s * sqrt(d);
}

// ---- CORE ----

vec2 normalize(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

float antialising(float distance) {
    return 1. - smoothstep(0., normalize(vec2(2., 2.), 0.).x, distance);
}

float determineIfTopRightIsLeading(vec2 a, vec2 b) {
    // Conditions using step
    float condition1 = step(b.x, a.x) * step(a.y, b.y); // a.x < b.x && a.y > b.y
    float condition2 = step(a.x, b.x) * step(b.y, a.y); // a.x > b.x && a.y < b.y

    // If neither condition is met, return 1 (else case)
    return 1.0 - max(condition1, condition2);
}

vec2 getRectangleCenter(vec4 rectangle) {
    return vec2(rectangle.x + (rectangle.z / 2.), rectangle.y - (rectangle.w / 2.));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);

    // Normalization for fragCoord to a space of -1 to 1;
    vec2 vu = normalize(fragCoord, 1.);
    vec2 offsetFactor = vec2(-.5, 0.5);

    // Normalization for cursor position and size;
    // cursor xy has the postion in a space of -1 to 1;
    // zw has the width and height
    vec4 currentCursor = vec4(normalize(iCurrentCursor.xy, 1.), normalize(iCurrentCursor.zw, 0.));
    vec4 previousCursor = vec4(normalize(iPreviousCursor.xy, 1.), normalize(iPreviousCursor.zw, 0.));

    // ---- SDF for parallelogram tail (for diagonal move) ----

    // When drawing a parellelogram between cursors for the trail i need to determine where to start at the top-left or top-right vertex of the cursor
    float isTopRightLeading = determineIfTopRightIsLeading(currentCursor.xy, previousCursor.xy);
    float isBottomLeftLeading = 1.0 - isTopRightLeading;

    // Set every vertex of my parellogram
    vec2 v0 = vec2(currentCursor.x + currentCursor.z * isTopRightLeading, currentCursor.y - currentCursor.w);
    vec2 v1 = vec2(currentCursor.x + currentCursor.z * isBottomLeftLeading, currentCursor.y);
    vec2 v2 = vec2(previousCursor.x + currentCursor.z * isBottomLeftLeading, previousCursor.y);
    vec2 v3 = vec2(previousCursor.x + currentCursor.z * isTopRightLeading, previousCursor.y - previousCursor.w);

    float sdfParaTrail = getSdfParallelogram(vu, v0, v1, v2, v3);

    // ---- SDF for rectangular tail (for straight move) ----

    vec2 centerCC = getRectangleCenter(currentCursor);
    vec2 centerCP = getRectangleCenter(previousCursor);

    vec2 minCenter = min(centerCC, centerCP);
    vec2 maxCenter = max(centerCC, centerCP);

    vec2 boxSize = (maxCenter - minCenter) + currentCursor.zw;
    vec2 boxCenter = (minCenter + maxCenter) * 0.5;

    float sdfRectTrail = getSdfRectangle(vu, boxCenter, boxSize * 0.5);

    // ---- Dispatch parallelogram/rectangular tail ----

    float threshold = 0.001;
    vec2 deltaAbs = abs(centerCC - centerCP);
    float isHorizontal = step(deltaAbs.y, threshold);
    float isVertical = step(deltaAbs.x, threshold);
    float isStraightMove = max(isHorizontal, isVertical);

    float sdfTrail = mix(sdfParaTrail, sdfRectTrail, isStraightMove);

    // ---- SDF for the current cursor ----

    float sdfCurrentCursor = getSdfRectangle(vu, currentCursor.xy - (currentCursor.zw * offsetFactor), currentCursor.zw * 0.5);

    // ---- Render tails and the current cursor ----

    // Distance between cursors determine the total length of the parallelogram;
    float lineLength = distance(centerCC, centerCP);

    // Compute fade factor based on distance from the current cursor, along the trail
    float progress = 1.0 - clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0);
    float easedProgress = ease(progress);
    float fadeFactor = clamp(1.0 - smoothstep(lineLength, sdfCurrentCursor, easedProgress * lineLength), 0., TRAIL_MAX_OPACITY);

    // Apply fading effect to trail color
    vec4 fadedTrailColor = mix(fragColor, iCurrentCursorColor, fadeFactor);

    // Blend trail with fade effect
    vec4 newColor =  mix(fragColor, fadedTrailColor, antialising(sdfTrail));

    // Draw current cursor
    newColor = mix(newColor, iCurrentCursorColor , antialising(sdfCurrentCursor));
    newColor = mix(newColor, fragColor, step(sdfCurrentCursor, 0.));
    fragColor = mix(fragColor, newColor, step(sdfCurrentCursor, easedProgress * lineLength));
}
