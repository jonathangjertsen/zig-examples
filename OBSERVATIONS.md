## Building and running

Based on the build script I have now, it all works very well

```
c:\dt\zig\hello>zig build run-hello
Hello, world!

c:\dt\zig\hello>zig build run-integers
Integer: 1

c:\dt\zig\hello>zig test src/test.zig
1/2 test "is_test"...OK
2/2 test "dumb_pass"...OK
All tests passed.
```

Questions:

* How are the dependencies resolved?
* When I do a run command, how much is built? Only what's needed?
* Can I get the tests to run in the same way as the other programs?

## Things to try out

* Assigning a const unsigned value to -1 gives a build-time error `error: cannot cast negative value -8 to unsigned integer type 'u32'`
* Creating a const unsigned value and subtracting a larger unsigned value gives a build-time error: `error: operation caused overflow: const unsigned_int: u32 = 1 - big_int;` 
* Creating a var unsigned value and subtracting a larger unsigned value gives a run-time error.

## Things that were hard to figure out

* How to do string interpolation!
