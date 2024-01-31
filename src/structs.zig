const std = @import("std");
const builtin = @import("builtin");
const print = std.debug.print;

pub fn main() void {
    structCreationExample();
    packedStructExample();
}

pub fn structCreationExample() void {
    const StructExample = struct {
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

    print("\nExample of struct creation.\n", .{});
    print("Zeroed StructExample: {}\n", .{zero});
    print("Size of StructExample: {} bytes (corresponding packed struct would be 3 bytes)\n", .{ @sizeOf(StructExample) });
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
    const bitfield: PackedStructExample = @bitCast(bitfield_value);

    print("\nExample of using a packed struct.\n", .{});
    print("Byte: 0b{b}\n", .{ bitfield_value });
    print("Resulting bitfield: {}\n", .{ bitfield });
    print("Size of PackedStructExample: {} bytes\n", .{ @sizeOf(PackedStructExample) });
}
