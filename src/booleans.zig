const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    literalBooleansExample();
    logicalOperatorExample();
}

pub fn literalBooleansExample() void {
    print("\nExamples of using boolean literals.\n", .{});
    print("False: {}\n", .{ false });
    print("True: {}\n", .{ true });
}

pub fn logicalOperatorExample() void {
    const false_value: bool = false;
    const true_value: bool = false;

    print("\nExamples of operators on booleans.\n", .{ });
    print("NOT false: {}\n", .{ !false_value });
    print("True AND false: {}\n", .{ true_value and false_value });
    print("True OR false: {}\n", .{ true_value or false_value });
    print("True XOR false: {}\n", .{ true_value != false_value });
}
