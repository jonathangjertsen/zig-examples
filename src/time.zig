const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    timestampExample();
    blockingSleepExample();
    try simpleTimerExample();
    try timerLapsExample();
}

pub fn timestampExample() void {
    const timestamp_s: i64 = std.time.timestamp();
    const timestamp_ms: i64 = std.time.milliTimestamp();

    print("\nExample of using timestamps.\n", .{});
    print("Current POSIX timestamp in seconds:      {}\n", .{ timestamp_s });
    print("Current POSIX timestamp in milliseconds: {}\n", .{ timestamp_ms });
}

pub fn blockingSleepExample() void {
    const nanos: u64 = 1e6;

    print("\nExample of blocking sleep.\n", .{});
    print("Sleeping for {} ns\n", .{ nanos });
    std.time.sleep(nanos);
}

pub fn simpleTimerExample() !void {
    var timer: std.time.Timer = try std.time.Timer.start();
    const time_from_start_to_read_ns: u64 = timer.read();

    print("\nExample of using a timer.\n", .{});
    print("Nanoseconds between timer.start() and timer.read(): {}\n", .{ time_from_start_to_read_ns });
}

pub fn timerLapsExample() !void {
    var timer: std.time.Timer = try std.time.Timer.start();
    var lap_times_ns: [10]u64 = [_]u64{0} ** 10;

    var i: usize = 0;
    while (i < 10) : ({
        i += 1;
    }) {
        std.time.sleep(1e6);
        lap_times_ns[i] = timer.lap();
    }

    print("\nExample of using timer.lap() between 1 ms sleeps.\n", .{});
    print("Lap times (microseconds):", .{});
    for (lap_times_ns) |lap_time_ns| {
        print(" {}", .{ @divTrunc(lap_time_ns, 1000) });
    }
    print("\n", .{});
}
