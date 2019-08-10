const std = @import("std");
const warn = std.debug.warn;

pub fn main() void {
    simpleWhileExample();
    complexWhileExample();
    labeledWhileExample();
}

pub fn simpleWhileExample() void {
    warn("\nExample of a simple while loop\n");
    var i: usize = 0;
    while (i < 2) {
        warn("i: {} in loop body\n", i);
        i += 1;
        break;
    }
    warn("i: {} outside of loop\n", i);
}

pub fn complexWhileExample() void {
    warn("\nExample of using a while loop with lots of bells and whistles.\n");
    var i: usize = 0;
    const loop_result: bool = while (i < 100) : ({
        i += 1;
        warn("i: {} in continue expression\n", i);
    }) {
        i += 1;

        if (i % 3 == 0) {
            warn("i: {} before continue in loop body\n", i);
            continue;
        }

        if (i > 10) {
            warn("i: {} before break\n", i);
            break true;
        }

        warn("i: {}, loop iteration completed\n", i);
    } else false;
    warn("Loop result: {}\n", loop_result);
}

pub fn labeledWhileExample() void {
    warn("\nExample of using labelled while loops to break out from nested loops\n");
    var i: usize = 0;
    outer: while (true) {
        warn("Entered outer loop\n");
        inner: while (true) {
            warn("Entered inner loop\n");
            warn("Breaking out of outer loop\n");
            break :outer;
        }
    }
}
