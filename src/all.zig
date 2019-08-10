const std = @import("std");
const warn = std.debug.warn;

const booleans = @import("booleans.zig");
const floats = @import("floats.zig");
const integers = @import("integers.zig");
const hello = @import("hello.zig");
const optionals = @import("optionals.zig");
const strings = @import("strings.zig");
const structs = @import("structs.zig");
const threads = @import("threads.zig");

pub fn main() !void {
    hello.main();
    booleans.main();
    integers.main();
    floats.main();
    structs.main();
    optionals.main();
    try strings.main();
    try threads.main();
}
