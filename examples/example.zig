const std = @import("std");
const zioease = @import("zioease");

pub fn main() !void {
    std.debug.print("=== zioease example ===\n\n", .{});

    // Easing curves at t=0.5
    std.debug.print("At t=0.5:\n", .{});
    std.debug.print("  linear:  {d:.1}\n", .{zioease.linear(f32, 0.5)});
    std.debug.print("  quadIn:  {d:.2}\n", .{zioease.quadIn(f32, 0.5)});
    std.debug.print("  quadOut: {d:.2}\n", .{zioease.quadOut(f32, 0.5)});
    std.debug.print("  cubicIn: {d:.2}\n", .{zioease.cubicIn(f32, 0.5)});
    std.debug.print("  sineOut: {d:.2}\n", .{zioease.sineOut(f32, 0.5)});

    // Elastic overshoots — great for bouncy UI
    std.debug.print("\nElastic at t=0.4: {d:.3} (overshoots past 1!)\n", .{zioease.elasticOut(f32, 0.4)});

    // Bounce — ball landing effect
    std.debug.print("Bounce at t=0.6: {d:.3}\n", .{zioease.bounceOut(f32, 0.6)});

    // Use f64 for precision
    std.debug.print("\nf64 precision: {d:.6}\n", .{zioease.quartInOut(f64, 0.25)});

    std.debug.print("\nDone!\n", .{});
}
