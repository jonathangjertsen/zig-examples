const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    embedExample();
}

pub fn embedExample() void {
    print("\nExample which reads a file at compile time.\n", .{});
    const message: []const u8 = @embedFile("embed-file-example.txt");
    print("Contents of embedded file: {s}\n", .{ message });
}
