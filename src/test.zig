// Examples of the test framework.
const assert = @import("std").debug.assert;
const builtin = @import("builtin");

/// A test that checks if it is running in a test environment
test "is_test" {
    assert(builtin.is_test);
}

/// A dumb test that asserts on something true
test "dumb_pass" {
    const x = true;
    assert(x);
}
