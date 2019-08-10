const std = @import("std");
const warn = std.debug.warn;

pub fn main() void {
    nulledStringExample();
}

pub fn nulledStringExample() void {
    var optional_string_null: ?[]const u8 = null;
    var optional_string_non_null: ?[]const u8 = "non-null";

    warn("\nExamples with optional values.\n");
    detectNull(optional_string_null);
    detectNull(optional_string_non_null);
}

pub fn detectNull(optional_value: ?[]const u8) void {
    if (optional_value) |value| {
        warn("value is guaranteed not null in this branch, is: {}\n", value);
    } else {
        warn("optional_value is guaranteed null in this branch, is: {}\n", optional_value);
    }
}
