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
