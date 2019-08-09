// Examples of float usage.
const std = @import("std");
const warn = std.debug.warn;

// This is main.
pub fn main() void {
    // Signed integer
    const float: f32 = -1.23 + 83.1;
    warn("Float: {}\n", float);
}
