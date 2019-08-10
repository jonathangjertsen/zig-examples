const std = @import("std");
const warn = std.debug.warn;

pub fn main() void {
    vectorExample();
}

pub fn vectorExample() void {
    const vector_1: @Vector(4, u8) = [4]u8{ 'A', 'B', 'C', 'D' };
    const vector_2: @Vector(4, u8) = [4]u8{ 1, 1, 1, 1 };
    const vector_sum = vector_1 + vector_2;

    // Casting back to array.
    // Needed here since the formatter can't do vectors at the moment.
    const array_from_vector_1: [4]u8 = vector_1;
    const array_from_vector_2: [4]u8 = vector_2;
    const array_from_vector_sum: [4]u8 = vector_sum;

    warn("Vector 1: {}\n", array_from_vector_1);
    warn("Vector 2: {}\n", array_from_vector_2);
    warn("Vector 1 + Vector 2: {}\n", array_from_vector_sum);
}
