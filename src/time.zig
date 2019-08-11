const std = @import("std");
const warn = std.debug.warn;

pub fn main() !void {
    timestampExample();
    blockingSleepExample();
    try simpleTimerExample();
    try timerLapsExample();
}

pub fn timestampExample() void {
    const timestamp_s: u64 = std.time.timestamp();
    const timestamp_ms: u64 = std.time.milliTimestamp();

    warn("\nExample of using timestamps.\n");
    warn("Current POSIX timestamp in seconds:      {}\n", timestamp_s);
    warn("Current POSIX timestamp in milliseconds: {}\n", timestamp_ms);
}

pub fn blockingSleepExample() void {
    const nanos: u64 = 1e6;

    warn("\nExample of blocking sleep.\n");
    warn("Sleeping for {} ns\n", nanos);
    std.time.sleep(nanos);
}

pub fn simpleTimerExample() !void {
    var timer: std.time.Timer = try std.time.Timer.start();
    const time_from_start_to_read_ns: u64 = timer.read();

    warn("\nExample of using a timer.\n");
    warn("Nanoseconds between timer.start() and timer.read(): {}\n", time_from_start_to_read_ns);
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

    warn("\nExample of using timer.lap() between 1 ms sleeps.\n");
    warn("Lap times (microseconds):");
    for (lap_times_ns) |lap_time_ns| {
        warn(" {}", @divTrunc(lap_time_ns, 1000));
    }
    warn("\n");
}
