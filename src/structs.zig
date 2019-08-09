// Examples of struct usage.
const std = @import("std");
const warn = std.debug.warn;

/// Struct definition
const TupleXY = struct {
    x: i32,
    y: i32,

    pub fn zero() TupleXY {
        return TupleXY{
            .x = 0,
            .y = 0,
        };
    }
};

// This is main.
pub fn main() void {
    const zero = TupleXY.zero();
    warn("Zeroed TupleXY: {}\n", zero);
}
