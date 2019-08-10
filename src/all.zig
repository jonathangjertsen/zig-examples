const std = @import("std");
const warn = std.debug.warn;

const booleans = @import("booleans.zig");
const floats = @import("floats.zig");
const integers = @import("integers.zig");
const hello = @import("hello.zig");
const optionals = @import("optionals.zig");
const strings = @import("strings.zig");
const structs = @import("structs.zig");

pub fn main() !void {
    hello.main();
    booleans.main();
    integers.main();
    floats.main();
    structs.main();
    try strings.main();
    optionals.main();
}
