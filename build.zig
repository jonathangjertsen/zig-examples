// Example of building.
const Builder = @import("std").build.Builder;

pub fn buildSingle(builder: *Builder, exec_name: []const u8, src_path: []const u8, run_step_name: []const u8, run_step_doc: []const u8) void {
    // Release options
    const mode = builder.standardReleaseOptions();

    // Create the executable
    const exe = builder.addExecutable(exec_name, src_path);

    // Set build mode to release options
    exe.setBuildMode(mode);

    // TODO: not sure what this step does.
    exe.install();

    // Create a command to run the executable
    const run_cmd = exe.run();

    // Make the run command depend on the generic install step?
    run_cmd.step.dependOn(builder.getInstallStep());

    // Create a step to run?
    const run_step = builder.step(run_step_name, run_step_doc);

    // Make the run step depend on the run command?
    run_step.dependOn(&run_cmd.step);
}

pub fn build(builder: *Builder) void {
    buildSingle(builder, "hello", "src/hello.zig", "run-hello", "Run the hello app");
    buildSingle(builder, "integers", "src/integers.zig", "run-integers", "Run the integers app");
}
