const std = @import("std");
const warn = std.debug.warn;

pub fn main() void {
    embedExample();
}

pub fn embedExample() void {
    warn("\nExample which reads a file at compile time.\n");
    const message: []const u8 = @embedFile("../assets/embed-file-example.txt");
    warn("Contents of embedded file: {}\n", message);
}
