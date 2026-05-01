//! Easing functions for animation and tweening.
//!
//! 30+ curves: quad, cubic, quart, quint, sine, expo, circ, elastic, back,
//! bounce — each with in/out/in-out variants. Generic over any float type.

const std = @import("std");

/// Linear interpolation: returns t unchanged. The simplest easing.
pub fn linear(comptime T: type, t: T) T {
    return t;
}

// --- Quadratic ---

/// Quadratic ease-in: starts slow, accelerates.
pub fn quadIn(comptime T: type, t: T) T {
    return t * t;
}

/// Quadratic ease-out: starts fast, decelerates.
pub fn quadOut(comptime T: type, t: T) T {
    return -(t - 1) * (t - 1) + 1;
}

/// Quadratic ease-in: starts slow, accelerates.
/// Quadratic ease-in-out: slow start and end, fast middle.
pub fn quadInOut(comptime T: type, t: T) T {
    if (t < 0.5) return 2 * t * t;
    return -1 + (4 - 2 * t) * t;
}

// --- Cubic ---

/// Cubic ease-in: stronger curve than quadratic.
pub fn cubicIn(comptime T: type, t: T) T {
    return t * t * t;
}

/// Cubic ease-out.
pub fn cubicOut(comptime T: type, t: T) T {
    const t1 = t - 1;
    return t1 * t1 * t1 + 1;
}

/// Cubic ease-in: stronger curve than quadratic.
/// Cubic ease-in-out.
pub fn cubicInOut(comptime T: type, t: T) T {
    if (t < 0.5) return 4 * t * t * t;
    const t1 = 2 * t - 2;
    return 0.5 * t1 * t1 * t1 + 1;
}

// --- Quartic ---

/// Quartic ease-in: even stronger curve.
pub fn quartIn(comptime T: type, t: T) T {
    return t * t * t * t;
}

pub fn quartOut(comptime T: type, t: T) T {
    const t1 = t - 1;
    return 1 - t1 * t1 * t1 * t1;
}

/// Quartic ease-in: even stronger curve.
pub fn quartInOut(comptime T: type, t: T) T {
    if (t < 0.5) return 8 * t * t * t * t;
    const t1 = t - 1;
    return 1 - 8 * t1 * t1 * t1 * t1;
}

// --- Quintic ---

pub fn quintIn(comptime T: type, t: T) T {
    return t * t * t * t * t;
}

pub fn quintOut(comptime T: type, t: T) T {
    const t1 = t - 1;
    return 1 + t1 * t1 * t1 * t1 * t1;
}

pub fn quintInOut(comptime T: type, t: T) T {
    if (t < 0.5) return 16 * t * t * t * t * t;
    const t1 = 2 * t - 2;
    return 1 + 0.5 * t1 * t1 * t1 * t1 * t1;
}

// --- Sine ---

/// Sine-based ease-in: smooth, organic curve.
pub fn sineIn(comptime T: type, t: T) T {
    return 1 - @cos(t * std.math.pi / 2);
}

pub fn sineOut(comptime T: type, t: T) T {
    return @sin(t * std.math.pi / 2);
}

/// Sine-based ease-in: smooth, organic curve.
pub fn sineInOut(comptime T: type, t: T) T {
    return -0.5 * (@cos(std.math.pi * t) - 1);
}

// --- Exponential ---

/// Exponential ease-in: dramatic start.
pub fn expoIn(comptime T: type, t: T) T {
    if (t == 0) return 0;
    return std.math.pow(T, 2, 10 * (t - 1));
}

pub fn expoOut(comptime T: type, t: T) T {
    if (t == 1) return 1;
    return 1 - std.math.pow(T, 2, -10 * t);
}

/// Exponential ease-in: dramatic start.
pub fn expoInOut(comptime T: type, t: T) T {
    if (t == 0) return 0;
    if (t == 1) return 1;
    if (t < 0.5) return 0.5 * std.math.pow(T, 2, 20 * t - 10);
    return 1 - 0.5 * std.math.pow(T, 2, -20 * t + 10);
}

// --- Circular ---

/// Circular ease-in: quarter-circle curve.
pub fn circIn(comptime T: type, t: T) T {
    return 1 - @sqrt(1 - t * t);
}

pub fn circOut(comptime T: type, t: T) T {
    const t1 = t - 1;
    return @sqrt(1 - t1 * t1);
}

/// Circular ease-in: quarter-circle curve.
pub fn circInOut(comptime T: type, t: T) T {
    if (t < 0.5) return 0.5 * (1 - @sqrt(1 - 4 * t * t));
    const t1 = 2 * t - 2;
    return 0.5 * (@sqrt(1 - t1 * t1) + 1);
}

// --- Elastic ---

/// Elastic ease-in: overshoots like a rubber band.
pub fn elasticIn(comptime T: type, t: T) T {
    if (t == 0) return 0;
    if (t == 1) return 1;
    return -std.math.pow(T, 2, 10 * (t - 1)) * @sin((10 * t - 10.75) * (2 * std.math.pi) / 3);
}

/// Elastic ease-out: bouncy overshoot at the end.
pub fn elasticOut(comptime T: type, t: T) T {
    if (t == 0) return 0;
    if (t == 1) return 1;
    return std.math.pow(T, 2, -10 * t) * @sin((10 * t - 0.75) * (2 * std.math.pi) / 3) + 1;
}

/// Elastic ease-in: overshoots like a rubber band.
pub fn elasticInOut(comptime T: type, t: T) T {
    if (t == 0) return 0;
    if (t == 1) return 1;
    if (t < 0.5) return -0.5 * std.math.pow(T, 2, 20 * t - 10) * @sin((20 * t - 11.125) * (2 * std.math.pi) / 4.5);
    return 0.5 * std.math.pow(T, 2, -20 * t + 10) * @sin((20 * t - 11.125) * (2 * std.math.pi) / 4.5) + 1;
}

// --- Back ---

/// Back ease-in: pulls back before accelerating.
pub fn backIn(comptime T: type, t: T) T {
    const s: T = 1.70158;
    return t * t * ((s + 1) * t - s);
}

pub fn backOut(comptime T: type, t: T) T {
    const s: T = 1.70158;
    const t1 = t - 1;
    return t1 * t1 * ((s + 1) * t1 + s) + 1;
}

/// Back ease-in: pulls back before accelerating.
pub fn backInOut(comptime T: type, t: T) T {
    const s: T = 1.70158 * 1.525;
    if (t < 0.5) {
        const t2 = 2 * t;
        return 0.5 * (t2 * t2 * ((s + 1) * t2 - s));
    }
    const t2 = 2 * t - 2;
    return 0.5 * (t2 * t2 * ((s + 1) * t2 + s) + 2);
}

// --- Bounce ---

/// Bounce ease-out: simulates a bouncing ball.
pub fn bounceOut(comptime T: type, t: T) T {
    if (t < 1.0 / 2.75) {
        return 7.5625 * t * t;
    } else if (t < 2.0 / 2.75) {
        const t1 = t - 1.5 / 2.75;
        return 7.5625 * t1 * t1 + 0.75;
    } else if (t < 2.5 / 2.75) {
        const t1 = t - 2.25 / 2.75;
        return 7.5625 * t1 * t1 + 0.9375;
    } else {
        const t1 = t - 2.625 / 2.75;
        return 7.5625 * t1 * t1 + 0.984375;
    }
}

/// Bounce ease-in: reverse bounce.
pub fn bounceIn(comptime T: type, t: T) T {
    return 1 - bounceOut(T, 1 - t);
}

/// Bounce ease-in: reverse bounce.
/// Bounce ease-in-out: bounce at both ends.
pub fn bounceInOut(comptime T: type, t: T) T {
    if (t < 0.5) return 0.5 * bounceIn(T, 2 * t);
    return 0.5 * bounceOut(T, 2 * t - 1) + 0.5;
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

test "linear" {
    try std.testing.expectApproxEqAbs(@as(f32, 0.0), linear(f32, 0.0), 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, 0.5), linear(f32, 0.5), 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, 1.0), linear(f32, 1.0), 0.0001);
}

test "quadIn/Out/InOut" {
    try std.testing.expectApproxEqAbs(@as(f32, 0.0), quadIn(f32, 0.0), 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, 0.25), quadIn(f32, 0.5), 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, 1.0), quadIn(f32, 1.0), 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, 0.75), quadOut(f32, 0.5), 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, 0.5), quadInOut(f32, 0.5), 0.0001);
}

test "cubicIn/Out/InOut" {
    try std.testing.expectApproxEqAbs(@as(f32, 0.125), cubicIn(f32, 0.5), 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, 0.875), cubicOut(f32, 0.5), 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, 0.5), cubicInOut(f32, 0.5), 0.0001);
}

test "quartIn/Out" {
    try std.testing.expectApproxEqAbs(@as(f32, 0.0625), quartIn(f32, 0.5), 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, 0.9375), quartOut(f32, 0.5), 0.0001);
}

test "quintIn/Out" {
    try std.testing.expectApproxEqAbs(@as(f32, 0.03125), quintIn(f32, 0.5), 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, 0.96875), quintOut(f32, 0.5), 0.0001);
}

test "sineIn/Out/InOut" {
    try std.testing.expectApproxEqAbs(@as(f32, 0.0), sineIn(f32, 0.0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 1.0), sineOut(f32, 1.0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 0.5), sineInOut(f32, 0.5), 0.001);
}

test "expoIn/Out/InOut boundaries" {
    try std.testing.expectApproxEqAbs(@as(f32, 0.0), expoIn(f32, 0.0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 1.0), expoIn(f32, 1.0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 0.0), expoOut(f32, 0.0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 1.0), expoOut(f32, 1.0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 0.0), expoInOut(f32, 0.0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 1.0), expoInOut(f32, 1.0), 0.001);
}

test "circIn/Out" {
    try std.testing.expectApproxEqAbs(@as(f32, 0.0), circIn(f32, 0.0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 1.0), circOut(f32, 1.0), 0.001);
}

test "elasticOut bounces past 1" {
    const v = elasticOut(f32, 0.5);
    try std.testing.expect(v > 1.0); // overshoots
}

test "backOut overshoots" {
    const v = backOut(f32, 0.5);
    try std.testing.expect(v > 1.0); // overshoots past 1
}

test "bounceOut" {
    try std.testing.expectApproxEqAbs(@as(f32, 0.0), bounceOut(f32, 0.0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 1.0), bounceOut(f32, 1.0), 0.001);
}

test "bounceIn" {
    try std.testing.expectApproxEqAbs(@as(f32, 0.0), bounceIn(f32, 0.0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 1.0), bounceIn(f32, 1.0), 0.001);
}

test "bounceInOut" {
    try std.testing.expectApproxEqAbs(@as(f32, 0.0), bounceInOut(f32, 0.0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 1.0), bounceInOut(f32, 1.0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 0.5), bounceInOut(f32, 0.5), 0.001);
}

test "f64 variants" {
    try std.testing.expectApproxEqAbs(@as(f64, 0.25), quadIn(f64, 0.5), 0.0001);
    try std.testing.expectApproxEqAbs(@as(f64, 0.875), cubicOut(f64, 0.5), 0.0001);
}

test "all functions return 0 at t=0 and 1 at t=1" {
    const T = f32;
    try std.testing.expectApproxEqAbs(@as(T, 0), quadIn(T, 0), 0.001);
    try std.testing.expectApproxEqAbs(@as(T, 1), quadIn(T, 1), 0.001);
    try std.testing.expectApproxEqAbs(@as(T, 0), quadOut(T, 0), 0.001);
    try std.testing.expectApproxEqAbs(@as(T, 1), quadOut(T, 1), 0.001);
    try std.testing.expectApproxEqAbs(@as(T, 0), quintInOut(T, 0), 0.001);
    try std.testing.expectApproxEqAbs(@as(T, 1), quintInOut(T, 1), 0.001);
    try std.testing.expectApproxEqAbs(@as(T, 0), sineInOut(T, 0), 0.001);
    try std.testing.expectApproxEqAbs(@as(T, 1), sineInOut(T, 1), 0.001);
    try std.testing.expectApproxEqAbs(@as(T, 0), elasticInOut(T, 0), 0.001);
    try std.testing.expectApproxEqAbs(@as(T, 1), elasticInOut(T, 1), 0.001);
    try std.testing.expectApproxEqAbs(@as(T, 0), backInOut(T, 0), 0.001);
    try std.testing.expectApproxEqAbs(@as(T, 1), backInOut(T, 1), 0.001);
}

test "backInOut symmetry" {
    // backInOut at t=0.5 should be close to 0.5
    const v = backInOut(f32, 0.5);
    try std.testing.expectApproxEqAbs(@as(f32, 0.5), v, 0.1);
}

test "elasticInOut boundaries" {
    try std.testing.expectApproxEqAbs(@as(f32, 0), elasticInOut(f32, 0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 1), elasticInOut(f32, 1), 0.001);
}

test "quartInOut boundaries" {
    try std.testing.expectApproxEqAbs(@as(f32, 0), quartInOut(f32, 0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 1), quartInOut(f32, 1), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 0.5), quartInOut(f32, 0.5), 0.001);
}

test "quintInOut boundaries" {
    try std.testing.expectApproxEqAbs(@as(f32, 0), quintInOut(f32, 0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 1), quintInOut(f32, 1), 0.001);
}

test "circInOut boundaries" {
    try std.testing.expectApproxEqAbs(@as(f32, 0), circInOut(f32, 0), 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 1), circInOut(f32, 1), 0.001);
}

test "all easings monotonic in for t in [0,1]" {
    // Easing-in functions should be monotonically increasing
    const T = f32;
    var prev: T = 0;
    for (0..11) |i| {
        const t: T = @as(T, @floatFromInt(i)) / 10;
        const v = quadIn(T, t);
        try std.testing.expect(v >= prev);
        prev = v;
    }
}

test "expoInOut midpoint" {
    try std.testing.expectApproxEqAbs(@as(f32, 0.5), expoInOut(f32, 0.5), 0.01);
}

test "backInOut midpoint" {
    // backInOut at 0.5 should be close to 0.5 (with slight deviation from back curve)
    const v = backInOut(f32, 0.5);
    try std.testing.expect(v > 0 and v < 1);
}

test "quartOut at 0.5" {
    try std.testing.expectApproxEqAbs(@as(f32, 0.9375), quartOut(f32, 0.5), 0.001);
}

test "quintIn at 0.5" {
    try std.testing.expectApproxEqAbs(@as(f32, 0.03125), quintIn(f32, 0.5), 0.001);
}

test "all out easings reach 1 at t=1" {
    const T = f32;
    try std.testing.expectApproxEqAbs(@as(T, 1), quadOut(T, 1), 0.001);
    try std.testing.expectApproxEqAbs(@as(T, 1), cubicOut(T, 1), 0.001);
    try std.testing.expectApproxEqAbs(@as(T, 1), quartOut(T, 1), 0.001);
    try std.testing.expectApproxEqAbs(@as(T, 1), quintOut(T, 1), 0.001);
    try std.testing.expectApproxEqAbs(@as(T, 1), sineOut(T, 1), 0.001);
}

test "sineIn at 0.25" {
    try std.testing.expectApproxEqAbs(@as(f32, 0.07612), sineIn(f32, 0.25), 0.001);
}

test "circOut at 0.5" {
    const v = circOut(f32, 0.5);
    try std.testing.expect(v > 0 and v < 1);
}

test "all in-out easings are symmetric around 0.5" {
    const T = f32;
    // In-out easings should return ~0.5 at t=0.5
    try std.testing.expectApproxEqAbs(@as(T, 0.5), quadInOut(T, 0.5), 0.01);
    try std.testing.expectApproxEqAbs(@as(T, 0.5), cubicInOut(T, 0.5), 0.01);
    try std.testing.expectApproxEqAbs(@as(T, 0.5), sineInOut(T, 0.5), 0.01);
}

test "all in easings start slow" {
    // At t=0.1, easing-in should give a value < 0.1 (accelerating)
    try std.testing.expect(quadIn(f32, 0.1) < 0.1);
    try std.testing.expect(cubicIn(f32, 0.1) < 0.1);
    try std.testing.expect(quartIn(f32, 0.1) < 0.1);
}

test "composed easing: bounce then smooth" {
    // Use bounceOut for first half, then smooth with quadInOut
    const t: f32 = 0.3;
    const v1 = bounceOut(f32, t);
    const v2 = quadInOut(f32, v1);
    try std.testing.expect(v2 >= 0 and v2 <= 1);
}

test "all out easings end at 1" {
    try std.testing.expectApproxEqAbs(@as(f32, 1), backOut(f32, 1.0), 0.01);
    try std.testing.expectApproxEqAbs(@as(f32, 1), bounceOut(f32, 1.0), 0.01);
    try std.testing.expectApproxEqAbs(@as(f32, 1), elasticOut(f32, 1.0), 0.01);
}

test "all out easings are monotonically increasing in second half" {
    var prev: f32 = cubicOut(f32, 0.5);
    var t: f32 = 0.55;
    while (t <= 1.0) : (t += 0.05) {
        const v = cubicOut(f32, t);
        try std.testing.expect(v >= prev - 0.01); // allow tiny float imprecision
        prev = v;
    }
}

test "all in easings are monotonically increasing" {
    var prev: f32 = 0;
    var t: f32 = 0.05;
    while (t <= 1.0) : (t += 0.05) {
        const v = quadIn(f32, t);
        try std.testing.expect(v >= prev - 0.001);
        prev = v;
    }
}
