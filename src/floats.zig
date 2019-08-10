const std = @import("std");
const warn = std.debug.warn;

pub fn main() void {
    floatExample();
}

pub fn floatExample() void {
    const float: f32 = -1.23 + 83.1;

    warn("\nExamples of using floats.\n");
    warn("Float: {}\n", float);
}
