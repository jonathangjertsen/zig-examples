const std = @import("std");
const warn = std.debug.warn;

const ExampleStruct = struct {
    x: i32,
    y: i32,

    pub fn zero() ExampleStruct {
        return ExampleStruct{
            .x = 0,
            .y = 0,
        };
    }
};

pub fn main() void {
    structCreationExample();
}

pub fn structCreationExample() void {
    const zero: ExampleStruct = ExampleStruct.zero();

    warn("\nExample of struct creation.\n");
    warn("Zeroed ExampleStruct: {}\n", zero);
}
