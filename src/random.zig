const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    randomNumberExample();
    randomBytesExample();
    shuffleExample();
}

pub fn getFastRng() std.rand.Random {
    var engine = std.rand.DefaultPrng.init(0x42);
    return engine.random();
}

pub fn getCryptographicallySecureRng() std.rand.Random {
    const seed_secure: [32]u8 = .{
         0, 1, 2, 3, 4, 5, 6, 7,
         8, 9,10,11,12,13,14,15,
        16,17,18,19,20,21,22,23,
        24,25,26,27,28,29,30,31,
    };
    var engine = std.rand.DefaultCsprng.init(seed_secure);
    return engine.random();
}

pub fn randomNumberExample() void {
    var fast_rng = getFastRng();
    var cryptographically_secure_rng = getCryptographicallySecureRng();

    // *Biased functions have a deterministic runtime bound (they are constant-time), but the result may be biased
    // Otherwise they are unbiased, but the runtime is exponentially distributed (pseudo-rng) or unbounded (true fast_rng)
    const random_boolean: bool = fast_rng.boolean();
    const random_boolean_cryptographically_secure: bool = cryptographically_secure_rng.boolean();
    const random_uint: u64 = fast_rng.int(u64);
    const random_sint: i64 = fast_rng.int(i64);
    const random_biased_uint_less_than: u64 = fast_rng.uintLessThanBiased(u64, 100);
    const random_unbiased_uint_less_than: u64 = fast_rng.uintLessThan(u64, 100);
    const random_biased_uint_at_most: u64 = fast_rng.uintAtMostBiased(u64, 100);
    const random_unbiased_uint_at_most: u64 = fast_rng.uintAtMost(u64, 100);
    const random_biased_int_in_range_less_than: i64 = fast_rng.intRangeLessThanBiased(i64, -100, 100);
    const random_unbiased_int_in_range_less_than: i64 = fast_rng.intRangeLessThan(i64, -100, 100);
    const random_biased_int_in_range_at_most: i64 = fast_rng.intRangeAtMostBiased(i64, -100, 100);
    const random_unbiased_int_in_range_at_most: i64 = fast_rng.intRangeAtMost(i64, -100, 100);
    const random_float_uniform: f32 = fast_rng.float(f32);
    const random_float_normal: f32 = fast_rng.floatNorm(f32);
    const random_float_exp: f32 = fast_rng.floatExp(f32);

    print("\nExample of using random number generation.\n", .{});
    print("Random boolean: {any}\n", .{ random_boolean });
    print("Random boolean from cryptographically secure PRNG: {any}\n", .{ random_boolean_cryptographically_secure });
    print("Random unsigned integer: {any}\n", .{ random_uint });
    print("Random signed integer: {any}\n", .{ random_sint });
    print("Random unsigned integer, biased: 0 <= {any} < 100\n", .{ random_biased_uint_less_than });
    print("Random unsigned integer, unbiased: 0 <= {any} < 100\n", .{ random_unbiased_uint_less_than });
    print("Random unsigned integer, biased: 0 <= {any} <= 100\n", .{ random_biased_uint_at_most });
    print("Random unsigned integer, unbiased: 0 <= {any} <= 100\n", .{ random_unbiased_uint_at_most });
    print("Random signed integer, biased: -100 <= {any} < 100\n", .{ random_biased_int_in_range_less_than });
    print("Random signed integer, unbiased: -100 <= {any} < 100\n", .{ random_unbiased_int_in_range_less_than });
    print("Random signed integer, biased: -100 <= {any} <= 100\n", .{ random_biased_int_in_range_at_most });
    print("Random signed integer, unbiased: -100 <= {any} <= 100\n", .{ random_unbiased_int_in_range_at_most });
    print("Random float with uniform distribution: 0 <= {d:.4} < 1\n", .{ random_float_uniform });
    print("Random float with normal distribution (mu=0, sigma=1): {d:.4}\n", .{ random_float_normal });
    print("Random float with exponential distribution (lambda=1): {d:.4}\n", .{ random_float_exp });
}

pub fn randomBytesExample() void {
    var fast_rng = getFastRng();
    var cryptographically_secure_rng = getCryptographicallySecureRng();

    var insecure_token: [16]u8 = undefined;
    var secure_token: [16]u8 = undefined;

    fast_rng.bytes(insecure_token[0..]);
    cryptographically_secure_rng.bytes(secure_token[0..]);

    const insecure_u128: u128 = @bitCast(insecure_token);
    const secure_u128: u128 = @bitCast(secure_token);

    print("\nExample of filling a buffer with random bytes.\n", .{});
    print("128-bit token from fast RNG:                     0x{x}\n", .{ insecure_u128 });
    print("128-bit token from cryptographically secure RNG: 0x{x}\n", .{ secure_u128 });
}

pub fn shuffleExample() void {
    var fast_rng = getFastRng();
    var buffer = [_]u8{ 'A', 'B', 'C', 'D', 'E' };

    print("\nExample of shuffling a buffer.\n", .{});
    print("Before shuffle: {any}\n", .{ buffer });
    fast_rng.shuffle(u8, buffer[0..]);
    print("After shuffle:  {any}\n", .{ buffer });
}
