// Examples of optional usage.
const std = @import("std");
const warn = std.debug.warn;

// This is main.
pub fn main() void {
    const hello_string: []const u8 = "Hello ";
    const concat_string: []const u8 = "compile-time concatenation!";
    const compile_time_concat_string = hello_string ++ concat_string;
    warn("Compile-time concatenated string: {}\n", compile_time_concat_string);

    // No idea how to build run-time interpolated strings.
    // Seems like a std.mem.Allocator is needed.
}
