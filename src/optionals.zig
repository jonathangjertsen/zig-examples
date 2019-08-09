// Examples of optional usage.
const std = @import("std");
const warn = std.debug.warn;

// This is main.
pub fn main() void {
    var optional_string: ?[]const u8 = null;
    warn("Nulled string: {}\n", optional_string);
}
