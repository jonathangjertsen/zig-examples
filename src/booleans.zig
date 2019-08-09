// Examples of boolean usage.
const std = @import("std");
const warn = std.debug.warn;

// This is main.
pub fn main() void {
    const false_value: bool = false;
    const true_value: bool = true;

    warn("False: {}\n", false_value);
    warn("True: {}\n", true_value);
    warn("Not false: {}\n", !false_value);
    warn("True and false: {}\n", true_value and false_value);
    warn("True or false: {}\n", true_value or false_value);
}
