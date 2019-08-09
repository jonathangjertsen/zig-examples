// Examples of integer usage.
const std = @import("std");
const warn = std.debug.warn;

// This is main.
pub fn main() void {
    // Signed integer
    const signed_int: i32 = 9 - 7;
    warn("Integer: {}\n", signed_int);

    // Unsigned integer
    var unsigned_int: u32 = 1;
    unsigned_int -= 9;
    warn("Unsigned integer: {}\n", unsigned_int);
}
