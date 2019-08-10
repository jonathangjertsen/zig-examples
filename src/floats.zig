const std = @import("std");
const warn = std.debug.warn;

pub fn main() void {
    floatLiteralsExample();
    floatFormattingExample();
}

pub fn floatLiteralsExample() void {
    // There is a compiler bug that prevents us from putting floats directly into warn(): https://github.com/ziglang/zig/issues/557
    // Use f32 for now.
    const float_with_dot: f32 = 1.0;
    const float_no_dot: f32 = 1;
    const float_with_e: f32 = 1E+0;
    const float_with_p: f32 = 0x1P0;

    warn("\nExamples of using float literals.\n");
    warn("Float literal declared with dot: {}\n", float_with_dot);
    warn("Float literal declared like an integer: {}\n", float_no_dot);
    warn("Float literal declared in scientific notation: {}\n", float_with_e);
    warn("Float literal declared in hex scientific notation: {}\n", float_with_p);
}

pub fn floatFormattingExample() void {
    // Formatting syntax deduced from the implementation in https://github.com/ziglang/zig/blob/master/std/fmt.zig.
    const float: f32 = 314.15;

    warn("\nExamples of float formatting.\n");
    warn("Default formatting: {}\n", float);
    warn("Scientific notation with 2 significant digits: {e:.2}\n", float);
    warn("Decimal with 2 digits: {d:.2}\n", float);
}
