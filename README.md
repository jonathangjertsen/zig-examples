# ⚠️ this repo is old ⚠️

zig started 7 years ago and this repo is now 4 years old, these examples probably don't build anymore

I'm currently working on porting these examples to zig 0.11

# Zig examples

These are some examples that I'm writing for myself while I'm learning Zig.

I hope it's useful for others stumbling across this very new shiny thing, but be aware that I'm as much a beginner as anyone here!

## Structure

* Example source is in the `/src` directory.
* There is also a build script in `build.zig`.
* Examples can be run with `zig build run-integers`, `zig build run-structs`, etc.
* There is also `zig build run-all` which runs all examples at once. `src/all.zig` also servers as an example of how to import local stuff
* All examples here are working. If I don't get something to work, it's in OBSERVATIONS.md.

## Code style

I try to mimic the code style of the [standard lib](https://github.com/ziglang/zig/tree/master/std), but focus on making things as clear as possible even when it makes things excessively verbose.

* `snake_case` for variables.
* `camelCase` for functions.
* `PascalCase` for structs.
* Use fully qualified names for standard library functions and structs so it's easy to see where they come from. The only exception is `warn`, which is used everywhere for output.
* Declare the type of every variable, argument etc, even if the compiler can figure it out by itself.
* In the examples, `main` should call a series of functions called `*Example()`.
* Make the variable names clear enough so that comments are almost never needed.
