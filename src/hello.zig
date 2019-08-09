// Mandatory hello-world app. Prints "Hello, world!" to stderr.
const warn = @import("std").debug.warn;

// Void means that the function cannot fail.
pub fn main() void {
    // warn() writes to stderr.
    warn("Hello, world!\n");
}
