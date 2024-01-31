const std = @import("std");
const print = std.debug.print;

const C = @cImport({
    // See https://github.com/ziglang/zig/issues/515
    @cDefine("_NO_CRT_STDIO_INLINE", "1");
    @cInclude("stdio.h");
});

pub fn main() void {
    callCExample();
}

pub fn callCExample() void {
    print("\nExample of calling a C function.\n", .{});
    _ = C.printf("Hello, C!\n");
}
