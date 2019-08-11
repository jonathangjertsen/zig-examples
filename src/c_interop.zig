const std = @import("std");
const warn = std.debug.warn;

const C = @cImport({
    // See https://github.com/ziglang/zig/issues/515
    @cDefine("_NO_CRT_STDIO_INLINE", "1");
    @cInclude("stdio.h");
});

pub fn main() void {
    warn("\nExample of calling a C function.\n");
    _ = C.printf(c"Hello, C!\n");
}