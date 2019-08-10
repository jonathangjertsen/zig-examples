const std = @import("std");
const warn = std.debug.warn;

// Anything can be passed as the first argument (`context`) to spawn.
// Wrapping it up in a struct seems like a good idea.
var num_threads: u32 = 0;
const CustomThreadContext = struct {
    thread_id: u32,
    number_to_add_to_thread_local_variable: i32,

    pub fn init(number_to_add_to_thread_local_variable: i32) CustomThreadContext {
        num_threads += 1;
        return CustomThreadContext{
            .thread_id = num_threads,
            .number_to_add_to_thread_local_variable = number_to_add_to_thread_local_variable,
        };
    }
};

threadlocal var thread_local_variable: i32 = 1;

pub fn main() !void {
    try threadExample();
}

pub fn threadExample() !void {
    const context_1: CustomThreadContext = CustomThreadContext.init(1);
    const context_2: CustomThreadContext = CustomThreadContext.init(2);

    const thread_1: *std.Thread = try std.Thread.spawn(context_1, threadCallback);
    const thread_2: *std.Thread = try std.Thread.spawn(context_2, threadCallback);

    thread_1.wait();
    thread_2.wait();
}

// Might not be the best idea to print from a thread.
pub fn threadCallback(context: CustomThreadContext) void {
    thread_local_variable += context.number_to_add_to_thread_local_variable;
    warn("From thread #{}: thread_local_variable: {}\n", context.thread_id, thread_local_variable);
}
