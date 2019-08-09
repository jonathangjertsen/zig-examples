// Examples of integer usage.
const std = @import("std");
const warn = std.debug.warn;

// This is main.
pub fn main() void {
    // Integer
    const integer: i32 = 1;
    warn("Integer: {}\n", integer);
}
