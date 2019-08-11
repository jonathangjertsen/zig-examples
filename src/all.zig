const std = @import("std");
const warn = std.debug.warn;

const allocators = @import("allocators.zig");
const booleans = @import("booleans.zig");
const c_interop = @import("c_interop.zig");
const control_flow = @import("control_flow.zig");
const coroutines = @import("coroutines.zig");
const embed = @import("embed.zig");
const enums = @import("enums.zig");
const floats = @import("floats.zig");
const hello = @import("hello.zig");
const integers = @import("integers.zig");
const optionals = @import("optionals.zig");
const random = @import("random.zig");
const strings = @import("strings.zig");
const structs = @import("structs.zig");
const threads = @import("threads.zig");
const time = @import("time.zig");
const vectors = @import("vectors.zig");

pub fn main() !void {
    hello.main();
    booleans.main();
    integers.main();
    floats.main();
    enums.main();
    control_flow.main();
    structs.main();
    optionals.main();
    vectors.main();
    random.main();
    try time.main();
    try coroutines.main();
    try strings.main();
    try threads.main();
    try allocators.main();

    // This hides a bug which causes the printf() statement to always come last...
    c_interop.main();
}
