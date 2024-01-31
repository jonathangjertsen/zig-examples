const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    signedIntegerExample();
    unsignedIntegerExample();
    wrappingOperationsExample();
    bitTwiddlingExample();
}

pub fn signedIntegerExample() void {
    const signed_int: i32 = -2;

    print("\nExamples of signed integer operations.\n", .{});
    print("signed_int: {}\n", .{ signed_int });
    print("signed_int + 2: {}\n", .{ signed_int + 2 });
    print("signed_int * 2: {}\n", .{ signed_int * 2 });
}

pub fn unsignedIntegerExample() void {
    const unsigned_int: u32 = 2;

    print("\nExamples of unsigned integer operations.\n", .{});
    print("unsigned_int: {}\n", .{ unsigned_int });
    print("unsigned_int + 2: {}\n", .{ unsigned_int + 2 });
    print("unsigned_int * 2: {}\n", .{ unsigned_int * 2 });
}

pub fn wrappingOperationsExample() void {
    var byte: u8 = 130;

    print("\nExample of wrapped operations.\n", .{});
    print("byte: {}\n", .{ byte });
    print("byte +% 130: {}\n", .{ byte +% 130 });
    print("byte -% 130: {}\n", .{ byte -% 130 });
    print("-%byte: {}\n", .{ -%byte });
    print("byte *% 2: {}\n", .{ byte *% 2 });
}

pub fn bitTwiddlingExample() void {
    const a: u8 = 0b10101100;
    const b: u8 = 0b01011100;

    print("\nExample of bitwise operations.\n", .{});
    print("a: {}\n", .{ a });
    print("~a: {}\n", .{ a });
    print("b: {}\n", .{ b });
    print("a & b: {}\n", .{ a & b });
    print("a | b: {}\n", .{ a | b });
    print("a ^ b: {}\n", .{ a ^ b });
    print("a << 1: {}\n", .{ a << 1 });
    print("a >> 1: {}\n", .{ a >> 1 });
}
