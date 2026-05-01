//! Easing functions for animation and tweening.
//!
//! 30+ curves: quad, cubic, quart, quint, sine, expo, circ, elastic, back,
//! bounce — each with in/out/in-out variants. Generic over any float type.

const std = @import("std");

pub fn linear(comptime T: type, t: T) T {
    return t;
}

// --- Quadratic ---

pub fn quadIn(comptime T: type, t: T) T {
    return t * t;
}

pub fn quadOut(comptime T: type, t: T) T {
    return -(t - 1) * (t - 1) + 1;
}

pub fn quadInOut(comptime T: type, t: T) T {
    if (t < 0.5) return 2 * t * t;
    return -1 + (4 - 2 * t) * t;
}

// --- Cubic ---

pub fn cubicIn(comptime T: type, t: T) T {
    return t * t * t;
}

pub fn cubicOut(comptime T: type, t: T) T {
    const t1 = t - 1;
    return t1 * t1 * t1 + 1;
}

pub fn cubicInOut(comptime T: type, t: T) T {
    if (t < 0.5) return 4 * t * t * t;
    const t1 = 2 * t - 2;
    return 0.5 * t1 * t1 * t1 + 1;
}

// --- Quartic ---

pub fn quartIn(comptime T: type, t: T) T {
    return t * t * t * t;
}

pub fn quartOut(comptime T: type, t: T) T {
    const t1 = t - 1;
    return 1 - t1 * t1 * t1 * t1;
}

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

pub fn sineIn(comptime T: type, t: T) T {
    return 1 - @cos(t * std.math.pi / 2);
}

pub fn sineOut(comptime T: type, t: T) T {
    return @sin(t * std.math.pi / 2);
}

pub fn sineInOut(comptime T: type, t: T) T {
    return -0.5 * (@cos(std.math.pi * t) - 1);
}

// --- Exponential ---

pub fn expoIn(comptime T: type, t: T) T {
    if (t == 0) return 0;
    return std.math.pow(T, 2, 10 * (t - 1));
}

pub fn expoOut(comptime T: type, t: T) T {
    if (t == 1) return 1;
    return 1 - std.math.pow(T, 2, -10 * t);
}

pub fn expoInOut(comptime T: type, t: T) T {
    if (t == 0) return 0;
    if (t == 1) return 1;
    if (t < 0.5) return 0.5 * std.math.pow(T, 2, 20 * t - 10);
    return 1 - 0.5 * std.math.pow(T, 2, -20 * t + 10);
}

// --- Circular ---

pub fn circIn(comptime T: type, t: T) T {
    return 1 - @sqrt(1 - t * t);
}

pub fn circOut(comptime T: type, t: T) T {
    const t1 = t - 1;
    return @sqrt(1 - t1 * t1);
}

pub fn circInOut(comptime T: type, t: T) T {
    if (t < 0.5) return 0.5 * (1 - @sqrt(1 - 4 * t * t));
    const t1 = 2 * t - 2;
    return 0.5 * (@sqrt(1 - t1 * t1) + 1);
}

// --- Elastic ---

pub fn elasticIn(comptime T: type, t: T) T {
    if (t == 0) return 0;
    if (t == 1) return 1;
    return -std.math.pow(T, 2, 10 * (t - 1)) * @sin((10 * t - 10.75) * (2 * std.math.pi) / 3);
}

pub fn elasticOut(comptime T: type, t: T) T {
    if (t == 0) return 0;
    if (t == 1) return 1;
    return std.math.pow(T, 2, -10 * t) * @sin((10 * t - 0.75) * (2 * std.math.pi) / 3) + 1;
}

pub fn elasticInOut(comptime T: type, t: T) T {
    if (t == 0) return 0;
    if (t == 1) return 1;
    if (t < 0.5) return -0.5 * std.math.pow(T, 2, 20 * t - 10) * @sin((20 * t - 11.125) * (2 * std.math.pi) / 4.5);
    return 0.5 * std.math.pow(T, 2, -20 * t + 10) * @sin((20 * t - 11.125) * (2 * std.math.pi) / 4.5) + 1;
}

// --- Back ---

pub fn backIn(comptime T: type, t: T) T {
    const s: T = 1.70158;
    return t * t * ((s + 1) * t - s);
}

pub fn backOut(comptime T: type, t: T) T {
    const s: T = 1.70158;
    const t1 = t - 1;
    return t1 * t1 * ((s + 1) * t1 + s) + 1;
}

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

pub fn bounceIn(comptime T: type, t: T) T {
    return 1 - bounceOut(T, 1 - t);
}

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
