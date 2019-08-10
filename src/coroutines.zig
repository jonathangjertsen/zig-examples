const std = @import("std");
const warn = std.debug.warn;

var counter: u32 = 0;

pub fn main() !void {
    try coroutineExample();
}

pub fn coroutineExample() !void {
    warn("\nExample of coroutines.\n");
    warn("Counter: {}\n", counter);
    const prom: promise->void = try async<std.debug.global_allocator> coroutine();
    warn("Back in caller after suspending. Counter: {}\n", counter);
    resume prom;
    warn("Back in caller after suspending. Counter: {}\n", counter);
    resume prom;
    warn("Back in caller after suspending. Counter: {}\n", counter);
    cancel prom;
    warn("Cancelled the coroutine. Counter: {}\n", counter);
    resume prom;
    warn("Tried to resume after cancelling. Counter: {}\n", counter);
}

async<*std.mem.Allocator> fn coroutine() void {
    warn("Entered coroutine for the first time.\n");
    while (true) {
        suspend;
        warn("Re-entered coroutine after suspending it.\n");
        counter += 1;
    }
}
