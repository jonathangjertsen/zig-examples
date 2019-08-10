const std = @import("std");
const warn = std.debug.warn;

const fill_value_for_reserved_memory = 0xaa;
const fixed_buffer_size = 10;

pub fn main() !void {
    try fixedBufferAllocatorExample();
}

pub fn fixedBufferAllocatorExample() !void {
    warn("\nExample of using std.heap.FixedBufferAllocator\n");

    var buf: [fixed_buffer_size]u8 = [_]u8{'A'} ** fixed_buffer_size;
    var fixedBufferAllocator: std.heap.FixedBufferAllocator = std.heap.FixedBufferAllocator.init(&buf);
    const allocator: *std.mem.Allocator = &fixedBufferAllocator.allocator;

    try useFixedAllocator(allocator, buf, 1);
    try useFixedAllocator(allocator, buf, 2);
}

pub fn useFixedAllocator(allocator: *std.mem.Allocator, buf: [fixed_buffer_size]u8, num: usize) !void {
    defer warn("Exited #{}. invocation of useFixedAllocator\n", num);

    var pointer: *u8 = try allocator.create(u8);
    defer allocator.destroy(pointer);

    var slice: []u8 = try allocator.alloc(u8, 3);
    defer allocator.free(slice);

    warn("Entered #{}. invocation of useFixedAllocator\n", num);
    warn("Address of the start of the buffer used for FixedBufferAllocator: {}\n", &buf[0]);
    warn("Contents of the buffer: {}\n", buf);
    warn("Pointer returned by allocator.create: {}\n", pointer);
    warn("Slice returned by allocator.alloc: {}\n", slice);
    pointer.* = 'B';
    std.mem.copy(u8, slice, "CCC");
    warn("Contents of the buffer after modifying contents of pointers and slices returned by the allocator: {}\n", buf);
}
