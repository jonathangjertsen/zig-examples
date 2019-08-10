const std = @import("std");
const builtin = @import("builtin");
const warn = std.debug.warn;

const StructExample = struct {
    x: i32,
    y: i32,

    pub fn zero() StructExample {
        return StructExample{
            .x = 0,
            .y = 0,
        };
    }
};

const PackedStructExample = packed struct {
    five_bits: u5,
    two_bits: u2,
    one_bit: u1,

    pub fn from_byte(byte: u8) PackedStructExample {
        // This seems platform dependent.
        return PackedStructExample{
            .one_bit = @intCast(u1, (byte & 0b10000000) >> 7),
            .two_bits = @intCast(u2, (byte & 0b01100000) >> 5),
            .five_bits = @intCast(u5, (byte & 0b00011111)),
        };
    }
};

pub fn main() void {
    structCreationExample();
    packedStructExample();
}

pub fn structCreationExample() void {
    const zero: StructExample = StructExample.zero();

    warn("\nExample of struct creation.\n");
    warn("Zeroed StructExample: {}\n", zero);
}

pub fn packedStructExample() void {
    const bitfield_value: u8 = 0b10101011;
    const bitfield: PackedStructExample = PackedStructExample.from_byte(bitfield_value);

    warn("\nExample of using a packed struct.\n");
    warn("Byte: {b}\n", @intCast(u8, bitfield_value)); // Cast due to compiler bug
    warn("Resulting bitfield: {}\n", bitfield);
    warn("Bits of the bitfield after bit-casting to byet: {b}\n", @bitCast(u8, bitfield));
}
