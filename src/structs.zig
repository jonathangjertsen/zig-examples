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
        one_bit: u1,
        five_bits: u5,
        two_bits: u2,
    };

    const bitfield_value: u8 = 0b01111010;
    //                                  ^ one_bit    = 0b0
    //                             ^^^^^  five_bits  = 0b11101
    //                           ^^       two_bits   = 0b01
    const bitfield: PackedStructExample = @bitCast(PackedStructExample, bitfield_value);

    warn("\nExample of using a packed struct.\n");
    warn("Byte: {b}\n", @intCast(u8, bitfield_value)); // Cast due to compiler bug
    warn("Resulting bitfield: {}\n", bitfield);
    warn("Size of PackedStructExample: {} bytes\n", @intCast(usize, @sizeOf(PackedStructExample)));
}
