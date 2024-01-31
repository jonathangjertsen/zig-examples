const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    vectorExample();
}

pub fn vectorExample() void {
    const vector_1: @Vector(4, u8) = [4]u8{ 'A', 'B', 'C', 'D' };
    const vector_2: @Vector(4, u8) = [4]u8{ 1, 1, 1, 1 };
    const vector_sum = vector_1 + vector_2;

    print("\nExamples of using vectors.\n", .{});
    print("vector_1: {any}\n", .{ vector_1 });
    print("vector_2: {any}\n", .{ vector_2 });
    print("vector_1 + vector_2: {any}\n", .{ vector_sum });
}
