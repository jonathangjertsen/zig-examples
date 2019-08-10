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

## Things that were hard to figure out

* How to do string interpolation
    * Explained extremely well in https://www.youtube.com/watch?v=WLJ_7lpBhys, not so much in the official documentation
* How to format floats
    * Deduced from source code (std/fmt.zig)
* How to import another file
    * Tried stuff until it worked

## Things that were hard to figure out

* How to iterate over imported modules (wanted to iterate over them in `all.zig` and call their `main()` functions, got something about type having to be comptime).
* How to get C interop to work on my machine (something wrong with my setup? Enormous amounts of errors from `ldd`)
* How to compile C files on my machine (something wrong with my setup? Enormous amounts of errors from `ldd`)
* In threads.zig, when calculating the next thread ID, it would be convenient with a static variable (either associated with the struct or from inside the init() function, like static in C). Can that be done?
