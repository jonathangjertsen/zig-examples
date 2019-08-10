const std = @import("std");
const warn = std.debug.warn;

pub fn main() void {
    literalBooleansExample();
    logicalOperatorExample();
}

pub fn literalBooleansExample() void {
    warn("\nExamples of using boolean literals.\n");
    warn("False: {}\n", false);
    warn("True: {}\n", true);
}

pub fn logicalOperatorExample() void {
    const false_value: bool = false;
    const true_value: bool = false;

    warn("\nExamples of operators on booleans.\n");
    warn("NOT false: {}\n", !false_value);
    warn("True AND false: {}\n", true_value and false_value);
    warn("True OR false: {}\n", true_value or false_value);
    warn("True XOR false: {}\n", true_value != false_value);
}
