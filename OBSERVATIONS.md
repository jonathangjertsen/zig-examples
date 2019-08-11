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
* Getting C interop to work on Windows (fix: remove "kernel32.lib" which was somehow created in the root dir)

## Things I still haven't figured out

* How to iterate over imported modules (wanted to iterate over them in `all.zig` and call their `main()` functions, got something about type having to be comptime).
* In threads.zig, when calculating the next thread ID, it would be convenient with a static variable (either associated with the struct or from inside the init() function, like static in C). Can that be done?
* Can I create a struct within a function? It fails when it tries to refer to its own type ("undeclared identifier").
* Can I iterate over an enum?
* Why does FixedBufferAllocator run out of memory when I expect it not to?
* Can you have closures?
