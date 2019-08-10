// Example of building.
const std = @import("std");
const builtin = @import("builtin");
const fmt = std.fmt;

pub fn buildSimple(builder: *std.build.Builder, name: []const u8) void {
    // Release options
    const mode: builtin.Mode = builder.standardReleaseOptions();

    // Create the executable
    const exe: *std.build.LibExeObjStep = builder.addExecutable(name, builder.fmt("src/{}.zig", name));

    // Set build mode to release options
    exe.setBuildMode(mode);

    // TODO: not sure what this step does.
    exe.install();

    // Create a command to run the executable
    const run_cmd: *std.build.RunStep = exe.run();

    // Make the run command depend on the generic install step?
    const builder_install_step: *std.build.Step = builder.getInstallStep();
    run_cmd.step.dependOn(builder_install_step);

    // Create a step to run?
    const run_step: *std.build.Step = builder.step(builder.fmt("run-{}", name), builder.fmt("Run the {} example", name));

    // Make the run step depend on the run command?
    run_step.dependOn(&run_cmd.step);
}

pub fn build(builder: *std.build.Builder) void {
    buildSimple(builder, "all");
    buildSimple(builder, "hello");
    buildSimple(builder, "integers");
    buildSimple(builder, "booleans");
    buildSimple(builder, "floats");
    buildSimple(builder, "structs");
    buildSimple(builder, "optionals");
    buildSimple(builder, "strings");
    buildSimple(builder, "threads");
    buildSimple(builder, "vectors");
}
