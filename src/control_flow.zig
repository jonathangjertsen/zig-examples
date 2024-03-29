const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    simpleWhileExample();
    continueExpressionExample();
}

pub fn simpleWhileExample() void {
    print("\nExample of a simple while loop to calculate the first 10 Fibonacci numbers.\n", .{});
    var f_nminus2: u32 = 0;
    var f_nminus1: u32 = 1;
    var f_n: u32 = 1;

    var i: usize = 0;
    while (i < 10) {
        print("{} ", .{ f_n });
        f_n = f_nminus1 + f_nminus2;
        f_nminus2 = f_nminus1;
        f_nminus1 = f_n;
        i += 1;
    }
    print("\n", .{});
}

pub fn continueExpressionExample() void {
    print("\nSame example, with loop counter in a continue expression\n", .{});
    var f_nminus2: u32 = 0;
    var f_nminus1: u32 = 1;
    var f_n: u32 = 1;

    var i: usize = 0;
    while (i < 10) : ({
        i += 1;
    }) {
        print("{} ", .{ f_n });
        f_n = f_nminus1 + f_nminus2;
        f_nminus2 = f_nminus1;
        f_nminus1 = f_n;
    }
    print("\n", .{});
}
