// Example of building.
const std = @import("std");
const Builder = std.build.Builder;
const fmt = std.fmt;

pub fn buildSimple(builder: *Builder, name: []const u8) void {
    var buffer: [100]u8 = undefined;

    // Release options
    const mode = builder.standardReleaseOptions();

    // Create the executable
    const exe = builder.addExecutable(name, builder.fmt("src/{}.zig", name));

    // Set build mode to release options
    exe.setBuildMode(mode);

    // TODO: not sure what this step does.
    exe.install();

    // Create a command to run the executable
    const run_cmd = exe.run();

    // Make the run command depend on the generic install step?
    run_cmd.step.dependOn(builder.getInstallStep());

    // Create a step to run?
    const run_step = builder.step(builder.fmt("run-{}", name), builder.fmt("Run the {} example", name));

    // Make the run step depend on the run command?
    run_step.dependOn(&run_cmd.step);
}

pub fn build(builder: *Builder) void {
    buildSimple(builder, "hello");
    buildSimple(builder, "integers");
    buildSimple(builder, "booleans");
    buildSimple(builder, "floats");
    buildSimple(builder, "structs");
    buildSimple(builder, "optionals");
    buildSimple(builder, "strings");
}
