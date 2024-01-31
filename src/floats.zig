const std = @import("std");
const builtin = @import("std").builtin;
const print = std.debug.print;

pub fn main() void {
    // https://ziglang.org/documentation/master/#setFloatMode
    // Only affects this scope, so no need to think about what the float mode is in outer scope
    @setFloatMode(builtin.FloatMode.Optimized);

    floatLiteralsExample();
    floatFormattingExample();
}

pub fn floatLiteralsExample() void {
    print("Examples of writing 1.0: {d:.1}, {d:.1}, {d:.1}, {d:.1}\n", .{
        1.0,
        @as(f32, 1),
        1E+0,
        0x1P0
    });
}

pub fn floatFormattingExample() void {
    // Formatting syntax deduced from the implementation in https://github.com/ziglang/zig/blob/master/std/fmt.zig.
    const float: f32 = 314.15;

    print("\nExamples of float formatting.\n", .{});
    print("Default formatting: {e}\n", .{ float });
    print("Scientific notation with 2 significant digits: {e:.2}\n", .{ float });
    print("Decimal with 2 digits: {d:.2}\n", .{ float });
}
