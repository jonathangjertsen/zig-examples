const std = @import("std");
const warn = std.debug.warn;

pub fn main() void {
    signedIntegerExample();
    unsignedIntegerExample();
    wrappingOperationsExample();
    bitTwiddlingExample();
}

pub fn signedIntegerExample() void {
    const signed_int: i32 = -2;

    warn("\nExamples of signed integer operations.\n");
    warn("signed_int: {}\n", signed_int);
    warn("signed_int + 2: {}\n", signed_int + 2);
    warn("signed_int * 2: {}\n", signed_int * 2);
}

pub fn unsignedIntegerExample() void {
    const unsigned_int: u32 = 2;

    warn("\nExamples of unsigned integer operations.\n");
    warn("unsigned_int: {}\n", unsigned_int);
    warn("unsigned_int + 2: {}\n", unsigned_int + 2);
    warn("unsigned_int * 2: {}\n", unsigned_int * 2);
}

pub fn wrappingOperationsExample() void {
    var byte: u8 = 130;

    warn("\nExample of wrapped operations.\n");
    warn("byte: {}\n", byte);
    warn("byte +% 130: {}\n", byte +% 130);
    warn("byte -% 130: {}\n", byte -% 130);
    warn("-%byte: {}\n", -%byte);
    warn("byte *% 2: {}\n", byte *% 2);
}

pub fn bitTwiddlingExample() void {
    const a: u8 = 0b10101100;
    const b: u8 = 0b01011100;

    warn("\nExample of bitwise operations.\n");
    warn("a: {}\n", a);
    warn("~a: {}\n", a);
    warn("b: {}\n", b);
    warn("a & b: {}\n", a & b);
    warn("a | b: {}\n", a | b);
    warn("a ^ b: {}\n", a ^ b);
    warn("a << 1: {}\n", a << 1);
    warn("a >> 1: {}\n", a >> 1);
}
