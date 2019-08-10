// Examples of optional usage.
const std = @import("std");
const warn = std.debug.warn;

// This is main.
// We are using a function which can fail (out of memory).
// No error handling yet, so we need to
//     * add the exclamation point to the return type
//     * add `try` before the function that may fail
pub fn main() !void {
    compileTimeStringConcatExample();
    try runtimeStringConcatExample();
}

pub fn compileTimeStringConcatExample() void {
    const hello_string: []const u8 = "Hello ";
    const concat_string: []const u8 = "compile-time concatenation!";

    const compile_time_concat_string: []const u8 = concatConstant(hello_string, concat_string);
    warn("Compile-time concatenated string: {}\n", compile_time_concat_string);
}

/// To concatenate strings that are compile-time known, we can use ++
/// Need to use the comptime keyword here to convince the compiler to evaluate them.
pub fn concatConstant(comptime a: []const u8, comptime b: []const u8) []const u8 {
    return a ++ b;
}

/// To concatenate strings that are runtime known, we need to think about memory allocation.
/// In this example, since the strings are compile-time known, so we could just use the
/// compile-time strategy in a realistic situation.
pub fn runtimeStringConcatExample() !void {
    var allocator_implementation: std.heap.HeapAllocator = std.heap.HeapAllocator.init();
    const allocator_interface: *std.mem.Allocator = &allocator_implementation.allocator;

    const hello_string: []const u8 = "Hello ";
    const concat_string: []const u8 = "run-time concatenation!";

    const runtime_concat_string: []u8 = try concatVariable(allocator_interface, hello_string, concat_string);
    defer allocator_interface.free(runtime_concat_string);

    warn("Runtime concatenated string: {}\n", runtime_concat_string);
}

/// To concatenate strings that are not compile-time known, we need an allocator.
/// There is really no concept of "strings" as such in Zig itself, just raw bytes.
/// Concatenating then means getting a big enough chunk of memory and copying the bytes
/// from each argument one after the other. We don't know how long the caller needs the
/// bytes we returned, so we should have a comment indicating that free() should be called.
pub fn concatVariable(allocator: *std.mem.Allocator, a: []const u8, b: []const u8) ![]u8 {
    var result = try allocator.alloc(u8, a.len + b.len);
    std.mem.copy(u8, result, a);
    std.mem.copy(u8, result[a.len..], b);
    return result;

    // There is no free here, so the caller is responsible for calling allocator.free() on the result!
}
