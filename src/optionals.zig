const std = @import("std");
const warn = std.debug.warn;

pub fn main() void {
    nulledStringExample();
}

pub fn nulledStringExample() void {
    var optional_string: ?[]const u8 = null;

    warn("\nExamples with optional values.\n");
    warn("Nulled string: {}\n", optional_string);
}
