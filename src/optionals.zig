const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    nulledStringExample();
}

pub fn nulledStringExample() void {
    var optional_string_null: ?[]const u8 = null;
    var optional_string_non_null: ?[]const u8 = "non-null";

    print("\nExamples with optional values.\n", .{});
    detectNull(optional_string_null);
    detectNull(optional_string_non_null);
}

pub fn detectNull(optional_value: ?[]const u8) void {
    if (optional_value) |value| {
        print("value is guaranteed not null in this branch, is: '{s}'\n", .{ value });
    } else {
        print("optional_value is guaranteed null in this branch, is: {any}\n", .{ optional_value });
    }
}
