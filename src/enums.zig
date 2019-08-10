const std = @import("std");
const warn = std.debug.warn;

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

    warn("\nExample of using an enum.\n");
    warn("Number of colors: {}\n", @intCast(u8, @memberCount(Color)));
    warn("black: {}, ordinal value: {}, is primary: {}\n", black, @enumToInt(black), Color.isPrimaryColor(black));
    warn("red: {}, ordinal value: {}, is primary: {}\n", red, @enumToInt(red), Color.isPrimaryColor(red));
    warn("green: {}, ordinal value: {}, is primary: {}\n", green, @enumToInt(green), Color.isPrimaryColor(green));
    warn("blue: {}, ordinal value: {}, is primary: {}\n", blue, @enumToInt(blue), Color.isPrimaryColor(blue));
}
