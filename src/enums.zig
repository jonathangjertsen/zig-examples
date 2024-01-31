const std = @import("std");
const print = std.debug.print;

const Color = enum(i8) {
    Black = -1,
    Red,
    Green,
    Blue,

    pub fn isPrimaryColor(color: Color) bool {
        switch (color) {
            .Black => return false,
            else => return true,
        }
    }
};

pub fn main() void {
    enumExample();
}

pub fn enumExample() void {
    const black: Color = Color.Black;
    const red: Color = Color.Red;
    const green: Color = .Green;
    const blue: Color = .Blue;

    print("\nExample of using an enum.\n", .{});
    print("Number of colors: {}\n", .{ @typeInfo(Color).Enum.fields.len });
    print("black: {}, ordinal value: {}, is primary: {}\n", .{ black, @intFromEnum(black), Color.isPrimaryColor(black) });
    print("red: {}, ordinal value: {}, is primary: {}\n", .{ red, @intFromEnum(red), Color.isPrimaryColor(red) });
    print("green: {}, ordinal value: {}, is primary: {}\n", .{ green, @intFromEnum(green), Color.isPrimaryColor(green) });
    print("blue: {}, ordinal value: {}, is primary: {}\n", .{ blue, @intFromEnum(blue), Color.isPrimaryColor(blue) });
}
