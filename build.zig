// Example of building.
const std = @import("std");
const builtin = @import("builtin");
const fmt = std.fmt;

pub fn buildSimple(
    builder: *std.Build,
    target: std.zig.CrossTarget,
    optimize: std.builtin.Mode,
    name: []const u8,
) void {
    // Create the executable
    const exe = builder.addExecutable(.{
        .name = name,
        .root_source_file = .{ .path = builder.fmt("src/{s}.zig", .{ name }) },
        .target = target,
        .optimize = optimize,
    });

    // Link with C
    exe.linkSystemLibrary("c");

    // TODO: not sure what this step does.
    builder.installArtifact(exe);

    // Create a command to run the executable
    const run_cmd = builder.addRunArtifact(exe);

    // Make the run command depend on the generic install step?
    const builder_install_step = builder.getInstallStep();
    run_cmd.step.dependOn(builder_install_step);

    // Create a step to run?
    const run_step = builder.step(builder.fmt("run-{s}", .{name}), builder.fmt("Run the {s} example", .{name}));

    // Make the run step depend on the run command?
    run_step.dependOn(&run_cmd.step);
}

pub fn build(builder: *std.Build) void {
    const target = builder.standardTargetOptions(.{});
    const optimize = builder.standardOptimizeOption(.{});

    // doesn't build: buildSimple(builder, target, optimize, "all");
    // doesn't build: buildSimple(builder, target, optimize, "allocators");
    buildSimple(builder, target, optimize, "booleans");
    buildSimple(builder, target, optimize, "c_interop");
    buildSimple(builder, target, optimize, "control_flow");
    buildSimple(builder, target, optimize, "embed");
    buildSimple(builder, target, optimize, "enums");
    buildSimple(builder, target, optimize, "floats");
    buildSimple(builder, target, optimize, "hello");
    buildSimple(builder, target, optimize, "integers");
    buildSimple(builder, target, optimize, "optionals");
    // segfaults: buildSimple(builder, target, optimize, "random");
    buildSimple(builder, target, optimize, "strings");
    buildSimple(builder, target, optimize, "structs");
    buildSimple(builder, target, optimize, "time");
    // doesn't build: buildSimple(builder, target, optimize, "threads");
    buildSimple(builder, target, optimize, "vectors");
    // doesn't build: buildSimple(builder, target, optimize, "game");
}
