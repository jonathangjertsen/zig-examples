const std = @import("std");
const builtin = @import("builtin");
const warn = std.debug.warn;

pub fn main() void {
    structCreationExample();
    packedStructExample();
}

pub fn structCreationExample() void {
    comptime const StructExample = struct {
        x: i13,
        y: i10,

        // We could have used StructExample instead of @This() if the
        // struct was defined in the global scope.
        pub fn zero() @This() {
            return @This(){
                .x = 0,
                .y = 0,
            };
        }
    };

    const zero: StructExample = StructExample.zero();

    warn("\nExample of struct creation.\n");
    warn("Zeroed StructExample: {}\n", zero);
    warn("Size of StructExample: {} bytes (corresponding packed struct would be 3 bytes)\n", @intCast(usize, @sizeOf(StructExample)));
}

pub fn packedStructExample() void {
    const PackedStructExample = packed struct {
        five_bits: u5,
        two_bits: u2,
        one_bit: u1,

        pub fn from_byte(byte: u8) @This() {
            return @This(){
                .one_bit = @intCast(u1, (byte & 0b10000000) >> 7),
                .two_bits = @intCast(u2, (byte & 0b01100000) >> 5),
                .five_bits = @intCast(u5, (byte & 0b00011111)),
            };
        }
    };

    const bitfield_value: u8 = 0b10101011;
    const bitfield: PackedStructExample = PackedStructExample.from_byte(bitfield_value);

    warn("\nExample of using a packed struct.\n");
    warn("Byte: {b}\n", @intCast(u8, bitfield_value)); // Cast due to compiler bug
    warn("Resulting bitfield: {}\n", bitfield);
    warn("Bits of the bitfield after bit-casting to byte: {b}\n", @bitCast(u8, bitfield));
    warn("Size of PackedStructExample: {} bytes\n", @intCast(usize, @sizeOf(PackedStructExample)));
}
